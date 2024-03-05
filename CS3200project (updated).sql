/* 
CS3500 Project
Tanishi Datta and Kaydence Lin
Summer 1 2023
ATM
*/

-- Drop the database if it exists
DROP DATABASE IF EXISTS `banking_system`;

-- Create the database
CREATE DATABASE banking_system;
USE banking_system;

-- Create the bank_company table
CREATE TABLE bank_company (
  company_fdic_cert_num INT PRIMARY KEY,
  company_name VARCHAR(100),
  company_address VARCHAR(100),
  company_zip VARCHAR(10),
  company_city VARCHAR(100),
  company_state VARCHAR(2),
  tot_loans DECIMAL(12, 2) DEFAULT 0,
  tot_deposits DECIMAL(12, 2) DEFAULT 0
);

-- Create the bank_branch table
CREATE TABLE bank_branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(100),
  branch_company INT NOT NULL,
  vault_cash DECIMAL(10, 2) DEFAULT 0,
  num_tellers INT DEFAULT 0,
  branch_street VARCHAR(100),
  branch_zip VARCHAR(10),
  branch_city VARCHAR(100),
  branch_state VARCHAR(100),
  CONSTRAINT fk_branch_company FOREIGN KEY (branch_company) REFERENCES bank_company(company_fdic_cert_num)
);

-- Create the teller table
CREATE TABLE teller (
  teller_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  phone_number VARCHAR(20),
  branch_id INT NOT NULL,
  bank_address VARCHAR(100),
  bank_zip VARCHAR(10),
  bank_city VARCHAR(100),
  bank_state VARCHAR(100),
  CONSTRAINT fk_teller_branch FOREIGN KEY (branch_id) REFERENCES bank_branch(branch_id)
);

-- Create the atm table
CREATE TABLE atm (
  atm_id VARCHAR(10) PRIMARY KEY,
  branch_id INT,
  atm_address VARCHAR(100),
  atm_zip VARCHAR(10),
  atm_city VARCHAR(50),
  atm_state VARCHAR(50),
  operation_time VARCHAR(100),
  CONSTRAINT fk_atm_branch FOREIGN KEY (branch_id) REFERENCES bank_branch(branch_id)
);

-- Create the customer table
CREATE TABLE customer (
  customer_id INT auto_increment PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  preferred_lang VARCHAR(50)
);

