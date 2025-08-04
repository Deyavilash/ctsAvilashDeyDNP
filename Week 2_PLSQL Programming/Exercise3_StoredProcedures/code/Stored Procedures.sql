SET SERVEROUTPUT ON;


BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE ACCOUNTS CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEES CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE DEPARTMENTS CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE ACCOUNTS (
    ACCOUNT_ID NUMBER PRIMARY KEY,
    ACCOUNT_TYPE VARCHAR2(20) NOT NULL,
    BALANCE NUMBER(10, 2) NOT NULL,
    CUSTOMER_ID NUMBER
);

CREATE TABLE DEPARTMENTS (
    DEPARTMENT_ID NUMBER PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR2(20) NOT NULL
);

CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID NUMBER PRIMARY KEY,
    EMPLOYEE_NAME VARCHAR2(20) NOT NULL,
    DEPARTMENT_ID NUMBER REFERENCES DEPARTMENTS(DEPARTMENT_ID),
    SALARY NUMBER(10, 2) NOT NULL,
    PERFORMANCE_RATING NUMBER(1,0)
);

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (10, 'HR');
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (20, 'Finance');
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (30, 'IT');

INSERT INTO EMPLOYEES (EMPLOYEE_ID, EMPLOYEE_NAME, DEPARTMENT_ID, SALARY, PERFORMANCE_RATING) VALUES (101, 'Avilash', 10, 60000.00, 4);
INSERT INTO EMPLOYEES (EMPLOYEE_ID, EMPLOYEE_NAME, DEPARTMENT_ID, SALARY, PERFORMANCE_RATING) VALUES (102, 'Bandan', 20, 50000.00, 5);
INSERT INTO EMPLOYEES (EMPLOYEE_ID, EMPLOYEE_NAME, DEPARTMENT_ID, SALARY, PERFORMANCE_RATING) VALUES (103, 'Champa', 30, 70000.00, 3);
INSERT INTO EMPLOYEES (EMPLOYEE_ID, EMPLOYEE_NAME, DEPARTMENT_ID, SALARY, PERFORMANCE_RATING) VALUES (104, 'Dev', 10, 55000.00, 5);
INSERT INTO EMPLOYEES (EMPLOYEE_ID, EMPLOYEE_NAME, DEPARTMENT_ID, SALARY, PERFORMANCE_RATING) VALUES (105, 'Subhasis', 20, 52000.00, 4);

INSERT INTO ACCOUNTS (ACCOUNT_ID, ACCOUNT_TYPE, BALANCE, CUSTOMER_ID) VALUES (1, 'Savings', 1000.00, 101);
INSERT INTO ACCOUNTS (ACCOUNT_ID, ACCOUNT_TYPE, BALANCE, CUSTOMER_ID) VALUES (2, 'Checking', 500.00, 101);
INSERT INTO ACCOUNTS (ACCOUNT_ID, ACCOUNT_TYPE, BALANCE, CUSTOMER_ID) VALUES (3, 'Savings', 2500.00, 102);
INSERT INTO ACCOUNTS (ACCOUNT_ID, ACCOUNT_TYPE, BALANCE, CUSTOMER_ID) VALUES (4, 'Checking', 1200.00, 102);
INSERT INTO ACCOUNTS (ACCOUNT_ID, ACCOUNT_TYPE, BALANCE, CUSTOMER_ID) VALUES (5, 'Savings', 5000.00, 103);
INSERT INTO ACCOUNTS (ACCOUNT_ID, ACCOUNT_TYPE, BALANCE, CUSTOMER_ID) VALUES (6, 'Savings', 150.00, 104);
COMMIT;
SELECT * FROM ACCOUNTS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
    C_INTEREST_RATE CONSTANT NUMBER := 0.01;
    v_updated_rows NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Executing ProcessMonthlyInterest ---');
    UPDATE ACCOUNTS
    SET BALANCE = BALANCE * (1 + C_INTEREST_RATE)
    WHERE ACCOUNT_TYPE = 'Savings';
    v_updated_rows := SQL%ROWCOUNT;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully applied ' || (C_INTEREST_RATE * 100) || '% interest to ' || v_updated_rows || ' savings accounts.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ProcessMonthlyInterest: ' || SQLERRM);
        ROLLBACK;
