// *****PLEASE ENTER YOUR DETAILS BELOW*****
// T6-mag-mongo.mongodb.js

// Student ID: 30534526
// Student Name: Gus Morris
// Unit Code: FIT3171
// Applied Class No: A01

//Comments for your marker:

// ===================================================================================
// Do not modify or remove any of the comments below (items marked with //)
// ===================================================================================

//Use (connect to) your database - you MUST update xyz001
//with your authcate username

use("gmor0013");

// (b)
// PLEASE PLACE REQUIRED MONGODB COMMAND TO CREATE THE COLLECTION HERE
// YOU MAY PICK ANY COLLECTION NAME
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// Drop collection

db.artist.drop();

// Create collection and insert documents

db.artist.insertMany([
{"_id":1,"name":"Martainn Jenteau","address":{"street":"328 Forest Pass","city":"Melbourne","state":"VIC"},"phone":"0495300384","artworks":[{"no":1,"title":"The Creation of Adam","minimum_price":30000},{"no":2,"title":"Boat festival","minimum_price":14500}]},
{"_id":2,"name":"Kipp Grellis","address":{"street":"2755 Briar Crest Place","city":"South Yarra","state":"VIC"},"phone":"0468858093","artworks":[{"no":1,"title":"The Starry Night","minimum_price":55400}]},
{"_id":3,"name":"Jessi Allward","address":{"street":"9 Becker Plaza","city":"Wallan","state":"VIC"},"phone":"0438843662","artworks":[{"no":1,"title":"Saint francis of Assisi","minimum_price":24500}]},
{"_id":4,"name":"Rosalinda Zavattiero","address":{"street":"1 Del Mar Avenue","city":"Malvern East","state":"VIC"},"phone":null,"artworks":[{"no":1,"title":"The Last Supper","minimum_price":17900}]},
{"_id":5,"name":"Neda Mylchreest","address":{"street":"327 Caliangt Street","city":"Clayton South","state":"VIC"},"phone":"0409562816","artworks":[{"no":1,"title":"the bushes","minimum_price":45000},{"no":2,"title":"The Sojourn","minimum_price":46700.45}]},
{"_id":7,"name":"Weston Stearndale","address":{"street":"39512 Kipling Road","city":"Leongatha","state":"VIC"},"phone":"0417905216","artworks":[{"no":1,"title":"Orange Veils","minimum_price":12900},{"no":2,"title":"Saint Francis of Assisi","minimum_price":34536.9}]},
{"_id":8,"name":"Reeba Wildman","address":{"street":"92542 Service Junction","city":"Malvern East","state":"VIC"},"phone":"0493427245","artworks":[{"no":1,"title":"Girl with a Pearl Earring","minimum_price":23100},{"no":2,"title":"Cafe Terrace at Night","minimum_price":45600.35}]},
{"_id":9,"name":"Marlee Champerlen","address":{"street":"64201 Carey Circle","city":"Clayton South","state":"VIC"},"phone":"0427832032","artworks":[{"no":1,"title":"The Mystic","minimum_price":34000}]},
{"_id":10,"name":"Dorette ","address":{"street":"87596 Porter Place","city":"Lysterfield","state":"VIC"},"phone":"0487345845","artworks":[{"no":1,"title":"The Scientist","minimum_price":24000}]},
]);

// List all documents you added
db.artist.find({ _id: { $gt: 0, $lt: 11 } });

// (c)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

db.artist.find(
    {"$or": [{"artworks.minimum_price":{ $gt:40000 }}, {"artworks.1": { "$exists": true }} ]},
    {"_id": 0, "name": 1, "phone": 1}
);

// (d)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// Show document before new artwork for Weston Stearndale is added

db.artist.find({ _id: 7 });

// Add new artwork

db.artist.updateOne(
    {"_id":7},
    {"$push":
        {
            "artworks":
            {
                "no":3,
                "title":"Purple Sky",
                "minimum_price": 25000
            }
        }
    }
);

// Illustrate/confirm changes made

db.artist.find({ _id: 7 });

