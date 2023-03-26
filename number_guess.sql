-- PostgreSQL database dump

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

-- Set configuration settings
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

-- Drop existing database
DROP DATABASE IF EXISTS game;

-- Create a new database
CREATE DATABASE game
  WITH TEMPLATE = template0
  ENCODING = 'UTF8'
  LC_COLLATE = 'C.UTF-8'
  LC_CTYPE = 'C.UTF-8'
  OWNER = freecodecamp;

-- Connect to the new database
\connect game

-- Set configuration settings for the new database
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

-- Set default tablespace and access method
SET default_tablespace = '';
SET default_table_access_method = heap;

-- Create the games table
CREATE TABLE public.games (
    game_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    guess_number INTEGER NOT NULL,
    won BOOLEAN NOT NULL
);

-- Set the owner of the games table
ALTER TABLE public.games OWNER TO freecodecamp;

-- Create the games_game_id_seq sequence
CREATE SEQUENCE public.games_game_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

-- Set the owner of the games_game_id_seq sequence
ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

-- Set the games_game_id_seq sequence to be owned by the game_id column of the games table
ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;

-- Create the usernames table
CREATE TABLE public.usernames (
    user_id INTEGER NOT NULL,
    username VARCHAR(50) NOT NULL
);

-- Set the owner of the usernames table
ALTER TABLE public.usernames OWNER TO freecodecamp;

-- Create the usernames_user_id_seq sequence
CREATE SEQUENCE public.usernames_user_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

-- Set the owner of the usernames_user_id_seq sequence
ALTER TABLE public.usernames_user_id_seq OWNER TO freecodecamp;

-- Set the usernames_user_id_seq sequence to be owned by the user_id column of the usernames table
ALTER SEQUENCE public.usernames_user_id_seq OWNED BY public.usernames.user_id;

-- Set the default value for the game_id column of the games table
ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);

-- Set the default value for the user_id column of the usernames table
ALTER TABLE ONLY public.usernames ALTER COLUMN user_id SET DEFAULT nextval('public.usernames_user_id_seq'::regclass);
