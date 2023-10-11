drop function if exists GetSupplyDetails(integer);
drop function if exists CompleteSupplierOrder(integer);
drop function if exists AddToSupplierOrder(bigint, decimal);


-- The function CompleteSupplierOrder(supl_id int) executes the delivery from the supplier, replenishing inventory levels with the ordered goods.
create or replace function CompleteSupplierOrder(supl_id int)
    returns
        table
        (
            supplyID         bigint,
            status           varchar(20),
            supplier_name    varchar(50),
            address          varchar(50),
            realized_date    date,
            ean              bigint,
            product_name     varchar(150),
            am_before_supply decimal,
            wanted_count     decimal,
            am_after_supply  decimal,
            short_name       varchar(15)
        )
as
$$
declare
    temprow      record;
    check_status varchar;
begin
    -- check if the order has not already been completed.
    select supply_orders.status into check_status from supply_orders where id = supl_id limit 1;
    if check_status = 'received_from_supplier' then
        raise exception 'Order with id % has already completed',supl_id;
    end if;

    for temprow in select sd.id,
                          sd.ean,
                          sd.wanted_count,
                          p.product_count
                   from supply_details sd
                            join products p on sd.ean = p.ean
                   where sd.supply_id = supl_id
        loop

            -- enter the quantity of the product before accepting the goods;
            update supply_details
            set am_before_supply = temprow.product_count,
                am_after_supply  = temprow.product_count + temprow.wanted_count
            where supply_details.supply_id = supl_id
              and supply_details.ean = temprow.ean;

            -- execute the delivery process: replenish inventory levels
            update products
            set product_count = product_count + temprow.wanted_count
            where products.
                      ean = temprow.ean;


        end loop;
    -- update the delivery status to completed
    update supply_orders
    set status        = 'received_from_supplier',
        realized_date = current_date
    where id = supl_id;

    -- display document data
    return query
        select * from getsupplydetails(supl_id);
end;
$$ language plpgsql;

-- GetSupplyDetails(supply_id int) displays data about the delivery document with id = supply_id. If supply_id = -1, the last document is displayed.
create or replace function GetSupplyDetails(supply_id int)
    returns table
            (
                supplyID         bigint,
                status           varchar(20),
                supplier_name    varchar(50),
                address          varchar(50),
                realized_date    date,
                ean              bigint,
                product_name     varchar(150),
                am_before_supply decimal,
                wanted_count     decimal,
                am_after_supply  decimal,
                short_name       varchar(15)
            )
as
$$
declare
    actual_supply_id integer;
BEGIN

    if exists(select * from supply_orders) = false then
        raise exception 'table supply_orders is empty';
    end if;

    if supply_id = -1 then
        select ih.id into actual_supply_id from supply_orders ih order by ih.id desc limit 1;
    else
        actual_supply_id = supply_id;
    end if;

    return query select so.id,
                        so.status,
                        s.name,
                        s.address,
                        so.realized_date,
                        sd.ean,
                        p.product_name,
                        sd.am_before_supply,
                        sd.wanted_count,
                        sd.am_after_supply,
                        u.short_name
                 from supply_orders so
                          join supply_details sd on so.id = sd.supply_id
                          join products p on sd.ean = p.ean
                          join units u on u.id = p.unit
                          join suppliers s on s.id = so.supplier_id
                 where so.id = actual_supply_id;

end;
$$ language plpgsql;

-- AddToSupplierOrder(ean_code bigint, wanted_amount decimal) saves the selected goods of the selected quantity to the next order list for suppliers.
create or replace function AddToSupplierOrder(ean_code bigint, wanted_amount decimal) returns void as
$$
declare
    supply_order_id integer;
BEGIN
    ----------------------
    -- due to the lack of the requested quantity, we place an order for suppliers

    -- if there is no active shopping list for the supplier in the supply_orders table then
    -- we create one
    if EXISTS(SELECT * FROM supply_orders where status = 'in_completing') = false then
        insert into supply_orders(supplier_id, realized_date)
        values (1, current_date);
    end if;

    -- retrieve the list id to which we will be entering the order
    select id as last_id
    into supply_order_id
    from supply_orders
    where status = 'in_completing'
    order by supply_orders.realized_date desc
    limit 1;

    -- place an order for the selected goods in the quantity of 50
    insert into supply_details(supply_id, ean, wanted_count)
    values (supply_order_id, ean_code, wanted_amount);

    ----------------------
END;
$$ language plpgsql;


------- Simulation of the process of ordering goods from a supplier -------

-- 1. run created_tables.sql and data.sql;
-- 2. execute the code above;
-- 3. check if we have any lists for suppliers and what is the document id
select *
from supply_orders
where status = 'in_completing';

--4. Check the initial quantity before accepting goods
select p.ean, p.product_name, p.product_count as actual_amount, sd.wanted_count, u.short_name
from products p
         join supply_details sd on p.ean = sd.ean
         join units u on u.id = p.unit
where supply_id = 1;

--5. Execute the ordering and acceptance of goods process;
select *
from CompleteSupplierOrder(1);

--6. Display the data of the last document
select *
from GetSupplyDetails(-1);











