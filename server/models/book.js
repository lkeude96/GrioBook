var mongoose = require('mongoose');

// Book Schema
var bookSchema = mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    author: {
        type: String,
        required: true
    },
    file_name: {
        type: String,
        required: true
    }
});

var Book = module.exports = mongoose.model('Book', bookSchema);

// Get Books
module.exports.getBooks = function(callback, limit) {
    Book.find(callback).limit(limit);
}

// Get Book by ID
module.exports.getBookById = function(id, callback) {
    Book.findById(id, callback);
}

// Add Book
module.exports.addBook = function(book, callback) {
    Book.create(book, callback);
}