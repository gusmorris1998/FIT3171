/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-mag-insert.sql

--Student ID: 30534526
--Student Name: Gus Morris

/* Comments for your marker:

Assumption that artwork does not need to be marked in transit for Sales

*/

--------------------------------------
--INSERT INTO aw_display
--------------------------------------

INSERT INTO aw_display VALUES (
    1,
    1,
    1,
    to_date('02-Jun-2023','dd-Mon-yyyy'),
    to_date('08-Aug-2023','dd-Mon-yyyy'),
    1
);

INSERT INTO aw_display VALUES (
    2,
    2,
    1,
    to_date('05-Jul-2023','dd-Mon-yyyy'),
    to_date('12-Jul-2023','dd-Mon-yyyy'),
    2
);

INSERT INTO aw_display VALUES (
    3,
    3,
    1,
    to_date('05-Jul-2023','dd-Mon-yyyy'),
    to_date('22-Nov-2023','dd-Mon-yyyy'),
    2
);

INSERT INTO aw_display VALUES (
    4,
    4,
    1,
    to_date('05-Jul-2023','dd-Mon-yyyy'),
    to_date('16-Aug-2023','dd-Mon-yyyy'),
    2
);

INSERT INTO aw_display VALUES (
    5,
    5,
    1,
    to_date('23-Aug-2023','dd-Mon-yyyy'),
    NULL,
    3
);

INSERT INTO aw_display VALUES (
    6,
    9,
    1,
    to_date('23-Aug-2023','dd-Mon-yyyy'),
    NULL,
    3
);

INSERT INTO aw_display VALUES (
    7,
    7,
    1,
    to_date('23-Aug-2023','dd-Mon-yyyy'),
    NULL,
    3
);

INSERT INTO aw_display VALUES (
    8,
    8,
    1,
    to_date('06-Nov-2023','dd-Mon-yyyy'),
    NULL,
    4
);

INSERT INTO aw_display VALUES (
    9,
    1,
    2,
    to_date('06-Nov-2023','dd-Mon-yyyy'),
    NULL,
    4
);

INSERT INTO aw_display VALUES (
    10,
    7,
    2,
    to_date('01-Dec-2023','dd-Mon-yyyy'),
    NULL,
    5
);

SELECT
    *
FROM
    AW_DISPLAY
ORDER BY
    AW_DISPLAY_ID;


--------------------------------------
--INSERT INTO aw_status
--------------------------------------

INSERT INTO aw_status VALUES (
    14,
    1,
    1,
    TO_DATE('2-Jun-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    1
);

INSERT INTO aw_status VALUES (
    15,
    2,
    1,
    TO_DATE('5-Jun-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    2
);

INSERT INTO aw_status VALUES (
    16,
    3,
    1,
    TO_DATE('5-Jul-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    2
);

INSERT INTO aw_status VALUES (
    17,
    4,
    1,
    TO_DATE('5-Jul-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    2
);

INSERT INTO aw_status VALUES (
    18,
    5,
    1,
    TO_DATE('23-Aug-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    3
);

INSERT INTO aw_status VALUES (
    19,
    9,
    1,
    TO_DATE('23-Aug-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    3
);

INSERT INTO aw_status VALUES (
    20,
    7,
    1,
    TO_DATE('23-Aug-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    3
);

INSERT INTO aw_status VALUES (
    21,
    8,
    1,
    TO_DATE('06-Nov-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    4
);

INSERT INTO aw_status VALUES (
    22,
    1,
    2,
    TO_DATE('06-Nov-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    4
);

INSERT INTO aw_status VALUES (
    23,
    7,
    2,
    TO_DATE('01-Dec-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'G',
    5
);

INSERT INTO aw_status VALUES (
    24,
    1,
    1,
    TO_DATE('08-Aug-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'S',
    NULL
);


INSERT INTO aw_status VALUES (
    25,
    2,
    1,
    TO_DATE('12-Jul-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'S',
    NULL
);

INSERT INTO aw_status VALUES (
    26,
    3,
    1,
    TO_DATE('22-Nov-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'S',
    NULL
);

INSERT INTO aw_status VALUES (
    27,
    4,
    1,
    TO_DATE('06-Aug-2023 08:00', 'DD-MON-YYYY HH24:MI'),
    'S',
    NULL
);

SELECT
    *
FROM
    AW_STATUS;


--------------------------------------
--INSERT INTO sale
--------------------------------------

INSERT INTO sale VALUES (
    1,
    to_date('08-Aug-2023','dd-Mon-yyyy'),
    20000.00,
    1,
    1
);

INSERT INTO sale VALUES (
    2,
    to_date('12-Jul-2023','dd-Mon-yyyy'),
    38000.00,
    2,
    2
);

INSERT INTO sale VALUES (
    3,
    to_date('22-Nov-2023','dd-Mon-yyyy'),
    45000.00,
    3,
    3
);

INSERT INTO sale VALUES (
    4,
    to_date('16-Aug-2023','dd-Mon-yyyy'),
    22000.00,
    4,
    4
);

COMMIT;




