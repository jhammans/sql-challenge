BEGIN;


ALTER TABLE IF EXISTS public.employees DROP CONSTRAINT IF EXISTS employees_emp_title_id_fkey;

ALTER TABLE IF EXISTS public.dept_managers DROP CONSTRAINT IF EXISTS dept_managers_dept_no_fkey;

ALTER TABLE IF EXISTS public.dept_managers DROP CONSTRAINT IF EXISTS dept_managers_emp_no_fkey;

ALTER TABLE IF EXISTS public.dept_emp DROP CONSTRAINT IF EXISTS dept_emp_dept_no_fkey;

ALTER TABLE IF EXISTS public.dept_emp DROP CONSTRAINT IF EXISTS dept_emp_emp_no_fkey;

ALTER TABLE IF EXISTS public.salaries DROP CONSTRAINT IF EXISTS salaries_emp_no_fkey;



DROP TABLE IF EXISTS public.employees;

CREATE TABLE IF NOT EXISTS public.employees
(
    emp_no integer NOT NULL,
    emp_title_id character varying(5) COLLATE pg_catalog."default" NOT NULL,
    birth_date date NOT NULL,
    first_name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    last_name character(30) COLLATE pg_catalog."default" NOT NULL,
    sex character(1) COLLATE pg_catalog."default" NOT NULL,
    hire_date date NOT NULL,
    CONSTRAINT employees_pkey PRIMARY KEY (emp_no)
);

DROP TABLE IF EXISTS public.titles;

CREATE TABLE IF NOT EXISTS public.titles
(
    title_id character varying(5) COLLATE pg_catalog."default" NOT NULL,
    title character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT titles_pkey PRIMARY KEY (title_id)
);

DROP TABLE IF EXISTS public.dept_managers;

CREATE TABLE IF NOT EXISTS public.dept_managers
(
    dept_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    emp_no integer NOT NULL,
    CONSTRAINT dept_managers_pkey PRIMARY KEY (dept_no, emp_no)
);

DROP TABLE IF EXISTS public.departments;

CREATE TABLE IF NOT EXISTS public.departments
(
    dept_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    dept_name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT departments_pkey PRIMARY KEY (dept_no)
);

DROP TABLE IF EXISTS public.dept_emp;

CREATE TABLE IF NOT EXISTS public.dept_emp
(
    emp_no integer NOT NULL,
    dept_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT dept_emp_pkey PRIMARY KEY (emp_no, dept_no)
);

DROP TABLE IF EXISTS public.salaries;

CREATE TABLE IF NOT EXISTS public.salaries
(
    emp_no integer NOT NULL,
    salary numeric(10, 2) NOT NULL,
    CONSTRAINT salaries_pkey PRIMARY KEY (emp_no)
);

ALTER TABLE IF EXISTS public.employees
    ADD CONSTRAINT employees_emp_title_id_fkey FOREIGN KEY (emp_title_id)
    REFERENCES public.titles (title_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.dept_managers
    ADD CONSTRAINT dept_managers_dept_no_fkey FOREIGN KEY (dept_no)
    REFERENCES public.departments (dept_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.dept_managers
    ADD CONSTRAINT dept_managers_emp_no_fkey FOREIGN KEY (emp_no)
    REFERENCES public.employees (emp_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.dept_emp
    ADD CONSTRAINT dept_emp_dept_no_fkey FOREIGN KEY (dept_no)
    REFERENCES public.departments (dept_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.dept_emp
    ADD CONSTRAINT dept_emp_emp_no_fkey FOREIGN KEY (emp_no)
    REFERENCES public.employees (emp_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.salaries
    ADD CONSTRAINT salaries_emp_no_fkey FOREIGN KEY (emp_no)
    REFERENCES public.employees (emp_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS salaries_pkey
    ON public.salaries(emp_no);

END;