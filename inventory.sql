drop function if exists CompleteInventory();
drop function if exists GetInventoryDetails(integer);

-- CompleteInventory() executes the inventory procedure for all goods, creating the appropriate document in inv_history.
-- Data on the quantity of goods after inventory can be found in the inv_buffer table.
create or replace function CompleteInventory()
    returns table
            (
                p_category          text,
                product_name        text,
                ean                 int,
                inv_expected_amount int,
                inv_actual_amount   int,
                unit                varchar(15),
                price               decimal,
                amount_on_storage   decimal
            )

as
$$
declare
    temprow        record;
    new_history_id integer;
    money_diff     decimal;
BEGIN

    money_diff = 0;
    -- set the next id for our inventory document
    select id + 1::int as last_id into new_history_id from inv_history order by id desc limit 1;
    raise notice '%' , new_history_id;
    if EXISTS(SELECT * FROM inv_history) = false then
        new_history_id = 1;
    elsif new_history_id is null or pg_typeof(new_history_id) != 'integer'::regtype then
        raise exception 'Error: id is null';
    end if;

    -- create a new inventory document
    insert into inv_history(id, doc_date, money_sum) values (new_history_id, current_date, null);
    for temprow in select p.ean                                         as ean,
                          p.product_count                               as expected_amount,
                          ib.actual_count                               as actual_amount,
                          (ib.actual_count - p.product_count) * p.price as money_difference
                   from products p
                            join inv_buffer ib on p.ean = ib.ean
        loop
            money_diff = money_diff + temprow.money_difference;
            insert into inv_details(inv_history_id, product_ean, expected_amount, actual_amount)
            values (new_history_id, temprow.ean, temprow.expected_amount, temprow.actual_amount);

            -- due to the lack of the requested quantity, we place an order for suppliers
            if temprow.actual_amount < 10 then
                perform AddToSupplierOrder(temprow.ean, 50);
            end if;

        end loop;

    -- update the product quantity in the warehouse after inventory
    update products p set product_count = invb.actual_count from inv_buffer invb where p.ean = invb.ean;

    -- supplement the inventory document with the difference amount
    update inv_history
    set money_sum = money_diff
    where inv_history.id = new_history_id;
    -- as a result, we display data about the completed document
    return query
        select * from GetInventoryDetails(new_history_id);
END;
$$ language plpgsql;


-- GetInventoryDetails(inv_id integer) displays data about the inventory document with id = inv_id. If inv_id = -1, the last document is displayed.
create or replace function GetInventoryDetails(inv_id int)
    returns table
            (
                p_category          text,
                product_name        text,
                ean                 int,
                inv_expected_amount int,
                inv_actual_amount   int,
                unit                varchar(15),
                price               decimal,
                amount_on_storage   decimal
            )
as
$$
declare
    actual_inv_id integer;
BEGIN

    if exists(select * from inv_history) = false then
        raise exception 'table inv_history is empty';
    end if;

    -- If inv_id=-1, the last inventory document is displayed
    if inv_id = -1 then
        select ih.id into actual_inv_id from inv_history ih order by ih.id desc limit 1;
    else
        actual_inv_id = inv_id;
    end if;

    return query with first as (select g.group_name,
                                       p.product_name,
                                       p.ean::int,
                                       invd.expected_amount,
                                       invd.actual_amount,
                                       u.short_name,
                                       p.price,
                                       p.product_count as amount_on_storage
                                from inv_details invd
                                         join products p on p.ean = invd.product_ean
                                         join units u on u.id = p.unit
                                         join groups g on g.id = p.group_id
                                where invd.inv_history_id = actual_inv_id)
                 select 'SUMMARY ROW:'::text as Category,
                        'doc id: ' || actual_inv_id ||
                        ', date: ' || invh.doc_date || ', money_difference: ' ||
                        invh.money_sum       as product_name,
                        null                 as ean,
                        null                 as inv_expected_amount,
                        null                 as inv_actual_amount,
                        null                 as unit,
                        null                 as price,
                        null                 as amount_on_storage
                 from first f
                          join inv_history invh on invh.id = actual_inv_id
                 group by invh.doc_date, invh.money_sum
                 union all
                 select *
                 from first;

end ;
$$ language plpgsql;


------- Simulation of conducting the inventory process -------

-- 1. run created_tables.sql and data.sql;
-- 2. execute the code above;

--3. Let's carry out the inventory process;
select *
from CompleteInventory();

--4. Display the data of the last document
select *
from GetInventoryDetails(-1);

