-- 
-- INITIAL DATA LOAD
-- 

INSERT INTO CUSTOMER(ID, NAME, FIRSTNAME, CONTACT, STATUS, STATUS_CHANGE) VALUES
    (100, 'Eric',   'Meyer',    'eme22@gmail.com',      'Active',         '2024-06-04 12:35:00'),
    (101, 'Sommer', 'Tina',     '+49 030 22458 29425',  'Active',         '2025-10-07 10:28:00'),
    (102, 'Schulze','Tim',      '+49 171 2358124',      'Active',         '2024-12-28 18:00:00'),
    (103, 'Brinkmann', 'Tobias','+49 030 662465724',    'InRegistration', '2025-11-28 12:18:00'),
    (104, 'Tony',   'Allister', '+49 030 24253134',     'Active',         '2023-02-10 18:00:00'),
    (105, 'Sandra', 'Ohlstadt', 'ohlst@gmail.com',      'Active',         '2023-08-17 18:00:00'),
    (106, 'Erica',  'Gronemann','gronemann@gmx.de',     'InRegistration', '2022-02-26 07:02:00'),
    (107, 'Khaleed','Samadi',   '-',                    'Active',         '2020-09-24 18:00:00'),
    (108, 'Igor',   'Medwedev', 'gopnik@bht-berlin.de', 'InRegistration', '2025-11-28 23:26:00')
;

INSERT INTO VEHICLE (ID, MAKE, MODEL, SEATS, CATEGORY, POWER, STATUS) VALUES
    (1001, 'VW', 'Golf', 4, 'Sedan', 'Gasoline', 'Active'),
    (1002, 'VW', 'Golf', 4, 'Sedan', 'Hybrid', 'Active'),
    (2000, 'BMW', '320d', 4, 'Sedan', 'Diesel', 'Active'),
    (3000, 'Mercedes', 'EQS', 4, 'Sedan', 'Electric', 'Active'),
    (1200, 'VW', 'Multivan Life', 8, 'Van', 'Gasoline', 'Active'),
    (6000, 'Tesla', 'Model 3', 4, 'Sedan', 'Electric', 'Active'),
    (6001, 'Tesla', 'Model S', 4, 'Sedan', 'Electric', 'Serviced')
;

INSERT INTO RESERVATION (ID, CUSTOMER_ID, VEHICLE_ID, TIME_BEGIN, TIME_END, PICKUP, DROPOFF, STATUS) VALUES
    (201235, 103, 1002, '2025-11-17 10:00:00', '2025-11-17 18:00:00', 'Berlin Wedding', 'Berlin Wedding', 'Booked'),
    (145373, 102, 6001, '2025-11-18 08:00:00', '2025-11-20 08:00:00', 'Berlin Wedding', 'Hamburg', 'Booked'),
    (382565, 102, 3000, '2025-11-16 09:00:00', '2025-11-17 09:00:00', 'Berlin Wedding', 'Hamburg', 'Inquired'),
    (351682, 102, 6000, '2025-11-14 10:00:00', '2025-11-17 16:30:00', 'Berlin Wedding', 'Hamburg', 'Cancelled'),
    (682351, 102, 6000, '2025-11-15 10:00:00', '2025-11-16 20:00:00', 'Potsdam', 'Teltow', 'Booked')
;
