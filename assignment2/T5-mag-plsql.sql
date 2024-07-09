--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T5-mag-plsql.sql

--Student ID: 30534526
--Student Name: Gus Morris

/* Comments for your marker:


*/

SET SERVEROUTPUT ON

--(a) 
--Write your trigger statement, 
--finish it with a slash(/) followed by a blank line

CREATE OR REPLACE TRIGGER check_min_sale BEFORE
    INSERT ON sale 
    FOR EACH ROW
DECLARE
    minprice artwork.ARTWORK_MINPRICE%type;
BEGIN
    SELECT ARTWORK_MINPRICE INTO minprice
    FROM
        ARTWORK A
        JOIN AW_DISPLAY AW ON (
            A.ARTWORK_NO = AW.ARTWORK_NO
            AND A.ARTIST_CODE = AW.ARTIST_CODE
        )
    WHERE
        AW_DISPLAY_ID = :new.aw_display_id;

    minprice := minprice * (100/70);

    IF (:new.sale_price < minprice) THEN
        raise_application_error(-20000, 'Error: Sale below minimum price threshold');
    END IF;
END;
/

-- Write Test Harness for (a)

-- Test VALUES
INSERT INTO customer VALUES (999, 'TEST', 'TEST', NULL, 'TEST', 'TEST', '0000000000','VIC');
INSERT INTO artist VALUES (999, 'TEST', 'TEST', 'TEST', 'TEST', '0000000000', 'VIC',0);
INSERT INTO artwork VALUES (999, 999, 'TEST', 30000, TO_DATE('01-Jan-2023', 'DD-MON-YYYY'));
INSERT INTO aw_display VALUES (999, 999, 999, to_date('02-Jan-2023','dd-Mon-yyyy'), NULL, 1);
INSERT INTO aw_status VALUES (999, 999, 999, to_date('02-Jan-2023','dd-Mon-yyyy'), 'G', 1);


-- Test Harness

-- before value
SELECT
    *
FROM
    SALE
ORDER BY
    SALE_ID;

-- test trigger - insert below min price threshold
BEGIN
    INSERT INTO sale VALUES (
        999,
        TO_DATE('03-JUN-2023', 'DD-MON-YYYY'),
        1,
        1,
        1
    );
END;
/

-- after value
SELECT
    *
FROM
    SALE
ORDER BY
    SALE_ID;

-- test trigger - insert above min price threshold
BEGIN
    INSERT INTO sale VALUES (
        999,
        TO_DATE('03-JUN-2023', 'DD-MON-YYYY'),
        50000,
        1,
        1
    );
END;
/

-- after value
SELECT
    *
FROM
    SALE
ORDER BY
    SALE_ID;

-- Close the transaction
ROLLBACK;
-- End of Test Harness



/*(b) 
Write a stored procedure called prc_insert_sale which handles the insert of a new
artwork sale.

The procedure only handles one SALE insertion at a time.
The procedure requires:
    ● Four input arguments
        ○ p_customer_id (ie. the customer id of the purchaser)
        ○ p_artist_code
        ○ p_artwork_no
        ○ p_sale_price
    ● One output arguments
        ○ p_output
The procedure must check if the customer is a valid customer and whether the inputted
artwork is currently on display. Once these values are checked, the procedure must
insert/update the necessary records in the relevant tables. The sale date is the date
when the record is inserted into the system. You may use the sequences created in Task
3a to generate the PK values.

The structure of the procedure has been provided in the T5-mag-plsql.sql. You must not
change this structure (i.e. you must not change the parameter names and order)
*/
CREATE OR REPLACE PROCEDURE prc_insert_sale (
    p_customer_id   IN NUMBER,
    p_artist_code   IN NUMBER,
    p_artwork_no    IN NUMBER,
    p_sale_price    IN NUMBER,
    p_output    OUT VARCHAR2
) AS
    customer_found      NUMBER;
    aw_display_found    NUMBER;
