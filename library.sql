--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.0
-- Dumped by pg_dump version 9.5.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authors; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE authors (
    id integer NOT NULL,
    name character varying,
    email character varying
);


ALTER TABLE authors OWNER TO Guest;

--
-- Name: authors_books; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE authors_books (
    id integer NOT NULL,
    author_id integer,
    book_id integer
);


ALTER TABLE authors_books OWNER TO Guest;

--
-- Name: authors_books_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE authors_books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE authors_books_id_seq OWNER TO Guest;

--
-- Name: authors_books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE authors_books_id_seq OWNED BY authors_books.id;


--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE authors_id_seq OWNER TO Guest;

--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE authors_id_seq OWNED BY authors.id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE books (
    id integer NOT NULL,
    title character varying
);


ALTER TABLE books OWNER TO Guest;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE books_id_seq OWNER TO Guest;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE books_id_seq OWNED BY books.id;


--
-- Name: checkouts; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE checkouts (
    id integer NOT NULL,
    due_date date,
    patron_id integer,
    book_id integer
);


ALTER TABLE checkouts OWNER TO Guest;

--
-- Name: checkouts_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE checkouts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE checkouts_id_seq OWNER TO Guest;

--
-- Name: checkouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE checkouts_id_seq OWNED BY checkouts.id;


--
-- Name: patrons; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE patrons (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE patrons OWNER TO Guest;

--
-- Name: patrons_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE patrons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE patrons_id_seq OWNER TO Guest;

--
-- Name: patrons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE patrons_id_seq OWNED BY patrons.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY authors ALTER COLUMN id SET DEFAULT nextval('authors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY authors_books ALTER COLUMN id SET DEFAULT nextval('authors_books_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY books ALTER COLUMN id SET DEFAULT nextval('books_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY checkouts ALTER COLUMN id SET DEFAULT nextval('checkouts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY patrons ALTER COLUMN id SET DEFAULT nextval('patrons_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY authors (id, name, email) FROM stdin;
\.


--
-- Data for Name: authors_books; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY authors_books (id, author_id, book_id) FROM stdin;
\.


--
-- Name: authors_books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('authors_books_id_seq', 1, false);


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('authors_id_seq', 1, false);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY books (id, title) FROM stdin;
\.


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('books_id_seq', 1, false);


--
-- Data for Name: checkouts; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY checkouts (id, due_date, patron_id, book_id) FROM stdin;
\.


--
-- Name: checkouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('checkouts_id_seq', 1, false);


--
-- Data for Name: patrons; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY patrons (id, name) FROM stdin;
\.


--
-- Name: patrons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('patrons_id_seq', 1, false);


--
-- Name: authors_books_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY authors_books
    ADD CONSTRAINT authors_books_pkey PRIMARY KEY (id);


--
-- Name: authors_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: books_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: checkouts_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY checkouts
    ADD CONSTRAINT checkouts_pkey PRIMARY KEY (id);


--
-- Name: patrons_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY patrons
    ADD CONSTRAINT patrons_pkey PRIMARY KEY (id);


--
-- Name: authors_books_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY authors_books
    ADD CONSTRAINT authors_books_author_id_fkey FOREIGN KEY (author_id) REFERENCES authors(id);


--
-- Name: authors_books_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY authors_books
    ADD CONSTRAINT authors_books_book_id_fkey FOREIGN KEY (book_id) REFERENCES books(id);


--
-- Name: checkouts_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY checkouts
    ADD CONSTRAINT checkouts_book_id_fkey FOREIGN KEY (book_id) REFERENCES books(id);


--
-- Name: checkouts_patron_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY checkouts
    ADD CONSTRAINT checkouts_patron_id_fkey FOREIGN KEY (patron_id) REFERENCES patrons(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: Guest
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM Guest;
GRANT ALL ON SCHEMA public TO Guest;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
