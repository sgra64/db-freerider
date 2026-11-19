-- Gemini-generated database data:
-- - "Give me 200 customer records."
-- - "Give me 160 product records."
-- - "Give me 250 orders with one to five order items of the customers and products you gave me before."

-- load complete data set as one transaction
START TRANSACTION;

-- Clear all tables for data-loadin existing schema.
-- Reset AUTO_INCREMENT: Unlike DELETE FROM ..., TRUNCATE TABLE resets AUTO_INCREMENT
-- Handle foreign keys cleanly: SET FOREIGN_KEY_CHECKS = 0 avoids ERROR 1701 (Cannot
-- truncate a table referenced in a foreign key constraint) when truncating parent
-- tables like customers or products.

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE ORDER_ITEMS;
TRUNCATE TABLE ORDERS;
TRUNCATE TABLE PRODUCTS;
TRUNCATE TABLE CUSTOMERS;

SET FOREIGN_KEY_CHECKS = 1;

-- Insert 200 Customers
INSERT INTO CUSTOMERS (first_name, last_name, email, phone, shipping_address, billing_address) VALUES
    ('James', 'Smith', 'james.smith1@example.com', '+1-202-555-0101', '101 Maple St, Springfield, IL 62701', '101 Maple St, Springfield, IL 62701'),
    ('Mary', 'Johnson', 'mary.johnson2@example.com', '+1-202-555-0102', '202 Oak Ave, Columbus, OH 43215', '202 Oak Ave, Columbus, OH 43215'),
    ('Robert', 'Williams', 'robert.williams3@example.com', '+1-202-555-0103', '303 Pine Rd, Austin, TX 78701', '303 Pine Rd, Austin, TX 78701'),
    ('Patricia', 'Brown', 'patricia.brown4@example.com', '+1-202-555-0104', '404 Cedar Ln, Denver, CO 80202', '404 Cedar Ln, Denver, CO 80202'),
    ('John', 'Jones', 'john.jones5@example.com', '+1-202-555-0105', '505 Elm Blvd, Seattle, WA 98101', '505 Elm Blvd, Seattle, WA 98101'),
    ('Jennifer', 'Garcia', 'jennifer.garcia6@example.com', '+1-202-555-0106', '606 Birch Way, Miami, FL 33101', '606 Birch Way, Miami, FL 33101'),
    ('Michael', 'Miller', 'michael.miller7@example.com', '+1-202-555-0107', '707 Walnut Dr, Boston, MA 02108', '707 Walnut Dr, Boston, MA 02108'),
    ('Linda', 'Davis', 'linda.davis8@example.com', '+1-202-555-0108', '808 Spruce Ct, Phoenix, AZ 85001', '808 Spruce Ct, Phoenix, AZ 85001'),
    ('David', 'Rodriguez', 'david.rodriguez9@example.com', '+1-202-555-0109', '909 Cherry Pl, Atlanta, GA 30301', '909 Cherry Pl, Atlanta, GA 30301'),
    ('Elizabeth', 'Martinez', 'elizabeth.martinez10@example.com', '+1-202-555-0110', '110 Ash St, Portland, OR 97201', '110 Ash St, Portland, OR 97201'),
    ('William', 'Hernandez', 'william.hernandez11@example.com', '+1-202-555-0111', '111 Willow Ave, Chicago, IL 60601', '111 Willow Ave, Chicago, IL 60601'),
    ('Barbara', 'Lopez', 'barbara.lopez12@example.com', '+1-202-555-0112', '112 Poplar Rd, Houston, TX 77001', '112 Poplar Rd, Houston, TX 77001'),
    ('Richard', 'Gonzalez', 'richard.gonzalez13@example.com', '+1-202-555-0113', '113 Sycamore Ln, San Diego, CA 92101', '113 Sycamore Ln, San Diego, CA 92101'),
    ('Susan', 'Wilson', 'susan.wilson14@example.com', '+1-202-555-0114', '114 Magnolia Blvd, Dallas, TX 75201', '114 Magnolia Blvd, Dallas, TX 75201'),
    ('Joseph', 'Anderson', 'joseph.anderson15@example.com', '+1-202-555-0115', '115 Cypress Way, San Jose, CA 95101', '115 Cypress Way, San Jose, CA 95101'),
    ('Jessica', 'Thomas', 'jessica.thomas16@example.com', '+1-202-555-0116', '116 Redwood Dr, Jacksonville, FL 32201', '116 Redwood Dr, Jacksonville, FL 32201'),
    ('Thomas', 'Taylor', 'thomas.taylor17@example.com', '+1-202-555-0117', '117 Sequoia Ct, Indianapolis, IN 46201', '117 Sequoia Ct, Indianapolis, IN 46201'),
    ('Sarah', 'Moore', 'sarah.moore18@example.com', '+1-202-555-0118', '118 Hickory Pl, San Francisco, CA 94101', '118 Hickory Pl, San Francisco, CA 94101'),
    ('Charles', 'Jackson', 'charles.jackson19@example.com', '+1-202-555-0119', '119 Chestnut St, Charlotte, NC 28201', '119 Chestnut St, Charlotte, NC 28201'),
    ('Karen', 'Martin', 'karen.martin20@example.com', '+1-202-555-0120', '120 Beech Ave, Fort Worth, TX 76101', '120 Beech Ave, Fort Worth, TX 76101'),
    ('Christopher', 'Lee', 'christopher.lee21@example.com', '+1-202-555-0121', '121 Alder Rd, Detroit, MI 48201', '121 Alder Rd, Detroit, MI 48201'),
    ('Nancy', 'Perez', 'nancy.perez22@example.com', '+1-202-555-0122', '122 Dogwood Ln, El Paso, TX 79901', '122 Dogwood Ln, El Paso, TX 79901'),
    ('Daniel', 'Thompson', 'daniel.thompson23@example.com', '+1-202-555-0123', '123 Fir Blvd, Memphis, TN 38101', '123 Fir Blvd, Memphis, TN 38101'),
    ('Lisa', 'White', 'lisa.white24@example.com', '+1-202-555-0124', '124 Hemlock Way, Nashville, TN 37201', '124 Hemlock Way, Nashville, TN 37201'),
    ('Matthew', 'Harris', 'matthew.harris25@example.com', '+1-202-555-0125', '125 Juniper Dr, Baltimore, MD 21201', '125 Juniper Dr, Baltimore, MD 21201'),
    ('Betty', 'Sanchez', 'betty.sanchez26@example.com', '+1-202-555-0126', '126 Larch Ct, Oklahoma City, OK 73101', '126 Larch Ct, Oklahoma City, OK 73101'),
    ('Anthony', 'Clark', 'anthony.clark27@example.com', '+1-202-555-0127', '127 Laurel Pl, Las Vegas, NV 89101', '127 Laurel Pl, Las Vegas, NV 89101'),
    ('Margaret', 'Ramirez', 'margaret.ramirez28@example.com', '+1-202-555-0128', '128 Locust St, Louisville, KY 40201', '128 Locust St, Louisville, KY 40201'),
    ('Mark', 'Lewis', 'mark.lewis29@example.com', '+1-202-555-0129', '129 Mulberry Ave, Milwaukee, WI 53201', '129 Mulberry Ave, Milwaukee, WI 53201'),
    ('Sandra', 'Robinson', 'sandra.robinson30@example.com', '+1-202-555-0130', '130 Olive Rd, Albuquerque, NM 87101', '130 Olive Rd, Albuquerque, NM 87101'),
    ('Donald', 'Walker', 'donald.walker31@example.com', '+1-202-555-0131', '131 Palm Ln, Tucson, AZ 85701', '131 Palm Ln, Tucson, AZ 85701'),
    ('Ashley', 'Young', 'ashley.young32@example.com', '+1-202-555-0132', '132 Pecan Blvd, Fresno, CA 93701', '132 Pecan Blvd, Fresno, CA 93701'),
    ('Steven', 'Allen', 'steven.allen33@example.com', '+1-202-555-0133', '133 Persimmon Way, Sacramento, CA 95814', '133 Persimmon Way, Sacramento, CA 95814'),
    ('Kimberly', 'King', 'kimberly.king34@example.com', '+1-202-555-0134', '134 Plum Dr, Kansas City, MO 64101', '134 Plum Dr, Kansas City, MO 64101'),
    ('Paul', 'Wright', 'paul.wright35@example.com', '+1-202-555-0135', '135 Sassafras Ct, Mesa, AZ 85201', '135 Sassafras Ct, Mesa, AZ 85201'),
    ('Emily', 'Scott', 'emily.scott36@example.com', '+1-202-555-0136', '136 Tamarack Pl, Omaha, NE 68101', '136 Tamarack Pl, Omaha, NE 68101'),
    ('Andrew', 'Torres', 'andrew.torres37@example.com', '+1-202-555-0137', '137 Tupelo St, Raleigh, NC 27601', '137 Tupelo St, Raleigh, NC 27601'),
    ('Donna', 'Nguyen', 'donna.nguyen38@example.com', '+1-202-555-0138', '138 Yew Ave, Long Beach, CA 90801', '138 Yew Ave, Long Beach, CA 90801'),
    ('Joshua', 'Hill', 'joshua.hill39@example.com', '+1-202-555-0139', '139 Acacia Rd, Virginia Beach, VA 23450', '139 Acacia Rd, Virginia Beach, VA 23450'),
    ('Michelle', 'Flores', 'michelle.flores40@example.com', '+1-202-555-0140', '140 Banyan Ln, Oakland, CA 94601', '140 Banyan Ln, Oakland, CA 94601'),
    ('Kenneth', 'Green', 'kenneth.green41@example.com', '+1-202-555-0141', '141 Boxwood Blvd, Minneapolis, MN 55401', '141 Boxwood Blvd, Minneapolis, MN 55401'),
    ('Dorothy', 'Adams', 'dorothy.adams42@example.com', '+1-202-555-0142', '142 Buckeye Way, Tulsa, OK 74101', '142 Buckeye Way, Tulsa, OK 74101'),
    ('Kevin', 'Nelson', 'kevin.nelson43@example.com', '+1-202-555-0143', '143 Butternut Dr, Tampa, FL 33601', '143 Butternut Dr, Tampa, FL 33601'),
    ('Carol', 'Baker', 'carol.baker44@example.com', '+1-202-555-0144', '144 Catalpa Ct, Arlington, TX 76001', '144 Catalpa Ct, Arlington, TX 76001'),
    ('Brian', 'Hall', 'brian.hall45@example.com', '+1-202-555-0145', '145 Cottonwood Pl, New Orleans, LA 70112', '145 Cottonwood Pl, New Orleans, LA 70112'),
    ('Amanda', 'Rivera', 'amanda.rivera46@example.com', '+1-202-555-0146', '146 Elderberry St, Wichita, KS 67201', '146 Elderberry St, Wichita, KS 67201'),
    ('George', 'Campbell', 'george.campbell47@example.com', '+1-202-555-0147', '147 Eucalyptus Ave, Cleveland, OH 44101', '147 Eucalyptus Ave, Cleveland, OH 44101'),
    ('Melissa', 'Mitchell', 'melissa.mitchell48@example.com', '+1-202-555-0148', '148 Ginkgo Rd, Bakersfield, CA 93301', '148 Ginkgo Rd, Bakersfield, CA 93301'),
    ('Edward', 'Carter', 'edward.carter49@example.com', '+1-202-555-0149', '149 Hackberry Ln, Aurora, CO 80010', '149 Hackberry Ln, Aurora, CO 80010'),
    ('Deborah', 'Roberts', 'deborah.roberts50@example.com', '+1-202-555-0150', '150 Hawthorn Blvd, Anaheim, CA 92801', '150 Hawthorn Blvd, Anaheim, CA 92801'),
    ('Ronald', 'Gomez', 'ronald.gomez51@example.com', '+1-303-555-0151', '201 Hazel Way, Honolulu, HI 96801', '201 Hazel Way, Honolulu, HI 96801'),
    ('Stephanie', 'Phillips', 'stephanie.phillips52@example.com', '+1-303-555-0152', '202 Holly Dr, Santa Ana, CA 92701', '202 Holly Dr, Santa Ana, CA 92701'),
    ('Timothy', 'Evans', 'timothy.evans53@example.com', '+1-303-555-0153', '203 Hornbeam Ct, Riverside, CA 92501', '203 Hornbeam Ct, Riverside, CA 92501'),
    ('Rebecca', 'Turner', 'rebecca.turner54@example.com', '+1-303-555-0154', '204 Ironwood Pl, Corpus Christi, TX 78401', '204 Ironwood Pl, Corpus Christi, TX 78401'),
    ('Jason', 'Diaz', 'jason.diaz55@example.com', '+1-303-555-0155', '205 Linden St, Lexington, KY 40501', '205 Linden St, Lexington, KY 40501'),
    ('Sharon', 'Parker', 'sharon.parker56@example.com', '+1-303-555-0156', '206 Mahogany Ave, Stockton, CA 95201', '206 Mahogany Ave, Stockton, CA 95201'),
    ('Jeffrey', 'Cruz', 'jeffrey.cruz57@example.com', '+1-303-555-0157', '207 Mesquite Rd, Henderson, NV 89002', '207 Mesquite Rd, Henderson, NV 89002'),
    ('Laura', 'Edwards', 'laura.edwards58@example.com', '+1-303-555-0158', '208 Mimosa Ln, Saint Paul, MN 55101', '208 Mimosa Ln, Saint Paul, MN 55101'),
    ('Ryan', 'Collins', 'ryan.collins59@example.com', '+1-303-555-0159', '209 Myrtle Blvd, St. Louis, MO 63101', '209 Myrtle Blvd, St. Louis, MO 63101'),
    ('Cynthia', 'Reyes', 'cynthia.reyes60@example.com', '+1-303-555-0160', '210 Oleander Way, Cincinnati, OH 45201', '210 Oleander Way, Cincinnati, OH 45201'),
    ('Jacob', 'Stewart', 'jacob.stewart61@example.com', '+1-303-555-0161', '211 Osage Dr, Pittsburgh, PA 15201', '211 Osage Dr, Pittsburgh, PA 15201'),
    ('Kathleen', 'Morris', 'kathleen.morris62@example.com', '+1-303-555-0162', '212 Palmetto Ct, Greensboro, NC 27401', '212 Palmetto Ct, Greensboro, NC 27401'),
    ('Gary', 'Morales', 'gary.morales63@example.com', '+1-303-555-0163', '213 Pawpaw Pl, Anchorage, AK 99501', '213 Pawpaw Pl, Anchorage, AK 99501'),
    ('Amy', 'Murphy', 'amy.murphy64@example.com', '+1-303-555-0164', '214 Pepperwood St, Plano, TX 75023', '214 Pepperwood St, Plano, TX 75023'),
    ('Nicholas', 'Cook', 'nicholas.cook65@example.com', '+1-303-555-0165', '215 Redbud Ave, Lincoln, NE 68501', '215 Redbud Ave, Lincoln, NE 68501'),
    ('Shirley', 'Rogers', 'shirley.rogers66@example.com', '+1-303-555-0166', '216 Rosewood Rd, Orlando, FL 32801', '216 Rosewood Rd, Orlando, FL 32801'),
    ('Eric', 'Gutierrez', 'eric.gutierrez67@example.com', '+1-303-555-0167', '217 Sandalwood Ln, Irvine, CA 92602', '217 Sandalwood Ln, Irvine, CA 92602'),
    ('Angela', 'Ortiz', 'angela.ortiz68@example.com', '+1-303-555-0168', '218 Serviceberry Blvd, Newark, NJ 07101', '218 Serviceberry Blvd, Newark, NJ 07101'),
    ('Jonathan', 'Morgan', 'jonathan.morgan69@example.com', '+1-303-555-0169', '219 Silverbell Way, Toledo, OH 43601', '219 Silverbell Way, Toledo, OH 43601'),
    ('Helen', 'Cooper', 'helen.cooper70@example.com', '+1-303-555-0170', '220 Sumac Dr, Durham, NC 27701', '220 Sumac Dr, Durham, NC 27701'),
    ('Stephen', 'Peterson', 'stephen.peterson71@example.com', '+1-303-555-0171', '221 Sweetgum Ct, Chula Vista, CA 91909', '221 Sweetgum Ct, Chula Vista, CA 91909'),
    ('Anna', 'Bailey', 'anna.bailey72@example.com', '+1-303-555-0172', '222 Teak Pl, Fort Wayne, IN 46801', '222 Teak Pl, Fort Wayne, IN 46801'),
    ('Larry', 'Reed', 'larry.reed73@example.com', '+1-303-555-0173', '223 Tulip St, Jersey City, NJ 07302', '223 Tulip St, Jersey City, NJ 07302'),
    ('Brenda', 'Kelly', 'brenda.kelly74@example.com', '+1-303-555-0174', '224 Viburnum Ave, St. Petersburg, FL 33701', '224 Viburnum Ave, St. Petersburg, FL 33701'),
    ('Justin', 'Howard', 'justin.howard75@example.com', '+1-303-555-0175', '225 Witchhazel Rd, Laredo, TX 78040', '225 Witchhazel Rd, Laredo, TX 78040'),
    ('Pamela', 'Ramos', 'pamela.ramos76@example.com', '+1-303-555-0176', '226 Zelkova Ln, Madison, WI 53701', '226 Zelkova Ln, Madison, WI 53701'),
    ('Scott', 'Kim', 'scott.kim77@example.com', '+1-303-555-0177', '227 Aspen Blvd, Chandler, AZ 85224', '227 Aspen Blvd, Chandler, AZ 85224'),
    ('Nicole', 'Cox', 'nicole.cox78@example.com', '+1-303-555-0178', '228 Basswood Way, Buffalo, NY 14201', '228 Basswood Way, Buffalo, NY 14201'),
    ('Brandon', 'Ward', 'brandon.ward79@example.com', '+1-303-555-0179', '229 Bayberry Dr, Lubbock, TX 79401', '229 Bayberry Dr, Lubbock, TX 79401'),
    ('Emma', 'Richardson', 'emma.richardson80@example.com', '+1-303-555-0180', '230 Bitternut Ct, Scottsdale, AZ 85250', '230 Bitternut Ct, Scottsdale, AZ 85250'),
    ('Benjamin', 'Watson', 'benjamin.watson81@example.com', '+1-303-555-0181', '231 Blackgum Pl, Reno, NV 89501', '231 Blackgum Pl, Reno, NV 89501'),
    ('Samantha', 'Brooks', 'samantha.brooks82@example.com', '+1-303-555-0182', '232 Bladdernut St, Glendale, AZ 85301', '232 Bladdernut St, Glendale, AZ 85301'),
    ('Samuel', 'Chavez', 'samuel.chavez83@example.com', '+1-303-555-0183', '233 Buttonbush Ave, Gilbert, AZ 85233', '233 Buttonbush Ave, Gilbert, AZ 85233'),
    ('Katherine', 'Wood', 'katherine.wood84@example.com', '+1-303-555-0184', '234 Chinquapin Rd, Winston-Salem, NC 27101', '234 Chinquapin Rd, Winston-Salem, NC 27101'),
    ('Gregory', 'James', 'gregory.james85@example.com', '+1-303-555-0185', '235 Chokecherry Ln, North Las Vegas, NV 89030', '235 Chokecherry Ln, North Las Vegas, NV 89030'),
    ('Christine', 'Bennett', 'christine.bennett86@example.com', '+1-303-555-0186', '236 Coffeetree Blvd, Norfolk, VA 23501', '236 Coffeetree Blvd, Norfolk, VA 23501'),
    ('Alexander', 'Gray', 'alexander.gray87@example.com', '+1-303-555-0187', '237 Crabapple Way, Chesapeake, VA 23320', '237 Crabapple Way, Chesapeake, VA 23320'),
    ('Debra', 'Mendoza', 'debra.mendoza88@example.com', '+1-303-555-0188', '238 Elder Dr, Garland, TX 75040', '238 Elder Dr, Garland, TX 75040'),
    ('Frank', 'Ruiz', 'frank.ruiz89@example.com', '+1-303-555-0189', '239 Filbert Ct, Irving, TX 75038', '239 Filbert Ct, Irving, TX 75038'),
    ('Rachel', 'Hughes', 'rachel.hughes90@example.com', '+1-303-555-0190', '240 Fringe Pl, Hialeah, FL 33010', '240 Fringe Pl, Hialeah, FL 33010'),
    ('Patrick', 'Price', 'patrick.price91@example.com', '+1-303-555-0191', '241 Goldenrain St, Fremont, CA 94536', '241 Goldenrain St, Fremont, CA 94536'),
    ('Carolyn', 'Alvarez', 'carolyn.alvarez92@example.com', '+1-303-555-0192', '242 Hackmatack Ave, Boise, ID 83701', '242 Hackmatack Ave, Boise, ID 83701'),
    ('Raymond', 'Castillo', 'raymond.castillo93@example.com', '+1-303-555-0193', '243 Hazelnut Rd, Richmond, VA 23218', '243 Hazelnut Rd, Richmond, VA 23218'),
    ('Janet', 'Sanders', 'janet.sanders94@example.com', '+1-303-555-0194', '244 Hophornbeam Ln, Baton Rouge, LA 70801', '244 Hophornbeam Ln, Baton Rouge, LA 70801'),
    ('Jack', 'Patel', 'jack.patel95@example.com', '+1-303-555-0195', '245 Horsechestnut Blvd, Spokane, WA 99201', '245 Horsechestnut Blvd, Spokane, WA 99201'),
    ('Maria', 'Myers', 'maria.myers96@example.com', '+1-303-555-0196', '246 Juneberry Way, Des Moines, IA 50301', '246 Juneberry Way, Des Moines, IA 50301'),
    ('Dennis', 'Long', 'dennis.long97@example.com', '+1-303-555-0197', '247 Katsura Dr, Tacoma, WA 98401', '247 Katsura Dr, Tacoma, WA 98401'),
    ('Heather', 'Ross', 'heather.ross98@example.com', '+1-303-555-0198', '248 Kentucky Ct, San Bernardino, CA 92401', '248 Kentucky Ct, San Bernardino, CA 92401'),
    ('Jerry', 'Foster', 'jerry.foster99@example.com', '+1-303-555-0199', '249 Laburnum Pl, Modesto, CA 95350', '249 Laburnum Pl, Modesto, CA 95350'),
    ('Diane', 'Jimenez', 'diane.jimenez100@example.com', '+1-303-555-0200', '250 Leatherwood St, Fontana, CA 92334', '250 Leatherwood St, Fontana, CA 92334'),
    ('Tyler', 'Powell', 'tyler.powell101@example.com', '+1-415-555-0201', '301 Lilac Ave, Santa Clarita, CA 91350', '301 Lilac Ave, Santa Clarita, CA 91350'),
    ('Julie', 'Jenkins', 'julie.jenkins102@example.com', '+1-415-555-0202', '302 Madrone Rd, Birmingham, AL 35201', '302 Madrone Rd, Birmingham, AL 35201'),
    ('Aaron', 'Perry', 'aaron.perry103@example.com', '+1-415-555-0203', '303 Manzanita Ln, Oxnard, CA 93030', '303 Manzanita Ln, Oxnard, CA 93030'),
    ('Joyce', 'Russell', 'joyce.russell104@example.com', '+1-415-555-0204', '304 Mountainash Blvd, Rochester, NY 14601', '304 Mountainash Blvd, Rochester, NY 14601'),
    ('Jose', 'Sullivan', 'jose.sullivan105@example.com', '+1-415-555-0205', '305 Nannyberry Way, Port St. Lucie, FL 34952', '305 Nannyberry Way, Port St. Lucie, FL 34952'),
    ('Victoria', 'Bell', 'victoria.bell106@example.com', '+1-415-555-0206', '306 Ninebark Dr, Grand Rapids, MI 49501', '306 Ninebark Dr, Grand Rapids, MI 49501'),
    ('Adam', 'Coleman', 'adam.coleman107@example.com', '+1-415-555-0207', '307 Pagoda Ct, Huntsville, AL 35801', '307 Pagoda Ct, Huntsville, AL 35801'),
    ('Kelly', 'Butler', 'kelly.butler108@example.com', '+1-415-555-0208', '308 Paulownia Pl, Salt Lake City, UT 84101', '308 Paulownia Pl, Salt Lake City, UT 84101'),
    ('Henry', 'Henderson', 'henry.henderson109@example.com', '+1-415-555-0209', '309 Peach St, Frisco, TX 75034', '309 Peach St, Frisco, TX 75034'),
    ('Christina', 'Barnes', 'christina.barnes110@example.com', '+1-415-555-0210', '310 Pear Ave, Yonkers, NY 10701', '310 Pear Ave, Yonkers, NY 10701'),
    ('Nathan', 'Gonzales', 'nathan.gonzales111@example.com', '+1-415-555-0211', '311 Pignut Rd, Amarillo, TX 79101', '311 Pignut Rd, Amarillo, TX 79101'),
    ('Lauren', 'Fisher', 'lauren.fisher112@example.com', '+1-415-555-0212', '312 Pinon Ln, Glendale, CA 91201', '312 Pinon Ln, Glendale, CA 91201'),
    ('Douglas', 'Vasquez', 'douglas.vasquez113@example.com', '+1-415-555-0213', '313 Ponderosa Blvd, Huntington Beach, CA 92646', '313 Ponderosa Blvd, Huntington Beach, CA 92646'),
    ('Joan', 'Simmons', 'joan.simmons114@example.com', '+1-415-555-0214', '314 Privet Way, McKinney, TX 75069', '314 Privet Way, McKinney, TX 75069'),
    ('Zachary', 'Romero', 'zachary.romero115@example.com', '+1-415-555-0215', '315 Quince Dr, Montgomery, AL 36101', '315 Quince Dr, Montgomery, AL 36101'),
    ('Evelyn', 'Jordan', 'evelyn.jordan116@example.com', '+1-415-555-0216', '316 Redbay Ct, Augusta, GA 30901', '316 Redbay Ct, Augusta, GA 30901'),
    ('Peter', 'Patterson', 'peter.patterson117@example.com', '+1-415-555-0217', '317 Rhododendron Pl, Aurora, IL 60502', '317 Rhododendron Pl, Aurora, IL 60502'),
    ('Olivia', 'Alexander', 'olivia.alexander118@example.com', '+1-415-555-0218', '318 Rowantree St, Akron, OH 44301', '318 Rowantree St, Akron, OH 44301'),
    ('Kyle', 'Hamilton', 'kyle.hamilton119@example.com', '+1-415-555-0219', '319 Russianolive Ave, Little Rock, AR 72201', '319 Russianolive Ave, Little Rock, AR 72201'),
    ('Judith', 'Graham', 'judith.graham120@example.com', '+1-415-555-0220', '320 Sagebrush Rd, Tempe, AZ 85281', '320 Sagebrush Rd, Tempe, AZ 85281'),
    ('Walter', 'Reynolds', 'walter.reynolds121@example.com', '+1-415-555-0221', '321 Sandplum Ln, Columbus, GA 31901', '321 Sandplum Ln, Columbus, GA 31901'),
    ('Megan', 'Griffin', 'megan.griffin122@example.com', '+1-415-555-0222', '322 Sapodilla Blvd, Overland Park, KS 66204', '322 Sapodilla Blvd, Overland Park, KS 66204'),
    ('Ethan', 'Wallace', 'ethan.wallace123@example.com', '+1-415-555-0223', '323 Satsuma Way, Grand Prairie, TX 75050', '323 Satsuma Way, Grand Prairie, TX 75050'),
    ('Cheryl', 'Moreno', 'cheryl.moreno124@example.com', '+1-415-555-0224', '324 SeaGrape Dr, Tallahassee, FL 32301', '324 SeaGrape Dr, Tallahassee, FL 32301'),
    ('Jeremy', 'West', 'jeremy.west125@example.com', '+1-415-555-0225', '325 Shagbark Ct, Cape Coral, FL 33904', '325 Shagbark Ct, Cape Coral, FL 33904'),
    ('Martha', 'Cole', 'martha.cole126@example.com', '+1-415-555-0226', '326 Silkwood Pl, Mobile, AL 36601', '326 Silkwood Pl, Mobile, AL 36601'),
    ('Harold', 'Hayes', 'harold.hayes127@example.com', '+1-415-555-0227', '327 Silvermaple St, Knoxville, TN 37901', '327 Silvermaple St, Knoxville, TN 37901'),
    ('Andrea', 'Bryant', 'andrea.bryant128@example.com', '+1-415-555-0228', '328 Smoketree Ave, Shreveport, LA 71101', '328 Smoketree Ave, Shreveport, LA 71101'),
    ('Keith', 'Herrera', 'keith.herrera129@example.com', '+1-415-555-0229', '329 Snowbell Rd, Worcester, MA 01601', '329 Snowbell Rd, Worcester, MA 01601'),
    ('Frances', 'Gibson', 'frances.gibson130@example.com', '+1-415-555-0230', '330 Soapberry Ln, Ontario, CA 91761', '330 Soapberry Ln, Ontario, CA 91761'),
    ('Christian', 'Ellis', 'christian.ellis131@example.com', '+1-415-555-0231', '331 Sourwood Blvd, Vancouver, WA 98660', '331 Sourwood Blvd, Vancouver, WA 98660'),
    ('Hannah', 'Tran', 'hannah.tran132@example.com', '+1-415-555-0232', '332 Spicebush Way, Sioux Falls, SD 57101', '332 Spicebush Way, Sioux Falls, SD 57101'),
    ('Roger', 'Medina', 'roger.medina133@example.com', '+1-415-555-0233', '333 Staghorn Dr, Chattanooga, TN 37401', '333 Staghorn Dr, Chattanooga, TN 37401'),
    ('Jacqueline', 'Aguilar', 'jacqueline.aguilar134@example.com', '+1-415-555-0234', '334 Stewartia Ct, Brownsville, TX 78520', '334 Stewartia Ct, Brownsville, TX 78520'),
    ('Noah', 'Stevens', 'noah.stevens135@example.com', '+1-415-555-0235', '335 Strawberry Pl, Fort Lauderdale, FL 33301', '335 Strawberry Pl, Fort Lauderdale, FL 33301'),
    ('Gloria', 'Murray', 'gloria.murray136@example.com', '+1-415-555-0236', '336 Sugarberry St, Providence, RI 02901', '336 Sugarberry St, Providence, RI 02901'),
    ('Gerald', 'Ford', 'gerald.ford137@example.com', '+1-415-555-0237', '337 Sugarmaple Ave, Newport News, VA 23601', '337 Sugarmaple Ave, Newport News, VA 23601'),
    ('Teresa', 'Castro', 'teresa.castro138@example.com', '+1-415-555-0238', '338 Swampoak Rd, Rancho Cucamonga, CA 91701', '338 Swampoak Rd, Rancho Cucamonga, CA 91701'),
    ('Carl', 'Marshall', 'carl.marshall139@example.com', '+1-415-555-0239', '339 Sweetbay Ln, Santa Rosa, CA 95401', '339 Sweetbay Ln, Santa Rosa, CA 95401'),
    ('Kathryn', 'Owens', 'kathryn.owens140@example.com', '+1-415-555-0240', '340 Sweetbirch Blvd, Peoria, AZ 85345', '340 Sweetbirch Blvd, Peoria, AZ 85345'),
    ('Terry', 'Harrison', 'terry.harrison141@example.com', '+1-415-555-0241', '341 Sweetbuckeye Way, Oceanside, CA 92049', '341 Sweetbuckeye Way, Oceanside, CA 92049'),
    ('Sara', 'Fernandez', 'sara.fernandez142@example.com', '+1-415-555-0242', '342 Sweetclover Dr, Elk Grove, CA 95624', '342 Sweetclover Dr, Elk Grove, CA 95624'),
    ('Sean', 'Mcdonald', 'sean.mcdonald143@example.com', '+1-415-555-0243', '343 Sweetfern Ct, Salem, OR 97301', '343 Sweetfern Ct, Salem, OR 97301'),
    ('Janice', 'Woods', 'janice.woods144@example.com', '+1-415-555-0244', '344 Sweetflag Pl, Pembroke Pines, FL 33024', '344 Sweetflag Pl, Pembroke Pines, FL 33024'),
    ('Austin', 'Washington', 'austin.washington145@example.com', '+1-415-555-0245', '345 Sweetgale St, Eugene, OR 97401', '345 Sweetgale St, Eugene, OR 97401'),
    ('Jean', 'Kennedy', 'jean.kennedy146@example.com', '+1-415-555-0246', '346 Sweetgrass Ave, Garden Grove, CA 92840', '346 Sweetgrass Ave, Garden Grove, CA 92840'),
    ('Arthur', 'Wells', 'arthur.wells147@example.com', '+1-415-555-0247', '347 Sweetleaf Rd, Cary, NC 27511', '347 Sweetleaf Rd, Cary, NC 27511'),
    ('Alice', 'Vargas', 'alice.vargas148@example.com', '+1-415-555-0248', '348 Sweetpea Ln, Sioux City, IA 51101', '348 Sweetpea Ln, Sioux City, IA 51101'),
    ('Lawrence', 'Henry', 'lawrence.henry149@example.com', '+1-415-555-0249', '349 Sweetspire Blvd, Corona, CA 92877', '349 Sweetspire Blvd, Corona, CA 92877'),
    ('Madison', 'Chen', 'madison.chen150@example.com', '+1-415-555-0250', '350 Sweetvetch Way, Springfield, MO 65801', '350 Sweetvetch Way, Springfield, MO 65801'),
    ('Jesse', 'Freeman', 'jesse.freeman151@example.com', '+1-512-555-0251', '401 Tallow Dr, Jackson, MS 39201', '401 Tallow Dr, Jackson, MS 39201'),
    ('Julia', 'Webb', 'julia.webb152@example.com', '+1-512-555-0252', '402 Tamarind Ct, Alexandria, VA 22301', '402 Tamarind Ct, Alexandria, VA 22301'),
    ('Dylan', 'Tucker', 'dylan.tucker153@example.com', '+1-512-555-0253', '403 Tangerine Pl, Hayward, CA 94541', '403 Tangerine Pl, Hayward, CA 94541'),
    ('Grace', 'Guzman', 'grace.guzman154@example.com', '+1-512-555-0254', '404 Tansy St, Clarksville, TN 37040', '404 Tansy St, Clarksville, TN 37040'),
    ('Bryan', 'Burns', 'bryan.burns155@example.com', '+1-512-555-0255', '405 Taro Ave, Lakewood, CO 80215', '405 Taro Ave, Lakewood, CO 80215'),
    ('Judy', 'Crawford', 'judy.crawford156@example.com', '+1-512-555-0256', '406 Tea Rd, Hollywood, FL 33019', '406 Tea Rd, Hollywood, FL 33019'),
    ('Joe', 'Olson', 'joe.olson157@example.com', '+1-512-555-0257', '407 Teaberry Ln, Sunnyvale, CA 94085', '407 Teaberry Ln, Sunnyvale, CA 94085'),
    ('Theresa', 'Simpson', 'theresa.simpson158@example.com', '+1-512-555-0258', '408 Teasel Blvd, Macon, GA 31201', '408 Teasel Blvd, Macon, GA 31201'),
    ('Jordan', 'Porter', 'jordan.porter159@example.com', '+1-512-555-0259', '409 Thistle Way, Kansas City, KS 66101', '409 Thistle Way, Kansas City, KS 66101'),
    ('Beverly', 'Hunter', 'beverly.hunter160@example.com', '+1-512-555-0260', '410 Thornapple Dr, Palmdale, CA 93550', '410 Thornapple Dr, Palmdale, CA 93550'),
    ('Billy', 'Gordon', 'billy.gordon161@example.com', '+1-512-555-0261', '411 Thyme Ct, Salinas, CA 93901', '411 Thyme Ct, Salinas, CA 93901'),
    ('Denise', 'Mendez', 'denise.mendez162@example.com', '+1-512-555-0262', '412 Tilia Pl, Springfield, MA 01101', '412 Tilia Pl, Springfield, MA 01101'),
    ('Bruce', 'Silva', 'bruce.silva163@example.com', '+1-512-555-0263', '413 Timber St, Pasadena, TX 77501', '413 Timber St, Pasadena, TX 77501'),
    ('Marilyn', 'Shaw', 'marilyn.shaw164@example.com', '+1-512-555-0264', '414 Tobacco Ave, Joliet, IL 60431', '414 Tobacco Ave, Joliet, IL 60431'),
    ('Albert', 'Snyder', 'albert.snyder165@example.com', '+1-512-555-0265', '415 Tomato Rd, Naperville, IL 60540', '415 Tomato Rd, Naperville, IL 60540'),
    ('Amber', 'Mason', 'amber.mason166@example.com', '+1-512-555-0266', '416 Torchwood Ln, Paterson, NJ 07501', '416 Torchwood Ln, Paterson, NJ 07501'),
    ('Willie', 'Dixon', 'willie.dixon167@example.com', '+1-512-555-0267', '417 Toyon Blvd, Torrance, CA 90501', '417 Toyon Blvd, Torrance, CA 90501'),
    ('Danielle', 'Munoz', 'danielle.munoz168@example.com', '+1-512-555-0268', '418 Trefoil Way, Syracuse, NY 13201', '418 Trefoil Way, Syracuse, NY 13201'),
    ('Gabriel', 'Hunt', 'gabriel.hunt169@example.com', '+1-512-555-0269', '419 Trillium Dr, Bridgeport, CT 06601', '419 Trillium Dr, Bridgeport, CT 06601'),
    ('Brittany', 'Hicks', 'brittany.hicks170@example.com', '+1-512-555-0270', '420 Trumpet Ct, Mesquite, TX 75149', '420 Trumpet Ct, Mesquite, TX 75149'),
    ('Logan', 'Holmes', 'logan.holmes171@example.com', '+1-512-555-0271', '421 Tuberose Pl, Savannah, GA 31401', '421 Tuberose Pl, Savannah, GA 31401'),
    ('Diana', 'Palmer', 'diana.palmer172@example.com', '+1-512-555-0272', '422 Tuliptree St, Escondido, CA 92025', '422 Tuliptree St, Escondido, CA 92025'),
    ('Alan', 'Wagner', 'alan.wagner173@example.com', '+1-512-555-0273', '423 Tung Ave, Lakewood, NJ 08701', '423 Tung Ave, Lakewood, NJ 08701'),
    ('Abigail', 'Black', 'abigail.black174@example.com', '+1-512-555-0274', '424 Turnip Rd, Naperville, IL 60563', '424 Turnip Rd, Naperville, IL 60563'),
    ('Juan', 'Robertson', 'juan.robertson175@example.com', '+1-512-555-0275', '425 Twinflower Ln, Rockford, IL 61101', '425 Twinflower Ln, Rockford, IL 61101'),
    ('Jane', 'Boyd', 'jane.boyd176@example.com', '+1-512-555-0276', '426 Umbrella Blvd, Pomona, CA 91766', '426 Umbrella Blvd, Pomona, CA 91766'),
    ('Wayne', 'Rose', 'wayne.rose177@example.com', '+1-512-555-0277', '427 Valerian Way, Pasadena, CA 91101', '427 Valerian Way, Pasadena, CA 91101'),
    ('Lori', 'Stone', 'lori.stone178@example.com', '+1-512-555-0278', '428 Vanilla Dr, Hampton, VA 23661', '428 Vanilla Dr, Hampton, VA 23661'),
    ('Roy', 'Salazar', 'roy.salazar179@example.com', '+1-512-555-0279', '429 Verbena Ct, Bellevue, WA 98004', '429 Verbena Ct, Bellevue, WA 98004'),
    ('Alexis', 'Fox', 'alexis.fox180@example.com', '+1-512-555-0280', '430 Veronica Pl, Surprise, AZ 85374', '430 Veronica Pl, Surprise, AZ 85374'),
    ('Ralph', 'Warren', 'ralph.warren181@example.com', '+1-512-555-0281', '431 Vervain St, Miramar, FL 33023', '431 Vervain St, Miramar, FL 33023'),
    ('Kayla', 'Mills', 'kayla.mills182@example.com', '+1-512-555-0282', '432 Vetch Ave, Olathe, KS 66061', '432 Vetch Ave, Olathe, KS 66061'),
    ('Randy', 'Meyer', 'randy.meyer183@example.com', '+1-512-555-0283', '433 Violet Rd, Dayton, OH 45401', '433 Violet Rd, Dayton, OH 45401'),
    ('Sophia', 'Rice', 'sophia.rice184@example.com', '+1-512-555-0284', '434 Wahoo Ln, Waco, TX 76701', '434 Wahoo Ln, Waco, TX 76701'),
    ('Eugene', 'Schmidt', 'eugene.schmidt185@example.com', '+1-512-555-0285', '435 Wallflower Blvd, Carrollton, TX 75006', '435 Wallflower Blvd, Carrollton, TX 75006'),
    ('Chloe', 'Garza', 'chloe.garza186@example.com', '+1-512-555-0286', '436 Watercress Way, Charleston, SC 29401', '436 Watercress Way, Charleston, SC 29401'),
    ('Vincent', 'Daniels', 'vincent.daniels187@example.com', '+1-512-555-0287', '437 Waterlily Dr, Orange, CA 92865', '437 Waterlily Dr, Orange, CA 92865'),
    ('Natalie', 'Ferguson', 'natalie.ferguson188@example.com', '+1-512-555-0288', '438 Waxmyrtle Ct, Fullerton, CA 92831', '438 Waxmyrtle Ct, Fullerton, CA 92831'),
    ('Russell', 'Nichols', 'russell.nichols189@example.com', '+1-512-555-0289', '439 Wayfaring Pl, Roseville, CA 95661', '439 Wayfaring Pl, Roseville, CA 95661'),
    ('Evelyn', 'Stephens', 'evelyn.stephens190@example.com', '+1-512-555-0290', '440 Weigela St, Thornton, CO 80229', '440 Weigela St, Thornton, CO 80229'),
    ('Louis', 'Soto', 'louis.soto191@example.com', '+1-512-555-0291', '441 Whitebeam Ave, Denton, TX 76201', '441 Whitebeam Ave, Denton, TX 76201'),
    ('Charlotte', 'Weaver', 'charlotte.weaver192@example.com', '+1-512-555-0292', '442 Whiteoak Rd, Surprise, AZ 85379', '442 Whiteoak Rd, Surprise, AZ 85379'),
    ('Philip', 'Ryan', 'philip.ryan193@example.com', '+1-512-555-0293', '443 Whitepine Ln, McAllen, TX 78501', '443 Whitepine Ln, McAllen, TX 78501'),
    ('Isabella', 'Gardner', 'isabella.gardner194@example.com', '+1-512-555-0294', '444 Wildcherry Blvd, Killeen, TX 76541', '444 Wildcherry Blvd, Killeen, TX 76541'),
    ('Bobby', 'Payne', 'bobby.payne195@example.com', '+1-512-555-0295', '445 Wildginger Way, New Haven, CT 06501', '445 Wildginger Way, New Haven, CT 06501'),
    ('Mia', 'Grant', 'mia.grant196@example.com', '+1-512-555-0296', '446 Wildindigo Dr, Visalia, CA 93277', '446 Wildindigo Dr, Visalia, CA 93277'),
    ('Johnny', 'Dunn', 'johnny.dunn197@example.com', '+1-512-555-0297', '447 Wildplum Ct, Gainesville, FL 32601', '447 Wildplum Ct, Gainesville, FL 32601'),
    ('Amelia', 'Kelley', 'amelia.kelley198@example.com', '+1-512-555-0298', '448 Wildrose Pl, Stamford, CT 06901', '448 Wildrose Pl, Stamford, CT 06901'),
    ('Bradley', 'Spencer', 'bradley.spencer199@example.com', '+1-512-555-0299', '449 Winterberry St, Concord, CA 94518', '449 Winterberry St, Concord, CA 94518'),
    ('Harper', 'Hawkins', 'harper.hawkins200@example.com', '+1-512-555-0300', '450 Wisteria Ave, Coral Springs, FL 33065', '450 Wisteria Ave, Coral Springs, FL 33065');


