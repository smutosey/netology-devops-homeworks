--
-- PostgreSQL database dump
--

-- Dumped from database version 13.12 (Debian 13.12-1.pgdg120+1)
-- Dumped by pg_dump version 13.12 (Debian 13.12-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: test_database; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE test_database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


\connect test_database

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
)
PARTITION BY RANGE (price);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


SET default_table_access_method = heap;

--
-- Name: orders_1; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders_1 (
    id integer DEFAULT nextval('public.orders_id_seq'::regclass) NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
);
ALTER TABLE ONLY public.orders ATTACH PARTITION public.orders_1 FOR VALUES FROM (499) TO (MAXVALUE);


--
-- Name: orders_2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders_2 (
    id integer DEFAULT nextval('public.orders_id_seq'::regclass) NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
);
ALTER TABLE ONLY public.orders ATTACH PARTITION public.orders_2 FOR VALUES FROM (MINVALUE) TO (499);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Data for Name: orders_1; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders_1 (id, title, price) FROM stdin;
2	My little database	500
6	WAL never lies	900
7	Me and my bash-pet	499
8	Dbiezdmin	501
9	partition test overprice	1001
\.


--
-- Data for Name: orders_2; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders_2 (id, title, price) FROM stdin;
1	War and peace	100
3	Adventure psql time	300
4	Server gravity falls	300
5	Log gossips	123
10	partition test lowprice	99
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 10, true);


--
-- Name: orders_pkey; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_pkey ON ONLY public.orders USING btree (id);


--
-- Name: orders_1_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_1_id_idx ON public.orders_1 USING btree (id);


--
-- Name: orders_2_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_2_id_idx ON public.orders_2 USING btree (id);


--
-- Name: orders_1_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.orders_pkey ATTACH PARTITION public.orders_1_id_idx;


--
-- Name: orders_2_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.orders_pkey ATTACH PARTITION public.orders_2_id_idx;


--
-- PostgreSQL database dump complete
--

