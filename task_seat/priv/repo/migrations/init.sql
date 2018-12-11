-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: task_seats_app | type: DATABASE --
-- -- DROP DATABASE IF EXISTS task_seats_app;
-- CREATE DATABASE task_seats_app;
-- -- ddl-end --
-- COMMENT ON DATABASE task_seats_app IS 'タスクシートアプリ';
-- -- ddl-end --
-- 

-- object: public.users | type: TABLE --
-- DROP TABLE IF EXISTS public.users CASCADE;
CREATE TABLE public.users(
	id uuid NOT NULL,
	name varchar(32) NOT NULL,
	email varchar(256) NOT NULL,
	password varchar(256) NOT NULL,
	created_at timestamp with time zone NOT NULL,
	created_by uuid NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY (id),
	CONSTRAINT uq_user_email UNIQUE (email)

);
-- ddl-end --
COMMENT ON TABLE public.users IS 'ユーザー';
-- ddl-end --
ALTER TABLE public.users OWNER TO postgres;
-- ddl-end --

-- object: public.tasks | type: TABLE --
-- DROP TABLE IF EXISTS public.tasks CASCADE;
CREATE TABLE public.tasks(
	id uuid NOT NULL,
	title varchar(64) NOT NULL,
	content text NOT NULL,
	category_id uuid NOT NULL,
	sheat_id uuid NOT NULL,
	created_at timestamp with time zone NOT NULL,
	created_by uuid NOT NULL,
	modified_at timestamp with time zone NOT NULL,
	modified_by uuid NOT NULL,
	importance smallint NOT NULL,
	urgency smallint NOT NULL,
	CONSTRAINT tasks_pk PRIMARY KEY (id),
	CONSTRAINT ch_importance CHECK (-100 <= importance AND importance <= 100),
	CONSTRAINT ch_urgency CHECK (-100 <= urgency AND urgency <= 100)

);
-- ddl-end --
COMMENT ON TABLE public.tasks IS 'タスク';
-- ddl-end --
COMMENT ON COLUMN public.tasks.title IS 'タイトル';
-- ddl-end --
COMMENT ON COLUMN public.tasks.content IS '内容';
-- ddl-end --
COMMENT ON COLUMN public.tasks.importance IS '重要度';
-- ddl-end --
COMMENT ON COLUMN public.tasks.urgency IS '緊急度';
-- ddl-end --
ALTER TABLE public.tasks OWNER TO postgres;
-- ddl-end --

-- object: public.categories | type: TABLE --
-- DROP TABLE IF EXISTS public.categories CASCADE;
CREATE TABLE public.categories(
	id uuid NOT NULL,
	name varchar(16) NOT NULL,
	color varchar(32) NOT NULL,
	sheat_id uuid NOT NULL,
	created_at timestamp with time zone NOT NULL,
	created_by uuid NOT NULL,
	modified_at timestamp with time zone NOT NULL,
	modified_by uuid NOT NULL,
	CONSTRAINT task_types_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.categories IS 'タスクのカテゴリー';
-- ddl-end --
COMMENT ON COLUMN public.categories.name IS 'タイプ名';
-- ddl-end --
COMMENT ON COLUMN public.categories.sheat_id IS 'シートID';
-- ddl-end --
ALTER TABLE public.categories OWNER TO postgres;
-- ddl-end --

-- object: public.sheats | type: TABLE --
-- DROP TABLE IF EXISTS public.sheats CASCADE;
CREATE TABLE public.sheats(
	id uuid NOT NULL,
	name varchar(64) NOT NULL,
	created_at timestamp with time zone NOT NULL,
	created_by uuid NOT NULL,
	modified_at timestamp with time zone NOT NULL,
	modified_by uuid NOT NULL,
	CONSTRAINT sheats_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.sheats IS 'シート。ユーザーが複数のシートを共有できるようにしたい。';
-- ddl-end --
ALTER TABLE public.sheats OWNER TO postgres;
-- ddl-end --

-- object: public.users_sheats | type: TABLE --
-- DROP TABLE IF EXISTS public.users_sheats CASCADE;
CREATE TABLE public.users_sheats(
	user_id uuid NOT NULL,
	sheat_id uuid NOT NULL,
	CONSTRAINT uq_users_sheats UNIQUE (user_id,sheat_id)

);
-- ddl-end --
COMMENT ON TABLE public.users_sheats IS 'ユーザー:シート＝n:n';
-- ddl-end --
ALTER TABLE public.users_sheats OWNER TO postgres;
-- ddl-end --

-- object: public.system_accounts | type: TABLE --
-- DROP TABLE IF EXISTS public.system_accounts CASCADE;
CREATE TABLE public.system_accounts(
	id uuid NOT NULL,
	email varchar(256) NOT NULL,
	password varchar(256) NOT NULL,
	name varchar(64) NOT NULL,
	CONSTRAINT system_accounts_pk PRIMARY KEY (id),
	CONSTRAINT uq_system_account_email UNIQUE (email)

);
-- ddl-end --
COMMENT ON TABLE public.system_accounts IS 'システム管理用アカウント';
-- ddl-end --
ALTER TABLE public.system_accounts OWNER TO postgres;
-- ddl-end --

-- object: fk_categories | type: CONSTRAINT --
-- ALTER TABLE public.tasks DROP CONSTRAINT IF EXISTS fk_categories CASCADE;
ALTER TABLE public.tasks ADD CONSTRAINT fk_categories FOREIGN KEY (category_id)
REFERENCES public.categories (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sheats | type: CONSTRAINT --
-- ALTER TABLE public.tasks DROP CONSTRAINT IF EXISTS fk_sheats CASCADE;
ALTER TABLE public.tasks ADD CONSTRAINT fk_sheats FOREIGN KEY (sheat_id)
REFERENCES public.sheats (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sheats | type: CONSTRAINT --
-- ALTER TABLE public.categories DROP CONSTRAINT IF EXISTS fk_sheats CASCADE;
ALTER TABLE public.categories ADD CONSTRAINT fk_sheats FOREIGN KEY (sheat_id)
REFERENCES public.sheats (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE public.users_sheats DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE public.users_sheats ADD CONSTRAINT fk_users FOREIGN KEY (user_id)
REFERENCES public.users (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sheats | type: CONSTRAINT --
-- ALTER TABLE public.users_sheats DROP CONSTRAINT IF EXISTS fk_sheats CASCADE;
ALTER TABLE public.users_sheats ADD CONSTRAINT fk_sheats FOREIGN KEY (sheat_id)
REFERENCES public.sheats (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --



