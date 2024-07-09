/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T3-mag-dml.sql

--Student ID: 30534526
--Student Name: Gus Morris

/* Comments for your marker:




*/

/*(a)*/

DROP SEQUENCE aw_display_seq;
CREATE SEQUENCE aw_display_seq START WITH 100 INCREMENT BY 10;

DROP SEQUENCE aw_status_seq;
CREATE SEQUENCE aw_status_seq START WITH 100 INCREMENT BY 10;

DROP SEQUENCE sale_seq;
CREATE SEQUENCE sale_seq START WITH 100 INCREMENT BY 10;


/*(b)

Suppose it is now 11 AM on 30th December 2023, a new artwork called Shattered glass
has just been received by the MAG central warehouse from the artist with artist code 1. The
minimum payment this artist is prepared to accept for this artwork is $25000. You may
assume that artist code 1 only has one artwork titled Shattered glass. Take the necessary
steps in the database to record the required entries for this new arrival (for this task you
may make changes to the provided ARTWORK table).

*/


INSERT INTO artwork VALUES (
    1,
    (
        SELECT
            COUNT(*)
        FROM 
            ARTWORK
        WHERE
            artist_code = 1
    ) + 1,
    'Shattered glass',
    25000,
    -- Does this need to be the full time '11 AM on 30th December 2023'
    TO_DATE('30-Dec-2023', 'DD-MON-YYYY')
);

SELECT
    *
FROM 
    ARTWORK
WHERE
    artist_code = 1;

INSERT INTO aw_status VALUES (
    aw_status_seq.NEXTVAL,
    1,
        (
        SELECT
            ARTWORK_NO
        FROM
            ARTWORK
        WHERE
            artist_code = 1
            AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
    ),
    TO_DATE('30-Dec-2023 11:00', 'DD-MON-YYYY HH24:MI'),
    'W',
    NULL
);

COMMIT;

/*(c)

The above artwork titled Shattered glass is then transited from the MAG central warehouse
to Art Smart gallery (ph: 0490556646) on 1st January 2024 at 1:00 PM.

2 hours and 30 minutes later, the gallery informed MAG by a phone call that the artwork
arrived safely at their location. On the next day, the gallery places the artwork on display for
a duration of 14 days.

Make these required changes to the data in the database.

*/

-- The above artwork titled Shattered glass is then transited from the MAG central warehouse
    -- to Art Smart gallery (ph: 0490556646) on 1st January 2024 at 1:00 PM.

INSERT INTO aw_status VALUES (
    aw_status_seq.NEXTVAL,
    1,
        (
        SELECT
            ARTWORK_NO
        FROM
            ARTWORK
        WHERE
            artist_code = 1
            AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
    ),
    TO_DATE('01-Jan-2024 13:00', 'DD-MON-YYYY HH24:MI'),
    'T',
    NULL
);

COMMIT;

-- 2 hours and 30 minutes later, the gallery informed MAG by a phone call that the artwork
    -- arrived safely at their location.


INSERT INTO aw_status VALUES (
    aw_status_seq.NEXTVAL,
    1,
        (
SELECT
    ARTWORK_NO
FROM
    ARTWORK
WHERE
    artist_code = 1
    AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
    ),
    -- Is there a function i need to use to add two dates.
        -- TO_DATE('01-Jan-2024 13:00', 'DD-MON-YYYY HH24:MI') + 2:30
    TO_DATE('01-Jan-2024 15:30', 'DD-MON-YYYY HH24:MI'),
    'G',
    (
        SELECT
            GALLERY_ID
        FROM 
            GALLERY
        WHERE
            GALLERY_PHONE = '0490556646'
    )
);

SELECT
    *
FROM
    AW_STATUS;


-- On the next day, the gallery places the artwork on display for
    -- a duration of 14 days.

INSERT INTO aw_display VALUES (
    aw_display_seq.NEXTVAL,
    1,
    (
        SELECT
            ARTWORK_NO
        FROM
            ARTWORK
        WHERE
            artist_code = 1
            AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
    ),
    TO_DATE('01-Jan-2024', 'DD-MON-YYYY') + 1,
    TO_DATE('01-Jan-2024', 'DD-MON-YYYY') + 15,
    (
        SELECT
            GALLERY_ID
        FROM 
            GALLERY
        WHERE
            GALLERY_PHONE = '0490556646'
    )
);

COMMIT;

    
/*(d)

On the 4th January 2024 at 11:30 AM, the artwork titled Shattered glass was sold to a
customer named Lois Hawkshaw (ph: 0458708402) at the price of $29,499.99. The gallery
was then instructed to stop displaying this artwork on this sale date.

*/

INSERT INTO sale VALUES (
    sale_seq.NEXTVAL,
    TO_DATE('04-Jan-2024', 'DD-MON-YYYY'),
    29499.99,
    (
        SELECT
            CUSTOMER_ID
        FROM
            CUSTOMER
        WHERE
            CUSTOMER_PHONE = '0458708402'
    ),
    (
        SELECT
            AW_DISPLAY_ID
        FROM
            aw_display
        WHERE
            ARTIST_CODE = 1
            AND ARTWORK_NO = (
                SELECT
                    ARTWORK_NO
                FROM
                    ARTWORK
                WHERE
                    artist_code = 1
                    AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
            )
            -- (A)
            AND AW_DISPLAY_START_DATE = TO_DATE('02-Jan-2024', 'DD-MON-YYYY')
    )
);

UPDATE aw_display
SET
    aw_display_end_date = TO_DATE('04-Jan-2024', 'DD-MON-YYYY')
WHERE
    ARTIST_CODE = 1
    AND ARTWORK_NO = (
        SELECT
            ARTWORK_NO
        FROM
            ARTWORK
        WHERE
            artist_code = 1
            AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
    )
    -- (A)
    AND AW_DISPLAY_START_DATE = TO_DATE('02-Jan-2024', 'DD-MON-YYYY');


INSERT INTO aw_status VALUES (
    aw_status_seq.NEXTVAL,
    1,
    (
        SELECT
            ARTWORK_NO
        FROM
            ARTWORK
        WHERE
            artist_code = 1
            AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
    ),
    TO_DATE('04-Jan-2024 11:30', 'DD-MON-YYYY HH24:MI'),
    'S',
    NULL
);

COMMIT;

/*(e)

Before delivering the sold artwork to the customer’s address, MAG was informed that the
customer was involved in illegal financial activities (the customer was accused of
involvement in a money laundering case). As a result, MAG management decided to cancel
the sale (remove the sale record and related status data from the system) and have the
payment refunded to the customer. The artwork was placed back in the gallery for
continuing display for sale based on its original gallery display start date.

*/


DELETE FROM sale
WHERE
    CUSTOMER_ID = (
        SELECT
            CUSTOMER_ID
        FROM
            CUSTOMER
        WHERE
            CUSTOMER_PHONE = '0458708402'
    )
    AND AW_DISPLAY_ID = (
        SELECT
            AW_DISPLAY_ID
        FROM
            aw_display
        WHERE
            ARTIST_CODE = 1
            AND ARTWORK_NO = (
                SELECT
                    ARTWORK_NO
                FROM
                    ARTWORK
                WHERE
                    artist_code = 1
                    AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
            )
            -- (A)
            AND AW_DISPLAY_START_DATE = TO_DATE('02-Jan-2024', 'DD-MON-YYYY')
    );

UPDATE aw_display
SET
    aw_display_end_date = TO_DATE('16-Jan-2024', 'DD-MON-YYYY')
WHERE
    ARTIST_CODE = 1
    AND ARTWORK_NO = (
        SELECT
            ARTWORK_NO
        FROM
            ARTWORK
        WHERE
            artist_code = 1
            AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
    )
    -- (A)
    AND AW_DISPLAY_START_DATE = TO_DATE('02-Jan-2024', 'DD-MON-YYYY');

DELETE FROM AW_STATUS
WHERE
    ARTIST_CODE = 1
    AND ARTWORK_NO = (
        SELECT
            ARTWORK_NO
        FROM
            ARTWORK
        WHERE
            artist_code = 1
            AND UPPER(ARTWORK_TITLE) = UPPER('Shattered glass')
    )
    AND AWS_DATE_TIME = TO_DATE('04-Jan-2024 11:30', 'DD-MON-YYYY HH24:MI');


COMMIT;

SELECT
    *
FROM 
    aw_display;

SELECT
    *
FROM 
    aw_status;

SELECT
    *
FROM 
    sale;

SELECT
    *
FROM
    artwork;