PGDMP          *                t           dev_check_the_lines    9.5.1    9.5.1     W	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            X	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            Y	           1262    116194    dev_check_the_lines    DATABASE     �   CREATE DATABASE dev_check_the_lines WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
 #   DROP DATABASE dev_check_the_lines;
             MichaelRode    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            Z	           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    6            [	           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    6                        3079    12623    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            \	           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    116205    delayed_jobs    TABLE     �  CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying,
    queue character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
     DROP TABLE public.delayed_jobs;
       public         MichaelRode    false    6            �            1259    116203    delayed_jobs_id_seq    SEQUENCE     u   CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.delayed_jobs_id_seq;
       public       MichaelRode    false    6    183            ]	           0    0    delayed_jobs_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;
            public       MichaelRode    false    182            �            1259    116219    games    TABLE     U  CREATE TABLE games (
    id integer NOT NULL,
    sport character varying,
    home_team_name character varying,
    away_team_name character varying,
    date date,
    home_team_massey_line double precision,
    away_team_massey_line double precision,
    home_team_vegas_line double precision,
    away_team_vegas_line double precision,
    vegas_over_under double precision,
    massey_over_under double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    line_diff double precision,
    over_under_diff double precision
);
    DROP TABLE public.games;
       public         MichaelRode    false    6            �            1259    116217    games_id_seq    SEQUENCE     n   CREATE SEQUENCE games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.games_id_seq;
       public       MichaelRode    false    185    6            ^	           0    0    games_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE games_id_seq OWNED BY games.id;
            public       MichaelRode    false    184            �            1259    116196    schema_migrations    TABLE     K   CREATE TABLE schema_migrations (
    version character varying NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public         MichaelRode    false    6            �           2604    116208    id    DEFAULT     d   ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);
 >   ALTER TABLE public.delayed_jobs ALTER COLUMN id DROP DEFAULT;
       public       MichaelRode    false    182    183    183            �           2604    116222    id    DEFAULT     V   ALTER TABLE ONLY games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);
 7   ALTER TABLE public.games ALTER COLUMN id DROP DEFAULT;
       public       MichaelRode    false    184    185    185            R	          0    116205    delayed_jobs 
   TABLE DATA               �   COPY delayed_jobs (id, priority, attempts, handler, last_error, run_at, locked_at, failed_at, locked_by, queue, created_at, updated_at) FROM stdin;
    public       MichaelRode    false    183   �       _	           0    0    delayed_jobs_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('delayed_jobs_id_seq', 1, false);
            public       MichaelRode    false    182            T	          0    116219    games 
   TABLE DATA               �   COPY games (id, sport, home_team_name, away_team_name, date, home_team_massey_line, away_team_massey_line, home_team_vegas_line, away_team_vegas_line, vegas_over_under, massey_over_under, created_at, updated_at, line_diff, over_under_diff) FROM stdin;
    public       MichaelRode    false    185   �       `	           0    0    games_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('games_id_seq', 425, true);
            public       MichaelRode    false    184            P	          0    116196    schema_migrations 
   TABLE DATA               -   COPY schema_migrations (version) FROM stdin;
    public       MichaelRode    false    181   �       �           2606    116215    delayed_jobs_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.delayed_jobs DROP CONSTRAINT delayed_jobs_pkey;
       public         MichaelRode    false    183    183            �           2606    116227 
   games_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.games DROP CONSTRAINT games_pkey;
       public         MichaelRode    false    185    185            �           1259    116216    delayed_jobs_priority    INDEX     S   CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);
 )   DROP INDEX public.delayed_jobs_priority;
       public         MichaelRode    false    183    183            �           1259    116202    unique_schema_migrations    INDEX     Y   CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);
 ,   DROP INDEX public.unique_schema_migrations;
       public         MichaelRode    false    181            R	      x������ � �      T	   �  x�}��N�0��W�(�~���Ƈ�4i�d��Z%�i���v��8?b5:����y�F���_ۺ�����L�W��k�6�9�MA+T�pY��/³�0�G��0��]by��1bG�a�ɜD�`����*� w�9ݶZR�`�\�2��E$�B�I>z` )�Ic��N���v�l=I��c���8�Pt�h�p��7Ou���Bm�ڽk���`U�!Ah9+�2F����~�}I.�zJM!�3��@��X�Ld���f����U�7n�kW?��F9�& IE��9*	cs*��q���6(����T�I(xX8P�֐@�(�����n� S�K�����k��րU!��Y�($����2BN[��i �Ln�[~j�D���V+�Sg�B%ѻ3��@�r���jN
_R`�R�ou�<q;mu"C==�qQ�>Vq����c����Zu�΄����x�޿4�=`��U�>�MR�X�DG5gR����gBF
r�}8��ʵ��@����,"�T����� �������c�3x5�ڷ;�����gV'�i�R�1d���٨r�*EV~o٘a,W.D����O�(EO<Dhl�+�{y�X�y���P��NsWr:�)l(F9��~i���ns�mr���z�MW�(J&2l/��?���?���      P	   3   x�UǱ  �=Ǡ6	�����`�͌�XT�$��n���|͢��'��d��     