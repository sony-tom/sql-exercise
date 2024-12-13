SELECT b.bookmark_title,
	b.bookmark_url,
	t.tag_name
FROM bookmarks b
INNER JOIN collections c
	ON c.collection_id = b.collection_id
INNER JOIN bookmark_tags bt
	ON bt.bookmark_id = b.bookmark_id
INNER JOIN tags t
	ON t.tag_id = bt.tag_id
WHERE c.collection_name = 'Development';

SELECT t.tag_name, COUNT(t.tag_id)
FROM tags t
INNER JOIN bookmark_tags bt
	ON bt.tag_id = t.tag_id
GROUP BY t.tag_name
ORDER BY COUNT(t.tag_id) DESC
LIMIT 10;

SELECT
	c.collection_name,
	u.user_email,
	COUNT(DISTINCT b.bookmark_id)
FROM collections c
INNER JOIN users u
	ON c.owner_id = u.user_id
INNER JOIN bookmarks b
	ON b.collection_id = c.collection_id
INNER JOIN shares s
	ON s.collection_id = c.collection_id
GROUP BY c.collection_name, u.user_email;

SELECT u.user_name
FROM users u
INNER JOIN bookmarks b
	ON b.bookmark_owner_id = u.user_id
LEFT JOIN shares s
	ON s.shared_with_user_id = u.user_id
WHERE s.share_date > current_date - interval '30 days'
OR b.bookmark_date > current_date - interval '30 days'
GROUP BY u.user_name