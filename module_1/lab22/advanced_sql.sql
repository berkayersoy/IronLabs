USE publications;

#Step 1
SELECT a.au_id,
	t.title_id,
	t.advance*ta.royaltyper/100 AS advance, 
	t.price*s.qty*t.royalty/100* ta.royaltyper/100 AS royalties
FROM titles t
INNER JOIN titleauthor ta ON t.title_id=ta.title_id
INNER JOIN authors a ON a.au_id=ta.au_id
INNER JOIN sales s ON s.title_id=t.title_id;

#Step 2
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

#Step 3
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