-- Create the account table
CREATE TABLE account (
  account_num INT auto_increment KEY,
  acct_type ENUM('Savings', 'Checking'),
  acct_balance DECIMAL(10, 2),
  pin_num INT(4),
  customer_id INT,
  CONSTRAINT fk_account_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Create the transactions table
CREATE TABLE transactions (
  transac_id INT,
  transac_type VARCHAR(10),
  money_sent DECIMAL(10,2),
  money_received DECIMAL(10,2),
  atm_id VARCHAR(10),
  customer_id INT,
  CONSTRAINT fk_transactions_atm FOREIGN KEY (atm_id) REFERENCES atm(atm_id),
  CONSTRAINT fk_transactions_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- function to calculate account balance
DELIMITER //
CREATE PROCEDURE CalculateAccountBalance(IN accountNumber INT, OUT balance DECIMAL(10, 2))
BEGIN
  SELECT acct_balance INTO balance
  FROM account
  WHERE account_num = accountNumber;
END //
DELIMITER ;

-- function to calculate total loans
DELIMITER //
CREATE FUNCTION CalculateTotalLoans(companyId INT) RETURNS DECIMAL(12, 2)
DETERMINISTIC
BEGIN
  DECLARE totalLoans DECIMAL(12, 2);
  SELECT tot_loans INTO totalLoans
  FROM bank_company
  WHERE company_fdic_cert_num = companyId;
  RETURN totalLoans;
END //
DELIMITER ;

-- procedure to add new customer
DELIMITER //
CREATE PROCEDURE AddNewCustomer(
  IN firstName VARCHAR(50),
  IN lastName VARCHAR(50),
  IN preferredLang VARCHAR(50),
  OUT customer_id INT
)
BEGIN
  INSERT INTO customer (first_name, last_name, preferred_lang)
  VALUES (firstName, lastName, preferredLang);
  SET customer_id =  LAST_INSERT_ID();
  
END //
DELIMITER ;

DELIMITER //

-- procedure to create new account
DELIMITER //
CREATE PROCEDURE CreateNewAcct(
  IN acct_type VARCHAR(50),
  IN acct_balance DECIMAL(10, 2),
  IN pin_num INT,
  IN customer_id INT,
  OUT account_num INT
)
BEGIN
  INSERT INTO account (acct_type, acct_balance, pin_num, customer_id)
  VALUES (acct_type, acct_balance, pin_num, customer_id);
  SET account_num = LAST_INSERT_ID();
END //
DELIMITER ;

DELIMITER //


-- trigger to update total deposits
CREATE TRIGGER UpdateTotalDeposits
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
  DECLARE branchCompany INT;
  
  -- Get the branch company of the customer
  SELECT branch_company INTO branchCompany
  FROM bank_branch
  WHERE branch_company = (
    SELECT branch_company
    FROM teller
    WHERE teller_id = (
      SELECT branch_id
      FROM atm
      WHERE atm_id = NEW.atm_id
    )
  );
  
  -- Update the total deposits of the branch
  UPDATE bank_company
  SET tot_deposits = tot_deposits + NEW.money_received
  WHERE company_fdic_cert_num = branchCompany;
END //

DELIMITER ;

-- function to get customer name
DELIMITER //
CREATE FUNCTION GetCustomerName(customerId INT) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
  DECLARE fullName VARCHAR(100);
  SELECT CONCAT(first_name, ' ', last_name) INTO fullName
  FROM customer
  WHERE customer_id = customerId;
  RETURN fullName;
END //
DELIMITER ;

DELIMITER $$
SET @current_date := CURDATE();

-- event to generate monthly statement event
CREATE EVENT GenerateMonthlyStatementEvent
    ON SCHEDULE EVERY 1 MONTH
    DO
    BEGIN
        DECLARE last_day_of_month DATE;

        SET last_day_of_month = LAST_DAY(@current_date);

        INSERT INTO monthly_statements (customer_id, statement_date)
        SELECT customer_id, last_day_of_month
        FROM account;
    END $$
DELIMITER ;

-- Insert data values
INSERT INTO bank_company (company_fdic_cert_num, company_name, company_address, company_zip, company_city, company_state, tot_loans, tot_deposits)
VALUES 
  (628, 'JPMorgan Chase Bank, National Association', '1111 Polaris Pkwy', '43240', 'Columbus', 'OH', 5237000, 987456000),
  (14, 'State Street Bank and Trust Company', 'One Congress Street Suite 1', '02114', 'Boston', 'MA', 312000, 47891000),
  (17534, 'KeyBank National Association', '127 Public Sq', '44114', 'Cleveland', 'OH', 24593000, 3785000000),
  (17798, 'Brookline Bank', '2 Harvard St', '02445', 'Brookline', 'MA', 752000, 123987000),
  (18221, 'Webster Bank, National Association', '1959 Summer St', '06905', 'Stamford', 'CT', 4896000, 789231000),
  (18342, 'Boston Trust Walden Company', '1 Beacon St', '02108', 'Boston', 'MA', 19413000, 2987000000),
  (3510, 'Bank of America, National Association', '100 N Tryon St', '28202', 'Charlotte', 'NC', 3547000, 512789000),
  (18503, 'Cathay Bank', '777 N Broadway', '90012', 'Los Angeles', 'CA', 8435000, 1287000000),
  (29950, 'Santander Bank, N.A.', '824 N Market St Ste 100', '19801', 'Wilmington', 'DE', 9126000, 1532000000),
  (57957, 'Citizens Bank, National Association', '1 Citizens Plz', '02903', 'Providence', 'RI', 6872000, 1098000000);


INSERT INTO bank_branch (branch_id, branch_name, branch_company, vault_cash, num_tellers, branch_street, branch_zip, branch_city, branch_state)
VALUES 
  (255249, 'Tremont Street Branch', 3510, 2500000, 8, '6 Tremont St', '02108', 'Boston', 'MA'),
  (570400, 'State Street Branch', 17798, 1200000, 4, '33 State St', '02109', 'Boston', 'MA'),
  (500171, 'Boston Branch', 18221, 1000000, 3, '100 Franklin St', '02110', 'Boston', 'MA'),
  (440186, 'Boston Branch', 18503, 3000000, 10, '621 Washington St', '02111', 'Boston', 'MA'),
  (193122, 'North End Branch', 3510, 2000000, 7, '260 Hanover St', '02113', 'Boston', 'MA'),
  (6, 'State Street Bank And Trust Company', 14, 1500000, 5, 'One Congress Street Suite 1', '02114', 'Boston', 'MA'),
  (193351, 'Boston - Brigham Circle Branch', 29950, 2800000, 9, '6 Francis St', '02215', 'Boston', 'MA'),
  (42211, 'Mass Avenue Branch', 29950, 1700000, 6, '279 Massachusetts Ave', '02115', 'Boston', 'MA'),
  (629684, 'Mass Ave Branch', 57957, 900000, 3, '183 Massachusetts Ave', '02115', 'Boston', 'MA'),
  (621880, 'Huntington Ave Branch', 628, 2200000, 8, '280 Huntington Ave', '02115', 'Boston', 'MA'),
  (255236, 'Huntington Avenue Branch', 3510, 1600000, 5, '285 Huntington Ave', '02115', 'Boston', 'MA'),
  (541133, 'Clarendon Street Branch', 17798, 2300000, 7, '131 Clarendon St', '02116', 'Boston', 'MA'),
  (575676, 'Copley Square Branch', 18221, 1100000, 4, '491 Boylston St', '02116', 'Boston', 'MA'),
  (576428, 'Chinatown Branch', 18221, 2600000, 9, '25 Stuart St', '02116', 'Boston', 'MA'),
  (258862, 'Boston-Egleston Square Branch', 29950, 1400000, 5, '3060 Washington St', '02119', 'Boston', 'MA'),
  (290976, 'Brigham Circle Branch', 57957, 2700000, 8, '1628 Tremont St', '02120', 'Boston', 'MA'),
  (619407, 'Jamaica Plain', 628, 1300000, 4, '701 Centre St', '02130', 'Boston', 'MA');

INSERT INTO teller (teller_id, first_name, last_name, phone_number, branch_id, bank_address, bank_zip, bank_city, bank_state)
VALUES 
  (01, 'Tassadit', 'Bellal', '6174889352', 255249, '6 Tremont St', '02108', 'Boston', 'MA'),
  (02, 'Mehtab', 'Ahmed', '6172264444', 570400, '33 State St', '02109', 'Boston', 'MA'),
  (03, 'MacKenson', 'Masse', '6177176850', 500171, '100 Franklin St', '02110', 'Boston', 'MA'),
  (04, 'Dong', 'Mai', '6173382700', 440186, '621 Washington St', '02111', 'Boston', 'MA'),
  (05, 'Hannah', 'Peters', '6177231905', 193122, '260 Hanover St', '02113', 'Boston', 'MA'),
  (06, 'Xiao', 'Chen', '6177231906', 193122, '261 Hanover St', '02114', 'Boston', 'MA'),
  (07, 'Chad', 'Smith', '6177863001', 6, 'One Congress Street Suite 1', '02114', 'Boston', 'MA'),
  (08, 'Will', 'Keller', '6177863002', 6, 'One Congress Street Suite 1', '02115', 'Boston', 'MA'),
  (09, 'Brad', 'Willson', '6177863003', 6, 'One Congress Street Suite 1', '02116', 'Boston', 'MA'),
  (10, 'Jason', 'Tapia', '6172775826', 193351, '6 Francis St', '02215', 'Boston', 'MA'),
  (11, 'Dylan', 'Souter', '8446837848', 42211, '279 Massachusetts Ave', '02115', 'Boston', 'MA'),
  (12, 'Danny', 'Jordan', '6175985860', 629684, '183 Massachusetts Ave', '02115', 'Boston', 'MA'),
  (13, 'Jason', 'Bell', '6172170462', 621880, '280 Huntington Ave', '02115', 'Boston', 'MA'),
  (14, 'Sam', 'Schultz', '6172170463', 621880, '280 Huntington Ave', '02115', 'Boston', 'MA'),
  (15, 'Jay', 'Troy', '6174370233', 255236, '285 Huntington Ave', '02115', 'Boston', 'MA'),
  (16, 'Alicia', 'Diamond', '6174254650', 541133, '131 Clarendon St', '02116', 'Boston', 'MA'),
  (17, 'Sasha', 'Belcro', '6178674190', 575676, '491 Boylston St', '02116', 'Boston', 'MA'),
  (18, 'Maddie', 'Shenizer', '6178674191', 575676, '492 Boylston St', '02117', 'Boston', 'MA'),
  (19, 'En Min', 'Chen', '6178674192', 576428, '25 Stuart St', '02116', 'Boston', 'MA'),
  (20, 'Brian', 'Kelly', '6175240025', 258862, '3060 Washington St', '02119', 'Boston', 'MA'),
  (21, 'Sarah', 'Cox', '6175668076', 290976, '1628 Tremont St', '02120', 'Boston', 'MA'),
  (22, 'Max', 'Modi', '6173902441', 619407, '701 Centre St', '02130', 'Boston', 'MA'),
  (23, 'Winston', 'Kane', '6173902442', 619407, '702 Centre St', '02131', 'Boston', 'MA'),
  (24, 'Ramon', 'Moss', '6173902443', 619407, '703 Centre St', '02132', 'Boston', 'MA');

INSERT INTO atm (atm_id, branch_id, atm_address, atm_zip, atm_city, atm_state, operation_time)
VALUES 
  ('MA-0001', 255249, '6 Tremont St', '02108', 'Boston', 'MA', 'Hours vary'),
  ('MA-0002', 570400, '33 State St', '02109', 'Boston', 'MA', 'Monday - Friday 8:30 AM - 5:00 PM'),
  ('MA-0003', 500171, '100 Franklin St', '02110', 'Boston', 'MA', '24 hours'),
  ('MA-0004', 440186, '621 Washington St', '02111', 'Boston', 'MA', 'Monday - Friday 9:00 AM - 5:00 PM, Saturday 10:00 AM - 2:00 PM'),
  ('MA-0005', 193122, '260 Hanover St', '02113', 'Boston', 'MA', 'Hours Vary'),
  ('MA-0006', 193351, '6 Francis St', '02215', 'Boston', 'MA', '24 hours'),
  ('MA-0007', 193351, '350 Longwood Avenue', '02115', 'Boston', 'MA', 'Monday - Saturday 6:30 AM - 10:00 PM, Sunday 6:30 AM - 8:00 PM'),
  ('MA-0008', 193351, '400 The Fenway', '02115', 'Boston', 'MA', 'N/A'),
  ('MA-0009', 193351, '121 Brookline Avenue', '02215', 'Boston', 'MA', '24 hours'),
  ('MA-0010', 42211, '279 Massachusetts Ave', '02115', 'Boston', 'MA', 'Monday - Thursday 9:00 AM - 5:00 PM, Friday 9:00 AM - 6:00 PM, Saturday 9:00 AM - 1:00 PM'),
  ('MA-0011', 42211, '231 Massachusetts Ave', '02115', 'Boston', 'MA', 'Monday - Sunday 7:00 AM - 10:00 PM'),
  ('MA-0012', 42211, '369 Huntington Avenue', '02115', 'Boston', 'MA', '24 hours'),
  ('MA-0013', 42211, '800 Boylston Street', '02199', 'Boston', 'MA', 'Monday - Sunday 8:00 AM - 9:00 PM'),
  ('MA-0014', 621880, '280 Huntington Ave', '02115', 'Boston', 'MA', 'Monday - Friday 9:00 AM - 5:00 PM, Saturday 9:00 AM - 1:00 PM'),
  ('MA-0015', 621880, '280 Huntington Ave', '02115', 'Boston', 'MA', 'Monday - Friday 9:00 AM - 5:00 PM, Saturday 9:00 AM - 1:00 PM'),
  ('MA-0016', 621880, '280 Huntington Ave', '02115', 'Boston', 'MA', 'Monday - Friday 9:00 AM - 5:00 PM, Saturday 9:00 AM - 1:00 PM'),
  ('MA-0017', 255236, '285 Huntington Ave', '02115', 'Boston', 'MA', 'Hours Vary'),
  ('MA-0018', 575676, '491 Boylston St', '02116', 'Boston', 'MA', 'Monday - Friday 9:00 AM - 4:00 PM, Saturday 9:00 AM - 12:00 PM'),
  ('MA-0019', 576428, '25 Stuart St', '02116', 'Boston', 'MA', '24 hours'),
  ('MA-0020', 258862, '3060 Washington Stree', '02119', 'Boston', 'MA', '24 hours'),
  ('MA-0021', 619407, '701 Centre St', '02130', 'Boston', 'MA', '24 hours'),
  ('MA-0022', 619407, '701 Centre St', '02130', 'Boston', 'MA', '24 hours');

INSERT INTO customer (first_name, last_name, preferred_lang)
VALUES 
  ('John', 'Doe', 'English'),
  ('Jane', 'Smith', 'Spanish'),
  ('Michael', 'Johnson', 'English'),
  ('Emma', 'Williams', 'French'),
  ('David', 'Brown', 'English'),
  ('Sophia', 'Miller', 'German'),
  ('Matthew', 'Anderson', 'English'),
  ('Olivia', 'Martinez', 'Spanish'),
  ('James', 'Taylor', 'English'),
  ('Ava', 'Garcia', 'Spanish'),
  ('Laura', 'Alexander', 'Portuguese'),
  ('Joe', 'Graham', 'English'),
  ('Oliver', 'Zhang', 'Spanish'),
  ('Sanya', 'Singh', 'English'),
  ('Alison', 'Cooper', 'Spanish');
  
INSERT INTO account (acct_type, acct_balance, pin_num, customer_id)
VALUES
  ('Savings', 1000.00, 1234, 3),
  ('Checking', 2500.00, 5678, 5),
  ('Checking', 500.00, 9876, 6),
  ('Savings', 3500.00, 4321, 1),
  ('Checking', 2000.00, 2468, 2),
  ('Savings', 1500.00, 1357, 7),
  ('Checking', 3000.00, 8642, 9),
  ('Savings', 1200.00, 9753, 4),
  ('Checking', 2800.00, 3141, 8),
  ('Savings', 1800.00, 5926, 10),
  ('Savings', 2200.00, 5926, 12),
  ('Checking', 1800.00, 8642, 13),
  ('Savings', 3500.00, 2468, 11),
  ('Savings', 4100.00, 5678, 14),
  ('Checking', 2900.00, 1234, 15);

INSERT INTO transactions (transac_id, transac_type, money_sent, money_received, atm_id, customer_id)
VALUES
  ('01001', 'Savings', 1000, 3850, 'MA-0003', 1),
  ('01002', 'Checking', 2500, 1175, 'MA-0003', 2),
  ('01003', 'Checking', 500, 2670, 'MA-0010', 3),
  ('01004', 'Savings', 3500, 4900, 'MA-0020', 4),
  ('01005', 'Checking', 2000, 1985, 'MA-0005', 5),
  ('01006', 'Savings', 1500, 1470, 'MA-0012', 6),
  ('01007', 'Checking', 3000, 620, 'MA-0003', 7),
  ('01008', 'Savings', 1200, 4100, 'MA-0020', 8),
  ('01009', 'Checking', 2800, 750, 'MA-0004', 9),
  ('01010', 'Savings', 1800, 2930, 'MA-0006', 10),
  ('01011', 'Savings', 2200, 1650, 'MA-0016', 11),
  ('01012', 'Checking', 1800, 3480, 'MA-0014', 12),
  ('01013', 'Savings', 3500, 825, 'MA-0018', 13),
  ('01014', 'Savings', 4100, 2560, 'MA-0002', 14),
  ('01015', 'Checking', 2900, 1375, 'MA-0007', 15),
  ('01016', 'Savings', 1200, 2130, 'MA-0017', 01),
  ('01017', 'Checking', 2800, 920, 'MA-0022', 02),
  ('01018', 'Savings', 1800, 410, 'MA-0021', 03),
  ('01019', 'Savings', 2200, 3160, 'MA-0013', 04),
  ('01020', 'Checking', 1800, 1950, 'MA-0001', 05);
