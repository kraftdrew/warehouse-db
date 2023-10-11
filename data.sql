------- In this file, we fill the tables with sample data -------

insert into units(name, short_name)
values ('kilogram', 'kg.'),
       ('units', 'unit.');

insert into stores(store_id, address, contact_number)
values (1, 'Calgary, 2832 95a ST NW', '+1 825 234 3421');

insert into GROUPS(parent_id, group_name)
values (null, 'Vegetables'),
       (null, 'Fruits'),
       (null, 'Milk products'),
       (1, 'Potatoes'),
       (2, 'Apples'),
       (2, 'Grapes'),
       (2, 'Berries');


insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539223, 7, 'Potatoes - Mini White 3 Oz', 60, 1, 30);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539224, 2, 'Melon', 3.29, 2, 20);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539225, 2, 'Melon - Cantaloupe', 6.51, 1, 11);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539226, 5, 'Crawfish', 26.06, 2, 28);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539227, 4, 'Pasta - Bauletti, Chicken White', 68.36, 2, 62);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539228, 4, 'Water Chestnut - Canned', 81.42, 2, 47);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539229, 2, 'Ananas', 3.19, 2, 63);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539230, 5, 'Fondant - Icing', 51.48, 2, 15);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539231, 3, 'Beans', 6.52, 2, 42);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539232, 2, 'Ginger - Fresh', 8.3, 2, 46);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539233, 5, 'Lamb - Racks, Frenched', 25.86, 1, 59);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539234, 5, 'Flour - All Purpose', 84.2, 2, 69);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539235, 5, 'Lettuce - Belgian Endive', 13.65, 1, 97);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539236, 1, 'Huck Towels White', 60.74, 2, 66);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539237, 6, 'Bay Leaf Fresh', 25.61, 2, 29);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539238, 3, 'Island Oasis - Wildberry', 5.64, 1, 97);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539239, 7, 'Kellogs All Bran Bars', 13.38, 1, 34);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539240, 4, 'Longos - Chicken Curried', 41.74, 1, 46);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539241, 5, 'Basil - Fresh', 58.97, 2, 80);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539242, 4, 'Sugar - Invert', 55.0, 1, 85);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539243, 3, 'Beef - Tenderlion, Center Cut', 54.58, 1, 100);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539244, 7, 'Lamb - Whole Head Off', 5.59, 1, 65);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539245, 2, 'Chicken - Breast, 5 - 7 Oz', 50.15, 2, 22);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539246, 6, 'Chicken - Wings, Tip Off', 95.13, 1, 47);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539247, 7, 'Truffle - Whole Black Peeled', 70.38, 1, 63);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539248, 4, 'Goulash Seasoning', 86.66, 2, 8);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539249, 6, 'Croissants Thaw And Serve', 82.23, 2, 80);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539250, 3, 'Marakuja', 5.89, 1, 42);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539251, 6, 'Rosemary - Primerba, Paste', 13.47, 2, 18);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539252, 6, 'Potatoes - Fingerling 4 Oz', 49.48, 1, 63);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539253, 6, 'Bread - Multigrain', 98.53, 2, 99);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539254, 5, 'Bay Leaf Ground', 75.35, 2, 32);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539255, 4, 'Tuna - Sushi Grade', 13.16, 1, 77);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539256, 7, 'Crush - Cream Soda', 85.06, 2, 29);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539257, 7, 'Pepperoni Slices', 83.68, 2, 40);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539258, 6, 'Quail - Jumbo Boneless', 67.76, 1, 61);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539259, 5, 'Madeira', 14.69, 2, 33);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539260, 2, 'Papryka zółta', 2.97, 1, 78);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539261, 6, 'Sour Puss Sour Apple', 11.6, 1, 72);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539262, 4, 'Bread - Olive', 73.69, 2, 15);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539263, 7, 'Beef - Bresaola', 48.62, 1, 67);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539264, 5, 'Rice - Wild', 14.9, 2, 54);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539265, 6, 'Spice - Peppercorn Melange', 58.0, 2, 46);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539266, 1, 'Cocoa Powder - Natural', 35.7, 2, 60);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539267, 4, 'Crush - Grape, 355 Ml', 34.85, 1, 73);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539268, 1, 'Potato', 0.99, 1, 28);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539269, 6, 'Kiwi', 3.45, 1, 95);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539270, 7, 'Cheese - Sheep Milk', 74.08, 2, 68);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539271, 2, 'Mango', 6.21, 2, 37);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539272, 5, 'Strawberry', 6.21, 2, 37);
insert into PRODUCTS (ean, group_id, product_name, price, unit, product_count)
values (1234539273, 5, 'Apples Lobo', 3.99, 2, 20);



insert into inv_buffer (ean, actual_count)
values (1234539223, 20);
insert into inv_buffer (ean, actual_count)
values (1234539224, 10);
insert into inv_buffer (ean, actual_count)
values (1234539225, 22);
insert into inv_buffer (ean, actual_count)
values (1234539226, 48);
insert into inv_buffer (ean, actual_count)
values (1234539227, 19);
insert into inv_buffer (ean, actual_count)
values (1234539228, 24);
insert into inv_buffer (ean, actual_count)
values (1234539229, 14);
insert into inv_buffer (ean, actual_count)
values (1234539230, 30);
insert into inv_buffer (ean, actual_count)
values (1234539231, 28);
insert into inv_buffer (ean, actual_count)
values (1234539232, 21);
insert into inv_buffer (ean, actual_count)
values (1234539233, 30);
insert into inv_buffer (ean, actual_count)
values (1234539234, 19);
insert into inv_buffer (ean, actual_count)
values (1234539235, 30);
insert into inv_buffer (ean, actual_count)
values (1234539236, 41);
insert into inv_buffer (ean, actual_count)
values (1234539237, 18);
insert into inv_buffer (ean, actual_count)
values (1234539238, 19);
insert into inv_buffer (ean, actual_count)
values (1234539239, 18);
insert into inv_buffer (ean, actual_count)
values (1234539240, 15);
insert into inv_buffer (ean, actual_count)
values (1234539241, 50);
insert into inv_buffer (ean, actual_count)
values (1234539242, 33);
insert into inv_buffer (ean, actual_count)
values (1234539243, 10);
insert into inv_buffer (ean, actual_count)
values (1234539244, 23);
insert into inv_buffer (ean, actual_count)
values (1234539245, 41);
insert into inv_buffer (ean, actual_count)
values (1234539246, 47);
insert into inv_buffer (ean, actual_count)
values (1234539247, 47);
insert into inv_buffer (ean, actual_count)
values (1234539248, 47);
insert into inv_buffer (ean, actual_count)
values (1234539249, 11);
insert into inv_buffer (ean, actual_count)
values (1234539250, 25);
insert into inv_buffer (ean, actual_count)
values (1234539251, 46);
insert into inv_buffer (ean, actual_count)
values (1234539252, 35);
insert into inv_buffer (ean, actual_count)
values (1234539253, 30);
insert into inv_buffer (ean, actual_count)
values (1234539254, 26);
insert into inv_buffer (ean, actual_count)
values (1234539255, 12);
insert into inv_buffer (ean, actual_count)
values (1234539256, 19);
insert into inv_buffer (ean, actual_count)
values (1234539257, 9);
insert into inv_buffer (ean, actual_count)
values (1234539258, 30);
insert into inv_buffer (ean, actual_count)
values (1234539259, 42);
insert into inv_buffer (ean, actual_count)
values (1234539260, 9);
insert into inv_buffer (ean, actual_count)
values (1234539261, 42);
insert into inv_buffer (ean, actual_count)
values (1234539262, 40);
insert into inv_buffer (ean, actual_count)
values (1234539263, 35);
insert into inv_buffer (ean, actual_count)
values (1234539264, 20);
insert into inv_buffer (ean, actual_count)
values (1234539265, 38);
insert into inv_buffer (ean, actual_count)
values (1234539266, 44);
insert into inv_buffer (ean, actual_count)
values (1234539267, 41);
insert into inv_buffer (ean, actual_count)
values (1234539268, 29);
insert into inv_buffer (ean, actual_count)
values (1234539269, 50);
insert into inv_buffer (ean, actual_count)
values (1234539270, 25);
insert into inv_buffer (ean, actual_count)
values (1234539271, 8);
insert into inv_buffer (ean, actual_count)
values (1234539272, 12);

insert into ORDERS(order_date, accepted_date, realized_date, status, store_id)
values ('2022-12-20', null, null, 'new', 1);


INSERT INTO order_details(order_id, ean, wanted_count)
VALUES (1, 1234539224, 34),
       (1, 1234539225, 10),
       (1, 1234539229, 20),
       (1, 1234539232, 100),
       (1, 1234539271, 19);

insert into losses_buffer(product_ean, lose_amount, notes)
VALUES (1234539223, 10, null),
       (1234539224, 10, 'out of date');


insert into suppliers(name, address, contact_number)
values ('Supplier Inc.', 'Calgary, 2832 95a ST NW', '+1 825 234 1353');

insert into supply_orders(supplier_id, realized_date) VALUES (1,current_date);

insert into supply_details(supply_id, ean, wanted_count)
values (1, 1234539223, 10),
       (1, 1234539224, 40),
       (1, 1234539231, 20),
       (1, 1234539229, 50),
       (1, 1234539232, 50),
       (1, 1234539271, 100),
       (1, 1234539268, 20);





