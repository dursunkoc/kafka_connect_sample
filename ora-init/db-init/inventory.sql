-- Create and populate our products using a single insert with many rows

create table inventory.products (
    id NUMBER(4) NOT NULL PRIMARY KEY,
    name VARCHAR2(255)NOT NULL,
    description VARCHAR2(512),
    weight FLOAT
);

 create sequence inventory.t1_seq
  increment by 1
  start with 101;
  
 

GRANT SELECT ON inventory.products to c##logminer; 

ALTER TABLE inventory.products ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO inventory.products
  VALUES (inventory.t1_seq.nextval,'scooter','Small 2-wheel scooter',3.14);
INSERT INTO inventory.products
  VALUES (inventory.t1_seq.nextval,'car battery','12V car battery',8.1);
INSERT INTO inventory.products
  VALUES (inventory.t1_seq.nextval,'12-pack drill bits','12-pack of drill bits with sizes ranging from #40 to #3',0.8);
INSERT INTO inventory.products
  VALUES (inventory.t1_seq.nextval,'hammer','12oz carpenter''s hammer',0.75);
INSERT INTO inventory.products
  VALUES (inventory.t1_seq.nextval,'hammer','14oz carpenter''s hammer',0.875);
INSERT INTO inventory.products
  VALUES (inventory.t1_seq.nextval,'hammer','16oz carpenter''s hammer',1.0);
INSERT INTO inventory.products
  VALUES (inventory.t1_seq.nextval,'rocks','box of assorted rocks',5.3);
INSERT INTO inventory.products
  VALUES (inventory.t1_seq.nextval,'jacket','water resistent black wind breaker',0.1);
INSERT INTO inventory.products
  VALUES (inventory.t1_seq.nextval,'spare tire','24 inch spare tire',22.2);

-- Create and populate the products on hand using multiple inserts
CREATE TABLE inventory.products_on_hand (
  product_id NUMBER(4) NOT NULL PRIMARY KEY,
  quantity NUMBER(4) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES inventory.products(id)
);

GRANT SELECT ON inventory.products_on_hand to c##logminer;
ALTER TABLE inventory.products_on_hand ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO inventory.products_on_hand VALUES (101,3);
INSERT INTO inventory.products_on_hand VALUES (102,8);
INSERT INTO inventory.products_on_hand VALUES (103,18);
INSERT INTO inventory.products_on_hand VALUES (104,4);
INSERT INTO inventory.products_on_hand VALUES (105,5);
INSERT INTO inventory.products_on_hand VALUES (106,0);
INSERT INTO inventory.products_on_hand VALUES (107,44);
INSERT INTO inventory.products_on_hand VALUES (108,2);
INSERT INTO inventory.products_on_hand VALUES (109,5);

-- Create some inventory.customers ...
CREATE TABLE inventory.customers (
  id NUMBER(4)  NOT NULL PRIMARY KEY,
  first_name VARCHAR2(255) NOT NULL,
  last_name VARCHAR2(255) NOT NULL,
  email VARCHAR2(255) NOT NULL UNIQUE
);

 create sequence inventory.t2_seq
  increment by 1
  start with 1001;

GRANT SELECT ON inventory.customers to c##logminer;

ALTER TABLE inventory.customers ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO inventory.customers
  VALUES (inventory.t2_seq.nextval,'Sally','Thomas','sally.thomas@acme.com');
INSERT INTO inventory.customers
  VALUES (inventory.t2_seq.nextval,'George','Bailey','gbailey@foobar.com');
INSERT INTO inventory.customers
  VALUES (inventory.t2_seq.nextval,'Edward','Walker','ed@walker.com');
INSERT INTO inventory.customers
  VALUES (inventory.t2_seq.nextval,'Anne','Kretchmar','annek@noanswer.org');

-- Create some very simple inventory.orders
CREATE TABLE inventory.orders (
  id NUMBER(6) NOT NULL PRIMARY KEY,
  order_date DATE NOT NULL,
  purchase_date DATE NOT NULL,
  purchaser NUMBER(4) NOT NULL,
  quantity NUMBER(4) NOT NULL,
  product_id NUMBER(4) NOT NULL,
  FOREIGN KEY (purchaser) REFERENCES inventory.customers(id),
  FOREIGN KEY (product_id) REFERENCES inventory.products(id)
);
create sequence inventory.t3_seq
  increment by 1
  start with 10001;

GRANT SELECT ON inventory.orders to c##logminer;

ALTER TABLE inventory.orders ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO inventory.orders
  VALUES (inventory.t3_seq.nextval, '16-JAN-2016', '16-JAN-2016', 1001, 1, 102);
INSERT INTO inventory.orders
  VALUES (inventory.t3_seq.nextval, '17-JAN-2016', '17-JAN-2016', 1002, 2, 105);
INSERT INTO inventory.orders
  VALUES (inventory.t3_seq.nextval, '19-FEB-2016', '19-FEB-2016', 1002, 2, 106);
INSERT INTO inventory.orders
  VALUES (inventory.t3_seq.nextval, '21-FEB-2016', '21-FEB-2016', 1003, 1, 107);