-- Insert 160 Products
INSERT INTO PRODUCTS (sku, name, description, price, stock_quantity) VALUES
    ('SKU-1001', 'Wireless Ergonomic Mouse', '2.4GHz and Bluetooth rechargeable ergonomic mouse with 6 programmable buttons.', 39.99, 145),
    ('SKU-1002', 'Mechanical Tenkeyless Keyboard', 'Compact TKL mechanical keyboard with hot-swappable tactile switches and white backlight.', 89.00, 82),
    ('SKU-1003', 'USB-C 7-in-1 Hub', 'Aluminum multiport adapter with 4K HDMI, 100W PD pass-through, SD/microSD, and USB-A ports.', 44.50, 210),
    ('SKU-1004', '27-Inch IPS Monitor', 'QHD 2560x1440 IPS display with 75Hz refresh rate, sRGB 99% color accuracy, and VESA mount.', 279.99, 38),
    ('SKU-1005', 'Noise-Canceling Over-Ear Headphones', 'Active noise cancellation wireless headphones with 35-hour battery life and plush memory foam.', 149.95, 64),
    ('SKU-1006', 'Webcam 1080p Full HD', 'Autofocus desktop webcam with dual stereo microphones and privacy shutter.', 54.00, 118),
    ('SKU-1007', 'Laptop Stand Riser', 'Adjustable anodized aluminum laptop stand for improved posture and airflow.', 32.99, 175),
    ('SKU-1008', 'Extended Desk Mat XL', 'Water-resistant stitched-edge desk pad measuring 900x400mm for keyboard and mouse.', 24.99, 260),
    ('SKU-1009', 'GaN 65W Fast Wall Charger', 'Compact gallium nitride USB-C charger with foldable prongs for laptops and phones.', 36.00, 190),
    ('SKU-1010', 'Braided USB-C to USB-C Cable 2m', 'Durably braided 100W PD and 480Mbps data cable with reinforced strain relief.', 14.99, 340),
    ('SKU-1011', 'Portable NVMe SSD 1TB', 'Ultra-fast external solid-state drive with USB 3.2 Gen 2 up to 1050MB/s.', 94.99, 73),
    ('SKU-1012', 'Smart LED Desk Lamp', 'Dimmable architect task lamp with stepless color temperature control and touch slider.', 49.50, 95),
    ('SKU-1013', 'Magnetic Wireless Power Bank 10000mAh', 'Snap-on wireless charger and power bank with kickstand and USB-C port.', 42.00, 128),
    ('SKU-1014', 'Monitor Light Bar', 'Asymmetric screen-mounted light bar that illuminates the desk without screen glare.', 59.99, 88),
    ('SKU-1015', 'Dual Monitor Arm Mount', 'Gas-spring articulated desk mount supporting two screens up to 32 inches each.', 79.00, 52),
    ('SKU-1016', 'Condenser USB Podcast Microphone', 'Cardioid condenser mic with gain knob, mute button, and shock mount.', 74.99, 67),
    ('SKU-1017', 'Wi-Fi 6E Mesh Router', 'Tri-band wireless router covering up to 2,500 sq ft with low-latency gaming mode.', 169.00, 41),
    ('SKU-1018', 'Smart Surge Protector Power Strip', '6-outlet surge strip with 3 USB ports and app/voice energy monitoring.', 34.99, 132),
    ('SKU-1019', 'Action Camera 4K60', 'Waterproof adventure camera with electronic image stabilization and dual screens.', 129.99, 46),
    ('SKU-1020', 'Digital Drawing Pen Tablet', 'Battery-free stylus tablet with 8,192 pressure levels and customizable shortcut keys.', 69.00, 59),
    ('SKU-1021', 'Insulated Stainless Steel Bottle 32oz', 'Double-wall vacuum-insulated water bottle keeping drinks cold for 24 hours.', 27.50, 220),
    ('SKU-1022', 'Pour-Over Coffee Maker Set', 'Borosilicate glass carafe with reusable stainless steel mesh filter.', 29.99, 105),
    ('SKU-1023', 'Electric Gooseneck Kettle', 'Precision temperature-control kettle with 0.9L capacity and hold function.', 79.95, 54),
    ('SKU-1024', 'Ceramic Non-Stick Fry Pan 10-inch', 'PFAS-free ceramic skillet with stay-cool handle and induction-ready base.', 45.00, 84),
    ('SKU-1025', 'Bamboo Cutting Board Set', 'Set of 3 organic bamboo chopping boards with juice grooves and side handles.', 31.99, 140),
    ('SKU-1026', 'Airtight Glass Food Storage 12-Pc', 'Borosilicate glass meal prep containers with locking leak-proof lids.', 38.50, 112),
    ('SKU-1027', 'French Press Coffee Brewer 34oz', 'Heat-resistant glass and stainless steel French press for rich full-bodied coffee.', 26.00, 97),
    ('SKU-1028', 'Digital Kitchen Scale', 'High-precision food scale with tare function, backlit LCD, and unit conversion.', 18.99, 185),
    ('SKU-1029', 'Silicone Baking Mat Set (3-Pack)', 'Non-stick oven-safe silicone liners with measurement markings for pastries and roasting.', 19.50, 160),
    ('SKU-1030', 'Cast Iron Dutch Oven 5.5qt', 'Enameled cast iron pot ideal for slow cooking, braising, and sourdough baking.', 89.99, 36),
    ('SKU-1031', 'Microfiber Dish Drying Mat', 'Absorbent reversible drying mat with hanging loop for easy storage.', 13.99, 240),
    ('SKU-1032', 'Manual Burr Coffee Grinder', 'Stainless steel conical burr grinder with 40 click grind settings for espresso or drip.', 44.00, 78),
    ('SKU-1033', 'Herb Stripper & Kitchen Shears Set', 'Heavy-duty removable-blade kitchen scissors with multi-hole herb stripper.', 16.99, 195),
    ('SKU-1034', 'Vacuum Sealer Starter Kit', 'Compact countertop vacuum sealer with 20 heat-seal bags for freezer preservation.', 52.99, 63),
    ('SKU-1035', 'Stoneware Dinnerware Set (16-Pc)', 'Matte glaze stoneware plates, salad plates, bowls, and mugs for four.', 94.00, 29),
    ('SKU-1036', 'Electric Milk Frother Handheld', 'Rechargeable stainless steel wand frother for lattes, cappuccinos, and matcha.', 15.99, 215),
    ('SKU-1037', 'Acacia Wood Serving Tray', 'Handcrafted acacia wood tray with brass handles for breakfast or entertaining.', 34.00, 72),
    ('SKU-1038', 'Instant Read Meat Thermometer', 'Fast 2-second waterproof digital thermometer with foldable probe and backlight.', 22.99, 150),
    ('SKU-1039', 'Glass Tea Infuser Mug 16oz', 'Double-walled glass mug with removable infuser basket and lid.', 23.50, 124),
    ('SKU-1040', 'Knife Block Set 8-Piece', 'High-carbon stainless steel chef, santoku, bread, and utility knives in wood block.', 119.00, 34),
    ('SKU-1041', 'Cotton Percale Sheet Set Queen', 'Crisp, breathable 100% cotton percale sheets with deep-pocket fitted sheet.', 79.00, 68),
    ('SKU-1042', 'Weighted Blanket 15lbs', 'Glass-bead weighted blanket with breathable cotton cover for calming sleep.', 64.99, 55),
    ('SKU-1043', 'Memory Foam Cervical Pillow', 'Ergonomic contour pillow supporting neck alignment for back and side sleepers.', 46.99, 92),
    ('SKU-1044', 'Waffle Weave Bath Towels (4-Pack)', 'Lightweight quick-drying Turkish cotton bath towels in neutral slate.', 48.00, 110),
    ('SKU-1045', 'Ultrasonic Essential Oil Diffuser', '300ml wood-grain aroma diffuser with auto shut-off and warm ambient LED light.', 28.99, 135),
    ('SKU-1046', 'Blackout Thermal Curtains Pair', 'Energy-efficient room-darkening curtains reducing outside noise and light.', 42.99, 86),
    ('SKU-1047', 'Laundry Hamper with Lid', 'Collapsible linen-blend laundry hamper with sturdy bamboo frame and inner liner.', 33.99, 77),
    ('SKU-1048', 'HEPA Air Purifier Compact', 'True HEPA H13 air purifier for bedrooms up to 220 sq ft with whisper-quiet sleep mode.', 84.99, 49),
    ('SKU-1049', 'Cordless Stick Vacuum Cleaner', 'Lightweight 25kPa cordless vacuum with motorized brush roll and wall dock.', 159.99, 31),
    ('SKU-1050', 'Ceramic Space Heater Oscillating', 'PTC ceramic room heater with thermostat, tip-over protection, and remote control.', 57.99, 61),
    ('SKU-1051', 'Microfiber Duster & Mop Kit', 'Extendable telescopic duster and flat floor mop with washable pads.', 35.50, 94),
    ('SKU-1052', 'Closet Organizer Hanging Shelves', '6-shelf fabric closet hanging organizer with reinforced inserts and side pockets.', 24.50, 148),
    ('SKU-1053', 'Under-Bed Storage Bins (2-Pack)', 'Clear-window zip storage bags with reinforced handles for seasonal clothes.', 26.99, 122),
    ('SKU-1054', 'Smart Wi-Fi Thermostat', 'Programmable smart thermostat with geofencing and energy-saving schedules.', 129.00, 44),
    ('SKU-1055', 'Indoor Security Camera 2K', 'Pan-and-tilt smart indoor camera with night vision, motion alerts, and two-way audio.', 39.95, 108),
    ('SKU-1056', 'Non-Slip Bath Mat Memory Foam', 'Plush quick-dry bath rug with skid-resistant backing.', 19.99, 170),
    ('SKU-1057', 'Satin Pillowcase Standard Set (2-Pack)', 'Smooth charmeuse satin pillowcases to reduce hair friction and creases.', 17.99, 205),
    ('SKU-1058', 'Hygrometer Digital Room Thermometer', 'Compact indoor humidity and temperature monitor with comfort indicator.', 12.99, 250),
    ('SKU-1059', 'Reed Diffuser Set Sandalwood', 'Long-lasting home fragrance diffuser with natural rattan reeds and glass bottle.', 21.50, 115),
    ('SKU-1060', 'Modular Fabric Ottoman Storage', 'Foldable linen storage ottoman bench supporting up to 300 lbs.', 44.99, 66),
    ('SKU-1061', 'Yoga Mat Extra Thick 8mm', 'High-density NBR cushioned exercise mat with non-slip texture and carrying strap.', 29.99, 130),
    ('SKU-1062', 'Adjustable Dumbbell Pair 5-52.5lbs', 'Space-saving dial-adjustable dumbbells replacing 15 sets of weights.', 299.00, 19),
    ('SKU-1063', 'Resistance Bands Fabric Set (3-Pack)', 'Non-slip cloth glute and leg resistance bands with varying tension levels.', 18.50, 180),
    ('SKU-1064', 'Foam Roller High Density', 'Textured EVA foam muscle roller for myofascial release and post-workout recovery.', 22.00, 114),
    ('SKU-1065', 'Jump Rope Speed Cable', 'Adjustable ball-bearing steel cable jump rope with ergonomic non-slip handles.', 14.50, 195),
    ('SKU-1066', 'Kettlebell Cast Iron 20lbs', 'Powder-coated solid cast iron kettlebell with wide smooth handle and flat base.', 39.99, 53),
    ('SKU-1067', 'Gym Duffel Bag with Shoe Compartment', 'Water-resistant workout bag with ventilated shoe pocket and wet-item pouch.', 37.99, 89),
    ('SKU-1068', 'Trekking Poles Collapsible Pair', 'Lightweight aluminum hiking poles with cork grips and tungsten carbide tips.', 49.99, 58),
    ('SKU-1069', 'Camping Hammock Double Parachute', 'Ultralight 210T nylon camping hammock with tree-friendly straps and carabiners.', 32.99, 83),
    ('SKU-1070', 'LED Headlamp Rechargeable 1000lm', 'USB-C rechargeable headlamp with red light mode, motion sensor, and IPX6 rating.', 25.99, 142),
    ('SKU-1071', 'Dry Bag Roll-Top 20L', 'Waterproof PVC dry bag for kayaking, boating, beach days, and rainy hikes.', 21.99, 126),
    ('SKU-1072', 'Portable Camp Stove Single Burner', 'Compact butane/propane camping burner with piezo ignition and carrying case.', 38.99, 62),
    ('SKU-1073', 'Pickleball Paddle Graphite Set', 'USAPA-approved carbon/graphite pickleball paddles with 4 balls and sling bag.', 64.99, 47),
    ('SKU-1074', 'Cycling Helmet MIPS Ventilated', 'Lightweight road and commuter bike helmet with dial fit system and 18 vents.', 69.99, 40),
    ('SKU-1075', 'Ab Wheel Roller Dual Wheel', 'Wide-track core ab roller with knee pad mat for stability and balance.', 19.99, 137),
    ('SKU-1076', 'Massage Gun Percussion Deep Tissue', 'Quiet brushless percussive massager with 5 speeds and 6 interchangeable heads.', 89.99, 51),
    ('SKU-1077', 'Compact Binoculars 10x42', 'BAK4 prism roof binoculars with multi-coated lenses for birding and sports.', 74.99, 43),
    ('SKU-1078', 'Travel Neck Pillow Memory Foam', 'Ergonomic chin-supporting travel pillow with washable cover and compression pouch.', 24.99, 152),
    ('SKU-1079', 'Packing Cubes Compression Set (6-Pc)', 'Zipper-compression travel packing cubes to maximize carry-on luggage space.', 29.99, 144),
    ('SKU-1080', 'Digital Luggage Scale', 'Portable hanging scale up to 110 lbs with backlit display and overload alert.', 12.50, 205),
    ('SKU-1081', 'Minimalist Leather Bifold Wallet', 'Slim full-grain leather wallet with RFID blocking lining and 8 card slots.', 39.99, 120),
    ('SKU-1082', 'Polarized Aviator Sunglasses', 'UV400 polarized lenses with lightweight stainless steel frame and hard case.', 34.99, 134),
    ('SKU-1083', 'Canvas Messenger Crossbody Bag', 'Waxed canvas everyday sling bag with padded tablet sleeve and brass buckles.', 54.99, 71),
    ('SKU-1084', 'Merino Wool Crew Socks (3-Pack)', 'Moisture-wicking merino wool blend athletic and everyday crew socks.', 28.00, 165),
    ('SKU-1085', 'Unisex Heavyweight Hoodie', '420gsm combed cotton fleece pullover hoodie with double-lined hood.', 59.00, 88),
    ('SKU-1086', 'Classic Chino Stretch Trousers', 'Tailored slim-straight chinos with cotton-elastane stretch for all-day comfort.', 52.00, 76),
    ('SKU-1087', 'Waterproof Packable Rain Jacket', 'Seam-sealed breathable shell jacket that packs into its own chest pocket.', 69.00, 65),
    ('SKU-1088', 'Braided Elastic Belt', 'Stretchy woven belt with leather trim and zinc alloy buckle for exact fit.', 23.99, 155),
    ('SKU-1089', 'Knit Ribbed Beanie Hat', 'Soft acrylic-wool cuffed winter beanie in versatile charcoal heather.', 16.50, 185),
    ('SKU-1090', 'Leather Care & Conditioning Balm', 'Natural beeswax and oil conditioner to nourish and protect leather goods.', 15.99, 140),
    ('SKU-1091', 'Hardcover Dot Grid Notebook A5', '120gsm acid-free cream paper notebook with 192 numbered pages and elastic band.', 17.50, 210),
    ('SKU-1092', 'Retractable Gel Pens Set (12-Pack)', '0.5mm fine-point quick-drying black ink gel pens with comfortable grip.', 14.99, 275),
    ('SKU-1093', 'Magnetic Whiteboard Desktop', 'Compact glass/steel desktop memo board with dry-erase marker and eraser.', 22.99, 102),
    ('SKU-1094', 'Fountain Pen Fine Nib Classic', 'Balanced metal barrel fountain pen with fine nib and refillable ink converter.', 28.50, 81),
    ('SKU-1095', 'Acrylic Desk Organizer 7-Compartment', 'Clear cast acrylic stationery caddy for pens, sticky notes, clips, and cards.', 21.00, 129),
    ('SKU-1096', 'Heavy-Duty Stapler & 1000 Staples', 'All-metal desktop stapler with jam-resistant mechanism and staple strip box.', 16.99, 145),
    ('SKU-1097', 'Washi Tape Assortment (20 Rolls)', 'Decorative patterned Japanese paper masking tapes for journaling and crafts.', 13.50, 190),
    ('SKU-1098', 'Laminator Thermal A4/Letter', 'Fast-warm-up desktop laminator with 25 thermal laminating pouches included.', 34.99, 57),
    ('SKU-1099', 'Cordless Electric Scissors', 'Rechargeable rotary fabric and cardboard cutter with safety lock switch.', 26.99, 93),
    ('SKU-1100', 'Archival Photo Storage Box', 'Acid-free linen-wrapped keepsake box holding up to 1,100 4x6 photos.', 27.99, 74),
    ('SKU-1101', 'Gentle Hydrating Cleanser 200ml', 'Fragrance-free daily facial cleanser with ceramides and hyaluronic acid.', 18.00, 160),
    ('SKU-1102', 'Vitamin C Brightening Serum 30ml', '15% L-ascorbic acid serum with ferulic acid and vitamin E in UV bottle.', 29.00, 112),
    ('SKU-1103', 'Broad Spectrum SPF 50 Sunscreen', 'Lightweight invisible-finish mineral-chemical sunscreen with no white cast.', 21.00, 175),
    ('SKU-1104', 'Bamboo Hairbrush Paddle', 'Pneumatic cushion paddle brush with rounded bamboo bristles to reduce snagging.', 16.99, 138),
    ('SKU-1105', 'Electric Sonic Toothbrush', 'Rechargeable sonic toothbrush with 4 brushing modes, 2-minute timer, and 3 heads.', 49.99, 85),
    ('SKU-1106', 'Cuticle & Nail Care Kit (7-Pc)', 'Stainless steel nail clippers, glass file, cuticle pusher, and tweezers in case.', 19.99, 150),
    ('SKU-1107', 'Rosehip Cold-Pressed Oil 50ml', '100% pure organic rosehip seed oil for dry skin and overnight moisture.', 22.50, 104),
    ('SKU-1108', 'Charcoal Peel-Off Mask Tube 100ml', 'Clarifying activated charcoal face mask to lift impurities and excess oil.', 14.50, 142),
    ('SKU-1109', 'Lip Balm SPF 15 Trio', 'Nourishing shea butter and beeswax lip balms in peppermint, vanilla, and berry.', 11.99, 230),
    ('SKU-1110', 'Hair Claw Clips Matte Set (4-Pack)', 'Durable polycarbonate jumbo claw clips for thick and medium hair.', 13.99, 188),
    ('SKU-1111', 'Cordless Precision Screwdriver Set', '52-in-1 magnetic precision bit kit with torque control for electronics and glasses.', 34.99, 96),
    ('SKU-1112', 'Laser Distance Measure 165ft', 'Digital laser rangefinder with area/volume calculation and backlit display.', 39.99, 68),
    ('SKU-1113', 'Stud Finder Wall Scanner 4-in-1', 'Electronic wall scanner detecting wood studs, metal pipes, and live AC wires.', 27.99, 87),
    ('SKU-1114', 'Ratcheting Socket Wrench Set (24-Pc)', 'Chrome vanadium steel sockets and 72-tooth reversible ratchet in storage case.', 44.99, 60),
    ('SKU-1115', 'LED Work Light Rechargeable 2000lm', 'Magnetic folding inspection work light with hook and power bank output.', 29.99, 105),
    ('SKU-1116', 'Digital Multimeter Auto-Ranging', 'True-RMS multimeter for AC/DC voltage, current, resistance, and continuity testing.', 32.99, 75),
    ('SKU-1117', 'Heavy-Duty Bungee Cords (12-Pack)', 'Assorted UV-resistant elastic bungee cords with vinyl-coated steel hooks.', 15.99, 165),
    ('SKU-1118', 'Microfiber Car Detailing Towels (6-Pack)', 'Lint-free 500GSM dual-pile microfiber cloths for paint, glass, and interior.', 18.99, 178),
    ('SKU-1119', 'Tire Inflator Portable Air Compressor', 'Cordless digital tire pump with auto shut-off up to 150 PSI and LED light.', 47.99, 69),
    ('SKU-1120', 'Magnetic Parts Tray Stainless Steel', '6-inch magnetic dish holding screws, nuts, bolts, and small tools securely.', 9.99, 240),
    ('SKU-1121', 'Automatic Pet Feeder Wi-Fi 4L', 'App-controlled dry food dispenser with scheduled meals and portion control.', 69.99, 54),
    ('SKU-1122', 'Stainless Steel Pet Water Fountain', '2.5L whisper-quiet circulating fountain with replaceable carbon filter.', 36.99, 82),
    ('SKU-1123', 'No-Pull Dog Harness Reflective', 'Breathable padded vest harness with front/back leash clips and quick-snap buckles.', 25.99, 116),
    ('SKU-1124', 'Interactive Cat Laser Toy Automatic', 'Auto-rotating laser teaser with unpredictable patterns and timer modes.', 17.99, 148),
    ('SKU-1125', 'Slow Feeder Dog Bowl Silicone', 'Maze-pattern food bowl encouraging slower eating and better digestion.', 14.99, 162),
    ('SKU-1126', 'Pet Grooming Slicker Brush Self-Cleaning', 'Fine bent wire bristles with one-button hair release for dogs and cats.', 16.50, 133),
    ('SKU-1127', 'Car Seat Protector for Pets', 'Waterproof quilted hammock seat cover with side flaps and anchor straps.', 34.99, 77),
    ('SKU-1128', 'Cat Scratching Post Sisal Tower', 'Sturdy natural sisal scratching post with weighted base and hanging plush ball.', 28.99, 91),
    ('SKU-1129', 'Dog Poop Bags & Dispenser (300 Count)', 'Leak-proof unscented waste bags with bone-shaped clip dispenser.', 15.50, 225),
    ('SKU-1130', 'Bird Feeder Hanging Weatherproof', 'Clear polycarbonate seed feeder with sloped roof and drainage holes.', 22.99, 84),
    ('SKU-1131', 'Board Game Strategy Cooperative', 'Cooperative deck-building tabletop game for 1-4 players, ~60 minutes playtime.', 44.99, 48),
    ('SKU-1132', 'Jigsaw Puzzle 1000 Pieces Landscape', 'Thick recycled board puzzle with glare-free matte finish and reference poster.', 18.99, 109),
    ('SKU-1133', 'Magnetic Building Tiles (60-Pc)', 'Translucent STEM magnetic tiles in vibrant colors for creative 3D structures.', 39.99, 79),
    ('SKU-1134', 'Ukulele Soprano Mahogany Starter Kit', '21-inch mahogany ukulele with gig bag, clip-on tuner, strap, and extra strings.', 54.99, 52),
    ('SKU-1135', 'Watercolor Paint Set 24 Half-Pans', 'Artists grade watercolor pans in metal tin with water brush and swatch sheet.', 24.99, 118),
    ('SKU-1136', 'Wooden Chess Set Folding Magnetic', '15-inch walnut-finish folding chess board with felt-lined slots and Staunton pieces.', 36.99, 67),
    ('SKU-1137', 'Vinyl Record Cleaning Kit 5-in-1', 'Velvet record brush, stylus brush, anti-static spray, and microfiber cloth.', 21.99, 98),
    ('SKU-1138', 'Book Reading Light Clip-On Amber', 'Eye-friendly warm LED book light with 3 brightness levels and rechargeable battery.', 14.99, 184),
    ('SKU-1139', 'Indoor Herb Planter Self-Watering', 'Ceramic planters with cotton wick self-watering reservoir for kitchen windowsills.', 26.99, 103),
    ('SKU-1140', 'Garden Pruning Shears Bypass', 'SK5 steel bypass hand pruner with ergonomic grip and safety lock.', 19.99, 121),
    ('SKU-1141', 'Solar Pathway Lights (8-Pack)', 'Warm white outdoor LED stake lights with dusk-to-dawn auto sensor.', 33.99, 95),
    ('SKU-1142', 'Hose Nozzle Heavy Duty Metal', '7-pattern thumb-control watering nozzle with brass threaded connector.', 21.50, 110),
    ('SKU-1143', 'Moisture Meter Soil 3-in-1', 'No-battery plant probe measuring soil moisture, light levels, and pH.', 12.99, 192),
    ('SKU-1144', 'Plant Stand Tiered Bamboo', '3-tier indoor corner plant shelf for displaying potted succulents and ferns.', 38.99, 64),
    ('SKU-1145', 'Weatherproof Outdoor Extension Cord 25ft', '14/3 SJTW heavy-duty outdoor power cord with lighted indicator end.', 24.99, 88),
    ('SKU-1146', 'Fire Pit Spark Screen 30-inch', 'Heavy-gauge steel mesh safety screen with lifting hook for outdoor fire bowls.', 35.99, 45),
    ('SKU-1147', 'Birdbath Pedestal Resin Classic', 'Weather-resistant lightweight garden birdbath with bowl and ground stakes.', 42.99, 37),
    ('SKU-1148', 'Seed Starter Trays with Humidity Dome', '5-pack 12-cell seedling trays with adjustable vents for indoor starting.', 17.99, 136),
    ('SKU-1149', 'Kneeling Pad Thick EVA Foam', 'Extra-thick water-resistant garden and workshop kneeling mat with handle.', 15.99, 154),
    ('SKU-1150', 'Compost Bin Countertop 1.3 Gallon', 'Odor-controlled stainless steel kitchen compost pail with charcoal filters.', 29.99, 72),
    ('SKU-1151', 'Smart Doorbell Wireless HD', 'Battery-powered video doorbell with motion zones, chime, and cloud/local storage.', 79.99, 56),
    ('SKU-1152', 'RFID Blocking Card Holder Aluminum', 'Pop-up aluminum wallet holding 6 cards with quick-eject mechanism.', 19.99, 168),
    ('SKU-1153', 'Screen Cleaning Kit Spray & Cloth', 'Alcohol-free mist spray and large microfiber cloth safe for OLED, LCD, and laptops.', 11.99, 245),
    ('SKU-1154', 'Cable Management Box & Sleeves', 'Under-desk cable tray, cord box, and Velcro ties to hide power bricks and wires.', 23.99, 131),
    ('SKU-1155', 'Digital Picture Frame 10.1-inch Wi-Fi', 'IPS touchscreen smart photo frame for sharing photos and videos via mobile app.', 99.99, 42),
    ('SKU-1156', 'Electric Wine Opener Rechargeable', 'Cordless foil cutter and automatic corkscrew opening up to 30 bottles per charge.', 24.99, 99),
    ('SKU-1157', 'Espresso Tamper 58.5mm Spring-Loaded', 'Calibrated stainless steel coffee tamper with consistent 30lb spring pressure.', 31.99, 70),
    ('SKU-1158', 'Silicone Trivet Mats (4-Pack)', 'Heat-resistant honeycomb silicone pads protecting counters up to 480°F.', 14.50, 200),
    ('SKU-1159', 'Folding Step Stool 2-Step', 'Compact non-slip folding step ladder holding up to 330 lbs for home and kitchen.', 37.99, 80),
    ('SKU-1160', 'Emergency Weather Radio Solar Crank', 'AM/FM/NOAA weather band radio with hand crank, solar panel, flashlight, and SOS.', 34.99, 90);


-- Insert 250 Orders (referencing customer_id 1..200)
INSERT INTO ORDERS (customer_id, order_number, status, total_amount, currency, order_date) VALUES
    (1, 'ORD-2026-0001', 'delivered', 0.00, 'USD', '2026-01-05 09:14:22'),
    (2, 'ORD-2026-0002', 'delivered', 0.00, 'USD', '2026-01-06 11:42:10'),
    (3, 'ORD-2026-0003', 'delivered', 0.00, 'USD', '2026-01-07 15:08:45'),
    (4, 'ORD-2026-0004', 'delivered', 0.00, 'USD', '2026-01-08 18:27:03'),
    (5, 'ORD-2026-0005', 'delivered', 0.00, 'USD', '2026-01-09 10:19:51'),
    (6, 'ORD-2026-0006', 'delivered', 0.00, 'USD', '2026-01-10 14:33:19'),
    (7, 'ORD-2026-0007', 'delivered', 0.00, 'USD', '2026-01-11 16:50:07'),
    (8, 'ORD-2026-0008', 'delivered', 0.00, 'USD', '2026-01-12 08:45:38'),
    (9, 'ORD-2026-0009', 'delivered', 0.00, 'USD', '2026-01-13 12:12:14'),
    (10, 'ORD-2026-0010', 'delivered', 0.00, 'USD', '2026-01-14 19:05:29'),
    (11, 'ORD-2026-0011', 'delivered', 0.00, 'USD', '2026-01-15 13:24:56'),
    (12, 'ORD-2026-0012', 'delivered', 0.00, 'USD', '2026-01-16 17:11:40'),
    (13, 'ORD-2026-0013', 'delivered', 0.00, 'USD', '2026-01-17 09:58:12'),
    (14, 'ORD-2026-0014', 'delivered', 0.00, 'USD', '2026-01-18 11:36:44'),
    (15, 'ORD-2026-0015', 'delivered', 0.00, 'USD', '2026-01-19 15:49:08'),
    (16, 'ORD-2026-0016', 'delivered', 0.00, 'USD', '2026-01-20 20:03:52'),
    (17, 'ORD-2026-0017', 'delivered', 0.00, 'USD', '2026-01-21 08:22:19'),
    (18, 'ORD-2026-0018', 'delivered', 0.00, 'USD', '2026-01-22 14:17:33'),
    (19, 'ORD-2026-0019', 'delivered', 0.00, 'USD', '2026-01-23 16:41:05'),
    (20, 'ORD-2026-0020', 'delivered', 0.00, 'USD', '2026-01-24 10:55:27'),
    (21, 'ORD-2026-0021', 'delivered', 0.00, 'USD', '2026-01-25 12:30:11'),
    (22, 'ORD-2026-0022', 'delivered', 0.00, 'USD', '2026-01-26 18:14:49'),
    (23, 'ORD-2026-0023', 'delivered', 0.00, 'USD', '2026-01-27 09:07:23'),
    (24, 'ORD-2026-0024', 'delivered', 0.00, 'USD', '2026-01-28 13:48:16'),
    (25, 'ORD-2026-0025', 'delivered', 0.00, 'USD', '2026-01-29 17:29:41'),
    (26, 'ORD-2026-0026', 'delivered', 0.00, 'USD', '2026-01-30 11:04:58'),
    (27, 'ORD-2026-0027', 'delivered', 0.00, 'USD', '2026-01-31 15:21:30'),
    (28, 'ORD-2026-0028', 'delivered', 0.00, 'USD', '2026-02-01 19:44:12'),
    (28, 'ORD-2026-0029', 'delivered', 0.00, 'USD', '2026-02-02 08:16:04'),
    (30, 'ORD-2026-0030', 'delivered', 0.00, 'USD', '2026-02-03 14:09:37'),
    (31, 'ORD-2026-0031', 'delivered', 0.00, 'USD', '2026-02-04 16:52:21'),
    (32, 'ORD-2026-0032', 'delivered', 0.00, 'USD', '2026-02-05 10:38:15'),
    (33, 'ORD-2026-0033', 'delivered', 0.00, 'USD', '2026-02-06 12:47:09'),
    (34, 'ORD-2026-0034', 'delivered', 0.00, 'USD', '2026-02-07 17:19:53'),
    (35, 'ORD-2026-0035', 'delivered', 0.00, 'USD', '2026-02-08 09:33:28'),
    (36, 'ORD-2026-0036', 'delivered', 0.00, 'USD', '2026-02-09 13:05:42'),
    (37, 'ORD-2026-0037', 'delivered', 0.00, 'USD', '2026-02-10 15:44:19'),
    (38, 'ORD-2026-0038', 'delivered', 0.00, 'USD', '2026-02-11 20:11:06'),
    (39, 'ORD-2026-0039', 'delivered', 0.00, 'USD', '2026-02-12 08:50:31'),
    (40, 'ORD-2026-0040', 'delivered', 0.00, 'USD', '2026-02-13 11:28:14'),
    (41, 'ORD-2026-0041', 'delivered', 0.00, 'USD', '2026-02-14 14:15:47'),
    (42, 'ORD-2026-0042', 'delivered', 0.00, 'USD', '2026-02-15 16:37:22'),
    (43, 'ORD-2026-0043', 'delivered', 0.00, 'USD', '2026-02-16 10:02:59'),
    (44, 'ORD-2026-0044', 'delivered', 0.00, 'USD', '2026-02-17 12:54:18'),
    (45, 'ORD-2026-0045', 'delivered', 0.00, 'USD', '2026-02-18 18:20:43'),
    (46, 'ORD-2026-0046', 'delivered', 0.00, 'USD', '2026-02-19 09:41:09'),
    (47, 'ORD-2026-0047', 'delivered', 0.00, 'USD', '2026-02-20 13:19:36'),
    (48, 'ORD-2026-0048', 'delivered', 0.00, 'USD', '2026-02-21 15:58:12'),
    (49, 'ORD-2026-0049', 'delivered', 0.00, 'USD', '2026-02-22 19:07:45'),
    (50, 'ORD-2026-0050', 'delivered', 0.00, 'USD', '2026-02-23 08:29:17'),
    (51, 'ORD-2026-0051', 'delivered', 0.00, 'USD', '2026-02-24 11:46:50'),
    (52, 'ORD-2026-0052', 'delivered', 0.00, 'USD', '2026-02-25 14:31:24'),
    (53, 'ORD-2026-0053', 'delivered', 0.00, 'USD', '2026-02-26 17:12:08'),
    (54, 'ORD-2026-0054', 'delivered', 0.00, 'USD', '2026-02-27 10:25:39'),
    (55, 'ORD-2026-0055', 'delivered', 0.00, 'USD', '2026-02-28 12:08:11'),
    (56, 'ORD-2026-0056', 'delivered', 0.00, 'USD', '2026-03-01 15:39:44'),
    (57, 'ORD-2026-0057', 'delivered', 0.00, 'USD', '2026-03-02 18:52:16'),
    (58, 'ORD-2026-0058', 'delivered', 0.00, 'USD', '2026-03-03 09:14:52'),
    (59, 'ORD-2026-0059', 'delivered', 0.00, 'USD', '2026-03-04 11:37:29'),
    (60, 'ORD-2026-0060', 'delivered', 0.00, 'USD', '2026-03-05 14:20:03'),
    (61, 'ORD-2026-0061', 'delivered', 0.00, 'USD', '2026-03-06 16:45:37'),
    (62, 'ORD-2026-0062', 'delivered', 0.00, 'USD', '2026-03-07 19:18:10'),
    (63, 'ORD-2026-0063', 'delivered', 0.00, 'USD', '2026-03-08 08:34:48'),
    (64, 'ORD-2026-0064', 'delivered', 0.00, 'USD', '2026-03-09 12:01:25'),
    (65, 'ORD-2026-0065', 'delivered', 0.00, 'USD', '2026-03-10 15:27:51'),
    (66, 'ORD-2026-0066', 'delivered', 0.00, 'USD', '2026-03-11 17:49:14'),
    (67, 'ORD-2026-0067', 'delivered', 0.00, 'USD', '2026-03-12 10:16:38'),
    (68, 'ORD-2026-0068', 'delivered', 0.00, 'USD', '2026-03-13 13:52:02'),
    (69, 'ORD-2026-0069', 'delivered', 0.00, 'USD', '2026-03-14 16:08:29'),
    (70, 'ORD-2026-0070', 'delivered', 0.00, 'USD', '2026-03-15 20:22:55'),
    (71, 'ORD-2026-0071', 'delivered', 0.00, 'USD', '2026-03-16 09:05:17'),
    (72, 'ORD-2026-0072', 'delivered', 0.00, 'USD', '2026-03-17 11:44:41'),
    (73, 'ORD-2026-0073', 'delivered', 0.00, 'USD', '2026-03-18 14:19:06'),
    (74, 'ORD-2026-0074', 'delivered', 0.00, 'USD', '2026-03-19 17:35:30'),
    (75, 'ORD-2026-0075', 'delivered', 0.00, 'USD', '2026-03-20 10:48:54'),
    (76, 'ORD-2026-0076', 'delivered', 0.00, 'USD', '2026-03-21 13:12:18'),
    (77, 'ORD-2026-0077', 'delivered', 0.00, 'USD', '2026-03-22 15:56:42'),
    (78, 'ORD-2026-0078', 'delivered', 0.00, 'USD', '2026-03-23 18:29:07'),
    (79, 'ORD-2026-0079', 'delivered', 0.00, 'USD', '2026-03-24 08:41:33'),
    (80, 'ORD-2026-0080', 'delivered', 0.00, 'USD', '2026-03-25 11:15:59'),
    (81, 'ORD-2026-0081', 'delivered', 0.00, 'USD', '2026-03-26 14:38:24'),
    (82, 'ORD-2026-0082', 'delivered', 0.00, 'USD', '2026-03-27 16:59:49'),
    (83, 'ORD-2026-0083', 'delivered', 0.00, 'USD', '2026-03-28 19:21:13'),
    (84, 'ORD-2026-0084', 'delivered', 0.00, 'USD', '2026-03-29 09:53:38'),
    (85, 'ORD-2026-0085', 'delivered', 0.00, 'USD', '2026-03-30 12:26:02'),
    (86, 'ORD-2026-0086', 'delivered', 0.00, 'USD', '2026-03-31 15:04:27'),
    (87, 'ORD-2026-0087', 'delivered', 0.00, 'USD', '2026-04-01 17:31:51'),
    (88, 'ORD-2026-0088', 'delivered', 0.00, 'USD', '2026-04-02 10:12:16'),
    (89, 'ORD-2026-0089', 'delivered', 0.00, 'USD', '2026-04-03 13:45:40'),
    (90, 'ORD-2026-0090', 'delivered', 0.00, 'USD', '2026-04-04 16:18:05'),
    (91, 'ORD-2026-0091', 'delivered', 0.00, 'USD', '2026-04-05 18:47:29'),
    (92, 'ORD-2026-0092', 'delivered', 0.00, 'USD', '2026-04-06 08:23:54'),
    (93, 'ORD-2026-0093', 'delivered', 0.00, 'USD', '2026-04-07 11:50:18'),
    (94, 'ORD-2026-0094', 'delivered', 0.00, 'USD', '2026-04-08 14:29:43'),
    (95, 'ORD-2026-0095', 'delivered', 0.00, 'USD', '2026-04-09 17:06:08'),
    (96, 'ORD-2026-0096', 'delivered', 0.00, 'USD', '2026-04-10 20:14:32'),
    (97, 'ORD-2026-0097', 'delivered', 0.00, 'USD', '2026-04-11 09:38:57'),
    (98, 'ORD-2026-0098', 'delivered', 0.00, 'USD', '2026-04-12 12:11:21'),
    (99, 'ORD-2026-0099', 'delivered', 0.00, 'USD', '2026-04-13 15:33:46'),
    (100, 'ORD-2026-0100', 'delivered', 0.00, 'USD', '2026-04-14 18:02:10'),
    (101, 'ORD-2026-0101', 'delivered', 0.00, 'USD', '2026-04-15 10:27:35'),
    (102, 'ORD-2026-0102', 'delivered', 0.00, 'USD', '2026-04-16 13:54:59'),
    (103, 'ORD-2026-0103', 'delivered', 0.00, 'USD', '2026-04-17 16:21:24'),
    (104, 'ORD-2026-0104', 'delivered', 0.00, 'USD', '2026-04-18 19:09:48'),
    (105, 'ORD-2026-0105', 'delivered', 0.00, 'USD', '2026-04-19 08:44:13'),
    (106, 'ORD-2026-0106', 'delivered', 0.00, 'USD', '2026-04-20 11:18:37'),
    (107, 'ORD-2026-0107', 'delivered', 0.00, 'USD', '2026-04-21 14:42:02'),
    (108, 'ORD-2026-0108', 'delivered', 0.00, 'USD', '2026-04-22 17:15:26'),
    (109, 'ORD-2026-0109', 'delivered', 0.00, 'USD', '2026-04-23 09:51:50'),
    (110, 'ORD-2026-0110', 'delivered', 0.00, 'USD', '2026-04-24 12:30:15'),
    (111, 'ORD-2026-0111', 'delivered', 0.00, 'USD', '2026-04-25 15:11:39'),
    (112, 'ORD-2026-0112', 'delivered', 0.00, 'USD', '2026-04-26 17:48:04'),
    (113, 'ORD-2026-0113', 'delivered', 0.00, 'USD', '2026-04-27 10:04:28'),
    (114, 'ORD-2026-0114', 'delivered', 0.00, 'USD', '2026-04-28 13:29:52'),
    (115, 'ORD-2026-0115', 'delivered', 0.00, 'USD', '2026-04-29 16:07:17'),
    (116, 'ORD-2026-0116', 'delivered', 0.00, 'USD', '2026-04-30 18:36:41'),
    (117, 'ORD-2026-0117', 'delivered', 0.00, 'USD', '2026-05-01 08:19:06'),
    (118, 'ORD-2026-0118', 'delivered', 0.00, 'USD', '2026-05-02 11:43:30'),
    (119, 'ORD-2026-0119', 'delivered', 0.00, 'USD', '2026-05-03 14:16:55'),
    (119, 'ORD-2026-0120', 'delivered', 0.00, 'USD', '2026-05-04 17:01:19'),
    (119, 'ORD-2026-0121', 'delivered', 0.00, 'USD', '2026-05-05 20:24:44'),
    (122, 'ORD-2026-0122', 'delivered', 0.00, 'USD', '2026-05-06 09:47:08'),
    (123, 'ORD-2026-0123', 'delivered', 0.00, 'USD', '2026-05-07 12:19:33'),
    (124, 'ORD-2026-0124', 'delivered', 0.00, 'USD', '2026-05-08 15:52:57'),
    (125, 'ORD-2026-0125', 'delivered', 0.00, 'USD', '2026-05-09 18:15:22'),
    (126, 'ORD-2026-0126', 'delivered', 0.00, 'USD', '2026-05-10 10:39:46'),
    (127, 'ORD-2026-0127', 'delivered', 0.00, 'USD', '2026-05-11 13:14:11'),
    (128, 'ORD-2026-0128', 'delivered', 0.00, 'USD', '2026-05-12 16:48:35'),
    (129, 'ORD-2026-0129', 'delivered', 0.00, 'USD', '2026-05-13 19:22:00'),
    (130, 'ORD-2026-0130', 'delivered', 0.00, 'USD', '2026-05-14 08:55:24'),
    (131, 'ORD-2026-0131', 'delivered', 0.00, 'USD', '2026-05-15 11:28:49'),
    (132, 'ORD-2026-0132', 'delivered', 0.00, 'USD', '2026-05-16 14:03:13'),
    (133, 'ORD-2026-0133', 'delivered', 0.00, 'USD', '2026-05-17 17:37:38'),
    (134, 'ORD-2026-0134', 'delivered', 0.00, 'USD', '2026-05-18 10:11:02'),
    (135, 'ORD-2026-0135', 'delivered', 0.00, 'USD', '2026-05-19 12:44:27'),
    (136, 'ORD-2026-0136', 'delivered', 0.00, 'USD', '2026-05-20 15:18:51'),
    (137, 'ORD-2026-0137', 'delivered', 0.00, 'USD', '2026-05-21 18:53:16'),
    (138, 'ORD-2026-0138', 'delivered', 0.00, 'USD', '2026-05-22 09:27:40'),
    (139, 'ORD-2026-0139', 'delivered', 0.00, 'USD', '2026-05-23 11:59:05'),
    (140, 'ORD-2026-0140', 'delivered', 0.00, 'USD', '2026-05-24 14:32:29'),
    (141, 'ORD-2026-0141', 'delivered', 0.00, 'USD', '2026-05-25 17:06:54'),
    (142, 'ORD-2026-0142', 'delivered', 0.00, 'USD', '2026-05-26 20:41:18'),
    (143, 'ORD-2026-0143', 'delivered', 0.00, 'USD', '2026-05-27 08:15:43'),
    (144, 'ORD-2026-0144', 'delivered', 0.00, 'USD', '2026-05-28 10:49:07'),
    (145, 'ORD-2026-0145', 'delivered', 0.00, 'USD', '2026-05-29 13:23:32'),
    (146, 'ORD-2026-0146', 'delivered', 0.00, 'USD', '2026-05-30 15:57:56'),
    (147, 'ORD-2026-0147', 'delivered', 0.00, 'USD', '2026-05-31 18:31:21'),
    (148, 'ORD-2026-0148', 'delivered', 0.00, 'USD', '2026-06-01 09:05:45'),
    (149, 'ORD-2026-0149', 'delivered', 0.00, 'USD', '2026-06-02 11:39:10'),
    (150, 'ORD-2026-0150', 'delivered', 0.00, 'USD', '2026-06-03 14:13:34'),
    (151, 'ORD-2026-0151', 'shipped', 0.00, 'USD', '2026-06-04 16:47:59'),
    (152, 'ORD-2026-0152', 'shipped', 0.00, 'USD', '2026-06-05 19:22:23'),
    (153, 'ORD-2026-0153', 'shipped', 0.00, 'USD', '2026-06-06 08:56:48'),
    (154, 'ORD-2026-0154', 'shipped', 0.00, 'USD', '2026-06-07 11:30:12'),
    (155, 'ORD-2026-0155', 'shipped', 0.00, 'USD', '2026-06-08 14:04:37'),
    (156, 'ORD-2026-0156', 'shipped', 0.00, 'USD', '2026-06-09 16:39:01'),
    (157, 'ORD-2026-0157', 'shipped', 0.00, 'USD', '2026-06-10 19:13:26'),
    (158, 'ORD-2026-0158', 'shipped', 0.00, 'USD', '2026-06-11 09:47:50'),
    (159, 'ORD-2026-0159', 'shipped', 0.00, 'USD', '2026-06-12 12:22:15'),
    (160, 'ORD-2026-0160', 'shipped', 0.00, 'USD', '2026-06-13 14:56:39'),
    (161, 'ORD-2026-0161', 'shipped', 0.00, 'USD', '2026-06-14 17:31:04'),
    (162, 'ORD-2026-0162', 'shipped', 0.00, 'USD', '2026-06-15 20:05:28'),
    (163, 'ORD-2026-0163', 'shipped', 0.00, 'USD', '2026-06-16 08:39:53'),
    (164, 'ORD-2026-0164', 'shipped', 0.00, 'USD', '2026-06-17 11:14:17'),
    (165, 'ORD-2026-0165', 'shipped', 0.00, 'USD', '2026-06-18 13:48:42'),
    (166, 'ORD-2026-0166', 'shipped', 0.00, 'USD', '2026-06-19 16:23:06'),
    (167, 'ORD-2026-0167', 'shipped', 0.00, 'USD', '2026-06-20 18:57:31'),
    (168, 'ORD-2026-0168', 'shipped', 0.00, 'USD', '2026-06-21 09:31:55'),
    (169, 'ORD-2026-0169', 'shipped', 0.00, 'USD', '2026-06-22 12:06:20'),
    (170, 'ORD-2026-0170', 'shipped', 0.00, 'USD', '2026-06-23 14:40:44'),
    (171, 'ORD-2026-0171', 'shipped', 0.00, 'USD', '2026-06-24 17:15:09'),
    (172, 'ORD-2026-0172', 'shipped', 0.00, 'USD', '2026-06-25 19:49:33'),
    (173, 'ORD-2026-0173', 'shipped', 0.00, 'USD', '2026-06-26 08:23:58'),
    (174, 'ORD-2026-0174', 'shipped', 0.00, 'USD', '2026-06-27 10:58:22'),
    (175, 'ORD-2026-0175', 'shipped', 0.00, 'USD', '2026-06-28 13:32:47'),
    (176, 'ORD-2026-0176', 'processing', 0.00, 'USD', '2026-06-29 16:07:11'),
    (177, 'ORD-2026-0177', 'processing', 0.00, 'USD', '2026-06-30 18:41:36'),
    (178, 'ORD-2026-0178', 'processing', 0.00, 'USD', '2026-07-01 09:15:00'),
    (179, 'ORD-2026-0179', 'processing', 0.00, 'USD', '2026-07-02 11:49:25'),
    (180, 'ORD-2026-0180', 'processing', 0.00, 'USD', '2026-07-03 14:23:49'),
    (181, 'ORD-2026-0181', 'processing', 0.00, 'USD', '2026-07-04 16:58:14'),
    (182, 'ORD-2026-0182', 'processing', 0.00, 'USD', '2026-07-05 19:32:38'),
    (183, 'ORD-2026-0183', 'processing', 0.00, 'USD', '2026-07-06 08:07:03'),
    (184, 'ORD-2026-0184', 'processing', 0.00, 'USD', '2026-07-07 10:41:27'),
    (185, 'ORD-2026-0185', 'processing', 0.00, 'USD', '2026-07-08 13:15:52'),
    (186, 'ORD-2026-0186', 'processing', 0.00, 'USD', '2026-07-09 15:50:16'),
    (187, 'ORD-2026-0187', 'processing', 0.00, 'USD', '2026-07-10 18:24:41'),
    (188, 'ORD-2026-0188', 'processing', 0.00, 'USD', '2026-07-11 09:59:05'),
    (189, 'ORD-2026-0189', 'processing', 0.00, 'USD', '2026-07-12 12:33:30'),
    (190, 'ORD-2026-0190', 'processing', 0.00, 'USD', '2026-07-13 15:07:54'),
    (191, 'ORD-2026-0191', 'processing', 0.00, 'USD', '2026-07-14 17:42:19'),
    (192, 'ORD-2026-0192', 'processing', 0.00, 'USD', '2026-07-15 20:16:43'),
    (193, 'ORD-2026-0193', 'processing', 0.00, 'USD', '2026-07-16 08:51:08'),
    (194, 'ORD-2026-0194', 'processing', 0.00, 'USD', '2026-07-17 11:25:32'),
    (195, 'ORD-2026-0195', 'processing', 0.00, 'USD', '2026-07-18 13:59:57'),
    (196, 'ORD-2026-0196', 'processing', 0.00, 'USD', '2026-07-19 16:34:21'),
    (197, 'ORD-2026-0197', 'processing', 0.00, 'USD', '2026-07-20 19:08:46'),
    (198, 'ORD-2026-0198', 'processing', 0.00, 'USD', '2026-07-21 09:43:10'),
    (199, 'ORD-2026-0199', 'processing', 0.00, 'USD', '2026-07-22 12:17:35'),
    (200, 'ORD-2026-0200', 'processing', 0.00, 'USD', '2026-07-23 14:51:59'),
    (25, 'ORD-2026-0201', 'pending', 0.00, 'USD', '2026-07-24 17:26:24'),
    (50, 'ORD-2026-0202', 'pending', 0.00, 'USD', '2026-07-25 20:00:48'),
    (75, 'ORD-2026-0203', 'pending', 0.00, 'USD', '2026-07-26 08:35:13'),
    (100, 'ORD-2026-0204', 'pending', 0.00, 'USD', '2026-07-27 11:09:37'),
    (125, 'ORD-2026-0205', 'pending', 0.00, 'USD', '2026-07-28 13:44:02'),
    (150, 'ORD-2026-0206', 'pending', 0.00, 'USD', '2026-07-29 16:18:26'),
    (175, 'ORD-2026-0207', 'pending', 0.00, 'USD', '2026-07-30 18:52:51'),
    (200, 'ORD-2026-0208', 'pending', 0.00, 'USD', '2026-07-31 09:27:15'),
    (12, 'ORD-2026-0209', 'pending', 0.00, 'USD', '2026-08-01 12:01:40'),
    (37, 'ORD-2026-0210', 'pending', 0.00, 'USD', '2026-08-02 14:36:04'),
    (62, 'ORD-2026-0211', 'pending', 0.00, 'USD', '2026-08-03 17:10:29'),
    (87, 'ORD-2026-0212', 'pending', 0.00, 'USD', '2026-08-04 19:44:53'),
    (112, 'ORD-2026-0213', 'pending', 0.00, 'USD', '2026-08-05 08:19:18'),
    (137, 'ORD-2026-0214', 'pending', 0.00, 'USD', '2026-08-06 10:53:42'),
    (162, 'ORD-2026-0215', 'pending', 0.00, 'USD', '2026-08-07 13:28:07'),
    (187, 'ORD-2026-0216', 'pending', 0.00, 'USD', '2026-08-08 16:02:31'),
    (19, 'ORD-2026-0217', 'pending', 0.00, 'USD', '2026-08-09 18:36:56'),
    (44, 'ORD-2026-0218', 'pending', 0.00, 'USD', '2026-08-10 09:11:20'),
    (69, 'ORD-2026-0219', 'pending', 0.00, 'USD', '2026-08-11 11:45:45'),
    (94, 'ORD-2026-0220', 'pending', 0.00, 'USD', '2026-08-12 14:20:09'),
    (119, 'ORD-2026-0221', 'pending', 0.00, 'USD', '2026-08-13 16:54:34'),
    (144, 'ORD-2026-0222', 'pending', 0.00, 'USD', '2026-08-14 19:28:58'),
    (169, 'ORD-2026-0223', 'pending', 0.00, 'USD', '2026-08-15 08:03:23'),
    (194, 'ORD-2026-0224', 'pending', 0.00, 'USD', '2026-08-16 10:37:47'),
    (7, 'ORD-2026-0225', 'pending', 0.00, 'USD', '2026-08-17 13:12:12'),
    (31, 'ORD-2026-0226', 'cancelled', 0.00, 'USD', '2026-08-18 15:46:36'),
    (56, 'ORD-2026-0227', 'cancelled', 0.00, 'USD', '2026-08-19 18:21:01'),
    (81, 'ORD-2026-0228', 'cancelled', 0.00, 'USD', '2026-08-20 09:55:25'),
    (106, 'ORD-2026-0229', 'cancelled', 0.00, 'USD', '2026-08-21 12:29:50'),
    (131, 'ORD-2026-0230', 'cancelled', 0.00, 'USD', '2026-08-22 15:04:14'),
    (156, 'ORD-2026-0231', 'cancelled', 0.00, 'USD', '2026-08-23 17:38:39'),
    (181, 'ORD-2026-0232', 'cancelled', 0.00, 'USD', '2026-08-24 20:13:03'),
    (14, 'ORD-2026-0233', 'cancelled', 0.00, 'USD', '2026-08-25 08:47:28'),
    (39, 'ORD-2026-0234', 'cancelled', 0.00, 'USD', '2026-08-26 11:21:52'),
    (64, 'ORD-2026-0235', 'cancelled', 0.00, 'USD', '2026-08-27 13:56:17'),
    (89, 'ORD-2026-0236', 'cancelled', 0.00, 'USD', '2026-08-28 16:30:41'),
    (114, 'ORD-2026-0237', 'cancelled', 0.00, 'USD', '2026-08-29 19:05:06'),
    (139, 'ORD-2026-0238', 'refunded', 0.00, 'USD', '2026-08-30 09:39:30'),
    (164, 'ORD-2026-0239', 'refunded', 0.00, 'USD', '2026-08-31 12:13:55'),
    (189, 'ORD-2026-0240', 'refunded', 0.00, 'USD', '2026-09-01 14:48:19'),
    (3, 'ORD-2026-0241', 'refunded', 0.00, 'USD', '2026-09-02 17:22:44'),
    (28, 'ORD-2026-0242', 'refunded', 0.00, 'USD', '2026-09-03 19:57:08'),
    (53, 'ORD-2026-0243', 'refunded', 0.00, 'USD', '2026-09-04 08:31:33'),
    (78, 'ORD-2026-0244', 'refunded', 0.00, 'USD', '2026-09-05 11:05:57'),
    (103, 'ORD-2026-0245', 'refunded', 0.00, 'USD', '2026-09-06 13:40:22'),
    (128, 'ORD-2026-0246', 'refunded', 0.00, 'USD', '2026-09-07 16:14:46'),
    (153, 'ORD-2026-0247', 'refunded', 0.00, 'USD', '2026-09-08 18:49:11'),
    (178, 'ORD-2026-0248', 'refunded', 0.00, 'USD', '2026-09-09 09:23:35'),
    (10, 'ORD-2026-0249', 'refunded', 0.00, 'USD', '2026-09-10 11:58:00'),
    (42, 'ORD-2026-0250', 'refunded', 0.00, 'USD', '2026-09-11 14:32:24');

SET @base_order_id = LAST_INSERT_ID();

-- Insert 1 to 5 Order Items per Order (750 total line items across orders +0..+249)
INSERT INTO ORDER_ITEMS (order_id, product_id, quantity, unit_price) VALUES
    -- Order 1 (+0) [3 items]
    (@base_order_id + 0, 1, 1, 39.99), (@base_order_id + 0, 8, 2, 24.99), (@base_order_id + 0, 10, 1, 14.99),
    -- Order 2 (+1) [2 items]
    (@base_order_id + 1, 4, 1, 279.99), (@base_order_id + 1, 3, 1, 44.50),
    -- Order 3 (+2) [4 items]
    (@base_order_id + 2, 21, 2, 27.50), (@base_order_id + 2, 22, 1, 29.99), (@base_order_id + 2, 27, 1, 26.00), (@base_order_id + 2, 36, 1, 15.99),
    -- Order 4 (+3) [1 item]
    (@base_order_id + 3, 5, 1, 149.95),
    -- Order 5 (+4) [5 items]
    (@base_order_id + 4, 91, 2, 17.50), (@base_order_id + 4, 92, 3, 14.99), (@base_order_id + 4, 95, 1, 21.00), (@base_order_id + 4, 96, 1, 16.99), (@base_order_id + 4, 97, 2, 13.50),
    -- Order 6 (+5) [3 items]
    (@base_order_id + 5, 61, 1, 29.99), (@base_order_id + 5, 63, 2, 18.50), (@base_order_id + 5, 64, 1, 22.00),
    -- Order 7 (+6) [2 items]
    (@base_order_id + 6, 41, 1, 79.00), (@base_order_id + 6, 43, 1, 46.99),
    -- Order 8 (+7) [4 items]
    (@base_order_id + 7, 101, 1, 18.00), (@base_order_id + 7, 102, 1, 29.00), (@base_order_id + 7, 103, 2, 21.00), (@base_order_id + 7, 109, 1, 11.99),
    -- Order 9 (+8) [1 item]
    (@base_order_id + 8, 17, 1, 169.00),
    -- Order 10 (+9) [3 items]
    (@base_order_id + 9, 121, 1, 69.99), (@base_order_id + 9, 122, 1, 36.99), (@base_order_id + 9, 129, 2, 15.50),
    -- Order 11 (+10) [5 items]
    (@base_order_id + 10, 2, 1, 89.00), (@base_order_id + 10, 6, 1, 54.00), (@base_order_id + 10, 7, 1, 32.99), (@base_order_id + 10, 9, 1, 36.00), (@base_order_id + 10, 12, 1, 49.50),
    -- Order 12 (+11) [2 items]
    (@base_order_id + 11, 24, 1, 45.00), (@base_order_id + 11, 25, 1, 31.99),
    -- Order 13 (+12) [3 items]
    (@base_order_id + 12, 81, 1, 39.99), (@base_order_id + 12, 82, 1, 34.99), (@base_order_id + 12, 88, 1, 23.99),
    -- Order 14 (+13) [4 items]
    (@base_order_id + 13, 139, 2, 26.99), (@base_order_id + 13, 140, 1, 19.99), (@base_order_id + 13, 143, 1, 12.99), (@base_order_id + 13, 148, 2, 17.99),
    -- Order 15 (+14) [1 item]
    (@base_order_id + 14, 49, 1, 159.99),
    -- Order 16 (+15) [3 items]
    (@base_order_id + 15, 111, 1, 34.99), (@base_order_id + 15, 115, 1, 29.99), (@base_order_id + 15, 120, 2, 9.99),
    -- Order 17 (+16) [2 items]
    (@base_order_id + 16, 11, 1, 94.99), (@base_order_id + 16, 13, 1, 42.00),
    -- Order 18 (+17) [5 items]
    (@base_order_id + 17, 28, 1, 18.99), (@base_order_id + 17, 29, 1, 19.50), (@base_order_id + 17, 31, 2, 13.99), (@base_order_id + 17, 33, 1, 16.99), (@base_order_id + 17, 38, 1, 22.99),
    -- Order 19 (+18) [3 items]
    (@base_order_id + 18, 68, 1, 49.99), (@base_order_id + 18, 69, 1, 32.99), (@base_order_id + 18, 70, 1, 25.99),
    -- Order 20 (+19) [4 items]
    (@base_order_id + 19, 151, 1, 79.99), (@base_order_id + 19, 152, 1, 19.99), (@base_order_id + 19, 153, 2, 11.99), (@base_order_id + 19, 154, 1, 23.99),
    -- Order 21 (+20) [1 item]
    (@base_order_id + 20, 30, 1, 89.99),
    -- Order 22 (+21) [3 items]
    (@base_order_id + 21, 44, 1, 48.00), (@base_order_id + 21, 45, 1, 28.99), (@base_order_id + 21, 56, 1, 19.99),
    -- Order 23 (+22) [2 items]
    (@base_order_id + 22, 131, 1, 44.99), (@base_order_id + 22, 132, 1, 18.99),
    -- Order 24 (+23) [4 items]
    (@base_order_id + 23, 78, 1, 24.99), (@base_order_id + 23, 79, 1, 29.99), (@base_order_id + 23, 80, 1, 12.50), (@base_order_id + 23, 156, 1, 24.99),
    -- Order 25 (+24) [5 items]
    (@base_order_id + 24, 104, 1, 16.99), (@base_order_id + 24, 105, 1, 49.99), (@base_order_id + 24, 106, 1, 19.99), (@base_order_id + 24, 107, 1, 22.50), (@base_order_id + 24, 110, 2, 13.99),
    -- Order 26 (+25) [2 items]
    (@base_order_id + 25, 14, 1, 59.99), (@base_order_id + 25, 18, 1, 34.99),
    -- Order 27 (+26) [3 items]
    (@base_order_id + 26, 23, 1, 79.95), (@base_order_id + 26, 32, 1, 44.00), (@base_order_id + 26, 157, 1, 31.99),
    -- Order 28 (+27) [1 item]
    (@base_order_id + 27, 62, 1, 299.00),
    -- Order 29 (+28) [4 items]
    (@base_order_id + 28, 51, 1, 35.50), (@base_order_id + 28, 52, 1, 24.50), (@base_order_id + 28, 53, 1, 26.99), (@base_order_id + 28, 58, 2, 12.99),
    -- Order 30 (+29) [3 items]
    (@base_order_id + 29, 84, 2, 28.00), (@base_order_id + 29, 85, 1, 59.00), (@base_order_id + 29, 89, 1, 16.50),
    -- Order 31 (+30) [2 items]
    (@base_order_id + 30, 123, 1, 25.99), (@base_order_id + 30, 125, 2, 14.99),
    -- Order 32 (+31) [5 items]
    (@base_order_id + 31, 133, 1, 39.99), (@base_order_id + 31, 134, 1, 54.99), (@base_order_id + 31, 135, 1, 24.99), (@base_order_id + 31, 136, 1, 36.99), (@base_order_id + 31, 138, 1, 14.99),
    -- Order 33 (+32) [3 items]
    (@base_order_id + 32, 15, 1, 79.00), (@base_order_id + 32, 16, 1, 74.99), (@base_order_id + 32, 154, 1, 23.99),
    -- Order 34 (+33) [1 item]
    (@base_order_id + 33, 40, 1, 119.00),
    -- Order 35 (+34) [4 items]
    (@base_order_id + 34, 65, 2, 14.50), (@base_order_id + 34, 66, 1, 39.99), (@base_order_id + 34, 67, 1, 37.99), (@base_order_id + 34, 75, 1, 19.99),
    -- Order 36 (+35) [2 items]
    (@base_order_id + 35, 42, 1, 64.99), (@base_order_id + 35, 57, 1, 17.99),
    -- Order 37 (+36) [3 items]
    (@base_order_id + 36, 112, 1, 39.99), (@base_order_id + 36, 113, 1, 27.99), (@base_order_id + 36, 117, 1, 15.99),
    -- Order 38 (+37) [4 items]
    (@base_order_id + 37, 141, 1, 33.99), (@base_order_id + 37, 142, 1, 21.50), (@base_order_id + 37, 144, 1, 38.99), (@base_order_id + 37, 149, 1, 15.99),
    -- Order 38 (+38) [3 items]
    (@base_order_id + 38, 19, 1, 129.99), (@base_order_id + 38, 20, 1, 69.00), (@base_order_id + 38, 153, 1, 11.99),
    -- Order 40 (+39) [2 items]
    (@base_order_id + 39, 26, 1, 38.50), (@base_order_id + 39, 34, 1, 52.99),
    -- Order 41 (+40) [5 items]
    (@base_order_id + 40, 93, 1, 22.99), (@base_order_id + 40, 94, 1, 28.50), (@base_order_id + 40, 98, 1, 34.99), (@base_order_id + 40, 99, 1, 26.99), (@base_order_id + 40, 100, 1, 27.99),
    -- Order 42 (+41) [1 item]
    (@base_order_id + 41, 48, 1, 84.99),
    -- Order 43 (+42) [3 items]
    (@base_order_id + 42, 71, 1, 21.99), (@base_order_id + 42, 72, 1, 38.99), (@base_order_id + 42, 73, 1, 64.99),
    -- Order 44 (+43) [4 items]
    (@base_order_id + 43, 124, 1, 17.99), (@base_order_id + 43, 126, 1, 16.50), (@base_order_id + 43, 127, 1, 34.99), (@base_order_id + 43, 128, 1, 28.99),
    -- Order 45 (+44) [2 items]
    (@base_order_id + 44, 83, 1, 54.99), (@base_order_id + 44, 90, 1, 15.99),
    -- Order 46 (+45) [3 items]
    (@base_order_id + 45, 1, 1, 39.99), (@base_order_id + 45, 7, 1, 32.99), (@base_order_id + 45, 10, 2, 14.99),
    -- Order 47 (+46) [4 items]
    (@base_order_id + 46, 35, 1, 94.00), (@base_order_id + 46, 37, 1, 34.00), (@base_order_id + 46, 39, 1, 23.50), (@base_order_id + 46, 158, 1, 14.50),
    -- Order 48 (+47) [1 item]
    (@base_order_id + 47, 155, 1, 99.99),
    -- Order 49 (+48) [3 items]
    (@base_order_id + 48, 54, 1, 129.00), (@base_order_id + 48, 55, 1, 39.95), (@base_order_id + 48, 59, 1, 21.50),
    -- Order 50 (+49) [5 items]
    (@base_order_id + 49, 101, 1, 18.00), (@base_order_id + 49, 104, 1, 16.99), (@base_order_id + 49, 107, 1, 22.50), (@base_order_id + 49, 108, 1, 14.50), (@base_order_id + 49, 109, 1, 11.99),
    -- Order 51 (+50) [2 items]
    (@base_order_id + 50, 74, 1, 69.99), (@base_order_id + 50, 76, 1, 89.99),
    -- Order 52 (+51) [3 items]
    (@base_order_id + 51, 114, 1, 44.99), (@base_order_id + 51, 116, 1, 32.99), (@base_order_id + 51, 118, 1, 18.99),
    -- Order 53 (+52) [4 items]
    (@base_order_id + 52, 145, 1, 24.99), (@base_order_id + 52, 146, 1, 35.99), (@base_order_id + 52, 147, 1, 42.99), (@base_order_id + 52, 150, 1, 29.99),
    -- Order 54 (+53) [1 item]
    (@base_order_id + 53, 4, 1, 279.99),
    -- Order 55 (+54) [3 items]
    (@base_order_id + 54, 21, 1, 27.50), (@base_order_id + 54, 26, 1, 38.50), (@base_order_id + 54, 28, 1, 18.99),
    -- Order 56 (+55) [2 items]
    (@base_order_id + 55, 46, 1, 42.99), (@base_order_id + 55, 47, 1, 33.99),
    -- Order 57 (+56) [4 items]
    (@base_order_id + 56, 86, 1, 52.00), (@base_order_id + 56, 87, 1, 69.00), (@base_order_id + 56, 88, 1, 23.99), (@base_order_id + 56, 89, 1, 16.50),
    -- Order 58 (+57) [3 items]
    (@base_order_id + 57, 121, 1, 69.99), (@base_order_id + 57, 123, 1, 25.99), (@base_order_id + 57, 124, 1, 17.99),
    -- Order 59 (+58) [5 items]
    (@base_order_id + 58, 91, 1, 17.50), (@base_order_id + 58, 92, 1, 14.99), (@base_order_id + 58, 93, 1, 22.99), (@base_order_id + 58, 94, 1, 28.50), (@base_order_id + 58, 95, 1, 21.00),
    -- Order 60 (+59) [2 items]
    (@base_order_id + 59, 61, 1, 29.99), (@base_order_id + 59, 62, 1, 299.00),
    -- Order 61 (+60) [3 items]
    (@base_order_id + 60, 3, 1, 44.50), (@base_order_id + 60, 9, 1, 36.00), (@base_order_id + 60, 152, 1, 19.99),
    -- Order 62 (+61) [1 item]
    (@base_order_id + 61, 17, 1, 169.00),
    -- Order 63 (+62) [4 items]
    (@base_order_id + 62, 111, 1, 34.99), (@base_order_id + 62, 112, 1, 39.99), (@base_order_id + 62, 118, 1, 18.99), (@base_order_id + 62, 119, 1, 47.99),
    -- Order 64 (+63) [3 items]
    (@base_order_id + 63, 131, 1, 44.99), (@base_order_id + 63, 135, 1, 24.99), (@base_order_id + 63, 137, 1, 21.99),
    -- Order 65 (+64) [2 items]
    (@base_order_id + 64, 22, 1, 29.99), (@base_order_id + 64, 27, 1, 26.00),
    -- Order 66 (+65) [4 items]
    (@base_order_id + 65, 50, 1, 57.99), (@base_order_id + 65, 56, 1, 19.99), (@base_order_id + 65, 57, 1, 17.99), (@base_order_id + 65, 60, 1, 44.99),
    -- Order 67 (+66) [3 items]
    (@base_order_id + 66, 77, 1, 74.99), (@base_order_id + 66, 78, 1, 24.99), (@base_order_id + 66, 80, 1, 12.50),
    -- Order 68 (+67) [5 items]
    (@base_order_id + 67, 102, 1, 29.00), (@base_order_id + 67, 103, 1, 21.00), (@base_order_id + 67, 105, 1, 49.99), (@base_order_id + 67, 106, 1, 19.99), (@base_order_id + 67, 110, 1, 13.99),
    -- Order 69 (+68) [1 item]
    (@base_order_id + 68, 5, 1, 149.95),
    -- Order 70 (+69) [3 items]
    (@base_order_id + 69, 141, 1, 33.99), (@base_order_id + 69, 143, 1, 12.99), (@base_order_id + 69, 148, 1, 17.99),
    -- Order 71 (+70) [2 items]
    (@base_order_id + 70, 2, 1, 89.00), (@base_order_id + 70, 8, 1, 24.99),
    -- Order 72 (+71) [4 items]
    (@base_order_id + 71, 29, 1, 19.50), (@base_order_id + 71, 31, 1, 13.99), (@base_order_id + 71, 33, 1, 16.99), (@base_order_id + 71, 36, 1, 15.99),
    -- Order 73 (+72) [3 items]
    (@base_order_id + 72, 63, 1, 18.50), (@base_order_id + 72, 64, 1, 22.00), (@base_order_id + 72, 65, 1, 14.50),
    -- Order 74 (+73) [2 items]
    (@base_order_id + 73, 41, 1, 79.00), (@base_order_id + 73, 42, 1, 64.99),
    -- Order 75 (+74) [4 items]
    (@base_order_id + 74, 96, 1, 16.99), (@base_order_id + 74, 97, 1, 13.50), (@base_order_id + 74, 98, 1, 34.99), (@base_order_id + 74, 99, 1, 26.99),
    -- Order 76 (+75) [1 item]
    (@base_order_id + 75, 49, 1, 159.99),
    -- Order 77 (+76) [3 items]
    (@base_order_id + 76, 122, 1, 36.99), (@base_order_id + 76, 125, 1, 14.99), (@base_order_id + 76, 130, 1, 22.99),
    -- Order 78 (+77) [5 items]
    (@base_order_id + 77, 11, 1, 94.99), (@base_order_id + 77, 12, 1, 49.50), (@base_order_id + 77, 13, 1, 42.00), (@base_order_id + 77, 14, 1, 59.99), (@base_order_id + 77, 153, 1, 11.99),
    -- Order 79 (+78) [2 items]
    (@base_order_id + 78, 81, 1, 39.99), (@base_order_id + 78, 84, 1, 28.00),
    -- Order 80 (+79) [3 items]
    (@base_order_id + 79, 113, 1, 27.99), (@base_order_id + 79, 114, 1, 44.99), (@base_order_id + 79, 120, 1, 9.99),
    -- Order 81 (+80) [4 items]
    (@base_order_id + 80, 132, 1, 18.99), (@base_order_id + 80, 133, 1, 39.99), (@base_order_id + 80, 134, 1, 54.99), (@base_order_id + 80, 136, 1, 36.99),
    -- Order 82 (+81) [1 item]
    (@base_order_id + 81, 30, 1, 89.99),
    -- Order 83 (+82) [3 items]
    (@base_order_id + 82, 24, 1, 45.00), (@base_order_id + 82, 25, 1, 31.99), (@base_order_id + 82, 34, 1, 52.99),
    -- Order 84 (+83) [2 items]
    (@base_order_id + 83, 66, 1, 39.99), (@base_order_id + 83, 67, 1, 37.99),
    -- Order 85 (+84) [4 items]
    (@base_order_id + 84, 43, 1, 46.99), (@base_order_id + 84, 44, 1, 48.00), (@base_order_id + 84, 45, 1, 28.99), (@base_order_id + 84, 58, 1, 12.99),
    -- Order 86 (+85) [3 items]
    (@base_order_id + 85, 142, 1, 21.50), (@base_order_id + 85, 144, 1, 38.99), (@base_order_id + 85, 149, 1, 15.99),
    -- Order 87 (+86) [5 items]
    (@base_order_id + 86, 1, 1, 39.99), (@base_order_id + 86, 6, 1, 54.00), (@base_order_id + 86, 7, 1, 32.99), (@base_order_id + 86, 10, 1, 14.99), (@base_order_id + 86, 159, 1, 37.99),
    -- Order 88 (+87) [2 items]
    (@base_order_id + 87, 71, 1, 21.99), (@base_order_id + 87, 72, 1, 38.99),
    -- Order 89 (+88) [3 items]
    (@base_order_id + 88, 101, 1, 18.00), (@base_order_id + 88, 107, 1, 22.50), (@base_order_id + 88, 109, 1, 11.99),
    -- Order 90 (+89) [1 item]
    (@base_order_id + 89, 155, 1, 99.99),
    -- Order 91 (+90) [4 items]
    (@base_order_id + 90, 51, 1, 35.50), (@base_order_id + 90, 52, 1, 24.50), (@base_order_id + 90, 53, 1, 26.99), (@base_order_id + 90, 59, 1, 21.50),
    -- Order 92 (+91) [3 items]
    (@base_order_id + 91, 82, 1, 34.99), (@base_order_id + 91, 83, 1, 54.99), (@base_order_id + 91, 90, 1, 15.99),
    -- Order 93 (+92) [2 items]
    (@base_order_id + 92, 115, 1, 29.99), (@base_order_id + 92, 116, 1, 32.99),
    -- Order 94 (+93) [4 items]
    (@base_order_id + 93, 126, 1, 16.50), (@base_order_id + 93, 127, 1, 34.99), (@base_order_id + 93, 128, 1, 28.99), (@base_order_id + 93, 129, 1, 15.50),
    -- Order 95 (+94) [3 items]
    (@base_order_id + 94, 35, 1, 94.00), (@base_order_id + 94, 37, 1, 34.00), (@base_order_id + 94, 38, 1, 22.99),
    -- Order 96 (+95) [2 items]
    (@base_order_id + 95, 16, 1, 74.99), (@base_order_id + 95, 18, 1, 34.99),
    -- Order 97 (+96) [5 items]
    (@base_order_id + 96, 68, 1, 49.99), (@base_order_id + 96, 69, 1, 32.99), (@base_order_id + 96, 70, 1, 25.99), (@base_order_id + 96, 73, 1, 64.99), (@base_order_id + 96, 74, 1, 69.99),
    -- Order 98 (+97) [1 item]
    (@base_order_id + 97, 4, 1, 279.99),
    -- Order 99 (+98) [3 items]
    (@base_order_id + 98, 91, 1, 17.50), (@base_order_id + 98, 95, 1, 21.00), (@base_order_id + 98, 100, 1, 27.99),
    -- Order 100 (+99) [4 items]
    (@base_order_id + 99, 145, 1, 24.99), (@base_order_id + 99, 146, 1, 35.99), (@base_order_id + 99, 147, 1, 42.99), (@base_order_id + 99, 150, 1, 29.99),
    -- Order 101 (+100) [3 items]
    (@base_order_id + 100, 3, 1, 44.50), (@base_order_id + 100, 9, 1, 36.00), (@base_order_id + 100, 151, 1, 79.99),
    -- Order 102 (+101) [2 items]
    (@base_order_id + 101, 21, 1, 27.50), (@base_order_id + 101, 22, 1, 29.99),
    -- Order 103 (+102) [4 items]
    (@base_order_id + 102, 46, 1, 42.99), (@base_order_id + 102, 47, 1, 33.99), (@base_order_id + 102, 56, 1, 19.99), (@base_order_id + 102, 57, 1, 17.99),
    -- Order 104 (+103) [1 item]
    (@base_order_id + 103, 62, 1, 299.00),
    -- Order 105 (+104) [3 items]
    (@base_order_id + 104, 102, 1, 29.00), (@base_order_id + 104, 103, 1, 21.00), (@base_order_id + 104, 108, 1, 14.50),
    -- Order 106 (+105) [5 items]
    (@base_order_id + 105, 75, 1, 19.99), (@base_order_id + 105, 76, 1, 89.99), (@base_order_id + 105, 77, 1, 74.99), (@base_order_id + 105, 78, 1, 24.99), (@base_order_id + 105, 79, 1, 29.99),
    -- Order 107 (+106) [2 items]
    (@base_order_id + 106, 117, 1, 15.99), (@base_order_id + 106, 118, 1, 18.99),
    -- Order 108 (+107) [3 items]
    (@base_order_id + 107, 134, 1, 54.99), (@base_order_id + 107, 135, 1, 24.99), (@base_order_id + 107, 138, 1, 14.99),
    -- Order 109 (+108) [4 items]
    (@base_order_id + 108, 85, 1, 59.00), (@base_order_id + 108, 86, 1, 52.00), (@base_order_id + 108, 87, 1, 69.00), (@base_order_id + 108, 88, 1, 23.99),
    -- Order 110 (+109) [2 items]
    (@base_order_id + 109, 27, 1, 26.00), (@base_order_id + 109, 32, 1, 44.00),
    -- Order 111 (+110) [3 items]
    (@base_order_id + 110, 121, 1, 69.99), (@base_order_id + 110, 124, 1, 17.99), (@base_order_id + 110, 125, 1, 14.99),
    -- Order 112 (+111) [1 item]
    (@base_order_id + 111, 17, 1, 169.00),
    -- Order 113 (+112) [4 items]
    (@base_order_id + 112, 139, 1, 26.99), (@base_order_id + 112, 140, 1, 19.99), (@base_order_id + 112, 141, 1, 33.99), (@base_order_id + 112, 142, 1, 21.50),
    -- Order 114 (+113) [3 items]
    (@base_order_id + 113, 11, 1, 94.99), (@base_order_id + 113, 13, 1, 42.00), (@base_order_id + 113, 160, 1, 34.99),
    -- Order 115 (+114) [2 items]
    (@base_order_id + 114, 61, 1, 29.99), (@base_order_id + 114, 63, 1, 18.50),
    -- Order 116 (+115) [5 items]
    (@base_order_id + 115, 92, 1, 14.99), (@base_order_id + 115, 93, 1, 22.99), (@base_order_id + 115, 94, 1, 28.50), (@base_order_id + 115, 96, 1, 16.99), (@base_order_id + 115, 97, 1, 13.50),
    -- Order 117 (+116) [3 items]
    (@base_order_id + 116, 41, 1, 79.00), (@base_order_id + 116, 44, 1, 48.00), (@base_order_id + 116, 58, 1, 12.99),
    -- Order 118 (+117) [2 items]
    (@base_order_id + 117, 105, 1, 49.99), (@base_order_id + 117, 106, 1, 19.99),
    -- Order 119 (+118) [4 items]
    (@base_order_id + 118, 19, 1, 129.99), (@base_order_id + 118, 20, 1, 69.00), (@base_order_id + 118, 152, 1, 19.99), (@base_order_id + 118, 153, 1, 11.99),
    -- Order 120 (+119) [1 item]
    (@base_order_id + 119, 48, 1, 84.99),
    -- Order 121 (+120) [3 items]
    (@base_order_id + 120, 23, 1, 79.95), (@base_order_id + 120, 29, 1, 19.50), (@base_order_id + 120, 31, 1, 13.99),
    -- Order 122 (+121) [2 items]
    (@base_order_id + 121, 111, 1, 34.99), (@base_order_id + 121, 112, 1, 39.99),
    -- Order 123 (+122) [4 items]
    (@base_order_id + 122, 64, 1, 22.00), (@base_order_id + 122, 65, 1, 14.50), (@base_order_id + 122, 66, 1, 39.99), (@base_order_id + 122, 67, 1, 37.99),
    -- Order 124 (+123) [3 items]
    (@base_order_id + 123, 126, 1, 16.50), (@base_order_id + 123, 127, 1, 34.99), (@base_order_id + 123, 130, 1, 22.99),
    -- Order 125 (+124) [5 items]
    (@base_order_id + 124, 143, 1, 12.99), (@base_order_id + 124, 144, 1, 38.99), (@base_order_id + 124, 145, 1, 24.99), (@base_order_id + 124, 146, 1, 35.99), (@base_order_id + 124, 147, 1, 42.99),
    -- Order 126 (+125) [2 items]
    (@base_order_id + 125, 1, 1, 39.99), (@base_order_id + 125, 2, 1, 89.00),
    -- Order 127 (+126) [3 items]
    (@base_order_id + 126, 52, 1, 24.50), (@base_order_id + 126, 54, 1, 129.00), (@base_order_id + 126, 60, 1, 44.99),
    -- Order 128 (+127) [1 item]
    (@base_order_id + 127, 5, 1, 149.95),
    -- Order 129 (+128) [4 items]
    (@base_order_id + 128, 81, 1, 39.99), (@base_order_id + 128, 82, 1, 34.99), (@base_order_id + 128, 83, 1, 54.99), (@base_order_id + 128, 89, 1, 16.50),
    -- Order 130 (+129) [3 items]
    (@base_order_id + 129, 33, 1, 16.99), (@base_order_id + 129, 36, 1, 15.99), (@base_order_id + 129, 39, 1, 23.50),
    -- Order 131 (+130) [2 items]
    (@base_order_id + 130, 131, 1, 44.99), (@base_order_id + 130, 132, 1, 18.99),
    -- Order 132 (+131) [4 items]
    (@base_order_id + 131, 68, 1, 49.99), (@base_order_id + 131, 69, 1, 32.99), (@base_order_id + 131, 70, 1, 25.99), (@base_order_id + 131, 71, 1, 21.99),
    -- Order 133 (+132) [3 items]
    (@base_order_id + 132, 101, 1, 18.00), (@base_order_id + 132, 102, 1, 29.00), (@base_order_id + 132, 107, 1, 22.50),
    -- Order 134 (+133) [2 items]
    (@base_order_id + 133, 14, 1, 59.99), (@base_order_id + 133, 15, 1, 79.00),
    -- Order 135 (+134) [5 items]
    (@base_order_id + 134, 113, 1, 27.99), (@base_order_id + 134, 114, 1, 44.99), (@base_order_id + 134, 115, 1, 29.99), (@base_order_id + 134, 116, 1, 32.99), (@base_order_id + 134, 120, 1, 9.99),
    -- Order 136 (+135) [1 item]
    (@base_order_id + 135, 30, 1, 89.99),
    -- Order 137 (+136) [3 items]
    (@base_order_id + 136, 42, 1, 64.99), (@base_order_id + 136, 43, 1, 46.99), (@base_order_id + 136, 45, 1, 28.99),
    -- Order 138 (+137) [4 items]
    (@base_order_id + 137, 94, 1, 28.50), (@base_order_id + 137, 95, 1, 21.00), (@base_order_id + 137, 98, 1, 34.99), (@base_order_id + 137, 99, 1, 26.99),
    -- Order 139 (+138) [2 items]
    (@base_order_id + 138, 122, 1, 36.99), (@base_order_id + 138, 128, 1, 28.99),
    -- Order 140 (+139) [3 items]
    (@base_order_id + 139, 148, 1, 17.99), (@base_order_id + 139, 149, 1, 15.99), (@base_order_id + 139, 150, 1, 29.99),
    -- Order 141 (+140) [4 items]
    (@base_order_id + 140, 6, 1, 54.00), (@base_order_id + 140, 7, 1, 32.99), (@base_order_id + 140, 8, 1, 24.99), (@base_order_id + 140, 10, 1, 14.99),
    -- Order 142 (+141) [3 items]
    (@base_order_id + 141, 24, 1, 45.00), (@base_order_id + 141, 25, 1, 31.99), (@base_order_id + 141, 26, 1, 38.50),
    -- Order 143 (+142) [2 items]
    (@base_order_id + 142, 72, 1, 38.99), (@base_order_id + 142, 73, 1, 64.99),
    -- Order 144 (+143) [1 item]
    (@base_order_id + 143, 155, 1, 99.99),
    -- Order 145 (+144) [5 items]
    (@base_order_id + 144, 51, 1, 35.50), (@base_order_id + 144, 53, 1, 26.99), (@base_order_id + 144, 55, 1, 39.95), (@base_order_id + 144, 56, 1, 19.99), (@base_order_id + 144, 57, 1, 17.99),
    -- Order 146 (+145) [3 items]
    (@base_order_id + 145, 84, 1, 28.00), (@base_order_id + 145, 86, 1, 52.00), (@base_order_id + 145, 90, 1, 15.99),
    -- Order 147 (+146) [2 items]
    (@base_order_id + 146, 103, 1, 21.00), (@base_order_id + 146, 104, 1, 16.99),
    -- Order 148 (+147) [4 items]
    (@base_order_id + 147, 133, 1, 39.99), (@base_order_id + 147, 134, 1, 54.99), (@base_order_id + 147, 136, 1, 36.99), (@base_order_id + 147, 137, 1, 21.99),
    -- Order 149 (+148) [3 items]
    (@base_order_id + 148, 34, 1, 52.99), (@base_order_id + 148, 35, 1, 94.00), (@base_order_id + 148, 40, 1, 119.00),
    -- Order 150 (+149) [2 items]
    (@base_order_id + 149, 117, 1, 15.99), (@base_order_id + 149, 119, 1, 47.99),
    -- Order 151 (+150) [4 items]
    (@base_order_id + 150, 3, 1, 44.50), (@base_order_id + 150, 11, 1, 94.99), (@base_order_id + 150, 12, 1, 49.50), (@base_order_id + 150, 13, 1, 42.00),
    -- Order 152 (+151) [1 item]
    (@base_order_id + 151, 49, 1, 159.99),
    -- Order 153 (+152) [3 items]
    (@base_order_id + 152, 61, 1, 29.99), (@base_order_id + 152, 63, 1, 18.50), (@base_order_id + 152, 65, 1, 14.50),
    -- Order 154 (+153) [5 items]
    (@base_order_id + 153, 91, 1, 17.50), (@base_order_id + 153, 92, 1, 14.99), (@base_order_id + 153, 96, 1, 16.99), (@base_order_id + 153, 97, 1, 13.50), (@base_order_id + 153, 100, 1, 27.99),
    -- Order 155 (+154) [2 items]
    (@base_order_id + 154, 121, 1, 69.99), (@base_order_id + 154, 123, 1, 25.99),
    -- Order 156 (+155) [3 items]
    (@base_order_id + 155, 141, 1, 33.99), (@base_order_id + 155, 142, 1, 21.50), (@base_order_id + 155, 144, 1, 38.99),
    -- Order 157 (+156) [4 items]
    (@base_order_id + 156, 21, 1, 27.50), (@base_order_id + 156, 22, 1, 29.99), (@base_order_id + 156, 23, 1, 79.95), (@base_order_id + 156, 27, 1, 26.00),
    -- Order 158 (+157) [3 items]
    (@base_order_id + 157, 46, 1, 42.99), (@base_order_id + 157, 47, 1, 33.99), (@base_order_id + 157, 58, 1, 12.99),
    -- Order 159 (+158) [2 items]
    (@base_order_id + 158, 74, 1, 69.99), (@base_order_id + 158, 75, 1, 19.99),
    -- Order 160 (+159) [4 items]
    (@base_order_id + 159, 105, 1, 49.99), (@base_order_id + 159, 106, 1, 19.99), (@base_order_id + 159, 108, 1, 14.50), (@base_order_id + 159, 110, 1, 13.99),
    -- Order 161 (+160) [1 item]
    (@base_order_id + 160, 4, 1, 279.99),
    -- Order 162 (+161) [3 items]
    (@base_order_id + 161, 85, 1, 59.00), (@base_order_id + 161, 87, 1, 69.00), (@base_order_id + 161, 89, 1, 16.50),
    -- Order 163 (+162) [5 items]
    (@base_order_id + 162, 111, 1, 34.99), (@base_order_id + 162, 112, 1, 39.99), (@base_order_id + 162, 115, 1, 29.99), (@base_order_id + 162, 118, 1, 18.99), (@base_order_id + 162, 120, 1, 9.99),
    -- Order 164 (+163) [2 items]
    (@base_order_id + 163, 126, 1, 16.50), (@base_order_id + 163, 129, 1, 15.50),
    -- Order 165 (+164) [3 items]
    (@base_order_id + 164, 132, 1, 18.99), (@base_order_id + 164, 138, 1, 14.99), (@base_order_id + 164, 154, 1, 23.99),
    -- Order 166 (+165) [4 items]
    (@base_order_id + 165, 28, 1, 18.99), (@base_order_id + 165, 29, 1, 19.50), (@base_order_id + 165, 31, 1, 13.99), (@base_order_id + 165, 32, 1, 44.00),
    -- Order 167 (+166) [3 items]
    (@base_order_id + 166, 64, 1, 22.00), (@base_order_id + 166, 66, 1, 39.99), (@base_order_id + 166, 67, 1, 37.99),
    -- Order 168 (+167) [2 items]
    (@base_order_id + 167, 145, 1, 24.99), (@base_order_id + 167, 148, 1, 17.99),
    -- Order 169 (+168) [4 items]
    (@base_order_id + 168, 1, 1, 39.99), (@base_order_id + 168, 9, 1, 36.00), (@base_order_id + 168, 16, 1, 74.99), (@base_order_id + 168, 18, 1, 34.99),
    -- Order 170 (+169) [1 item]
    (@base_order_id + 169, 62, 1, 299.00),
    -- Order 171 (+170) [3 items]
    (@base_order_id + 170, 41, 1, 79.00), (@base_order_id + 170, 42, 1, 64.99), (@base_order_id + 170, 43, 1, 46.99),
    -- Order 172 (+171) [5 items]
    (@base_order_id + 171, 76, 1, 89.99), (@base_order_id + 171, 77, 1, 74.99), (@base_order_id + 171, 78, 1, 24.99), (@base_order_id + 171, 79, 1, 29.99), (@base_order_id + 171, 80, 1, 12.50),
    -- Order 173 (+172) [2 items]
    (@base_order_id + 172, 93, 1, 22.99), (@base_order_id + 172, 94, 1, 28.50),
    -- Order 174 (+173) [3 items]
    (@base_order_id + 173, 101, 1, 18.00), (@base_order_id + 173, 107, 1, 22.50), (@base_order_id + 173, 109, 1, 11.99),
    -- Order 175 (+174) [4 items]
    (@base_order_id + 174, 122, 1, 36.99), (@base_order_id + 174, 124, 1, 17.99), (@base_order_id + 174, 125, 1, 14.99), (@base_order_id + 174, 127, 1, 34.99),
    -- Order 176 (+175) [3 items]
    (@base_order_id + 175, 2, 1, 89.00), (@base_order_id + 175, 8, 1, 24.99), (@base_order_id + 175, 156, 1, 24.99),
    -- Order 177 (+176) [2 items]
    (@base_order_id + 176, 50, 1, 57.99), (@base_order_id + 176, 59, 1, 21.50),
    -- Order 178 (+177) [4 items]
    (@base_order_id + 177, 33, 1, 16.99), (@base_order_id + 177, 36, 1, 15.99), (@base_order_id + 177, 37, 1, 34.00), (@base_order_id + 177, 38, 1, 22.99),
    -- Order 179 (+178) [1 item]
    (@base_order_id + 178, 17, 1, 169.00),
    -- Order 180 (+179) [3 items]
    (@base_order_id + 179, 68, 1, 49.99), (@base_order_id + 179, 69, 1, 32.99), (@base_order_id + 179, 70, 1, 25.99),
    -- Order 181 (+180) [5 items]
    (@base_order_id + 180, 113, 1, 27.99), (@base_order_id + 180, 114, 1, 44.99), (@base_order_id + 180, 116, 1, 32.99), (@base_order_id + 180, 117, 1, 15.99), (@base_order_id + 180, 119, 1, 47.99),
    -- Order 182 (+181) [2 items]
    (@base_order_id + 181, 139, 1, 26.99), (@base_order_id + 181, 140, 1, 19.99),
    -- Order 183 (+182) [3 items]
    (@base_order_id + 182, 81, 1, 39.99), (@base_order_id + 182, 84, 1, 28.00), (@base_order_id + 182, 88, 1, 23.99),
    -- Order 184 (+183) [4 items]
    (@base_order_id + 183, 131, 1, 44.99), (@base_order_id + 183, 133, 1, 39.99), (@base_order_id + 183, 134, 1, 54.99), (@base_order_id + 183, 135, 1, 24.99),
    -- Order 185 (+184) [3 items]
    (@base_order_id + 184, 24, 1, 45.00), (@base_order_id + 184, 26, 1, 38.50), (@base_order_id + 184, 157, 1, 31.99),
    -- Order 186 (+185) [2 items]
    (@base_order_id + 185, 44, 1, 48.00), (@base_order_id + 185, 45, 1, 28.99),
    -- Order 187 (+186) [4 items]
    (@base_order_id + 186, 61, 1, 29.99), (@base_order_id + 186, 63, 1, 18.50), (@base_order_id + 186, 64, 1, 22.00), (@base_order_id + 186, 65, 1, 14.50),
    -- Order 188 (+187) [1 item]
    (@base_order_id + 187, 5, 1, 149.95),
    -- Order 189 (+188) [3 items]
    (@base_order_id + 188, 95, 1, 21.00), (@base_order_id + 188, 98, 1, 34.99), (@base_order_id + 188, 99, 1, 26.99),
    -- Order 190 (+189) [5 items]
    (@base_order_id + 189, 146, 1, 35.99), (@base_order_id + 190, 147, 1, 42.99), (@base_order_id + 190, 149, 1, 15.99), (@base_order_id + 190, 150, 1, 29.99), (@base_order_id + 190, 158, 1, 14.50),
    -- Order 191 (+190) [2 items]
    (@base_order_id + 190, 102, 1, 29.00), (@base_order_id + 190, 103, 1, 21.00),
    -- Order 192 (+191) [3 items]
    (@base_order_id + 191, 11, 1, 94.99), (@base_order_id + 191, 14, 1, 59.99), (@base_order_id + 191, 15, 1, 79.00),
    -- Order 193 (+192) [4 items]
    (@base_order_id + 192, 51, 1, 35.50), (@base_order_id + 192, 52, 1, 24.50), (@base_order_id + 192, 53, 1, 26.99), (@base_order_id + 192, 54, 1, 129.00),
    -- Order 194 (+193) [3 items]
    (@base_order_id + 193, 71, 1, 21.99), (@base_order_id + 193, 72, 1, 38.99), (@base_order_id + 193, 73, 1, 64.99),
    -- Order 195 (+194) [2 items]
    (@base_order_id + 194, 121, 1, 69.99), (@base_order_id + 194, 128, 1, 28.99),
    -- Order 196 (+195) [4 items]
    (@base_order_id + 195, 35, 1, 94.00), (@base_order_id + 195, 39, 1, 23.50), (@base_order_id + 195, 40, 1, 119.00), (@base_order_id + 195, 159, 1, 37.99),
    -- Order 197 (+196) [1 item]
    (@base_order_id + 196, 30, 1, 89.99),
    -- Order 198 (+197) [3 items]
    (@base_order_id + 197, 82, 1, 34.99), (@base_order_id + 197, 83, 1, 54.99), (@base_order_id + 197, 86, 1, 52.00),
    -- Order 199 (+198) [5 items]
    (@base_order_id + 198, 104, 1, 16.99), (@base_order_id + 198, 105, 1, 49.99), (@base_order_id + 198, 106, 1, 19.99), (@base_order_id + 198, 108, 1, 14.50), (@base_order_id + 198, 110, 1, 13.99),
    -- Order 200 (+199) [2 items]
    (@base_order_id + 199, 136, 1, 36.99), (@base_order_id + 199, 137, 1, 21.99),
    -- Order 201 (+200) [3 items]
    (@base_order_id + 200, 1, 1, 39.99), (@base_order_id + 200, 3, 1, 44.50), (@base_order_id + 200, 10, 1, 14.99),
    -- Order 202 (+201) [4 items]
    (@base_order_id + 201, 21, 1, 27.50), (@base_order_id + 201, 22, 1, 29.99), (@base_order_id + 201, 25, 1, 31.99), (@base_order_id + 201, 27, 1, 26.00),
    -- Order 203 (+202) [2 items]
    (@base_order_id + 202, 42, 1, 64.99), (@base_order_id + 202, 43, 1, 46.99),
    -- Order 204 (+203) [3 items]
    (@base_order_id + 203, 74, 1, 69.99), (@base_order_id + 203, 75, 1, 19.99), (@base_order_id + 203, 76, 1, 89.99),
    -- Order 205 (+204) [1 item]
    (@base_order_id + 204, 48, 1, 84.99),
    -- Order 206 (+205) [4 items]
    (@base_order_id + 205, 91, 1, 17.50), (@base_order_id + 205, 92, 1, 14.99), (@base_order_id + 205, 93, 1, 22.99), (@base_order_id + 205, 97, 1, 13.50),
    -- Order 207 (+206) [3 items]
    (@base_order_id + 206, 111, 1, 34.99), (@base_order_id + 206, 112, 1, 39.99), (@base_order_id + 206, 120, 1, 9.99),
    -- Order 208 (+207) [5 items]
    (@base_order_id + 207, 122, 1, 36.99), (@base_order_id + 207, 123, 1, 25.99), (@base_order_id + 207, 124, 1, 17.99), (@base_order_id + 207, 125, 1, 14.99), (@base_order_id + 207, 129, 1, 15.50),
    -- Order 209 (+208) [2 items]
    (@base_order_id + 208, 141, 1, 33.99), (@base_order_id + 208, 143, 1, 12.99),
    -- Order 210 (+209) [3 items]
    (@base_order_id + 209, 6, 1, 54.00), (@base_order_id + 209, 7, 1, 32.99), (@base_order_id + 209, 9, 1, 36.00),
    -- Order 211 (+210) [4 items]
    (@base_order_id + 210, 28, 1, 18.99), (@base_order_id + 210, 29, 1, 19.50), (@base_order_id + 210, 31, 1, 13.99), (@base_order_id + 210, 34, 1, 52.99),
    -- Order 212 (+211) [1 item]
    (@base_order_id + 211, 4, 1, 279.99),
    -- Order 213 (+212) [3 items]
    (@base_order_id + 212, 55, 1, 39.95), (@base_order_id + 212, 56, 1, 19.99), (@base_order_id + 212, 57, 1, 17.99),
    -- Order 214 (+213) [2 items]
    (@base_order_id + 213, 66, 1, 39.99), (@base_order_id + 213, 67, 1, 37.99),
    -- Order 215 (+214) [4 items]
    (@base_order_id + 214, 87, 1, 69.00), (@base_order_id + 214, 88, 1, 23.99), (@base_order_id + 214, 89, 1, 16.50), (@base_order_id + 214, 90, 1, 15.99),
    -- Order 216 (+215) [3 items]
    (@base_order_id + 215, 101, 1, 18.00), (@base_order_id + 215, 107, 1, 22.50), (@base_order_id + 215, 109, 1, 11.99),
    -- Order 217 (+216) [5 items]
    (@base_order_id + 216, 113, 1, 27.99), (@base_order_id + 216, 114, 1, 44.99), (@base_order_id + 216, 115, 1, 29.99), (@base_order_id + 216, 116, 1, 32.99), (@base_order_id + 216, 118, 1, 18.99),
    -- Order 218 (+217) [2 items]
    (@base_order_id + 217, 132, 1, 18.99), (@base_order_id + 217, 138, 1, 14.99),
    -- Order 219 (+218) [3 items]
    (@base_order_id + 218, 142, 1, 21.50), (@base_order_id + 218, 144, 1, 38.99), (@base_order_id + 218, 148, 1, 17.99),
    -- Order 220 (+219) [4 items]
    (@base_order_id + 219, 12, 1, 49.50), (@base_order_id + 219, 13, 1, 42.00), (@base_order_id + 219, 19, 1, 129.99), (@base_order_id + 219, 20, 1, 69.00),
    -- Order 221 (+220) [1 item]
    (@base_order_id + 220, 62, 1, 299.00),
    -- Order 222 (+221) [3 items]
    (@base_order_id + 221, 32, 1, 44.00), (@base_order_id + 221, 33, 1, 16.99), (@base_order_id + 221, 36, 1, 15.99),
    -- Order 223 (+222) [2 items]
    (@base_order_id + 222, 46, 1, 42.99), (@base_order_id + 222, 47, 1, 33.99),
    -- Order 224 (+223) [4 items]
    (@base_order_id + 223, 68, 1, 49.99), (@base_order_id + 223, 69, 1, 32.99), (@base_order_id + 223, 70, 1, 25.99), (@base_order_id + 223, 71, 1, 21.99),
    -- Order 225 (+224) [3 items]
    (@base_order_id + 224, 94, 1, 28.50), (@base_order_id + 224, 95, 1, 21.00), (@base_order_id + 224, 98, 1, 34.99),
    -- Order 226 (+225) [5 items]
    (@base_order_id + 225, 126, 1, 16.50), (@base_order_id + 225, 127, 1, 34.99), (@base_order_id + 225, 128, 1, 28.99), (@base_order_id + 225, 130, 1, 22.99), (@base_order_id + 225, 160, 1, 34.99),
    -- Order 227 (+226) [2 items]
    (@base_order_id + 226, 133, 1, 39.99), (@base_order_id + 226, 134, 1, 54.99),
    -- Order 228 (+227) [3 items]
    (@base_order_id + 227, 145, 1, 24.99), (@base_order_id + 227, 146, 1, 35.99), (@base_order_id + 227, 147, 1, 42.99),
    -- Order 229 (+228) [4 items]
    (@base_order_id + 228, 2, 1, 89.00), (@base_order_id + 228, 8, 1, 24.99), (@base_order_id + 228, 16, 1, 74.99), (@base_order_id + 228, 18, 1, 34.99),
    -- Order 230 (+229) [1 item]
    (@base_order_id + 229, 49, 1, 159.99),
    -- Order 231 (+230) [3 items]
    (@base_order_id + 230, 23, 1, 79.95), (@base_order_id + 230, 24, 1, 45.00), (@base_order_id + 230, 37, 1, 34.00),
    -- Order 232 (+231) [2 items]
    (@base_order_id + 231, 51, 1, 35.50), (@base_order_id + 231, 58, 1, 12.99),
    -- Order 233 (+232) [4 items]
    (@base_order_id + 232, 61, 1, 29.99), (@base_order_id + 232, 63, 1, 18.50), (@base_order_id + 232, 64, 1, 22.00), (@base_order_id + 232, 65, 1, 14.50),
    -- Order 234 (+233) [3 items]
    (@base_order_id + 233, 77, 1, 74.99), (@base_order_id + 233, 78, 1, 24.99), (@base_order_id + 233, 79, 1, 29.99),
    -- Order 235 (+234) [5 items]
    (@base_order_id + 234, 99, 1, 26.99), (@base_order_id + 234, 100, 1, 27.99), (@base_order_id + 234, 102, 1, 29.00), (@base_order_id + 234, 103, 1, 21.00), (@base_order_id + 234, 104, 1, 16.99),
    -- Order 236 (+235) [2 items]
    (@base_order_id + 235, 117, 1, 15.99), (@base_order_id + 235, 119, 1, 47.99),
    -- Order 237 (+236) [3 items]
    (@base_order_id + 236, 135, 1, 24.99), (@base_order_id + 236, 136, 1, 36.99), (@base_order_id + 236, 137, 1, 21.99),
    -- Order 238 (+237) [4 items]
    (@base_order_id + 237, 149, 1, 15.99), (@base_order_id + 237, 150, 1, 29.99), (@base_order_id + 237, 151, 1, 79.99), (@base_order_id + 237, 152, 1, 19.99),
    -- Order 239 (+238) [1 item]
    (@base_order_id + 238, 17, 1, 169.00),
    -- Order 240 (+239) [3 items]
    (@base_order_id + 239, 35, 1, 94.00), (@base_order_id + 239, 38, 1, 22.99), (@base_order_id + 239, 39, 1, 23.50),
    -- Order 241 (+240) [2 items]
    (@base_order_id + 240, 41, 1, 79.00), (@base_order_id + 240, 44, 1, 48.00),
    -- Order 242 (+241) [4 items]
    (@base_order_id + 241, 52, 1, 24.50), (@base_order_id + 241, 53, 1, 26.99), (@base_order_id + 241, 54, 1, 129.00), (@base_order_id + 241, 59, 1, 21.50),
    -- Order 243 (+242) [3 items]
    (@base_order_id + 242, 81, 1, 39.99), (@base_order_id + 242, 82, 1, 34.99), (@base_order_id + 242, 83, 1, 54.99),
    -- Order 244 (+243) [5 items]
    (@base_order_id + 243, 105, 1, 49.99), (@base_order_id + 243, 106, 1, 19.99), (@base_order_id + 243, 108, 1, 14.50), (@base_order_id + 243, 110, 1, 13.99), (@base_order_id + 243, 153, 1, 11.99),
    -- Order 245 (+244) [2 items]
    (@base_order_id + 244, 121, 1, 69.99), (@base_order_id + 244, 122, 1, 36.99),
    -- Order 246 (+245) [3 items]
    (@base_order_id + 245, 139, 1, 26.99), (@base_order_id + 245, 140, 1, 19.99), (@base_order_id + 245, 154, 1, 23.99),
    -- Order 247 (+246) [4 items]
    (@base_order_id + 246, 1, 1, 39.99), (@base_order_id + 246, 11, 1, 94.99), (@base_order_id + 246, 155, 1, 99.99), (@base_order_id + 246, 156, 1, 24.99),
    -- Order 248 (+247) [2 items]
    (@base_order_id + 247, 72, 1, 38.99), (@base_order_id + 247, 73, 1, 64.99),
    -- Order 249 (+248) [3 items]
    (@base_order_id + 248, 84, 1, 28.00), (@base_order_id + 248, 85, 1, 59.00), (@base_order_id + 248, 157, 1, 31.99),
    -- Order 250 (+249) [4 items]
    (@base_order_id + 249, 141, 1, 33.99), (@base_order_id + 249, 142, 1, 21.50), (@base_order_id + 249, 144, 1, 38.99), (@base_order_id + 249, 158, 1, 14.50);

-- Recalculate total_amount for all newly inserted orders from their order_items
UPDATE ORDERS o
JOIN (
    SELECT order_id, ROUND(SUM(quantity * unit_price), 2) AS calculated_total
    FROM ORDER_ITEMS
    WHERE order_id BETWEEN @base_order_id AND @base_order_id + 249
    GROUP BY order_id
) t ON o.order_id = t.order_id
SET o.total_amount = t.calculated_total;


-- commit data-load transaction
COMMIT;
