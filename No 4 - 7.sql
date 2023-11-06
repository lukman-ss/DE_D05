-- Nama: Lukman
--Use movie dataset and create stored procedure or function for counting movie based on genre. Use genre as a parameter, and return the count of movie
-- No 4
CREATE OR REPLACE FUNCTION count_movies_by_genre(genre_param VARCHAR) RETURNS INTEGER AS $$
DECLARE
    movie_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO movie_count FROM movie 
        INNER JOIN movie_genres ON movie.mov_id = movie_genres.mov_id 
        INNER JOIN genres ON movie_genres.gen_id = genres.gen_id
            WHERE genres.gen_title = genre_param;
    
    RETURN movie_count;
END;
$$ LANGUAGE plpgsql;

SELECT count_movies_by_genre('Action');

--No 5
SELECT COUNT(*) AS adventure_movie_count
FROM movie AS m
JOIN movie_genres AS mg ON m.mov_id = mg.mov_id
JOIN genres AS g ON mg.gen_id = g.gen_id
WHERE g.gen_title = 'Adventure';

--No 6
--prepare
create table ninja (
    id bigint not null primary key,
    nama varchar,
    desa varchar,
    regis_date date default now(),
    email varchar,
    nilai int default 90
);

insert into ninja (id, nama, desa, email, nilai) values (1, 'naruto', 'konoha', 'naruto@mail.com', 100);
insert into ninja (id, nama, desa, email, nilai) values (2, 'gaara', 'suna', 'gaara@mail.com', 90);
insert into ninja (id, nama, desa, email, nilai) values (3, 'sasuke', 'konoha', 'sasuke@mail.com', 100);
insert into ninja (id, nama, desa, email, nilai) values (4, 'kankuro', 'suna', 'kankuro@mail.com', 70);
insert into ninja (id, nama, desa, email, nilai) values (5, 'temari', 'suna', 'temari@mail.com', 75);
insert into ninja (id, nama, desa, email, nilai) values (6, 'shikamaru', 'cianjur', 'shikamaru@mail.com', 90);
insert into ninja (id, nama, desa, email, nilai) values (7, 'ino', 'cianjur', 'ino@mail.com', 70);
insert into ninja (id, nama, desa, email, nilai) values (8, 'choji', 'cianjur', 'choji@mail.com', 85);
insert into ninja (id, nama, desa, email, nilai) values (9, 'kiba', 'cianjur', 'kiba@mail.com', 88);
insert into ninja (id, nama, desa, email, nilai) values (10, 'hinata', 'citayam', 'hinata@mail.com', 80);
insert into ninja (id, nama, desa, email, nilai) values (11, 'shino', 'citayam', 'shino@mail.com', 70);
insert into ninja (id, nama, desa, email, nilai) values (12, 'neji', 'citayam', 'neji@mail.com', 95);
insert into ninja (id, nama, desa, email, nilai) values (13, 'tenten', 'citayam', 'tenten@mail.com', 65);
insert into ninja (id, nama, desa, email, nilai) values (14, 'sakura', 'konoha', 'sakura@mail.com', 70);
insert into ninja (id, nama, desa, email, nilai) values (15, 'kakashi', 'konoha', 'kakashi@mail.com', 96);
set enable_seqscan = off
EXPLAIN ANALYZE
SELECT nama, desa
FROM ninja
WHERE email = 'naruto@mail.com';
-- Seq Scan on ninja  (cost=10000000000.00..10000000017.25 rows=3 width=64) (actual time=0.009..0.011 rows=1 loops=1)
-- Filter: ((email)::text = 'naruto@mail.com'::text)
-- Rows Removed by Filter: 14
-- Planning Time: 0.063 ms
-- Execution Time: 0.190 ms
-- set enable_seqscan = on
CREATE INDEX idx_email ON ninja (email);
EXPLAIN ANALYZE
SELECT nama, desa
FROM ninja
WHERE email = 'naruto@mail.com';
-- Index Scan using idx_email on ninja  (cost=0.14..8.15 rows=1 width=64) (actual time=0.028..0.029 rows=1 loops=1)
-- Index Cond: ((email)::text = 'naruto@mail.com'::text)
-- Planning Time: 0.843 ms
-- Execution Time: 0.044 ms
set enable_seqscan = on

--no 7
SELECT gen_title AS genre, mov_title AS title, rev_stars AS rating
FROM (
    SELECT
        g.gen_title,
        m.mov_title,
        r.rev_stars,
        RANK() OVER (PARTITION BY g.gen_title ORDER BY r.rev_stars DESC) AS rnk
    FROM genres g
    JOIN movie_genres mg ON g.gen_id = mg.gen_id
    JOIN movie m ON mg.mov_id = m.mov_id
    JOIN rating r ON m.mov_id = r.mov_id
) ranked_movies
WHERE rnk = 1;