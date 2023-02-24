USE publications;

-- CHALLENGE 1
# STEP 1
SELECT a.au_id,
	t.title_id,
	t.advance*ta.royaltyper/100 AS advance, 
	t.price*s.qty*t.royalty/100* ta.royaltyper/100 AS royalties
FROM titles t
INNER JOIN titleauthor ta ON t.title_id=ta.title_id
INNER JOIN authors a ON a.au_id=ta.au_id
INNER JOIN sales s ON s.title_id=t.title_id;

# STEP 2
SELECT summary.au_id, summary.title_id, SUM(summary.advance + summary.royalties) AS sum_royalties, advance
FROM (
	SELECT a.au_id,
		t.title_id,
		t.advance*ta.royaltyper/100 AS advance, 
		t.price*s.qty*t.royalty/100*ta.royaltyper/100 AS royalties
	FROM titles t
	INNER JOIN titleauthor ta
	ON t.title_id=ta.title_id
	INNER JOIN authors a
	ON a.au_id=ta.au_id
	INNER JOIN sales s
	ON s.title_id=t.title_id
) AS summary
GROUP BY au_id, summary.title_id;

# STEP 3
SELECT summary2.au_id, SUM(summary2.advance+summary2.royalties) AS profits
FROM (
	SELECT summary.au_id, summary.title_id, SUM(royalties) AS sum_royalties, advance
	FROM (
			SELECT a.au_id,
				t.title_id,
				t.advance*ta.royaltyper/100 AS advance, 
				t.price*s.qty*t.royalty/100*ta.royaltyper/100 AS royalties
			FROM titles t
			INNER JOIN titleauthor ta
			ON t.title_id=ta.title_id
			INNER JOIN authors a
			ON a.au_id=ta.au_id
			INNER JOIN sales s
			ON s.title_id=t.title_id
		) AS summary
	) AS summary2
GROUP BY summary2.au_id
ORDER BY profits
LIMIT 3;



-- CHALLENGE 2 Alternative solution
# STEP 1
CREATE TABLE ppub.royalty_per_sale
SELECT advancetable.title_id, advancetable.au_id, advancetable.advance,
		(advancetable.price * sales.qty * advancetable.royalty / 100 * advancetable.royaltyper / 100) as sales_royalty
FROM (
		SELECT titleauthor.title_id, titleauthor.au_id, titles.price,
		titles.royalty, titleauthor.royaltyper,
			(titles.advance*titleauthor.royaltyper/100) as advance
		FROM titleauthor
		LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
        WHERE advance IS NOT NULL) as advancetable
LEFT JOIN sales
ON advancetable.title_id = sales.title_id;

# STEP 2
SELECT royalty_per_sale.au_id, royalty_per_sale.title_id, SUM(royalty_per_sale.sales_royalty) as tot_royalties
FROM ppub.royalty_per_sale
GROUP BY  royalty_per_sale.au_id, royalty_per_sale.title_id;

# STEP 3
CREATE TABLE ppub.final_results
SELECT royalty_per_sale.au_id, concat(authors.au_fname, " ", authors.au_lname) as Author_Name, (SUM(royalty_per_sale.advance)+SUM(royalty_per_sale.sales_royalty)) as profits
FROM ppub.royalty_per_sale
left join authors 
on royalty_per_sale.au_id=authors.au_id
GROUP BY  royalty_per_sale.au_id
ORDER BY profits DESC LIMIT 3;




-- CHALLENGE 3
select *
from final_results;

create table most_profiting_authors(
au_id varchar(11),
author_name varchar(50),
profits int);


Insert into most_profiting_authors (au_id, author_name, profits)
Select au_id, Author_Name, profits
from final_results;

Select * 
from most_profiting_authors;



