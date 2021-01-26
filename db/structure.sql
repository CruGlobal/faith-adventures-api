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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

--
-- Name: adventure_memberships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adventure_memberships (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    adventure_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: adventure_step_form_field_responses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adventure_step_form_field_responses (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    form_field_id uuid NOT NULL,
    user_id uuid NOT NULL,
    value text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: adventure_step_form_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adventure_step_form_fields (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    step_id uuid NOT NULL,
    type character varying NOT NULL,
    name character varying NOT NULL,
    min character varying,
    max character varying,
    required boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: adventure_steps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adventure_steps (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    adventure_id uuid NOT NULL,
    content_id uuid NOT NULL,
    "position" integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name character varying NOT NULL,
    slug character varying
);


--
-- Name: adventures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adventures (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    template_id uuid,
    content_id uuid NOT NULL,
    name character varying NOT NULL,
    description text,
    published boolean,
    locale character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    slug character varying,
    featured boolean
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: contents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contents (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    locale character varying NOT NULL,
    name character varying NOT NULL,
    description text,
    type character varying NOT NULL,
    metadata jsonb DEFAULT '"{}"'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.friendly_id_slugs (
    id bigint NOT NULL,
    slug character varying NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(50),
    scope character varying,
    created_at timestamp without time zone
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.friendly_id_slugs_id_seq OWNED BY public.friendly_id_slugs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.taggings (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    tag_id uuid,
    taggable_type character varying,
    taggable_id uuid,
    tagger_type character varying,
    tagger_id uuid,
    context character varying(128),
    created_at timestamp without time zone
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    taggings_count integer DEFAULT 0
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    sub character varying NOT NULL,
    given_name character varying,
    family_name character varying,
    nickname character varying,
    name character varying,
    picture character varying,
    locale character varying,
    email character varying,
    email_verified boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: friendly_id_slugs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('public.friendly_id_slugs_id_seq'::regclass);


--
-- Name: adventure_memberships adventure_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_memberships
    ADD CONSTRAINT adventure_memberships_pkey PRIMARY KEY (id);


--
-- Name: adventure_step_form_field_responses adventure_step_form_field_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_step_form_field_responses
    ADD CONSTRAINT adventure_step_form_field_responses_pkey PRIMARY KEY (id);


--
-- Name: adventure_step_form_fields adventure_step_form_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_step_form_fields
    ADD CONSTRAINT adventure_step_form_fields_pkey PRIMARY KEY (id);


--
-- Name: adventure_steps adventure_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_steps
    ADD CONSTRAINT adventure_steps_pkey PRIMARY KEY (id);


--
-- Name: adventures adventures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventures
    ADD CONSTRAINT adventures_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: contents contents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contents
    ADD CONSTRAINT contents_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: taggings taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_responses_on_user_and_form_field; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_responses_on_user_and_form_field ON public.adventure_step_form_field_responses USING btree (user_id, form_field_id);


--
-- Name: index_adventure_memberships_on_adventure_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adventure_memberships_on_adventure_id ON public.adventure_memberships USING btree (adventure_id);


--
-- Name: index_adventure_memberships_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adventure_memberships_on_user_id ON public.adventure_memberships USING btree (user_id);


--
-- Name: index_adventure_memberships_on_user_id_and_adventure_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_adventure_memberships_on_user_id_and_adventure_id ON public.adventure_memberships USING btree (user_id, adventure_id);


--
-- Name: index_adventure_step_form_field_responses_on_form_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adventure_step_form_field_responses_on_form_field_id ON public.adventure_step_form_field_responses USING btree (form_field_id);


--
-- Name: index_adventure_step_form_field_responses_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adventure_step_form_field_responses_on_user_id ON public.adventure_step_form_field_responses USING btree (user_id);


--
-- Name: index_adventure_step_form_fields_on_step_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adventure_step_form_fields_on_step_id ON public.adventure_step_form_fields USING btree (step_id);


--
-- Name: index_adventure_steps_on_adventure_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adventure_steps_on_adventure_id ON public.adventure_steps USING btree (adventure_id);


--
-- Name: index_adventure_steps_on_content_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adventure_steps_on_content_id ON public.adventure_steps USING btree (content_id);


--
-- Name: index_adventure_steps_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_adventure_steps_on_slug ON public.adventure_steps USING btree (slug);


--
-- Name: index_adventures_on_content_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adventures_on_content_id ON public.adventures USING btree (content_id);


--
-- Name: index_adventures_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_adventures_on_slug ON public.adventures USING btree (slug);


--
-- Name: index_adventures_on_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adventures_on_template_id ON public.adventures USING btree (template_id);


--
-- Name: index_contents_on_metadata; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contents_on_metadata ON public.contents USING gin (metadata);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON public.friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON public.friendly_id_slugs USING btree (slug, sluggable_type, scope);


--
-- Name: index_friendly_id_slugs_on_sluggable_type_and_sluggable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type_and_sluggable_id ON public.friendly_id_slugs USING btree (sluggable_type, sluggable_id);


--
-- Name: index_taggings_on_context; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_context ON public.taggings USING btree (context);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tag_id ON public.taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_id ON public.taggings USING btree (taggable_id);


--
-- Name: index_taggings_on_taggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_type ON public.taggings USING btree (taggable_type);


--
-- Name: index_taggings_on_taggable_type_and_taggable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_type_and_taggable_id ON public.taggings USING btree (taggable_type, taggable_id);


--
-- Name: index_taggings_on_tagger_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tagger_id ON public.taggings USING btree (tagger_id);


--
-- Name: index_taggings_on_tagger_id_and_tagger_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tagger_id_and_tagger_type ON public.taggings USING btree (tagger_id, tagger_type);


--
-- Name: index_taggings_on_tagger_type_and_tagger_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tagger_type_and_tagger_id ON public.taggings USING btree (tagger_type, tagger_id);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_name ON public.tags USING btree (name);


--
-- Name: index_users_on_sub; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_sub ON public.users USING btree (sub);


--
-- Name: taggings_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX taggings_idx ON public.taggings USING btree (tag_id, taggable_id, taggable_type, context, tagger_id, tagger_type);


--
-- Name: taggings_idy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggings_idy ON public.taggings USING btree (taggable_id, taggable_type, tagger_id, context);


--
-- Name: taggings_taggable_context_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggings_taggable_context_idx ON public.taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: adventure_steps fk_rails_018ee72ccf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_steps
    ADD CONSTRAINT fk_rails_018ee72ccf FOREIGN KEY (adventure_id) REFERENCES public.adventures(id) ON DELETE CASCADE;


--
-- Name: adventure_step_form_field_responses fk_rails_06ac960ac1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_step_form_field_responses
    ADD CONSTRAINT fk_rails_06ac960ac1 FOREIGN KEY (form_field_id) REFERENCES public.adventure_step_form_fields(id) ON DELETE CASCADE;


--
-- Name: adventure_step_form_field_responses fk_rails_40bcc69806; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_step_form_field_responses
    ADD CONSTRAINT fk_rails_40bcc69806 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: adventure_memberships fk_rails_7f7159f7ef; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_memberships
    ADD CONSTRAINT fk_rails_7f7159f7ef FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: adventure_step_form_fields fk_rails_891348f31b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_step_form_fields
    ADD CONSTRAINT fk_rails_891348f31b FOREIGN KEY (step_id) REFERENCES public.adventure_steps(id) ON DELETE CASCADE;


--
-- Name: taggings fk_rails_9fcd2e236b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT fk_rails_9fcd2e236b FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- Name: adventures fk_rails_b61b712b3a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventures
    ADD CONSTRAINT fk_rails_b61b712b3a FOREIGN KEY (template_id) REFERENCES public.adventures(id) ON DELETE CASCADE;


--
-- Name: adventure_memberships fk_rails_c2691b9523; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_memberships
    ADD CONSTRAINT fk_rails_c2691b9523 FOREIGN KEY (adventure_id) REFERENCES public.adventures(id) ON DELETE CASCADE;


--
-- Name: adventure_steps fk_rails_f09b31f4b4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventure_steps
    ADD CONSTRAINT fk_rails_f09b31f4b4 FOREIGN KEY (content_id) REFERENCES public.contents(id) ON DELETE CASCADE;


--
-- Name: adventures fk_rails_fcacfcb7bb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adventures
    ADD CONSTRAINT fk_rails_fcacfcb7bb FOREIGN KEY (content_id) REFERENCES public.contents(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20201208035533'),
('20201208035607'),
('20210113023355'),
('20210113023356'),
('20210113023432'),
('20210113031053'),
('20210113031054'),
('20210113031055'),
('20210113031056'),
('20210113031058'),
('20210122025325'),
('20210122025333'),
('20210122030140'),
('20210124225522'),
('20210125020142'),
('20210126034234'),
('20210126034537');


