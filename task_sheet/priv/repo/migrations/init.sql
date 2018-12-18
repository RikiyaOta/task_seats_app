-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: task_sheet_app | type: DATABASE --
-- -- DROP DATABASE IF EXISTS task_sheet_app;
-- CREATE DATABASE task_sheet_app;
-- -- ddl-end --
-- COMMENT ON DATABASE task_sheet_app IS 'タスクシートアプリ';
-- -- ddl-end --
-- 

-- object: public.users | type: TABLE --
-- DROP TABLE IF EXISTS public.users CASCADE;
CREATE TABLE public.users(
	id uuid NOT NULL,
	name varchar(64) NOT NULL,
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
	content text,
	category_id uuid,
	sheet_id uuid NOT NULL,
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
	name varchar(64) NOT NULL,
	color varchar(32) NOT NULL,
	sheet_id uuid NOT NULL,
	created_at timestamp with time zone NOT NULL,
	created_by uuid NOT NULL,
	modified_at timestamp with time zone NOT NULL,
	modified_by uuid NOT NULL,
	CONSTRAINT categories_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.categories IS 'タスクのカテゴリー';
-- ddl-end --
COMMENT ON COLUMN public.categories.name IS 'タイプ名';
-- ddl-end --
COMMENT ON COLUMN public.categories.sheet_id IS 'シートID';
-- ddl-end --
ALTER TABLE public.categories OWNER TO postgres;
-- ddl-end --

-- object: public.sheets | type: TABLE --
-- DROP TABLE IF EXISTS public.sheets CASCADE;
CREATE TABLE public.sheets(
	id uuid NOT NULL,
	name varchar(64) NOT NULL,
	created_at timestamp with time zone NOT NULL,
	created_by uuid NOT NULL,
	modified_at timestamp with time zone NOT NULL,
	modified_by uuid NOT NULL,
	CONSTRAINT sheets_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.sheets IS 'シート。ユーザーが複数のシートを共有できるようにしたい。';
-- ddl-end --
ALTER TABLE public.sheets OWNER TO postgres;
-- ddl-end --

-- object: public.users_sheets | type: TABLE --
-- DROP TABLE IF EXISTS public.users_sheets CASCADE;
CREATE TABLE public.users_sheets(
	user_id uuid NOT NULL,
	sheet_id uuid NOT NULL,
	CONSTRAINT uq_users_sheets UNIQUE (user_id,sheet_id)

);
-- ddl-end --
COMMENT ON TABLE public.users_sheets IS 'ユーザー:シート＝n:n';
-- ddl-end --
ALTER TABLE public.users_sheets OWNER TO postgres;
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

-- object: public.users_tasks | type: TABLE --
-- DROP TABLE IF EXISTS public.users_tasks CASCADE;
CREATE TABLE public.users_tasks(
	user_id uuid NOT NULL,
	task_id uuid NOT NULL,
	CONSTRAINT uq_users_tasks UNIQUE (user_id,task_id)

);
-- ddl-end --
ALTER TABLE public.users_tasks OWNER TO postgres;
-- ddl-end --

-- object: fk_categories | type: CONSTRAINT --
-- ALTER TABLE public.tasks DROP CONSTRAINT IF EXISTS fk_categories CASCADE;
ALTER TABLE public.tasks ADD CONSTRAINT fk_categories FOREIGN KEY (category_id)
REFERENCES public.categories (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sheets | type: CONSTRAINT --
-- ALTER TABLE public.tasks DROP CONSTRAINT IF EXISTS fk_sheets CASCADE;
ALTER TABLE public.tasks ADD CONSTRAINT fk_sheets FOREIGN KEY (sheet_id)
REFERENCES public.sheets (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sheets | type: CONSTRAINT --
-- ALTER TABLE public.categories DROP CONSTRAINT IF EXISTS fk_sheets CASCADE;
ALTER TABLE public.categories ADD CONSTRAINT fk_sheets FOREIGN KEY (sheet_id)
REFERENCES public.sheets (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE public.users_sheets DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE public.users_sheets ADD CONSTRAINT fk_users FOREIGN KEY (user_id)
REFERENCES public.users (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sheets | type: CONSTRAINT --
-- ALTER TABLE public.users_sheets DROP CONSTRAINT IF EXISTS fk_sheets CASCADE;
ALTER TABLE public.users_sheets ADD CONSTRAINT fk_sheets FOREIGN KEY (sheet_id)
REFERENCES public.sheets (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE public.users_tasks DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE public.users_tasks ADD CONSTRAINT fk_users FOREIGN KEY (user_id)
REFERENCES public.users (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_tasks | type: CONSTRAINT --
-- ALTER TABLE public.users_tasks DROP CONSTRAINT IF EXISTS fk_tasks CASCADE;
ALTER TABLE public.users_tasks ADD CONSTRAINT fk_tasks FOREIGN KEY (task_id)
REFERENCES public.tasks (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --



