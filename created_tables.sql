------- W tym pliku tworzymy niezbędne tabele -------

DROP TABLE IF EXISTS groups CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS units CASCADE;
drop table if exists inv_buffer;
drop table if exists inv_history cascade;
drop table if exists inv_details cascade;
drop table if exists losses_buffer cascade;
drop table if exists losses_history cascade;
drop table if exists losses_details cascade;
drop table if exists stores cascade;
drop table if exists orders cascade;
drop table if exists order_details cascade;
drop table if exists suppliers cascade;
drop table if exists supply_orders cascade;
drop table if exists supply_details cascade;


CREATE TABLE units
(
    id         bigserial primary key,
    name       varchar(40) not null,
    short_name varchar(15) not null
);

CREATE TABLE groups
(
    id         bigserial primary key,
    parent_id  int default null,
    group_name varchar(40) unique not null
);

CREATE TABLE products
(
    id            bigserial primary key,
    ean           bigint unique,
    group_id      bigint references GROUPS (id) on delete cascade,
    product_name  varchar(150)                    not null,
    price         decimal                         not null,
    unit          bigserial references UNITS (id) not null,
    product_count decimal                         not null,
    CHECK ( length(ean::text) = 10)
);

CREATE TABLE inv_buffer
(
    id           bigserial primary key,
    ean          bigint unique references PRODUCTS (ean),
    actual_count bigint not null,
    CHECK ( length(ean::text) = 10)
);

CREATE TABLE inv_history
(
    id        bigserial primary key,
    doc_date  date not null,
    money_sum decimal
);

CREATE TABLE inv_details
(
    id               bigserial primary key,
    inv_history_id   bigint references inv_history (id) on delete cascade,
    product_ean      bigint references products (ean),
    expected_amount  integer not null,
    actual_amount    integer not null default 0
);

CREATE TABLE losses_buffer
(
    id          bigserial primary key,
    product_ean bigint references products (ean) not null unique,
    lose_amount decimal                          not null,
    notes       text
);

CREATE TABLE losses_history
(
    id        bigserial primary key,
    doc_date  date not null,
    money_sum decimal
);

CREATE TABLE losses_details
(
    id             bigserial primary key,
    los_history_id bigint references losses_history (id) on delete cascade,
    product_ean    bigint references products (ean),
    losses_amount  decimal not null,
    money_amount   decimal not null,
    notes          text
);

CREATE TABLE stores
(
    store_id       bigint primary key not null,
    address        varchar(150)       not null,
    contact_number varchar(20)        not null
);

CREATE TABLE orders
(
    id            bigserial primary key not null,
    order_date    date                  not null,
    accepted_date date                           default null,
    realized_date date                           default null,
    status        varchar(20)           not null default 'new',
    store_id      bigint references STORES (store_id),
    check ( status in ('new', 'realized') )
);

CREATE TABLE order_details
(
    id           bigserial not null,
    order_id     bigint references orders (id) on delete cascade,
    ean          bigint references products (ean),
    wanted_count bigint    not null,
    actual_count bigint       default null,
    comment_txt  varchar(180) default null

);

CREATE TABLE suppliers
(
    id             bigserial primary key,
    name           varchar(50) not null,
    address        varchar(50) not null,
    contact_number varchar(25) not null
);

CREATE TABLE supply_orders
(
    id            bigserial primary key,
    supplier_id   bigint references suppliers (id),
    realized_date date                 default null,
    status        varchar(40) not null default 'in_completing',
    check ( status in ('in_completing', 'received_from_supplier') )
);

CREATE TABLE supply_details
(
    id           bigserial primary key,
    supply_id    bigint references supply_orders (id) on delete cascade,
    ean          bigint references products (ean),
    am_before_supply decimal default null,
    wanted_count decimal not null,
    am_after_supply decimal default null
);