END ProcessMonthlyInterest;
/
EXEC ProcessMonthlyInterest;
SELECT * FROM ACCOUNTS WHERE ACCOUNT_TYPE = 'Savings';

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department_id    IN EMPLOYEES.DEPARTMENT_ID%TYPE,
    p_bonus_percentage IN NUMBER
)
IS
    v_updated_employees NUMBER;
BEGIN
    UPDATE EMPLOYEES
    SET SALARY = SALARY * (1 + p_bonus_percentage)
    WHERE DEPARTMENT_ID = p_department_id;
    v_updated_employees := SQL%ROWCOUNT;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully applied ' || (p_bonus_percentage * 100) || '% bonus to ' || v_updated_employees || ' employees in Department ' || p_department_id || '.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in UpdateEmployeeBonus: ' || SQLERRM);
        ROLLBACK;
END UpdateEmployeeBonus;
/
EXEC UpdateEmployeeBonus(20, 0.05);
EXEC UpdateEmployeeBonus(10, 0.03);

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_source_account_id      IN ACCOUNTS.ACCOUNT_ID%TYPE,
    p_destination_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE,
    p_amount                 IN ACCOUNTS.BALANCE%TYPE
)
IS
    v_source_balance ACCOUNTS.BALANCE%TYPE;
    v_destination_balance ACCOUNTS.BALANCE%TYPE;
    e_insufficient_funds EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_insufficient_funds, -20001);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Attempting to transfer Rs. ' || p_amount || ' from Account ' || p_source_account_id || ' to Account ' || p_destination_account_id || '.');
    IF p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Transfer amount must be positive.');
    END IF;
    IF p_source_account_id = p_destination_account_id THEN
        RAISE_APPLICATION_ERROR(-20003, 'Source and destination accounts cannot be the same.');
    END IF;
    SELECT BALANCE
    INTO v_source_balance
    FROM ACCOUNTS
    WHERE ACCOUNT_ID = p_source_account_id
    FOR UPDATE OF BALANCE;
    SELECT BALANCE
    INTO v_destination_balance
    FROM ACCOUNTS
    WHERE ACCOUNT_ID = p_destination_account_id;
    DBMS_OUTPUT.PUT_LINE('Before Transfer:');
    DBMS_OUTPUT.PUT_LINE('  Account ' || p_source_account_id || ' Balance: Rs. ' || v_source_balance);
    DBMS_OUTPUT.PUT_LINE('  Account ' || p_destination_account_id || ' Balance: Rs. ' || v_destination_balance);
    IF v_source_balance < p_amount THEN
        RAISE e_insufficient_funds;
    END IF;
    UPDATE ACCOUNTS
    SET BALANCE = BALANCE - p_amount
    WHERE ACCOUNT_ID = p_source_account_id;
    UPDATE ACCOUNTS
    SET BALANCE = BALANCE + p_amount
    WHERE ACCOUNT_ID = p_destination_account_id;
    COMMIT;
    SELECT BALANCE INTO v_source_balance FROM ACCOUNTS WHERE ACCOUNT_ID = p_source_account_id;
    SELECT BALANCE INTO v_destination_balance FROM ACCOUNTS WHERE ACCOUNT_ID = p_destination_account_id;
    DBMS_OUTPUT.PUT_LINE('Transfer successful.');
    DBMS_OUTPUT.PUT_LINE('After Transfer:');
    DBMS_OUTPUT.PUT_LINE('  Account ' || p_source_account_id || ' Balance: Rs. ' || v_source_balance);
    DBMS_OUTPUT.PUT_LINE('  Account ' || p_destination_account_id || ' Balance: Rs. ' || v_destination_balance);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: One of the accounts (Source or Destination) does not exist.');
        ROLLBACK;
    WHEN e_insufficient_funds THEN
        DBMS_OUTPUT.PUT_LINE('Insufficient funds in source account.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred in TransferFunds: ' || SQLERRM);
        ROLLBACK;
END TransferFunds;
/
EXEC TransferFunds(1, 2, 100);
EXEC TransferFunds(6, 5, 200);
EXEC TransferFunds(1, 2, 0);
EXEC TransferFunds(1, 1, 50);
EXEC TransferFunds(99, 1, 50);
