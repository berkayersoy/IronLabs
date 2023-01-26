# Challenge 1 - Who Have Published What At Where?
SELECT A.au_id, A.au_lname, A.au_fname, TA.title_id, T.title, P.pub_name
FROM authors A
INNER JOIN titleauthor TA
ON TA.au_id = A.au_id
INNER JOIN titles T
ON T.title_id=TA.title_id
INNER JOIN publishers P
ON P.pub_id=T.pub_id
ORDER BY au_id ASC;

# Challenge 2 - Who Have Published How Many At Where?
SELECT A.au_id, A.au_lname, A.au_fname, P.pub_name, COUNT(T.title) AS number_of_titles
FROM authors A
INNER JOIN titleauthor TA
ON TA.au_id = A.au_id
INNER JOIN titles T
ON T.title_id=TA.title_id
INNER JOIN publishers P
ON P.pub_id=T.pub_id
GROUP BY A.au_id, P.pub_name
ORDER BY number_of_titles DESC;

# Challenge 3 - Best Selling Authors
SELECT A.au_lname, SUM(T.ytd_sales)
FROM authors A
INNER JOIN titleauthor TA
ON TA.au_id = A.au_id
INNER JOIN titles T
ON T.title_id=TA.title_id
GROUP BY A.au_lname
ORDER BY SUM(T.ytd_sales) DESC
LIMIT 3;

# Challenge 4 - Best Selling Authors Ranking
SELECT A.au_lname, IFNULL(SUM(T.ytd_sales),0) AS total_sales_by_author
FROM authors A
LEFT JOIN titleauthor TA
ON TA.au_id = A.au_id
LEFT JOIN titles T
ON T.title_id=TA.title_id
GROUP BY A.au_lname
ORDER BY total_sales_by_author DESC;



