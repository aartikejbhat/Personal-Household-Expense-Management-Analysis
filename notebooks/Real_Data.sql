--------- CREATE TABLE ------------

CREATE TABLE expense_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE expense_subcategories (
    subcategory_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL,
    subcategory_name VARCHAR(100) NOT NULL UNIQUE,

    FOREIGN KEY (category_id)
        REFERENCES expense_categories(category_id)
		
);

CREATE TABLE family_members (
    member_id SERIAL PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL
);

CREATE TABLE payment_methods (
    payment_method_id SERIAL PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE vendors (
    vendor_id SERIAL PRIMARY KEY,
    vendor_name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE expenses (
    expense_id SERIAL PRIMARY KEY,
    expense_date DATE NOT NULL,
    subcategory_id INTEGER NOT NULL,
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    member_id INTEGER NOT NULL,
    vendor_id INTEGER,
    payment_method_id INTEGER NOT NULL,
    description TEXT,
    recurring BOOLEAN NOT NULL DEFAULT FALSE,
    status VARCHAR(20) NOT NULL DEFAULT 'Paid',

    FOREIGN KEY (subcategory_id)
        REFERENCES expense_subcategories(subcategory_id),

    FOREIGN KEY (member_id)
        REFERENCES family_members(member_id),

    FOREIGN KEY (vendor_id)
        REFERENCES vendors(vendor_id),

    FOREIGN KEY (payment_method_id)
        REFERENCES payment_methods(payment_method_id),

    CHECK (status IN ('Paid', 'Pending'))
);

SELECT * FROM expense_categories;
SELECT * FROM expense_subcategories;
SELECT * FROM family_members;
SELECT * FROM payment_methods;
SELECT * FROM vendors;
SELECT * FROM expenses;

------------- INSERT DATA ------------

--- Expense Category ----

INSERT INTO expense_categories (category_name)
VALUES
('Farming'),
('Health'),
('Livestock'),
('Grocery'),
('Transportation'),
('Personal'),
('Personal Care'),
('Utilities'),
('Food'),
('Housing'),
('Other'),
('Pooja Item'),
('Education'),
('Household');

--- Expenses Subcategory ----

INSERT INTO expense_subcategories (category_id, subcategory_name)
VALUES
(1, 'Fertilizer & Seeds'),
(1, 'Tractor'),
(1, 'Fertilizer'),
(1, 'Pesticides'),

(2, 'Medical'),

(3, 'Animal Medical'),
(3, 'Animal Feed'),

(4, 'Kirana'),

(5, 'Petrol'),
(5, 'Bus'),

(6, 'Clothing'),

(7, 'Salon'),

(8, 'Gas'),
(8, 'Mobile Recharge'),

(9, 'Mess'),

(10, 'Room Rent'),

(11, 'Extra Expense'),

(12, 'Pooja Item'),

(13, 'Class Fees'),
(13, 'College Fees'),
(13, 'Stationery'),

(14, 'Other');

--- family_members ----

INSERT INTO family_members (member_name)
VALUES
('Father'),
('Mother'),
('Daughter'),
('Brother 1'),
('Brother 2');

SELECT * 
FROM family_members;

-------- Payment Method ---------

INSERT INTO payment_methods (method_name)
VALUES
('Cash'),
('UPI'),
('Net Banking'),
('Bank Transfer');

SELECT *
FROM payment_methods;

----- Vendors Data Insert ----

INSERT INTO vendors (vendor_name)
VALUES
('Shree Krushi Seva Kendra'),
('Tractor Rental Service'),
('Local Neurosurgery Clinic'),
('Veterinary Doctor / Veterinary Clinic'),
('Sai Animal Food Supplier'),
('Local Kirana Store'),
('Local Petrol Pump'),
('Sai Clothing Store'),
('Local Salon'),
('City Bus'),
('Indian Gas Agency'),
('Mobile Recharge Service'),
('Vedika Mess'),
('Room Owner'),
('Other / Local Store'),
('Local Pooja Store'),
('AIGinius'),
('College / University'),
('Local Store'),
('Local Stationery Store'),
('Deogiri College');

SELECT * FROM vendors;

--------- Expeneses --------

--- June ----

INSERT INTO expenses
(expense_date, subcategory_id, amount, member_id, vendor_id,
 payment_method_id, description, recurring, status)
VALUES

('2026-06-03',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Fertilizer & Seeds'),
 18000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Shree Krushi Seva Kendra'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Fertilizer and seeds', TRUE, 'Paid'),

('2026-06-05',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Tractor'),
 15000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Tractor Rental Service'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Tractor rent', FALSE, 'Paid'),

('2026-06-08',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Medical'),
 6666.60,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Neurosurgery Clinic'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Medical treatment', TRUE, 'Paid'),

('2026-06-09',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Animal Medical'),
 15000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Veterinary Doctor / Veterinary Clinic'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Animal medical', TRUE, 'Paid'),

('2026-06-12',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Animal Feed'),
 10000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Sai Animal Food Supplier'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Animal feed', TRUE, 'Paid'),

('2026-06-15',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Kirana'),
 4000,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Kirana Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Household groceries', TRUE, 'Paid'),

('2026-06-04',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Petrol'),
 3000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Petrol Pump'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Petrol for vehicle', TRUE, 'Paid'),

('2026-06-28',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Clothing'),
 5000,
 (SELECT member_id FROM family_members WHERE member_name='Brother 1'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Sai Clothing Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Clothes for Brother 1', FALSE, 'Paid'),

('2026-06-10',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Salon'),
 150,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Salon'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Salon expense', TRUE, 'Paid'),

('2026-06-25',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Pesticides'),
 4000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Shree Krushi Seva Kendra'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Pesticides', TRUE, 'Paid'),

('2026-06-01',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Bus'),
 3000,
 (SELECT member_id FROM family_members WHERE member_name='Brother 1'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='City Bus'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Bus travel', TRUE, 'Paid'),

('2026-06-01',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Gas'),
 1500,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Indian Gas Agency'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'LPG cylinder', FALSE, 'Paid'),

('2026-06-02',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Mobile Recharge'),
 3300,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Mobile Recharge Service'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Net Banking'),
 'Multiple recharges', TRUE, 'Paid'),

('2026-06-20',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Mess'),
 2000,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Vedika Mess'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Mess food', TRUE, 'Paid'),

('2026-06-20',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Room Rent'),
 2500,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Room Owner'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Monthly room rent', TRUE, 'Paid'),

('2026-06-20',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Extra Expense'),
 1500,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Other / Local Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Other expense', TRUE, 'Paid');

------ July ------

INSERT INTO expenses
(expense_date, subcategory_id, amount, member_id, vendor_id,
 payment_method_id, description, recurring, status)
VALUES

('2026-07-02',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Fertilizer'),
 5000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Shree Krushi Seva Kendra'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Fertilizer', TRUE, 'Paid'),

('2026-07-07',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Medical'),
 6666.60,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Neurosurgery Clinic'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Medical treatment', TRUE, 'Paid'),

('2026-07-09',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Animal Medical'),
 1000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Veterinary Doctor / Veterinary Clinic'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Animal medical', FALSE, 'Paid'),

('2026-07-11',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Animal Feed'),
 10000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Sai Animal Food Supplier'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Animal feed', TRUE, 'Paid'),

('2026-07-12',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Kirana'),
 5000,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Kirana Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Household groceries', TRUE, 'Paid'),

('2026-07-14',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Petrol'),
 3000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Petrol Pump'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Petrol', TRUE, 'Paid'),

('2026-07-15',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Pooja Item'),
 500,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Pooja Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Pooja items', FALSE, 'Paid'),

('2026-07-17',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Pesticides'),
 6000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Shree Krushi Seva Kendra'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Pesticides', FALSE, 'Paid'),

('2026-07-18',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Bus'),
 3000,
 (SELECT member_id FROM family_members WHERE member_name='Brother 1'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='City Bus'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Bus travel', TRUE, 'Paid'),

('2026-07-19',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Mobile Recharge'),
 3300,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Mobile Recharge Service'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Net Banking'),
 'Multiple recharges', TRUE, 'Paid'),

('2026-07-09',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Class Fees'),
 20000,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='AIGinius'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Class fees', TRUE, 'Paid'),

('2026-07-21',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Other'),
 2500,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Household expense', FALSE, 'Paid'),

('2026-07-22',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Extra Expense'),
 1000,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Other / Local Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Other expense', FALSE, 'Paid'),

('2026-07-23',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Salon'),
 150,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Salon'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Salon expense', TRUE, 'Paid'),

('2026-07-26',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Mess'),
 2000,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Vedika Mess'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Mess food', TRUE, 'Paid'),

('2026-07-27',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Room Rent'),
 2500,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Room Owner'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Monthly room rent', TRUE, 'Paid'),

('2026-07-28',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='College Fees'),
 3000,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='College / University'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'College fees', TRUE, 'Paid');

------- August --------

INSERT INTO expenses
(expense_date, subcategory_id, amount, member_id, vendor_id,
 payment_method_id, description, recurring, status)
VALUES

('2026-08-02',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Fertilizer'),
 4000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Shree Krushi Seva Kendra'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Fertilizer', TRUE, 'Paid'),

('2026-08-04',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Medical'),
 6666.60,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Neurosurgery Clinic'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Medical treatment', TRUE, 'Paid'),

('2026-08-06',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Animal Medical'),
 100,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Veterinary Doctor / Veterinary Clinic'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Animal medical', FALSE, 'Paid'),

('2026-08-08',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Animal Feed'),
 10000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Sai Animal Food Supplier'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Animal feed', TRUE, 'Paid'),

('2026-08-09',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Kirana'),
 6000,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Kirana Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Household groceries', TRUE, 'Paid'),

('2026-08-11',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Petrol'),
 3000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Petrol Pump'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Petrol', TRUE, 'Paid'),

('2026-08-13',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Pooja Item'),
 100,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Pooja Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Pooja items', FALSE, 'Paid'),

('2026-08-15',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Pesticides'),
 1000,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Shree Krushi Seva Kendra'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Pesticides', FALSE, 'Paid'),

('2026-08-17',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Bus'),
 3000,
 (SELECT member_id FROM family_members WHERE member_name='Brother 1'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='City Bus'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Bus travel', TRUE, 'Paid'),

('2026-08-18',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Mobile Recharge'),
 3300,
 (SELECT member_id FROM family_members WHERE member_name='Father'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Mobile Recharge Service'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Net Banking'),
 'Multiple recharges', TRUE, 'Paid'),

('2026-08-19',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Stationery'),
 500,
 (SELECT member_id FROM family_members WHERE member_name='Brother 1'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Stationery Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Stationery', FALSE, 'Paid'),

('2026-08-21',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Other'),
 1000,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Household expense', FALSE, 'Paid'),

('2026-08-22',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Extra Expense'),
 2000,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Other / Local Store'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Other expense', FALSE, 'Paid'),

('2026-08-23',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Salon'),
 150,
 (SELECT member_id FROM family_members WHERE member_name='Mother'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Local Salon'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='Cash'),
 'Salon expense', TRUE, 'Paid'),

('2026-08-26',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Mess'),
 2000,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Vedika Mess'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Mess food', TRUE, 'Paid'),

('2026-08-27',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='Room Rent'),
 2500,
 (SELECT member_id FROM family_members WHERE member_name='Daughter'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Room Owner'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'Monthly room rent', TRUE, 'Paid'),

('2026-08-28',
 (SELECT subcategory_id FROM expense_subcategories WHERE subcategory_name='College Fees'),
 8678,
 (SELECT member_id FROM family_members WHERE member_name='Brother 1'),
 (SELECT vendor_id FROM vendors WHERE vendor_name='Deogiri College'),
 (SELECT payment_method_id FROM payment_methods WHERE method_name='UPI'),
 'College fees', FALSE, 'Paid');

SELECT COUNT(*) AS total_records
FROM expenses;
----------------------------------------------------------------------------------------
--- Month Vise Data ---
SELECT
    TO_CHAR(DATE_TRUNC('month', expense_date), 'Month') AS month,
    COUNT(*) AS records
FROM expenses
GROUP BY DATE_TRUNC('month', expense_date)
ORDER BY DATE_TRUNC('month', expense_date);

---- final readable expense report ----

SELECT
    e.expense_id,
    e.expense_date,
    ec.category_name AS category,
    es.subcategory_name AS subcategory,
    e.amount,
    fm.member_name AS member,
    v.vendor_name AS vendor,
    pm.method_name AS payment_method,
    e.description,
    e.recurring,
    e.status
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
JOIN family_members fm
    ON e.member_id = fm.member_id
LEFT JOIN vendors v
    ON e.vendor_id = v.vendor_id
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
ORDER BY e.expense_date, e.expense_id;

------- Total Expense -----

SELECT SUM(amount) AS total_expense
FROM expenses;

------ Average Expense -----

SELECT ROUND(AVG(amount), 2) AS average_expense
FROM expenses;

----- Highest Expense -------

SELECT MAX(amount) AS highest_expense
FROM expenses;

------ Lowest Expense -----

SELECT MIN(amount) AS highest_expense
FROM expenses;

---- Findings ----
--Highest expense month: June — ₹94,616.60
--Lowest expense month: August — ₹53,994.60

--Expense Category Analysis

SELECT
    ec.category_name AS category,
    COUNT(e.expense_id) AS total_transactions,
    SUM(e.amount) AS total_expense,
    ROUND(AVG(e.amount), 2) AS average_expense
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
GROUP BY ec.category_name
ORDER BY total_expense DESC;

--Farming is the highest spending category at ₹53,000.
--Livestock is the second-highest at ₹46,100.
--Education has the highest average expense per transaction at ₹8,044.50.
--Farming, Livestock, and Education are the top three spending areas.
--Personal Care and Pooja Items have the lowest total spending.

----- Recurring Expense Analysis ----

SELECT
    recurring,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_expense
FROM expenses
GROUP BY recurring
ORDER BY recurring DESC;

------- Recurring Expenses Category-wise -----

SELECT
    ec.category_name AS category,
    'Yes' AS recurring,
    COUNT(*) AS recurring_transactions,
    SUM(e.amount) AS recurring_expense
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
WHERE e.recurring = TRUE
GROUP BY ec.category_name
ORDER BY recurring_expense DESC;

------ Payment Behaviour Analysis

SELECT
    pm.method_name AS payment_method,
    COUNT(*) AS total_transactions,
    SUM(e.amount) AS total_expense,
    ROUND(AVG(e.amount), 2) AS average_expense
FROM expenses e
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
GROUP BY pm.method_name
ORDER BY total_expense DESC

--Cash was the most frequently used payment method 
--with 31 transactions and ₹1,43,650 total spending. 
--UPI was the second most used method.

--- Cash vs Digital Payment Analysis---

SELECT
    CASE
        WHEN pm.method_name = 'Cash' THEN 'Cash'
        ELSE 'Digital Payment'
    END AS payment_type,
    COUNT(*) AS total_transactions,
    SUM(e.amount) AS total_expense
FROM expenses e
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
GROUP BY
    CASE
        WHEN pm.method_name = 'Cash' THEN 'Cash'
        ELSE 'Digital Payment'
    END
ORDER BY total_expense DESC;

--------- High-Value Expenses Analysis------
------ 10000< high value is consider -----

SELECT
    e.expense_id,
    e.expense_date,
    ec.category_name AS category,
    es.subcategory_name AS subcategory,
    e.amount,
    fm.member_name AS member,
    v.vendor_name AS vendor,
    pm.method_name AS payment_method,
    e.description
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
JOIN family_members fm
    ON e.member_id = fm.member_id
LEFT JOIN vendors v
    ON e.vendor_id = v.vendor_id
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
WHERE e.amount > 10000
ORDER BY e.amount DESC;
--Education – Class Fees: ₹20,000 is the highest individual expense.
--Farming – Fertilizer & Seeds: ₹18,000 is the second-highest expense.
--Farming – Tractor: ₹15,000 is another major expense.
--Livestock – Animal Medical: ₹15,000 was spent on animal medical treatment.

-----------------UPDATE Operation---------------------------
------------ Wrong Amount Correction
--Before Correction

SELECT
    expense_id,
    expense_date,
    amount,
    description
FROM expenses
WHERE expense_date = '2026-06-04';

-- After Correction/Update

UPDATE expenses
SET amount = 3500
WHERE expense_date = '2026-06-04'
  AND description = 'Petrol for vehicle';

-- Alter ---
SELECT
    expense_id,
    expense_date,
    amount,
    description
FROM expenses
WHERE expense_date = '2026-06-04';

------------------------DELET-------------------------

--create table
CREATE TABLE test_expenses (
    test_id SERIAL PRIMARY KEY,
    test_name VARCHAR(50)
);

INSERT INTO test_expenses (test_name)
VALUES ('Test Expense');

SELECT * FROM test_expenses;

DELETE FROM test_expenses;

------------------- DROP Operation -----------------------

-- create temporary table 
DROP TABLE IF EXISTS test_expenses;

CREATE TABLE test_expenses (
    test_id SERIAL PRIMARY KEY,
    test_name VARCHAR(50)
);

SELECT * FROM test_expenses;

DROP TABLE test_expenses;

-------------------- ALTER Operations -----------

---expense_type column add---
ALTER TABLE expenses
ADD COLUMN expense_type VARCHAR(20);

SELECT expense_id, amount, expense_type
FROM expenses
LIMIT 5;

---location column add---

ALTER TABLE expenses
ADD COLUMN location VARCHAR(100);

SELECT expense_id, amount, location
FROM expenses
LIMIT 5;

---contact_number column add---

ALTER TABLE vendors
ADD COLUMN contact_number VARCHAR(15);

SELECT vendor_id, vendor_name, contact_number
FROM vendors;

SELECT
    CASE
        WHEN recurring = TRUE THEN 'Yes'
        ELSE 'No'
    END AS recurring,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_expense
FROM expenses
GROUP BY recurring
ORDER BY total_expense DESC;

SELECT
    ec.category_name AS category,
    COUNT(*) AS recurring_transactions,
    SUM(e.amount) AS recurring_expense,
    ROUND(AVG(e.amount), 2) AS average_expense
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
WHERE e.recurring = TRUE
GROUP BY ec.category_name
ORDER BY recurring_expense DESC;

--------------Three-Month Household Expense Analysis---------------

-----------------A. Overall Spending ----------------------

--Q1. What is the total household expenditure during the three months?
SELECT
    SUM(amount) AS total_household_expenditure
FROM expenses;

--Q2. What is the average expense per transaction?
SELECT
    ROUND(AVG(amount), 2) AS average_expense_per_transaction
FROM expenses;

--Q3. What is the highest individual expense?
SELECT
    MAX(amount) AS highest_individual_expense
FROM expenses;

--Q4. What is the lowest individual expense?
SELECT
    MIN(amount) AS lowest_individual_expense
FROM expenses;

--Q5. How many expense transactions were recorded?
SELECT
    COUNT(*) AS total_transactions
FROM expenses;

------------B. Month-wise Analysis---------------

--Q6. Which month had the highest total expenditure?
SELECT
    TO_CHAR(expense_date, 'Month') AS month,
    SUM(amount) AS total_expense
FROM expenses
GROUP BY EXTRACT(MONTH FROM expense_date),
         TO_CHAR(expense_date, 'Month')
ORDER BY total_expense DESC
LIMIT 1;

--Q7. Which month had the lowest total expenditure?
SELECT
    TO_CHAR(expense_date, 'Month') AS month,
    SUM(amount) AS total_expense
FROM expenses
GROUP BY EXTRACT(MONTH FROM expense_date),
         TO_CHAR(expense_date, 'Month')
ORDER BY total_expense ASC
LIMIT 1;

--Q8. Did household expenditure increase or decrease from the first month to the third month?
SELECT
    (SELECT SUM(amount)
     FROM expenses
     WHERE EXTRACT(MONTH FROM expense_date) = 6) AS june_expense,

    (SELECT SUM(amount)
     FROM expenses
     WHERE EXTRACT(MONTH FROM expense_date) = 8) AS august_expense,

    (SELECT SUM(amount)
     FROM expenses
     WHERE EXTRACT(MONTH FROM expense_date) = 8)
    -
    (SELECT SUM(amount)
     FROM expenses
     WHERE EXTRACT(MONTH FROM expense_date) = 6) AS difference;	
--Household expenditure decreased by ₹41,122 from June (₹95,116.60)
--to August (₹53,994.60), showing an overall reduction in spending.

--Q9. Which month had the highest number of transactions?
SELECT
    TO_CHAR(expense_date, 'Month') AS month,
    COUNT(*) AS total_transactions
FROM expenses
GROUP BY EXTRACT(MONTH FROM expense_date),
         TO_CHAR(expense_date, 'Month')
ORDER BY total_transactions DESC
LIMIT 1;

--Q10. Identify any significant change in spending between the three months.
SELECT
    TO_CHAR(expense_date, 'Month') AS month,
    SUM(amount) AS total_expense,
    COUNT(*) AS total_transactions,
    ROUND(AVG(amount), 2) AS average_expense
FROM expenses
GROUP BY EXTRACT(MONTH FROM expense_date),
         TO_CHAR(expense_date, 'Month')
ORDER BY EXTRACT(MONTH FROM expense_date);

--June had the highest spending (₹95,116.60), while August had the
--lowest (₹53,994.60). The average expense also decreased from ₹5,944.79 in 
--June to ₹3,176.15 in August, 
--showing improved spending control.

--------------------C. Expense Pattern Analysis-------------------------

--Q11. What are the major types of expenses in the household?
SELECT
    ec.category_name AS expense_type,
    SUM(e.amount) AS total_expense
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
GROUP BY ec.category_name
ORDER BY total_expense DESC;

--Q12. Which expense type consumed the largest amount?
SELECT
    ec.category_name AS expense_type,
    SUM(e.amount) AS total_expense
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
GROUP BY ec.category_name
ORDER BY total_expense DESC
LIMIT 1;

--Q13. Which expense type occurred most frequently?
SELECT
    ec.category_name AS expense_type,
    COUNT(*) AS total_transactions
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
GROUP BY ec.category_name
ORDER BY total_transactions DESC
LIMIT 1;

--Q14. Identify the top three areas where the household spends the most.
SELECT
    ec.category_name AS category,
    SUM(e.amount) AS total_expense
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
GROUP BY ec.category_name
ORDER BY total_expense DESC
LIMIT 3;
--Farming had the highest total expense (₹53,000), followed by Livestock
--(₹46,100) and Education (₹32,178). These are the major spending categories.

--Q15. Identify expenses that occur frequently but involve relatively small amounts.

SELECT
    es.subcategory_name AS expense,
    COUNT(*) AS total_transactions,
    SUM(e.amount) AS total_expense,
    ROUND(AVG(e.amount), 2) AS average_expense
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
GROUP BY es.subcategory_name
HAVING COUNT(*) >= 3
   AND AVG(e.amount) < 1000
ORDER BY total_transactions DESC;
D. Recurring Expense Analysis

--Q16. Identify the household's recurring expenses.
SELECT
    e.expense_id,
    e.expense_date,
    ec.category_name AS category,
    es.subcategory_name AS subcategory,
    e.amount,
    e.description
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
WHERE e.recurring = TRUE
ORDER BY e.expense_date;

--Q17. How much money is spent on recurring expenses during the three months?
SELECT
    COUNT(*) AS recurring_transactions,
    SUM(amount) AS total_recurring_expense,
    ROUND(AVG(amount), 2) AS average_recurring_expense
FROM expenses
WHERE recurring = TRUE;
Q18. Which recurring expenses should the family review?
SELECT
    es.subcategory_name AS expense,
    COUNT(*) AS recurring_transactions,
    SUM(e.amount) AS total_recurring_expense
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
WHERE e.recurring = TRUE
GROUP BY es.subcategory_name
ORDER BY total_recurring_expense DESC;

--Q19. Identify recurring expenses whose amounts are relatively high.
SELECT
    e.expense_id,
    e.expense_date,
    es.subcategory_name AS expense,
    e.amount,
    e.description
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
WHERE e.recurring = TRUE
  AND e.amount > 5000
ORDER BY e.amount DESC;

---------------------E. Payment Behaviour--------------------------
--Q20. Which payment method is used most frequently?
SELECT
    pm.method_name AS payment_method,
    COUNT(*) AS total_transactions
FROM expenses e
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
GROUP BY pm.method_name
ORDER BY total_transactions DESC
LIMIT 1;

--Q21. Which payment method accounts for the largest amount of expenditure?
SELECT
    pm.method_name AS payment_method,
    SUM(e.amount) AS total_expense
FROM expenses e
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
GROUP BY pm.method_name
ORDER BY total_expense DESC
LIMIT 1;

--Q22. How much is spent through cash?
SELECT
    SUM(e.amount) AS total_cash_expense
FROM expenses e
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
WHERE pm.method_name = 'Cash';

--Q23. How much is spent through digital payment methods?

SELECT
    SUM(e.amount) AS total_digital_expense
FROM expenses e
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
WHERE pm.method_name IN
      ('UPI', 'Net Banking', 'Bank Transfer');
	  
--Q24. Identify high-value transactions made through digital payment methods.

SELECT
    e.expense_id,
    e.expense_date,
    ec.category_name AS category,
    es.subcategory_name AS subcategory,
    e.amount,
    pm.method_name AS payment_method,
    e.description
FROM expenses e
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
WHERE pm.method_name IN
      ('UPI', 'Net Banking', 'Bank Transfer')
  AND e.amount > 10000
ORDER BY e.amount DESC;

-----------------------F. High-Value and Unusual Expenses-------------------------------

--Q25. Identify expenses above a threshold that you consider significant for your household.

SELECT
    e.expense_id,
    e.expense_date,
    ec.category_name AS category,
    es.subcategory_name AS subcategory,
    e.amount,
    fm.member_name AS member,
    v.vendor_name AS vendor,
    pm.method_name AS payment_method,
    e.description
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
JOIN family_members fm
    ON e.member_id = fm.member_id
LEFT JOIN vendors v
    ON e.vendor_id = v.vendor_id
JOIN payment_methods pm
    ON e.payment_method_id = pm.payment_method_id
WHERE e.amount > 10000
ORDER BY e.amount DESC;

--Q26. Identify unusually high expenses.

SELECT
    e.expense_id,
    e.expense_date,
    ec.category_name AS category,
    es.subcategory_name AS subcategory,
    e.amount,
    e.description
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
WHERE e.amount > 15000
ORDER BY e.amount DESC;

--Q27. Identify expenses that occurred only once but had a significant financial impact.
SELECT
    es.subcategory_name AS expense,
    COUNT(*) AS occurrence,
    SUM(e.amount) AS total_expense,
    MAX(e.amount) AS amount
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
GROUP BY es.subcategory_name
HAVING COUNT(*) = 1
   AND MAX(e.amount) > 10000
ORDER BY amount DESC;
--Class Fees had the highest one-time expense at ₹20,000, 
--followed by Fertilizer & Seeds at ₹18,000 and Tractor at ₹15,000.
--These are significant high-value expenses.

--Q28. Investigate the reason for at least three significant/high-value expenses.

SELECT
    e.expense_id,
    e.expense_date,
    ec.category_name AS category,
    es.subcategory_name AS subcategory,
    e.amount,
    fm.member_name AS member,
    v.vendor_name AS vendor,
    e.description
FROM expenses e
JOIN expense_subcategories es
    ON e.subcategory_id = es.subcategory_id
JOIN expense_categories ec
    ON es.category_id = ec.category_id
JOIN family_members fm
    ON e.member_id = fm.member_id
LEFT JOIN vendors v
    ON e.vendor_id = v.vendor_id
WHERE e.amount > 10000
ORDER BY e.amount DESC
LIMIT 3;

--The highest-value expense was Class Fees at ₹20,000, 
--followed by Fertilizer & Seeds at ₹18,000 and Animal Medical 
--at ₹15,000. These expenses were incurred by the family mainly for 
--education, 
--farming, and livestock needs.




