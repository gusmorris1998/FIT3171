/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T4-mag-mods.sql

--Student ID: 30534526
--Student Name: Gus Morris


/* Comments for your marker:





*/

/*(a)

MAG would like to be able to easily determine the total number of artworks that each
artist has submitted which have been sold or are currently available for sale (i.e., not
including the ones that have been returned).

Based on the data which is currently stored in the system, this attribute must be
initialised to the correct current number of artworks. Add a new attribute which will record
this requirement.

As part of your solution provide appropriate select and desc statements to show the
changes you have made. Select to show any data changes which have occurred and
desc tablename e.g. desc customer to show any table structural changes.

*/

ALTER TABLE artist ADD ( artist_selling_sold NUMBER(3, 0) DEFAULT 0 NOT NULL );

SELECT
    *
FROM
    artist;

COMMENT ON COLUMN artist.artist_selling_sold IS
    'Total number of artworks that artist has submitted which have been sold or are currently available';


UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 1
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 1;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 2
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 2;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 3
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 3;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 4
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 4;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 5
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 5;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 6
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 6;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 7
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 7;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 8
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 8;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 9
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 9;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 10
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 10;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 11
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 11;

UPDATE artist
SET
    artist_selling_sold = (
        SELECT
            COUNT(DISTINCT artwork_no)
        FROM
            aw_status
        WHERE
            artist_code = 12
            AND upper(aws_status) <> upper('R')
    )
WHERE
    artist_code = 12;

COMMIT;

/*(b)

MAG has observed that many customers seem to purchase artworks from the same
artist. They want to record the number of artworks that each customer has purchased
from each artist so as to assist with future marketing opportunities for particular artists.

Change the database to meet this requirement. Your solution must record the correct
number of artworks that each customer has purchased from each artist based on the
data that is currently stored in the database.

As part of your solution provide appropriate select and desc statements to show the
changes you have made. Select to show any data changes which have occurred and
desc tablename e.g. desc customer to show any table structural changes.

*/
DROP TABLE customer_artist_purchases CASCADE CONSTRAINTS;

CREATE TABLE customer_artist_purchases AS
    SELECT
        customer_id,
        artist_code
    FROM
        customer
        NATURAL JOIN artist;

COMMENT ON COLUMN customer_artist_purchases.customer_id IS
    'Identifier for customer';

COMMENT ON COLUMN customer_artist_purchases.artist_code IS
    'Identifier for artist';

ALTER TABLE customer_artist_purchases ADD ( purchases NUMBER(3) DEFAULT 0 NOT NULL );

COMMENT ON COLUMN customer_artist_purchases.purchases IS
    'Number of purchases made by customer of a the particular Artists artworks';

ALTER TABLE customer_artist_purchases ADD CONSTRAINT customer_artist_purchases_pk PRIMARY KEY ( customer_id, artist_code );

ALTER TABLE customer_artist_purchases ADD CONSTRAINT cas_customer_fk FOREIGN KEY ( customer_id ) REFERENCES customer ( customer_id );

ALTER TABLE customer_artist_purchases ADD CONSTRAINT cas_artist_fk FOREIGN KEY ( artist_code ) REFERENCES artist ( artist_code );

UPDATE customer_artist_purchases
SET
    purchases = 1
WHERE
    artist_code = 1
    AND customer_id = 1;

UPDATE customer_artist_purchases
SET
    purchases = 1
WHERE
    artist_code = 2
    AND customer_id = 2;

UPDATE customer_artist_purchases
SET
    purchases = 1
WHERE
    artist_code = 3
    AND customer_id = 3;

UPDATE customer_artist_purchases
SET
    purchases = 1
WHERE
    artist_code = 4
    AND customer_id = 4;

SELECT
    *
FROM
    customer_artist_purchases;

COMMIT;