BEGIN
    SELECT
        COUNT(*) INTO customer_found
    FROM
        CUSTOMER
    WHERE
        CUSTOMER_ID = p_customer_id;

    SELECT
        COUNT(*) INTO aw_display_found
    FROM
        AW_DISPLAY
    WHERE
        ARTIST_CODE = p_artist_code
        AND ARTWORK_NO = p_artwork_no
        AND SYSDATE >= AW_DISPLAY_START_DATE
        AND SYSDATE < NVL(AW_DISPLAY_END_DATE, SYSDATE + 1);

    IF ( customer_found = 0 ) THEN
        p_output := 'Invalid customer ID, new sale process cancelled';
    ELSE
        IF ( aw_display_found = 0 ) THEN
            p_output := 'No valid display found, new sale process cancelled';
        ELSE
            SELECT
                aw_display_id INTO aw_display_found
            FROM
                AW_DISPLAY
            WHERE
                ARTIST_CODE = p_artist_code
                AND ARTWORK_NO = p_artwork_no
                AND SYSDATE >= AW_DISPLAY_START_DATE
                AND SYSDATE <= NVL(AW_DISPLAY_END_DATE, SYSDATE);

            INSERT INTO sale VALUES (
                sale_seq.NEXTVAL,
                SYSDATE,
                p_sale_price,
                p_customer_id,
                aw_display_found
            );

            UPDATE AW_DISPLAY
            SET
                AW_DISPLAY_END_DATE = SYSDATE
            WHERE
                AW_DISPLAY_ID = aw_display_found;

            INSERT INTO AW_STATUS VALUES (
                aw_status_seq.NEXTVAL,
                p_artist_code,
                p_artwork_no,
                SYSDATE,
                'S',
                NULL
            );

            p_output := 'The new sale for customer ID '
            || p_customer_id
            || ' has been recorded';
        END IF;
    END IF;   
EXCEPTION 
-- catch the error raised by the DML statements
   WHEN OTHERS THEN
      raise_application_error(-20010,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END prc_insert_sale;
/

-- Write Test Harness for (b)

-- Test VALUES
INSERT INTO customer VALUES (999, 'TEST', 'TEST', NULL, 'TEST', 'TEST', '0000000000','VIC');
INSERT INTO artist VALUES (999, 'TEST', 'TEST', 'TEST', 'TEST', '0000000000', 'VIC',0);
INSERT INTO artwork VALUES (999, 999, 'TEST', 30000, TO_DATE('01-Jan-2023', 'DD-MON-YYYY'));
INSERT INTO aw_display VALUES (999, 999, 999, to_date('02-Jan-2023','dd-Mon-yyyy'), NULL, 1);
INSERT INTO aw_status VALUES (999, 999, 999, to_date('02-Jan-2023','dd-Mon-yyyy'), 'G', 1);

-- Before value (Does not exist)
SELECT
    *
FROM
    SALE
WHERE
    CUSTOMER_ID = 9999;

--execute the procedure - invalid customer ID
DECLARE
    output VARCHAR2(200);
BEGIN
    prc_insert_sale(9999, 999, 999, 50000, output);
    dbms_output.put_line(output);
END;
/

--execute the procedure - invalid AW_DISPLAY (artist_code, artwork_no)
DECLARE
    output VARCHAR2(200);
BEGIN
    prc_insert_sale(999, 9999, 999, 50000, output);
    dbms_output.put_line(output);
END;
/

DECLARE
    output VARCHAR2(200);
BEGIN
    prc_insert_sale(999, 999, 9999, 50000, output);
    dbms_output.put_line(output);
END;
/


-- Update display end date to before current time.
UPDATE AW_DISPLAY
SET
    aw_display_end_date = to_date('03-Jan-2024','dd-Mon-yyyy')
WHERE
    aw_display_id = 999;

DECLARE
    output VARCHAR2(200);
BEGIN
    prc_insert_sale(999, 999, 999, 50000, output);
    dbms_output.put_line(output);
END;
/

SELECT
    *
FROM
    SALE
WHERE
    CUSTOMER_ID = 999;

-- Display after current time
UPDATE AW_DISPLAY
SET
    aw_display_end_date = to_date('01-Jun-2024','dd-Mon-yyyy')
WHERE
    aw_display_id = 999;

DECLARE
    output VARCHAR2(200);
BEGIN
    prc_insert_sale(999, 999, 999, 50000, output);
    dbms_output.put_line(output);
END;
/

SELECT
    *
FROM
    SALE
WHERE
    CUSTOMER_ID = 999;

SELECT
    *
FROM
    aw_display
WHERE
    aw_display_id = 999;

SELECT
    *
FROM
    AW_STATUS
WHERE
    ARTIST_CODE = 999;

ROLLBACK;