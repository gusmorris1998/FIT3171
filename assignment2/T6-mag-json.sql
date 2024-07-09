/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T6-mag-json.sql

--Student ID: 30534526
--Student Name: Gus Morris


/* Comments for your marker:




*/

-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    JSON_OBJECT ( '_id' VALUE ARTIST_CODE, 'name' VALUE ARTIST_GNAME
                || ' '
                || ARTIST_FNAME,
                'address' VALUE JSON_OBJECT (
                                'street' VALUE ARTIST_STREET,
                                'city' VALUE ARTIST_CITY,
                                'state' VALUE STATE_CODE ),
                'phone' VALUE ARTIST_PHONE,
                'artworks' VALUE JSON_ARRAYAGG(
                                JSON_OBJECT('no' VALUE ARTWORK_NO,
                                'title' VALUE ARTWORK_TITLE,
                                'minimum_price' VALUE ARTWORK_MINPRICE))
    FORMAT JSON )
    || ','
FROM
    ARTIST
    NATURAL JOIN ARTWORK
GROUP BY
    ARTIST_CODE,
    ARTIST_GNAME,
    ARTIST_FNAME,
    ARTIST_STREET,
    ARTIST_CITY,
    STATE_CODE,
    ARTIST_PHONE
ORDER BY
    ARTIST_CODE;