use practical_file;
CREATE TABLE acct (
    acct_num INT PRIMARY KEY,
    bal DECIMAL(10, 2)
);

DROP PROCEDURE IF EXISTS DeductFromBalance;

DELIMITER //

CREATE PROCEDURE DeductFromBalance()
BEGIN
    DECLARE account_num INT DEFAULT 1001;
    DECLARE balance DECIMAL(10, 2);
    DECLARE minimum_balance DECIMAL(10, 2) DEFAULT 500;

    SELECT bal INTO balance FROM acct WHERE acct_num = account_num;

    IF balance < minimum_balance THEN
        UPDATE acct SET bal = bal - 100 WHERE acct_num = account_num;
        SELECT CONCAT('Rs. 100 deducted from the balance for account number ', account_num) AS message;
    ELSE
        SELECT CONCAT('Balance is sufficient for account number ', account_num) AS message;
    END IF;
END//

DELIMITER ;
CALL DeductFromBalance();

DELIMITER //

CREATE PROCEDURE CalculateArea()
BEGIN
    DECLARE radius_val DECIMAL(10, 2);
    DECLARE area_val DECIMAL(10, 2);
    
    SET radius_val := 3;
    
    WHILE radius_val <= 7 DO
        SET area_val := 3.14 * radius_val * radius_val;
        INSERT INTO areas VALUES (radius_val, area_val);
        SET radius_val := radius_val + 1;
    END WHILE;
    
    SELECT 'Data inserted into the areas table successfully.' AS message;
END//
DELIMITER ;

CALL CalculateArea();

DELIMITER //

CREATE PROCEDURE CalculateFactorial(IN num INT)
BEGIN
    DECLARE factorial INT DEFAULT 1;
    DECLARE i INT DEFAULT 1;

    WHILE i <= num DO
        SET factorial = factorial * i;
        SET i = i + 1;
    END WHILE;

    SELECT CONCAT('Factorial of ', num, ' is: ', factorial) AS result;
END//

DELIMITER ;

CALL CalculateFactorial(5);

DELIMITER //

CREATE PROCEDURE ReverseNumber()
BEGIN
    DECLARE num INT DEFAULT 12345;
    DECLARE reversed_num INT DEFAULT 0;
    
    WHILE num > 0 DO
        SET reversed_num = reversed_num * 10 + MOD(num, 10);
        SET num = FLOOR(num / 10);
    END WHILE;
    
    SELECT CONCAT('Number in reverse order: ', reversed_num) AS result;
END//

DELIMITER ;

CALL ReverseNumber();