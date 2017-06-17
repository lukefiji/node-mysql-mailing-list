
SELECT DISTINCT CONCAT(author_fname, ' ',author_lname) AS 'distinct names' FROM books;

-- Also applies to multiple columns
SELECT DISTINCT author_fname, author_lname FROM books;
