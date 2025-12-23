------------------------------------------- Vehicle Rental System - Database Design & SQL Queries


------------------------- Create table -----------------------
-- create the custom type 
create type user_role_enum as enum('Admin','Customer');
create type booking_status_enum as enum('Pending','Confirmed','Completed','Cancelled');
create type vehicle_type_enum as enum('Car','Truck','Bike');
create type booking_status_enum as enum('Available','Rented','Maintenance')
-- rename enum type
alter type booking_status_enum rename value 'CANCELLED' to 'Cancelled'

 SELECT enum_range(NULL::booking_status_enum);

-- user table
create table users(
  user_id serial primary key,
  name varchar(150) not null,
  email varchar(150) unique not null,
  password varchar(255),
  phone int,
  user_role user_role_enum default 'Customer'
);



-- bookings
create table bookings(
  booking_id serial primary key,
  start_date date not null,
  end_date date not null,
  status booking_status_enum default 'Pending',
  total_cost int,
  user_id int references users(user_id),
  vehicle_id int references vehicles(vehicle_id)
);



-- vehicles 
create table vehicles(
  vehicle_id serial primary key,
  vehicle_name varchar(150),
  model varchar(150),
  type vehicle_type_enum,
  regisration_no varchar(100,
  price_per_day int,
  availity_status vehicle_availaty_status default 'Available'
)





------------------------------ Insert data --------------------------
-- user insert data 
insert into users (name,email,phone,user_role) values
('Alice','alice@example.com',1234567890, 'Customer'),
('Bob','bob@example.com',0987654321, 'Admin'),
('Charlie','charlie@example.com',1122334455, 'Customer')


-- vehicle insert data
insert into vehicles (vehicle_name,type,model,regisration_no,price_per_day,availity_status)
values ('Toyota Corolla','Car','2022','ABC-123',50,'Available'),
  ('Honda Civic','Car','2021','DEF-456',60,'Rented'),
  ('Yamaha R15','Bike','2023','GHI-789',30,'Available'),
  ('Ford F-150','Truck','2020','JKL-012',100,'Maintenance')

  
-- bookings insert data
insert into bookings (user_id,vehicle_id,start_date,end_date,status,total_cost)
values (1,2,'2023-10-01','2023-10-05','Completed',240),
  (1,2,'2023-11-01','2023-11-03','Completed',120),
  (3,2,'2023-12-01','2023-12-02','Confirmed',60),
  (1,1,'2023-12-10','2023-12-12','Pending',100)

INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, status, total_cost)
VALUES 
(1, 2, '2023-10-01', '2023-10-05', 'Completed', 240),
(1, 2, '2023-11-01', '2023-11-03', 'Completed', 120),
(3, 2, '2023-12-01', '2023-12-02', 'Confirmed', 60),
(1, 1, '2023-12-10', '2023-12-12', 'Pending', 100);



-------------------- Data Retrive ---------------
-- 1. Retrieve booking information along with Customer name and Vehicle name.
select booking_id,name as customer_name,vehicle_name,start_date,end_date,status from bookings inner join users on users.user_id = bookings.user_id 
inner join vehicles on vehicles.vehicle_id = bookings.vehicle_id

-- 2. Find all vehicles that have never been booked.
  select vehicle_id,vehicle_name as name,type,model,regisration_no as registration_number,price_per_day as rental_price ,availity_status as status from vehicles where not exists (
  select 1 from bookings where bookings.vehicle_id = vehicles.vehicle_id
  ) order by vehicles.vehicle_id
 

-- 3. Retrieve all available vehicles of a specific type (e.g. cars)
select * from vehicles where availity_status = 'Available' and type ='Car'


-- 4. Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
select vehicle_name,count(bookings.booking_id) as total_booking
  from bookings inner join vehicles on vehicles.vehicle_id = bookings.vehicle_id group by vehicle_name
having count(bookings.booking_id) > 2
