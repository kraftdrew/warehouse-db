drop function if exists Whiteoff();
drop function if exists ShowWhiteoff(ord_id integer);

-- Whiteoff() executes the procedure of writing off goods as losses, creating the appropriate document in losses_history.
-- Data on the amount of losses can be found in the losses_buffer table.
create or replace function Whiteoff()
    returns
        table
        (
            document_id   bigint,
            suma_strat    decimal,
            doc_date      date,
            product_ean   bigint,
            product_name  varchar(150),
            losses_amount decimal,
            short_name    varchar(15),
            money_diff    decimal,
            notes         text
        )
as
$$
declare
    temprow        record;
    new_history_id integer;
BEGIN

    -- raise exception if the losses_buffer table is empty
    if EXISTS(SELECT * FROM losses_buffer) = false then
        raise exception 'Error: table losses_buffer is empty';
    end if;
    -- set the next id for our loss document
    select id + 1::int as last_id into new_history_id from losses_history order by id desc limit 1;
    if EXISTS(SELECT * FROM losses_history) = false then
        new_history_id = 1;
    elsif new_history_id is null or pg_typeof(new_history_id) != 'integer'::regtype then
        raise exception 'Error: id is null';
    end if;
    -- create a new loss document
    insert into losses_history(id, doc_date, money_sum) values (new_history_id, current_date, null);

    for temprow in select lb.product_ean,
                          lb.lose_amount,
                          p.price,
                          p.product_count,
                          lb.lose_amount * (-1) * p.price as losses_in_money,
                          lb.notes
                   from losses_buffer lb
                            join products p on p.ean = lb.product_ean
        loop
            -- update the product quantity in the warehouse after writing off
            update products
            set product_count = product_count - temprow.lose_amount
            where ean = temprow.product_ean;
            insert into losses_details(los_history_id, product_ean, losses_amount, money_amount, notes)
            values (new_history_id, temprow.product_ean, temprow.lose_amount, temprow.losses_in_money, temprow.notes);

            -- due to the lack of the requested quantity, we place an order for suppliers
            if  temprow.product_count - temprow.lose_amount < 10 then
                  perform AddToSupplierOrder(temprow.product_ean,50);
            end if;

        end loop;

    -- supplement the loss document with the total sum of losses
    update losses_history
    set money_sum = subquery.sum
    from (select sum(money_amount) as sum from losses_details where los_history_id = new_history_id) as subquery
    where losses_history.id = new_history_id;

        -- display in the console that the document has been created
    raise notice 'losses document with id: % in losses_history
        has been created based on data from losses_buffer',new_history_id;

    -- as a result, we display data about the completed document
    return query
         select * from ShowWhiteoff(new_history_id);

END;
$$ language plpgsql;

-- ShowWhiteoff(losses_id integer) displays data about the loss document with id = losses_id. If losses_id = -1, the last document is displayed.
create or replace function ShowWhiteoff(losses_id integer)

    returns
        table
        (
            document_id   bigint,
            suma_strat    decimal,
            doc_date      date,
            product_ean   bigint,
            product_name  varchar(150),
            losses_amount decimal,
            short_name    varchar(15),
            money_diff    decimal,
            notes         text
        )
as
$$
declare
    actual_order_id integer;
BEGIN

    if exists(select * from losses_history) = false then
        raise exception 'table losses_history is empty';
    end if;

    -- If losses_id=-1, the last loss document is displayed    if losses_id = -1 then
        select lh.id into actual_order_id from losses_history lh order by lh.id desc limit 1;
    else
        actual_order_id = losses_id;
    end if;

    return query
        select lh.id,
               lh.money_sum,
               lh.doc_date,
               ld.product_ean,
               p.product_name,
               ld.losses_amount,
               u.short_name,
               ld.money_amount as ma,
               ld.notes
        from losses_history lh
                 join losses_details ld on lh.id = ld.los_history_id
                 join products p on ld.product_ean = p.ean
                 join units u on u.id = p.unit
        where lh.id = actual_order_id;

end;
$$ language plpgsql;


------- Simulation of the loss process -------

-- 1. run created_tables.sql and data.sql;
-- 2. execute the code above;

--3. Let's carry out the process of writing off goods as losses;
select * from Whiteoff();

--4. Display the data of the last loss document
select * from ShowWhiteoff(-1);













