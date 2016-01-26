var express = require('express');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');

var Book = require('./models/book');

var app = express();

// Connect to Mongoose
mongoose.connect('mongodb://kinsley:root@ds051655.mongolab.com:51655/griobook/book');
var db = mongoose.connection;

app.use(bodyParser.json());

app.get('/', function(req, res) {
    res.send('GrioBook: Please use /api/books.');
});

app.get('/api/books', function(req, res) {
    Book.getBooks(function(err, books) {
        if(err) {
            throw err;
        }
        res.json(books);
    })
});

app.post('/api/books', function(req, res) {
    var book = req.body;
    
    Book.addBook(book, function(err, book) {
        if(err) {
            throw err;
        }
        res.json(book);
    })
});

app.get('/api/books/:_id', function(req, res) {
    Book.getBookById(req.params._id,function(err, book) {
        if(err) {
            throw err;
        }
        res.json(book);
    })
});


app.listen(process.env.PORT);
console.log('Server running on port '+ process.env.PORT+'...');