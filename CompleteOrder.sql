
------- Creating necessary functions -------
drop function if exists CompleteOrder(ord_id int);
drop function if exists ShowOrderDetails(ord_id integer);


-- CompleteOrder(ord_id:int) is used to complete an order with id=ord_id from the orders table.
create or replace function CompleteOrder(ord_id int)
    returns table
            (
                order_id      bigint,
                order_date    date,
                accepted_date date,
                realized_date date,
                o_status      varchar(20),
                store_id      bigint,
                address       varchar(150),
                odet_id       bigint,
                eat           bigint,
                product_name  varchar(150),
                wanted_count  bigint,
                actual_count  bigint,
                short_name    varchar(15),
                comment      varchar(180)

            )
as
$$
declare
    temprow         record;
    check_status    varchar;
    items_notice    record;
begin
    select status into check_status from orders where id = ord_id limit 1;
    if check_status = 'realized' then
        raise exception 'Order with id % has already completed',ord_id;
    end if;

    for temprow in select od.id,
                          od.order_id,
                          od.ean,
                          od.wanted_count,
                          od.actual_count,
                          p.product_count,
                          p.product_count::int - od.wanted_count::int as difference
                   from order_details od
                            join products p on od.ean = p.ean
                   where od.order_id = ord_id
        loop

            -- if we have the requested amount of goods in stock then
            if temprow.difference >= 0 then

                -- update the actual_count field to the requested quantity (wanted_count)
                update order_details
                set actual_count = order_details.wanted_count
                where id = temprow.id;

                -- update the inventory levels of the goods in the warehouse
                update products
                set product_count = temprow.difference
                where ean = temprow.ean;

            -- if we don't have the requested amount of goods in stock then
            elsif temprow.difference < 0 then
                -- add to the order as much goods as we have in stock
                update order_details
                set actual_count = temprow.product_count,
                    comment_txt  = 'No such item on store, gave: ' || temprow.product_count::text
                where id = temprow.id;

                -- change the inventory levels of the goods in the warehouse to 0
                update products
                set product_count = 0
                where ean = temprow.ean;

               -- due to the lack of the requested quantity, we place an order for suppliers
                 perform AddToSupplierOrder(temprow.ean,50);



            else
                raise exception 'Error in counting';

            end if;

        end loop;
    -- change the order status to completed
    update orders
    set status        = 'realized',
        accepted_date = current_date,
        realized_date = current_date
    where id = ord_id;

     -- display in the console that the order is completed and ready for delivery to the store
    for items_notice in select s.address
                        from orders o
                                 join stores s on o.store_id = s.store_id
                        where o.id = ord_id
        loop
            raise notice 'order with id:% is completed and ready to delivery to store with address % ' , ord_id,items_notice.address;
        end loop;

     -- as a result, we display data about the completed document
    return query select * from ShowOrderDetails(ord_id);
end;
$$ language plpgsql;

-- ShowOrderDetails(ord_id:int) displays data about the order with id=ord_id. If ord_id=-1, the last order is displayed.
create or replace function ShowOrderDetails(ord_id integer)

    returns
        table
        (
            order_id      bigint,
            order_date    date,
            accepted_date date,
            realized_date date,
            o_status      varchar(20),
            store_id      bigint,
            address       varchar(150),
            odet_id       bigint,
            eat           bigint,
            product_name  varchar(150),
            wanted_count  bigint,
            actual_count  bigint,
            short_name    varchar(15),
            commnent      varchar(180)

        )
as
$$
declare
    actual_order_id integer;
BEGIN

    if exists(select * from orders) = false then
        raise exception 'table orders is empty';
    end if;

    -- If ord_id=-1, the last order is displayed
    if ord_id = -1 then
        select o.id into actual_order_id from orders o order by o.id desc limit 1;
    else
        actual_order_id = ord_id;
    end if;

    return query select o.*,
                        s.address,
                        od.id,
                        od.ean,
                        p.product_name,
                        od.wanted_count,
                        od.actual_count,
                        u.short_name,
                        od.comment_txt
                 from orders o
                          join order_details od on o.id = od.order_id
                          join products p on p.ean = od.ean
                          join units u on u.id = p.unit
                          join stores s on o.store_id = s.store_id
                 where o.id = actual_order_id;
END;
$$ language plpgsql;


------- Simulation of placing an order -------

-- 1. run created_tables.sql and data.sql;
-- 2. execute the code above;

-- 3. Check the latest order. Status: new, order_id:1;
select * from ShowOrderDetails(-1);

--4. Complete the order with id 1;
select * from CompleteOrder(1);

--5. Let's make sure that the status, realization date, comments, etc. in the order with id 1 have changed;
select * from ShowOrderDetails(1);

--5. An attempt to re-complete the order with id:1 will result in an error
-- select * from CompleteOrder(1);



