--
-- PostgreSQL database dump
--

\restrict 27zUlcgBkbfPQKJQ53sw5JBdkfTEPLALo6hTWBgemF3JqxpLLiFHBgaPQmAWaj8

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.10 (Ubuntu 17.10-1.pgdg24.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: graphql(text, text, jsonb, jsonb); Type: FUNCTION; Schema: graphql_public; Owner: supabase_admin
--

CREATE FUNCTION graphql_public.graphql("operationName" text DEFAULT NULL::text, query text DEFAULT NULL::text, variables jsonb DEFAULT NULL::jsonb, extensions jsonb DEFAULT NULL::jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;


ALTER FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) OWNER TO supabase_admin;

--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: actualizar_ultimo_acceso_mejorado(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_ultimo_acceso_mejorado() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  UPDATE usuarios 
  SET ultimo_acceso = NOW()
  WHERE id = NEW.usuario_id;
  RETURN NEW;
EXCEPTION
  WHEN OTHERS THEN
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.actualizar_ultimo_acceso_mejorado() OWNER TO postgres;

--
-- Name: actualizar_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.actualizar_updated_at() OWNER TO postgres;

--
-- Name: calcular_siguiente_nivel(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_siguiente_nivel(puntos_actuales integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN GREATEST(1, (FLOOR(SQRT(puntos_actuales::NUMERIC / 100))::INTEGER) + 1);
END;
$$;


ALTER FUNCTION public.calcular_siguiente_nivel(puntos_actuales integer) OWNER TO postgres;

--
-- Name: calcular_tiempo_al_completar(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_tiempo_al_completar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.completado = true AND OLD.completado = false THEN
    IF NEW.iniciado_en IS NOT NULL THEN
      NEW.tiempo_dedicado := EXTRACT(EPOCH FROM (NEW.updated_at - NEW.iniciado_en))::INTEGER;
    ELSE
      NEW.tiempo_dedicado := EXTRACT(EPOCH FROM (NEW.updated_at - NEW.created_at))::INTEGER;
    END IF;
    
    IF NEW.tiempo_dedicado > 180 THEN
      NEW.tiempo_dedicado := 180;
    END IF;
    
    IF NEW.tiempo_dedicado < 10 THEN
      NEW.tiempo_dedicado := 10;
    END IF;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.calcular_tiempo_al_completar() OWNER TO postgres;

--
-- Name: calcular_tiempo_dedicado_real(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_tiempo_dedicado_real() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Solo calcular si hay fechas reales
  IF NEW.iniciado_en IS NOT NULL AND NEW.updated_at IS NOT NULL THEN
    NEW.tiempo_dedicado := EXTRACT(EPOCH FROM (NEW.updated_at - NEW.iniciado_en))::INTEGER;
  END IF;
  
  -- Si el tiempo es 0 pero está completado, poner mínimo de 30 segundos
  IF NEW.completado = true AND (NEW.tiempo_dedicado IS NULL OR NEW.tiempo_dedicado < 30) THEN
    NEW.tiempo_dedicado := 30;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.calcular_tiempo_dedicado_real() OWNER TO postgres;

--
-- Name: clasificar_estudiante(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clasificar_estudiante(p_id uuid) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_total_actividades INTEGER;
    v_promedio_progreso NUMERIC;
    v_tipo TEXT;
BEGIN
    SELECT 
        COUNT(*),
        COALESCE(AVG(progreso), 0)
    INTO 
        v_total_actividades,
        v_promedio_progreso
    FROM progreso_estudiantes
    WHERE usuario_id = p_id;
    
    IF v_total_actividades = 0 THEN
        v_tipo := CASE WHEN random() < 0.33 THEN 'excelente'
                       WHEN random() < 0.66 THEN 'intermedio'
                       ELSE 'requiere_intervencion'
                  END;
    ELSIF v_promedio_progreso >= 80 THEN
        v_tipo := 'excelente';
    ELSIF v_promedio_progreso >= 50 THEN
        v_tipo := 'intermedio';
    ELSE
        v_tipo := 'requiere_intervencion';
    END IF;
    
    RETURN v_tipo;
END;
$$;


ALTER FUNCTION public.clasificar_estudiante(p_id uuid) OWNER TO postgres;

--
-- Name: get_estado_usuario(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_estado_usuario(p_usuario_id uuid) RETURNS TABLE(nombre character varying, email character varying, rol character varying, estado_legible text, ultima_actividad timestamp without time zone)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    u.nombre,
    u.email,
    u.rol,
    CASE 
      WHEN u.rol = 'admin' AND u.ultimo_acceso > NOW() - INTERVAL '5 minutes' 
        THEN '🟢 ACTIVO AHORA'
      WHEN u.rol = 'estudiante' AND u.ultimo_acceso IS NULL 
        THEN '⚫ NUNCA CONECTADO'
      WHEN u.ultimo_acceso > NOW() - INTERVAL '1 hour' 
        THEN '🟢 HACE MENOS DE 1 HORA'
      WHEN u.ultimo_acceso > NOW() - INTERVAL '24 hours' 
        THEN '🟡 HOY'
      WHEN u.ultimo_acceso > NOW() - INTERVAL '7 days' 
        THEN '🟠 ESTA SEMANA'
      WHEN u.ultimo_acceso > NOW() - INTERVAL '30 days' 
        THEN '🔴 ESTE MES'
      ELSE '⚫ INACTIVO'
    END,
    u.ultimo_acceso
  FROM usuarios u
  WHERE u.id = p_usuario_id;
END;
$$;


ALTER FUNCTION public.get_estado_usuario(p_usuario_id uuid) OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    INSERT INTO public.usuarios (id, auth_id, nombre, usuario, email, rol, activo, created_at)
    VALUES (
        NEW.id,
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'nombre', split_part(NEW.email, '@', 1)),
        split_part(NEW.email, '@', 1),  -- Usuario = parte antes del @
        NEW.email,
        'estudiante',
        true,
        NOW()
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: obtener_todos_grupos(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_todos_grupos(user_id uuid) RETURNS uuid[]
    LANGUAGE plpgsql
    AS $$
DECLARE
  usuario_record RECORD;
  todos_grupos UUID[];
BEGIN
  SELECT grupo_id, grupos_adicionales INTO usuario_record
  FROM usuarios
  WHERE id = user_id;
  
  todos_grupos := ARRAY[]::UUID[];
  
  IF usuario_record.grupo_id IS NOT NULL THEN
    todos_grupos := ARRAY[usuario_record.grupo_id];
  END IF;
  
  IF usuario_record.grupos_adicionales IS NOT NULL 
     AND array_length(usuario_record.grupos_adicionales, 1) > 0 THEN
    todos_grupos := todos_grupos || usuario_record.grupos_adicionales;
  END IF;
  
  RETURN todos_grupos;
END;
$$;


ALTER FUNCTION public.obtener_todos_grupos(user_id uuid) OWNER TO postgres;

--
-- Name: FUNCTION obtener_todos_grupos(user_id uuid); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.obtener_todos_grupos(user_id uuid) IS 'Retorna todos los grupos de un usuario (principal + adicionales)';


--
-- Name: obtener_todos_roles(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_todos_roles(user_id uuid) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
  usuario_record RECORD;
  todos_roles TEXT[];
BEGIN
  SELECT rol, roles_adicionales INTO usuario_record
  FROM usuarios
  WHERE id = user_id;
  
  IF usuario_record.rol IS NULL THEN
    RETURN ARRAY[]::TEXT[];
  END IF;
  
  todos_roles := ARRAY[usuario_record.rol];
  
  IF usuario_record.roles_adicionales IS NOT NULL 
     AND array_length(usuario_record.roles_adicionales, 1) > 0 THEN
    todos_roles := todos_roles || usuario_record.roles_adicionales;
  END IF;
  
  RETURN todos_roles;
END;
$$;


ALTER FUNCTION public.obtener_todos_roles(user_id uuid) OWNER TO postgres;

--
-- Name: FUNCTION obtener_todos_roles(user_id uuid); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.obtener_todos_roles(user_id uuid) IS 'Retorna todos los roles de un usuario (principal + adicionales)';


--
-- Name: puntos_faltantes_proximo_nivel(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.puntos_faltantes_proximo_nivel(puntos_actuales integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  nivel_actual INTEGER;
  puntos_requeridos INTEGER;
BEGIN
  nivel_actual := calcular_siguiente_nivel(puntos_actuales);
  puntos_requeridos := puntos_para_siguiente_nivel(nivel_actual);
  RETURN GREATEST(0, puntos_requeridos - puntos_actuales);
END;
$$;


ALTER FUNCTION public.puntos_faltantes_proximo_nivel(puntos_actuales integer) OWNER TO postgres;

--
-- Name: puntos_para_siguiente_nivel(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.puntos_para_siguiente_nivel(nivel_actual integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN (POWER(nivel_actual + 1, 2) * 100)::INTEGER;
END;
$$;


ALTER FUNCTION public.puntos_para_siguiente_nivel(nivel_actual integer) OWNER TO postgres;

--
-- Name: registrar_acceso_automatico(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.registrar_acceso_automatico() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- Actualizar ultimo_acceso cada vez que el usuario hace algo en la app
  UPDATE usuarios 
  SET ultimo_acceso = NOW()
  WHERE auth_id = auth.uid();
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.registrar_acceso_automatico() OWNER TO postgres;

--
-- Name: registrar_inicio_actividad(uuid, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.registrar_inicio_actividad(p_usuario_id uuid, p_recurso_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO progreso_estudiantes (usuario_id, recurso_id, iniciado_en, created_at)
  VALUES (p_usuario_id, p_recurso_id, NOW(), NOW())
  ON CONFLICT (usuario_id, recurso_id) 
  DO UPDATE SET 
    iniciado_en = NOW(),
    updated_at = NOW()
  WHERE progreso_estudiantes.completado = false;
END;
$$;


ALTER FUNCTION public.registrar_inicio_actividad(p_usuario_id uuid, p_recurso_id uuid) OWNER TO postgres;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- Name: usuario_en_grupo(uuid, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.usuario_en_grupo(user_id uuid, target_grupo_id uuid) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  usuario_record RECORD;
BEGIN
  SELECT grupo_id, grupos_adicionales INTO usuario_record
  FROM usuarios
  WHERE id = user_id;
  
  IF usuario_record.grupo_id = target_grupo_id THEN
    RETURN TRUE;
  END IF;
  
  IF target_grupo_id = ANY(usuario_record.grupos_adicionales) THEN
    RETURN TRUE;
  END IF;
  
  RETURN FALSE;
END;
$$;


ALTER FUNCTION public.usuario_en_grupo(user_id uuid, target_grupo_id uuid) OWNER TO postgres;

--
-- Name: FUNCTION usuario_en_grupo(user_id uuid, target_grupo_id uuid); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.usuario_en_grupo(user_id uuid, target_grupo_id uuid) IS 'Verifica si un usuario pertenece a un grupo (principal o adicional)';


--
-- Name: usuario_tiene_rol(uuid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.usuario_tiene_rol(user_id uuid, target_rol text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  usuario_record RECORD;
BEGIN
  SELECT rol, roles_adicionales INTO usuario_record
  FROM usuarios
  WHERE id = user_id;
  
  IF usuario_record.rol = target_rol THEN
    RETURN TRUE;
  END IF;
  
  IF target_rol = ANY(usuario_record.roles_adicionales) THEN
    RETURN TRUE;
  END IF;
  
  RETURN FALSE;
END;
$$;


ALTER FUNCTION public.usuario_tiene_rol(user_id uuid, target_rol text) OWNER TO postgres;

--
-- Name: FUNCTION usuario_tiene_rol(user_id uuid, target_rol text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.usuario_tiene_rol(user_id uuid, target_rol text) IS 'Verifica si un usuario tiene un rol específico (principal o adicional)';


--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
    -- Regclass of the table e.g. public.notes
    entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

    -- I, U, D, T: insert, update ...
    action realtime.action = (
        case wal ->> 'action'
            when 'I' then 'INSERT'
            when 'U' then 'UPDATE'
            when 'D' then 'DELETE'
            else 'ERROR'
        end
    );

    -- Is row level security enabled for the table
    is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

    subscriptions realtime.subscription[] = array_agg(subs)
        from
            realtime.subscription subs
        where
            subs.entity = entity_
            -- Filter by action early - only get subscriptions interested in this action
            -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
            and (subs.action_filter = '*' or subs.action_filter = action::text);

    -- Subscription vars
    working_role regrole;
    working_selected_columns text[];
    claimed_role regrole;
    claims jsonb;

    subscription_id uuid;
    subscription_has_access bool;
    visible_to_subscription_ids uuid[] = '{}';

    -- structured info for wal's columns
    columns realtime.wal_column[];
    -- previous identity values for update/delete
    old_columns realtime.wal_column[];

    error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

    -- Primary jsonb output for record
    output jsonb;

    -- Loop record for iterating unique roles (outer loop)
    role_record record;
    -- Loop record for iterating unique selected_columns within a role (inner loop)
    cols_record record;
    -- Subscription ids visible at the role level (before fanning out by selected_columns)
    visible_role_sub_ids uuid[] = '{}';

begin
    perform set_config('role', null, true);

    columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'columns') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    old_columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'identity') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    for role_record in
        select claims_role
        from (select distinct claims_role from unnest(subscriptions)) t
        order by claims_role::text
    loop
        working_role := role_record.claims_role;

        -- Update `is_selectable` for columns and old_columns (once per role)
        columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(columns) c;

        old_columns =
                array_agg(
                    (
                        c.name,
                        c.type_name,
                        c.type_oid,
                        c.value,
                        c.is_pkey,
                        pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                    )::realtime.wal_column
                )
                from
                    unnest(old_columns) c;

        if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
            -- Fan out 400 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;
            end loop;

        -- The claims role does not have SELECT permission to the primary key of entity
        elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
            -- Fan out 401 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;
            end loop;

        else
            -- Create the prepared statement (once per role)
            if is_rls_enabled and action <> 'DELETE' then
                if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                    deallocate walrus_rls_stmt;
                end if;
                execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
            end if;

            -- Collect all visible subscription IDs for this role (filter check + RLS check)
            visible_role_sub_ids = '{}';

            for subscription_id, claims in (
                    select
                        subs.subscription_id,
                        subs.claims
                    from
                        unnest(subscriptions) subs
                    where
                        subs.entity = entity_
                        and subs.claims_role = working_role
                        and (
                            realtime.is_visible_through_filters(columns, subs.filters)
                            or (
                              action = 'DELETE'
                              and realtime.is_visible_through_filters(old_columns, subs.filters)
                            )
                        )
            ) loop

                if not is_rls_enabled or action = 'DELETE' then
                    visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                else
                    -- Check if RLS allows the role to see the record
                    perform
                        -- Trim leading and trailing quotes from working_role because set_config
                        -- doesn't recognize the role as valid if they are included
                        set_config('role', trim(both '"' from working_role::text), true),
                        set_config('request.jwt.claims', claims::text, true);

                    execute 'execute walrus_rls_stmt' into subscription_has_access;

                    if subscription_has_access then
                        visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                    end if;
                end if;
            end loop;

            perform set_config('role', null, true);

            -- Inner loop: per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;

                output = jsonb_build_object(
                    'schema', wal ->> 'schema',
                    'table', wal ->> 'table',
                    'type', action,
                    'commit_timestamp', to_char(
                        ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                        'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
                    ),
                    'columns', (
                        select
                            jsonb_agg(
                                jsonb_build_object(
                                    'name', pa.attname,
                                    'type', pt.typname
                                )
                                order by pa.attnum asc
                            )
                        from
                            pg_attribute pa
                            join pg_type pt
                                on pa.atttypid = pt.oid
                            left join (
                                select unnest(conkey) as pkey_attnum
                                from pg_constraint
                                where conrelid = entity_ and contype = 'p'
                            ) pk on pk.pkey_attnum = pa.attnum
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                            and (working_selected_columns is null or pa.attname = any(working_selected_columns) or pk.pkey_attnum is not null)
                    )
                )
                -- Add "record" key for insert and update
                || case
                    when action in ('INSERT', 'UPDATE') then
                        jsonb_build_object(
                            'record',
                            (
                                select
                                    jsonb_object_agg(
                                        -- if unchanged toast, get column name and value from old record
                                        coalesce((c).name, (oc).name),
                                        case
                                            when (c).name is null then (oc).value
                                            else (c).value
                                        end
                                    )
                                from
                                    unnest(columns) c
                                    full outer join unnest(old_columns) oc
                                        on (c).name = (oc).name
                                where
                                    coalesce((c).is_selectable, (oc).is_selectable)
                                    and (working_selected_columns is null or coalesce((c).name, (oc).name) = any(working_selected_columns) or coalesce((c).is_pkey, (oc).is_pkey))
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            )
                        )
                    else '{}'::jsonb
                end
                -- Add "old_record" key for update and delete
                || case
                    when action = 'UPDATE' then
                        jsonb_build_object(
                                'old_record',
                                (
                                    select jsonb_object_agg((c).name, (c).value)
                                    from unnest(old_columns) c
                                    where
                                        (c).is_selectable
                                        and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                        and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                )
                            )
                    when action = 'DELETE' then
                        jsonb_build_object(
                            'old_record',
                            (
                                select jsonb_object_agg((c).name, (c).value)
                                from unnest(old_columns) c
                                where
                                    (c).is_selectable
                                    and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Filter visible_role_sub_ids to those matching the current selected_columns group
                visible_to_subscription_ids = coalesce(
                    (
                        select array_agg(s.subscription_id)
                        from unnest(subscriptions) s
                        where s.claims_role = working_role
                          and (s.selected_columns is not distinct from working_selected_columns)
                          and s.subscription_id = any(visible_role_sub_ids)
                    ),
                    '{}'::uuid[]
                );

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;
            end loop;

        end if;
    end loop;

    perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  SELECT
    realtime.wal2json_escape_identifier(nsp.nspname::text)
    || '.'
    || realtime.wal2json_escape_identifier(pc.relname::text)
  FROM pg_class pc
  JOIN pg_namespace nsp ON pc.relnamespace = nsp.oid
  WHERE pc.oid = entity
$$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: send_binary(bytea, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, binary_payload, event, topic, private, extension)
    VALUES (generated_id, payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
    col_names text[] = coalesce(
            array_agg(c.column_name order by c.ordinal_position),
            '{}'::text[]
        )
        from
            information_schema.columns c
        where
            format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
            and pg_catalog.has_column_privilege(
                (new.claims ->> 'role'),
                format('%I.%I', c.table_schema, c.table_name)::regclass,
                c.column_name,
                'SELECT'
            );
    table_col_names text[] = coalesce(
            array_agg(pa.attname),
            '{}'::text[]
        )
        from
            pg_attribute pa
        where
            pa.attrelid = new.entity
            and pa.attnum > 0;
    filter realtime.user_defined_filter;
    col_type regtype;
    in_val jsonb;
    selected_col text;
begin
    for filter in select * from unnest(new.filters) loop
        -- Filtered column is valid
        if not filter.column_name = any(col_names) then
            raise exception 'invalid column for filter %', filter.column_name;
        end if;

        -- Type is sanitized and safe for string interpolation
        col_type = (
            select atttypid::regtype
            from pg_catalog.pg_attribute
            where attrelid = new.entity
                  and attname = filter.column_name
        );
        if col_type is null then
            raise exception 'failed to lookup type for column %', filter.column_name;
        end if;
        if filter.op = 'in'::realtime.equality_op then
            in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
            if coalesce(jsonb_array_length(in_val), 0) > 100 then
                raise exception 'too many values for `in` filter. Maximum 100';
            end if;
        else
            -- raises an exception if value is not coercable to type
            perform realtime.cast(filter.value, col_type);
        end if;
    end loop;

    -- Validate that selected_columns reference columns the role can SELECT
    if new.selected_columns is not null then
        for selected_col in select * from unnest(new.selected_columns) loop
            if not selected_col = any(col_names) then
                raise exception 'invalid column for select %', selected_col;
            end if;
        end loop;
    end if;

    -- Apply consistent order to filters so the unique constraint on
    -- (subscription_id, entity, filters) can't be tricked by a different filter order
    new.filters = coalesce(
        array_agg(f order by f.column_name, f.op, f.value),
        '{}'
    ) from unnest(new.filters) f;

    -- Normalize selected_columns order so ARRAY['a','b'] and ARRAY['b','a'] are
    -- treated as the same subscription group in apply_rls
    new.selected_columns = (
        select array_agg(c order by c)
        from unnest(new.selected_columns) c
    );

    return new;
end;
$$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: wal2json_escape_identifier(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.wal2json_escape_identifier(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  -- Prefix `\`, `,`, `.`, and any whitespace with `\`
  SELECT regexp_replace(name, '([\\,.[:space:]])', '\\\1', 'g')
$$;


ALTER FUNCTION realtime.wal2json_escape_identifier(name text) OWNER TO supabase_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Get the last path segment (the actual filename)
    SELECT _parts[array_length(_parts, 1)] INTO _filename;
    -- Extract extension: reverse, split on '.', then reverse again
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint)::bigint as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: actividad_diaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actividad_diaria (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    usuario_id uuid,
    fecha date DEFAULT CURRENT_DATE,
    puntos_ganados integer DEFAULT 0,
    recursos_completados integer DEFAULT 0,
    quizzes_completados integer DEFAULT 0,
    logros_obtenidos integer DEFAULT 0,
    tiempo_estudiado integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.actividad_diaria OWNER TO postgres;

--
-- Name: auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditoria (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    tabla character varying(100) NOT NULL,
    operacion character varying(10) NOT NULL,
    usuario_id uuid,
    registro_id uuid,
    datos_anteriores jsonb,
    datos_nuevos jsonb,
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.auditoria OWNER TO postgres;

--
-- Name: biblioteca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.biblioteca (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text,
    tipo_archivo character varying(50) NOT NULL,
    url_archivo text NOT NULL,
    "tamaño_archivo" integer,
    categoria character varying(100),
    tags text[],
    subido_por uuid,
    descargas integer DEFAULT 0,
    publico boolean DEFAULT true,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.biblioteca OWNER TO postgres;

--
-- Name: contenido_favoritos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contenido_favoritos (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    contenido_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.contenido_favoritos OWNER TO postgres;

--
-- Name: contenido_favoritos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.contenido_favoritos ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contenido_favoritos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contenido_generado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contenido_generado (
    id bigint NOT NULL,
    type text NOT NULL,
    prompt text NOT NULL,
    title text NOT NULL,
    content jsonb NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    status text DEFAULT 'generated'::text
);


ALTER TABLE public.contenido_generado OWNER TO postgres;

--
-- Name: contenido_generado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.contenido_generado ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contenido_generado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contenido_usos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contenido_usos (
    id bigint NOT NULL,
    contenido_id bigint NOT NULL,
    usuario_id uuid NOT NULL,
    tipo_uso text NOT NULL,
    detalles jsonb,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.contenido_usos OWNER TO postgres;

--
-- Name: contenido_usos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.contenido_usos ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contenido_usos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cursos (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text,
    nivel_id uuid,
    imagen_url text,
    color character varying(7) DEFAULT '#3B82F6'::character varying,
    orden integer DEFAULT 1,
    activo boolean DEFAULT true,
    created_by uuid,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cursos OWNER TO postgres;

--
-- Name: progreso_estudiantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.progreso_estudiantes (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    usuario_id uuid,
    recurso_id uuid,
    completado boolean DEFAULT false,
    tiempo_dedicado integer DEFAULT 0,
    puntuacion integer,
    mejor_puntuacion integer DEFAULT 0,
    respuestas_quiz jsonb,
    fecha_completado timestamp without time zone,
    intentos integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    progreso integer DEFAULT 0,
    retroalimentacion text,
    respuestas_dadas jsonb DEFAULT '{}'::jsonb,
    iniciado_en timestamp without time zone DEFAULT now()
);


ALTER TABLE public.progreso_estudiantes OWNER TO postgres;

--
-- Name: puntos_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.puntos_usuario (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    usuario_id uuid,
    puntos_totales integer DEFAULT 0,
    experiencia integer DEFAULT 0,
    nivel_actual integer DEFAULT 1,
    racha_dias integer DEFAULT 0,
    ultima_actividad date DEFAULT CURRENT_DATE,
    estadisticas jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.puntos_usuario OWNER TO postgres;

--
-- Name: recursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recursos (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text,
    tipo character varying(50) NOT NULL,
    url text,
    contenido jsonb,
    contenido_quiz jsonb,
    metadata jsonb DEFAULT '{}'::jsonb,
    dificultad character varying(20) DEFAULT 'media'::character varying,
    curso_id uuid,
    orden integer DEFAULT 1,
    puntos_recompensa integer DEFAULT 10,
    tiempo_estimado integer DEFAULT 5,
    activo boolean DEFAULT true,
    created_by uuid,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT recursos_dificultad_check CHECK (((dificultad)::text = ANY ((ARRAY['facil'::character varying, 'media'::character varying, 'dificil'::character varying])::text[]))),
    CONSTRAINT recursos_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['video'::character varying, 'imagen'::character varying, 'pdf'::character varying, 'audio'::character varying, 'interactivo'::character varying, 'juego'::character varying, 'quiz'::character varying])::text[])))
);


ALTER TABLE public.recursos OWNER TO postgres;

--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    auth_id uuid,
    nombre text NOT NULL,
    email text,
    rol text DEFAULT 'visitante'::text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    roles_adicionales text[] DEFAULT '{}'::text[],
    grupo_id uuid,
    activo boolean DEFAULT true,
    ultimo_acceso timestamp without time zone,
    puntos_totales integer DEFAULT 0,
    grupos_adicionales uuid[] DEFAULT '{}'::uuid[],
    usuario character varying(255),
    CONSTRAINT usuarios_rol_check CHECK ((rol = ANY (ARRAY['admin'::text, 'docente'::text, 'estudiante'::text, 'visitante'::text])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: COLUMN usuarios.roles_adicionales; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.usuarios.roles_adicionales IS 'Roles adicionales del usuario';


--
-- Name: COLUMN usuarios.ultimo_acceso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.usuarios.ultimo_acceso IS 'Timestamp del último acceso';


--
-- Name: COLUMN usuarios.grupos_adicionales; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.usuarios.grupos_adicionales IS 'Grupos adicionales del usuario';


--
-- Name: usuarios_logros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios_logros (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    usuario_id uuid,
    logro_id uuid,
    progreso integer DEFAULT 0,
    completado boolean DEFAULT false,
    fecha_obtenido timestamp without time zone DEFAULT now()
);


ALTER TABLE public.usuarios_logros OWNER TO postgres;

--
-- Name: estadisticas_usuario_optimizada; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.estadisticas_usuario_optimizada AS
 SELECT u.id AS usuario_id,
    u.nombre,
    u.email,
    COALESCE(pu.puntos_totales, 0) AS puntos_totales,
    COALESCE(pu.nivel_actual, 1) AS nivel_actual,
    COALESCE(pu.racha_dias, 0) AS racha_dias,
    ( SELECT count(*) AS count
           FROM public.progreso_estudiantes
          WHERE ((progreso_estudiantes.usuario_id = u.id) AND (progreso_estudiantes.completado = true))) AS recursos_completados,
    ( SELECT count(*) AS count
           FROM (public.progreso_estudiantes pe
             JOIN public.recursos r ON ((pe.recurso_id = r.id)))
          WHERE ((pe.usuario_id = u.id) AND (pe.completado = true) AND ((r.tipo)::text = 'quiz'::text))) AS quizzes_completados,
    ( SELECT COALESCE(round(avg(progreso_estudiantes.puntuacion), 2), (0)::numeric) AS "coalesce"
           FROM public.progreso_estudiantes
          WHERE ((progreso_estudiantes.usuario_id = u.id) AND (progreso_estudiantes.puntuacion IS NOT NULL))) AS promedio_puntuacion,
    ( SELECT COALESCE(sum(progreso_estudiantes.tiempo_dedicado), (0)::bigint) AS "coalesce"
           FROM public.progreso_estudiantes
          WHERE (progreso_estudiantes.usuario_id = u.id)) AS total_tiempo_estudiado,
    ( SELECT count(*) AS count
           FROM public.usuarios_logros
          WHERE ((usuarios_logros.usuario_id = u.id) AND (usuarios_logros.completado = true))) AS logros_obtenidos,
    now() AS updated_at
   FROM (public.usuarios u
     LEFT JOIN public.puntos_usuario pu ON ((u.id = pu.usuario_id)))
  WHERE ((u.activo = true) AND (u.rol = 'estudiante'::text))
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.estadisticas_usuario_optimizada OWNER TO postgres;

--
-- Name: evaluaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluaciones (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text,
    curso_id uuid,
    preguntas jsonb NOT NULL,
    puntuacion_maxima integer DEFAULT 100,
    tiempo_limite integer,
    intentos_permitidos integer DEFAULT 3,
    activo boolean DEFAULT true,
    created_by uuid,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.evaluaciones OWNER TO postgres;

--
-- Name: foros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.foros (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text,
    curso_id uuid,
    nivel_id uuid,
    created_by uuid,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.foros OWNER TO postgres;

--
-- Name: grupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupos (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.grupos OWNER TO postgres;

--
-- Name: TABLE grupos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.grupos IS 'Grupos de estudiantes';


--
-- Name: logros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logros (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion text,
    icono character varying(50) DEFAULT 'star'::character varying,
    color character varying(7) DEFAULT '#FFD700'::character varying,
    condicion jsonb,
    puntos_requeridos integer,
    puntos_recompensa integer DEFAULT 50,
    rareza character varying(20) DEFAULT 'comun'::character varying,
    categoria character varying(50) DEFAULT 'general'::character varying,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT logros_rareza_check CHECK (((rareza)::text = ANY ((ARRAY['comun'::character varying, 'raro'::character varying, 'epico'::character varying, 'legendario'::character varying])::text[])))
);


ALTER TABLE public.logros OWNER TO postgres;

--
-- Name: mensajes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensajes (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    usuario_id uuid,
    destinatario_id uuid,
    curso_id uuid,
    tipo character varying(20) DEFAULT 'privado'::character varying,
    mensaje text NOT NULL,
    leido boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT mensajes_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['privado'::character varying, 'curso'::character varying, 'global'::character varying])::text[])))
);


ALTER TABLE public.mensajes OWNER TO postgres;

--
-- Name: mentorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mentorias (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    mentor_id uuid,
    estudiante_id uuid,
    curso_id uuid,
    estado character varying(20) DEFAULT 'activa'::character varying,
    notas text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT mentorias_estado_check CHECK (((estado)::text = ANY ((ARRAY['activa'::character varying, 'pausada'::character varying, 'completada'::character varying])::text[])))
);


ALTER TABLE public.mentorias OWNER TO postgres;

--
-- Name: niveles_aprendizaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.niveles_aprendizaje (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion text,
    orden integer DEFAULT 1,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.niveles_aprendizaje OWNER TO postgres;

--
-- Name: publicaciones_foro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publicaciones_foro (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    foro_id uuid,
    usuario_id uuid,
    titulo character varying(255),
    contenido text NOT NULL,
    padre_id uuid,
    likes integer DEFAULT 0,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.publicaciones_foro OWNER TO postgres;

--
-- Name: ranking_estudiantes_v2; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ranking_estudiantes_v2 AS
 SELECT u.id,
    u.nombre,
    u.email,
    COALESCE(pu.puntos_totales, 0) AS puntos_totales,
    COALESCE(pu.nivel_actual, 1) AS nivel_actual,
    COALESCE(pu.racha_dias, 0) AS racha_dias,
    COALESCE(eu.recursos_completados, (0)::bigint) AS recursos_completados,
    COALESCE(eu.logros_obtenidos, (0)::bigint) AS logros_obtenidos,
    public.puntos_faltantes_proximo_nivel(COALESCE(pu.puntos_totales, 0)) AS puntos_faltantes,
    rank() OVER (ORDER BY COALESCE(pu.puntos_totales, 0) DESC) AS posicion
   FROM ((public.usuarios u
     LEFT JOIN public.puntos_usuario pu ON ((u.id = pu.usuario_id)))
     LEFT JOIN public.estadisticas_usuario_optimizada eu ON ((u.id = eu.usuario_id)))
  WHERE ((u.rol = 'estudiante'::text) AND (u.activo = true))
  ORDER BY COALESCE(pu.puntos_totales, 0) DESC;


ALTER VIEW public.ranking_estudiantes_v2 OWNER TO postgres;

--
-- Name: resultados_evaluaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resultados_evaluaciones (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    evaluacion_id uuid,
    usuario_id uuid,
    respuestas jsonb NOT NULL,
    puntuacion integer NOT NULL,
    porcentaje numeric(5,2) NOT NULL,
    tiempo_dedicado integer,
    intento_numero integer DEFAULT 1,
    aprobado boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.resultados_evaluaciones OWNER TO postgres;

--
-- Name: vista_usuarios_completa; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_usuarios_completa AS
 SELECT u.id,
    u.auth_id,
    u.nombre,
    u.email,
    u.rol AS rol_principal,
    u.roles_adicionales,
    public.obtener_todos_roles(u.id) AS todos_roles,
    u.grupo_id AS grupo_principal,
    g.nombre AS nombre_grupo_principal,
    u.grupos_adicionales,
    public.obtener_todos_grupos(u.id) AS todos_grupos,
    u.activo,
    u.ultimo_acceso,
    u.puntos_totales,
    u.created_at,
    u.updated_at,
        CASE
            WHEN (u.ultimo_acceso IS NULL) THEN 'Nunca conectado'::text
            WHEN (u.ultimo_acceso > (now() - '00:05:00'::interval)) THEN 'En línea'::text
            WHEN (u.ultimo_acceso > (now() - '00:30:00'::interval)) THEN 'Activo'::text
            WHEN (u.ultimo_acceso > (now() - '24:00:00'::interval)) THEN 'Inactivo hoy'::text
            WHEN (u.ultimo_acceso > (now() - '7 days'::interval)) THEN 'Inactivo esta semana'::text
            ELSE 'Inactivo'::text
        END AS estado_conexion
   FROM (public.usuarios u
     LEFT JOIN public.grupos g ON ((u.grupo_id = g.id)));


ALTER VIEW public.vista_usuarios_completa OWNER TO postgres;

--
-- Name: VIEW vista_usuarios_completa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.vista_usuarios_completa IS 'Vista completa con estado en tiempo real';


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    selected_columns text[],
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	d96525fa-94d8-4925-9c75-e98196cf758f	{"action":"user_confirmation_requested","actor_id":"541ff02c-b5cf-4e99-bdfb-c3aedc499e89","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-04 04:10:40.493448+00	
00000000-0000-0000-0000-000000000000	fefc0dda-79fe-482a-801f-931439a93590	{"action":"user_confirmation_requested","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-04 04:11:56.279426+00	
00000000-0000-0000-0000-000000000000	ae689069-e3dd-4be7-b08f-49ffc09fd4ab	{"action":"user_signedup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-04 04:12:44.143177+00	
00000000-0000-0000-0000-000000000000	7976fc2f-e997-41dc-a1ef-7c0d9209436c	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-04 04:13:07.216129+00	
00000000-0000-0000-0000-000000000000	f381f94a-61d6-47bf-abb5-8d5046aaeda3	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-04 05:26:31.283368+00	
00000000-0000-0000-0000-000000000000	c5d437bd-98ae-411c-8d82-369560d4d221	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-04 05:26:31.304705+00	
00000000-0000-0000-0000-000000000000	0196077c-d579-4042-976b-cb65bd82a8af	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-04 06:18:24.532687+00	
00000000-0000-0000-0000-000000000000	4f623f62-9192-423f-bf99-9d9785a579fc	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-04 06:18:24.545933+00	
00000000-0000-0000-0000-000000000000	65162ea0-d09b-46c9-8ece-3e393e14cfcb	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-04 06:34:11.983084+00	
00000000-0000-0000-0000-000000000000	22c84e88-7b8e-4c8d-a7db-b22719aaa37f	{"action":"user_recovery_requested","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-09-04 06:38:11.044191+00	
00000000-0000-0000-0000-000000000000	b0b02088-3576-4e3a-bdf8-edc88b4fa713	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-04 06:38:49.413997+00	
00000000-0000-0000-0000-000000000000	c4ea6f5c-d7ba-49d8-9034-79631a09ec42	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-04 06:40:32.265971+00	
00000000-0000-0000-0000-000000000000	692b7d50-b722-42eb-bc55-858bb816d300	{"action":"logout","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-04 06:40:53.688274+00	
00000000-0000-0000-0000-000000000000	eeb961a2-e03e-4155-9886-730d390e2c81	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-04 06:43:26.142292+00	
00000000-0000-0000-0000-000000000000	87088bf6-d8eb-41f5-8949-3b6bcf518851	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-04 06:51:52.467205+00	
00000000-0000-0000-0000-000000000000	4ebc39a7-6f34-417c-af88-dd3d124bad5e	{"action":"user_confirmation_requested","actor_id":"ba1ecd50-7365-4132-849c-14ec50aca273","actor_username":"tatiana.zambrano@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-04 15:26:02.807708+00	
00000000-0000-0000-0000-000000000000	6f99c48f-8ea8-499e-bf49-eb1e219a8aac	{"action":"user_confirmation_requested","actor_id":"79ee110f-89e4-46d5-a1c4-83a569a93d34","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-04 15:26:30.005522+00	
00000000-0000-0000-0000-000000000000	557d9c6f-0dec-459c-959b-bcc6a6e75618	{"action":"user_confirmation_requested","actor_id":"79ee110f-89e4-46d5-a1c4-83a569a93d34","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-04 15:29:47.953025+00	
00000000-0000-0000-0000-000000000000	a1775fe1-159b-4dd6-8f4a-474ede874342	{"action":"user_signedup","actor_id":"79ee110f-89e4-46d5-a1c4-83a569a93d34","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-04 15:30:47.104394+00	
00000000-0000-0000-0000-000000000000	0f8267ce-22c3-464a-802c-9dd6ec8afeea	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-04 15:31:37.304747+00	
00000000-0000-0000-0000-000000000000	9188ea37-b535-476d-9a19-61a80ede476a	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 00:09:43.277722+00	
00000000-0000-0000-0000-000000000000	4976f76d-7c44-4c0e-be91-5109ce1384a6	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 00:09:43.285263+00	
00000000-0000-0000-0000-000000000000	a74167d6-3f3f-4a24-9f85-9b6a2005540b	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 00:10:00.361907+00	
00000000-0000-0000-0000-000000000000	c7550211-cbab-41e7-893a-23e4eb2a6b17	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 03:36:26.861827+00	
00000000-0000-0000-0000-000000000000	81e2a6b6-9494-4b8a-8a77-d95ea8619e7f	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 03:36:26.886584+00	
00000000-0000-0000-0000-000000000000	28ace3b2-e39b-4dc8-a423-25dbda32da80	{"action":"user_confirmation_requested","actor_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 03:36:57.93027+00	
00000000-0000-0000-0000-000000000000	247d99db-851c-4e24-b2ca-930631486e65	{"action":"user_confirmation_requested","actor_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 03:42:37.054058+00	
00000000-0000-0000-0000-000000000000	fe2e2ce3-12e2-4d03-a69c-9c3bbbfd0347	{"action":"user_confirmation_requested","actor_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 03:43:37.691405+00	
00000000-0000-0000-0000-000000000000	ce97a1c3-51ea-4ee5-a590-e27703b5ac46	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 03:46:10.815756+00	
00000000-0000-0000-0000-000000000000	da1f084e-621b-498f-9063-5e7ef4df3878	{"action":"user_repeated_signup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 03:47:15.152593+00	
00000000-0000-0000-0000-000000000000	c6b16bf7-0887-48dc-8dca-50e26d342c45	{"action":"user_repeated_signup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 03:49:52.841878+00	
00000000-0000-0000-0000-000000000000	a081cc74-2159-488b-a4ac-dcd02f2fa05b	{"action":"user_repeated_signup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 03:49:56.934524+00	
00000000-0000-0000-0000-000000000000	b1599265-ad3e-484c-b057-7de3bc5efce9	{"action":"user_repeated_signup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 03:49:58.233402+00	
00000000-0000-0000-0000-000000000000	9a2da3cb-0e93-4709-b010-6a6082d1c47a	{"action":"user_repeated_signup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 03:51:49.350819+00	
00000000-0000-0000-0000-000000000000	0dc644fd-629c-4d1e-9b4c-a6b0a4e273a8	{"action":"user_repeated_signup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 03:54:31.353362+00	
00000000-0000-0000-0000-000000000000	19dec860-b08a-48e2-8ed4-39e6e81ae879	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 04:53:43.360948+00	
00000000-0000-0000-0000-000000000000	2db2ac90-77e4-42cb-b68f-4c1e737bbf34	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 04:53:43.380708+00	
00000000-0000-0000-0000-000000000000	4da40b90-9d89-4aae-99b0-f5464be17bee	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 18:38:01.332744+00	
00000000-0000-0000-0000-000000000000	95e9bee9-d777-4e7d-b36a-a1629b78f544	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 18:38:01.344397+00	
00000000-0000-0000-0000-000000000000	7cbd0311-1066-4926-a801-1ccec0a79d26	{"action":"user_repeated_signup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 18:38:05.996911+00	
00000000-0000-0000-0000-000000000000	feefe616-010f-4214-a600-cba71e0ba264	{"action":"user_confirmation_requested","actor_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 18:46:59.584883+00	
00000000-0000-0000-0000-000000000000	f0ed22a0-938a-4e4f-9da6-1904317656fb	{"action":"user_confirmation_requested","actor_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 18:55:15.984729+00	
00000000-0000-0000-0000-000000000000	40c7692f-c069-425a-b1cf-76d1ecb15cb4	{"action":"user_confirmation_requested","actor_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 19:04:13.387009+00	
00000000-0000-0000-0000-000000000000	1148573e-d71e-4e76-a50e-77704345a1fa	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 19:52:02.502543+00	
00000000-0000-0000-0000-000000000000	9af51841-21e3-46b6-8c96-9c3331891ac2	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 19:52:02.509357+00	
00000000-0000-0000-0000-000000000000	cd2e9435-e1ff-40bd-8beb-c1cf6d8714fa	{"action":"user_repeated_signup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 19:52:35.058302+00	
00000000-0000-0000-0000-000000000000	5d4d3eec-f1e7-4b69-93f6-4e43df9adfc0	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 20:34:10.858115+00	
00000000-0000-0000-0000-000000000000	f60f7875-e2f9-4a12-9dff-3f6939d3a2a3	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 21:40:08.950189+00	
00000000-0000-0000-0000-000000000000	31209d37-77a2-48a6-a4d6-91b2c4538d74	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 21:40:08.958477+00	
00000000-0000-0000-0000-000000000000	d1ec5f57-7741-424e-834f-4058e44f0a1f	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-05 21:40:11.010399+00	
00000000-0000-0000-0000-000000000000	744c2df6-eb49-475b-950a-dde2b8e1f350	{"action":"logout","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-05 21:40:14.237859+00	
00000000-0000-0000-0000-000000000000	d821827e-2aff-494c-ae1e-85d4fe1fd93e	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 21:40:38.197396+00	
00000000-0000-0000-0000-000000000000	5c22a95f-5af4-41b9-9686-60e06f924af6	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 21:41:18.401712+00	
00000000-0000-0000-0000-000000000000	abcac16b-fdd6-43fc-aa49-47a90ead027a	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 21:43:53.427323+00	
00000000-0000-0000-0000-000000000000	25ecded3-1618-4f4d-9552-728f54a031e1	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 21:44:15.010673+00	
00000000-0000-0000-0000-000000000000	984798f3-3d3c-4386-a00e-77235d970d11	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 21:48:53.382435+00	
00000000-0000-0000-0000-000000000000	15de5278-d8bc-4a5e-ad8f-39c1523160ae	{"action":"user_repeated_signup","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 21:49:28.156813+00	
00000000-0000-0000-0000-000000000000	3c8bc1c5-3f2b-40f2-bae6-3087829c0f23	{"action":"user_confirmation_requested","actor_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 21:57:49.186404+00	
00000000-0000-0000-0000-000000000000	2813e8fa-b71d-44bb-9013-581d25d75b90	{"action":"user_signedup","actor_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-05 21:59:43.503969+00	
00000000-0000-0000-0000-000000000000	7491b5fa-18e8-42cc-911d-1773533735a6	{"action":"login","actor_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 21:59:53.409371+00	
00000000-0000-0000-0000-000000000000	fcda0595-52ef-4a88-a0b3-c66254c9c698	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 22:18:23.100156+00	
00000000-0000-0000-0000-000000000000	066360d7-1bf4-4bac-a401-d465c84f662f	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 22:23:53.002981+00	
00000000-0000-0000-0000-000000000000	904be31b-11a2-442c-95ad-a6cd0f852fec	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-05 22:25:27.266039+00	
00000000-0000-0000-0000-000000000000	fc143e27-171e-4a8a-b09e-e89b9cbd6490	{"action":"user_confirmation_requested","actor_id":"3ac2ad1d-0918-422c-b24e-5b4e68e4f699","actor_username":"yanelly_2003@hotmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-05 22:26:36.587401+00	
00000000-0000-0000-0000-000000000000	a78c6c00-92e0-406b-ac02-02a8171fab38	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 00:05:24.359555+00	
00000000-0000-0000-0000-000000000000	88fcf70b-06b3-4290-b393-85d010961794	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 00:05:24.370182+00	
00000000-0000-0000-0000-000000000000	48cb8f89-544d-47fa-be4f-a4d9915e2c25	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 03:16:44.122524+00	
00000000-0000-0000-0000-000000000000	6578ff70-ff14-4a4c-9ea0-13fe680a5a45	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 03:16:44.130474+00	
00000000-0000-0000-0000-000000000000	2618a47c-aa7a-40c5-92c8-75a5bd9a1d10	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 04:27:35.880143+00	
00000000-0000-0000-0000-000000000000	1c2e9ea4-5033-47cd-a99f-2aeff57a1fab	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 04:27:35.900705+00	
00000000-0000-0000-0000-000000000000	ec3017eb-21d0-4300-a9ed-7578f2e5c442	{"action":"user_confirmation_requested","actor_id":"80bdb7b2-1124-48e2-ac29-c56185132960","actor_username":"merarteaga1967@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-06 06:00:24.207875+00	
00000000-0000-0000-0000-000000000000	6444d4c8-a297-4433-9da0-fd595b141968	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:00:48.054238+00	
00000000-0000-0000-0000-000000000000	b964c52c-9589-4d1d-9f8b-66ae1e72a43a	{"action":"logout","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-06 06:00:59.776041+00	
00000000-0000-0000-0000-000000000000	3df834d2-c38a-4c32-92bd-b9a6661f7a5d	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:34:33.648206+00	
00000000-0000-0000-0000-000000000000	cc2fc448-80c7-4bd4-bd20-c10061c109a8	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:34:40.165901+00	
00000000-0000-0000-0000-000000000000	19abdf1f-03d8-4130-a16b-afc70f61f1b6	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:39:52.968082+00	
00000000-0000-0000-0000-000000000000	b4f5df71-e8ec-47df-ac6c-300dbbd957ab	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:14.673449+00	
00000000-0000-0000-0000-000000000000	d2a7bc2b-5e1f-4d93-95e1-5743eb0e5143	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:17.104872+00	
00000000-0000-0000-0000-000000000000	b40b9f8f-57a7-4263-bda2-b3a3da1fe2f2	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:18.476398+00	
00000000-0000-0000-0000-000000000000	66e2af1f-8a4d-4bef-b108-b412d2fc0516	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:19.37919+00	
00000000-0000-0000-0000-000000000000	2116de33-b14f-4cad-9f3c-a685ed3770c3	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:19.984325+00	
00000000-0000-0000-0000-000000000000	371d8df8-ccae-401b-842d-32dfbd666ec7	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:20.761664+00	
00000000-0000-0000-0000-000000000000	c9d80792-42ab-43d1-9920-cfc12604ad3c	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:21.524454+00	
00000000-0000-0000-0000-000000000000	3e44b9fa-bdfb-4045-a347-46bb2bef8776	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:22.252949+00	
00000000-0000-0000-0000-000000000000	ad7551ac-6e77-4402-912e-1ba22b348082	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:22.833936+00	
00000000-0000-0000-0000-000000000000	2538be52-c2f9-4615-988d-14e5b80996c1	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:23.820388+00	
00000000-0000-0000-0000-000000000000	db88e6c0-dae0-4148-9cb8-b9f49064cc67	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-06 06:52:24.40287+00	
00000000-0000-0000-0000-000000000000	ad00bda0-f9f9-42c6-985f-0a91452374cf	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 16:46:21.980704+00	
00000000-0000-0000-0000-000000000000	8ea7f275-c5c2-478b-ae30-2df2dc386318	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 16:46:22.004066+00	
00000000-0000-0000-0000-000000000000	ac455c6d-813c-41ac-a4ac-a77e4aadaf33	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 20:57:33.032976+00	
00000000-0000-0000-0000-000000000000	3a8cb87b-40fe-4b22-a1f8-a29870512555	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 20:57:33.049355+00	
00000000-0000-0000-0000-000000000000	59f8cfce-6574-4d6d-b652-d1535dc1c2e2	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 22:28:18.14376+00	
00000000-0000-0000-0000-000000000000	a04065d2-8604-4960-b640-8d761bcb68c8	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-06 22:28:18.156558+00	
00000000-0000-0000-0000-000000000000	ad10aae7-43ff-4202-b0d4-5f93921ad638	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-07 20:28:53.581704+00	
00000000-0000-0000-0000-000000000000	219d049f-a80c-496a-afab-f31b6283b632	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-07 20:28:53.611712+00	
00000000-0000-0000-0000-000000000000	fd99596b-1fae-4148-8f58-947161a3eefb	{"action":"token_refreshed","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-07 22:42:56.441925+00	
00000000-0000-0000-0000-000000000000	315333ad-bd3d-456b-8480-a63ae3dbdee0	{"action":"token_revoked","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-07 22:42:56.45722+00	
00000000-0000-0000-0000-000000000000	045542b3-3d4b-40bb-b225-ce543d5b6fe4	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 22:44:52.21191+00	
00000000-0000-0000-0000-000000000000	5ebcd8df-c8fe-42bf-a180-da9c6dd82a16	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:07:07.642678+00	
00000000-0000-0000-0000-000000000000	99824141-0e16-4f1e-bc9f-ca61afea57b7	{"action":"login","actor_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:07:14.207939+00	
00000000-0000-0000-0000-000000000000	a42fb65c-aaba-4952-ac8b-a7dfaaeeeee4	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"tatiana.zambrano@utm.edu.ec","user_id":"79ee110f-89e4-46d5-a1c4-83a569a93d34","user_phone":""}}	2025-09-07 23:14:44.562621+00	
00000000-0000-0000-0000-000000000000	3e5ce41d-0cc0-45e1-abe8-572181791a74	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"merarteaga1967@gmail.com","user_id":"80bdb7b2-1124-48e2-ac29-c56185132960","user_phone":""}}	2025-09-07 23:14:44.561186+00	
00000000-0000-0000-0000-000000000000	7b9f4e52-8706-4c97-b775-35e6619ea139	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"arteagayanelly23@gmail.com","user_id":"6a2af269-7042-4448-90e0-1d8e8703b52d","user_phone":""}}	2025-09-07 23:14:44.56111+00	
00000000-0000-0000-0000-000000000000	673b17d1-94d0-4d53-9d60-57cd012f66b8	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"tatiana.zambrano@gmail.com","user_id":"ba1ecd50-7365-4132-849c-14ec50aca273","user_phone":""}}	2025-09-07 23:14:44.565562+00	
00000000-0000-0000-0000-000000000000	3923d889-1f80-4f36-8ee5-00abe7b05563	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ynlldom@gmail.com","user_id":"3eebc50d-2b9b-4edb-9c10-7ece50996cd4","user_phone":""}}	2025-09-07 23:14:44.562143+00	
00000000-0000-0000-0000-000000000000	d9b650b7-97bc-4909-aef3-d7eff22d1531	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"yanelly_2003@hotmail.com","user_id":"3ac2ad1d-0918-422c-b24e-5b4e68e4f699","user_phone":""}}	2025-09-07 23:14:44.569867+00	
00000000-0000-0000-0000-000000000000	9db4d8a7-0491-432e-98fd-990ed517b0cd	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin@admin.com","user_id":"541ff02c-b5cf-4e99-bdfb-c3aedc499e89","user_phone":""}}	2025-09-07 23:14:44.586949+00	
00000000-0000-0000-0000-000000000000	6ea570ef-daf9-441f-bd04-571069adf132	{"action":"user_confirmation_requested","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-07 23:24:21.525172+00	
00000000-0000-0000-0000-000000000000	2706951a-eec7-4ce8-bce4-7244e93ef744	{"action":"user_signedup","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-07 23:24:59.68657+00	
00000000-0000-0000-0000-000000000000	7b77889c-0044-4012-8017-98c7da76e0a6	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:25:04.287827+00	
00000000-0000-0000-0000-000000000000	d7299ac0-0528-4358-a6d1-0df354e4e8f2	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:25:06.18305+00	
00000000-0000-0000-0000-000000000000	babbc4a0-a28f-4acb-9103-7d1a692f00e5	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:25:21.019516+00	
00000000-0000-0000-0000-000000000000	34a81ca7-6a21-43c4-b583-43275a9dde2a	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:31:56.347575+00	
00000000-0000-0000-0000-000000000000	a6ef70e5-9370-4332-aa90-495279d38ede	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:32:05.587733+00	
00000000-0000-0000-0000-000000000000	26061f8c-a2e7-421e-a8cd-2f9d879d274d	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:32:07.224656+00	
00000000-0000-0000-0000-000000000000	67402ca5-2991-4073-abf3-537508cc18a6	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:40:32.135741+00	
00000000-0000-0000-0000-000000000000	30d7b11c-9e8e-4ba4-a580-5324cab04c39	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:40:34.662055+00	
00000000-0000-0000-0000-000000000000	465573c9-535b-4c3f-9f56-95416094e6f1	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:40:35.838722+00	
00000000-0000-0000-0000-000000000000	105397be-f7a3-4e1c-97df-2c814e54f4b3	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:40:36.968037+00	
00000000-0000-0000-0000-000000000000	ee990576-3d64-43a5-beee-33831f573995	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-07 23:44:32.597516+00	
00000000-0000-0000-0000-000000000000	6000dcb0-472f-43c7-8123-bcdd5357e536	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:16:30.352807+00	
00000000-0000-0000-0000-000000000000	bd403cfd-209e-46b7-95dd-f051fa633517	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:16:32.242778+00	
00000000-0000-0000-0000-000000000000	4b61fe67-a394-46f3-8399-316d549eb7e3	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:19:56.990933+00	
00000000-0000-0000-0000-000000000000	81b6987b-720e-420a-8eb4-b06c3be1ab53	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:23:35.985719+00	
00000000-0000-0000-0000-000000000000	711d33ee-702d-4455-9e7f-df68e5e3bb51	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:23:38.138748+00	
00000000-0000-0000-0000-000000000000	98b21cd3-9b8e-4f5f-8df7-26521be0c4ff	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:23:39.851445+00	
00000000-0000-0000-0000-000000000000	8d591b03-d996-4b9b-b3af-ba745b71bfc7	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:23:45.395312+00	
00000000-0000-0000-0000-000000000000	0dfac621-9258-4d4b-9fe7-e69eaacb627a	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:23:47.789146+00	
00000000-0000-0000-0000-000000000000	d90d79d6-6b03-4371-b1f0-2511adc93208	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:24:24.872407+00	
00000000-0000-0000-0000-000000000000	f3031a1e-3927-4e1e-b6da-7ee7c11c8835	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:24:26.715022+00	
00000000-0000-0000-0000-000000000000	62fb2edc-ae8d-4948-83a5-2ff6075a0f62	{"action":"user_confirmation_requested","actor_id":"f31e86f7-14f7-433c-aee2-902bc3c7dfbf","actor_username":"arteagayanlly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-08 00:50:27.056122+00	
00000000-0000-0000-0000-000000000000	5728dd58-5ae6-4dac-b4ce-a0b1a52ae38c	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"arteagayanlly23@gmail.com","user_id":"f31e86f7-14f7-433c-aee2-902bc3c7dfbf","user_phone":""}}	2025-09-08 00:55:57.627088+00	
00000000-0000-0000-0000-000000000000	c526db86-03f5-4ea2-8b88-627a6b0a602b	{"action":"user_confirmation_requested","actor_id":"8da2758c-c134-487a-870b-273536b63486","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-08 00:56:34.891062+00	
00000000-0000-0000-0000-000000000000	ff3c7f20-5cb8-4ef2-b032-e9beb1d137fe	{"action":"user_signedup","actor_id":"8da2758c-c134-487a-870b-273536b63486","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-08 00:56:53.993427+00	
00000000-0000-0000-0000-000000000000	3377db42-8424-4b5e-8c1c-4e213874a2b9	{"action":"login","actor_id":"8da2758c-c134-487a-870b-273536b63486","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 00:56:57.232122+00	
00000000-0000-0000-0000-000000000000	b262a9e3-9230-4551-9566-7a10f25b1794	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 01:02:51.776675+00	
00000000-0000-0000-0000-000000000000	9e490747-231c-463e-a0e4-d5790473048d	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-08 01:03:02.581451+00	
00000000-0000-0000-0000-000000000000	2a96bd06-f8f3-4f10-b86c-7f827909cb37	{"action":"login","actor_id":"8da2758c-c134-487a-870b-273536b63486","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 01:03:36.300684+00	
00000000-0000-0000-0000-000000000000	a0ad152a-9a2b-485b-87f8-55d0406e4810	{"action":"logout","actor_id":"8da2758c-c134-487a-870b-273536b63486","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-08 01:07:12.495122+00	
00000000-0000-0000-0000-000000000000	ad62c881-342f-4c65-9b54-e964dec8c463	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 01:07:35.876898+00	
00000000-0000-0000-0000-000000000000	e8e1cba2-282d-4285-8197-ff9f2898398a	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-08 01:10:50.300541+00	
00000000-0000-0000-0000-000000000000	cede4698-897e-40ed-8878-87c7facfb11b	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 01:28:04.788934+00	
00000000-0000-0000-0000-000000000000	3014057f-a7e2-45e5-95e7-89915e81f5fa	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-08 01:32:42.383307+00	
00000000-0000-0000-0000-000000000000	3cac6ab6-45ae-4f9c-8e88-b44a34538bc3	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-08 03:08:55.063855+00	
00000000-0000-0000-0000-000000000000	1665f0a3-28f1-43b6-81fc-da746136bb54	{"action":"token_refreshed","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-08 06:00:30.246165+00	
00000000-0000-0000-0000-000000000000	8a578567-9e8e-4940-8137-a4aca28a4b95	{"action":"token_revoked","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-08 06:00:30.274281+00	
00000000-0000-0000-0000-000000000000	143b9ea4-c368-4d30-92b7-7ee60870db4a	{"action":"token_refreshed","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-08 08:41:29.366772+00	
00000000-0000-0000-0000-000000000000	3a1125e2-8663-4695-bf4a-e5ed244d4f3e	{"action":"token_revoked","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-08 08:41:29.388352+00	
00000000-0000-0000-0000-000000000000	0f67d180-d61e-4a65-8678-928fc21d6715	{"action":"token_refreshed","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-08 09:48:59.962722+00	
00000000-0000-0000-0000-000000000000	1b8cb90b-9b11-495d-ae28-75f15230547d	{"action":"token_revoked","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-08 09:48:59.983103+00	
00000000-0000-0000-0000-000000000000	c165a283-9b8b-4a2e-bf4c-c1c856da9301	{"action":"token_refreshed","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-08 19:41:27.379937+00	
00000000-0000-0000-0000-000000000000	d1978bdc-5dbd-42d0-96b9-87f13e7d4d88	{"action":"token_revoked","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-08 19:41:27.402039+00	
00000000-0000-0000-0000-000000000000	63847f87-c3cb-44db-b7b1-b9ed22271701	{"action":"token_refreshed","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-10 01:15:28.178103+00	
00000000-0000-0000-0000-000000000000	ee434be4-e101-4310-bfda-c85e379c37e9	{"action":"token_revoked","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-10 01:15:28.203403+00	
00000000-0000-0000-0000-000000000000	95681af6-a314-40ce-b900-9704f60914c9	{"action":"token_refreshed","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-10 02:17:01.651211+00	
00000000-0000-0000-0000-000000000000	a1915666-593b-4bfe-bd6b-0f291003fb8a	{"action":"token_revoked","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-10 02:17:01.664302+00	
00000000-0000-0000-0000-000000000000	bff12755-e893-4eb8-8070-53d4d0fa97d3	{"action":"token_refreshed","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-10 03:18:34.911616+00	
00000000-0000-0000-0000-000000000000	7ee4581c-82e4-48cf-bf69-782ce18babb9	{"action":"token_revoked","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-10 03:18:34.931681+00	
00000000-0000-0000-0000-000000000000	d911490f-cc95-4bc1-a8d1-3807549edf6f	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-10 03:41:25.946836+00	
00000000-0000-0000-0000-000000000000	42c950ea-b928-46be-9dd2-48ed99824588	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-10 06:31:01.145127+00	
00000000-0000-0000-0000-000000000000	17fde7c1-a281-4fe3-8754-fb3a058a040e	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-10 06:31:11.489703+00	
00000000-0000-0000-0000-000000000000	39acbe7f-da15-4dfb-84e1-f37493ef56df	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-10 08:34:20.735991+00	
00000000-0000-0000-0000-000000000000	793e0410-083c-4629-88e2-4d962fe36367	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-10 08:38:37.163658+00	
00000000-0000-0000-0000-000000000000	24515d2f-3cda-4456-928f-3e10f49d5e48	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-10 09:58:32.818019+00	
00000000-0000-0000-0000-000000000000	6150641c-afd3-46d2-8574-4169acb25920	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-10 09:58:40.327511+00	
00000000-0000-0000-0000-000000000000	60531ca1-345a-4b19-8af7-d7b33c0943fd	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-10 20:26:05.62605+00	
00000000-0000-0000-0000-000000000000	0218cdff-dac3-432b-936b-58a9c58133fb	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-10 20:26:25.395197+00	
00000000-0000-0000-0000-000000000000	da6f5d8d-a51a-496a-97f5-4bb30c41a40f	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-11 21:44:26.365535+00	
00000000-0000-0000-0000-000000000000	07cf05c8-a8a1-4f34-aa58-af6ce6842a52	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-11 21:50:50.089656+00	
00000000-0000-0000-0000-000000000000	53a48245-a2d7-49d4-a2d5-e1b04a02b028	{"action":"user_confirmation_requested","actor_id":"ab2b5a55-cf48-498a-ae6e-2e74a9717edd","actor_username":"puchi.merart@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-11 21:51:41.269419+00	
00000000-0000-0000-0000-000000000000	66070d18-d575-4b0a-9eac-b8ef31587336	{"action":"user_signedup","actor_id":"ab2b5a55-cf48-498a-ae6e-2e74a9717edd","actor_username":"puchi.merart@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-11 21:53:40.562414+00	
00000000-0000-0000-0000-000000000000	4fd6724b-d260-446e-8ddc-9d8412eb99c0	{"action":"login","actor_id":"ab2b5a55-cf48-498a-ae6e-2e74a9717edd","actor_username":"puchi.merart@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-11 21:53:49.879125+00	
00000000-0000-0000-0000-000000000000	f9d283f7-7a9e-4ba5-94d7-991b68373462	{"action":"logout","actor_id":"ab2b5a55-cf48-498a-ae6e-2e74a9717edd","actor_username":"puchi.merart@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-11 22:09:20.565934+00	
00000000-0000-0000-0000-000000000000	f4b572d2-a421-4c47-a92c-89b88c81babf	{"action":"user_confirmation_requested","actor_id":"96095a22-8de6-47b0-bbca-69e220b2764c","actor_username":"merarteaga1967@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-13 19:27:55.705125+00	
00000000-0000-0000-0000-000000000000	27a8739a-034a-4576-9897-e25e01b6bbdc	{"action":"login","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-15 21:12:44.700404+00	
00000000-0000-0000-0000-000000000000	46c7e015-9f18-4034-bbac-120d9156b80a	{"action":"token_refreshed","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-15 22:03:35.800544+00	
00000000-0000-0000-0000-000000000000	24fd2c31-e1b8-4b6a-91f1-b6228289fa79	{"action":"token_revoked","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-15 22:03:35.814767+00	
00000000-0000-0000-0000-000000000000	1c6608b5-8d34-4676-9e8b-65f8d500a9ba	{"action":"logout","actor_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-15 22:05:06.749253+00	
00000000-0000-0000-0000-000000000000	320e9440-0e5f-4b3f-8276-daf38692f3c0	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ynlldom@gmail.com","user_id":"24fb4a46-a234-4334-bfaf-8c39d1aaf762","user_phone":""}}	2025-09-15 22:05:21.649329+00	
00000000-0000-0000-0000-000000000000	55275436-7ff9-400a-ace3-3317cb7ab05e	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"puchi.merart@gmail.com","user_id":"ab2b5a55-cf48-498a-ae6e-2e74a9717edd","user_phone":""}}	2025-09-15 22:05:21.66781+00	
00000000-0000-0000-0000-000000000000	6b91c559-5f0d-40b1-a0a6-2b430daa779f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"merarteaga1967@gmail.com","user_id":"96095a22-8de6-47b0-bbca-69e220b2764c","user_phone":""}}	2025-09-15 22:05:21.685326+00	
00000000-0000-0000-0000-000000000000	46fcfc01-3818-44d0-909f-4a18bb651b34	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"arteagayanelly23@gmail.com","user_id":"8da2758c-c134-487a-870b-273536b63486","user_phone":""}}	2025-09-15 22:05:21.684643+00	
00000000-0000-0000-0000-000000000000	154bdca6-c3e5-4860-a832-c796044af0a6	{"action":"user_confirmation_requested","actor_id":"48f0ee69-2a54-49d1-87e2-d2b5b60ec7d5","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-15 22:07:31.774362+00	
00000000-0000-0000-0000-000000000000	bc4cf781-38fb-4d83-9c56-c6b11b288312	{"action":"user_confirmation_requested","actor_id":"48f0ee69-2a54-49d1-87e2-d2b5b60ec7d5","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-15 22:22:10.826997+00	
00000000-0000-0000-0000-000000000000	a8bcc67f-79c3-48c7-9a7a-caaf35d7d0f3	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ynlldom@gmail.com","user_id":"48f0ee69-2a54-49d1-87e2-d2b5b60ec7d5","user_phone":""}}	2025-09-16 02:42:23.293423+00	
00000000-0000-0000-0000-000000000000	cad67f10-bee0-426c-baef-c7da7a229265	{"action":"user_confirmation_requested","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-16 02:46:02.534484+00	
00000000-0000-0000-0000-000000000000	6f623da1-2f77-4ec3-81df-db866bce7c7c	{"action":"user_confirmation_requested","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-16 02:49:37.822669+00	
00000000-0000-0000-0000-000000000000	6bf8366b-625b-4181-b5d6-b0067410ae1c	{"action":"user_confirmation_requested","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-16 03:03:47.766737+00	
00000000-0000-0000-0000-000000000000	88864f28-c1c8-4acd-9503-ebd6cc160ea5	{"action":"user_signedup","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-16 03:17:28.538996+00	
00000000-0000-0000-0000-000000000000	687f5d32-f7b3-48ee-8db0-13b276d872e7	{"action":"login","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-16 03:17:38.695647+00	
00000000-0000-0000-0000-000000000000	80da4ba9-6d0b-47f2-a004-2abb24b8bf7d	{"action":"logout","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-16 03:30:49.165771+00	
00000000-0000-0000-0000-000000000000	348d71ae-695e-4f2e-858d-ef94f7a9b362	{"action":"login","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-16 20:59:12.179042+00	
00000000-0000-0000-0000-000000000000	d8057f30-b0d3-492e-a283-a8f93df3ba93	{"action":"logout","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-16 21:01:25.776792+00	
00000000-0000-0000-0000-000000000000	bb81fd27-a4a5-4c85-a5d6-02b7435311a0	{"action":"login","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-16 21:01:43.229298+00	
00000000-0000-0000-0000-000000000000	037b1aec-f65f-4142-a49b-880afa84a082	{"action":"login","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-16 21:07:50.826694+00	
00000000-0000-0000-0000-000000000000	a46c7030-4ea6-48b4-9edd-01abbdc92471	{"action":"logout","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-16 21:12:46.98269+00	
00000000-0000-0000-0000-000000000000	e5bc5076-742c-4161-8009-e7be44817a9f	{"action":"login","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-16 21:13:26.11124+00	
00000000-0000-0000-0000-000000000000	325500f7-6778-4907-bd7b-13c8f343b65f	{"action":"logout","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-16 21:15:46.551922+00	
00000000-0000-0000-0000-000000000000	bf5a9e95-2838-4313-a82b-726581fbc8ab	{"action":"user_confirmation_requested","actor_id":"b5beb0c1-0b3a-4324-a344-8a38268e6612","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-16 21:16:52.150288+00	
00000000-0000-0000-0000-000000000000	2d443d2c-256c-49cc-9c41-bf1c79034959	{"action":"user_confirmation_requested","actor_id":"a59764fe-4a1d-45cf-95c5-ed87e5c6490e","actor_username":"domyanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-16 21:56:10.444331+00	
00000000-0000-0000-0000-000000000000	7b9b1868-79b5-4b6b-829b-d7f73b373787	{"action":"login","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-16 22:33:09.696308+00	
00000000-0000-0000-0000-000000000000	1b493ec8-cd65-4a54-8bdd-b17e5fb5488f	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-16 23:27:01.632764+00	
00000000-0000-0000-0000-000000000000	d7478095-3aa1-477c-beb8-c29897b99d1a	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-16 23:27:01.646584+00	
00000000-0000-0000-0000-000000000000	fc6d53cb-4368-48fc-86aa-6212913dd6a8	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-17 00:15:27.323098+00	
00000000-0000-0000-0000-000000000000	57c14736-f62b-49f7-8fa3-2f8c8cb53957	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-17 00:15:27.342408+00	
00000000-0000-0000-0000-000000000000	aedad7d6-903a-422b-b7cd-b607ff36c30c	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 22:26:59.743512+00	
00000000-0000-0000-0000-000000000000	29e98069-5e46-4642-bc8f-f1e4357d161c	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 22:26:59.760938+00	
00000000-0000-0000-0000-000000000000	5a087246-3f63-4755-b093-62c309fadde3	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 23:18:15.120998+00	
00000000-0000-0000-0000-000000000000	a543c3bf-b61e-48f6-95d6-dbe0cc30415d	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 23:18:15.13621+00	
00000000-0000-0000-0000-000000000000	11b53d2d-e01f-4431-84e8-5962b566df1d	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-10 00:06:03.043166+00	
00000000-0000-0000-0000-000000000000	9e491bcd-d5c4-48a4-887f-702f53cb2998	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-10 00:06:03.061059+00	
00000000-0000-0000-0000-000000000000	c58904c3-6642-40d4-9764-9a1990e3eecc	{"action":"logout","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-10 00:14:13.232641+00	
00000000-0000-0000-0000-000000000000	6d439228-e2c7-4b43-8bfe-bc2a76af3840	{"action":"user_confirmation_requested","actor_id":"367cfd8e-427e-4204-8616-bda115628aa0","actor_username":"merarteaga1967@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-10 03:04:14.380009+00	
00000000-0000-0000-0000-000000000000	ebcdf48d-2a5a-4a71-9579-9160f21d137e	{"action":"user_signedup","actor_id":"367cfd8e-427e-4204-8616-bda115628aa0","actor_username":"merarteaga1967@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-10 03:21:58.799509+00	
00000000-0000-0000-0000-000000000000	305383d3-e56f-402e-822a-1384ed230a3d	{"action":"login","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-10 04:49:37.39606+00	
00000000-0000-0000-0000-000000000000	58f1a130-d5bf-4ccb-909c-76df14ef5cb4	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-10 05:50:39.6755+00	
00000000-0000-0000-0000-000000000000	b388c015-5192-4999-a1c1-492819670515	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-10 05:50:39.69189+00	
00000000-0000-0000-0000-000000000000	0e514bd0-8cdf-466b-87f8-b70f9d600436	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 03:33:37.749166+00	
00000000-0000-0000-0000-000000000000	0b202f5c-115d-4a19-b3d9-c4b18f814430	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 03:33:37.761947+00	
00000000-0000-0000-0000-000000000000	9bcbdb1a-b4b6-4784-ab69-b80155979395	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 04:33:29.35348+00	
00000000-0000-0000-0000-000000000000	c3efcc68-0cc7-4818-8f5a-25501326b3b1	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 04:33:29.369756+00	
00000000-0000-0000-0000-000000000000	35feea72-43f4-4dd3-a3bc-ed7b93137576	{"action":"login","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-12 04:39:51.892957+00	
00000000-0000-0000-0000-000000000000	770148a5-aa4c-44b4-b9c3-abc06a99adcb	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 05:28:12.567347+00	
00000000-0000-0000-0000-000000000000	cce61d0d-0858-4238-8c6b-295eff7d73de	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 05:28:12.582841+00	
00000000-0000-0000-0000-000000000000	acf0f0c5-6636-4a5b-9d58-d26374ce1749	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 06:17:09.635891+00	
00000000-0000-0000-0000-000000000000	a3f4459f-a9fd-44cf-996c-a2e88f7900b7	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 06:17:09.657746+00	
00000000-0000-0000-0000-000000000000	9eaa6c5f-4c99-4b87-b8ac-2e4d0553e482	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 08:25:20.483077+00	
00000000-0000-0000-0000-000000000000	1a35d592-22e0-4ae9-a403-9590cd79edeb	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-12 08:25:20.506658+00	
00000000-0000-0000-0000-000000000000	7b6131b8-404a-4a7b-a7c2-0efb3161bdac	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 19:53:44.91821+00	
00000000-0000-0000-0000-000000000000	679d465f-410d-4479-abb8-5a8df4ba47ac	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 19:53:44.937964+00	
00000000-0000-0000-0000-000000000000	c995ae72-787c-4a67-a9ea-2db3a36b08ca	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 20:52:24.817376+00	
00000000-0000-0000-0000-000000000000	bdc9b2f5-d70a-4ccb-bfb1-e221fd2b5634	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 20:52:24.831128+00	
00000000-0000-0000-0000-000000000000	ef9b2c80-d00a-49a4-bd8f-dace2a7ea47f	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 23:21:08.310689+00	
00000000-0000-0000-0000-000000000000	b29252c9-2956-47dc-92d2-1caecec77295	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 23:21:08.330787+00	
00000000-0000-0000-0000-000000000000	d5b3d9c7-aa3c-4cbb-97a5-edf18aca24e6	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 00:47:21.774892+00	
00000000-0000-0000-0000-000000000000	6f171cf4-68ad-4628-b4c1-cb043b8860b4	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 00:47:21.793081+00	
00000000-0000-0000-0000-000000000000	9d6180c2-5743-4b66-b946-0fab62f7b67e	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 01:44:37.795768+00	
00000000-0000-0000-0000-000000000000	ce560251-8862-426d-b3ad-174f68ba133a	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 01:44:37.807511+00	
00000000-0000-0000-0000-000000000000	1370e3a7-c5e1-49d3-b423-bd15b703f18d	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 03:13:43.41263+00	
00000000-0000-0000-0000-000000000000	b6bc8695-f416-4fee-be5c-b27e675ab2bd	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 03:13:43.434932+00	
00000000-0000-0000-0000-000000000000	0ff283ea-d50f-4770-b95d-60f663b770bb	{"action":"token_refreshed","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 04:10:28.149149+00	
00000000-0000-0000-0000-000000000000	43f3e67e-55d6-4006-9d42-677863d83ecb	{"action":"token_revoked","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 04:10:28.158979+00	
00000000-0000-0000-0000-000000000000	09e87c21-7171-4f98-a069-caf5558d6b49	{"action":"logout","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 04:12:42.766915+00	
00000000-0000-0000-0000-000000000000	4291554e-7668-4670-8cea-81ca176d700b	{"action":"user_repeated_signup","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 04:15:30.605083+00	
00000000-0000-0000-0000-000000000000	f592c519-185b-4e70-b3b3-4cdfa4f2f445	{"action":"user_repeated_signup","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 04:19:05.898805+00	
00000000-0000-0000-0000-000000000000	a6f44d3b-855c-4a39-b015-6d393f9b875b	{"action":"user_repeated_signup","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 04:28:14.828547+00	
00000000-0000-0000-0000-000000000000	0de81c20-77ba-482f-9f27-17c8ff1111a7	{"action":"user_repeated_signup","actor_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 04:30:47.639219+00	
00000000-0000-0000-0000-000000000000	34c42ff1-2eaf-42e1-9934-2426bb4664a4	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ynlldom@gmail.com","user_id":"295de186-b43b-4ac3-a570-99ddc471fd9c","user_phone":""}}	2025-10-18 04:31:33.602045+00	
00000000-0000-0000-0000-000000000000	7d40a62f-642a-4162-a792-6428195d2c16	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"arteagayanelly23@gmail.com","user_id":"b5beb0c1-0b3a-4324-a344-8a38268e6612","user_phone":""}}	2025-10-18 04:31:33.610077+00	
00000000-0000-0000-0000-000000000000	207a2046-7bd9-418a-a447-9aac1acbb6a6	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"merarteaga1967@gmail.com","user_id":"367cfd8e-427e-4204-8616-bda115628aa0","user_phone":""}}	2025-10-18 04:31:33.615194+00	
00000000-0000-0000-0000-000000000000	e3aecfc0-901f-46a2-9f52-406065fb1f82	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"domyanelly23@gmail.com","user_id":"a59764fe-4a1d-45cf-95c5-ed87e5c6490e","user_phone":""}}	2025-10-18 04:31:33.616286+00	
00000000-0000-0000-0000-000000000000	1a91d5a9-81b3-4849-873a-29322b208e54	{"action":"user_confirmation_requested","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 04:32:56.868408+00	
00000000-0000-0000-0000-000000000000	df73077a-cee0-4c36-bae0-c2f5916cd367	{"action":"user_signedup","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-18 04:33:35.445834+00	
00000000-0000-0000-0000-000000000000	3df82193-dcc0-4bdf-a7dc-275b3dcf341e	{"action":"login","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 04:33:46.065047+00	
00000000-0000-0000-0000-000000000000	0c54d0c2-3a18-4e19-a3d1-9c41c15d5cbc	{"action":"logout","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 04:37:35.019368+00	
00000000-0000-0000-0000-000000000000	451d01d6-0c41-4577-af8e-981961ae7ee2	{"action":"login","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 04:38:31.542271+00	
00000000-0000-0000-0000-000000000000	a30d3765-7c8b-4f00-ba3e-57f13394942b	{"action":"logout","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 04:41:21.229846+00	
00000000-0000-0000-0000-000000000000	aded68ea-7dae-4ee0-8827-6f58a5aa1a08	{"action":"login","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 04:41:34.477656+00	
00000000-0000-0000-0000-000000000000	b26f7a63-587b-4437-aa75-c005973a17be	{"action":"logout","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 04:41:41.256909+00	
00000000-0000-0000-0000-000000000000	cf8a9e3f-508d-440f-8ddb-d30b02acb412	{"action":"login","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 04:48:18.839029+00	
00000000-0000-0000-0000-000000000000	5cceaafa-fcb5-4d81-b550-400f398d662b	{"action":"logout","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 04:48:31.238132+00	
00000000-0000-0000-0000-000000000000	c7899698-2592-4451-b023-e99f66dd8615	{"action":"login","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 05:02:31.043076+00	
00000000-0000-0000-0000-000000000000	de75c50b-6d71-4697-9f1a-29f820add75b	{"action":"token_refreshed","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 16:53:58.291526+00	
00000000-0000-0000-0000-000000000000	88068faa-f564-4c77-a8b1-8e10b716d938	{"action":"token_revoked","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 16:53:58.317018+00	
00000000-0000-0000-0000-000000000000	dcd7d1f2-72b6-416b-8d74-1ece992c7a46	{"action":"logout","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 16:57:59.011732+00	
00000000-0000-0000-0000-000000000000	19c90cb1-1bfd-4e29-9225-0f307c2b5455	{"action":"login","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 19:05:26.721991+00	
00000000-0000-0000-0000-000000000000	3554172e-dbac-463a-bb13-ab5ed232f36e	{"action":"logout","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 19:05:37.013712+00	
00000000-0000-0000-0000-000000000000	560137d4-5467-49d2-8e95-3afe1ade60f7	{"action":"login","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 19:16:33.636367+00	
00000000-0000-0000-0000-000000000000	68fce29c-8033-4a3c-be9b-732ea47537f6	{"action":"logout","actor_id":"09f8b54a-ea51-4f39-864b-3408e9241447","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 19:20:33.66011+00	
00000000-0000-0000-0000-000000000000	b8cda320-b040-4861-82d3-c42b6e8a3ced	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ynlldom@gmail.com","user_id":"09f8b54a-ea51-4f39-864b-3408e9241447","user_phone":""}}	2025-10-18 19:36:53.077609+00	
00000000-0000-0000-0000-000000000000	07e0c270-ec5b-4ac7-b4ed-a2ad56208774	{"action":"user_confirmation_requested","actor_id":"5069e6d7-cf11-45c8-92d8-d1cb2353df87","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 19:42:41.384271+00	
00000000-0000-0000-0000-000000000000	5e714daa-b1e3-4d4a-96d4-3affcf97c866	{"action":"user_signedup","actor_id":"5069e6d7-cf11-45c8-92d8-d1cb2353df87","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-18 19:43:07.780901+00	
00000000-0000-0000-0000-000000000000	87202dd3-edf9-46b7-a172-4129cbdfda0b	{"action":"login","actor_id":"5069e6d7-cf11-45c8-92d8-d1cb2353df87","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 19:43:10.468801+00	
00000000-0000-0000-0000-000000000000	6cb296d8-061f-4cee-a6c8-e9dbcee9b920	{"action":"login","actor_id":"5069e6d7-cf11-45c8-92d8-d1cb2353df87","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 20:33:33.108757+00	
00000000-0000-0000-0000-000000000000	91310c45-e5f5-4cab-933d-8b970fc720dd	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ynlldom@gmail.com","user_id":"5069e6d7-cf11-45c8-92d8-d1cb2353df87","user_phone":""}}	2025-10-18 21:19:36.012426+00	
00000000-0000-0000-0000-000000000000	fb254405-cc63-4a3d-af2a-1c31f39a9887	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 07:40:57.655938+00	
00000000-0000-0000-0000-000000000000	226e0076-4784-4c39-bfd6-08fae62ad03f	{"action":"user_confirmation_requested","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 21:23:06.594472+00	
00000000-0000-0000-0000-000000000000	55f55cd1-2a20-48f6-9d1e-32dff239373c	{"action":"user_signedup","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-18 21:23:37.279846+00	
00000000-0000-0000-0000-000000000000	34d69264-0b5b-491a-a187-ab967f8b016f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 21:26:37.294693+00	
00000000-0000-0000-0000-000000000000	c34fcf43-8097-4ae4-a73f-787228d4c1ed	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 22:17:48.116955+00	
00000000-0000-0000-0000-000000000000	48a0d534-367d-45f2-a956-3279b5bc8f34	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 22:17:48.141703+00	
00000000-0000-0000-0000-000000000000	06bc4a52-75f4-4d19-83a8-31cc96dd571a	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:24:12.761865+00	
00000000-0000-0000-0000-000000000000	41807297-46d2-43cc-958e-f8ca04faf592	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:24:16.83779+00	
00000000-0000-0000-0000-000000000000	5d7595d9-2e44-4a3c-b9c7-3db3702547b6	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:24:18.814919+00	
00000000-0000-0000-0000-000000000000	40443797-c204-4e4b-ab1b-3f6f1a58b34d	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:24:24.43801+00	
00000000-0000-0000-0000-000000000000	0033581c-f02d-465a-a4fd-7f1a8ba4ffaf	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:24:41.921298+00	
00000000-0000-0000-0000-000000000000	67f4cb94-2154-46f8-8e3e-712d975b9bea	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:26:17.729911+00	
00000000-0000-0000-0000-000000000000	e16eb155-8854-4798-a7a4-5f4403a9b465	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:26:22.044561+00	
00000000-0000-0000-0000-000000000000	559239d0-1af5-4cbd-91b6-9520e99f79f9	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:40:29.671678+00	
00000000-0000-0000-0000-000000000000	08d16c2c-8dc8-49b5-8315-c361837f1aa2	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:43:38.911628+00	
00000000-0000-0000-0000-000000000000	61248bd2-7193-42a6-a17f-429209a70d75	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:49:53.660058+00	
00000000-0000-0000-0000-000000000000	bd35df05-4022-42cc-b726-b98c132ed391	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:49:57.760257+00	
00000000-0000-0000-0000-000000000000	1132f4e9-d103-473a-bec5-6d766b7de414	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 22:56:47.351098+00	
00000000-0000-0000-0000-000000000000	36c6fc00-f430-408d-8040-21061f6e29c6	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 23:08:02.641067+00	
00000000-0000-0000-0000-000000000000	1bf879d8-5aad-4350-9c49-2f78ef2f02cb	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 23:13:13.121839+00	
00000000-0000-0000-0000-000000000000	e06c0b27-4748-412e-ac84-deb97f0eafa1	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 23:13:18.132172+00	
00000000-0000-0000-0000-000000000000	081adc6d-615d-4511-ac32-d444d14e43c6	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 00:11:46.220778+00	
00000000-0000-0000-0000-000000000000	b0ac09c1-8de4-415a-9ea5-7bf41ea78bfc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 00:11:46.240533+00	
00000000-0000-0000-0000-000000000000	14b9b718-5a14-41b3-bdb5-575845bd4560	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 00:30:19.712822+00	
00000000-0000-0000-0000-000000000000	8f9fa7c3-6cfa-4fbf-a986-ad94640a7e8d	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 01:13:49.976938+00	
00000000-0000-0000-0000-000000000000	757df33c-fdba-402c-b53a-9598c0e854b1	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 01:20:16.207099+00	
00000000-0000-0000-0000-000000000000	bd04b85f-cc41-4b06-ae54-65076d275d16	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 02:07:55.998808+00	
00000000-0000-0000-0000-000000000000	a7f7384c-dfdb-4f80-8d9f-996594dcb99c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 02:07:56.028097+00	
00000000-0000-0000-0000-000000000000	9ce3b3c9-04dd-4720-85de-9551310e108a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 02:55:26.608671+00	
00000000-0000-0000-0000-000000000000	6f31a653-f254-4851-afa6-28767aed91bc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 02:55:26.63043+00	
00000000-0000-0000-0000-000000000000	d6ca0e9c-618d-495a-9d68-264057c192b4	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 22:47:44.949359+00	
00000000-0000-0000-0000-000000000000	39fab1b2-676a-45ed-beb1-6fd174b837cc	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 23:02:13.251465+00	
00000000-0000-0000-0000-000000000000	3c06cb8c-c4d6-4870-bec6-5daf91c2bf05	{"action":"user_confirmation_requested","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-20 23:07:38.918472+00	
00000000-0000-0000-0000-000000000000	3e06ffc4-ba37-443c-ab81-ad50bf91605c	{"action":"user_signedup","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-20 23:18:38.953444+00	
00000000-0000-0000-0000-000000000000	d33e2a3f-27e9-41d8-8eb4-12e313df3988	{"action":"login","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 23:24:09.133867+00	
00000000-0000-0000-0000-000000000000	88c531e7-4521-4257-b566-6032dbe9f4b6	{"action":"login","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 23:25:18.758448+00	
00000000-0000-0000-0000-000000000000	8c0152e0-3573-4ce4-9f21-aff52230a178	{"action":"login","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 23:25:27.531799+00	
00000000-0000-0000-0000-000000000000	48d1ba3a-78a3-4ba9-99ee-8fa29d9f99d0	{"action":"login","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 23:25:33.648991+00	
00000000-0000-0000-0000-000000000000	0e440538-cf33-4860-9c29-853d93ba5570	{"action":"login","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 23:25:54.440476+00	
00000000-0000-0000-0000-000000000000	f0363136-250b-48ad-9bd5-4482be4067f0	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 23:27:03.091133+00	
00000000-0000-0000-0000-000000000000	e8a81975-e41c-4742-a7bf-dbf3f83e4ed8	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 23:42:50.593315+00	
00000000-0000-0000-0000-000000000000	9ae9a942-3f5c-473b-8c3a-06d0fc591995	{"action":"login","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 23:43:06.984761+00	
00000000-0000-0000-0000-000000000000	6023486b-c4b8-4b90-8c88-edaf624501c5	{"action":"token_refreshed","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 00:30:31.669704+00	
00000000-0000-0000-0000-000000000000	a29f8851-e3ea-40f7-872c-5ad14bcdf72e	{"action":"token_revoked","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 00:30:31.68638+00	
00000000-0000-0000-0000-000000000000	8bc60b2b-8e36-456e-8cda-ee4fd52a5069	{"action":"token_refreshed","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 01:31:31.576005+00	
00000000-0000-0000-0000-000000000000	c6a8b29c-f779-4a3e-9fde-f61fb65f7d4b	{"action":"token_revoked","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 01:31:31.602549+00	
00000000-0000-0000-0000-000000000000	59a75447-d89c-423c-a914-a01e574c145f	{"action":"token_refreshed","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 02:19:00.28567+00	
00000000-0000-0000-0000-000000000000	f0ba2b45-437d-4039-9f20-e05cac8b5f4b	{"action":"token_revoked","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 02:19:00.327348+00	
00000000-0000-0000-0000-000000000000	4a6ae7c2-c2f9-4ee6-8c62-4150765406b7	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:35:24.035193+00	
00000000-0000-0000-0000-000000000000	93d9c7a0-eaf1-405f-9e0f-2833c7873342	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 02:35:43.52415+00	
00000000-0000-0000-0000-000000000000	2a0bddd6-0228-4989-b527-43dad71fd210	{"action":"login","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:36:05.752764+00	
00000000-0000-0000-0000-000000000000	b93aebef-20c5-49d9-90be-5e5f863d10a7	{"action":"logout","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 02:36:29.85843+00	
00000000-0000-0000-0000-000000000000	c54c9b1a-3f37-4ea7-959b-151f2d628a66	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:38:39.726196+00	
00000000-0000-0000-0000-000000000000	7cc53b5b-143c-4cc6-a45f-e6fcbe37c2b9	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:44:04.301252+00	
00000000-0000-0000-0000-000000000000	79b4d1b2-cea9-4a2e-9081-e0deaaa37723	{"action":"user_confirmation_requested","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-21 02:44:15.65228+00	
00000000-0000-0000-0000-000000000000	4b238143-54d4-4c65-ac51-3ce13247d10c	{"action":"user_signedup","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-21 02:44:40.628175+00	
00000000-0000-0000-0000-000000000000	cd6a74ee-a1fd-458b-b62f-974daf18a282	{"action":"login","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:45:03.758766+00	
00000000-0000-0000-0000-000000000000	512b7e15-3c50-4b56-9ea8-7193f48fe3d1	{"action":"login","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:45:08.218945+00	
00000000-0000-0000-0000-000000000000	b80df21d-53d9-45fc-87d3-fd13a3d35bfd	{"action":"login","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:45:14.19583+00	
00000000-0000-0000-0000-000000000000	78d89bb7-182a-41e9-be57-b32099002526	{"action":"logout","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 02:45:49.774792+00	
00000000-0000-0000-0000-000000000000	37057895-c5d8-4ba1-a84c-1d07c3a76fae	{"action":"login","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:46:00.773382+00	
00000000-0000-0000-0000-000000000000	ca4e809b-faef-4352-8a04-252828de6e8e	{"action":"logout","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 02:46:24.304814+00	
00000000-0000-0000-0000-000000000000	2ca113e2-34ef-4515-9ee9-dcbb40c8156d	{"action":"login","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:46:36.469065+00	
00000000-0000-0000-0000-000000000000	7a0a7f55-d1e2-420c-9f80-a2ec09bc06d4	{"action":"logout","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 02:46:59.940446+00	
00000000-0000-0000-0000-000000000000	329c532e-ab05-45c7-bdd1-76601c4b3ed7	{"action":"login","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:47:21.968478+00	
00000000-0000-0000-0000-000000000000	e81c8a0b-05d2-44f0-863e-a149b5f3f8cc	{"action":"logout","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 02:47:25.108202+00	
00000000-0000-0000-0000-000000000000	a40d8241-25d1-409c-998e-6e5f51f45e48	{"action":"login","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 02:51:35.634722+00	
00000000-0000-0000-0000-000000000000	9be2351a-d939-4813-93f2-8619af8d97a2	{"action":"user_confirmation_requested","actor_id":"0e773dca-0696-446d-8700-d934e7cd5151","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-21 13:22:28.33585+00	
00000000-0000-0000-0000-000000000000	e78e298d-4a57-4499-87c6-aa544d280097	{"action":"user_signedup","actor_id":"0e773dca-0696-446d-8700-d934e7cd5151","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-21 13:23:43.051252+00	
00000000-0000-0000-0000-000000000000	c77a8939-469d-4e33-ba26-a4ddd206662e	{"action":"login","actor_id":"0e773dca-0696-446d-8700-d934e7cd5151","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 13:24:18.421191+00	
00000000-0000-0000-0000-000000000000	2f344427-324f-4346-a7cf-3e480f38a70f	{"action":"login","actor_id":"0e773dca-0696-446d-8700-d934e7cd5151","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 13:24:28.979642+00	
00000000-0000-0000-0000-000000000000	efa46f35-98af-4ff6-aa38-e00e67fab484	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 13:25:07.181714+00	
00000000-0000-0000-0000-000000000000	9e3a0597-c602-4563-9ece-2e7b5774f661	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 13:30:25.372771+00	
00000000-0000-0000-0000-000000000000	3ba52b73-7a92-4a99-8033-f2fb45e4c383	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 13:31:14.693337+00	
00000000-0000-0000-0000-000000000000	7ccff364-9298-453d-b81a-9ffa597e86fb	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 13:46:37.90791+00	
00000000-0000-0000-0000-000000000000	7665fc91-062b-488e-a017-874d0b40119f	{"action":"login","actor_id":"0e773dca-0696-446d-8700-d934e7cd5151","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 13:46:47.03476+00	
00000000-0000-0000-0000-000000000000	78dede40-3ca3-4604-aad6-fd737496e24b	{"action":"token_refreshed","actor_id":"0e773dca-0696-446d-8700-d934e7cd5151","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"token"}	2025-10-21 15:32:19.62084+00	
00000000-0000-0000-0000-000000000000	aaf52fbc-7c53-40d6-a995-8ab0fe009743	{"action":"token_revoked","actor_id":"0e773dca-0696-446d-8700-d934e7cd5151","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"token"}	2025-10-21 15:32:19.650176+00	
00000000-0000-0000-0000-000000000000	b1634bd3-8199-4d90-aa54-dda2ed637fbe	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-26 19:54:09.398727+00	
00000000-0000-0000-0000-000000000000	9d6371f9-170e-4ab0-911f-4c861a091a8e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-26 20:52:24.484237+00	
00000000-0000-0000-0000-000000000000	b24c76da-ff59-49e9-bebf-f4fe4eee39e6	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-26 20:52:24.500184+00	
00000000-0000-0000-0000-000000000000	4d51a1dd-2683-4620-badb-8ef63474692e	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-26 21:13:08.780172+00	
00000000-0000-0000-0000-000000000000	c25f6770-7c65-41f0-b959-f63568cdc52e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-26 22:00:21.042797+00	
00000000-0000-0000-0000-000000000000	421e70d5-5405-4382-8899-1dd42501c35a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-26 22:00:21.061177+00	
00000000-0000-0000-0000-000000000000	e88c6690-99c2-4564-a238-c5e6b42fafb4	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 02:46:36.733306+00	
00000000-0000-0000-0000-000000000000	0da33813-8661-4171-9425-e98757a5d354	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 02:46:36.752297+00	
00000000-0000-0000-0000-000000000000	a9e4e306-8cb3-4aa1-a57e-f306441c51de	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 04:04:43.903619+00	
00000000-0000-0000-0000-000000000000	b551ce89-0c1d-47d7-bddf-806257881633	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 04:04:43.921996+00	
00000000-0000-0000-0000-000000000000	b2708987-3f03-44bf-982a-0ca3a4a150f0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 04:06:11.786577+00	
00000000-0000-0000-0000-000000000000	d9599e04-b3b2-4580-8489-ea184f016551	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 04:06:11.787569+00	
00000000-0000-0000-0000-000000000000	58b65566-fe28-457b-a01d-8ab6ca828941	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 05:19:18.87804+00	
00000000-0000-0000-0000-000000000000	5c64d975-aa93-41e6-a638-8053cf2fb4a8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 05:19:18.900418+00	
00000000-0000-0000-0000-000000000000	b02abf5e-5ce4-45ea-9868-af0f2e56cd2c	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 06:06:17.850676+00	
00000000-0000-0000-0000-000000000000	58e37098-5ca8-4e67-b9ce-28358bbbad13	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 06:06:17.871855+00	
00000000-0000-0000-0000-000000000000	a32012e8-5eee-4d93-95f9-8ade7f2abe34	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 06:53:47.284339+00	
00000000-0000-0000-0000-000000000000	a9ad5e7d-bd5e-4bb8-aeaa-740fda90ace0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 06:53:47.303271+00	
00000000-0000-0000-0000-000000000000	832a80cd-eb78-46e9-9194-50cbc85227f5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 07:40:57.646359+00	
00000000-0000-0000-0000-000000000000	d57ca010-d05a-4d4e-8e68-d14ade11fd15	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 08:28:04.455137+00	
00000000-0000-0000-0000-000000000000	7f181b06-b0eb-41da-a40f-2b84d7e4aea7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 08:28:04.474137+00	
00000000-0000-0000-0000-000000000000	ff76ce59-8949-410a-8960-16596ab046bb	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 09:18:39.936844+00	
00000000-0000-0000-0000-000000000000	462c9cc8-561e-46c6-a1c3-37a4148b647b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 09:18:39.957653+00	
00000000-0000-0000-0000-000000000000	4ca16111-49ea-4ed3-a542-0dba7a3c80f2	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 09:28:36.667478+00	
00000000-0000-0000-0000-000000000000	29aa01aa-4a03-4495-b9c9-343d4cfcacb8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 09:28:36.676535+00	
00000000-0000-0000-0000-000000000000	0f595cf9-7988-4090-a74b-25c688b01314	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-29 09:32:30.380775+00	
00000000-0000-0000-0000-000000000000	ba23bb34-99e8-4e38-88e4-18ea71e6e0df	{"action":"token_refreshed","actor_id":"0e773dca-0696-446d-8700-d934e7cd5151","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"token"}	2025-10-29 19:10:53.904959+00	
00000000-0000-0000-0000-000000000000	18fc274a-f0a5-4566-9d06-edded3b622a3	{"action":"logout","actor_id":"0e773dca-0696-446d-8700-d934e7cd5151","actor_username":"tatiana.zambrano@utm.edu.ec","actor_via_sso":false,"log_type":"account"}	2025-10-29 19:11:51.191204+00	
00000000-0000-0000-0000-000000000000	f20fcb74-1983-4faa-a2af-39834155657a	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-29 19:12:49.323962+00	
00000000-0000-0000-0000-000000000000	688a9944-adb5-43e1-a395-17b9769f03f3	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 21:01:48.717488+00	
00000000-0000-0000-0000-000000000000	95ba9132-f0ca-4226-94af-6b7ad019deae	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 21:01:48.736729+00	
00000000-0000-0000-0000-000000000000	a022e41f-db0a-437f-922b-c0aa7654fe5b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 01:26:13.135924+00	
00000000-0000-0000-0000-000000000000	f237ef80-9ec7-4889-a033-576265d82e52	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 01:26:13.144102+00	
00000000-0000-0000-0000-000000000000	d410b7bf-fc4f-4b94-8aae-a4b4ae034b2c	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 12:48:35.514749+00	
00000000-0000-0000-0000-000000000000	2a2b095d-262e-4489-b782-96892bf7dcb1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 12:48:35.546397+00	
00000000-0000-0000-0000-000000000000	5d279f5d-9b61-4093-86d7-9f4d7e346408	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 15:21:25.796216+00	
00000000-0000-0000-0000-000000000000	c0d39f1d-4ad9-401c-80d6-9d3e92d834b9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 15:21:25.814588+00	
00000000-0000-0000-0000-000000000000	89a2ac7e-1deb-4855-9aa5-be66f815c8a4	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 20:20:30.831861+00	
00000000-0000-0000-0000-000000000000	a8bd796f-92e0-4aed-9a2b-65ac94b2e5af	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 20:20:30.849947+00	
00000000-0000-0000-0000-000000000000	416d7bd2-b524-453f-b143-06c0814c220c	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 04:04:08.036612+00	
00000000-0000-0000-0000-000000000000	5df1cfef-3ddf-4d0e-a67a-22739ff40bd7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 04:04:08.062419+00	
00000000-0000-0000-0000-000000000000	52b29401-0594-46c3-bbd6-b5edf15cff02	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 04:51:27.015103+00	
00000000-0000-0000-0000-000000000000	447afcaf-d5ba-4caf-ab6b-4e4a6977a5e7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 04:51:27.029073+00	
00000000-0000-0000-0000-000000000000	9ccbb606-ea6a-4f00-a6db-8bac2846cce1	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 05:44:44.093257+00	
00000000-0000-0000-0000-000000000000	48226817-150e-4e00-8785-3873ed42c664	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 05:44:44.112029+00	
00000000-0000-0000-0000-000000000000	e7f25823-2580-4031-a8a8-81ea5bd30eb4	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 07:20:05.485861+00	
00000000-0000-0000-0000-000000000000	699ee12c-8e1d-4794-96f9-71f3a76ae018	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 07:20:05.505669+00	
00000000-0000-0000-0000-000000000000	0d43edfb-3590-4a0f-ba73-a56ce3b27cc4	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 07:30:37.008252+00	
00000000-0000-0000-0000-000000000000	50e5f3c4-d81f-4055-81d7-0db4a62fe089	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 07:30:37.022992+00	
00000000-0000-0000-0000-000000000000	0e57b4f5-1f8a-4ed3-9d31-213d99efc1dc	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 08:18:06.654466+00	
00000000-0000-0000-0000-000000000000	ae9918b2-13ab-4c08-b5ed-ca74eb59954f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 08:18:06.672516+00	
00000000-0000-0000-0000-000000000000	9c38b19d-b5d4-494a-b441-2339e5c9b2bc	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 08:35:55.391942+00	
00000000-0000-0000-0000-000000000000	0ab40e03-a595-4890-8bee-b51c71ee4001	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 08:35:55.404141+00	
00000000-0000-0000-0000-000000000000	2f915280-def7-4029-96c2-a959bf524032	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 01:58:22.604572+00	
00000000-0000-0000-0000-000000000000	6a56d9d6-d9b9-4a41-9c11-c171e08df72b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 01:58:22.633232+00	
00000000-0000-0000-0000-000000000000	066d837b-9bb0-44f0-a0ab-8afcfeea9ef2	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 02:45:47.280956+00	
00000000-0000-0000-0000-000000000000	11544e99-d616-4c57-9075-b93e3091fa42	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 02:45:47.301471+00	
00000000-0000-0000-0000-000000000000	dadb4578-d8e5-4cd7-8892-174f710770a7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 03:04:55.513328+00	
00000000-0000-0000-0000-000000000000	46e51f98-b5a4-4479-8945-30294d8fbd74	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 03:04:55.526094+00	
00000000-0000-0000-0000-000000000000	083f2e5c-b50c-4e55-af01-06f1883d0999	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 03:32:56.189148+00	
00000000-0000-0000-0000-000000000000	8553062f-f9ef-4ee4-9e1e-384e3c3df608	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 03:32:56.198409+00	
00000000-0000-0000-0000-000000000000	2c03de70-6b3f-4082-ab9f-38cfd17d139a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 04:19:55.774286+00	
00000000-0000-0000-0000-000000000000	0d079ce1-4f2f-42f9-bf32-93666524f5a5	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 04:19:55.792695+00	
00000000-0000-0000-0000-000000000000	e351f20a-8dc7-4bb0-94a0-0ae6539ae748	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 05:08:45.216002+00	
00000000-0000-0000-0000-000000000000	e9b47b56-aa8c-4568-b514-f98c21137c4c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 05:08:45.229874+00	
00000000-0000-0000-0000-000000000000	bbf0b3f8-2589-444a-a0dc-35d419b613d0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 05:15:19.331472+00	
00000000-0000-0000-0000-000000000000	12ff829a-62cf-41d5-8dc8-0ef67c1aee2f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 05:15:19.341071+00	
00000000-0000-0000-0000-000000000000	fe3572eb-401b-4007-952a-42ea55137b06	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 05:55:33.997286+00	
00000000-0000-0000-0000-000000000000	83076cec-375b-44b8-ad3d-9aa0481e2e98	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 05:55:34.02834+00	
00000000-0000-0000-0000-000000000000	889b36e0-4b07-4d81-b716-e1db2d43b3a8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 01:57:52.805313+00	
00000000-0000-0000-0000-000000000000	4493fde8-3a4f-44f7-b916-1293cd85368e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 01:57:52.832242+00	
00000000-0000-0000-0000-000000000000	c3fa396c-df1a-4886-868e-0941bce61dda	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 02:27:18.257721+00	
00000000-0000-0000-0000-000000000000	8de9e9a8-b100-40cb-8eaa-e28a493b7e20	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 02:27:18.279431+00	
00000000-0000-0000-0000-000000000000	1dc691ff-e8f4-402b-8f96-338ecb5fbed0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 03:14:06.774137+00	
00000000-0000-0000-0000-000000000000	36ff007f-9449-4cd7-ac05-3f2b9ced0293	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 03:14:06.783349+00	
00000000-0000-0000-0000-000000000000	3cc67d11-6151-4e31-83f7-3e0e9ea84df0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 03:25:23.765354+00	
00000000-0000-0000-0000-000000000000	6811cd52-02fa-4e97-a2a9-f87df55520a4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 03:25:23.770644+00	
00000000-0000-0000-0000-000000000000	2236e213-6354-48d6-8cc0-f22cbe89d400	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 04:15:35.995675+00	
00000000-0000-0000-0000-000000000000	9ab75d3b-c60b-47af-a2d4-a340ffda6561	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 04:15:36.0255+00	
00000000-0000-0000-0000-000000000000	5ca2fc14-7193-469b-9bba-7b9a8c8d9d2f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 05:02:42.120183+00	
00000000-0000-0000-0000-000000000000	85204222-f929-4a0a-9601-cc8ea5d48e89	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 05:02:42.129661+00	
00000000-0000-0000-0000-000000000000	32e7bab2-7118-49c7-a036-2a6b0ca654ab	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 05:08:08.424322+00	
00000000-0000-0000-0000-000000000000	04b83bcc-56ea-4c97-b248-68b0fc2060d7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 05:08:08.430673+00	
00000000-0000-0000-0000-000000000000	862b57d7-529f-447d-92a4-e7bca868a660	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-07 05:20:43.089691+00	
00000000-0000-0000-0000-000000000000	e30f5660-f215-469e-bd0d-59b62e2c11a2	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-07 05:21:08.901462+00	
00000000-0000-0000-0000-000000000000	18fd771f-3998-417b-9771-be7a1ffd96d8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 06:34:09.641059+00	
00000000-0000-0000-0000-000000000000	30679a58-4f84-4578-b9ca-e1ee6a4589bc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 06:34:09.661978+00	
00000000-0000-0000-0000-000000000000	3249aa66-7462-4b16-82b8-b910f7b5d34a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 07:25:42.179719+00	
00000000-0000-0000-0000-000000000000	a6d53306-110b-488a-8b48-2e0f61907db1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 07:25:42.211039+00	
00000000-0000-0000-0000-000000000000	2df9f32f-afa8-4987-88dc-0c5690a2981b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 08:15:28.725759+00	
00000000-0000-0000-0000-000000000000	c0b5a1ac-9ff8-440b-b1f8-5d03c687bf13	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 08:15:28.753973+00	
00000000-0000-0000-0000-000000000000	670f19bd-9237-41ea-8396-a8a233b32086	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 09:04:32.434463+00	
00000000-0000-0000-0000-000000000000	5d224919-bf1b-48b6-85f7-2406b611d6d8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 09:04:32.446479+00	
00000000-0000-0000-0000-000000000000	bb9afabd-5525-4c55-8dc6-2673c87f02cd	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-07 09:41:26.244304+00	
00000000-0000-0000-0000-000000000000	1f03f1af-5c10-4ffe-860e-e99000dcb879	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-07 09:55:25.295709+00	
00000000-0000-0000-0000-000000000000	8e30a944-e25b-4d6b-af6f-cc817fc431d1	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-07 15:16:40.644965+00	
00000000-0000-0000-0000-000000000000	64aea2b0-7a6e-4e44-bee7-b7c9a1ab027b	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-07 15:36:16.844058+00	
00000000-0000-0000-0000-000000000000	abd425c5-d563-46d0-9bcd-245a5c50d26f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-12 18:33:22.742809+00	
00000000-0000-0000-0000-000000000000	d53bfd1e-19eb-4ef6-a255-1fe5fce3a8ed	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-19 14:11:25.853259+00	
00000000-0000-0000-0000-000000000000	0a66b47a-abb8-4d30-8886-b075d8e74857	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-19 14:11:25.861954+00	
00000000-0000-0000-0000-000000000000	efd32919-7d79-43fc-b7f0-060da6741244	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-19 15:13:35.733063+00	
00000000-0000-0000-0000-000000000000	7c129a15-0c21-4089-a332-cec4f3b7f922	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-19 15:13:35.757961+00	
00000000-0000-0000-0000-000000000000	5af9cc5b-b8e9-4eca-afc0-80d94a90acf2	{"action":"token_refreshed","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-19 15:38:23.084809+00	
00000000-0000-0000-0000-000000000000	7f3f30d0-a4da-4f51-a8fa-044adcf705a4	{"action":"token_revoked","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-19 15:38:23.093304+00	
00000000-0000-0000-0000-000000000000	9457ba05-f744-411f-bd7d-1a40921dabd9	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-22 18:14:02.848646+00	
00000000-0000-0000-0000-000000000000	cdfe7a56-645d-46ee-8f66-43eff44bfcb6	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-22 19:55:41.356568+00	
00000000-0000-0000-0000-000000000000	04090acc-4f3d-4f95-80c5-52dda08c01c1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-22 19:55:41.37775+00	
00000000-0000-0000-0000-000000000000	15fe91ef-ade5-4891-9c25-25aa04777aaf	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-22 20:47:53.754534+00	
00000000-0000-0000-0000-000000000000	d27bae49-63bc-436e-b612-fa1d05893015	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-22 20:53:43.098574+00	
00000000-0000-0000-0000-000000000000	ae967f4e-f997-4c7b-b801-cc696688d30e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-22 20:53:43.116688+00	
00000000-0000-0000-0000-000000000000	d599e36c-fd93-4ac0-8df8-25099d30a982	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-22 23:00:33.835634+00	
00000000-0000-0000-0000-000000000000	71e7d55b-91c0-4a40-a9da-31cc8278460f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-22 23:00:33.848601+00	
00000000-0000-0000-0000-000000000000	e9341026-e11c-4eda-8fcc-dcd8f933b783	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-23 03:24:07.512826+00	
00000000-0000-0000-0000-000000000000	f04464bf-a91b-4c25-a39f-c3099f3f4091	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-23 03:24:07.537485+00	
00000000-0000-0000-0000-000000000000	641602dd-f06e-48a7-ba82-9dfbbc3a0256	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-23 06:28:53.268181+00	
00000000-0000-0000-0000-000000000000	5c5dd69f-a13a-4b73-8e05-86625e609541	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-24 17:54:50.743382+00	
00000000-0000-0000-0000-000000000000	0f6eac8e-fce1-45a8-97d9-b12cc7ff2e2f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-24 17:54:50.769251+00	
00000000-0000-0000-0000-000000000000	aa9536d9-bfb1-4779-8616-1fe883eda032	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-24 18:01:50.283127+00	
00000000-0000-0000-0000-000000000000	48d50351-bddc-4eab-9096-20a789c2bfd8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-24 18:01:50.294476+00	
00000000-0000-0000-0000-000000000000	02506430-b4a8-4c1b-b39a-ad80f1731535	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-24 19:01:51.776129+00	
00000000-0000-0000-0000-000000000000	c206f139-bb35-4dab-84c1-882314b3c365	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-24 19:01:51.79657+00	
00000000-0000-0000-0000-000000000000	01bbc0cc-8824-4649-b315-652f609ee98b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-24 22:00:48.343853+00	
00000000-0000-0000-0000-000000000000	37ae0a73-d166-4b1f-a5a6-658ec6060009	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-24 22:00:48.373574+00	
00000000-0000-0000-0000-000000000000	6734be95-0a4d-46f9-bc59-3de5c5700d90	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-25 01:44:52.433194+00	
00000000-0000-0000-0000-000000000000	d40b6131-7b31-427a-b4cb-5abb65e1cec1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-25 01:44:52.459142+00	
00000000-0000-0000-0000-000000000000	81b1dd3b-1416-416c-955a-4c7ad7079f11	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-25 02:28:55.933899+00	
00000000-0000-0000-0000-000000000000	ff93b186-6beb-4f14-8162-aad4e961e660	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-25 03:34:03.989632+00	
00000000-0000-0000-0000-000000000000	c86063d7-d3ee-4358-ad1d-49de33c6680f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-25 03:34:04.020164+00	
00000000-0000-0000-0000-000000000000	5537166f-7fb1-4030-b956-95204f067e21	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-25 05:01:43.892945+00	
00000000-0000-0000-0000-000000000000	36c45eaf-0c2c-4199-a402-effe22168dbf	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-25 05:01:43.919871+00	
00000000-0000-0000-0000-000000000000	681222af-8226-42fa-bd19-2d56e25c6990	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-29 19:29:57.976219+00	
00000000-0000-0000-0000-000000000000	552cf970-8dd3-4326-b9db-674896de6587	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-29 19:29:58.003785+00	
00000000-0000-0000-0000-000000000000	7bacc339-9e92-4ecf-9bce-33b330342db9	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-29 20:43:03.592885+00	
00000000-0000-0000-0000-000000000000	d7dda1a1-2086-4e84-bac5-ec463e867ba2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-29 20:43:03.609979+00	
00000000-0000-0000-0000-000000000000	5759e1e6-0bff-49c4-af7e-4b688ce0fa72	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-29 22:32:56.972485+00	
00000000-0000-0000-0000-000000000000	8d26e546-cd7c-48c6-b0b3-fb0ca3f12643	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-29 22:32:56.991766+00	
00000000-0000-0000-0000-000000000000	2e14d882-1800-42a2-8e9c-e27b2545a073	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 01:12:02.799314+00	
00000000-0000-0000-0000-000000000000	f5d3da7c-7086-418c-a52a-f2fbf5c2d84b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 01:12:02.810806+00	
00000000-0000-0000-0000-000000000000	093fc62b-1bfe-4f6c-b567-636ec782c9ce	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 02:10:11.411568+00	
00000000-0000-0000-0000-000000000000	8f18e6e5-53e4-43b8-85da-0121d549732c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 02:10:11.419788+00	
00000000-0000-0000-0000-000000000000	3ee4b8ee-4943-49f0-ab6b-8e94f0a93f9e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 03:13:36.688658+00	
00000000-0000-0000-0000-000000000000	a6fe5569-9977-4196-9031-b4696248a69b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 03:13:36.704176+00	
00000000-0000-0000-0000-000000000000	30be4000-ae64-443c-b3fc-1b4bf59b06e6	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 04:11:42.492179+00	
00000000-0000-0000-0000-000000000000	bacfb0c7-0d72-41d7-b285-fa2a44d9d853	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 04:11:42.503127+00	
00000000-0000-0000-0000-000000000000	952cee83-3e22-4502-baac-5214e50afa46	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 05:25:56.745491+00	
00000000-0000-0000-0000-000000000000	f5b397f9-fa34-4563-9afb-e2187120e4e6	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-30 05:25:56.761244+00	
00000000-0000-0000-0000-000000000000	5fee1f7b-1d7a-4b8a-99ac-b8dd08cbf455	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 16:32:47.355448+00	
00000000-0000-0000-0000-000000000000	d49f36ca-b2a1-4967-a824-6e7358064e6d	{"action":"token_refreshed","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-01 21:44:42.650812+00	
00000000-0000-0000-0000-000000000000	6fad540d-f812-4fe6-b1d7-9bd4a0f71dbf	{"action":"token_revoked","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-01 21:44:42.679232+00	
00000000-0000-0000-0000-000000000000	b6b798ea-b0e9-4eae-9c46-8ef987e86949	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 22:40:17.892613+00	
00000000-0000-0000-0000-000000000000	67e7c154-b9d2-44e6-b5dc-cd1a5312a841	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-01 22:40:28.049153+00	
00000000-0000-0000-0000-000000000000	f8f9fc8e-fca2-436d-96a2-0c479d462fd4	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 22:40:35.897048+00	
00000000-0000-0000-0000-000000000000	1ddb1cde-2f88-4048-b706-7e66e79884e4	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-01 22:40:54.147009+00	
00000000-0000-0000-0000-000000000000	1babdf54-1ee8-40c5-8d69-016f699e475c	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 22:41:02.504738+00	
00000000-0000-0000-0000-000000000000	ccaf33ed-d906-4146-8f10-217aae6cfa1e	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-01 22:43:37.367201+00	
00000000-0000-0000-0000-000000000000	f2fce61b-d6ce-4946-9e39-b7d35605089c	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-01 23:15:29.063439+00	
00000000-0000-0000-0000-000000000000	5447a050-dafe-40c5-95b8-fa214415e3ab	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 00:13:46.737058+00	
00000000-0000-0000-0000-000000000000	3158cd77-6839-4e5c-8933-2580a9834747	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 00:13:46.755457+00	
00000000-0000-0000-0000-000000000000	4e4f8e24-322c-4375-88db-fa3c93a8fac7	{"action":"token_refreshed","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 00:27:55.677465+00	
00000000-0000-0000-0000-000000000000	a4fe20cd-bfb1-441a-a86d-a8005b275b80	{"action":"token_revoked","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 00:27:55.681338+00	
00000000-0000-0000-0000-000000000000	07b36b87-0a43-418e-9c0f-3901a308cdb3	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-02 00:31:23.912015+00	
00000000-0000-0000-0000-000000000000	1a735b22-8007-4ad1-b0b2-4f047fec0ed7	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-02 00:31:34.584205+00	
00000000-0000-0000-0000-000000000000	a3d002b3-763b-4414-a3cf-d41493bbc02c	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-02 00:32:11.512387+00	
00000000-0000-0000-0000-000000000000	73d3a933-cea2-4175-8994-2b1997a28446	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-02 00:37:59.533394+00	
00000000-0000-0000-0000-000000000000	402abcf7-8d66-4cb6-bf2f-b5f3963567cb	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-02 00:39:29.04507+00	
00000000-0000-0000-0000-000000000000	c9f05f4e-8cb9-416c-9cc7-4bd73ab4cf6f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-02 00:50:05.116664+00	
00000000-0000-0000-0000-000000000000	2982f7b2-d742-47e2-91f0-c041baae2dcf	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 02:25:51.067353+00	
00000000-0000-0000-0000-000000000000	f0a252a0-0bc0-4584-b1ba-5aa4182cadf4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 02:25:51.078209+00	
00000000-0000-0000-0000-000000000000	d13a9c98-639d-466b-a2a8-b1af0920a4c5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 03:32:25.525441+00	
00000000-0000-0000-0000-000000000000	213d3a65-f86c-4e88-ace7-606ae29ba5e9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 03:32:25.542155+00	
00000000-0000-0000-0000-000000000000	97d41be0-7dd1-4fcd-833a-69ae74136632	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 04:34:29.441135+00	
00000000-0000-0000-0000-000000000000	e7378323-54a0-4c3d-8102-551e1b1f15fc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 04:34:29.460298+00	
00000000-0000-0000-0000-000000000000	1f973cfc-63ac-4cd5-b9b0-89be6c944f9a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 05:33:38.926022+00	
00000000-0000-0000-0000-000000000000	9d4bdd9e-d83c-4418-b977-e7be52a481c2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 05:33:38.943566+00	
00000000-0000-0000-0000-000000000000	c0f7028c-8d2a-4cc3-bf24-ad148ecb9f24	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 06:36:02.360529+00	
00000000-0000-0000-0000-000000000000	705a804c-4215-458f-8e9d-8d44b2aa51c7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-02 06:36:02.386511+00	
00000000-0000-0000-0000-000000000000	839b629d-d101-4b31-855a-ea2f79f2e3bc	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-03 03:10:41.322938+00	
00000000-0000-0000-0000-000000000000	1bd6c7b2-22ea-4ad2-8622-b3ebc4857ca3	{"action":"token_refreshed","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-03 18:39:25.378782+00	
00000000-0000-0000-0000-000000000000	9e97719f-077b-4e85-8c61-132647f31eac	{"action":"token_revoked","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-03 18:39:25.405131+00	
00000000-0000-0000-0000-000000000000	152b2259-03a3-46ce-b1ec-3d27691922b5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-04 03:51:41.992851+00	
00000000-0000-0000-0000-000000000000	180c42c1-165d-44e5-b13e-58bf4e1196ca	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-04 03:51:42.022872+00	
00000000-0000-0000-0000-000000000000	675204e8-fce5-4409-8e94-0172c800dacf	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-04 18:03:26.833497+00	
00000000-0000-0000-0000-000000000000	152a4f61-33ae-4969-ae51-93c99af901da	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-05 03:16:18.658481+00	
00000000-0000-0000-0000-000000000000	b477676d-285f-470e-b5b0-f44e9dba7cf7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-05 03:16:18.682524+00	
00000000-0000-0000-0000-000000000000	27e325c1-5081-4469-b49f-ba3e54f4b063	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-06 19:01:38.079335+00	
00000000-0000-0000-0000-000000000000	4f9a2899-741f-4587-ba75-7bc36c61a317	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-06 22:29:04.657669+00	
00000000-0000-0000-0000-000000000000	76f6eaad-0f57-4af4-965c-b2567a174b3b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-06 22:29:04.677599+00	
00000000-0000-0000-0000-000000000000	3227915f-e855-451e-a637-e7d69e85b53a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-06 23:28:04.039192+00	
00000000-0000-0000-0000-000000000000	d4e69453-0657-4022-a112-e94c5169b588	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-06 23:28:04.051852+00	
00000000-0000-0000-0000-000000000000	15ed07fa-f78a-4359-b5d5-80218d303165	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-06 23:28:04.097749+00	
00000000-0000-0000-0000-000000000000	b0fe6400-9f1a-4aae-86d3-439c2e38860a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 00:27:03.763194+00	
00000000-0000-0000-0000-000000000000	f77c6963-32d6-4272-b784-1be4f49c910b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 00:27:03.778005+00	
00000000-0000-0000-0000-000000000000	6ec0b59f-601e-4f3e-9bac-0dd5f16deee8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 01:26:04.034526+00	
00000000-0000-0000-0000-000000000000	84786247-e4ba-4696-9240-980bb4fad000	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 01:26:04.04315+00	
00000000-0000-0000-0000-000000000000	ef0458f8-ecec-420e-9044-5c8e48fec35a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 02:36:51.467956+00	
00000000-0000-0000-0000-000000000000	e8f7e9dd-f979-4fe7-90dd-77e37ca90ca6	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 02:36:51.496268+00	
00000000-0000-0000-0000-000000000000	7e9b7d65-63ee-44c0-aca5-cb9fb4e126e7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 03:50:27.69251+00	
00000000-0000-0000-0000-000000000000	a16558d0-ada1-49d3-abcf-ecf59570ae97	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 03:50:27.718642+00	
00000000-0000-0000-0000-000000000000	8f85dcc1-f792-462c-a6f1-976c46a29791	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 04:48:47.800576+00	
00000000-0000-0000-0000-000000000000	c145972d-31c4-447f-aa49-ded750d12a45	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 04:48:47.815909+00	
00000000-0000-0000-0000-000000000000	a7ae22ca-fa33-4fd3-9031-d3f32a569529	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 05:47:03.605984+00	
00000000-0000-0000-0000-000000000000	52fb817f-68f7-4bab-8e23-7cb9f6ee6905	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 05:47:03.625678+00	
00000000-0000-0000-0000-000000000000	a59141ec-3344-4842-9186-0496937e5e85	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 20:46:36.703942+00	
00000000-0000-0000-0000-000000000000	18df60fb-5acf-4384-959e-bc4e75d41513	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 20:46:36.727662+00	
00000000-0000-0000-0000-000000000000	b4d5173c-e93a-458c-999c-8b6c447e6a45	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 21:45:44.179448+00	
00000000-0000-0000-0000-000000000000	34a07600-88b6-43dd-b072-37b6c38c9e41	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 21:45:44.190923+00	
00000000-0000-0000-0000-000000000000	cdce870e-61cb-4e31-bf9e-dad25d674587	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 22:44:44.196462+00	
00000000-0000-0000-0000-000000000000	5cc21d8f-fcbc-45a6-8e3e-50344eaec3db	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 22:44:44.214854+00	
00000000-0000-0000-0000-000000000000	6c5996e7-9c5f-45ea-9071-13159bec60bb	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 23:20:05.802742+00	
00000000-0000-0000-0000-000000000000	ca26648a-7e9f-4cd1-8cd3-50545cb78cc9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-07 23:20:05.812688+00	
00000000-0000-0000-0000-000000000000	9b017230-a5d3-409f-a02b-e53f54450a7e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 00:18:37.946642+00	
00000000-0000-0000-0000-000000000000	fe74a250-7a32-47f0-a9fa-d64bb4426942	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 00:18:37.963662+00	
00000000-0000-0000-0000-000000000000	fa3e0b24-3867-4fa5-9240-173bb565c7a7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 03:06:16.275512+00	
00000000-0000-0000-0000-000000000000	2cc4cd58-82c4-402a-abf0-3cf5bf5f0033	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 03:06:16.304389+00	
00000000-0000-0000-0000-000000000000	fe189076-adad-4cad-869f-561aaed768b5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 04:05:33.798796+00	
00000000-0000-0000-0000-000000000000	9f0c4425-5842-4897-a44e-845be23352a9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 04:05:33.810659+00	
00000000-0000-0000-0000-000000000000	3e7a42e7-6f45-45f6-9181-bee12a283248	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 05:04:34.417756+00	
00000000-0000-0000-0000-000000000000	40d2de6c-48b0-41fe-a378-e9556d7e9dbe	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 05:04:34.433201+00	
00000000-0000-0000-0000-000000000000	27e1f6fc-aed7-49e3-847e-7ff36a85adfa	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 21:06:20.050671+00	
00000000-0000-0000-0000-000000000000	be9abfb4-4f2a-493f-9fc5-837f4014960f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 21:06:20.07281+00	
00000000-0000-0000-0000-000000000000	b1fd7106-9949-4284-af2b-6a919c88132b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 22:05:45.837314+00	
00000000-0000-0000-0000-000000000000	9caa449f-1b31-490d-a4eb-78958df9918d	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 22:05:45.848897+00	
00000000-0000-0000-0000-000000000000	89f462ce-0b22-455b-8a55-0cab718d089e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 23:04:20.759115+00	
00000000-0000-0000-0000-000000000000	6e582bb9-9b54-4595-af7c-f532ee062797	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-08 23:04:20.766667+00	
00000000-0000-0000-0000-000000000000	3fc2a813-053b-484e-b70d-2f90560d6ebb	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-09 00:02:42.927007+00	
00000000-0000-0000-0000-000000000000	fad6ee0f-0f45-4fbb-a1ae-578189058853	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-09 00:02:42.942143+00	
00000000-0000-0000-0000-000000000000	bf8af9e8-29c7-459a-8fb4-d5a79bbf08e3	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-09 01:00:44.012499+00	
00000000-0000-0000-0000-000000000000	e27cfe03-8d4b-4ef8-b464-8fd6b84f1c19	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-09 01:00:44.019862+00	
00000000-0000-0000-0000-000000000000	cc94a3c8-3904-49b2-87ad-8a95d00cf839	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-09 01:59:43.678125+00	
00000000-0000-0000-0000-000000000000	ee0745fa-b0c4-4169-bff2-a2da4c85c597	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-09 01:59:43.691346+00	
00000000-0000-0000-0000-000000000000	c0dcf6da-f6cb-40bd-a1c1-8f3c01ec9975	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-09 02:58:44.186072+00	
00000000-0000-0000-0000-000000000000	8b8a3930-84ba-4c3d-80a6-b496ae326126	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-09 02:58:44.205516+00	
00000000-0000-0000-0000-000000000000	513a20ca-0090-4553-b834-c4c04fb937c5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-10 02:19:40.739239+00	
00000000-0000-0000-0000-000000000000	92006db4-7c8d-401b-add2-5b6bab1930d3	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-10 02:19:40.765191+00	
00000000-0000-0000-0000-000000000000	88ed6f74-83d9-48c9-a4be-b6ed75cfaa9c	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-10 03:18:30.377617+00	
00000000-0000-0000-0000-000000000000	6710db72-3fa2-439d-bc59-1e5447834800	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-10 03:18:30.394654+00	
00000000-0000-0000-0000-000000000000	fb7c7ea5-4502-4788-b302-a7ef65e6f71b	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-10 03:49:54.776737+00	
00000000-0000-0000-0000-000000000000	5e5d7f2a-f2d1-493a-a015-60279f13e4e1	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 16:15:11.798698+00	
00000000-0000-0000-0000-000000000000	7b8fe278-ebc9-4279-8ffd-fd48069c874d	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 16:15:11.822528+00	
00000000-0000-0000-0000-000000000000	a1aca20b-a3ba-416e-9c94-6ff73afee7c9	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 17:14:08.510244+00	
00000000-0000-0000-0000-000000000000	8d81970c-b087-43d6-8374-f19cf782db10	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 17:14:08.520812+00	
00000000-0000-0000-0000-000000000000	80321c78-eefc-4472-b90a-f500df288a81	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 18:12:10.455357+00	
00000000-0000-0000-0000-000000000000	bd39cdc8-c0b8-450a-a9a5-eb2491143636	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 18:12:10.464311+00	
00000000-0000-0000-0000-000000000000	d7e0fa3a-575d-43a0-b2ee-4c3dd8de0005	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 19:10:40.488733+00	
00000000-0000-0000-0000-000000000000	90768740-7520-4441-844d-d39266779744	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 19:10:40.496861+00	
00000000-0000-0000-0000-000000000000	273ecd3c-454d-47ef-93f1-69d614a449e6	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 22:27:26.364637+00	
00000000-0000-0000-0000-000000000000	de3ca3f5-0176-4c14-b7e7-e016a91a7f24	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 22:27:26.375062+00	
00000000-0000-0000-0000-000000000000	97de0242-5113-4a1f-a8be-fa992563933d	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 23:46:28.662168+00	
00000000-0000-0000-0000-000000000000	7f0b1489-635b-4cd3-a387-8b5ea5a156fe	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-13 23:46:28.683185+00	
00000000-0000-0000-0000-000000000000	38bfae98-6f36-4b51-a436-815fac37bbd5	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-13 23:47:32.53652+00	
00000000-0000-0000-0000-000000000000	cfb06bdd-ae20-43ba-9d1b-26fa2480fef1	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-13 23:47:42.866405+00	
00000000-0000-0000-0000-000000000000	a932fc19-d295-4e5b-9470-94d90da96207	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-13 23:57:26.169604+00	
00000000-0000-0000-0000-000000000000	27aa801b-1d0d-4f73-b7b0-e63963e3d4a1	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-13 23:57:34.535919+00	
00000000-0000-0000-0000-000000000000	43162856-c041-487f-94a8-854f675d4b99	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-13 23:59:15.083039+00	
00000000-0000-0000-0000-000000000000	4e396d78-b12f-47e3-a611-5f21a098a291	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-13 23:59:21.963607+00	
00000000-0000-0000-0000-000000000000	7bdc5179-d0ef-4cf2-a85e-b1a7ba39276d	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 00:00:41.958593+00	
00000000-0000-0000-0000-000000000000	046aea75-bfcb-4ad9-995f-7df1ac7aa186	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 00:00:49.352032+00	
00000000-0000-0000-0000-000000000000	a241abe0-55e0-46f2-945d-9ab17aa8850f	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 00:06:24.321492+00	
00000000-0000-0000-0000-000000000000	ba4f427b-867e-4a55-9df2-8e42a604a380	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 00:06:58.928973+00	
00000000-0000-0000-0000-000000000000	a26e85b7-b4ca-4524-ab8c-40ef017da0fc	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 00:07:33.197173+00	
00000000-0000-0000-0000-000000000000	a23ec3c8-8e7a-4007-9507-8701c1686b35	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 00:07:42.054559+00	
00000000-0000-0000-0000-000000000000	305fa48d-fb42-4818-8b09-a9fdcf08a70b	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 00:27:15.593585+00	
00000000-0000-0000-0000-000000000000	00882d90-4f59-4d71-a715-6f2222bd8205	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 00:36:30.667584+00	
00000000-0000-0000-0000-000000000000	6768de4f-31cb-4174-ad8f-0f8b97dab0a7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-14 01:35:11.293402+00	
00000000-0000-0000-0000-000000000000	4e982fb9-3f88-44eb-95b1-aeacb9f2deda	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-14 01:35:11.316888+00	
00000000-0000-0000-0000-000000000000	289e8646-a50e-4e99-81d3-55ac28b1c27e	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 01:35:13.468507+00	
00000000-0000-0000-0000-000000000000	b230a31d-fb38-4678-b574-06ac5374c9fc	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 02:25:35.137706+00	
00000000-0000-0000-0000-000000000000	c8a8a6c6-3032-49bc-96cf-68d6c3e0a69e	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 02:31:56.704327+00	
00000000-0000-0000-0000-000000000000	cc4fc3ed-be66-4780-9d12-385bb9bcd2a6	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 02:33:37.183508+00	
00000000-0000-0000-0000-000000000000	a717b795-f598-48e6-bedd-ac03567766f0	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 02:33:42.713595+00	
00000000-0000-0000-0000-000000000000	909e0010-566b-4b53-b3c9-b19fa0a7b037	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 02:34:04.153761+00	
00000000-0000-0000-0000-000000000000	56b8c3be-8e56-4e35-8e7d-9b4cfeb640d5	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 03:00:05.664989+00	
00000000-0000-0000-0000-000000000000	be1af2b1-ac23-415c-aa9f-db7d46aaa0c5	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 03:00:23.893471+00	
00000000-0000-0000-0000-000000000000	c0205c7b-e1ee-4da8-9f91-c67e009ee513	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 03:00:35.474515+00	
00000000-0000-0000-0000-000000000000	a26138e1-fe01-4a3e-8b51-71919120dbd9	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 03:00:51.855736+00	
00000000-0000-0000-0000-000000000000	bcb9d1f7-4b8c-40d1-becc-d05d31ff436b	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 03:01:02.10123+00	
00000000-0000-0000-0000-000000000000	b3c18263-96f8-4e9f-b814-41127463b6f2	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 03:03:51.348783+00	
00000000-0000-0000-0000-000000000000	7e6317aa-b7ed-4ab3-8de1-0a2ea632c27f	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 03:04:02.97793+00	
00000000-0000-0000-0000-000000000000	eca4fcac-d372-45ef-a34d-50c49f7db8e5	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 03:04:17.450318+00	
00000000-0000-0000-0000-000000000000	01986e96-cdc5-408d-8aac-aebc6f72b90f	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 03:16:22.203285+00	
00000000-0000-0000-0000-000000000000	72738a03-e46e-4507-aaf1-21fdb41c5223	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 03:16:31.13805+00	
00000000-0000-0000-0000-000000000000	5e53e4b4-64c6-4541-9e4a-d3515126c95e	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 03:17:53.937619+00	
00000000-0000-0000-0000-000000000000	a964123f-fb4d-4260-936e-661dd8743e2d	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 03:18:01.743622+00	
00000000-0000-0000-0000-000000000000	8ab2c25c-bb3b-4dc3-ae1a-c70a04f66895	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 20:12:11.465865+00	
00000000-0000-0000-0000-000000000000	1a2ce5aa-7045-482a-8365-338e87a4cc9b	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 20:24:53.977359+00	
00000000-0000-0000-0000-000000000000	a1ef93af-bafa-406c-a264-7b04b536df6a	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 20:25:04.101969+00	
00000000-0000-0000-0000-000000000000	143406fe-ac21-48f8-b82b-2c0434320050	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 20:26:03.327243+00	
00000000-0000-0000-0000-000000000000	729a6f6c-bbb5-4475-97ac-d31c1825cd53	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 20:26:12.429492+00	
00000000-0000-0000-0000-000000000000	6b1e9ca6-be3b-42b8-9eb3-f9aa57a32ccb	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-14 21:28:04.682574+00	
00000000-0000-0000-0000-000000000000	5fd64fed-7bc9-4197-b2b3-9e10ad4ef2ff	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-14 21:28:04.706475+00	
00000000-0000-0000-0000-000000000000	db9a6571-f75e-4133-83c8-b52cefbde8e9	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-14 21:28:13.366892+00	
00000000-0000-0000-0000-000000000000	fa7a27a7-dcdb-4aba-abcf-088b58ecfe01	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 21:28:54.44402+00	
00000000-0000-0000-0000-000000000000	2aef930d-fa8f-406b-87a0-006c5d5abf2d	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-14 21:55:36.599885+00	
00000000-0000-0000-0000-000000000000	13f7f6ad-878d-4b0f-b6d5-f026cd87b6d5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-14 22:54:08.210756+00	
00000000-0000-0000-0000-000000000000	32be83ff-82d6-4ad5-ad52-3290881d5d7c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-14 22:54:08.222649+00	
00000000-0000-0000-0000-000000000000	6274c92e-618f-405c-a2f7-bd078c297e7f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 00:41:03.922531+00	
00000000-0000-0000-0000-000000000000	016a1b31-109f-4b19-913e-bc5a5cbe6c2f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 00:41:03.947518+00	
00000000-0000-0000-0000-000000000000	cc646dd1-79b2-4b82-9eeb-58ee0ceec2be	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 01:14:51.926209+00	
00000000-0000-0000-0000-000000000000	62760798-efda-4428-9e26-fd9f2a3c6e3d	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 01:32:29.653007+00	
00000000-0000-0000-0000-000000000000	faa0f874-149c-4de5-a68e-0e7d04d84b58	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 01:57:48.017335+00	
00000000-0000-0000-0000-000000000000	4ba2a15a-8a3c-40d2-936c-b2af7abacdb1	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 01:57:56.177781+00	
00000000-0000-0000-0000-000000000000	f2e5d01f-8a16-46bf-8869-30c706fb8aee	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 01:58:09.280984+00	
00000000-0000-0000-0000-000000000000	cdd48a68-1d12-4b10-bf37-3b08c99d25ce	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 01:58:22.147396+00	
00000000-0000-0000-0000-000000000000	98d40df2-e48d-4072-9afa-ba6927566d10	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 01:59:13.193411+00	
00000000-0000-0000-0000-000000000000	4a1ba855-4b8c-449a-bbd0-c0acc48f3539	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 01:59:26.267959+00	
00000000-0000-0000-0000-000000000000	55f6dda5-fd74-4cd0-b451-3e8d5984347a	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 02:19:49.128471+00	
00000000-0000-0000-0000-000000000000	6c0c9f3a-8eb2-424a-8fc0-a14e4d26e279	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 02:22:50.710784+00	
00000000-0000-0000-0000-000000000000	79278cff-2dcd-41c0-b848-b51b3e80b70f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 03:01:03.134887+00	
00000000-0000-0000-0000-000000000000	c7eb96c8-571b-48a1-acac-cca0b0f39b33	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 03:02:39.288577+00	
00000000-0000-0000-0000-000000000000	baf0e241-d3d8-4290-86bf-adf3b1772987	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 03:12:50.760733+00	
00000000-0000-0000-0000-000000000000	d2ce42f0-6efd-44ce-b7df-dfaa7e1ba317	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 03:26:05.153696+00	
00000000-0000-0000-0000-000000000000	cb868a51-bfd8-48eb-9d34-f63660719981	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 03:28:56.20045+00	
00000000-0000-0000-0000-000000000000	c8f18759-9a0b-40a7-b089-013c56a7c502	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-15 03:29:43.285158+00	
00000000-0000-0000-0000-000000000000	33094e17-e9c7-45e4-9e5c-3c4976341bd3	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 03:29:50.916572+00	
00000000-0000-0000-0000-000000000000	732f664d-32d4-41b6-90ef-6a73b11fbc66	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 04:29:11.602258+00	
00000000-0000-0000-0000-000000000000	9fa24477-8001-4fb8-a7da-f8588754c044	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 04:29:11.615567+00	
00000000-0000-0000-0000-000000000000	f46cd1e4-ae78-4b5f-93cb-743d2c0be002	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 05:27:49.143331+00	
00000000-0000-0000-0000-000000000000	84b256be-d35b-455c-8930-def9d4bec11c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 05:27:49.155095+00	
00000000-0000-0000-0000-000000000000	9ebf31f9-99d9-4956-9911-324957671db5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 17:24:46.890315+00	
00000000-0000-0000-0000-000000000000	259b1de9-fe33-4a0f-8192-f032f2c1477d	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 17:24:46.907705+00	
00000000-0000-0000-0000-000000000000	ba0b23aa-f7f6-4d8d-9d71-890c95299b96	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 18:23:50.616446+00	
00000000-0000-0000-0000-000000000000	cf1c01f7-84e8-48f0-9529-1c1f2d3c3b2a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 18:23:50.630353+00	
00000000-0000-0000-0000-000000000000	f1c99daf-a1c4-4242-b92e-bf4ae9cac0fa	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 19:22:50.880416+00	
00000000-0000-0000-0000-000000000000	fc25596e-85cc-4279-972b-4b2a3e40c53f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 19:22:50.891014+00	
00000000-0000-0000-0000-000000000000	d00564d4-089f-4d58-9cf2-c5dc24b07b9d	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 20:21:50.674501+00	
00000000-0000-0000-0000-000000000000	2ebb0f35-48ec-460f-8b75-519e7b3ef3ea	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 20:21:50.68835+00	
00000000-0000-0000-0000-000000000000	b0b45950-3a56-4079-ac99-14629c44b641	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-15 21:13:56.468608+00	
00000000-0000-0000-0000-000000000000	9a554213-bb11-4b64-8839-9b36c8f2f6a9	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 22:12:50.577921+00	
00000000-0000-0000-0000-000000000000	5b825c58-ed1b-4090-bc60-d010a52e9331	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 22:12:50.585847+00	
00000000-0000-0000-0000-000000000000	40d1aff3-7f9f-4e9d-8c93-1f9d507587bc	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 23:16:20.825102+00	
00000000-0000-0000-0000-000000000000	91f9869c-664b-43ec-a822-9edb809280f3	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-15 23:16:20.83638+00	
00000000-0000-0000-0000-000000000000	ab5a5ac8-37c2-4ff4-bde5-3b2ad6d88d3f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 00:15:13.518735+00	
00000000-0000-0000-0000-000000000000	5b648eb6-e243-448f-81fc-c479caefb04c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 00:15:13.533908+00	
00000000-0000-0000-0000-000000000000	473a4532-ad0b-4450-82db-eb1c4d203db5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 01:19:03.750299+00	
00000000-0000-0000-0000-000000000000	c19e48d5-578f-4c53-86db-be469108230e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 01:19:03.759285+00	
00000000-0000-0000-0000-000000000000	b2beeb9b-373e-4196-b955-f8718ba01825	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 02:57:26.947168+00	
00000000-0000-0000-0000-000000000000	f171ae28-f557-4cad-aecd-dcf705aa6a86	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 02:57:26.954694+00	
00000000-0000-0000-0000-000000000000	c2c2bf37-8231-4374-8345-1810ad2ab701	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 04:07:22.165419+00	
00000000-0000-0000-0000-000000000000	a238ebf2-6d69-4b4f-a996-e7d70e8bca3a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 04:07:22.196289+00	
00000000-0000-0000-0000-000000000000	a4fefaa9-67b5-4cc6-867d-0c30c02c6eca	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 05:06:15.160508+00	
00000000-0000-0000-0000-000000000000	d45aede3-addb-4e41-ad2c-27a5c4880312	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 05:06:15.179675+00	
00000000-0000-0000-0000-000000000000	6f09f7f4-70a9-4d30-8ab6-721e1ab582d8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 06:05:14.695528+00	
00000000-0000-0000-0000-000000000000	5d7b1302-e9e7-4e3b-9dde-e71dae536666	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 06:05:14.709345+00	
00000000-0000-0000-0000-000000000000	0d31b512-9097-44ab-9e4e-bb2d59dcb3c2	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 07:03:16.826537+00	
00000000-0000-0000-0000-000000000000	082a1154-5bc7-46e3-b998-e804f99eb618	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 07:03:16.840889+00	
00000000-0000-0000-0000-000000000000	c1d120eb-ea05-4aea-9a1c-fbca0bd14fe5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 08:01:17.303117+00	
00000000-0000-0000-0000-000000000000	5d43d0c0-66e0-447a-9e40-f8614216fdeb	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 08:01:17.317512+00	
00000000-0000-0000-0000-000000000000	3595d053-2fd0-4cd9-8f56-764b2931edaf	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 09:00:29.249863+00	
00000000-0000-0000-0000-000000000000	d32873b8-35da-4ca3-a8f4-0b942b54692c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 09:00:29.265465+00	
00000000-0000-0000-0000-000000000000	17d796e7-7ea6-4c20-8b68-74a89669e072	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-16 09:31:00.668346+00	
00000000-0000-0000-0000-000000000000	cb54d10b-3e89-4b7a-9ff6-a6bd8ba488e8	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-16 10:22:01.008186+00	
00000000-0000-0000-0000-000000000000	bae467af-a002-41df-9d78-876f2f08d13f	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-16 10:24:15.228021+00	
00000000-0000-0000-0000-000000000000	90f71e67-7aee-4c2f-96a4-c9906895b19f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-16 10:24:33.830714+00	
00000000-0000-0000-0000-000000000000	fd480210-4d16-4516-8380-f47c5bb01087	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-16 10:25:08.289019+00	
00000000-0000-0000-0000-000000000000	22739af7-2b2e-4505-8b88-62d26a8377a9	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-16 10:26:03.507681+00	
00000000-0000-0000-0000-000000000000	52adb5bb-b743-42cb-befc-65f9efb09990	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-16 10:31:22.863244+00	
00000000-0000-0000-0000-000000000000	7d63bcf4-0c0c-4756-8004-4bd0920695fb	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-12-16 10:31:28.453982+00	
00000000-0000-0000-0000-000000000000	0c641cdf-b514-4a5f-8dca-80c520a4265a	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-16 10:31:52.020637+00	
00000000-0000-0000-0000-000000000000	a9593850-a2d9-430a-acde-d0b7969f6b42	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-16 10:33:14.773321+00	
00000000-0000-0000-0000-000000000000	57c516f8-3c1c-461d-ba5b-5e002e3515f2	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-16 16:10:29.8296+00	
00000000-0000-0000-0000-000000000000	d44fd5d0-bfc9-4753-a83a-ac1cc563812f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-16 16:28:07.633059+00	
00000000-0000-0000-0000-000000000000	2b957eb0-9ea2-43d7-9f77-c8a8e539fc72	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 16:51:21.513735+00	
00000000-0000-0000-0000-000000000000	1c3e6563-8808-4ff2-97e7-b4550c63479d	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 16:51:21.522613+00	
00000000-0000-0000-0000-000000000000	15811090-6eb2-41dd-9364-59a3349a6384	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 19:12:52.134443+00	
00000000-0000-0000-0000-000000000000	0285533a-a82b-4652-981e-351e4ceaa637	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-16 19:12:52.157382+00	
00000000-0000-0000-0000-000000000000	ef19da2f-8a0a-4922-b68a-7991a138ddc0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-17 02:43:46.217516+00	
00000000-0000-0000-0000-000000000000	07cb3565-c30c-43f4-973a-532f73a94329	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-17 02:43:46.228422+00	
00000000-0000-0000-0000-000000000000	672b7dff-e2f9-48ef-8caa-57fb3ac8f407	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-17 03:59:45.765216+00	
00000000-0000-0000-0000-000000000000	5ca6047a-bb1c-4f01-9cd4-0978c052c256	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-17 03:59:45.78922+00	
00000000-0000-0000-0000-000000000000	a0e2542d-d7d1-44ab-8eeb-78eeedec6a4f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-17 04:59:02.89398+00	
00000000-0000-0000-0000-000000000000	45d7ad5a-5aeb-4eea-99ee-eb6b4a0f102e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-17 04:59:02.911242+00	
00000000-0000-0000-0000-000000000000	91077308-2671-4b63-a5b0-19195de9b719	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-17 14:44:16.853205+00	
00000000-0000-0000-0000-000000000000	8d287d9c-2251-4c54-897b-544d877636ba	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-17 15:01:48.500294+00	
00000000-0000-0000-0000-000000000000	0172dc5b-0dd1-4d76-b03a-3df780e11019	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-19 16:18:28.426894+00	
00000000-0000-0000-0000-000000000000	6255fba5-2344-418b-8627-4aaf57263959	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-19 16:18:28.458854+00	
00000000-0000-0000-0000-000000000000	bcb15f78-d744-47e7-a4a2-f558635d83bf	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-19 17:17:21.792444+00	
00000000-0000-0000-0000-000000000000	05ed3afa-c3fc-4e6d-95b6-27366b4d0cb0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-19 17:17:21.804075+00	
00000000-0000-0000-0000-000000000000	f4c7ac04-fbef-451e-82de-aa7c2e9630ee	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-19 19:13:10.148842+00	
00000000-0000-0000-0000-000000000000	c16e7f60-6e36-4b82-8782-218cfe6d2db1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-19 19:13:10.170261+00	
00000000-0000-0000-0000-000000000000	7c3bd965-bd94-4dcc-b317-c23d3e584d14	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 00:15:52.373798+00	
00000000-0000-0000-0000-000000000000	399c06b4-97ec-4905-98f1-38d41fecfeae	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 00:15:52.39569+00	
00000000-0000-0000-0000-000000000000	3b2ec402-818b-436c-a794-b8b8d14038bc	{"action":"token_refreshed","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 01:11:15.167135+00	
00000000-0000-0000-0000-000000000000	4d44cde4-665c-491c-931c-fad99b192acb	{"action":"token_revoked","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 01:11:15.184982+00	
00000000-0000-0000-0000-000000000000	95eb0f82-729d-4192-9c8f-0eb3e1cd31b1	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 01:14:32.024976+00	
00000000-0000-0000-0000-000000000000	915965cc-f5a6-4667-9e3e-fe58b79835df	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 01:14:32.026082+00	
00000000-0000-0000-0000-000000000000	9b608f9f-c845-47b1-9883-564a11be4de9	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 02:13:32.186539+00	
00000000-0000-0000-0000-000000000000	2a27e018-d56a-441c-a44c-bf84cf09eb11	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 02:13:32.193701+00	
00000000-0000-0000-0000-000000000000	7267f3dc-0744-4e8e-af85-83a1b4aadc46	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 04:13:44.28466+00	
00000000-0000-0000-0000-000000000000	3b2ef2d1-991e-415a-99b0-5798b5a4ea8f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 04:13:44.311216+00	
00000000-0000-0000-0000-000000000000	8959c4ee-e3a3-4193-8616-3487f1eb7761	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 05:12:15.559826+00	
00000000-0000-0000-0000-000000000000	888bc5af-c233-4f9f-a117-65185a5d9562	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-12-20 05:12:15.567993+00	
00000000-0000-0000-0000-000000000000	e3d2d202-5d4d-42d8-8a50-fa4e5ff3cffe	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-12 03:30:11.854986+00	
00000000-0000-0000-0000-000000000000	aea54fa2-0bbd-4138-b2e4-a73b0e128ba5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-12 04:29:22.617409+00	
00000000-0000-0000-0000-000000000000	43cb568b-b69e-4a77-9b58-20c3ba4390fd	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-12 04:29:22.620011+00	
00000000-0000-0000-0000-000000000000	9613d36d-1924-4e5e-bc04-795b1715f83a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-12 05:27:35.027899+00	
00000000-0000-0000-0000-000000000000	291ad6cc-af25-4908-b715-763273dc43d0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-12 05:27:35.048281+00	
00000000-0000-0000-0000-000000000000	31ce4db6-ad4c-463c-93c1-195ba6816a2d	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-12 15:14:37.884134+00	
00000000-0000-0000-0000-000000000000	50ee1b02-17f3-4cd6-b16e-93c23b4066c1	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-12 16:13:27.45473+00	
00000000-0000-0000-0000-000000000000	59209ca5-c6b0-4ab2-ad9e-15844466430e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-12 16:13:27.467844+00	
00000000-0000-0000-0000-000000000000	77bd9553-d889-4af9-945e-e5ba8c6c9a29	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-12 17:12:26.850412+00	
00000000-0000-0000-0000-000000000000	2ad61234-a728-4a5d-8b43-8ae128c88293	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-12 17:12:26.860793+00	
00000000-0000-0000-0000-000000000000	a20ea336-ef4b-4e93-9597-533911f35125	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 02:19:36.95359+00	
00000000-0000-0000-0000-000000000000	42b463af-ac26-4900-bf68-7f6b9b8bd6e5	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 02:19:36.972937+00	
00000000-0000-0000-0000-000000000000	410ad087-7006-471d-9eb2-d267374cbc4b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 03:18:56.29661+00	
00000000-0000-0000-0000-000000000000	3253750c-2412-42ab-8d16-fcc77f341072	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 03:18:56.309021+00	
00000000-0000-0000-0000-000000000000	99a331f9-5a65-4a26-9f40-3ca7d3ff692e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 04:17:10.47998+00	
00000000-0000-0000-0000-000000000000	04e56056-369b-4abd-93ea-deb72a12c8d4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 04:17:10.491102+00	
00000000-0000-0000-0000-000000000000	379a2cec-da9d-4637-b3d0-c621c0b4d2b0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-14 02:31:41.384132+00	
00000000-0000-0000-0000-000000000000	2fac769a-4ef1-437c-8c14-7b6c778abf45	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-14 02:31:41.40263+00	
00000000-0000-0000-0000-000000000000	dc96ffb0-1364-478d-8c1b-c6cdeee66259	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-14 03:36:28.433172+00	
00000000-0000-0000-0000-000000000000	84aea636-9be2-45ae-aed3-6517549ce97f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-14 04:35:55.96586+00	
00000000-0000-0000-0000-000000000000	cd4304bc-1bed-4d86-ac99-95b5edc601b5	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-14 04:35:55.976414+00	
00000000-0000-0000-0000-000000000000	adada8ce-4070-4806-992e-d650dda876f0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-15 01:28:01.086061+00	
00000000-0000-0000-0000-000000000000	aa3451e2-9dce-4384-9f2f-93b6f82d991e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-15 01:28:01.112112+00	
00000000-0000-0000-0000-000000000000	4f540ad7-e9fa-4006-9d7d-f6e6ff4dee11	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-15 03:53:26.312379+00	
00000000-0000-0000-0000-000000000000	c0198f82-411e-4638-8058-010ed631b997	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-15 03:53:26.335394+00	
00000000-0000-0000-0000-000000000000	c93d153b-360e-4d2f-883f-f47596210688	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-15 04:51:57.970633+00	
00000000-0000-0000-0000-000000000000	ab307e09-4260-4001-adc4-3c86eb5fa509	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-15 04:51:57.993344+00	
00000000-0000-0000-0000-000000000000	72e8efba-af16-43b8-8166-fafbc5430cbd	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-15 05:50:57.376843+00	
00000000-0000-0000-0000-000000000000	b3571dff-67f1-49ea-96f4-698bca2fc5cc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-15 05:50:57.381865+00	
00000000-0000-0000-0000-000000000000	78127103-20f3-40b9-aa6b-aa74339700ec	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-18 22:51:25.657514+00	
00000000-0000-0000-0000-000000000000	3bcdc394-e945-43d8-8e8a-661fed3a329c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-18 22:51:25.685002+00	
00000000-0000-0000-0000-000000000000	91d25a10-6f25-4efe-9830-d01f907d6a09	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-18 23:51:46.723342+00	
00000000-0000-0000-0000-000000000000	f85f7ca7-143c-473d-ae2a-244c7a52b52c	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 00:50:06.745403+00	
00000000-0000-0000-0000-000000000000	67a7a909-5a8d-4576-b60c-bbefd0ee23ef	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 00:50:06.763147+00	
00000000-0000-0000-0000-000000000000	69d05b2e-d8c5-46ca-83a0-ece39cece9ad	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 01:08:49.193491+00	
00000000-0000-0000-0000-000000000000	3450c8a5-81c8-4a21-8218-abae4ca8555d	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 01:08:49.211038+00	
00000000-0000-0000-0000-000000000000	820e5f40-1f8d-4e73-a8da-3a65dcd1ce79	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 03:20:28.985939+00	
00000000-0000-0000-0000-000000000000	81e6f8f6-4892-486d-8590-b0623377c125	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 03:20:28.996703+00	
00000000-0000-0000-0000-000000000000	a5ed5c4d-eff5-4934-874a-d9db7526ee56	{"action":"user_confirmation_requested","actor_id":"a721cb76-7b06-4025-afed-d62c9f579550","actor_username":"yanellyart@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-01-19 03:49:52.133+00	
00000000-0000-0000-0000-000000000000	46ad971e-a68d-4362-a76b-9a7e63ba4a0f	{"action":"user_confirmation_requested","actor_id":"84d3eaaf-2a36-42c4-b3e5-b93ac3fe9ae9","actor_username":"yarteaga23@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-01-19 04:01:33.555503+00	
00000000-0000-0000-0000-000000000000	825913b2-c47c-4b32-9877-2db4f3f9aa1c	{"action":"user_confirmation_requested","actor_id":"233d26ed-f72e-4ff7-b859-2b8b48b8c6b3","actor_username":"merart@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-01-19 04:07:42.028615+00	
00000000-0000-0000-0000-000000000000	94302677-c8bd-4c3d-a94b-6400a3acc5eb	{"action":"user_confirmation_requested","actor_id":"ecfe53a4-3b92-472e-bcf0-f77807681f84","actor_username":"kengart@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-01-19 04:11:08.622418+00	
00000000-0000-0000-0000-000000000000	73475be9-0a51-46dc-b1fc-160610c24602	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 04:14:49.099467+00	
00000000-0000-0000-0000-000000000000	b4b1dfc9-de12-4545-b3bf-0cb3789b9576	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 04:14:57.821978+00	
00000000-0000-0000-0000-000000000000	ebeb9b40-2106-47ea-b9a0-0d25d0f3d437	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 04:16:31.093827+00	
00000000-0000-0000-0000-000000000000	d4d556c7-fc47-4be3-8618-77ef87da3935	{"action":"user_confirmation_requested","actor_id":"9d0f2934-0bf1-4eae-9fa4-234870fb66cb","actor_username":"danivm@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-01-19 04:21:18.53994+00	
00000000-0000-0000-0000-000000000000	08a27e4d-b865-4bd0-8fe1-d2661544c10e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 05:15:41.968709+00	
00000000-0000-0000-0000-000000000000	8ab1b3f9-02c0-4379-bb8b-d89aba9bdf03	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 05:15:41.980642+00	
00000000-0000-0000-0000-000000000000	ef3cfb66-fa44-4e29-a3cd-bc252aa8c0dd	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 06:14:37.055578+00	
00000000-0000-0000-0000-000000000000	aeb9e93e-151b-4d51-9db3-b900002a9350	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 06:14:37.065876+00	
00000000-0000-0000-0000-000000000000	6dc9cf27-3f14-4c85-b93e-cbd4a61a7401	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 06:50:40.715865+00	
00000000-0000-0000-0000-000000000000	2fe222fa-4990-443e-9edc-eab0579c6b5d	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 18:35:38.74777+00	
00000000-0000-0000-0000-000000000000	f4c4dfbe-f976-4176-9cbd-c93d6d231d0a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 18:35:38.772074+00	
00000000-0000-0000-0000-000000000000	636a5418-7509-40ab-97c8-c8ef84907057	{"action":"user_signedup","actor_id":"d1fd4826-8e5a-4cae-9222-aef526df4961","actor_username":"estudiante1@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-01-19 18:51:24.339507+00	
00000000-0000-0000-0000-000000000000	8754999a-f15d-4986-91ac-7c8fff377873	{"action":"login","actor_id":"d1fd4826-8e5a-4cae-9222-aef526df4961","actor_username":"estudiante1@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 18:51:24.34732+00	
00000000-0000-0000-0000-000000000000	988aead1-5514-478d-8fa3-f1802d1130c9	{"action":"user_repeated_signup","actor_id":"d1fd4826-8e5a-4cae-9222-aef526df4961","actor_username":"estudiante1@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-01-19 18:51:59.827885+00	
00000000-0000-0000-0000-000000000000	557220b5-ea1d-4ad2-8029-8a40f4357a15	{"action":"logout","actor_id":"d1fd4826-8e5a-4cae-9222-aef526df4961","actor_username":"estudiante1@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-01-19 19:01:05.934172+00	
00000000-0000-0000-0000-000000000000	aa70bc3a-b20c-42cc-9752-2094be49320e	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 19:01:23.387804+00	
00000000-0000-0000-0000-000000000000	e3a7e062-77af-4fc2-a6d0-970d2d12d1c6	{"action":"user_signedup","actor_id":"e836b53c-0eb8-4c93-9e8c-e972aab5b995","actor_username":"estudiante1@didactikapp.local","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-01-19 19:02:23.634983+00	
00000000-0000-0000-0000-000000000000	351788d9-877f-4563-84c2-98f5143ed558	{"action":"login","actor_id":"e836b53c-0eb8-4c93-9e8c-e972aab5b995","actor_username":"estudiante1@didactikapp.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 19:02:23.644757+00	
00000000-0000-0000-0000-000000000000	6f93a055-1808-461f-8ce2-25e9b9b3ef72	{"action":"user_signedup","actor_id":"55db67b3-bc35-4671-81f3-a996a5350425","actor_username":"estudiante2@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-01-19 19:06:30.724061+00	
00000000-0000-0000-0000-000000000000	55ffe8a0-d088-44eb-a26b-43525f7c2b2c	{"action":"login","actor_id":"55db67b3-bc35-4671-81f3-a996a5350425","actor_username":"estudiante2@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 19:06:30.737338+00	
00000000-0000-0000-0000-000000000000	c8a9109c-ec12-4220-9c88-397a3b72086b	{"action":"user_signedup","actor_id":"009551f7-f973-4e33-82c5-cc7f2171e07f","actor_username":"estudiante3@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-01-19 19:08:45.445978+00	
00000000-0000-0000-0000-000000000000	c989f30e-fd4d-4ecf-97ad-845a0fe6defe	{"action":"login","actor_id":"009551f7-f973-4e33-82c5-cc7f2171e07f","actor_username":"estudiante3@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 19:08:45.450272+00	
00000000-0000-0000-0000-000000000000	32e6a556-c80a-4eb4-a1d6-dfd1abb86a8e	{"action":"user_repeated_signup","actor_id":"009551f7-f973-4e33-82c5-cc7f2171e07f","actor_username":"estudiante3@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-01-19 19:12:33.135986+00	
00000000-0000-0000-0000-000000000000	ddda36df-5f47-4ae5-a6b0-7f4e785a20d5	{"action":"user_repeated_signup","actor_id":"009551f7-f973-4e33-82c5-cc7f2171e07f","actor_username":"estudiante3@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-01-19 19:12:38.498267+00	
00000000-0000-0000-0000-000000000000	d463b718-3a04-4d7c-93bf-c7f8b51d98a6	{"action":"user_signedup","actor_id":"27226334-0bfb-4d86-9a02-1fe3763995ed","actor_username":"estudiante4@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-01-19 19:12:47.320686+00	
00000000-0000-0000-0000-000000000000	3a15de5c-c776-4c0d-ba84-60f9a50e68d7	{"action":"login","actor_id":"27226334-0bfb-4d86-9a02-1fe3763995ed","actor_username":"estudiante4@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 19:12:47.326144+00	
00000000-0000-0000-0000-000000000000	4b08c02d-7add-4136-8ef7-f80fa9b445cd	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-19 19:17:56.078326+00	
00000000-0000-0000-0000-000000000000	387d80a6-613b-442f-b607-dbcc9967fe7b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 20:16:30.147786+00	
00000000-0000-0000-0000-000000000000	f3367ca1-a90b-42b5-bdcd-eb04a2958ff6	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 20:16:30.161868+00	
00000000-0000-0000-0000-000000000000	27b872fe-a348-4339-9b3d-a6ce8f815184	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 21:15:19.398235+00	
00000000-0000-0000-0000-000000000000	aebf888c-2071-4125-b599-dfce1a6fd4c4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-19 21:15:19.410464+00	
00000000-0000-0000-0000-000000000000	c6a7c4d5-70fb-43b1-b6e3-41894c4f32e1	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-20 00:29:54.726416+00	
00000000-0000-0000-0000-000000000000	6cc03a22-def8-438a-b6bf-2c321569edcc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-20 00:29:54.742911+00	
00000000-0000-0000-0000-000000000000	36eba2c9-f96d-4fe7-8af9-80eea321290a	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-21 22:56:34.358689+00	
00000000-0000-0000-0000-000000000000	23077881-9d72-4449-a81d-68c458e9de1b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-21 23:56:01.587608+00	
00000000-0000-0000-0000-000000000000	318cfe57-63a0-4dd1-b4b6-d392df120e21	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-21 23:56:01.599181+00	
00000000-0000-0000-0000-000000000000	99f5ccd9-c12f-4a34-ba0f-1c16cb54eff5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 01:04:05.412496+00	
00000000-0000-0000-0000-000000000000	c1b64984-2b29-4682-acf4-0b6a3e55669a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 01:04:05.431418+00	
00000000-0000-0000-0000-000000000000	b6a745c5-b7c4-458a-94da-eac6846e0d34	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 02:03:01.36573+00	
00000000-0000-0000-0000-000000000000	302df167-4250-4984-9649-040df20f79fd	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 02:03:01.372963+00	
00000000-0000-0000-0000-000000000000	7bfc5187-d3c2-405f-a379-81bfffb1b2a0	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-22 03:36:45.370558+00	
00000000-0000-0000-0000-000000000000	4719a5ca-dd00-4306-bee7-e4f72be6012e	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-22 04:33:29.038097+00	
00000000-0000-0000-0000-000000000000	c87af759-dfca-4978-a133-0b0b277242d8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 05:32:43.284289+00	
00000000-0000-0000-0000-000000000000	9cbf5cf4-1826-4ac5-b571-bf5ab460d06e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 05:32:43.298417+00	
00000000-0000-0000-0000-000000000000	b00c7c7b-d3e7-4499-8956-181406124b84	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 06:49:17.861144+00	
00000000-0000-0000-0000-000000000000	f5f59a25-9fe5-4e77-8fcd-de49632e2f00	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 06:49:17.88785+00	
00000000-0000-0000-0000-000000000000	8b318a1f-e22d-4fa7-94ce-eb40ec0c2987	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 13:00:54.072326+00	
00000000-0000-0000-0000-000000000000	a51784ca-ff86-4e74-8c2a-d63f188759ce	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 13:00:54.097914+00	
00000000-0000-0000-0000-000000000000	4a38c7b8-dbf0-4678-bf9e-e2cabc6ae677	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-22 13:27:58.849879+00	
00000000-0000-0000-0000-000000000000	86eaf8e9-a710-4cf5-981a-b792e52f57e0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 16:22:43.317097+00	
00000000-0000-0000-0000-000000000000	90e690f3-d357-4e42-ae7e-fed639957ad9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-22 16:22:43.339425+00	
00000000-0000-0000-0000-000000000000	1d7d0500-5541-4db7-a92f-c1181c5a6894	{"action":"user_signedup","actor_id":"6bd6fd48-7433-4526-8803-516660c1103a","actor_username":"mer123@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-01-22 16:27:29.98694+00	
00000000-0000-0000-0000-000000000000	fb16f02c-ead0-45e3-83b8-e022095b6861	{"action":"login","actor_id":"6bd6fd48-7433-4526-8803-516660c1103a","actor_username":"mer123@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-22 16:27:30.011796+00	
00000000-0000-0000-0000-000000000000	c2957038-8306-4538-b09b-f79125088fd0	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-22 16:43:20.823191+00	
00000000-0000-0000-0000-000000000000	b4255ec7-c6c5-44ce-afbb-52e6aa47344d	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-27 20:41:44.511379+00	
00000000-0000-0000-0000-000000000000	fba6fb69-b50e-4f69-972e-4604e5ef78bb	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 21:40:31.087926+00	
00000000-0000-0000-0000-000000000000	90398cb7-6801-4b1a-aca2-19fd6a58a10f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 21:40:31.09758+00	
00000000-0000-0000-0000-000000000000	955ff0af-22ac-4658-bec8-ed5d988e246b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 22:39:26.4754+00	
00000000-0000-0000-0000-000000000000	dd73f47b-e6af-4c98-bb2c-d976a19a72f8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 22:39:26.487346+00	
00000000-0000-0000-0000-000000000000	a6e93825-e157-4d60-91a1-813ff20848e3	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 23:38:41.833845+00	
00000000-0000-0000-0000-000000000000	da752d99-b6dc-46ed-a8ee-4ab760cf9f02	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 23:38:41.851123+00	
00000000-0000-0000-0000-000000000000	cc89150e-28e8-4bbb-a81b-a4452a0fe798	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 00:37:41.499893+00	
00000000-0000-0000-0000-000000000000	e16ecdbe-84bf-40d0-ba40-4ebec6d0bde2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 00:37:41.507363+00	
00000000-0000-0000-0000-000000000000	a70c59fa-a78a-4127-a423-94955ad0caa2	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 01:36:09.633942+00	
00000000-0000-0000-0000-000000000000	9cfcfeb3-e1a6-41d5-89f3-dd143aca4c64	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 01:36:09.648175+00	
00000000-0000-0000-0000-000000000000	270d444b-f411-470a-8559-ae43334c8a95	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 02:34:09.582769+00	
00000000-0000-0000-0000-000000000000	29d9e0ce-893e-4426-808e-8e771b601374	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 02:34:09.593215+00	
00000000-0000-0000-0000-000000000000	9416f73c-d70d-4061-bdad-20b342e89517	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 03:32:09.597643+00	
00000000-0000-0000-0000-000000000000	ab8d1b92-9345-4ac2-8692-2a27230171e4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 03:32:09.605312+00	
00000000-0000-0000-0000-000000000000	a609237c-1e23-4e2e-9de7-e118476825a4	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 04:30:32.526739+00	
00000000-0000-0000-0000-000000000000	a9f6b2e1-504e-471f-9ecf-2e7750e2b29f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 04:30:32.544717+00	
00000000-0000-0000-0000-000000000000	e1ad6652-0045-4bcf-9929-cdfae00c7384	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 05:29:41.549693+00	
00000000-0000-0000-0000-000000000000	9fdb1603-8457-4287-94fb-cf30f7729b98	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 05:29:41.560453+00	
00000000-0000-0000-0000-000000000000	3cf391a6-9e65-4b4e-be7f-7be6b46f68d4	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 02:15:43.530188+00	
00000000-0000-0000-0000-000000000000	858dab6a-1b27-4615-ac4c-510eb56628d1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 02:15:43.560061+00	
00000000-0000-0000-0000-000000000000	d17fab9b-90b3-4414-b623-1da4bcada873	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 04:03:16.63227+00	
00000000-0000-0000-0000-000000000000	afcc1fa5-5d23-4fb5-a3ac-7ddf52d0b07b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 04:03:16.660155+00	
00000000-0000-0000-0000-000000000000	801b4cb8-572e-4655-a125-099ec87c5a03	{"action":"user_signedup","actor_id":"db36010b-60f9-4d38-bfd1-1fd9063149d7","actor_username":"spidergay@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-01-29 04:18:36.393231+00	
00000000-0000-0000-0000-000000000000	1c00d2f9-7de5-4d4c-a933-62bc6ef9878f	{"action":"login","actor_id":"db36010b-60f9-4d38-bfd1-1fd9063149d7","actor_username":"spidergay@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-29 04:18:36.409378+00	
00000000-0000-0000-0000-000000000000	a6530324-da28-4ade-ae47-0830a9cf2b7c	{"action":"token_refreshed","actor_id":"db36010b-60f9-4d38-bfd1-1fd9063149d7","actor_username":"spidergay@didactikapp.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 16:26:50.131634+00	
00000000-0000-0000-0000-000000000000	5ecacdc2-f8a8-45bd-bc2d-7da745631451	{"action":"token_revoked","actor_id":"db36010b-60f9-4d38-bfd1-1fd9063149d7","actor_username":"spidergay@didactikapp.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 16:26:50.16117+00	
00000000-0000-0000-0000-000000000000	e8d4fb25-e86f-4248-a8f1-30159deee99b	{"action":"logout","actor_id":"db36010b-60f9-4d38-bfd1-1fd9063149d7","actor_username":"spidergay@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-01-29 17:21:08.495154+00	
00000000-0000-0000-0000-000000000000	22175ab5-e539-4b52-babd-e93c52d91afc	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-29 17:21:32.07045+00	
00000000-0000-0000-0000-000000000000	94310565-5308-4315-b3fa-d129f24f4b62	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 18:20:21.115513+00	
00000000-0000-0000-0000-000000000000	78eb891a-a743-4bf0-b261-45ab781cd460	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 18:20:21.131786+00	
00000000-0000-0000-0000-000000000000	5feeb5bf-6117-4e56-9321-a7620687a0c7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 19:19:20.632371+00	
00000000-0000-0000-0000-000000000000	896558a3-3a45-4697-ac2e-87413ca35dce	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 19:19:20.643588+00	
00000000-0000-0000-0000-000000000000	f3a359c8-b8e0-490d-9129-5df03db6eab0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 20:17:53.922003+00	
00000000-0000-0000-0000-000000000000	bc1b3478-1e7e-4dec-bd4e-f4f1dfa04cbc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 20:17:53.93302+00	
00000000-0000-0000-0000-000000000000	c6560b75-eb3e-4b1a-b425-50f7774d1785	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 21:16:53.735424+00	
00000000-0000-0000-0000-000000000000	099ddc3d-da79-4c24-a245-fc37bd85fde8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 21:16:53.752349+00	
00000000-0000-0000-0000-000000000000	f207cade-6de8-4e04-b546-b41a7e5711b7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 22:15:53.99819+00	
00000000-0000-0000-0000-000000000000	da95f7f2-0e8e-4c37-af62-067c51cc30db	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 22:15:54.011554+00	
00000000-0000-0000-0000-000000000000	f1898b17-58b0-4f5d-9a31-d776edb1b6dd	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 23:14:53.833822+00	
00000000-0000-0000-0000-000000000000	e1633b01-2c4f-4e24-a6a9-94b906498cbc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-29 23:14:53.850273+00	
00000000-0000-0000-0000-000000000000	f4a17e89-b142-4432-951c-08c7fe0c6848	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 00:13:54.089424+00	
00000000-0000-0000-0000-000000000000	7c077f0f-002b-4785-89f7-d0eeca5c4fd7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 00:13:54.096869+00	
00000000-0000-0000-0000-000000000000	bdeb02f1-f4e6-4ca9-bd44-f7387ebfd00a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 01:12:53.686476+00	
00000000-0000-0000-0000-000000000000	63d1ccec-dcda-4724-abfc-89e419c1157c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 01:12:53.702364+00	
00000000-0000-0000-0000-000000000000	b12d77bc-0a65-4997-ad90-76b927329699	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 02:11:53.850627+00	
00000000-0000-0000-0000-000000000000	eb03d6ab-5b7a-42e4-a597-13d1b2a8642f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 02:11:53.862546+00	
00000000-0000-0000-0000-000000000000	d137277f-99ee-4659-95c9-082b516e68f5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 03:10:21.666367+00	
00000000-0000-0000-0000-000000000000	ae3ae99e-fa19-41c7-863c-264054fb81b1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 03:10:21.683627+00	
00000000-0000-0000-0000-000000000000	674fa9de-2f9d-4431-bb3e-ee90efaa845e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 04:08:53.901236+00	
00000000-0000-0000-0000-000000000000	0bfc0738-ffe8-4443-a6ac-effb988752df	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 04:08:53.913231+00	
00000000-0000-0000-0000-000000000000	e661018c-f715-43a5-831a-9ba555900114	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 05:07:53.787899+00	
00000000-0000-0000-0000-000000000000	37b357c2-b36b-4ffb-9229-cacaae53f392	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 05:07:53.795469+00	
00000000-0000-0000-0000-000000000000	975e07c9-12c7-4cd4-a38a-b16edfb9dcbb	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-30 05:36:18.791815+00	
00000000-0000-0000-0000-000000000000	c3908f89-f1b0-4d64-a626-be2346c8938b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 06:37:32.668475+00	
00000000-0000-0000-0000-000000000000	0e7e3c4a-ecfe-404a-a46f-bcdd88e87bb3	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 06:37:32.689491+00	
00000000-0000-0000-0000-000000000000	6bd6181e-2ae7-407d-99e3-63e7e9c39e8b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 07:35:36.82558+00	
00000000-0000-0000-0000-000000000000	f54b4058-b3d7-4f5a-ab1a-ab0e75a9e291	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 07:35:36.833687+00	
00000000-0000-0000-0000-000000000000	323919cc-89e1-4490-b051-2f4f237bb0c9	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 07:36:16.071429+00	
00000000-0000-0000-0000-000000000000	49676907-f9fe-42f1-a534-b3cf84f5af54	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 08:34:48.745862+00	
00000000-0000-0000-0000-000000000000	00de4071-72e3-4a80-a5d3-735aeca41155	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 08:34:48.75582+00	
00000000-0000-0000-0000-000000000000	e95532dd-9d12-4d67-92da-d0ea5225a77e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 08:58:02.06798+00	
00000000-0000-0000-0000-000000000000	58335b57-2aa2-4c60-857e-cad76f204a90	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 08:58:02.075025+00	
00000000-0000-0000-0000-000000000000	a881c356-2556-443a-af46-e54923327bf8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 16:12:18.393261+00	
00000000-0000-0000-0000-000000000000	a44f0bbc-cc6f-4957-9d2a-302de15df263	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 16:12:18.412806+00	
00000000-0000-0000-0000-000000000000	d56f707b-ad1c-413a-a891-5d7d17f51802	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-30 16:46:08.82724+00	
00000000-0000-0000-0000-000000000000	93b8e562-1718-48e8-9a8b-1d966a3cb9fb	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 19:20:31.037705+00	
00000000-0000-0000-0000-000000000000	41d15cf7-b68f-4ebd-b519-59ef0715cee4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-30 19:20:31.057195+00	
00000000-0000-0000-0000-000000000000	683dda3e-ed85-47ec-bc52-755c125f14b4	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-31 18:49:41.43889+00	
00000000-0000-0000-0000-000000000000	c6dd4e87-31c3-4054-9260-21855fba1c4e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-01-31 18:49:41.467619+00	
00000000-0000-0000-0000-000000000000	de547fe9-5bb0-43dd-8a46-827bd479bdf6	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-03 04:18:09.051227+00	
00000000-0000-0000-0000-000000000000	e521919c-bd04-4f0c-bf78-8547d3484e0a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-03 04:18:09.079128+00	
00000000-0000-0000-0000-000000000000	0ca472af-4ab2-4ef3-ad88-a59b23e58257	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-03 04:32:04.865179+00	
00000000-0000-0000-0000-000000000000	08c24c1c-90f3-48f3-ba53-4aac87ae68ad	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-03 04:32:04.868458+00	
00000000-0000-0000-0000-000000000000	15a10540-1fbc-4130-9595-b540adf572b3	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-04 15:43:57.725453+00	
00000000-0000-0000-0000-000000000000	01742061-7275-4f74-9e37-f278ce4f9108	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-04 15:43:57.752145+00	
00000000-0000-0000-0000-000000000000	e0a1b848-20ac-4748-91af-a27c5709bb07	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-04 21:22:47.508119+00	
00000000-0000-0000-0000-000000000000	9bb4aaf9-ebb1-43c6-bced-d5dd388c83d1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-04 21:22:47.531745+00	
00000000-0000-0000-0000-000000000000	a05221c0-82b1-4f40-8d6f-0dbfa623f453	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-04 22:35:32.402057+00	
00000000-0000-0000-0000-000000000000	f9a361ad-6df6-4ce5-993f-f2ec7ff189eb	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-04 22:35:32.430085+00	
00000000-0000-0000-0000-000000000000	a66e1821-d9de-4436-bdfd-a829063c0fec	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-04 23:34:56.098812+00	
00000000-0000-0000-0000-000000000000	1ae5b36b-9f73-4c54-a3cf-679fc4343086	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-04 23:34:56.115713+00	
00000000-0000-0000-0000-000000000000	1b86f480-5836-4ac7-9ffb-23a2cd00e548	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 01:04:32.213385+00	
00000000-0000-0000-0000-000000000000	2f9cdeb4-b829-479c-b347-147cac971db4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 01:04:32.237083+00	
00000000-0000-0000-0000-000000000000	a2488777-209c-43ce-8707-a9157d76ded6	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 02:06:45.42707+00	
00000000-0000-0000-0000-000000000000	8f4e0433-17b3-4c36-a4b1-c08353b5b64b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 02:06:45.440764+00	
00000000-0000-0000-0000-000000000000	8e1610f8-5a61-4be9-b781-548a3b442923	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 03:04:54.317584+00	
00000000-0000-0000-0000-000000000000	8e900558-542b-4754-8094-179d672a71c4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 03:04:54.339117+00	
00000000-0000-0000-0000-000000000000	76180f65-b3f3-40eb-9448-618ec3d89223	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 04:03:01.023175+00	
00000000-0000-0000-0000-000000000000	68fccf10-a205-423a-85de-ee636ba3ddcb	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 04:03:01.040651+00	
00000000-0000-0000-0000-000000000000	45eb0334-2084-4938-90e0-cb30eb7d4df5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 05:01:26.058078+00	
00000000-0000-0000-0000-000000000000	4d8197fc-7cdd-4718-a6d5-e161773325b6	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 05:01:26.069328+00	
00000000-0000-0000-0000-000000000000	a0d64669-86e0-4b9f-acb8-9ff074606404	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 05:59:58.622355+00	
00000000-0000-0000-0000-000000000000	fbae3371-d7a4-4e52-a470-33c8d019e8e2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 05:59:58.632215+00	
00000000-0000-0000-0000-000000000000	53bd6a5d-8f86-48b1-a05f-c94632c9bee9	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 17:30:31.853544+00	
00000000-0000-0000-0000-000000000000	3325cfdd-6dd6-4f62-b008-4c791560b576	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-05 17:30:31.877894+00	
00000000-0000-0000-0000-000000000000	5a1beae2-49ab-4587-aa56-73583c5f74e8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 03:47:03.814646+00	
00000000-0000-0000-0000-000000000000	0cbbca15-d6ba-4ff6-b230-f6acc934e3c1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 03:47:03.824555+00	
00000000-0000-0000-0000-000000000000	b817f075-4aaf-4e98-8cf9-2e6f35d2c31d	{"action":"user_repeated_signup","actor_id":"55db67b3-bc35-4671-81f3-a996a5350425","actor_username":"estudiante2@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-09 04:07:01.694416+00	
00000000-0000-0000-0000-000000000000	8ac02f0e-9159-4589-80cb-343e44619526	{"action":"user_repeated_signup","actor_id":"009551f7-f973-4e33-82c5-cc7f2171e07f","actor_username":"estudiante3@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-09 04:07:17.294+00	
00000000-0000-0000-0000-000000000000	c38da245-bad7-41b9-8205-bcda79d94014	{"action":"user_repeated_signup","actor_id":"27226334-0bfb-4d86-9a02-1fe3763995ed","actor_username":"estudiante4@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-09 04:07:27.050932+00	
00000000-0000-0000-0000-000000000000	186d9522-14fc-419a-bbd0-46c7f9128cae	{"action":"user_signedup","actor_id":"e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4","actor_username":"estudiante5@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 04:07:36.172226+00	
00000000-0000-0000-0000-000000000000	804d1734-ceb5-49a5-bfeb-c39494e3e9b2	{"action":"login","actor_id":"e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4","actor_username":"estudiante5@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 04:07:36.184644+00	
00000000-0000-0000-0000-000000000000	3cd14804-b517-4654-8c7f-4f676ec3d920	{"action":"logout","actor_id":"e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4","actor_username":"estudiante5@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 04:08:06.920869+00	
00000000-0000-0000-0000-000000000000	6a77aa68-5e84-4520-9cea-c66ee37cf856	{"action":"login","actor_id":"e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4","actor_username":"estudiante5@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 04:08:17.617191+00	
00000000-0000-0000-0000-000000000000	64d9373c-5809-4abd-aeac-c50391fe986e	{"action":"token_refreshed","actor_id":"e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4","actor_username":"estudiante5@didactikapp.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 05:15:48.506809+00	
00000000-0000-0000-0000-000000000000	ce1a46f3-bb96-4ca1-83a9-e6b0b98a4808	{"action":"token_revoked","actor_id":"e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4","actor_username":"estudiante5@didactikapp.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 05:15:48.528415+00	
00000000-0000-0000-0000-000000000000	b34f6f9d-0d1d-41ce-8396-7dc56206ef5e	{"action":"token_refreshed","actor_id":"e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4","actor_username":"estudiante5@didactikapp.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 13:34:53.29098+00	
00000000-0000-0000-0000-000000000000	4df275a4-ceeb-429a-b6e0-91139a2b0e11	{"action":"token_revoked","actor_id":"e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4","actor_username":"estudiante5@didactikapp.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 13:34:53.306207+00	
00000000-0000-0000-0000-000000000000	a2d59626-8374-4f7e-82b8-77dc1ea38c13	{"action":"logout","actor_id":"e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4","actor_username":"estudiante5@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 13:35:24.925559+00	
00000000-0000-0000-0000-000000000000	9c9db75f-662b-491c-a192-a05fd1d168ed	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 13:35:37.494563+00	
00000000-0000-0000-0000-000000000000	481beb80-eae1-45bb-9478-48c70f677c13	{"action":"user_signedup","actor_id":"e6059964-8108-4ff1-a812-f6eca0cbd3f7","actor_username":"miaalava@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 13:46:49.86508+00	
00000000-0000-0000-0000-000000000000	b640f4af-cd04-431d-b4c6-0f00758ef435	{"action":"login","actor_id":"e6059964-8108-4ff1-a812-f6eca0cbd3f7","actor_username":"miaalava@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 13:46:49.877068+00	
00000000-0000-0000-0000-000000000000	077c7132-f610-4db7-b49f-d1a8f6e742d8	{"action":"user_signedup","actor_id":"0aff3647-bda6-48f4-9e6a-4bf9d1f9e118","actor_username":"donobansarangundi@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 13:48:17.298208+00	
00000000-0000-0000-0000-000000000000	4a1428a0-ae08-4751-92b5-f24f74898b83	{"action":"login","actor_id":"0aff3647-bda6-48f4-9e6a-4bf9d1f9e118","actor_username":"donobansarangundi@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 13:48:17.302552+00	
00000000-0000-0000-0000-000000000000	6f6aa187-4091-4e62-ab4d-e83ce34673b1	{"action":"user_signedup","actor_id":"5d623cd2-7471-4ffc-8341-f55de82f5b7c","actor_username":"renathaarteaga@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 13:50:12.510724+00	
00000000-0000-0000-0000-000000000000	640cc3f9-7f94-4b52-925d-0d32d0457b10	{"action":"login","actor_id":"5d623cd2-7471-4ffc-8341-f55de82f5b7c","actor_username":"renathaarteaga@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 13:50:12.514498+00	
00000000-0000-0000-0000-000000000000	170da56a-502b-4bdf-8717-5ef98fa05d08	{"action":"user_signedup","actor_id":"a6a516f4-345e-4af4-a95d-fcab95a375c4","actor_username":"pedrocampos@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 13:51:32.721802+00	
00000000-0000-0000-0000-000000000000	8ec5acb6-f02b-4c08-88af-243e212194b8	{"action":"login","actor_id":"a6a516f4-345e-4af4-a95d-fcab95a375c4","actor_username":"pedrocampos@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 13:51:32.725771+00	
00000000-0000-0000-0000-000000000000	b667650e-72ec-404a-8f0f-97d80741a644	{"action":"user_signedup","actor_id":"1326d366-a9f6-4216-9395-fb904afcb5eb","actor_username":"josechavez@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 13:54:55.652343+00	
00000000-0000-0000-0000-000000000000	9f04ed56-fe59-4b3f-aad0-6dd82e3a1099	{"action":"login","actor_id":"1326d366-a9f6-4216-9395-fb904afcb5eb","actor_username":"josechavez@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 13:54:55.663571+00	
00000000-0000-0000-0000-000000000000	926efc90-c100-42df-802b-bf5a168dd231	{"action":"logout","actor_id":"1326d366-a9f6-4216-9395-fb904afcb5eb","actor_username":"josechavez@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 13:59:04.499554+00	
00000000-0000-0000-0000-000000000000	8b4f92cc-8cb2-4601-ade4-306573c87403	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 13:59:15.454105+00	
00000000-0000-0000-0000-000000000000	69cb1eb6-29c2-457c-9a39-bd023249a84b	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 13:59:29.393625+00	
00000000-0000-0000-0000-000000000000	ddbabe99-b9f4-44d1-b0d3-c09d97d76c5b	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 14:08:13.556519+00	
00000000-0000-0000-0000-000000000000	9ed633d0-6318-49eb-93aa-e5ee4cbd325b	{"action":"login","actor_id":"1326d366-a9f6-4216-9395-fb904afcb5eb","actor_username":"josechavez@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:08:27.018445+00	
00000000-0000-0000-0000-000000000000	f3559cf6-c549-429c-b602-896d6f708243	{"action":"logout","actor_id":"1326d366-a9f6-4216-9395-fb904afcb5eb","actor_username":"josechavez@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 14:12:24.004029+00	
00000000-0000-0000-0000-000000000000	6820dc4d-6a16-432b-9cf7-566542070e2b	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:12:50.307193+00	
00000000-0000-0000-0000-000000000000	f45d75fc-656e-459d-83ed-098e63f6b30a	{"action":"user_signedup","actor_id":"28f6c2fe-742e-4188-b53d-700ba85aec4c","actor_username":"juandavidcarreno@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 14:36:25.31936+00	
00000000-0000-0000-0000-000000000000	1408b295-f467-44a3-9688-f15a57902c7b	{"action":"login","actor_id":"28f6c2fe-742e-4188-b53d-700ba85aec4c","actor_username":"juandavidcarreno@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:36:25.339323+00	
00000000-0000-0000-0000-000000000000	0fed49b3-91f4-4764-9b19-e25cf10e4e70	{"action":"user_signedup","actor_id":"88bbd661-7479-4a84-b9ef-4f32da93ff26","actor_username":"ainhoachavez@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 14:40:47.143945+00	
00000000-0000-0000-0000-000000000000	1b42be89-e78f-484c-80ab-0ee7edcc6269	{"action":"login","actor_id":"88bbd661-7479-4a84-b9ef-4f32da93ff26","actor_username":"ainhoachavez@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:40:47.155113+00	
00000000-0000-0000-0000-000000000000	5cf58812-d7a6-4a21-817c-734f31c3fc31	{"action":"user_signedup","actor_id":"7b542b46-6fbd-4176-bbbb-5cf594c49da2","actor_username":"luischilan@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 14:45:35.271172+00	
00000000-0000-0000-0000-000000000000	26779a73-bcff-49dc-8cc3-31a660b0e690	{"action":"login","actor_id":"7b542b46-6fbd-4176-bbbb-5cf594c49da2","actor_username":"luischilan@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:45:35.2771+00	
00000000-0000-0000-0000-000000000000	a25818b4-c0f3-4f82-a719-8fefb8835284	{"action":"user_signedup","actor_id":"6c94d34d-5856-4649-8998-7eb1090fdf09","actor_username":"matheochilan@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 14:47:13.852205+00	
00000000-0000-0000-0000-000000000000	cca55956-e5cc-47f9-9a57-b9efe4b7acf2	{"action":"login","actor_id":"6c94d34d-5856-4649-8998-7eb1090fdf09","actor_username":"matheochilan@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:47:13.863883+00	
00000000-0000-0000-0000-000000000000	34ff47fd-559c-41f0-9e29-ed031b39eb98	{"action":"user_signedup","actor_id":"811c750f-97ad-4705-8156-9cdf28b37323","actor_username":"sashachilan@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 14:48:57.130915+00	
00000000-0000-0000-0000-000000000000	3adcfe9d-8825-4daf-a0ce-7163adfdcc56	{"action":"login","actor_id":"811c750f-97ad-4705-8156-9cdf28b37323","actor_username":"sashachilan@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:48:57.135729+00	
00000000-0000-0000-0000-000000000000	6e4a76bf-a926-4f1e-bfdf-a0d8c7414e2f	{"action":"user_signedup","actor_id":"75424ae3-8fbd-4752-8c5c-2bb5e38be82f","actor_username":"guillermofernandez@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 14:50:48.03386+00	
00000000-0000-0000-0000-000000000000	51b69bd7-be6e-41d3-b8dd-df4ed9fab184	{"action":"login","actor_id":"75424ae3-8fbd-4752-8c5c-2bb5e38be82f","actor_username":"guillermofernandez@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:50:48.039233+00	
00000000-0000-0000-0000-000000000000	4db952a0-6e50-4454-9229-72eb5bf44bc2	{"action":"user_signedup","actor_id":"520498cc-f65a-42a2-97b6-22f766b06cfc","actor_username":"ahitannamiley@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 14:53:18.224036+00	
00000000-0000-0000-0000-000000000000	70975a31-77aa-4742-af39-8781bffcf307	{"action":"login","actor_id":"520498cc-f65a-42a2-97b6-22f766b06cfc","actor_username":"ahitannamiley@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:53:18.229519+00	
00000000-0000-0000-0000-000000000000	a81cc585-7bb8-419e-b9ee-aa46c5cdfd9e	{"action":"user_repeated_signup","actor_id":"520498cc-f65a-42a2-97b6-22f766b06cfc","actor_username":"ahitannamiley@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-09 14:54:50.471306+00	
00000000-0000-0000-0000-000000000000	99363fc0-7a77-4bed-b877-b33cb1aac56f	{"action":"user_repeated_signup","actor_id":"520498cc-f65a-42a2-97b6-22f766b06cfc","actor_username":"ahitannamiley@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-09 14:56:36.809517+00	
00000000-0000-0000-0000-000000000000	0a5599c8-67c3-48c0-af5e-d0b0d190c4bf	{"action":"user_signedup","actor_id":"ba0d8cac-1ab0-4319-86cd-6e9840a12111","actor_username":"ahitannamileylaz@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 14:56:44.607875+00	
00000000-0000-0000-0000-000000000000	b6b52a7f-6f50-4567-8d44-eba255ac00f0	{"action":"login","actor_id":"ba0d8cac-1ab0-4319-86cd-6e9840a12111","actor_username":"ahitannamileylaz@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:56:44.613902+00	
00000000-0000-0000-0000-000000000000	69847f1f-bffd-47ca-9843-c2de0d24afcf	{"action":"user_signedup","actor_id":"d39fd319-3593-4ddc-840a-5a89f73a3d75","actor_username":"sophiemala@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 14:58:09.194009+00	
00000000-0000-0000-0000-000000000000	0a707ac0-076f-4bdb-8dc8-65677e587737	{"action":"login","actor_id":"d39fd319-3593-4ddc-840a-5a89f73a3d75","actor_username":"sophiemala@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 14:58:09.198503+00	
00000000-0000-0000-0000-000000000000	ab9cb7ac-30d2-4fbc-a892-b2c5d30f9193	{"action":"user_signedup","actor_id":"2e05a86b-6966-4266-a17a-cedc2aad1567","actor_username":"jimmymedranda@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 15:00:31.430915+00	
00000000-0000-0000-0000-000000000000	d7536e10-8a05-492b-9949-2064199b8acb	{"action":"login","actor_id":"2e05a86b-6966-4266-a17a-cedc2aad1567","actor_username":"jimmymedranda@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:00:31.434785+00	
00000000-0000-0000-0000-000000000000	91930ff2-257d-45ea-a15e-2e3a7f31e6be	{"action":"user_signedup","actor_id":"a12584c4-19a5-4716-83d9-e0bb42fbf002","actor_username":"tiagomendoza@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 15:02:13.331191+00	
00000000-0000-0000-0000-000000000000	a03dc72a-6fb2-4c01-bd43-91ff5b182b5f	{"action":"login","actor_id":"a12584c4-19a5-4716-83d9-e0bb42fbf002","actor_username":"tiagomendoza@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:02:13.334686+00	
00000000-0000-0000-0000-000000000000	42f1a1cb-e4ac-4135-bd4f-0addbe53d9bd	{"action":"user_signedup","actor_id":"e180edb5-9a66-4602-9e4a-17a4c9c70d92","actor_username":"gaelmiranda@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 15:04:53.472881+00	
00000000-0000-0000-0000-000000000000	1760b5b9-b7c1-4579-9cd3-c8271c81b73f	{"action":"login","actor_id":"e180edb5-9a66-4602-9e4a-17a4c9c70d92","actor_username":"gaelmiranda@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:04:53.487174+00	
00000000-0000-0000-0000-000000000000	15d545fb-cfc5-4cfc-8158-e16ce99cb491	{"action":"user_signedup","actor_id":"d81fa5d0-b828-47be-bf4f-d04e151c937f","actor_username":"ailenmolina@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 15:07:00.88121+00	
00000000-0000-0000-0000-000000000000	dc2fa36b-b587-4e34-bc00-2802252b5836	{"action":"login","actor_id":"d81fa5d0-b828-47be-bf4f-d04e151c937f","actor_username":"ailenmolina@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:07:00.885916+00	
00000000-0000-0000-0000-000000000000	965b67aa-3e19-47e7-a067-34224e00a1da	{"action":"user_signedup","actor_id":"f681ddbe-c67f-44f1-9969-31b64b4c879a","actor_username":"keylamolina@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 15:07:53.546599+00	
00000000-0000-0000-0000-000000000000	4104b8c7-4ed7-40c4-a105-5f0fefc0bfdf	{"action":"login","actor_id":"f681ddbe-c67f-44f1-9969-31b64b4c879a","actor_username":"keylamolina@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:07:53.549953+00	
00000000-0000-0000-0000-000000000000	28f6cdfe-c181-4491-ae5c-af5b64bfb8e0	{"action":"user_signedup","actor_id":"00aff592-6206-428c-9476-2ca0e5c985bf","actor_username":"marielmolina@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 15:08:45.913708+00	
00000000-0000-0000-0000-000000000000	4e447929-88b5-4287-9e3a-f9564d421b37	{"action":"login","actor_id":"00aff592-6206-428c-9476-2ca0e5c985bf","actor_username":"marielmolina@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:08:45.920586+00	
00000000-0000-0000-0000-000000000000	fe291ea1-9cac-47c2-9899-56bb7683a8ba	{"action":"user_signedup","actor_id":"f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e","actor_username":"damarispalacios@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 15:12:41.576394+00	
00000000-0000-0000-0000-000000000000	f552c0bb-967a-4a2d-ad47-bd32534fb12d	{"action":"login","actor_id":"f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e","actor_username":"damarispalacios@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:12:41.580565+00	
00000000-0000-0000-0000-000000000000	513e46f0-d9a9-4ccb-8956-350e6975fdec	{"action":"user_signedup","actor_id":"2244697e-3126-4d57-af2d-ab28686fc83d","actor_username":"yuliethrivas@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 15:16:15.437247+00	
00000000-0000-0000-0000-000000000000	c9bb3db3-6bc3-4b87-a29f-a469fe7e8736	{"action":"login","actor_id":"2244697e-3126-4d57-af2d-ab28686fc83d","actor_username":"yuliethrivas@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:16:15.444921+00	
00000000-0000-0000-0000-000000000000	9b6e1670-15cb-42a5-b463-5a7e50b917b9	{"action":"logout","actor_id":"2244697e-3126-4d57-af2d-ab28686fc83d","actor_username":"yuliethrivas@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:16:28.936721+00	
00000000-0000-0000-0000-000000000000	f8babd21-c3a9-4496-a772-b4c63df2eec0	{"action":"login","actor_id":"2244697e-3126-4d57-af2d-ab28686fc83d","actor_username":"yuliethrivas@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:16:38.164098+00	
00000000-0000-0000-0000-000000000000	8cba28c7-5575-4bd0-a711-faac81232a9e	{"action":"logout","actor_id":"2244697e-3126-4d57-af2d-ab28686fc83d","actor_username":"yuliethrivas@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:18:51.318508+00	
00000000-0000-0000-0000-000000000000	f761e052-eef1-4aad-a9c0-5b2d7edfc4a6	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:19:05.216681+00	
00000000-0000-0000-0000-000000000000	fa9da3db-8e8b-42de-8121-0bbd51d422c9	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:19:30.007084+00	
00000000-0000-0000-0000-000000000000	f25c02d8-7102-4a02-9c34-b2fd5c93834d	{"action":"login","actor_id":"e6059964-8108-4ff1-a812-f6eca0cbd3f7","actor_username":"miaalava@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:19:40.841229+00	
00000000-0000-0000-0000-000000000000	9292fd8b-7cce-4c58-94bf-180d6889c3e1	{"action":"logout","actor_id":"e6059964-8108-4ff1-a812-f6eca0cbd3f7","actor_username":"miaalava@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:20:46.732693+00	
00000000-0000-0000-0000-000000000000	67730a86-0007-41af-81a1-2a3c49d3e87f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:20:56.464422+00	
00000000-0000-0000-0000-000000000000	e3be3ad8-d52c-4fae-8b89-676ce4cf69a2	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:21:19.320074+00	
00000000-0000-0000-0000-000000000000	696c7a9d-10fa-490b-b146-41e803e94348	{"action":"login","actor_id":"0aff3647-bda6-48f4-9e6a-4bf9d1f9e118","actor_username":"donobansarangundi@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:21:27.76289+00	
00000000-0000-0000-0000-000000000000	4dfd80e6-c7e4-4ca6-9393-fd3f11366a09	{"action":"logout","actor_id":"0aff3647-bda6-48f4-9e6a-4bf9d1f9e118","actor_username":"donobansarangundi@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:24:01.504349+00	
00000000-0000-0000-0000-000000000000	89337bbb-5a8c-43db-ade9-42f7fc7c2c95	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:24:10.904117+00	
00000000-0000-0000-0000-000000000000	43e88deb-5ae2-43f3-87fc-e6c62e480e2f	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:24:45.207593+00	
00000000-0000-0000-0000-000000000000	f72fbf97-54df-49d0-b25a-ef0735735563	{"action":"login","actor_id":"ba0d8cac-1ab0-4319-86cd-6e9840a12111","actor_username":"ahitannamileylaz@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:24:55.908475+00	
00000000-0000-0000-0000-000000000000	8f863e53-4d3b-43ea-9132-994a5640c3be	{"action":"logout","actor_id":"ba0d8cac-1ab0-4319-86cd-6e9840a12111","actor_username":"ahitannamileylaz@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:26:01.545971+00	
00000000-0000-0000-0000-000000000000	9d436e77-ea2e-4fc3-911a-190bc3667486	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:26:11.918184+00	
00000000-0000-0000-0000-000000000000	0dbb42b9-6de3-4f4c-9c3d-a7e4ab0cf132	{"action":"user_signedup","actor_id":"11133b74-e96b-46b7-9c9c-585824841fe6","actor_username":"dayrapalma@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 15:27:55.154684+00	
00000000-0000-0000-0000-000000000000	e2e18592-09d6-409f-8aff-736c1d840f1e	{"action":"login","actor_id":"11133b74-e96b-46b7-9c9c-585824841fe6","actor_username":"dayrapalma@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:27:55.165702+00	
00000000-0000-0000-0000-000000000000	906f90a3-880a-4d12-9dc1-2f715f86b458	{"action":"logout","actor_id":"11133b74-e96b-46b7-9c9c-585824841fe6","actor_username":"dayrapalma@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:28:05.773087+00	
00000000-0000-0000-0000-000000000000	4710e989-d5f6-419b-8cf5-70d5930c1206	{"action":"login","actor_id":"11133b74-e96b-46b7-9c9c-585824841fe6","actor_username":"dayrapalma@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:28:12.993377+00	
00000000-0000-0000-0000-000000000000	3c0b1b77-f8b7-4e81-9f38-a93e5b990a79	{"action":"logout","actor_id":"11133b74-e96b-46b7-9c9c-585824841fe6","actor_username":"dayrapalma@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-09 15:29:40.305435+00	
00000000-0000-0000-0000-000000000000	efff1dab-4297-4675-9e74-0641b10609f9	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 15:29:50.799316+00	
00000000-0000-0000-0000-000000000000	c540509d-fe96-4afa-8f3c-47b8e7093df0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-10 15:02:11.600049+00	
00000000-0000-0000-0000-000000000000	2ee4f5ea-28cf-43f3-9e00-7b6288c5d9d9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-10 15:02:11.626687+00	
00000000-0000-0000-0000-000000000000	5828b8d1-7e33-4670-bd6b-7109954d747b	{"action":"user_signedup","actor_id":"9247ea7b-2d1d-45b3-b037-6ec04945be81","actor_username":"arisleyalava@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:17:41.275849+00	
00000000-0000-0000-0000-000000000000	ce80cd43-3978-44fc-b685-b654a5c16f59	{"action":"login","actor_id":"9247ea7b-2d1d-45b3-b037-6ec04945be81","actor_username":"arisleyalava@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:17:41.292928+00	
00000000-0000-0000-0000-000000000000	62b2fe41-be69-446d-bd82-2fe44b3a0ca3	{"action":"user_signedup","actor_id":"07698bac-d8fb-4e65-982d-27c4d482f909","actor_username":"yasbethbarrezueta@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:19:35.847717+00	
00000000-0000-0000-0000-000000000000	f9f1c95e-fa71-4d70-a9e0-35292d09351a	{"action":"login","actor_id":"07698bac-d8fb-4e65-982d-27c4d482f909","actor_username":"yasbethbarrezueta@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:19:35.853567+00	
00000000-0000-0000-0000-000000000000	65744910-dab4-4a73-91b7-8f4b808859a3	{"action":"user_signedup","actor_id":"b60a73bd-7f4b-4062-8407-62cefee3b0d0","actor_username":"juantuala@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:20:39.552356+00	
00000000-0000-0000-0000-000000000000	6a484d52-0aa4-4202-93d4-3bb5fd0d60ff	{"action":"login","actor_id":"b60a73bd-7f4b-4062-8407-62cefee3b0d0","actor_username":"juantuala@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:20:39.556531+00	
00000000-0000-0000-0000-000000000000	5ded9389-b9d5-4f63-9a8c-4fc8d4323fc0	{"action":"user_signedup","actor_id":"9b07c741-12ea-4816-83ff-6eec722cd7da","actor_username":"roselinecedeno@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:22:17.306122+00	
00000000-0000-0000-0000-000000000000	905b0043-7483-4987-8288-b720657feab4	{"action":"login","actor_id":"9b07c741-12ea-4816-83ff-6eec722cd7da","actor_username":"roselinecedeno@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:22:17.312617+00	
00000000-0000-0000-0000-000000000000	ee0e7989-dc4b-4273-a440-cbb618160eb7	{"action":"user_signedup","actor_id":"8faf560f-ba50-4fc1-b96c-384072c80c90","actor_username":"josedelgado@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:23:20.870303+00	
00000000-0000-0000-0000-000000000000	4eacbd03-f42a-418a-8e9e-f81b558f505a	{"action":"login","actor_id":"8faf560f-ba50-4fc1-b96c-384072c80c90","actor_username":"josedelgado@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:23:20.879215+00	
00000000-0000-0000-0000-000000000000	5370d268-9bf9-454a-902f-813a33718b6a	{"action":"user_signedup","actor_id":"18a33406-19e8-4e01-a292-bf1cd1af8c65","actor_username":"edisongarcia@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:24:03.507716+00	
00000000-0000-0000-0000-000000000000	841b393a-7555-4432-8a70-c3de825d0eca	{"action":"login","actor_id":"18a33406-19e8-4e01-a292-bf1cd1af8c65","actor_username":"edisongarcia@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:24:03.516972+00	
00000000-0000-0000-0000-000000000000	0051be03-5979-4d72-b3e1-25c8be7b3396	{"action":"user_signedup","actor_id":"771ad79b-34ce-4812-9d05-3914d9ada480","actor_username":"maytehormaza@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:25:15.769028+00	
00000000-0000-0000-0000-000000000000	9228cc65-6765-4834-bb05-e95502e64f4e	{"action":"login","actor_id":"771ad79b-34ce-4812-9d05-3914d9ada480","actor_username":"maytehormaza@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:25:15.774808+00	
00000000-0000-0000-0000-000000000000	ee3b6c9d-b7f0-4eba-940f-518d2e577885	{"action":"user_signedup","actor_id":"23830ef8-baf0-4b79-bae5-b8c2cfda4931","actor_username":"dekerlaz@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:26:28.122863+00	
00000000-0000-0000-0000-000000000000	19ad88a3-e092-4dfc-a43e-8963ebf615ae	{"action":"login","actor_id":"23830ef8-baf0-4b79-bae5-b8c2cfda4931","actor_username":"dekerlaz@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:26:28.126713+00	
00000000-0000-0000-0000-000000000000	0a61a53e-85ce-44fa-b7ba-bb54b67609d1	{"action":"user_signedup","actor_id":"7524e67f-698f-40b6-8424-26f05bac35e1","actor_username":"samaramarin@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:27:16.056507+00	
00000000-0000-0000-0000-000000000000	46e846a2-dac8-46e5-b8e1-42453aeebe06	{"action":"login","actor_id":"7524e67f-698f-40b6-8424-26f05bac35e1","actor_username":"samaramarin@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:27:16.060308+00	
00000000-0000-0000-0000-000000000000	515f2cdc-e5e9-4f78-badf-c4af94274912	{"action":"user_signedup","actor_id":"02d3430e-9601-4b3b-a6d6-e9390872b54b","actor_username":"jostinmolina@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:28:14.397606+00	
00000000-0000-0000-0000-000000000000	f790ee98-6afb-47c6-9b27-08e75ad704da	{"action":"login","actor_id":"02d3430e-9601-4b3b-a6d6-e9390872b54b","actor_username":"jostinmolina@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:28:14.400809+00	
00000000-0000-0000-0000-000000000000	1b64a72d-8744-42fc-9995-85e4f531ddfd	{"action":"user_signedup","actor_id":"f5def64f-2c9e-4165-9302-4c4870991dad","actor_username":"mariamoreira@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:29:01.45452+00	
00000000-0000-0000-0000-000000000000	5a897d13-74a1-488e-9abb-3729b065d520	{"action":"login","actor_id":"f5def64f-2c9e-4165-9302-4c4870991dad","actor_username":"mariamoreira@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:29:01.457571+00	
00000000-0000-0000-0000-000000000000	e6d7b157-b281-42a9-a219-79ed3cfbbb1b	{"action":"user_signedup","actor_id":"9b79fcf6-f192-4364-80ec-ab95b18c87e3","actor_username":"ashleymurillo@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:29:58.854634+00	
00000000-0000-0000-0000-000000000000	42f3a4c2-e3d9-49a9-8abc-0770bc5ac9e7	{"action":"login","actor_id":"9b79fcf6-f192-4364-80ec-ab95b18c87e3","actor_username":"ashleymurillo@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:29:58.857814+00	
00000000-0000-0000-0000-000000000000	b1604e8e-24ff-4de8-8063-eed2debd8658	{"action":"user_signedup","actor_id":"4ba36fc8-7010-4374-96b4-51d95257be5a","actor_username":"moisespalma@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:30:40.116855+00	
00000000-0000-0000-0000-000000000000	ec5d78ba-fb02-4dd5-bbe8-eb6f32e0d6a9	{"action":"login","actor_id":"4ba36fc8-7010-4374-96b4-51d95257be5a","actor_username":"moisespalma@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:30:40.123202+00	
00000000-0000-0000-0000-000000000000	6188aa8f-937d-4440-af0b-33b336b42257	{"action":"user_signedup","actor_id":"7bab67c8-74d3-4a9e-a2b1-990223186d4e","actor_username":"miapalma@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:31:18.336756+00	
00000000-0000-0000-0000-000000000000	0c059ce2-fc7a-4be9-ba61-1e20b8a63b57	{"action":"login","actor_id":"7bab67c8-74d3-4a9e-a2b1-990223186d4e","actor_username":"miapalma@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:31:18.340674+00	
00000000-0000-0000-0000-000000000000	d54a02e4-a380-4241-90ce-99096ccf5de5	{"action":"user_signedup","actor_id":"1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7","actor_username":"enzopalmas@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:32:18.87327+00	
00000000-0000-0000-0000-000000000000	f1a29f50-219e-4717-8e89-5cccfdc0ff27	{"action":"login","actor_id":"1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7","actor_username":"enzopalmas@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:32:18.880134+00	
00000000-0000-0000-0000-000000000000	9f75605f-988d-41f4-b9d8-30021935efbc	{"action":"user_signedup","actor_id":"47739d07-5148-4e33-9aee-d236406d760e","actor_username":"raulpalma@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:32:55.885535+00	
00000000-0000-0000-0000-000000000000	411756dc-ecf6-4268-9825-31b801262547	{"action":"login","actor_id":"47739d07-5148-4e33-9aee-d236406d760e","actor_username":"raulpalma@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:32:55.88962+00	
00000000-0000-0000-0000-000000000000	0446f9d5-0d7c-4dda-9950-87e360ea91ff	{"action":"user_signedup","actor_id":"d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03","actor_username":"ninoskapin@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:34:02.268268+00	
00000000-0000-0000-0000-000000000000	4c10a0a7-f299-4163-a2c4-b178ccaa3449	{"action":"login","actor_id":"d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03","actor_username":"ninoskapin@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:34:02.273521+00	
00000000-0000-0000-0000-000000000000	cc460ff1-f3de-4395-b5f0-7fcee8845f81	{"action":"user_signedup","actor_id":"40e4b506-1d73-4298-8d8b-2011f8e24bef","actor_username":"dereckpinargote@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:34:51.326142+00	
00000000-0000-0000-0000-000000000000	f2a73906-e261-4cc8-9354-6c969c14859a	{"action":"login","actor_id":"40e4b506-1d73-4298-8d8b-2011f8e24bef","actor_username":"dereckpinargote@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:34:51.329526+00	
00000000-0000-0000-0000-000000000000	6735ab62-c6af-4dde-9f75-cd313725511b	{"action":"user_signedup","actor_id":"8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8","actor_username":"domenicaponce@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:35:47.047459+00	
00000000-0000-0000-0000-000000000000	dfea6199-9dc4-4fa5-9dbb-937ffe976c62	{"action":"login","actor_id":"8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8","actor_username":"domenicaponce@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:35:47.051348+00	
00000000-0000-0000-0000-000000000000	013cf884-b8aa-4547-83ba-77385214fd9b	{"action":"user_signedup","actor_id":"83bb0944-5672-4759-b72b-37deea537a47","actor_username":"joseposligua@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:36:26.889839+00	
00000000-0000-0000-0000-000000000000	bb5f7853-bbe4-498b-96f2-7ab374f32e85	{"action":"login","actor_id":"83bb0944-5672-4759-b72b-37deea537a47","actor_username":"joseposligua@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:36:26.893056+00	
00000000-0000-0000-0000-000000000000	5d80e44a-e624-4d3a-920c-84a3cbfb67fe	{"action":"user_signedup","actor_id":"5dc9910f-4d2e-4fae-8907-0fe3b596cde0","actor_username":"gregorioposligua@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:37:15.552254+00	
00000000-0000-0000-0000-000000000000	0f0fc05a-5287-49d1-b87b-ee8a8ef33a30	{"action":"login","actor_id":"5dc9910f-4d2e-4fae-8907-0fe3b596cde0","actor_username":"gregorioposligua@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:37:15.555876+00	
00000000-0000-0000-0000-000000000000	5211f9e5-4139-4734-b9eb-a7997a628ba6	{"action":"user_signedup","actor_id":"937926f9-3c6b-46d2-9cf3-341479442747","actor_username":"carlosreyes@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:38:11.877214+00	
00000000-0000-0000-0000-000000000000	5069aa58-88fb-4de0-852a-88e87f9987d2	{"action":"login","actor_id":"937926f9-3c6b-46d2-9cf3-341479442747","actor_username":"carlosreyes@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:38:11.880832+00	
00000000-0000-0000-0000-000000000000	ed5e55ce-d754-40f1-a492-5e465dce32a6	{"action":"user_signedup","actor_id":"27356752-78d4-4833-bdbc-ac5ceb23883e","actor_username":"emmarivas@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:40:40.920235+00	
00000000-0000-0000-0000-000000000000	cca4ced6-8e5e-46ad-b977-4e752ff7f055	{"action":"login","actor_id":"27356752-78d4-4833-bdbc-ac5ceb23883e","actor_username":"emmarivas@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:40:40.925734+00	
00000000-0000-0000-0000-000000000000	a47f4317-7c5b-48a8-b90d-5f95b657ddcd	{"action":"user_signedup","actor_id":"d656273e-e4fe-448d-9aa1-7e87839688d6","actor_username":"jusneyrivas@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:41:30.222726+00	
00000000-0000-0000-0000-000000000000	8d8158d3-7868-413b-bdfa-b7ba15eb10d8	{"action":"login","actor_id":"d656273e-e4fe-448d-9aa1-7e87839688d6","actor_username":"jusneyrivas@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:41:30.241209+00	
00000000-0000-0000-0000-000000000000	a35d0faf-3b64-48a3-a20b-06dba17e0600	{"action":"user_signedup","actor_id":"a883d161-ec1f-497b-91c6-16543a922792","actor_username":"lizsanchez@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:42:12.692584+00	
00000000-0000-0000-0000-000000000000	e9382a4e-174b-4fc8-b6fe-84ce591ce170	{"action":"login","actor_id":"a883d161-ec1f-497b-91c6-16543a922792","actor_username":"lizsanchez@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:42:12.698007+00	
00000000-0000-0000-0000-000000000000	c54cc014-6f47-49ff-ab48-9d4d68de98ef	{"action":"user_signedup","actor_id":"ac8e6da9-87c7-49a5-8791-31208c8005f2","actor_username":"breynertejena@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:43:14.845357+00	
00000000-0000-0000-0000-000000000000	9198e0a6-f620-4c5b-9827-c46ef4fea6d8	{"action":"login","actor_id":"ac8e6da9-87c7-49a5-8791-31208c8005f2","actor_username":"breynertejena@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:43:14.850281+00	
00000000-0000-0000-0000-000000000000	59e39614-9792-4410-b0b5-bc11adaeb995	{"action":"user_signedup","actor_id":"ed3fc59a-eab6-4126-9062-d79a3153f5da","actor_username":"samirtejena@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:43:51.492993+00	
00000000-0000-0000-0000-000000000000	e3b619eb-4f54-410d-a6b5-ca546bad8b71	{"action":"login","actor_id":"ed3fc59a-eab6-4126-9062-d79a3153f5da","actor_username":"samirtejena@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:43:51.496426+00	
00000000-0000-0000-0000-000000000000	8354fe04-fbd0-4bd8-a2db-7aac40cf7675	{"action":"user_signedup","actor_id":"085e1141-b596-4dd7-8bbc-cccb55bf46fa","actor_username":"carlostejena@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:45:14.513577+00	
00000000-0000-0000-0000-000000000000	d7a2280e-8de9-422f-891a-dab95f852bef	{"action":"login","actor_id":"085e1141-b596-4dd7-8bbc-cccb55bf46fa","actor_username":"carlostejena@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:45:14.51824+00	
00000000-0000-0000-0000-000000000000	f8c3dddf-6154-4bbd-860c-d04bcb75eedf	{"action":"user_signedup","actor_id":"242a6366-d3f0-4a5a-ba81-0db7aed6ac63","actor_username":"breylivelez@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:46:03.43488+00	
00000000-0000-0000-0000-000000000000	f6d19b64-f5a7-4deb-aa87-022164349ffd	{"action":"login","actor_id":"242a6366-d3f0-4a5a-ba81-0db7aed6ac63","actor_username":"breylivelez@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:46:03.441985+00	
00000000-0000-0000-0000-000000000000	cb9c3b36-a375-4d0d-87cd-b0b5a9006066	{"action":"user_signedup","actor_id":"f1ff761b-109b-46ac-8ffd-991130b7cfe7","actor_username":"brihanatorres@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:47:33.707109+00	
00000000-0000-0000-0000-000000000000	8462fc22-c141-4722-b375-87370050de74	{"action":"login","actor_id":"f1ff761b-109b-46ac-8ffd-991130b7cfe7","actor_username":"brihanatorres@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:47:33.711441+00	
00000000-0000-0000-0000-000000000000	6891ca23-f0e5-43da-b977-012b03c840cf	{"action":"user_signedup","actor_id":"ca71cb86-8002-48da-8292-cbd21b04c618","actor_username":"ikerzambrano@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:48:13.38939+00	
00000000-0000-0000-0000-000000000000	fb610025-3fe1-4b15-ab89-2c83788d7855	{"action":"login","actor_id":"ca71cb86-8002-48da-8292-cbd21b04c618","actor_username":"ikerzambrano@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:48:13.392901+00	
00000000-0000-0000-0000-000000000000	928062fe-b3b4-471e-897b-40581ae36692	{"action":"user_signedup","actor_id":"ba9207cf-7064-435f-8ab0-0ac8a9679084","actor_username":"sherylzambrabo@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 15:49:00.835316+00	
00000000-0000-0000-0000-000000000000	894308df-9a72-43e8-acaf-b85ea6d8eed1	{"action":"login","actor_id":"ba9207cf-7064-435f-8ab0-0ac8a9679084","actor_username":"sherylzambrabo@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:49:00.838713+00	
00000000-0000-0000-0000-000000000000	1f36d135-872b-4bdc-88ed-c258a7ea8982	{"action":"logout","actor_id":"ba9207cf-7064-435f-8ab0-0ac8a9679084","actor_username":"sherylzambrabo@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 15:54:29.037435+00	
00000000-0000-0000-0000-000000000000	87340b23-b018-462b-b990-3d4a02a01ecf	{"action":"login","actor_id":"8faf560f-ba50-4fc1-b96c-384072c80c90","actor_username":"josedelgado@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:54:40.294626+00	
00000000-0000-0000-0000-000000000000	b80f2f1c-6f01-40b5-8a67-6f9ee703f162	{"action":"logout","actor_id":"8faf560f-ba50-4fc1-b96c-384072c80c90","actor_username":"josedelgado@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 15:57:39.187947+00	
00000000-0000-0000-0000-000000000000	2f24af55-618d-45d7-a5cd-dc56f042e2f1	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 15:57:47.430715+00	
00000000-0000-0000-0000-000000000000	f43e6cfd-6d62-42c1-bf1f-cd24a94fdd74	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 15:59:53.781873+00	
00000000-0000-0000-0000-000000000000	224ea991-f604-4007-b7be-485160fa5593	{"action":"login","actor_id":"23830ef8-baf0-4b79-bae5-b8c2cfda4931","actor_username":"dekerlaz@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:00:02.53948+00	
00000000-0000-0000-0000-000000000000	6edd5126-4f73-4875-9ace-5dbd04ef26c9	{"action":"logout","actor_id":"23830ef8-baf0-4b79-bae5-b8c2cfda4931","actor_username":"dekerlaz@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:01:30.415772+00	
00000000-0000-0000-0000-000000000000	46a8e15b-06a6-4ef8-9f60-413ceae475af	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:01:49.378761+00	
00000000-0000-0000-0000-000000000000	41649908-f2f2-4608-8bfa-1d66c7b2af25	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:02:11.5204+00	
00000000-0000-0000-0000-000000000000	cbc3153e-a984-4d60-b99c-0de86f8e4707	{"action":"login","actor_id":"d656273e-e4fe-448d-9aa1-7e87839688d6","actor_username":"jusneyrivas@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:02:21.016723+00	
00000000-0000-0000-0000-000000000000	12105959-236f-4bd4-bf58-a83eda2fb6a8	{"action":"logout","actor_id":"d656273e-e4fe-448d-9aa1-7e87839688d6","actor_username":"jusneyrivas@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:03:38.158925+00	
00000000-0000-0000-0000-000000000000	f62145d5-2364-42ce-bb54-f677f143c312	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:03:49.33678+00	
00000000-0000-0000-0000-000000000000	fe315e2e-69e1-4bde-84dc-6268393c17d7	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:04:43.272968+00	
00000000-0000-0000-0000-000000000000	0b6742ee-b58a-4f02-9fd5-826e8828f3ee	{"action":"login","actor_id":"07698bac-d8fb-4e65-982d-27c4d482f909","actor_username":"yasbethbarrezueta@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:04:53.81693+00	
00000000-0000-0000-0000-000000000000	deae299b-3852-4095-9ea8-0b171fe0d197	{"action":"logout","actor_id":"07698bac-d8fb-4e65-982d-27c4d482f909","actor_username":"yasbethbarrezueta@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:06:01.675339+00	
00000000-0000-0000-0000-000000000000	a9595bf7-d0c6-4b9e-9d6d-036816956303	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:06:19.430915+00	
00000000-0000-0000-0000-000000000000	dcde827e-1d9f-419c-ad1b-8f13ed3f5f1d	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:08:05.192232+00	
00000000-0000-0000-0000-000000000000	594f23fa-94e4-4c06-b226-61a12c5b3baa	{"action":"login","actor_id":"085e1141-b596-4dd7-8bbc-cccb55bf46fa","actor_username":"carlostejena@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:08:16.118003+00	
00000000-0000-0000-0000-000000000000	c8c16c53-1532-43c1-b41f-3f14d5c10bf8	{"action":"logout","actor_id":"085e1141-b596-4dd7-8bbc-cccb55bf46fa","actor_username":"carlostejena@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:09:57.618856+00	
00000000-0000-0000-0000-000000000000	8d3339fd-7ef1-42eb-929c-e512dba13d40	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:10:06.815396+00	
00000000-0000-0000-0000-000000000000	6da9e5a9-fdd1-4e31-add7-55bbc49d5dc8	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:10:28.800348+00	
00000000-0000-0000-0000-000000000000	05386e70-f59a-4e30-a30c-a44898bb14ee	{"action":"login","actor_id":"ed3fc59a-eab6-4126-9062-d79a3153f5da","actor_username":"samirtejena@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:10:37.535722+00	
00000000-0000-0000-0000-000000000000	d93944ec-831d-4203-8287-6b61ee759a34	{"action":"logout","actor_id":"ed3fc59a-eab6-4126-9062-d79a3153f5da","actor_username":"samirtejena@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:13:08.058186+00	
00000000-0000-0000-0000-000000000000	ea671697-8044-43fd-bda9-b608b18d3cf7	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:13:20.023991+00	
00000000-0000-0000-0000-000000000000	b9f6cf42-f107-4f78-8cee-f387babbec2a	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:13:50.701576+00	
00000000-0000-0000-0000-000000000000	3e02a9a4-aa5e-4e1f-9cfc-6e147ee59d67	{"action":"login","actor_id":"4ba36fc8-7010-4374-96b4-51d95257be5a","actor_username":"moisespalma@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:13:59.73674+00	
00000000-0000-0000-0000-000000000000	7237eda6-13e9-4400-81c1-eeef9912084d	{"action":"logout","actor_id":"4ba36fc8-7010-4374-96b4-51d95257be5a","actor_username":"moisespalma@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:15:46.75215+00	
00000000-0000-0000-0000-000000000000	a1e18716-7287-4804-81ee-7de5a431d522	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:15:59.561637+00	
00000000-0000-0000-0000-000000000000	76a785f7-1ebe-4878-a089-4d5a05fbeac6	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:17:35.48921+00	
00000000-0000-0000-0000-000000000000	a152b746-828c-4c28-8d05-15ea883c70a7	{"action":"login","actor_id":"f1ff761b-109b-46ac-8ffd-991130b7cfe7","actor_username":"brihanatorres@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:17:45.800963+00	
00000000-0000-0000-0000-000000000000	4e534611-51b7-479c-900b-8926ffd34ad4	{"action":"logout","actor_id":"f1ff761b-109b-46ac-8ffd-991130b7cfe7","actor_username":"brihanatorres@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:20:24.924729+00	
00000000-0000-0000-0000-000000000000	edaa3674-cf20-4620-8ee9-4939700524d7	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:20:38.643323+00	
00000000-0000-0000-0000-000000000000	4c48e924-9f2a-4ea7-8468-9198a8a8f974	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:21:17.790489+00	
00000000-0000-0000-0000-000000000000	163d0626-9d5c-4633-a600-bc097090140e	{"action":"login","actor_id":"9b07c741-12ea-4816-83ff-6eec722cd7da","actor_username":"roselinecedeno@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:21:26.626631+00	
00000000-0000-0000-0000-000000000000	443293d6-c076-458a-baab-dc437ffc89bd	{"action":"logout","actor_id":"9b07c741-12ea-4816-83ff-6eec722cd7da","actor_username":"roselinecedeno@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:23:11.825595+00	
00000000-0000-0000-0000-000000000000	199def0f-1fac-4930-a52b-5191c7b7fe9c	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:23:26.880737+00	
00000000-0000-0000-0000-000000000000	bb90381a-d526-42be-9af2-20e8793ed62e	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:24:03.724842+00	
00000000-0000-0000-0000-000000000000	65891e9e-7df7-40a6-924d-dce0eaf45461	{"action":"login","actor_id":"b60a73bd-7f4b-4062-8407-62cefee3b0d0","actor_username":"juantuala@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:24:14.619018+00	
00000000-0000-0000-0000-000000000000	6d6f18e2-ca41-47b4-ab14-5e4ef9b331f5	{"action":"logout","actor_id":"b60a73bd-7f4b-4062-8407-62cefee3b0d0","actor_username":"juantuala@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:25:29.901993+00	
00000000-0000-0000-0000-000000000000	bdde9918-0136-4a9c-83ec-8714b940865d	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:25:42.405706+00	
00000000-0000-0000-0000-000000000000	7a132a39-de97-48b2-ba4c-51c3f0bc82a2	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:26:35.93429+00	
00000000-0000-0000-0000-000000000000	cf056c20-7888-45bc-88e4-b7d7553a7dcb	{"action":"login","actor_id":"07698bac-d8fb-4e65-982d-27c4d482f909","actor_username":"yasbethbarrezueta@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:26:46.60481+00	
00000000-0000-0000-0000-000000000000	ae1a6e4b-701a-467f-a7f7-cad6817f71ee	{"action":"logout","actor_id":"07698bac-d8fb-4e65-982d-27c4d482f909","actor_username":"yasbethbarrezueta@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:27:54.542078+00	
00000000-0000-0000-0000-000000000000	91289588-3bae-4ee8-9cf1-31b2658f76c0	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:28:12.945049+00	
00000000-0000-0000-0000-000000000000	e4793569-18cf-41bd-bc9f-ae34e1711a99	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:28:35.032056+00	
00000000-0000-0000-0000-000000000000	b87563c8-3730-4bb8-b3da-794223fc1065	{"action":"login","actor_id":"ac8e6da9-87c7-49a5-8791-31208c8005f2","actor_username":"breynertejena@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:28:43.713194+00	
00000000-0000-0000-0000-000000000000	6958325d-7172-4aaf-91e3-40e87cca3272	{"action":"logout","actor_id":"ac8e6da9-87c7-49a5-8791-31208c8005f2","actor_username":"breynertejena@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:30:55.397822+00	
00000000-0000-0000-0000-000000000000	1b41186e-913a-468a-ba27-8b9d5921a3d7	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:31:05.391818+00	
00000000-0000-0000-0000-000000000000	206458a8-23a3-4824-a237-10b893e7633c	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:31:41.557531+00	
00000000-0000-0000-0000-000000000000	fbaa3c5a-6324-4782-a188-1861b7f3a762	{"action":"login","actor_id":"771ad79b-34ce-4812-9d05-3914d9ada480","actor_username":"maytehormaza@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:31:54.250734+00	
00000000-0000-0000-0000-000000000000	143e910b-a6b9-45d2-9f94-8013d4a1a4df	{"action":"logout","actor_id":"771ad79b-34ce-4812-9d05-3914d9ada480","actor_username":"maytehormaza@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:33:33.308281+00	
00000000-0000-0000-0000-000000000000	4e9ac7ba-cd62-4ed1-8e3a-13e20428d369	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:33:56.207834+00	
00000000-0000-0000-0000-000000000000	3f6c159a-7957-45a0-936a-d00b75aae3e7	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:34:01.835614+00	
00000000-0000-0000-0000-000000000000	8bef6e44-1b07-45df-b6cd-e960fe949217	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:35:19.352171+00	
00000000-0000-0000-0000-000000000000	41b35d78-29d5-49d1-91b1-f00677ad08aa	{"action":"login","actor_id":"d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03","actor_username":"ninoskapin@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:35:27.837907+00	
00000000-0000-0000-0000-000000000000	d873bf80-da17-4e1e-94d4-83fa68e9ea2e	{"action":"logout","actor_id":"d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03","actor_username":"ninoskapin@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:37:30.401217+00	
00000000-0000-0000-0000-000000000000	7cc83333-fb26-4131-a6a9-7beff9454544	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:37:42.684577+00	
00000000-0000-0000-0000-000000000000	e020f397-f81a-4b60-bfed-6d60cc838bc4	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:38:05.351833+00	
00000000-0000-0000-0000-000000000000	79652fb0-af6b-4455-a1eb-c768876b5d3e	{"action":"login","actor_id":"ca71cb86-8002-48da-8292-cbd21b04c618","actor_username":"ikerzambrano@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 16:38:15.264617+00	
00000000-0000-0000-0000-000000000000	7d8413bc-4011-4aba-9849-00eea44d48d2	{"action":"logout","actor_id":"ca71cb86-8002-48da-8292-cbd21b04c618","actor_username":"ikerzambrano@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-10 16:39:34.776985+00	
00000000-0000-0000-0000-000000000000	ad2c2744-e6a3-4ee1-96b9-517f088151a9	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 14:14:24.78509+00	
00000000-0000-0000-0000-000000000000	dd4f9c89-037e-497a-81ed-a47348aabd7d	{"action":"user_signedup","actor_id":"4f59b75d-bb02-40d9-9cd2-b653d198a438","actor_username":"jesuspin@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-12 14:16:26.671768+00	
00000000-0000-0000-0000-000000000000	35e2ff09-fab7-41ba-a5e8-03025e729a88	{"action":"login","actor_id":"4f59b75d-bb02-40d9-9cd2-b653d198a438","actor_username":"jesuspin@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 14:16:26.684341+00	
00000000-0000-0000-0000-000000000000	1507f54b-9ce5-4b5e-924a-2f76c4507efb	{"action":"logout","actor_id":"4f59b75d-bb02-40d9-9cd2-b653d198a438","actor_username":"jesuspin@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-12 14:16:54.079216+00	
00000000-0000-0000-0000-000000000000	9e1a771f-c45f-4bac-8c46-bcd299394fc8	{"action":"login","actor_id":"4f59b75d-bb02-40d9-9cd2-b653d198a438","actor_username":"jesuspin@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 14:17:05.915677+00	
00000000-0000-0000-0000-000000000000	ff7941e6-e490-4a8a-bc00-22a4c312bfad	{"action":"logout","actor_id":"4f59b75d-bb02-40d9-9cd2-b653d198a438","actor_username":"jesuspin@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-02-12 14:19:26.79724+00	
00000000-0000-0000-0000-000000000000	4255d3dc-146f-4d28-9380-5117091e536f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 14:19:36.641438+00	
00000000-0000-0000-0000-000000000000	675dbaf6-2b38-442d-a597-5c0a66f477d7	{"action":"user_signedup","actor_id":"92a11fb0-ed08-4d87-9ae4-e7bac360a51d","actor_username":"dastinparedes@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-12 14:24:04.512779+00	
00000000-0000-0000-0000-000000000000	3dba2d19-d475-484b-94e8-01421d59e352	{"action":"login","actor_id":"92a11fb0-ed08-4d87-9ae4-e7bac360a51d","actor_username":"dastinparedes@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 14:24:04.527398+00	
00000000-0000-0000-0000-000000000000	db018282-fe6c-4085-adcc-31fe235467ec	{"action":"user_signedup","actor_id":"91976250-d16f-48f5-9315-c89017ed5980","actor_username":"sofiapin@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-12 14:24:54.792791+00	
00000000-0000-0000-0000-000000000000	54a91c07-e478-47bb-944d-601a52a3dc5d	{"action":"login","actor_id":"91976250-d16f-48f5-9315-c89017ed5980","actor_username":"sofiapin@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 14:24:54.797327+00	
00000000-0000-0000-0000-000000000000	87aa6c21-477a-4c5c-af4d-8d77d354b290	{"action":"token_refreshed","actor_id":"91976250-d16f-48f5-9315-c89017ed5980","actor_username":"sofiapin@didactikapp.com","actor_via_sso":false,"log_type":"token"}	2026-02-12 16:32:52.734363+00	
00000000-0000-0000-0000-000000000000	4f85d4d8-0b4d-45cf-a6f1-7b5a3b9481f7	{"action":"token_revoked","actor_id":"91976250-d16f-48f5-9315-c89017ed5980","actor_username":"sofiapin@didactikapp.com","actor_via_sso":false,"log_type":"token"}	2026-02-12 16:32:52.749045+00	
00000000-0000-0000-0000-000000000000	89cb3f75-eac8-4dd0-a44c-f86ede70d130	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 16:35:03.390015+00	
00000000-0000-0000-0000-000000000000	804d20d6-60ca-4645-a747-fe9bc57bb0b2	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-12 17:34:13.643196+00	
00000000-0000-0000-0000-000000000000	7eacdfd5-6059-4819-a130-4b9e52433e7f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-12 17:34:13.655192+00	
00000000-0000-0000-0000-000000000000	844cd8c4-531c-4911-bdcb-d17ddd6cdb39	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 17:44:13.321649+00	
00000000-0000-0000-0000-000000000000	d4a1dbb9-ea8a-4124-a673-f215853db7d4	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-12 17:46:37.33245+00	
00000000-0000-0000-0000-000000000000	72555514-233d-4d76-92d5-1b92419a4774	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 18:00:18.310687+00	
00000000-0000-0000-0000-000000000000	66fb5cf9-a578-4828-b6c2-348d595018de	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 18:00:25.613442+00	
00000000-0000-0000-0000-000000000000	6dfbd797-0d0f-4b9e-a1c3-d55bb0036698	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-12 18:01:10.652433+00	
00000000-0000-0000-0000-000000000000	06f7ee71-3599-4b40-b48d-d5d400864988	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-12 14:45:01.775998+00	
00000000-0000-0000-0000-000000000000	54ea91fd-8748-41ae-aa20-edd6be23a4af	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-12 15:08:52.385582+00	
00000000-0000-0000-0000-000000000000	2590e9e5-9390-475e-9fc4-5836edff33be	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 15:28:17.143843+00	
00000000-0000-0000-0000-000000000000	f92b5fd7-1453-40fa-a4c0-fed88d1141ae	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 15:28:17.154952+00	
00000000-0000-0000-0000-000000000000	b6fa19de-e5b3-4647-b403-dc33aab366ed	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 16:11:11.543969+00	
00000000-0000-0000-0000-000000000000	b205eb3d-4095-4cd7-b143-cf63ac7a7604	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 16:11:11.55129+00	
00000000-0000-0000-0000-000000000000	1ff25be8-3657-4e9a-8162-d0b4fe57caa6	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 16:40:23.154567+00	
00000000-0000-0000-0000-000000000000	aec4fb13-69ce-4bd2-b137-57bdcd51a503	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 16:40:23.163584+00	
00000000-0000-0000-0000-000000000000	b6075e00-c66e-4589-8f91-2cc20232f872	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 16:54:05.712725+00	
00000000-0000-0000-0000-000000000000	2fbf1c1f-5819-4758-b634-7b9a499cccea	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 16:54:05.719482+00	
00000000-0000-0000-0000-000000000000	f720deef-4b3b-4918-ba8f-1f2d1fd86e58	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 17:36:49.986794+00	
00000000-0000-0000-0000-000000000000	1c087c96-361a-4659-bb73-7ffa57626055	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 17:36:49.997094+00	
00000000-0000-0000-0000-000000000000	0dd88822-5f24-4712-b7de-26373189905a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 18:20:05.338359+00	
00000000-0000-0000-0000-000000000000	538f889d-1107-4943-8b9d-b6b85e82359b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 18:20:05.344676+00	
00000000-0000-0000-0000-000000000000	d7526f09-e288-4d31-83f4-e933fbf49a86	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 19:03:19.673432+00	
00000000-0000-0000-0000-000000000000	dea895dc-f7e6-4c43-8edf-e4bcbb8a580e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 19:03:19.684223+00	
00000000-0000-0000-0000-000000000000	d98c923e-4dde-43c9-b90b-89404a02297a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 19:55:36.400337+00	
00000000-0000-0000-0000-000000000000	e29adb76-9c2a-4d95-998d-37a2424dfade	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 19:55:36.419393+00	
00000000-0000-0000-0000-000000000000	6172c33a-3a19-465c-be26-48aec39210fa	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 20:38:41.520801+00	
00000000-0000-0000-0000-000000000000	3138730b-8476-495f-a5c2-d9819f8294de	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 20:38:41.531695+00	
00000000-0000-0000-0000-000000000000	40ec184e-ab3d-4686-a67d-d03b02358c09	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 21:22:17.112107+00	
00000000-0000-0000-0000-000000000000	390c5367-a398-45e8-b097-0da0ec07123c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 21:22:17.122732+00	
00000000-0000-0000-0000-000000000000	5d436fd6-5531-4134-a8f8-a93fd6430f55	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 22:25:36.975811+00	
00000000-0000-0000-0000-000000000000	956146c1-c39b-4aea-a004-a6d197b41de5	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-12 22:25:36.986903+00	
00000000-0000-0000-0000-000000000000	8a056e57-b38d-48f7-a2ae-8a2cb60cc7a3	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-12 23:50:07.225183+00	
00000000-0000-0000-0000-000000000000	882a53e1-b9d4-43f9-ad94-f43604df760a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 00:11:49.556298+00	
00000000-0000-0000-0000-000000000000	b62499c2-7fcf-4884-a3fd-a44e7af800aa	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 00:11:49.568247+00	
00000000-0000-0000-0000-000000000000	a26cc572-78ad-4fa3-b7be-6b0b8c177b22	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 00:48:39.63221+00	
00000000-0000-0000-0000-000000000000	f41ac3a1-2383-4851-ab66-eacde0cf6bb2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 00:48:39.641615+00	
00000000-0000-0000-0000-000000000000	5e8de1e5-0beb-4110-b3ef-c24157fbb6ba	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 00:55:46.13878+00	
00000000-0000-0000-0000-000000000000	090e83b2-7502-469f-9060-fe2c3c9ef446	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 00:55:46.147743+00	
00000000-0000-0000-0000-000000000000	48becb8d-6af2-4552-8874-6e6f5b6f5926	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 01:47:39.41966+00	
00000000-0000-0000-0000-000000000000	0c91900d-8d67-4bd3-9f53-ab7d4d627857	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 01:47:39.426571+00	
00000000-0000-0000-0000-000000000000	cbbec3ec-784d-4927-b01a-ed231ae016ac	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 01:54:51.190408+00	
00000000-0000-0000-0000-000000000000	33cbfe1f-f7d9-42c5-afc0-ecd581f4ef05	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 01:54:51.194922+00	
00000000-0000-0000-0000-000000000000	7777ab6f-0566-4e07-89e7-98ef8310a41e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 02:46:39.484229+00	
00000000-0000-0000-0000-000000000000	ee7d4575-4819-4c84-9d60-176b032f4410	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-13 02:46:39.496101+00	
00000000-0000-0000-0000-000000000000	cc9df560-92a1-49af-9bce-b33e59de43e1	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-14 02:48:45.937792+00	
00000000-0000-0000-0000-000000000000	eaf36967-6ebe-4ec5-ad14-50e8c07bbddf	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-14 02:48:45.956114+00	
00000000-0000-0000-0000-000000000000	6e75489f-8150-4139-8c4d-cc32c3b207c3	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-14 03:47:42.128242+00	
00000000-0000-0000-0000-000000000000	55b1bc9f-e410-48d1-8c45-0d8dcc29b271	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-14 03:47:42.134723+00	
00000000-0000-0000-0000-000000000000	1b8b9f57-e651-4517-8bd9-867ace044876	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-18 16:44:06.487842+00	
00000000-0000-0000-0000-000000000000	d1495e0e-64f6-4336-8479-d943c951c9d0	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-18 17:27:26.742372+00	
00000000-0000-0000-0000-000000000000	6df31159-7e4e-406d-a858-3787a8fbfc74	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-18 17:27:26.753812+00	
00000000-0000-0000-0000-000000000000	31d584fe-ae66-4310-955e-de1fc1497ffd	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-18 18:11:29.279687+00	
00000000-0000-0000-0000-000000000000	4355efd6-33cf-4c60-8556-000d9dfd3355	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-18 18:11:29.288741+00	
00000000-0000-0000-0000-000000000000	7f526cbe-27cf-4790-a147-949a0a7c021e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-18 20:01:42.927476+00	
00000000-0000-0000-0000-000000000000	4d75d6ba-5dc9-4009-9bdf-89a483b9c055	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-18 20:01:42.947621+00	
00000000-0000-0000-0000-000000000000	a2beb058-cf75-41bf-a0db-e79afcb0290e	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-04-18 20:11:13.623603+00	
00000000-0000-0000-0000-000000000000	d045d760-5573-47e7-ad62-338f0d69a8ce	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-18 20:46:07.668318+00	
00000000-0000-0000-0000-000000000000	344b4fbd-88cd-4a88-95a4-c79a85fc94f4	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-18 21:27:28.142927+00	
00000000-0000-0000-0000-000000000000	f1e0411d-72cb-4c28-a0fc-067aaca1eb3d	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-18 22:10:03.00836+00	
00000000-0000-0000-0000-000000000000	c29ac567-c9e9-4562-ab02-bc22ebbb4942	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-18 22:10:03.015637+00	
00000000-0000-0000-0000-000000000000	ac976e87-55a6-4e48-aff1-04ad509b8623	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 01:06:35.948898+00	
00000000-0000-0000-0000-000000000000	28fb6ab7-5c37-47b0-b909-19fc7476997b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 01:06:35.963665+00	
00000000-0000-0000-0000-000000000000	e2c2e39a-c864-4ac4-92bb-81d3cdc7b2f8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 01:58:13.994261+00	
00000000-0000-0000-0000-000000000000	276a76ff-c366-4e75-9716-8de84bc73049	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 01:58:14.006873+00	
00000000-0000-0000-0000-000000000000	5549b4cd-bf4a-48fc-b49b-1bb9b167e107	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 02:41:02.740725+00	
00000000-0000-0000-0000-000000000000	cb8f35d8-6ee8-444c-852c-65a86210eb5e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 02:41:02.750572+00	
00000000-0000-0000-0000-000000000000	0beaa062-1f0c-4ed8-8dde-fbe163098305	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 03:24:40.983749+00	
00000000-0000-0000-0000-000000000000	f864e94f-7d5e-48bc-b24a-9a05ee408edb	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 03:24:40.99856+00	
00000000-0000-0000-0000-000000000000	5084a6ff-d1cf-432d-9839-cb266e720b80	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 04:07:32.234328+00	
00000000-0000-0000-0000-000000000000	55f81cf4-b32c-4449-9a04-ab6e1d13d7ca	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 04:07:32.242122+00	
00000000-0000-0000-0000-000000000000	c9f68d27-e578-4651-86b2-17843ad94fed	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 04:50:38.081792+00	
00000000-0000-0000-0000-000000000000	45ba1bb0-0ca1-47b7-947f-a32083f9c124	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 04:50:38.091532+00	
00000000-0000-0000-0000-000000000000	bd2d516f-3c5a-4544-9566-c7b3bc5e1d46	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 16:33:07.89348+00	
00000000-0000-0000-0000-000000000000	2a06d4a1-b53b-46d2-a93e-ad49aa3e15ff	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 16:33:07.917511+00	
00000000-0000-0000-0000-000000000000	8e014c32-8501-498a-a923-7ec33430e90f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 17:15:50.88565+00	
00000000-0000-0000-0000-000000000000	ceff66ca-ad9f-435f-98bc-3a8b413918c7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 17:15:50.892337+00	
00000000-0000-0000-0000-000000000000	95336963-0ed5-4f53-a90f-2af3d9a78f9c	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 17:58:34.83467+00	
00000000-0000-0000-0000-000000000000	d0efd987-e0b5-4ea1-81c5-1acca19dd758	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-19 17:58:34.840254+00	
00000000-0000-0000-0000-000000000000	a188ae41-67e0-4fa2-b012-29efa5f7b49a	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-19 18:15:19.805128+00	
00000000-0000-0000-0000-000000000000	bb3d30d8-e970-4c91-9c91-a05eda37e15d	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-26 19:08:32.757173+00	
00000000-0000-0000-0000-000000000000	1acb6834-5ef5-42f7-9b55-b5b7e76f7728	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 19:10:01.128976+00	
00000000-0000-0000-0000-000000000000	f8a5ae99-fb62-44ee-bcae-fed855ed60c1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 19:10:01.135017+00	
00000000-0000-0000-0000-000000000000	e01405b1-bcae-40b7-b6d7-e52921b604ba	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-26 19:10:28.724121+00	
00000000-0000-0000-0000-000000000000	d3e89fc1-8ea8-4729-b39b-b98bca97c7a5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 19:53:02.463806+00	
00000000-0000-0000-0000-000000000000	f5e975c0-9865-4c9b-b7fb-33ea8992d6bf	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 19:53:02.474268+00	
00000000-0000-0000-0000-000000000000	e10f130c-63ef-4ea6-b97c-8f8652205e6b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 21:14:17.238346+00	
00000000-0000-0000-0000-000000000000	c0dbdd8e-051d-47dc-bb23-0f06b6db795a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 21:14:17.255368+00	
00000000-0000-0000-0000-000000000000	32396cae-e8bb-48aa-b3d7-e6009e789b55	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 21:56:53.572022+00	
00000000-0000-0000-0000-000000000000	a6623bb4-8532-496d-8840-aa28f481074e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 21:56:53.586232+00	
00000000-0000-0000-0000-000000000000	0bcc22a9-8f1a-4732-9c3f-274a195aae42	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 22:39:16.659836+00	
00000000-0000-0000-0000-000000000000	4c3f39b3-6252-4f83-b219-10908138a39a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 22:39:16.668004+00	
00000000-0000-0000-0000-000000000000	ed73c823-ddb5-4fca-9486-4fe1fed545fc	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 23:21:47.151181+00	
00000000-0000-0000-0000-000000000000	220115b8-c6ad-4cfd-8b54-de55d46d03dc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 23:21:47.167372+00	
00000000-0000-0000-0000-000000000000	46753e00-dc3d-4f5e-9095-35b18f679627	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 00:04:28.527055+00	
00000000-0000-0000-0000-000000000000	dfdb54cf-d729-45b8-9412-0f2ad56887b2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 00:04:28.538899+00	
00000000-0000-0000-0000-000000000000	e4566e8c-60c2-4f65-a606-98d1c2b0f54e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 00:46:58.892523+00	
00000000-0000-0000-0000-000000000000	965b4056-560b-446e-8422-34d6f0afad7b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 00:46:58.898625+00	
00000000-0000-0000-0000-000000000000	b218ffe0-0bd5-4ff8-8756-18fb91341b35	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 01:29:15.540204+00	
00000000-0000-0000-0000-000000000000	436df76e-a9b1-4a4a-9d52-6c62898869ff	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 01:29:15.550498+00	
00000000-0000-0000-0000-000000000000	beccded7-e43f-4933-9f46-69292bff82ef	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 02:11:58.470846+00	
00000000-0000-0000-0000-000000000000	301d99ca-b6d1-40d3-a8bc-a8be974a5605	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 02:11:58.483399+00	
00000000-0000-0000-0000-000000000000	8a43fdf9-8b8a-4daf-bab1-51678e608c1c	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 02:54:26.262396+00	
00000000-0000-0000-0000-000000000000	a4feb2c4-b8e2-41e3-aa42-0ecb075786a3	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 02:54:26.278697+00	
00000000-0000-0000-0000-000000000000	66cb7e50-caaa-4859-a37f-9f48d0451c51	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 16:50:02.189955+00	
00000000-0000-0000-0000-000000000000	dcfb3fa5-eed3-4b1b-a9f3-1d3a822c0fb0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 16:50:02.207536+00	
00000000-0000-0000-0000-000000000000	445eb122-6d12-48bb-a061-1cb680e0cfd8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 17:35:24.235746+00	
00000000-0000-0000-0000-000000000000	caa92c63-67a1-4b57-98c2-c8e26675d84b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 17:35:24.250581+00	
00000000-0000-0000-0000-000000000000	faa38c73-3f10-45a2-8574-4c0d9aa94bc7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 18:17:25.422439+00	
00000000-0000-0000-0000-000000000000	7201ccb5-9a74-4f83-9c61-86470a16e07e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 18:17:25.429431+00	
00000000-0000-0000-0000-000000000000	fcdece0b-135f-4a5e-87df-4289a9d76e5f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 18:59:34.901976+00	
00000000-0000-0000-0000-000000000000	d80b4d97-9674-443d-ae1f-94c3e5ea9700	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 18:59:34.911301+00	
00000000-0000-0000-0000-000000000000	5c84a752-a485-4c41-b292-3e0b27fcfee8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 19:41:37.479786+00	
00000000-0000-0000-0000-000000000000	59bbffb2-7f0e-4827-8eef-01acfd75b534	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 19:41:37.494766+00	
00000000-0000-0000-0000-000000000000	ae0fa286-e34f-46e2-8550-035868b1aeb9	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 20:23:35.838208+00	
00000000-0000-0000-0000-000000000000	dc57938f-4b69-4afe-9de4-53279924bea2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-10 20:23:35.846911+00	
00000000-0000-0000-0000-000000000000	b1f209c6-a03c-41e3-8575-92d8b4ae2647	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-11 01:10:04.458597+00	
00000000-0000-0000-0000-000000000000	5438e632-8c8d-45de-be91-912e07a08d89	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-11 01:42:18.405752+00	
00000000-0000-0000-0000-000000000000	0c44ebe7-37a6-406c-913e-9d2e6d0307bb	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-11 01:42:18.415276+00	
00000000-0000-0000-0000-000000000000	d06e3ba6-0d39-4802-bf31-f84d9ce8a4b9	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-13 01:25:36.478143+00	
00000000-0000-0000-0000-000000000000	60f02207-b127-4738-95d2-1d94a54579c7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-13 01:25:36.494313+00	
00000000-0000-0000-0000-000000000000	f709b0ee-e2b5-408d-b38b-a9787a444b26	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-15 18:52:34.33445+00	
00000000-0000-0000-0000-000000000000	7460c37d-b482-4462-a60d-69da3a997107	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-15 18:52:34.353012+00	
00000000-0000-0000-0000-000000000000	08ed7752-2082-4594-b255-56c048332038	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-15 23:35:18.36598+00	
00000000-0000-0000-0000-000000000000	7fd25054-7dd9-4239-a547-100106a386b8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-15 23:35:18.38134+00	
00000000-0000-0000-0000-000000000000	e695cf01-bbf3-4b6e-8f8c-7180cffa04f8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-17 22:39:19.059877+00	
00000000-0000-0000-0000-000000000000	09c02f1c-cc27-45ef-88e9-0f08bfb60240	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-17 22:39:19.067161+00	
00000000-0000-0000-0000-000000000000	90d327b8-9edb-4851-b58b-7203a3a17075	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-17 23:38:11.433719+00	
00000000-0000-0000-0000-000000000000	cbcfbf31-29dd-4ff7-9f6b-7d6b9a2dcf9a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-17 23:38:11.445707+00	
00000000-0000-0000-0000-000000000000	1a097092-a4db-4925-acd2-7fd95baaba03	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-18 00:37:11.416823+00	
00000000-0000-0000-0000-000000000000	f3529cc5-90da-4fc5-9e9a-d19dd72a8b6f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-18 00:37:11.423945+00	
00000000-0000-0000-0000-000000000000	701e48d9-3623-4fd5-8627-62ff0360bcc2	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-20 03:01:05.34857+00	
00000000-0000-0000-0000-000000000000	4b1efdfe-64ee-41dd-b4b3-2696ff6fab36	{"action":"user_signedup","actor_id":"bc729450-c4d8-450a-bf83-215288d70e0a","actor_username":"adrianmikko@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-05-20 03:25:08.32353+00	
00000000-0000-0000-0000-000000000000	bbe9e70d-3eff-4cd1-92a7-e0f17d0310dd	{"action":"login","actor_id":"bc729450-c4d8-450a-bf83-215288d70e0a","actor_username":"adrianmikko@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-20 03:25:08.340097+00	
00000000-0000-0000-0000-000000000000	a5536fd9-75b4-43b0-b892-c2056dee5103	{"action":"logout","actor_id":"bc729450-c4d8-450a-bf83-215288d70e0a","actor_username":"adrianmikko@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-05-20 03:27:30.579511+00	
00000000-0000-0000-0000-000000000000	d252eae1-0fa5-4cd8-9d3b-6c9f06e95338	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-20 03:27:49.721057+00	
00000000-0000-0000-0000-000000000000	f1d8f4e1-1eba-464c-80fb-8a9a6f085e4e	{"action":"login","actor_id":"bc729450-c4d8-450a-bf83-215288d70e0a","actor_username":"adrianmikko@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-20 03:31:09.640308+00	
00000000-0000-0000-0000-000000000000	0cb3c4c7-84a4-4c7c-b423-a293c61c90f1	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-23 14:23:50.372189+00	
00000000-0000-0000-0000-000000000000	c8ed844f-d028-4d32-8c1f-dd6459e0e3fe	{"action":"user_signedup","actor_id":"8d999d39-7910-409f-a2ef-1b83c369843a","actor_username":"carlos23@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-05-23 14:29:13.869705+00	
00000000-0000-0000-0000-000000000000	c87ce2b0-b79a-4cc5-b1a8-004e13fc2c47	{"action":"login","actor_id":"8d999d39-7910-409f-a2ef-1b83c369843a","actor_username":"carlos23@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-23 14:29:13.8893+00	
00000000-0000-0000-0000-000000000000	7cf435ce-f24b-4197-a64b-9b9b180ebf29	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-23 14:30:15.429378+00	
00000000-0000-0000-0000-000000000000	1b774745-24a9-4a3b-b86b-b6fbba9ca7be	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-23 15:28:52.298738+00	
00000000-0000-0000-0000-000000000000	023d80a1-6f06-4fd7-9317-a954775ead94	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-23 15:28:52.309624+00	
00000000-0000-0000-0000-000000000000	5bb9134c-1732-488f-b879-df429ef9b517	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-23 16:28:06.163822+00	
00000000-0000-0000-0000-000000000000	fc90ed40-dd0e-4e3f-887a-37dce7d57fb7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-23 16:28:06.173454+00	
00000000-0000-0000-0000-000000000000	2ba13771-b4d0-49c7-9a49-105b5437451a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-23 17:29:07.939718+00	
00000000-0000-0000-0000-000000000000	0bf166b1-161a-4d14-9efc-2c84dc2ea3e4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-23 17:29:07.956344+00	
00000000-0000-0000-0000-000000000000	61685ea9-9975-48e1-952f-23a9c63164b4	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-23 21:02:53.997944+00	
00000000-0000-0000-0000-000000000000	e95cb91e-6892-48f3-9e32-99e87bb45fb5	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-23 21:02:54.015996+00	
00000000-0000-0000-0000-000000000000	67034423-2c6e-4c3c-a5c3-fbebf259bb49	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 00:15:10.359155+00	
00000000-0000-0000-0000-000000000000	3f6dfc2d-b5c2-43cf-a321-8a2948cf1197	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 00:15:10.373401+00	
00000000-0000-0000-0000-000000000000	f3f4bb45-6360-4eac-97bd-da990309ac12	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 03:27:17.183416+00	
00000000-0000-0000-0000-000000000000	fc0b6172-67ba-492b-9d63-98d3a4be9eef	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 03:27:17.198317+00	
00000000-0000-0000-0000-000000000000	3560f417-651c-4a1d-8e2c-09e804b3ee90	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 06:38:23.039265+00	
00000000-0000-0000-0000-000000000000	999fcbd0-a200-461d-9fa8-788d628748f1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 06:38:23.061079+00	
00000000-0000-0000-0000-000000000000	a3d72da2-a4ff-46bf-a7d8-eb703f4e3565	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 09:50:10.830979+00	
00000000-0000-0000-0000-000000000000	10ef69a1-acf4-4801-a10f-9fec525bd61e	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 09:50:10.848831+00	
00000000-0000-0000-0000-000000000000	496d131a-e24d-4af5-b708-f35d53868e4a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 13:02:59.235628+00	
00000000-0000-0000-0000-000000000000	84fa996e-a10e-47ce-b853-d533557f33da	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 13:02:59.251678+00	
00000000-0000-0000-0000-000000000000	37716283-4460-47c8-a55b-a43e1e3ae467	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 14:28:45.826433+00	
00000000-0000-0000-0000-000000000000	732c7d0f-ce93-4cab-9273-42f07c2204ae	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 14:28:45.844485+00	
00000000-0000-0000-0000-000000000000	c24939ce-a7e2-4bcf-b5f2-9127aec1a339	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 15:28:05.997689+00	
00000000-0000-0000-0000-000000000000	9b38d9e0-27e7-41c6-8e95-eaf9e521eda4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-24 15:28:06.006576+00	
00000000-0000-0000-0000-000000000000	cd02eff3-0321-45ae-a382-f7c16e7277ba	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-25 23:57:09.699886+00	
00000000-0000-0000-0000-000000000000	432b49d6-9dbf-4a53-9464-a25e68be196b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-25 23:57:09.720965+00	
00000000-0000-0000-0000-000000000000	bfe7e2f4-a87f-4343-8101-c755115967b2	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-26 01:23:48.693311+00	
00000000-0000-0000-0000-000000000000	afe1033b-c139-4149-bee2-b8d238c28f1a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-26 01:23:48.707224+00	
00000000-0000-0000-0000-000000000000	877639d4-033d-4b98-bef9-53de7f44aeef	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 18:27:06.302179+00	
00000000-0000-0000-0000-000000000000	75ce9196-0918-4ce3-b67d-5afdd3772b04	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 18:40:31.836031+00	
00000000-0000-0000-0000-000000000000	92074218-0c13-474b-a0b1-02bc0c713f1b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 18:40:31.847552+00	
00000000-0000-0000-0000-000000000000	312ac7e1-8f97-48a8-9189-e8e76e78a6d6	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 19:22:15.788077+00	
00000000-0000-0000-0000-000000000000	ecb78f67-47a8-402c-8a8e-e623f5ecc2f2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 19:22:15.805714+00	
00000000-0000-0000-0000-000000000000	dd33a53b-c276-4e21-8793-22ad7cf0c61d	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 20:04:16.026614+00	
00000000-0000-0000-0000-000000000000	e52c6b6b-9cbf-4546-895c-5a8a9321256b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 20:04:16.037898+00	
00000000-0000-0000-0000-000000000000	72a09519-7f91-4576-ad07-aa8043c8e0f1	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 20:45:52.012416+00	
00000000-0000-0000-0000-000000000000	a36450ff-4117-4050-b7ba-5662c1725bc0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 20:45:52.02553+00	
00000000-0000-0000-0000-000000000000	febfe002-d783-452c-8a04-c13501dd7a2b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 21:27:42.557528+00	
00000000-0000-0000-0000-000000000000	69252e5b-dcd5-46e8-8bee-ac8e4e150568	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 21:27:42.567514+00	
00000000-0000-0000-0000-000000000000	036b8dbb-3e97-40ea-b0c4-e25188797c0f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 22:09:11.986892+00	
00000000-0000-0000-0000-000000000000	fb14fc45-b4b9-42d2-a513-44876cbe1e8c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 22:09:11.996596+00	
00000000-0000-0000-0000-000000000000	54abdb4e-9465-46b3-85b8-59c90091c4cd	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 22:50:42.019491+00	
00000000-0000-0000-0000-000000000000	89d5090a-b9ad-44b3-b5e5-c2188f64c4c4	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 22:50:42.027935+00	
00000000-0000-0000-0000-000000000000	2f359871-8d25-47c1-8fe3-46fa0b947b3c	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 23:32:14.271028+00	
00000000-0000-0000-0000-000000000000	c58fa7bf-4d18-4ce3-b45d-bcde422211a8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-30 23:32:14.281792+00	
00000000-0000-0000-0000-000000000000	40ff56dd-7e2d-43b7-adfd-9207f7f0353c	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 00:13:45.694588+00	
00000000-0000-0000-0000-000000000000	6da4f5f9-c68c-4bf6-ad0c-4b9abc8766d9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 00:13:45.700381+00	
00000000-0000-0000-0000-000000000000	f89f0766-0b56-4902-8851-eb2876a3c5b7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 00:47:57.251808+00	
00000000-0000-0000-0000-000000000000	66ac9acc-61de-4da1-82c9-b197f29e6d85	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 00:47:57.260067+00	
00000000-0000-0000-0000-000000000000	33d94fc9-da67-45ba-a784-3783c445b1f1	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 00:55:55.411884+00	
00000000-0000-0000-0000-000000000000	1b7d4ef3-8274-47e8-9c43-4669f4f0a10c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 00:55:55.416326+00	
00000000-0000-0000-0000-000000000000	fe4044f4-2714-4cf9-8dff-172cb2198ce1	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 00:57:51.479749+00	
00000000-0000-0000-0000-000000000000	d591624b-a451-4214-b6e9-a2cfddb4a8ea	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 01:40:43.932853+00	
00000000-0000-0000-0000-000000000000	f9aba43f-3d0b-4ebd-9e7f-ebcb9e01167a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 01:40:43.946229+00	
00000000-0000-0000-0000-000000000000	af8ba7f6-a6b5-435d-91a0-ccc233092f3b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 02:22:12.64785+00	
00000000-0000-0000-0000-000000000000	43ddf731-d239-4b3f-a36d-b719ab60bc72	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 02:22:12.656576+00	
00000000-0000-0000-0000-000000000000	6cafbb6c-2451-4292-9c18-f203ba74ce52	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 03:03:48.4714+00	
00000000-0000-0000-0000-000000000000	419e52a2-3ade-4630-8706-274b7695fd2c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 03:03:48.485244+00	
00000000-0000-0000-0000-000000000000	e0fdf437-52c2-4dd3-b41c-f4ced16b8f78	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 03:45:53.409575+00	
00000000-0000-0000-0000-000000000000	c78e0882-77ad-4aba-973b-577c192686ab	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 03:45:53.418283+00	
00000000-0000-0000-0000-000000000000	2dd448cf-ad2f-4034-b65b-6cfcf35142cd	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-31 03:47:14.348731+00	
00000000-0000-0000-0000-000000000000	7f63f1ee-fa83-4112-b9ae-38217e1d87ce	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 04:28:54.887368+00	
00000000-0000-0000-0000-000000000000	a14daf50-9a56-4c57-9876-a77acb6d42bf	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 04:28:54.896395+00	
00000000-0000-0000-0000-000000000000	ec20056e-cc73-4142-b864-d4c4b5b32272	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 05:10:51.197702+00	
00000000-0000-0000-0000-000000000000	a5663e9c-151b-4186-8c05-d517bbd0a286	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 05:10:51.20901+00	
00000000-0000-0000-0000-000000000000	4e50c3ee-0581-42b8-90b4-7d0d8c689bf6	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 05:52:52.120452+00	
00000000-0000-0000-0000-000000000000	51c80c71-ccaa-4348-9910-d290594665c1	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 05:52:52.12926+00	
00000000-0000-0000-0000-000000000000	52f28dc3-881f-4e26-a529-b665c6db1721	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 06:28:34.85608+00	
00000000-0000-0000-0000-000000000000	913ba509-0611-4610-8a77-013b29c5c190	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 06:28:34.861135+00	
00000000-0000-0000-0000-000000000000	e0d04169-5ad1-4635-adb9-7057cbdf5005	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 07:10:10.972044+00	
00000000-0000-0000-0000-000000000000	901474b8-e03b-4cc0-ab30-c48555913b57	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 07:10:10.990309+00	
00000000-0000-0000-0000-000000000000	76ee14a6-c096-4897-8be2-1f315e7a1575	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 07:51:45.863892+00	
00000000-0000-0000-0000-000000000000	ee12a661-6c14-4790-86ae-0298fc5c8ad9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 07:51:45.883071+00	
00000000-0000-0000-0000-000000000000	1b86aafe-26fd-4dcd-b468-c1e94e7cd9da	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 08:33:34.197131+00	
00000000-0000-0000-0000-000000000000	374c10aa-eac6-4c43-a7e4-49178044668b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 08:33:34.204701+00	
00000000-0000-0000-0000-000000000000	a37e7c83-444f-4b51-872d-a6692b472432	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 15:47:44.899924+00	
00000000-0000-0000-0000-000000000000	1d944ee7-3397-4961-a40a-6552d9c7e789	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 15:47:44.916461+00	
00000000-0000-0000-0000-000000000000	a025696d-c6fb-47b6-b05e-42ffbca21044	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 16:13:22.551622+00	
00000000-0000-0000-0000-000000000000	1edf9b44-8899-4337-aeca-fe0ca9a0703b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 16:13:22.564013+00	
00000000-0000-0000-0000-000000000000	f3a46f4b-b3f4-44ee-9b46-f109f81ffadb	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 16:55:21.944246+00	
00000000-0000-0000-0000-000000000000	cd0b403a-eec3-4ffd-9074-e8a82a416362	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 16:55:21.955679+00	
00000000-0000-0000-0000-000000000000	90a48537-92e0-4a55-8066-8301cb717685	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-31 16:59:06.772301+00	
00000000-0000-0000-0000-000000000000	ed11240d-a854-4308-99c7-7a35719c3151	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 17:37:37.506738+00	
00000000-0000-0000-0000-000000000000	fe9243fd-46ef-4a99-aab6-59e1faf389a0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 17:37:37.524063+00	
00000000-0000-0000-0000-000000000000	0645e2fc-7639-4562-967a-b9d04eae34df	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 17:58:00.066426+00	
00000000-0000-0000-0000-000000000000	2163b283-6034-4e41-9b2e-2c3853daa0fc	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 17:58:00.078782+00	
00000000-0000-0000-0000-000000000000	a885c8a4-c5a9-49bf-bf59-135d31df9492	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 18:19:24.836386+00	
00000000-0000-0000-0000-000000000000	3dc46e65-58a1-4523-a19a-a38ea0238063	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-05-31 18:19:24.848885+00	
00000000-0000-0000-0000-000000000000	d3cd53c1-9deb-4af2-853f-d25a13d92340	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-05-31 18:37:33.946969+00	
00000000-0000-0000-0000-000000000000	a380ea42-bc12-4381-8f67-bcae7d212454	{"action":"login","actor_id":"ac8e6da9-87c7-49a5-8791-31208c8005f2","actor_username":"breynertejena@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-31 18:37:43.033484+00	
00000000-0000-0000-0000-000000000000	533ef4a4-9dfc-4f4b-ba5f-df27eeb2d202	{"action":"logout","actor_id":"ac8e6da9-87c7-49a5-8791-31208c8005f2","actor_username":"breynertejena@didactikapp.com","actor_via_sso":false,"log_type":"account"}	2026-05-31 18:38:20.051218+00	
00000000-0000-0000-0000-000000000000	fbfe5263-004b-46ec-8696-e5b8dcafbdaf	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-31 18:38:28.588786+00	
00000000-0000-0000-0000-000000000000	17eba2b1-d78f-4f21-ae49-2f84a3021374	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-31 18:41:55.971763+00	
00000000-0000-0000-0000-000000000000	6cd6caac-635f-4a53-a5f6-8e51567425ec	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-31 18:43:41.865763+00	
00000000-0000-0000-0000-000000000000	69b1d750-9173-45ba-b060-a549b9ee325e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 00:55:42.128978+00	
00000000-0000-0000-0000-000000000000	422ad130-e664-4773-9f5f-715c3b4a3950	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 00:55:42.145392+00	
00000000-0000-0000-0000-000000000000	711d1059-69ab-40f2-bb0d-6dc640237cfe	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 01:54:51.902109+00	
00000000-0000-0000-0000-000000000000	68ececf1-dd7b-46a2-b24c-0f0e0af2a8b0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 01:54:51.912132+00	
00000000-0000-0000-0000-000000000000	6c26f93d-27a0-4685-b2c1-a382869692c8	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 02:53:17.260211+00	
00000000-0000-0000-0000-000000000000	89d95ee2-04af-4e8f-b374-18ef608ab6d0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 02:53:17.268797+00	
00000000-0000-0000-0000-000000000000	6bfc8b90-0db0-40fe-b695-b1e5398c4c8f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 03:51:50.463706+00	
00000000-0000-0000-0000-000000000000	ae908769-3728-48f5-b1bd-801deab01fe2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 03:51:50.475912+00	
00000000-0000-0000-0000-000000000000	006fb135-e49e-40b2-9392-d91a2872859d	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 04:50:50.639497+00	
00000000-0000-0000-0000-000000000000	c4c5cc02-e3a1-4c3c-ba02-1018bbcef98f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 04:50:50.653563+00	
00000000-0000-0000-0000-000000000000	d02d65ad-83b4-4011-b7b2-b1604e7f8752	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 05:40:16.786936+00	
00000000-0000-0000-0000-000000000000	ffcaf7aa-9f3c-4c1e-9647-c0201f65505f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 05:40:16.796003+00	
00000000-0000-0000-0000-000000000000	5eb9366c-7bcf-4864-94c2-e765cd288889	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 06:02:51.136907+00	
00000000-0000-0000-0000-000000000000	4fe7e19e-ee5c-4855-b4db-4e6fd0f25bdd	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 06:02:51.151333+00	
00000000-0000-0000-0000-000000000000	408e5e3b-f2e1-4abf-8b27-a3f3dc543bb0	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 06:02:57.383436+00	
00000000-0000-0000-0000-000000000000	c8b1e6a2-524a-473c-8e53-aabc82964ce7	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 06:24:28.175633+00	
00000000-0000-0000-0000-000000000000	8f6a48aa-ff4b-42dd-b9c7-f39c7b1026b8	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 06:36:42.859411+00	
00000000-0000-0000-0000-000000000000	139263ce-490e-4c09-9c25-e2f614c6b09a	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 06:46:13.474948+00	
00000000-0000-0000-0000-000000000000	6d2dd40c-a207-459b-bae7-3d31d71ae5ed	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 06:47:46.612762+00	
00000000-0000-0000-0000-000000000000	57479430-eeac-4311-b7d9-eb9c44a995e3	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 06:53:44.948545+00	
00000000-0000-0000-0000-000000000000	715a4322-045b-4ab6-a7c5-49163cde14b0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 06:53:44.956409+00	
00000000-0000-0000-0000-000000000000	7e4202f5-7458-4ba9-9160-6438ce9cac4b	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 07:01:35.108908+00	
00000000-0000-0000-0000-000000000000	78d59a7e-9403-4699-b3da-df108b93a25c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 07:01:35.113973+00	
00000000-0000-0000-0000-000000000000	6d16bbbd-cecf-4eeb-9f42-7e62062839eb	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 07:04:40.5038+00	
00000000-0000-0000-0000-000000000000	5b1e7d06-344f-45a2-b84c-3ca5cdb5f645	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-01 07:05:07.344152+00	
00000000-0000-0000-0000-000000000000	b4c8096d-1342-46ae-b639-642c53fae650	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 07:06:28.774286+00	
00000000-0000-0000-0000-000000000000	8735cb69-374b-4a83-a60f-356780183137	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 07:06:38.271906+00	
00000000-0000-0000-0000-000000000000	6ade9979-20d7-4f8a-b57b-8c9f5edb2d08	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 07:35:03.945867+00	
00000000-0000-0000-0000-000000000000	56374eba-ff43-400b-8e0e-31d36089b465	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 07:37:40.497807+00	
00000000-0000-0000-0000-000000000000	21a256d4-8d47-4ae8-a66e-725dd319fbdf	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 07:55:25.653585+00	
00000000-0000-0000-0000-000000000000	4f7c0c45-fdfc-4c9b-b2a4-0f889400e191	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 07:55:43.442235+00	
00000000-0000-0000-0000-000000000000	bec16b06-9863-4b9b-a119-fb2aff9b2297	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 07:56:32.356803+00	
00000000-0000-0000-0000-000000000000	85a4af6a-82a7-4e18-aafd-6e766af3f057	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 08:36:33.271667+00	
00000000-0000-0000-0000-000000000000	4c3bf785-0b8e-48ce-8fbb-9a5c8c24acd9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 08:36:33.286857+00	
00000000-0000-0000-0000-000000000000	6a49017b-3039-41d4-bb3c-91f7cb6db747	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 08:45:47.103599+00	
00000000-0000-0000-0000-000000000000	af0e7213-0b6a-404b-b294-2395da59e2af	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 08:52:59.9396+00	
00000000-0000-0000-0000-000000000000	b4a4d659-5817-4735-adba-a42937899810	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 17:12:29.631205+00	
00000000-0000-0000-0000-000000000000	62ea0df7-c83e-4a69-ac30-317e116c5d4f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 17:12:29.651463+00	
00000000-0000-0000-0000-000000000000	fa3a1c8b-ebf8-491a-a42b-a552d985c320	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 17:54:42.943924+00	
00000000-0000-0000-0000-000000000000	69f8291a-50b1-4e1d-98ca-58bcae89ffa3	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 17:54:42.957111+00	
00000000-0000-0000-0000-000000000000	c2866ebf-2e47-4f9f-9d3a-84b1ed3bf9ce	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 18:12:27.512088+00	
00000000-0000-0000-0000-000000000000	1dc2c3e5-4d55-4a1b-b3be-d262512f1fea	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 18:12:27.520597+00	
00000000-0000-0000-0000-000000000000	dd6152ef-f76c-4b9b-8bac-0ce685227564	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 18:39:25.995964+00	
00000000-0000-0000-0000-000000000000	8c85cc64-38cd-462a-9573-0e81a7250f03	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 18:39:26.005336+00	
00000000-0000-0000-0000-000000000000	f72c8894-3594-4db4-a9f6-f4048ce03962	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 19:11:13.177818+00	
00000000-0000-0000-0000-000000000000	fc2ab7cb-03e6-47f6-a931-cd91458cb3f6	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 19:11:13.18448+00	
00000000-0000-0000-0000-000000000000	de1d18ca-2bf7-4f32-b2bf-0c203f10e619	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 19:22:12.710013+00	
00000000-0000-0000-0000-000000000000	552cccef-2a9b-45c7-af66-35aa3b08cd8b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 19:22:12.724203+00	
00000000-0000-0000-0000-000000000000	85a85d8d-f276-40f5-a718-f396721fe0d7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:04:12.528436+00	
00000000-0000-0000-0000-000000000000	1f1ea6b8-5108-491c-b25b-1fb6f7702870	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:04:12.545277+00	
00000000-0000-0000-0000-000000000000	98a3cf6d-d029-4ea7-9e48-3606ec545300	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:46:12.261173+00	
00000000-0000-0000-0000-000000000000	b99a1a79-3eda-439c-a3d0-e5ec48eba3a2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:46:12.269047+00	
00000000-0000-0000-0000-000000000000	67e6505f-1802-4ade-b6cf-af308d1fb5fe	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:46:49.235929+00	
00000000-0000-0000-0000-000000000000	99d5c117-49fa-43c0-865c-a869a4346bf8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:46:49.238187+00	
00000000-0000-0000-0000-000000000000	2047b6c6-6098-4358-91b1-6d634a550ba4	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 21:27:55.59772+00	
00000000-0000-0000-0000-000000000000	29ff9788-8ad3-49d8-aed6-cae492dbe61b	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 21:27:55.611156+00	
00000000-0000-0000-0000-000000000000	1d8172f6-4389-4f41-b5c3-3be0a121dfec	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 22:09:25.445086+00	
00000000-0000-0000-0000-000000000000	dd1a6835-637e-448a-a3c5-b9dc97fbee86	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 22:09:25.454568+00	
00000000-0000-0000-0000-000000000000	446f05ef-7a30-44d3-98b1-68ca178131f5	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 23:37:04.361455+00	
00000000-0000-0000-0000-000000000000	b487c388-84b7-4e49-93a7-f070991603e0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-01 23:37:04.377914+00	
00000000-0000-0000-0000-000000000000	1a46ac6a-db6d-4c4b-bb68-ea9bdecb11fc	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 00:20:53.046923+00	
00000000-0000-0000-0000-000000000000	815c8a0d-bcd7-4fb8-9f41-bd68327c8419	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-02 01:19:04.531089+00	
00000000-0000-0000-0000-000000000000	fae28af5-946b-4190-b8b9-bca588a1b40a	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-02 01:19:04.538881+00	
00000000-0000-0000-0000-000000000000	33e801dd-a20e-434a-a94f-87a64f0fa820	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-02 02:11:59.602629+00	
00000000-0000-0000-0000-000000000000	e6d2454f-946a-4cab-a724-709634ac509f	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-02 02:11:59.618725+00	
00000000-0000-0000-0000-000000000000	2ad5d4a7-c808-408c-a2e3-eea7e145c3be	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:13:19.810509+00	
00000000-0000-0000-0000-000000000000	f57496ad-aee4-49f5-a75f-7710faec741a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-02 02:15:38.535033+00	
00000000-0000-0000-0000-000000000000	56282f2b-d1b7-462c-9687-31f458602755	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-02 02:15:38.545927+00	
00000000-0000-0000-0000-000000000000	84040769-b595-48b3-9785-e7027a73a1fd	{"action":"user_repeated_signup","actor_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-06-02 02:17:04.540894+00	
00000000-0000-0000-0000-000000000000	e99480cb-f4e3-47e4-b759-ebce51cff7aa	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-02 02:18:33.986234+00	
00000000-0000-0000-0000-000000000000	07de45fc-a557-4bff-89d1-5274043cf1c7	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-02 02:18:33.988248+00	
00000000-0000-0000-0000-000000000000	50aca6bb-e350-439d-b935-2eba565d48e5	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 02:45:24.423933+00	
00000000-0000-0000-0000-000000000000	f511657e-7879-43b1-a072-970a88d1347d	{"action":"user_signedup","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-06-02 02:46:39.751795+00	
00000000-0000-0000-0000-000000000000	f6e94484-37eb-4c68-8ae1-a4fc4eae34d8	{"action":"login","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:46:39.766647+00	
00000000-0000-0000-0000-000000000000	9e5ad654-0aeb-4878-a02a-be82f5c2fc89	{"action":"login","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:47:13.031858+00	
00000000-0000-0000-0000-000000000000	7e32dedb-0ecd-4d52-b0e0-5feda07cb113	{"action":"login","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:47:21.338564+00	
00000000-0000-0000-0000-000000000000	e46f7e0b-6de1-430e-bc02-402a03b61034	{"action":"login","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:47:44.277739+00	
00000000-0000-0000-0000-000000000000	1dc7eb71-702c-4aca-9262-3be3ffa85f50	{"action":"login","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:47:47.933128+00	
00000000-0000-0000-0000-000000000000	1a6cf016-d217-4208-a5fc-31fde8d1cea3	{"action":"login","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:48:08.545217+00	
00000000-0000-0000-0000-000000000000	4335f110-194a-44cc-b69c-0b4689c69b78	{"action":"login","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:48:10.990282+00	
00000000-0000-0000-0000-000000000000	23169cd5-c633-4b44-91e8-cdefe7e16b3f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:48:21.99411+00	
00000000-0000-0000-0000-000000000000	984873fc-29c6-45ab-95b1-2e1c6639de63	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 02:51:34.767804+00	
00000000-0000-0000-0000-000000000000	781eb448-0433-4f87-a1c4-cacc79d427c1	{"action":"user_signedup","actor_id":"ce486e2e-89f5-49ed-91f1-95c760d9e602","actor_username":"puchi.merart@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-06-02 02:52:01.567478+00	
00000000-0000-0000-0000-000000000000	b1729c45-c8bf-4760-afe1-303a5797faa4	{"action":"login","actor_id":"ce486e2e-89f5-49ed-91f1-95c760d9e602","actor_username":"puchi.merart@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:52:01.57375+00	
00000000-0000-0000-0000-000000000000	1546a42e-e0a8-4837-9bcd-0d8bf8b7ae65	{"action":"logout","actor_id":"ce486e2e-89f5-49ed-91f1-95c760d9e602","actor_username":"puchi.merart@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 02:52:14.686053+00	
00000000-0000-0000-0000-000000000000	62a60e62-0391-4a06-8476-a410d3c7f9d0	{"action":"user_repeated_signup","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-06-02 02:54:28.688008+00	
00000000-0000-0000-0000-000000000000	141767c7-ed81-4c80-8ed7-498c0bfa7787	{"action":"user_repeated_signup","actor_id":"e26adb54-7dcd-48a7-96c9-df6604bed15a","actor_username":"arteagayanelly23@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-06-02 02:54:55.650614+00	
00000000-0000-0000-0000-000000000000	d76a42c5-6d1e-4041-b3b3-5f6f0afce8c7	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 02:55:14.176479+00	
00000000-0000-0000-0000-000000000000	3dc40d25-eb54-4ddf-9f61-8817eab8e093	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 02:56:09.381818+00	
00000000-0000-0000-0000-000000000000	de774df7-8daa-4815-84bc-f52dd54bab83	{"action":"user_repeated_signup","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-06-02 03:03:31.450681+00	
00000000-0000-0000-0000-000000000000	33a79cb0-d7df-4de8-8b9f-ded9ae93d590	{"action":"user_repeated_signup","actor_id":"29181cd1-c18d-42e9-b0a8-7f13ec976837","actor_username":"yarteaga4576@utm.edu.ec","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-06-02 03:05:53.5131+00	
00000000-0000-0000-0000-000000000000	42154b20-eb3f-4620-954d-3c32d30bd82f	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:06:08.611808+00	
00000000-0000-0000-0000-000000000000	e1265f5a-5380-4a5b-8451-61b67284bea4	{"action":"user_signedup","actor_id":"7ebe0e88-8f7d-4583-9e84-0b1c5d561918","actor_username":"merlypaola@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-06-02 03:10:49.768937+00	
00000000-0000-0000-0000-000000000000	6fb0394b-2fc8-4a96-940c-b251bd955e6c	{"action":"login","actor_id":"7ebe0e88-8f7d-4583-9e84-0b1c5d561918","actor_username":"merlypaola@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:10:49.781237+00	
00000000-0000-0000-0000-000000000000	e5fe58f9-7a0e-433d-ac39-392fc869b9de	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:11:39.012394+00	
00000000-0000-0000-0000-000000000000	a3cf8473-23ad-47ba-8432-daa60a0650ce	{"action":"user_repeated_signup","actor_id":"7ebe0e88-8f7d-4583-9e84-0b1c5d561918","actor_username":"merlypaola@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-06-02 03:12:26.318381+00	
00000000-0000-0000-0000-000000000000	9ba705d4-5b47-4d92-b7b9-4bbfb6d937e8	{"action":"user_repeated_signup","actor_id":"7ebe0e88-8f7d-4583-9e84-0b1c5d561918","actor_username":"merlypaola@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-06-02 03:12:29.105166+00	
00000000-0000-0000-0000-000000000000	90931b8a-3b4d-491a-b805-91ad9a7c862e	{"action":"user_repeated_signup","actor_id":"7ebe0e88-8f7d-4583-9e84-0b1c5d561918","actor_username":"merlypaola@didactikapp.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-06-02 03:12:39.49427+00	
00000000-0000-0000-0000-000000000000	3407da15-233f-47d5-b4d6-6a38eece0fbd	{"action":"user_signedup","actor_id":"07010bce-5076-4553-9a09-2a95b20e0e8b","actor_username":"admin2@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-06-02 03:15:10.73233+00	
00000000-0000-0000-0000-000000000000	adc1a9bb-6e5a-424d-8e0c-e8591cb8aab9	{"action":"login","actor_id":"07010bce-5076-4553-9a09-2a95b20e0e8b","actor_username":"admin2@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:15:10.743389+00	
00000000-0000-0000-0000-000000000000	138fc366-f646-48b0-ba67-e021162a1c62	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:15:56.631738+00	
00000000-0000-0000-0000-000000000000	03e3588c-4933-4d96-a007-d28df34708d0	{"action":"user_signedup","actor_id":"0e495a05-fc94-4a96-b7d8-0ebed3cf3f95","actor_username":"admin3@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-06-02 03:18:41.494946+00	
00000000-0000-0000-0000-000000000000	60fb0f0a-2fa6-4454-aad0-e4f778fc9856	{"action":"login","actor_id":"0e495a05-fc94-4a96-b7d8-0ebed3cf3f95","actor_username":"admin3@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:18:41.503822+00	
00000000-0000-0000-0000-000000000000	01d6a2a5-2cd8-484b-8653-8e90fb57e5f3	{"action":"user_signedup","actor_id":"14ce5450-53d1-4997-aa2d-6c182759611d","actor_username":"anaja@didactikapp.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-06-02 03:22:40.73732+00	
00000000-0000-0000-0000-000000000000	eeeea839-dad7-4fe3-94c0-10f92567c5ee	{"action":"login","actor_id":"14ce5450-53d1-4997-aa2d-6c182759611d","actor_username":"anaja@didactikapp.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:22:40.747153+00	
00000000-0000-0000-0000-000000000000	b3805321-a258-4de9-8144-10446d00400e	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:26:50.142387+00	
00000000-0000-0000-0000-000000000000	cf200eec-de5d-4c68-83d3-1200f51dbef8	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 03:29:07.167855+00	
00000000-0000-0000-0000-000000000000	701d52dc-832f-4a17-8f47-b2aa69f23419	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:31:08.140173+00	
00000000-0000-0000-0000-000000000000	7643d0d3-8099-4ebf-b899-155cd7e098ad	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:31:50.015866+00	
00000000-0000-0000-0000-000000000000	8638323c-5afc-4e93-bcfc-9a37c47cb06a	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:32:06.151977+00	
00000000-0000-0000-0000-000000000000	4ad0264c-e65b-4b8d-a2b2-de3258ce8bef	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:32:24.416454+00	
00000000-0000-0000-0000-000000000000	f661eb24-d681-482a-b3d9-6ec610f466fa	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 03:33:14.574068+00	
00000000-0000-0000-0000-000000000000	43b89c69-a575-463c-b207-b59f115fe681	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"paolamerly1@gmail.com","user_id":"f9336dc6-3bbe-4740-8910-a91e4caeac47","user_phone":""}}	2026-06-02 03:49:59.242358+00	
00000000-0000-0000-0000-000000000000	e73adb9a-711e-47ec-9334-82fce463ae03	{"action":"user_signedup","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-06-02 03:51:15.788034+00	
00000000-0000-0000-0000-000000000000	ff1a9a53-6101-433a-988a-f0377a0e8f9c	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:51:15.795852+00	
00000000-0000-0000-0000-000000000000	bc4ab383-7b10-4fff-849f-543c7abc5e60	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:53:37.492989+00	
00000000-0000-0000-0000-000000000000	8dffea0e-281f-4f2e-b40d-a725bbaff4b7	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:56:57.906387+00	
00000000-0000-0000-0000-000000000000	2d4e5078-4958-42a4-81b0-0c7d2f700db1	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 03:57:02.237929+00	
00000000-0000-0000-0000-000000000000	72904d41-1073-438c-9139-8f67abc8efc0	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:57:12.530851+00	
00000000-0000-0000-0000-000000000000	6c1e17b1-9ef2-4dff-876b-11c2ed76051e	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 03:59:25.0611+00	
00000000-0000-0000-0000-000000000000	b8db6621-1669-4082-bc19-94b890c02d01	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:00:47.599854+00	
00000000-0000-0000-0000-000000000000	c7a9f139-22d9-4dc2-a732-ff262769c109	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:01:06.660119+00	
00000000-0000-0000-0000-000000000000	426568f7-47cb-4028-8043-51c38aa773bd	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 04:01:18.392118+00	
00000000-0000-0000-0000-000000000000	d67deae6-f0eb-4bfb-b900-fd99f653a5ac	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:15:12.271624+00	
00000000-0000-0000-0000-000000000000	7aee90be-6784-4fc9-960c-c4eab67a8765	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:16:46.682397+00	
00000000-0000-0000-0000-000000000000	a468fda0-337f-4a90-b979-f5fa96b4d6a8	{"action":"logout","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 04:23:14.406275+00	
00000000-0000-0000-0000-000000000000	0510a2b3-0c69-4728-9177-a9fc7f959125	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:23:24.185445+00	
00000000-0000-0000-0000-000000000000	90838011-4df3-4860-9eef-5ee75080edcb	{"action":"logout","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 04:23:31.442465+00	
00000000-0000-0000-0000-000000000000	5f733604-b51d-49ee-ae2a-0883981d3941	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:26:27.186568+00	
00000000-0000-0000-0000-000000000000	e29ffe37-97cc-4bf1-9c0d-9c4fda8172f3	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:26:55.982586+00	
00000000-0000-0000-0000-000000000000	8e8f8fb1-c09b-4346-a88b-9098f2656dea	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:27:24.615074+00	
00000000-0000-0000-0000-000000000000	03104391-98ad-4237-99ad-68917522b216	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 04:27:57.843174+00	
00000000-0000-0000-0000-000000000000	8a2a7ebc-622d-4c97-b822-59fbbcf03ea2	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:33:32.737889+00	
00000000-0000-0000-0000-000000000000	2e56f937-fe17-4746-9ed0-3d39fd5cc2f8	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:34:51.28116+00	
00000000-0000-0000-0000-000000000000	b0501eff-1d74-4d71-899e-134d5efce5f5	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:35:30.222483+00	
00000000-0000-0000-0000-000000000000	8f8deb50-751a-4719-abed-c75533b11351	{"action":"logout","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-02 04:35:59.186492+00	
00000000-0000-0000-0000-000000000000	a215b58e-6f06-4a8d-9fff-d67f705d2796	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:41:22.062957+00	
00000000-0000-0000-0000-000000000000	4122a8b9-0488-4a24-8019-b4aaab8494bb	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:47:20.993727+00	
00000000-0000-0000-0000-000000000000	e1adb9ff-cfd7-4c56-ac16-6ffffe0d8afa	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-02 04:50:00.948447+00	
00000000-0000-0000-0000-000000000000	c7e31f12-f50a-4f5b-87b2-f11b4c597fc5	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 20:49:17.49138+00	
00000000-0000-0000-0000-000000000000	9df2553b-3d0b-4d66-888e-5481a47e678a	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-03 21:51:38.21679+00	
00000000-0000-0000-0000-000000000000	e021d2ef-764a-415b-b1a1-0b25236394ba	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-03 21:51:38.225234+00	
00000000-0000-0000-0000-000000000000	1f555b77-7142-46cd-9b66-c492ed20b8c7	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-03 23:04:14.840228+00	
00000000-0000-0000-0000-000000000000	0355d20b-d5b0-4af8-a0d1-6d1c3c7b2f17	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-03 23:04:14.853962+00	
00000000-0000-0000-0000-000000000000	13aa235c-ca14-4587-bd87-0eddfb3ad0fa	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 00:02:36.960382+00	
00000000-0000-0000-0000-000000000000	bfdb1f47-00de-4322-8159-b50f2e430837	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 00:02:36.972729+00	
00000000-0000-0000-0000-000000000000	bca71633-c981-4989-ad01-af8f4930011e	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 01:01:17.908286+00	
00000000-0000-0000-0000-000000000000	65781ff9-d31d-4d5a-8dcd-67048ca5d461	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 01:01:17.92473+00	
00000000-0000-0000-0000-000000000000	4614ef67-5b88-41a6-b04e-1c496ebe8a13	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 01:59:54.602639+00	
00000000-0000-0000-0000-000000000000	b0a003b1-adc5-4749-ba3f-297cd08e3bc8	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 01:59:54.619694+00	
00000000-0000-0000-0000-000000000000	fbad234b-de75-4415-81f2-9450235e3b37	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 03:02:58.591536+00	
00000000-0000-0000-0000-000000000000	bb8605c8-7c8a-4f46-863d-8bb8dd00a4c0	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 03:02:58.613779+00	
00000000-0000-0000-0000-000000000000	5b08efa5-e669-4301-a207-f144b48c56bf	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 16:51:02.438152+00	
00000000-0000-0000-0000-000000000000	e2f7828b-fae0-41cf-bdc6-e7a50886052c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 16:51:02.454962+00	
00000000-0000-0000-0000-000000000000	34a651b7-565b-436c-9de5-e5761568613b	{"action":"login","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 17:03:14.504024+00	
00000000-0000-0000-0000-000000000000	500be8f8-d257-4292-80d3-b4491b650156	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 19:01:28.678932+00	
00000000-0000-0000-0000-000000000000	c363ccae-3993-4645-80e1-6dab91bd42b2	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 19:01:28.696237+00	
00000000-0000-0000-0000-000000000000	614fe83b-5c3a-4e4d-a92a-343a7b22d3ff	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 20:00:50.323641+00	
00000000-0000-0000-0000-000000000000	566560cb-73d9-488f-bd04-cc203c201532	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-04 20:00:50.330753+00	
00000000-0000-0000-0000-000000000000	f9d9e0fe-49f6-4880-acc4-6d9c964d394f	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-06 15:32:57.860382+00	
00000000-0000-0000-0000-000000000000	42d2bece-eeb2-4fa2-8747-1bb0068618d9	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-06 15:32:57.882436+00	
00000000-0000-0000-0000-000000000000	0b9e4bc7-2484-4f8f-9128-7773c91bd766	{"action":"token_refreshed","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-08 22:02:27.296516+00	
00000000-0000-0000-0000-000000000000	9296219a-e84a-48ec-a5f7-290372b7851c	{"action":"token_revoked","actor_id":"3a90fa1a-c502-40ab-8d7a-3fff14060570","actor_username":"ynlldom@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-08 22:02:27.318875+00	
00000000-0000-0000-0000-000000000000	850dbbde-d835-437f-9150-f54b164fbbe4	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:05:52.201224+00	
00000000-0000-0000-0000-000000000000	9993aa24-6eb4-4de8-b6d9-803a2285be95	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:06:25.608454+00	
00000000-0000-0000-0000-000000000000	d7b8e870-b09e-477f-a987-bfc0396344c0	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:08:21.603432+00	
00000000-0000-0000-0000-000000000000	b61057a8-03cb-47f7-a83a-5e1b4d7402c5	{"action":"logout","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-08 22:12:42.920645+00	
00000000-0000-0000-0000-000000000000	dabf827b-fc67-41fc-a6fb-b64d38a41217	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:12:46.715926+00	
00000000-0000-0000-0000-000000000000	0dbec80a-2e34-4b27-ab83-8b96dcf22e26	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:13:04.087415+00	
00000000-0000-0000-0000-000000000000	5f2d661e-69f3-4738-ad5d-c6ea6e43bcf7	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:13:23.581852+00	
00000000-0000-0000-0000-000000000000	8258e869-db30-4b1e-b6e9-4e35f641634d	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:13:39.059784+00	
00000000-0000-0000-0000-000000000000	5d81a299-73bf-4b44-bb76-26e4bfbafc3c	{"action":"logout","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-08 22:20:14.325484+00	
00000000-0000-0000-0000-000000000000	ad8d24af-297f-4ee4-9c3f-0eb55f2737f8	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:23:28.836763+00	
00000000-0000-0000-0000-000000000000	e408e327-b8ce-4ffe-9102-0ce1246945f4	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:23:55.256945+00	
00000000-0000-0000-0000-000000000000	37b954bb-0a90-462c-abd1-5da67858aa17	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:24:31.340005+00	
00000000-0000-0000-0000-000000000000	076aeb93-fbc5-45f1-8ec8-6e7861448963	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-08 22:26:45.724754+00	
00000000-0000-0000-0000-000000000000	98291079-92a1-44b8-9221-602284b33c91	{"action":"token_refreshed","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-09 15:59:32.527097+00	
00000000-0000-0000-0000-000000000000	d2b6c0ff-21aa-4010-a7e8-371de81d2d0d	{"action":"token_revoked","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-06-09 15:59:32.554323+00	
00000000-0000-0000-0000-000000000000	c578fab3-8c85-4903-8fa3-096ab6572a22	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-09 16:00:59.475549+00	
00000000-0000-0000-0000-000000000000	66d122ca-6ecd-4995-ba18-85d4761abb04	{"action":"logout","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-09 16:01:15.33246+00	
00000000-0000-0000-0000-000000000000	9d00fa66-39b3-4197-8f12-b44166477fb7	{"action":"login","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-09 16:29:41.726361+00	
00000000-0000-0000-0000-000000000000	d890f246-0cc0-485a-83ff-34add5c3c913	{"action":"logout","actor_id":"14076186-432f-49f8-87c2-093a3ae9804f","actor_username":"paolamerly1@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-06-09 16:53:36.809716+00	
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
3a90fa1a-c502-40ab-8d7a-3fff14060570	3a90fa1a-c502-40ab-8d7a-3fff14060570	{"rol": "visitante", "sub": "3a90fa1a-c502-40ab-8d7a-3fff14060570", "email": "ynlldom@gmail.com", "nombre": "Administrador", "email_verified": true, "phone_verified": false}	email	2025-10-18 21:23:06.582697+00	2025-10-18 21:23:06.582764+00	2025-10-18 21:23:06.582764+00	6e9056d3-bddc-4d5a-85f0-f8ee0a9ab3e7
e26adb54-7dcd-48a7-96c9-df6604bed15a	e26adb54-7dcd-48a7-96c9-df6604bed15a	{"rol": "visitante", "sub": "e26adb54-7dcd-48a7-96c9-df6604bed15a", "email": "arteagayanelly23@gmail.com", "nombre": "estudiante 1", "email_verified": true, "phone_verified": false}	email	2025-10-20 23:07:38.905953+00	2025-10-20 23:07:38.906562+00	2025-10-20 23:07:38.906562+00	e3280735-c9b9-4ec6-aa7c-018c79ddc3a6
0e773dca-0696-446d-8700-d934e7cd5151	0e773dca-0696-446d-8700-d934e7cd5151	{"rol": "visitante", "sub": "0e773dca-0696-446d-8700-d934e7cd5151", "email": "tatiana.zambrano@utm.edu.ec", "nombre": "Tatiana Zambrano", "email_verified": true, "phone_verified": false}	email	2025-10-21 13:22:28.326156+00	2025-10-21 13:22:28.326216+00	2025-10-21 13:22:28.326216+00	f50959d9-a704-40c4-a49c-4c1e3b0c4ab3
a721cb76-7b06-4025-afed-d62c9f579550	a721cb76-7b06-4025-afed-d62c9f579550	{"rol": "estudiante", "sub": "a721cb76-7b06-4025-afed-d62c9f579550", "email": "yanellyart@didactikapp.com", "nombre": "Yanelly Arteaga", "usuario": "yanellyart", "email_verified": false, "phone_verified": false}	email	2026-01-19 03:49:52.11786+00	2026-01-19 03:49:52.118403+00	2026-01-19 03:49:52.118403+00	829369a8-183a-4b5e-9366-6202a57878fd
84d3eaaf-2a36-42c4-b3e5-b93ac3fe9ae9	84d3eaaf-2a36-42c4-b3e5-b93ac3fe9ae9	{"rol": "estudiante", "sub": "84d3eaaf-2a36-42c4-b3e5-b93ac3fe9ae9", "email": "yarteaga23@didactikapp.com", "nombre": "Yanelly Arteaga", "usuario": "yarteaga23", "email_verified": false, "phone_verified": false}	email	2026-01-19 04:01:33.544387+00	2026-01-19 04:01:33.545127+00	2026-01-19 04:01:33.545127+00	eb395a02-9c2b-4a94-b5f4-973a96a605e5
233d26ed-f72e-4ff7-b859-2b8b48b8c6b3	233d26ed-f72e-4ff7-b859-2b8b48b8c6b3	{"rol": "estudiante", "sub": "233d26ed-f72e-4ff7-b859-2b8b48b8c6b3", "email": "merart@didactikapp.com", "nombre": "Mercedes Arteaga", "usuario": "merart", "email_verified": false, "phone_verified": false}	email	2026-01-19 04:07:42.018348+00	2026-01-19 04:07:42.018404+00	2026-01-19 04:07:42.018404+00	7b514bb8-5685-4667-a64c-587bb6bf9a9b
ecfe53a4-3b92-472e-bcf0-f77807681f84	ecfe53a4-3b92-472e-bcf0-f77807681f84	{"rol": "estudiante", "sub": "ecfe53a4-3b92-472e-bcf0-f77807681f84", "email": "kengart@didactikapp.com", "nombre": "Kevin Arteaga", "usuario": "kengart", "email_verified": false, "phone_verified": false}	email	2026-01-19 04:11:08.616828+00	2026-01-19 04:11:08.616878+00	2026-01-19 04:11:08.616878+00	2bfa7f15-bc08-4226-8fc7-0537ed083bda
9d0f2934-0bf1-4eae-9fa4-234870fb66cb	9d0f2934-0bf1-4eae-9fa4-234870fb66cb	{"rol": "estudiante", "sub": "9d0f2934-0bf1-4eae-9fa4-234870fb66cb", "email": "danivm@didactikapp.com", "nombre": "Daniela Villamarin", "usuario": "danivm", "email_verified": false, "phone_verified": false}	email	2026-01-19 04:21:18.533715+00	2026-01-19 04:21:18.535042+00	2026-01-19 04:21:18.535042+00	6bf143df-73ec-4b62-a8a8-3f0552db4983
d1fd4826-8e5a-4cae-9222-aef526df4961	d1fd4826-8e5a-4cae-9222-aef526df4961	{"rol": "estudiante", "sub": "d1fd4826-8e5a-4cae-9222-aef526df4961", "email": "estudiante1@didactikapp.com", "nombre": "Estudiante1", "usuario": "estudiante1", "email_verified": false, "phone_verified": false}	email	2026-01-19 18:51:24.3364+00	2026-01-19 18:51:24.336451+00	2026-01-19 18:51:24.336451+00	2e72e9f6-3f34-4ac1-b67e-eda2dd17f940
e836b53c-0eb8-4c93-9e8c-e972aab5b995	e836b53c-0eb8-4c93-9e8c-e972aab5b995	{"rol": "estudiante", "sub": "e836b53c-0eb8-4c93-9e8c-e972aab5b995", "email": "estudiante1@didactikapp.local", "nombre": "Estudiante1", "usuario": "estudiante1", "email_verified": false, "phone_verified": false}	email	2026-01-19 19:02:23.628653+00	2026-01-19 19:02:23.631135+00	2026-01-19 19:02:23.631135+00	d3ab18c1-a32a-4168-a3a5-7c69034c4ebd
55db67b3-bc35-4671-81f3-a996a5350425	55db67b3-bc35-4671-81f3-a996a5350425	{"rol": "estudiante", "sub": "55db67b3-bc35-4671-81f3-a996a5350425", "email": "estudiante2@didactikapp.com", "nombre": "Estudiante2", "usuario": "estudiante2", "email_verified": false, "phone_verified": false}	email	2026-01-19 19:06:30.719008+00	2026-01-19 19:06:30.719107+00	2026-01-19 19:06:30.719107+00	889dbfbb-8585-430b-aeb9-74c01595a965
009551f7-f973-4e33-82c5-cc7f2171e07f	009551f7-f973-4e33-82c5-cc7f2171e07f	{"rol": "estudiante", "sub": "009551f7-f973-4e33-82c5-cc7f2171e07f", "email": "estudiante3@didactikapp.com", "nombre": "Estudiante3", "usuario": "estudiante3", "email_verified": false, "phone_verified": false}	email	2026-01-19 19:08:45.442366+00	2026-01-19 19:08:45.442427+00	2026-01-19 19:08:45.442427+00	55635e40-f4cb-4642-a1f7-b51653c6ed8f
27226334-0bfb-4d86-9a02-1fe3763995ed	27226334-0bfb-4d86-9a02-1fe3763995ed	{"rol": "estudiante", "sub": "27226334-0bfb-4d86-9a02-1fe3763995ed", "email": "estudiante4@didactikapp.com", "nombre": "Estudiante4", "usuario": "estudiante4", "email_verified": false, "phone_verified": false}	email	2026-01-19 19:12:47.318005+00	2026-01-19 19:12:47.31806+00	2026-01-19 19:12:47.31806+00	20230877-f8f9-4320-b233-cf7404f3c6a8
6bd6fd48-7433-4526-8803-516660c1103a	6bd6fd48-7433-4526-8803-516660c1103a	{"rol": "estudiante", "sub": "6bd6fd48-7433-4526-8803-516660c1103a", "email": "mer123@didactikapp.com", "nombre": "Merly Zambrannn", "usuario": "mer123", "grupo_id": "d305e415-7036-4bbb-ae94-af93c858d220", "email_verified": false, "phone_verified": false}	email	2026-01-22 16:27:29.966668+00	2026-01-22 16:27:29.966729+00	2026-01-22 16:27:29.966729+00	539adf8e-b9a9-4fa7-bf94-773474c82a22
db36010b-60f9-4d38-bfd1-1fd9063149d7	db36010b-60f9-4d38-bfd1-1fd9063149d7	{"rol": "estudiante", "sub": "db36010b-60f9-4d38-bfd1-1fd9063149d7", "email": "spidergay@didactikapp.com", "nombre": "sneyder", "usuario": "spidergay", "grupo_id": null, "email_verified": false, "phone_verified": false}	email	2026-01-29 04:18:36.386132+00	2026-01-29 04:18:36.386186+00	2026-01-29 04:18:36.386186+00	ba66630a-b26d-47b7-9682-60fca25a43c8
e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4	e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4	{"rol": "estudiante", "sub": "e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4", "email": "estudiante5@didactikapp.com", "nombre": "estudiante5", "usuario": "estudiante5", "grupo_id": "3c37d832-e781-44e8-bf45-e4a82e42ae72", "email_verified": false, "phone_verified": false}	email	2026-02-09 04:07:36.165885+00	2026-02-09 04:07:36.165939+00	2026-02-09 04:07:36.165939+00	24887584-f2fa-4b97-91ff-73b18e5702b3
e6059964-8108-4ff1-a812-f6eca0cbd3f7	e6059964-8108-4ff1-a812-f6eca0cbd3f7	{"rol": "estudiante", "sub": "e6059964-8108-4ff1-a812-f6eca0cbd3f7", "email": "miaalava@didactikapp.com", "nombre": "Mia Fiorella Alava Pin", "usuario": "miaalava", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 13:46:49.857803+00	2026-02-09 13:46:49.857853+00	2026-02-09 13:46:49.857853+00	360faac4-8a08-4874-948c-124ce0734a3a
0aff3647-bda6-48f4-9e6a-4bf9d1f9e118	0aff3647-bda6-48f4-9e6a-4bf9d1f9e118	{"rol": "estudiante", "sub": "0aff3647-bda6-48f4-9e6a-4bf9d1f9e118", "email": "donobansarangundi@didactikapp.com", "nombre": "Donoban S Arangundi Criollo", "usuario": "donobansarangundi", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 13:48:17.2956+00	2026-02-09 13:48:17.295647+00	2026-02-09 13:48:17.295647+00	58043681-7fe5-46e8-beac-4b0c662257a7
5d623cd2-7471-4ffc-8341-f55de82f5b7c	5d623cd2-7471-4ffc-8341-f55de82f5b7c	{"rol": "estudiante", "sub": "5d623cd2-7471-4ffc-8341-f55de82f5b7c", "email": "renathaarteaga@didactikapp.com", "nombre": "Renatha Isabella Arteaga Cedeño", "usuario": "renathaarteaga", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 13:50:12.507801+00	2026-02-09 13:50:12.507845+00	2026-02-09 13:50:12.507845+00	0e8c28dc-af59-4fcc-adae-ef651428629f
a6a516f4-345e-4af4-a95d-fcab95a375c4	a6a516f4-345e-4af4-a95d-fcab95a375c4	{"rol": "estudiante", "sub": "a6a516f4-345e-4af4-a95d-fcab95a375c4", "email": "pedrocampos@didactikapp.com", "nombre": "Pedro Elias Campos Chiguita", "usuario": "pedrocampos", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 13:51:32.718969+00	2026-02-09 13:51:32.719016+00	2026-02-09 13:51:32.719016+00	a52553fb-749f-4184-b637-3e71949c9ce9
1326d366-a9f6-4216-9395-fb904afcb5eb	1326d366-a9f6-4216-9395-fb904afcb5eb	{"rol": "estudiante", "sub": "1326d366-a9f6-4216-9395-fb904afcb5eb", "email": "josechavez@didactikapp.com", "nombre": "Jose Ramon Chavez Rivas", "usuario": "josechavez", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 13:54:55.645998+00	2026-02-09 13:54:55.646049+00	2026-02-09 13:54:55.646049+00	798c81f6-04f3-4108-a531-1bda3ce8ba0f
28f6c2fe-742e-4188-b53d-700ba85aec4c	28f6c2fe-742e-4188-b53d-700ba85aec4c	{"rol": "estudiante", "sub": "28f6c2fe-742e-4188-b53d-700ba85aec4c", "email": "juandavidcarreno@didactikapp.com", "nombre": "Juan David Carreño Guatarama", "usuario": "juandavidcarreno", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 14:36:25.306636+00	2026-02-09 14:36:25.306688+00	2026-02-09 14:36:25.306688+00	073b0cc1-6fad-4572-b577-a837fdff0010
88bbd661-7479-4a84-b9ef-4f32da93ff26	88bbd661-7479-4a84-b9ef-4f32da93ff26	{"rol": "estudiante", "sub": "88bbd661-7479-4a84-b9ef-4f32da93ff26", "email": "ainhoachavez@didactikapp.com", "nombre": "Ainhoa Kaitlin Chavez Palma", "usuario": "ainhoachavez", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 14:40:47.135811+00	2026-02-09 14:40:47.135859+00	2026-02-09 14:40:47.135859+00	417b747d-d103-4ab3-a978-d5b8ed85210f
ce486e2e-89f5-49ed-91f1-95c760d9e602	ce486e2e-89f5-49ed-91f1-95c760d9e602	{"rol": "visitante", "sub": "ce486e2e-89f5-49ed-91f1-95c760d9e602", "email": "puchi.merart@gmail.com", "nombre": "Merly", "email_verified": false, "phone_verified": false}	email	2026-06-02 02:52:01.562291+00	2026-06-02 02:52:01.562358+00	2026-06-02 02:52:01.562358+00	dbb3caa5-3044-462b-8957-c691dc1dadc2
7b542b46-6fbd-4176-bbbb-5cf594c49da2	7b542b46-6fbd-4176-bbbb-5cf594c49da2	{"rol": "estudiante", "sub": "7b542b46-6fbd-4176-bbbb-5cf594c49da2", "email": "luischilan@didactikapp.com", "nombre": "Luis Sebastian Chilan Bachicorea", "usuario": "luischilan", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 14:45:35.264469+00	2026-02-09 14:45:35.264521+00	2026-02-09 14:45:35.264521+00	b3b0bd32-9101-446c-be0e-781bd68f3255
6c94d34d-5856-4649-8998-7eb1090fdf09	6c94d34d-5856-4649-8998-7eb1090fdf09	{"rol": "estudiante", "sub": "6c94d34d-5856-4649-8998-7eb1090fdf09", "email": "matheochilan@didactikapp.com", "nombre": "Matheo Leonel Chilan Pinargote", "usuario": "matheochilan", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 14:47:13.844156+00	2026-02-09 14:47:13.844204+00	2026-02-09 14:47:13.844204+00	73277e29-0f32-41de-bbe9-d423f93a3f78
811c750f-97ad-4705-8156-9cdf28b37323	811c750f-97ad-4705-8156-9cdf28b37323	{"rol": "estudiante", "sub": "811c750f-97ad-4705-8156-9cdf28b37323", "email": "sashachilan@didactikapp.com", "nombre": "Sasha Ariana Chilan Posligua", "usuario": "sashachilan", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 14:48:57.128324+00	2026-02-09 14:48:57.128371+00	2026-02-09 14:48:57.128371+00	a7d85dba-6cee-4c8b-aeae-e6980d40f2e6
75424ae3-8fbd-4752-8c5c-2bb5e38be82f	75424ae3-8fbd-4752-8c5c-2bb5e38be82f	{"rol": "estudiante", "sub": "75424ae3-8fbd-4752-8c5c-2bb5e38be82f", "email": "guillermofernandez@didactikapp.com", "nombre": "Guillermo F Fernandez Alcivar", "usuario": "guillermofernandez", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 14:50:48.031317+00	2026-02-09 14:50:48.031363+00	2026-02-09 14:50:48.031363+00	391bea1b-c2d3-4ae7-b0bb-33e18e1a4a3f
520498cc-f65a-42a2-97b6-22f766b06cfc	520498cc-f65a-42a2-97b6-22f766b06cfc	{"rol": "estudiante", "sub": "520498cc-f65a-42a2-97b6-22f766b06cfc", "email": "ahitannamiley@didactikapp.com", "nombre": "Mendoza", "usuario": "ahitannamiley", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 14:53:18.221406+00	2026-02-09 14:53:18.221456+00	2026-02-09 14:53:18.221456+00	83bc0b6f-baeb-4e08-b889-d33d199f0040
ba0d8cac-1ab0-4319-86cd-6e9840a12111	ba0d8cac-1ab0-4319-86cd-6e9840a12111	{"rol": "estudiante", "sub": "ba0d8cac-1ab0-4319-86cd-6e9840a12111", "email": "ahitannamileylaz@didactikapp.com", "nombre": "Ahitanna Miley Laz Mendoza", "usuario": "ahitannamileylaz", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 14:56:44.605099+00	2026-02-09 14:56:44.605149+00	2026-02-09 14:56:44.605149+00	7747df7a-e26c-4a47-82c1-dce3f3c18c05
d39fd319-3593-4ddc-840a-5a89f73a3d75	d39fd319-3593-4ddc-840a-5a89f73a3d75	{"rol": "estudiante", "sub": "d39fd319-3593-4ddc-840a-5a89f73a3d75", "email": "sophiemala@didactikapp.com", "nombre": "Sophie Monserrat Mala Palma", "usuario": "sophiemala", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 14:58:09.19135+00	2026-02-09 14:58:09.191396+00	2026-02-09 14:58:09.191396+00	54f144d8-8fb3-412c-a698-f7767773d0f9
2e05a86b-6966-4266-a17a-cedc2aad1567	2e05a86b-6966-4266-a17a-cedc2aad1567	{"rol": "estudiante", "sub": "2e05a86b-6966-4266-a17a-cedc2aad1567", "email": "jimmymedranda@didactikapp.com", "nombre": "Jimmy Jael Medranda Pico", "usuario": "jimmymedranda", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 15:00:31.427544+00	2026-02-09 15:00:31.427589+00	2026-02-09 15:00:31.427589+00	9bd91436-a5f5-4ccf-a325-860312924d72
a12584c4-19a5-4716-83d9-e0bb42fbf002	a12584c4-19a5-4716-83d9-e0bb42fbf002	{"rol": "estudiante", "sub": "a12584c4-19a5-4716-83d9-e0bb42fbf002", "email": "tiagomendoza@didactikapp.com", "nombre": "Tiago Alexander Mendoza Reina", "usuario": "tiagomendoza", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 15:02:13.328545+00	2026-02-09 15:02:13.328592+00	2026-02-09 15:02:13.328592+00	518409e3-17bd-411b-9799-bf9c45e948b8
e180edb5-9a66-4602-9e4a-17a4c9c70d92	e180edb5-9a66-4602-9e4a-17a4c9c70d92	{"rol": "estudiante", "sub": "e180edb5-9a66-4602-9e4a-17a4c9c70d92", "email": "gaelmiranda@didactikapp.com", "nombre": "Gael Dominic Miranda Laz", "usuario": "gaelmiranda", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 15:04:53.469523+00	2026-02-09 15:04:53.469571+00	2026-02-09 15:04:53.469571+00	eba57a07-76c9-4595-88f8-35c87b19e137
d81fa5d0-b828-47be-bf4f-d04e151c937f	d81fa5d0-b828-47be-bf4f-d04e151c937f	{"rol": "estudiante", "sub": "d81fa5d0-b828-47be-bf4f-d04e151c937f", "email": "ailenmolina@didactikapp.com", "nombre": "Ailen Dariela Molina Palma", "usuario": "ailenmolina", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 15:07:00.878796+00	2026-02-09 15:07:00.87884+00	2026-02-09 15:07:00.87884+00	4278b5c6-46e3-4e94-8af4-e536fceea6e8
f681ddbe-c67f-44f1-9969-31b64b4c879a	f681ddbe-c67f-44f1-9969-31b64b4c879a	{"rol": "estudiante", "sub": "f681ddbe-c67f-44f1-9969-31b64b4c879a", "email": "keylamolina@didactikapp.com", "nombre": "Keyla Oana Molina Garcia", "usuario": "keylamolina", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 15:07:53.544543+00	2026-02-09 15:07:53.544585+00	2026-02-09 15:07:53.544585+00	a0412271-98fd-4ccf-b055-81ad035541d2
00aff592-6206-428c-9476-2ca0e5c985bf	00aff592-6206-428c-9476-2ca0e5c985bf	{"rol": "estudiante", "sub": "00aff592-6206-428c-9476-2ca0e5c985bf", "email": "marielmolina@didactikapp.com", "nombre": "Mariel Sarahi Molina Vera", "usuario": "marielmolina", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 15:08:45.91086+00	2026-02-09 15:08:45.910907+00	2026-02-09 15:08:45.910907+00	d116c971-c8e9-411a-9305-bb97ec4e647b
f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e	f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e	{"rol": "estudiante", "sub": "f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e", "email": "damarispalacios@didactikapp.com", "nombre": "Damaris Sophia Palacios Lopez", "usuario": "damarispalacios", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 15:12:41.573685+00	2026-02-09 15:12:41.573731+00	2026-02-09 15:12:41.573731+00	d27fc0c0-da16-4657-80b1-35c33bd99a3b
2244697e-3126-4d57-af2d-ab28686fc83d	2244697e-3126-4d57-af2d-ab28686fc83d	{"rol": "estudiante", "sub": "2244697e-3126-4d57-af2d-ab28686fc83d", "email": "yuliethrivas@didactikapp.com", "nombre": "Yulieth Paulette Rivas Palma", "usuario": "yuliethrivas", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 15:16:15.43211+00	2026-02-09 15:16:15.432154+00	2026-02-09 15:16:15.432154+00	a73c2350-82b2-4280-959a-24bc9229a3d1
11133b74-e96b-46b7-9c9c-585824841fe6	11133b74-e96b-46b7-9c9c-585824841fe6	{"rol": "estudiante", "sub": "11133b74-e96b-46b7-9c9c-585824841fe6", "email": "dayrapalma@didactikapp.com", "nombre": "Dayra Iveth Palma Alarcon", "usuario": "dayrapalma", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-09 15:27:55.149601+00	2026-02-09 15:27:55.149645+00	2026-02-09 15:27:55.149645+00	b8e45ef8-0d9f-4061-93a8-ce8d3a7f61b3
9247ea7b-2d1d-45b3-b037-6ec04945be81	9247ea7b-2d1d-45b3-b037-6ec04945be81	{"rol": "estudiante", "sub": "9247ea7b-2d1d-45b3-b037-6ec04945be81", "email": "arisleyalava@didactikapp.com", "nombre": "Arisley Ahinoa Alava Arteaga", "usuario": "arisleyalava", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:17:41.266602+00	2026-02-10 15:17:41.266653+00	2026-02-10 15:17:41.266653+00	bdadbfcc-86c6-4ea0-88ce-0ef9e5f9f1b4
07698bac-d8fb-4e65-982d-27c4d482f909	07698bac-d8fb-4e65-982d-27c4d482f909	{"rol": "estudiante", "sub": "07698bac-d8fb-4e65-982d-27c4d482f909", "email": "yasbethbarrezueta@didactikapp.com", "nombre": "Yasbeth Fiorela Barrezueta Cano", "usuario": "yasbethbarrezueta", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:19:35.842527+00	2026-02-10 15:19:35.843202+00	2026-02-10 15:19:35.843202+00	b4e03793-b1f6-48ee-ac36-907a89740537
b60a73bd-7f4b-4062-8407-62cefee3b0d0	b60a73bd-7f4b-4062-8407-62cefee3b0d0	{"rol": "estudiante", "sub": "b60a73bd-7f4b-4062-8407-62cefee3b0d0", "email": "juantuala@didactikapp.com", "nombre": "Juan Issac Buste Tuala", "usuario": "juantuala", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:20:39.545422+00	2026-02-10 15:20:39.54547+00	2026-02-10 15:20:39.54547+00	f9f6fbf4-18e6-4e9f-9443-37e1a33331ee
9b07c741-12ea-4816-83ff-6eec722cd7da	9b07c741-12ea-4816-83ff-6eec722cd7da	{"rol": "estudiante", "sub": "9b07c741-12ea-4816-83ff-6eec722cd7da", "email": "roselinecedeno@didactikapp.com", "nombre": "Roselyne Elizabeth Cedeño Posligua", "usuario": "roselinecedeno", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:22:17.303458+00	2026-02-10 15:22:17.303505+00	2026-02-10 15:22:17.303505+00	b7f713e7-1473-4fd5-b06d-5f52f24a0e76
8faf560f-ba50-4fc1-b96c-384072c80c90	8faf560f-ba50-4fc1-b96c-384072c80c90	{"rol": "estudiante", "sub": "8faf560f-ba50-4fc1-b96c-384072c80c90", "email": "josedelgado@didactikapp.com", "nombre": "Jose Gerardo Delgado Molina", "usuario": "josedelgado", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:23:20.864239+00	2026-02-10 15:23:20.864289+00	2026-02-10 15:23:20.864289+00	4765d864-6f05-439d-815a-b0a522dfc26e
18a33406-19e8-4e01-a292-bf1cd1af8c65	18a33406-19e8-4e01-a292-bf1cd1af8c65	{"rol": "estudiante", "sub": "18a33406-19e8-4e01-a292-bf1cd1af8c65", "email": "edisongarcia@didactikapp.com", "nombre": "Edison Gabriel Garcia Tuala", "usuario": "edisongarcia", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:24:03.500638+00	2026-02-10 15:24:03.500685+00	2026-02-10 15:24:03.500685+00	f99e0b1e-1c82-4cff-804e-7066c2d8105d
771ad79b-34ce-4812-9d05-3914d9ada480	771ad79b-34ce-4812-9d05-3914d9ada480	{"rol": "estudiante", "sub": "771ad79b-34ce-4812-9d05-3914d9ada480", "email": "maytehormaza@didactikapp.com", "nombre": "Andrainna Mayte Hormaza Falconez", "usuario": "maytehormaza", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:25:15.76648+00	2026-02-10 15:25:15.766532+00	2026-02-10 15:25:15.766532+00	c7e92309-ad93-4d78-b96b-37e01c12535e
23830ef8-baf0-4b79-bae5-b8c2cfda4931	23830ef8-baf0-4b79-bae5-b8c2cfda4931	{"rol": "estudiante", "sub": "23830ef8-baf0-4b79-bae5-b8c2cfda4931", "email": "dekerlaz@didactikapp.com", "nombre": "Deker jose Laz Rodriguez", "usuario": "dekerlaz", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:26:28.120104+00	2026-02-10 15:26:28.120151+00	2026-02-10 15:26:28.120151+00	593139c9-3d29-4412-89fe-9ca1a261cab2
7524e67f-698f-40b6-8424-26f05bac35e1	7524e67f-698f-40b6-8424-26f05bac35e1	{"rol": "estudiante", "sub": "7524e67f-698f-40b6-8424-26f05bac35e1", "email": "samaramarin@didactikapp.com", "nombre": "Samara Sherazade Marin Laz", "usuario": "samaramarin", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:27:16.053842+00	2026-02-10 15:27:16.053883+00	2026-02-10 15:27:16.053883+00	f3427174-58b5-4069-9b12-e26021a70256
02d3430e-9601-4b3b-a6d6-e9390872b54b	02d3430e-9601-4b3b-a6d6-e9390872b54b	{"rol": "estudiante", "sub": "02d3430e-9601-4b3b-a6d6-e9390872b54b", "email": "jostinmolina@didactikapp.com", "nombre": "Jostin Yeriel Molina Angulo", "usuario": "jostinmolina", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:28:14.395644+00	2026-02-10 15:28:14.395694+00	2026-02-10 15:28:14.395694+00	1803fd50-02c0-4dac-b9c2-be3a92640384
f5def64f-2c9e-4165-9302-4c4870991dad	f5def64f-2c9e-4165-9302-4c4870991dad	{"rol": "estudiante", "sub": "f5def64f-2c9e-4165-9302-4c4870991dad", "email": "mariamoreira@didactikapp.com", "nombre": "Maria Jose Moreira Vera", "usuario": "mariamoreira", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:29:01.452526+00	2026-02-10 15:29:01.452569+00	2026-02-10 15:29:01.452569+00	fa4ff4f0-1c4d-4330-ab76-84682083e75d
9b79fcf6-f192-4364-80ec-ab95b18c87e3	9b79fcf6-f192-4364-80ec-ab95b18c87e3	{"rol": "estudiante", "sub": "9b79fcf6-f192-4364-80ec-ab95b18c87e3", "email": "ashleymurillo@didactikapp.com", "nombre": "Ashley Krilley Murillo Mantuano", "usuario": "ashleymurillo", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:29:58.852626+00	2026-02-10 15:29:58.852672+00	2026-02-10 15:29:58.852672+00	f6685d1d-2fda-41b0-9ed1-d369aa85cc5b
4ba36fc8-7010-4374-96b4-51d95257be5a	4ba36fc8-7010-4374-96b4-51d95257be5a	{"rol": "estudiante", "sub": "4ba36fc8-7010-4374-96b4-51d95257be5a", "email": "moisespalma@didactikapp.com", "nombre": "Moises Oseias Palma Correa", "usuario": "moisespalma", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:30:40.112704+00	2026-02-10 15:30:40.112744+00	2026-02-10 15:30:40.112744+00	880504d6-b4b2-4ed5-b9bd-f8ddf711a002
7bab67c8-74d3-4a9e-a2b1-990223186d4e	7bab67c8-74d3-4a9e-a2b1-990223186d4e	{"rol": "estudiante", "sub": "7bab67c8-74d3-4a9e-a2b1-990223186d4e", "email": "miapalma@didactikapp.com", "nombre": "Mia Fiorella Palma Laz", "usuario": "miapalma", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:31:18.334169+00	2026-02-10 15:31:18.334218+00	2026-02-10 15:31:18.334218+00	b92e3a19-c036-47a4-ac50-b67e3f328722
1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7	1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7	{"rol": "estudiante", "sub": "1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7", "email": "enzopalmas@didactikapp.com", "nombre": "Enzo Mathias Palmas Menendez", "usuario": "enzopalmas", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:32:18.865701+00	2026-02-10 15:32:18.865749+00	2026-02-10 15:32:18.865749+00	0f841361-8a37-4e8e-b0e4-feca2c7a662e
47739d07-5148-4e33-9aee-d236406d760e	47739d07-5148-4e33-9aee-d236406d760e	{"rol": "estudiante", "sub": "47739d07-5148-4e33-9aee-d236406d760e", "email": "raulpalma@didactikapp.com", "nombre": "Raul Felipe Palma Vera", "usuario": "raulpalma", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:32:55.883434+00	2026-02-10 15:32:55.883479+00	2026-02-10 15:32:55.883479+00	bff4b8ba-b29a-4da5-a99d-b6d130a17318
d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03	d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03	{"rol": "estudiante", "sub": "d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03", "email": "ninoskapin@didactikapp.com", "nombre": "Ninoska Yurani Pin Molina", "usuario": "ninoskapin", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:34:02.265388+00	2026-02-10 15:34:02.265435+00	2026-02-10 15:34:02.265435+00	499bd396-6ffc-4cc2-bc35-9f6d30a1eeac
40e4b506-1d73-4298-8d8b-2011f8e24bef	40e4b506-1d73-4298-8d8b-2011f8e24bef	{"rol": "estudiante", "sub": "40e4b506-1d73-4298-8d8b-2011f8e24bef", "email": "dereckpinargote@didactikapp.com", "nombre": "Dereck Joel Pinargote Cordoba", "usuario": "dereckpinargote", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:34:51.32423+00	2026-02-10 15:34:51.324274+00	2026-02-10 15:34:51.324274+00	4a077183-1c9d-42f7-9fda-850f565216cf
8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8	8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8	{"rol": "estudiante", "sub": "8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8", "email": "domenicaponce@didactikapp.com", "nombre": "Domenica Adamaris Ponce España", "usuario": "domenicaponce", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:35:47.044512+00	2026-02-10 15:35:47.044555+00	2026-02-10 15:35:47.044555+00	66fed0d4-c0f7-4407-9fae-533b977f4990
83bb0944-5672-4759-b72b-37deea537a47	83bb0944-5672-4759-b72b-37deea537a47	{"rol": "estudiante", "sub": "83bb0944-5672-4759-b72b-37deea537a47", "email": "joseposligua@didactikapp.com", "nombre": "Jose Antonio Posligua Chilan", "usuario": "joseposligua", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:36:26.885642+00	2026-02-10 15:36:26.885684+00	2026-02-10 15:36:26.885684+00	a76fc83d-7994-4f67-9aff-9cf75d1ad579
5dc9910f-4d2e-4fae-8907-0fe3b596cde0	5dc9910f-4d2e-4fae-8907-0fe3b596cde0	{"rol": "estudiante", "sub": "5dc9910f-4d2e-4fae-8907-0fe3b596cde0", "email": "gregorioposligua@didactikapp.com", "nombre": "Gregorio Xavier Posligua Tejena", "usuario": "gregorioposligua", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:37:15.549216+00	2026-02-10 15:37:15.549261+00	2026-02-10 15:37:15.549261+00	7902cfb7-c65c-432b-824e-bf1654d271fb
937926f9-3c6b-46d2-9cf3-341479442747	937926f9-3c6b-46d2-9cf3-341479442747	{"rol": "estudiante", "sub": "937926f9-3c6b-46d2-9cf3-341479442747", "email": "carlosreyes@didactikapp.com", "nombre": "Carlos Mathias Reyes Loor", "usuario": "carlosreyes", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:38:11.875371+00	2026-02-10 15:38:11.875415+00	2026-02-10 15:38:11.875415+00	25e0f235-1877-4509-8c13-335e438c9fd2
27356752-78d4-4833-bdbc-ac5ceb23883e	27356752-78d4-4833-bdbc-ac5ceb23883e	{"rol": "estudiante", "sub": "27356752-78d4-4833-bdbc-ac5ceb23883e", "email": "emmarivas@didactikapp.com", "nombre": "Emma Asuncion Rivas Barcia", "usuario": "emmarivas", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:40:40.917771+00	2026-02-10 15:40:40.917817+00	2026-02-10 15:40:40.917817+00	601355e7-69c4-410a-9985-8799b408aa91
d656273e-e4fe-448d-9aa1-7e87839688d6	d656273e-e4fe-448d-9aa1-7e87839688d6	{"rol": "estudiante", "sub": "d656273e-e4fe-448d-9aa1-7e87839688d6", "email": "jusneyrivas@didactikapp.com", "nombre": "Jusney Joel Rivas Chilan", "usuario": "jusneyrivas", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:41:30.211408+00	2026-02-10 15:41:30.211454+00	2026-02-10 15:41:30.211454+00	c2d789af-4c2f-41f8-a7b7-6610d601b184
a883d161-ec1f-497b-91c6-16543a922792	a883d161-ec1f-497b-91c6-16543a922792	{"rol": "estudiante", "sub": "a883d161-ec1f-497b-91c6-16543a922792", "email": "lizsanchez@didactikapp.com", "nombre": "Liz Maria Sanchez Rivas", "usuario": "lizsanchez", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:42:12.688382+00	2026-02-10 15:42:12.688435+00	2026-02-10 15:42:12.688435+00	65131291-e32f-4bf1-a749-cbc39279e924
ac8e6da9-87c7-49a5-8791-31208c8005f2	ac8e6da9-87c7-49a5-8791-31208c8005f2	{"rol": "estudiante", "sub": "ac8e6da9-87c7-49a5-8791-31208c8005f2", "email": "breynertejena@didactikapp.com", "nombre": "Breyner German Tejena Chilan", "usuario": "breynertejena", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:43:14.840923+00	2026-02-10 15:43:14.840973+00	2026-02-10 15:43:14.840973+00	c554f5d1-27c1-47a4-8c73-fc833f34c379
ed3fc59a-eab6-4126-9062-d79a3153f5da	ed3fc59a-eab6-4126-9062-d79a3153f5da	{"rol": "estudiante", "sub": "ed3fc59a-eab6-4126-9062-d79a3153f5da", "email": "samirtejena@didactikapp.com", "nombre": "Samir Randy Tejena Vera", "usuario": "samirtejena", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:43:51.491038+00	2026-02-10 15:43:51.49108+00	2026-02-10 15:43:51.49108+00	fa1f2b3a-8e5f-49ca-9b32-f9ac3095d9ac
085e1141-b596-4dd7-8bbc-cccb55bf46fa	085e1141-b596-4dd7-8bbc-cccb55bf46fa	{"rol": "estudiante", "sub": "085e1141-b596-4dd7-8bbc-cccb55bf46fa", "email": "carlostejena@didactikapp.com", "nombre": "Carlos Noriel Tejena Zambrano", "usuario": "carlostejena", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:45:14.509687+00	2026-02-10 15:45:14.509733+00	2026-02-10 15:45:14.509733+00	6b29669d-5089-43c3-929c-82c8a1d8d132
242a6366-d3f0-4a5a-ba81-0db7aed6ac63	242a6366-d3f0-4a5a-ba81-0db7aed6ac63	{"rol": "estudiante", "sub": "242a6366-d3f0-4a5a-ba81-0db7aed6ac63", "email": "breylivelez@didactikapp.com", "nombre": "Breyli Gregoria Velez Aragundi", "usuario": "breylivelez", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:46:03.432802+00	2026-02-10 15:46:03.432847+00	2026-02-10 15:46:03.432847+00	f984ef31-a179-4ad4-afb3-6215311ece73
f1ff761b-109b-46ac-8ffd-991130b7cfe7	f1ff761b-109b-46ac-8ffd-991130b7cfe7	{"rol": "estudiante", "sub": "f1ff761b-109b-46ac-8ffd-991130b7cfe7", "email": "brihanatorres@didactikapp.com", "nombre": "Brihana Samara Torres Vera", "usuario": "brihanatorres", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:47:33.704617+00	2026-02-10 15:47:33.704665+00	2026-02-10 15:47:33.704665+00	385e3dc7-9fba-4c04-a257-09b9226f113a
ca71cb86-8002-48da-8292-cbd21b04c618	ca71cb86-8002-48da-8292-cbd21b04c618	{"rol": "estudiante", "sub": "ca71cb86-8002-48da-8292-cbd21b04c618", "email": "ikerzambrano@didactikapp.com", "nombre": "Iker Santiago Zambrano Laz", "usuario": "ikerzambrano", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:48:13.38724+00	2026-02-10 15:48:13.387286+00	2026-02-10 15:48:13.387286+00	6d488fdc-2250-4d28-b4cf-445bb2d7a2c3
ba9207cf-7064-435f-8ab0-0ac8a9679084	ba9207cf-7064-435f-8ab0-0ac8a9679084	{"rol": "estudiante", "sub": "ba9207cf-7064-435f-8ab0-0ac8a9679084", "email": "sherylzambrabo@didactikapp.com", "nombre": "Sheryl Keyveveth Zambrano Palma", "usuario": "sherylzambrabo", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": false, "phone_verified": false}	email	2026-02-10 15:49:00.83341+00	2026-02-10 15:49:00.833455+00	2026-02-10 15:49:00.833455+00	fd817b1c-5e97-4c42-bbc8-1b0fb47456bf
4f59b75d-bb02-40d9-9cd2-b653d198a438	4f59b75d-bb02-40d9-9cd2-b653d198a438	{"rol": "estudiante", "sub": "4f59b75d-bb02-40d9-9cd2-b653d198a438", "email": "jesuspin@didactikapp.com", "nombre": "Jesus David Pin Vera", "usuario": "jesuspin", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-12 14:16:26.657921+00	2026-02-12 14:16:26.65797+00	2026-02-12 14:16:26.65797+00	4bc14423-0c9a-4026-be39-cb431687db01
92a11fb0-ed08-4d87-9ae4-e7bac360a51d	92a11fb0-ed08-4d87-9ae4-e7bac360a51d	{"rol": "estudiante", "sub": "92a11fb0-ed08-4d87-9ae4-e7bac360a51d", "email": "dastinparedes@didactikapp.com", "nombre": "Dastin Isaias Paredes Garcia", "usuario": "dastinparedes", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-12 14:24:04.499668+00	2026-02-12 14:24:04.501618+00	2026-02-12 14:24:04.501618+00	57fa8fee-ad8f-41e6-ab29-9e9c50f13c1d
91976250-d16f-48f5-9315-c89017ed5980	91976250-d16f-48f5-9315-c89017ed5980	{"rol": "estudiante", "sub": "91976250-d16f-48f5-9315-c89017ed5980", "email": "sofiapin@didactikapp.com", "nombre": "Sofia Cristel Pin Tejena", "usuario": "sofiapin", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-02-12 14:24:54.787594+00	2026-02-12 14:24:54.787648+00	2026-02-12 14:24:54.787648+00	2d64ab03-e2a2-4ee8-bef3-dcefcd76662e
bc729450-c4d8-450a-bf83-215288d70e0a	bc729450-c4d8-450a-bf83-215288d70e0a	{"rol": "estudiante", "sub": "bc729450-c4d8-450a-bf83-215288d70e0a", "email": "adrianmikko@didactikapp.com", "nombre": "Adrianmikko", "usuario": "adrianmikko", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-05-20 03:25:08.307413+00	2026-05-20 03:25:08.308191+00	2026-05-20 03:25:08.308191+00	9fc3140d-8c80-4c6b-976f-0b02cc66a495
8d999d39-7910-409f-a2ef-1b83c369843a	8d999d39-7910-409f-a2ef-1b83c369843a	{"rol": "estudiante", "sub": "8d999d39-7910-409f-a2ef-1b83c369843a", "email": "carlos23@didactikapp.com", "nombre": "carlos", "usuario": "carlos23", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-05-23 14:29:13.857655+00	2026-05-23 14:29:13.857708+00	2026-05-23 14:29:13.857708+00	cfce6a57-5f93-437d-805a-6438bcb80072
29181cd1-c18d-42e9-b0a8-7f13ec976837	29181cd1-c18d-42e9-b0a8-7f13ec976837	{"rol": "visitante", "sub": "29181cd1-c18d-42e9-b0a8-7f13ec976837", "email": "yarteaga4576@utm.edu.ec", "nombre": "Merly Paola", "email_verified": false, "phone_verified": false}	email	2026-06-02 02:46:39.74519+00	2026-06-02 02:46:39.74524+00	2026-06-02 02:46:39.74524+00	d5c8ddea-fd58-41e3-853e-836ee03aff75
7ebe0e88-8f7d-4583-9e84-0b1c5d561918	7ebe0e88-8f7d-4583-9e84-0b1c5d561918	{"rol": "estudiante", "sub": "7ebe0e88-8f7d-4583-9e84-0b1c5d561918", "email": "merlypaola@didactikapp.com", "nombre": "admin2", "usuario": "merlypaola", "grupo_id": null, "email_verified": false, "phone_verified": false}	email	2026-06-02 03:10:49.750018+00	2026-06-02 03:10:49.750069+00	2026-06-02 03:10:49.750069+00	a8d9b0b4-78c6-47a4-9fc1-5e0ad8cbaebc
07010bce-5076-4553-9a09-2a95b20e0e8b	07010bce-5076-4553-9a09-2a95b20e0e8b	{"rol": "estudiante", "sub": "07010bce-5076-4553-9a09-2a95b20e0e8b", "email": "admin2@didactikapp.com", "nombre": "Merly Paola Zambrano", "usuario": "admin2", "grupo_id": null, "email_verified": false, "phone_verified": false}	email	2026-06-02 03:15:10.728366+00	2026-06-02 03:15:10.728419+00	2026-06-02 03:15:10.728419+00	fc1c804a-1058-4b05-be08-5581b6a6ef30
0e495a05-fc94-4a96-b7d8-0ebed3cf3f95	0e495a05-fc94-4a96-b7d8-0ebed3cf3f95	{"rol": "estudiante", "sub": "0e495a05-fc94-4a96-b7d8-0ebed3cf3f95", "email": "admin3@didactikapp.com", "nombre": "admin3", "usuario": "admin3", "grupo_id": null, "email_verified": false, "phone_verified": false}	email	2026-06-02 03:18:41.489014+00	2026-06-02 03:18:41.489071+00	2026-06-02 03:18:41.489071+00	7cefc87f-1548-4188-9ef2-b66615d28233
14ce5450-53d1-4997-aa2d-6c182759611d	14ce5450-53d1-4997-aa2d-6c182759611d	{"rol": "estudiante", "sub": "14ce5450-53d1-4997-aa2d-6c182759611d", "email": "anaja@didactikapp.com", "nombre": "ana karen", "usuario": "anaja", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": false, "phone_verified": false}	email	2026-06-02 03:22:40.734126+00	2026-06-02 03:22:40.734176+00	2026-06-02 03:22:40.734176+00	6ddef4da-fb50-4863-a49e-af09f72979ec
14076186-432f-49f8-87c2-093a3ae9804f	14076186-432f-49f8-87c2-093a3ae9804f	{"rol": "visitante", "sub": "14076186-432f-49f8-87c2-093a3ae9804f", "email": "paolamerly1@gmail.com", "nombre": "Merly Zambrano Bravo ", "email_verified": false, "phone_verified": false}	email	2026-06-02 03:51:15.784055+00	2026-06-02 03:51:15.784125+00	2026-06-02 03:51:15.784125+00	55e0a65e-3eda-4e8b-a263-35473d9b2878
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
1aabb745-3212-4877-a984-08ecb3fbd15c	2026-02-09 14:36:25.38733+00	2026-02-09 14:36:25.38733+00	password	b3e5027b-ab0a-4519-9557-65116d5f1208
984fe04c-d7c1-4da3-bf65-bc9dbfb2e78e	2026-02-09 14:40:47.163544+00	2026-02-09 14:40:47.163544+00	password	1c7fe87d-b957-456b-8aa1-c3c160a01b33
e130642a-fa10-4b28-a9b1-a6290e61be6c	2026-02-09 14:45:35.287233+00	2026-02-09 14:45:35.287233+00	password	3a214ee3-def0-4d5e-835a-788520537ac1
a0c39278-6d8e-4fa6-8163-9284414d7395	2026-02-09 14:47:13.877071+00	2026-02-09 14:47:13.877071+00	password	3c71641c-dd00-4e84-8312-463f96f49b96
c2046a2c-c7e1-4fd9-879f-db77facdd399	2026-02-09 14:48:57.140723+00	2026-02-09 14:48:57.140723+00	password	d28a87a9-6aae-4721-a65c-4893419b168c
f3441fdd-bcd3-4f19-84cb-ab295e359592	2026-02-09 14:50:48.043012+00	2026-02-09 14:50:48.043012+00	password	d28b0ec4-bb09-48ec-baf3-ce2cc3367437
77b2fb2d-4d26-499a-806b-822122780a0f	2026-02-09 14:53:18.233267+00	2026-02-09 14:53:18.233267+00	password	68612cd9-fa6f-45ae-b3bb-0034a81b0710
304a3bd2-f2f3-4e03-afee-90b6ecb88f13	2026-02-09 14:58:09.202126+00	2026-02-09 14:58:09.202126+00	password	30ec0cb8-e349-4ff6-9772-9aed702998e1
e6064adf-07d4-49db-8f6e-f14066cb0bf6	2026-02-09 15:00:31.438432+00	2026-02-09 15:00:31.438432+00	password	d7dd16ee-e7d1-47b6-9125-d4e2f60dd5fd
ef87e6ff-57a2-497d-bc82-b8dd0c54abb1	2026-02-09 15:02:13.341214+00	2026-02-09 15:02:13.341214+00	password	e314c478-9bd8-4596-acfd-ec51b98ffaab
d00b2cbb-ff8a-4d10-88f6-9d5a2a5fec17	2026-02-09 15:04:53.508108+00	2026-02-09 15:04:53.508108+00	password	97ba3283-d0e6-4104-867a-b56ac813084a
c554c052-2d7f-4209-a2ba-a0e3c17eaed0	2026-02-09 15:07:00.89451+00	2026-02-09 15:07:00.89451+00	password	447a3c94-2f62-4ef9-9876-5edbd5b9f004
c36a6312-7838-4e8b-ba18-bc234c897a34	2026-02-09 15:07:53.553204+00	2026-02-09 15:07:53.553204+00	password	045eca08-37d5-4ba7-9fc3-d4c99dc02261
f56bd577-ce66-49f1-9d0c-203a01afcdc7	2026-02-09 15:08:45.923957+00	2026-02-09 15:08:45.923957+00	password	5ffc2f9f-d62a-4b75-9e5e-3b5ff54a51c0
e98c5f58-05f5-469e-a029-f1aee849a7ae	2026-02-09 15:12:41.584568+00	2026-02-09 15:12:41.584568+00	password	48d528e6-098a-4dd2-908d-a80aa1b36539
53b5a674-cd1e-43e4-84bb-ac00c44e2092	2026-02-12 14:24:04.547136+00	2026-02-12 14:24:04.547136+00	password	987bbed9-d885-47a9-892b-7ed7a1d970e1
fed8dd6c-9bc9-494c-92e7-f077e8d7b46f	2026-02-12 14:24:54.799909+00	2026-02-12 14:24:54.799909+00	password	f308b531-1810-4ff7-96fa-c55374b8cc6c
fd66d27e-82cc-4469-b853-701d0da933e5	2026-02-10 15:17:41.341896+00	2026-02-10 15:17:41.341896+00	password	a0ac25a2-2253-437e-87b4-bb4dba16f429
3a673fa5-9437-406b-af7a-17fa3958dd4f	2026-02-10 15:24:03.520936+00	2026-02-10 15:24:03.520936+00	password	21c11cd4-ffd0-4f9d-ac00-40a7e09ae996
374b974c-ac24-4f9d-87be-a331e33dbbae	2026-06-02 04:41:22.075907+00	2026-06-02 04:41:22.075907+00	password	26462e47-df23-48f0-8de0-d9bd6a12bde3
9556e7b7-f450-47ce-9c0f-6c255cf91a59	2026-06-02 04:47:21.022638+00	2026-06-02 04:47:21.022638+00	password	260c212a-9e9b-4dd1-9ca8-0fb87e62f370
27c4c83d-5e6f-4c60-ba07-65d817018b34	2026-02-10 15:27:16.062772+00	2026-02-10 15:27:16.062772+00	password	1134eae3-bc0b-43e4-a1ed-74af481c3d0b
4dfea4d6-64c5-4881-9bc5-3308a3612fe0	2026-02-10 15:28:14.403318+00	2026-02-10 15:28:14.403318+00	password	2b81ac07-453e-417c-aacf-975ee0009cd9
ef420784-7f91-4bd5-a43c-be4b7f858cf5	2026-02-10 15:29:01.460713+00	2026-02-10 15:29:01.460713+00	password	8a2db338-e8a4-46da-83d3-3cbec9369296
dd7a901f-3406-4c37-aa5c-cb5d027da249	2026-02-10 15:29:58.860264+00	2026-02-10 15:29:58.860264+00	password	f7440bf6-6dbf-47da-8d7d-861b556825cd
6ef4f562-48fa-4757-a576-f93189fecf5c	2026-06-02 04:50:00.96048+00	2026-06-02 04:50:00.96048+00	password	da117bad-7c55-4324-ad26-66b28de9b119
28319db4-fc62-42d7-9d5c-fea746073c1f	2026-02-10 15:31:18.343895+00	2026-02-10 15:31:18.343895+00	password	d1d95ef4-1f1a-465a-80da-8b9bf9dff3b0
9aa114af-caed-4e23-abb1-9d42c8b217c3	2026-02-10 15:32:18.894213+00	2026-02-10 15:32:18.894213+00	password	0d7d8a37-000e-47b4-abd7-0ee2c0d6dadc
9ca93e6f-cc2f-4ffc-a9ab-e60f9012c2b5	2026-02-10 15:32:55.892441+00	2026-02-10 15:32:55.892441+00	password	8a60a7c5-fe43-4341-a260-daccdc4646b5
3d9ae19a-4853-4f9e-a731-1840ef689672	2026-06-03 20:49:17.580695+00	2026-06-03 20:49:17.580695+00	password	c252f6e6-e63c-41f4-a9fa-b3415aa336ef
b62eeba1-d92b-4804-86e7-8b49eb3591ce	2026-02-10 15:34:51.332042+00	2026-02-10 15:34:51.332042+00	password	14a7a189-564d-475d-a2a5-d4381220ab8f
06551f01-fca2-41b9-954d-b9545e6dc7cd	2026-02-10 15:35:47.053764+00	2026-02-10 15:35:47.053764+00	password	a4478d54-a69a-4570-998f-01addbdbb662
6ac8c977-ae1c-4dac-991b-3e1975be6e7b	2026-02-10 15:36:26.896057+00	2026-02-10 15:36:26.896057+00	password	9df7fbd9-7094-4709-9e92-f07199cedd2c
23715c15-14fc-48de-b7bc-631fb0d0117c	2026-01-19 19:02:23.648616+00	2026-01-19 19:02:23.648616+00	password	7a186d8b-620d-4866-894c-81fdc6767460
19228195-8fa6-4e89-851f-7ac0200b9f44	2026-01-19 19:06:30.75077+00	2026-01-19 19:06:30.75077+00	password	5b63e08c-e325-40d8-8835-ee5321fee4c8
132441ca-ddc1-4684-807a-b8963422747e	2026-01-19 19:08:45.4541+00	2026-01-19 19:08:45.4541+00	password	e02a2689-f6e7-4fb7-8c32-2a9e5dfa1ae3
0897c0fc-a151-4d9e-85af-0ef20dec0ccf	2026-01-19 19:12:47.329726+00	2026-01-19 19:12:47.329726+00	password	5f218130-ea28-4e3e-a2ac-bcd69ac6699b
48a42d8d-3e2b-468e-9b5b-19f36e892592	2026-02-10 15:37:15.559374+00	2026-02-10 15:37:15.559374+00	password	92fbdbea-c2db-47f0-97cc-141d14a5f7b9
1144fabc-c0f0-42aa-910c-becb5c7a358a	2026-02-10 15:38:11.88408+00	2026-02-10 15:38:11.88408+00	password	812229e7-5c1b-43f8-85b7-4902bb052c5a
7f82ac4c-af88-4a66-b2e1-8f541e84ca66	2026-02-10 15:40:40.930093+00	2026-02-10 15:40:40.930093+00	password	c7227f11-5523-40c0-ab0b-b2b36a50db0a
48436920-6440-4dc6-ab5e-ccc38c1e1018	2026-06-04 17:03:14.585706+00	2026-06-04 17:03:14.585706+00	password	4fcf1ab8-5ee7-4ab2-b379-bf3617334ce3
5f226324-632f-40ed-b8c1-357e9527dc42	2026-02-10 15:42:12.700797+00	2026-02-10 15:42:12.700797+00	password	dd2a17e7-7b80-4d16-ad16-5bfbc02e2b65
904af32b-42c8-4161-a8fd-90b9f87b34b2	2026-01-22 16:27:30.046671+00	2026-01-22 16:27:30.046671+00	password	e034ba90-5af3-4db8-b2d8-754405340240
8aa50bca-575e-4407-9041-12c06b377c61	2026-05-20 03:31:09.679857+00	2026-05-20 03:31:09.679857+00	password	13974bfc-b2df-4fe9-bab3-c38734337239
9e3772ee-2bcb-42be-85a0-ffa1119d27f9	2026-02-10 15:46:03.44554+00	2026-02-10 15:46:03.44554+00	password	0a353b18-f304-4bb9-a8fc-5b67393ae660
96bb8670-7812-4db8-a89b-0bb9b6759732	2026-05-23 14:29:13.915038+00	2026-05-23 14:29:13.915038+00	password	ca2fe7b7-c7ac-4c7e-a611-f6471d8da9aa
29f8bd95-4db3-446a-8419-28a8bb8457e5	2026-02-09 13:50:12.520531+00	2026-02-09 13:50:12.520531+00	password	5f36c388-ff5a-4782-befc-6f8568af534e
a28c68aa-7f49-4751-a759-75eb7104c377	2026-02-09 13:51:32.730514+00	2026-02-09 13:51:32.730514+00	password	6e8cb8a9-2c51-4131-bf5b-b39449ca435c
427497da-88cc-4f40-b912-4b9785237ae6	2026-06-02 02:46:39.780235+00	2026-06-02 02:46:39.780235+00	password	be287db8-4f12-4d6e-866c-c510adaabff8
d2184e84-daff-4601-8b86-ba5a586ba2a7	2026-06-02 02:47:13.036877+00	2026-06-02 02:47:13.036877+00	password	a10026da-8993-49a9-a5a9-203d93fb6dec
ab3a3e04-0ced-4e6c-9d6b-c37949b8e0c5	2026-06-02 02:47:21.343505+00	2026-06-02 02:47:21.343505+00	password	492933a6-8d20-4931-aa74-d429653cf229
c04aab6c-cb3a-41dc-b22b-84ceef8ba03e	2026-06-02 02:47:44.281113+00	2026-06-02 02:47:44.281113+00	password	5b921bfd-5d1e-486e-80ef-be1869d7758f
ceec6a65-1fb9-4e9a-9b92-e8c3771a8e07	2026-06-02 02:47:47.939436+00	2026-06-02 02:47:47.939436+00	password	89a94605-8c5e-4a1c-8965-9778e49dadea
24f9b27b-6e90-4a5f-a9a5-956880b3e2ad	2026-06-02 02:48:08.548603+00	2026-06-02 02:48:08.548603+00	password	86fc69e7-cf92-4f30-9ed8-7de61c56c69b
7866603f-b82d-4b43-83d4-1d5e3c93d66e	2026-06-02 02:48:10.993631+00	2026-06-02 02:48:10.993631+00	password	96a5ba83-4137-4d08-9de7-a8c37bff405e
fd9058a2-3f27-4351-ad53-86728f5b2d91	2026-06-02 03:10:49.822238+00	2026-06-02 03:10:49.822238+00	password	36fbdfbe-cee7-420c-962b-08bda6ab3f56
873d6507-898e-4560-b2ac-399ebc365111	2026-06-02 03:15:10.760189+00	2026-06-02 03:15:10.760189+00	password	a2a773dd-0c3f-460d-88c2-87c0b97528ca
fd64124a-8c46-45e7-b0f5-76a790159fae	2026-06-02 03:18:41.521331+00	2026-06-02 03:18:41.521331+00	password	089befc7-b0dd-4743-b0ad-e24b60473f4b
0e1a97bd-90ea-4c99-a61b-e090336da21b	2026-06-02 03:22:40.77367+00	2026-06-02 03:22:40.77367+00	password	3458fbf2-9842-4753-ad40-f448e469a0df
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
9ecc3724-b8ac-41a9-851b-0c52dd23bf6d	a721cb76-7b06-4025-afed-d62c9f579550	confirmation_token	62685d918e60e970f18a6c855174b6cc7f0b20d7077658396935d569	yanellyart@didactikapp.com	2026-01-19 03:49:52.404308	2026-01-19 03:49:52.404308
058987b8-6ef2-4fe4-9f33-592e89702ee2	84d3eaaf-2a36-42c4-b3e5-b93ac3fe9ae9	confirmation_token	ff8acc3e9186e6c35298a6e49fc5fc0fc8a4cf837f165e3b3fbfb815	yarteaga23@didactikapp.com	2026-01-19 04:01:33.812337	2026-01-19 04:01:33.812337
88ef7688-a43b-4c1f-a83f-814c3065eb38	233d26ed-f72e-4ff7-b859-2b8b48b8c6b3	confirmation_token	2d9313b64b529ae368f1372c5b6ec2a5c8cfab4f6848820f065525ae	merart@didactikapp.com	2026-01-19 04:07:42.224175	2026-01-19 04:07:42.224175
23d19768-27cb-4f36-8ff5-551ccd13951f	ecfe53a4-3b92-472e-bcf0-f77807681f84	confirmation_token	b1615c6b98a06d6a9401aaacfcaf505cf19032672711b4415694abc5	kengart@didactikapp.com	2026-01-19 04:11:08.830707	2026-01-19 04:11:08.830707
18cfc8a6-f765-46b2-ac7c-f5aa8ace8900	9d0f2934-0bf1-4eae-9fa4-234870fb66cb	confirmation_token	e2935630d29cfc885fec819682910e0e995a6553b019d1288373ea75	danivm@didactikapp.com	2026-01-19 04:21:18.814871	2026-01-19 04:21:18.814871
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	443	duxds72jkzg5	55db67b3-bc35-4671-81f3-a996a5350425	f	2026-01-19 19:06:30.745946+00	2026-01-19 19:06:30.745946+00	\N	19228195-8fa6-4e89-851f-7ac0200b9f44
00000000-0000-0000-0000-000000000000	794	r6kqdrqykqs4	29181cd1-c18d-42e9-b0a8-7f13ec976837	f	2026-06-02 02:46:39.776202+00	2026-06-02 02:46:39.776202+00	\N	427497da-88cc-4f40-b912-4b9785237ae6
00000000-0000-0000-0000-000000000000	529	5k6iwmcrlm5v	7b542b46-6fbd-4176-bbbb-5cf594c49da2	f	2026-02-09 14:45:35.281499+00	2026-02-09 14:45:35.281499+00	\N	e130642a-fa10-4b28-a9b1-a6290e61be6c
00000000-0000-0000-0000-000000000000	532	zmeypqw6c3tj	75424ae3-8fbd-4752-8c5c-2bb5e38be82f	f	2026-02-09 14:50:48.041165+00	2026-02-09 14:50:48.041165+00	\N	f3441fdd-bcd3-4f19-84cb-ab295e359592
00000000-0000-0000-0000-000000000000	535	no4y2x4f5w4x	d39fd319-3593-4ddc-840a-5a89f73a3d75	f	2026-02-09 14:58:09.200334+00	2026-02-09 14:58:09.200334+00	\N	304a3bd2-f2f3-4e03-afee-90b6ecb88f13
00000000-0000-0000-0000-000000000000	538	6njsty6hsfeu	e180edb5-9a66-4602-9e4a-17a4c9c70d92	f	2026-02-09 15:04:53.498756+00	2026-02-09 15:04:53.498756+00	\N	d00b2cbb-ff8a-4d10-88f6-9d5a2a5fec17
00000000-0000-0000-0000-000000000000	622	ieeupkiiy7dc	92a11fb0-ed08-4d87-9ae4-e7bac360a51d	f	2026-02-12 14:24:04.539059+00	2026-02-12 14:24:04.539059+00	\N	53b5a674-cd1e-43e4-84bb-ac00c44e2092
00000000-0000-0000-0000-000000000000	795	dsbqoohbzytg	29181cd1-c18d-42e9-b0a8-7f13ec976837	f	2026-06-02 02:47:13.034294+00	2026-06-02 02:47:13.034294+00	\N	d2184e84-daff-4601-8b86-ba5a586ba2a7
00000000-0000-0000-0000-000000000000	623	ubioxwbnbbdn	91976250-d16f-48f5-9315-c89017ed5980	t	2026-02-12 14:24:54.798774+00	2026-02-12 16:32:52.751071+00	\N	fed8dd6c-9bc9-494c-92e7-f077e8d7b46f
00000000-0000-0000-0000-000000000000	796	byrtu4pmdl7i	29181cd1-c18d-42e9-b0a8-7f13ec976837	f	2026-06-02 02:47:21.342086+00	2026-06-02 02:47:21.342086+00	\N	ab3a3e04-0ced-4e6c-9d6b-c37949b8e0c5
00000000-0000-0000-0000-000000000000	797	gcqhr5buve2z	29181cd1-c18d-42e9-b0a8-7f13ec976837	f	2026-06-02 02:47:44.279876+00	2026-06-02 02:47:44.279876+00	\N	c04aab6c-cb3a-41dc-b22b-84ceef8ba03e
00000000-0000-0000-0000-000000000000	798	uakdeyghmbwo	29181cd1-c18d-42e9-b0a8-7f13ec976837	f	2026-06-02 02:47:47.937506+00	2026-06-02 02:47:47.937506+00	\N	ceec6a65-1fb9-4e9a-9b92-e8c3771a8e07
00000000-0000-0000-0000-000000000000	799	4rz4pecmlsvw	29181cd1-c18d-42e9-b0a8-7f13ec976837	f	2026-06-02 02:48:08.547229+00	2026-06-02 02:48:08.547229+00	\N	24f9b27b-6e90-4a5f-a9a5-956880b3e2ad
00000000-0000-0000-0000-000000000000	800	zfba7s7mrkrs	29181cd1-c18d-42e9-b0a8-7f13ec976837	f	2026-06-02 02:48:10.992507+00	2026-06-02 02:48:10.992507+00	\N	7866603f-b82d-4b43-83d4-1d5e3c93d66e
00000000-0000-0000-0000-000000000000	561	inwuxlwjubyq	18a33406-19e8-4e01-a292-bf1cd1af8c65	f	2026-02-10 15:24:03.519113+00	2026-02-10 15:24:03.519113+00	\N	3a673fa5-9437-406b-af7a-17fa3958dd4f
00000000-0000-0000-0000-000000000000	570	22dqa6tjudq3	1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7	f	2026-02-10 15:32:18.890615+00	2026-02-10 15:32:18.890615+00	\N	9aa114af-caed-4e23-abb1-9d42c8b217c3
00000000-0000-0000-0000-000000000000	571	owc6hn57x35p	47739d07-5148-4e33-9aee-d236406d760e	f	2026-02-10 15:32:55.891137+00	2026-02-10 15:32:55.891137+00	\N	9ca93e6f-cc2f-4ffc-a9ab-e60f9012c2b5
00000000-0000-0000-0000-000000000000	809	wtydxr4vhl7l	0e495a05-fc94-4a96-b7d8-0ebed3cf3f95	f	2026-06-02 03:18:41.512602+00	2026-06-02 03:18:41.512602+00	\N	fd64124a-8c46-45e7-b0f5-76a790159fae
00000000-0000-0000-0000-000000000000	835	ai7jgn6niscs	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-03 20:49:17.549608+00	2026-06-03 21:51:38.22691+00	\N	3d9ae19a-4853-4f9e-a731-1840ef689672
00000000-0000-0000-0000-000000000000	838	blfbkk3te62g	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-04 00:02:36.984504+00	2026-06-04 01:01:17.926391+00	hm4oz4tij7vl	3d9ae19a-4853-4f9e-a731-1840ef689672
00000000-0000-0000-0000-000000000000	841	iwt57fooi5od	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-04 03:02:58.632537+00	2026-06-04 16:51:02.456838+00	yad6k6km3dbe	3d9ae19a-4853-4f9e-a731-1840ef689672
00000000-0000-0000-0000-000000000000	844	pacqlneaevbo	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-04 19:01:28.717464+00	2026-06-04 20:00:50.331944+00	l4ydaxi54nve	48436920-6440-4dc6-ab5e-ccc38c1e1018
00000000-0000-0000-0000-000000000000	832	337ixisub5tl	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-02 04:41:22.071955+00	2026-06-06 15:32:57.884606+00	\N	374b974c-ac24-4f9d-87be-a331e33dbbae
00000000-0000-0000-0000-000000000000	847	cn33hf3iyj45	3a90fa1a-c502-40ab-8d7a-3fff14060570	f	2026-06-08 22:02:27.342678+00	2026-06-08 22:02:27.342678+00	m2xuvhg5nf5g	374b974c-ac24-4f9d-87be-a331e33dbbae
00000000-0000-0000-0000-000000000000	527	xn5eahimlsoa	28f6c2fe-742e-4188-b53d-700ba85aec4c	f	2026-02-09 14:36:25.359639+00	2026-02-09 14:36:25.359639+00	\N	1aabb745-3212-4877-a984-08ecb3fbd15c
00000000-0000-0000-0000-000000000000	444	o55cntctowpz	009551f7-f973-4e33-82c5-cc7f2171e07f	f	2026-01-19 19:08:45.452162+00	2026-01-19 19:08:45.452162+00	\N	132441ca-ddc1-4684-807a-b8963422747e
00000000-0000-0000-0000-000000000000	530	ir3e54fus6nf	6c94d34d-5856-4649-8998-7eb1090fdf09	f	2026-02-09 14:47:13.86971+00	2026-02-09 14:47:13.86971+00	\N	a0c39278-6d8e-4fa6-8163-9284414d7395
00000000-0000-0000-0000-000000000000	533	wzwnb4atw45z	520498cc-f65a-42a2-97b6-22f766b06cfc	f	2026-02-09 14:53:18.231476+00	2026-02-09 14:53:18.231476+00	\N	77b2fb2d-4d26-499a-806b-822122780a0f
00000000-0000-0000-0000-000000000000	445	nhterbzh2exm	27226334-0bfb-4d86-9a02-1fe3763995ed	f	2026-01-19 19:12:47.327955+00	2026-01-19 19:12:47.327955+00	\N	0897c0fc-a151-4d9e-85af-0ef20dec0ccf
00000000-0000-0000-0000-000000000000	536	l24aeogmkfar	2e05a86b-6966-4266-a17a-cedc2aad1567	f	2026-02-09 15:00:31.436591+00	2026-02-09 15:00:31.436591+00	\N	e6064adf-07d4-49db-8f6e-f14066cb0bf6
00000000-0000-0000-0000-000000000000	442	2zq7wniooqt3	e836b53c-0eb8-4c93-9e8c-e972aab5b995	f	2026-01-19 19:02:23.646838+00	2026-01-19 19:02:23.646838+00	\N	23715c15-14fc-48de-b7bc-631fb0d0117c
00000000-0000-0000-0000-000000000000	539	xoqd4pgle3cb	d81fa5d0-b828-47be-bf4f-d04e151c937f	f	2026-02-09 15:07:00.891333+00	2026-02-09 15:07:00.891333+00	\N	c554c052-2d7f-4209-a2ba-a0e3c17eaed0
00000000-0000-0000-0000-000000000000	540	dpgmyslhzrfi	f681ddbe-c67f-44f1-9969-31b64b4c879a	f	2026-02-09 15:07:53.551303+00	2026-02-09 15:07:53.551303+00	\N	c36a6312-7838-4e8b-ba18-bc234c897a34
00000000-0000-0000-0000-000000000000	541	kkaa6gkathjp	00aff592-6206-428c-9476-2ca0e5c985bf	f	2026-02-09 15:08:45.922069+00	2026-02-09 15:08:45.922069+00	\N	f56bd577-ce66-49f1-9d0c-203a01afcdc7
00000000-0000-0000-0000-000000000000	805	eyc7ddrqgyju	7ebe0e88-8f7d-4583-9e84-0b1c5d561918	f	2026-06-02 03:10:49.80633+00	2026-06-02 03:10:49.80633+00	\N	fd9058a2-3f27-4351-ad53-86728f5b2d91
00000000-0000-0000-0000-000000000000	624	vvz2uswc3siu	91976250-d16f-48f5-9315-c89017ed5980	f	2026-02-12 16:32:52.766405+00	2026-02-12 16:32:52.766405+00	ubioxwbnbbdn	fed8dd6c-9bc9-494c-92e7-f077e8d7b46f
00000000-0000-0000-0000-000000000000	810	bdnq33gc5uvb	14ce5450-53d1-4997-aa2d-6c182759611d	f	2026-06-02 03:22:40.758963+00	2026-06-02 03:22:40.758963+00	\N	0e1a97bd-90ea-4c99-a61b-e090336da21b
00000000-0000-0000-0000-000000000000	573	twgceyr5fwk2	40e4b506-1d73-4298-8d8b-2011f8e24bef	f	2026-02-10 15:34:51.330932+00	2026-02-10 15:34:51.330932+00	\N	b62eeba1-d92b-4804-86e7-8b49eb3591ce
00000000-0000-0000-0000-000000000000	574	2jrpbbf3lhqz	8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8	f	2026-02-10 15:35:47.052655+00	2026-02-10 15:35:47.052655+00	\N	06551f01-fca2-41b9-954d-b9545e6dc7cd
00000000-0000-0000-0000-000000000000	575	vy4fjxavzww4	83bb0944-5672-4759-b72b-37deea537a47	f	2026-02-10 15:36:26.894745+00	2026-02-10 15:36:26.894745+00	\N	6ac8c977-ae1c-4dac-991b-3e1975be6e7b
00000000-0000-0000-0000-000000000000	576	q2d6xt5uzqm6	5dc9910f-4d2e-4fae-8907-0fe3b596cde0	f	2026-02-10 15:37:15.557316+00	2026-02-10 15:37:15.557316+00	\N	48a42d8d-3e2b-468e-9b5b-19f36e892592
00000000-0000-0000-0000-000000000000	577	ypv6uk4k66vf	937926f9-3c6b-46d2-9cf3-341479442747	f	2026-02-10 15:38:11.882173+00	2026-02-10 15:38:11.882173+00	\N	1144fabc-c0f0-42aa-910c-becb5c7a358a
00000000-0000-0000-0000-000000000000	584	oglpst4e5vfe	242a6366-d3f0-4a5a-ba81-0db7aed6ac63	f	2026-02-10 15:46:03.444233+00	2026-02-10 15:46:03.444233+00	\N	9e3772ee-2bcb-42be-85a0-ffa1119d27f9
00000000-0000-0000-0000-000000000000	833	kpk3idltcrof	3a90fa1a-c502-40ab-8d7a-3fff14060570	f	2026-06-02 04:47:21.015767+00	2026-06-02 04:47:21.015767+00	\N	9556e7b7-f450-47ce-9c0f-6c255cf91a59
00000000-0000-0000-0000-000000000000	836	r5fizu4grlta	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-03 21:51:38.236219+00	2026-06-03 23:04:14.859453+00	ai7jgn6niscs	3d9ae19a-4853-4f9e-a731-1840ef689672
00000000-0000-0000-0000-000000000000	839	pzvf6x4yjazg	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-04 01:01:17.934926+00	2026-06-04 01:59:54.621553+00	blfbkk3te62g	3d9ae19a-4853-4f9e-a731-1840ef689672
00000000-0000-0000-0000-000000000000	842	3itusww2jzsa	3a90fa1a-c502-40ab-8d7a-3fff14060570	f	2026-06-04 16:51:02.473494+00	2026-06-04 16:51:02.473494+00	iwt57fooi5od	3d9ae19a-4853-4f9e-a731-1840ef689672
00000000-0000-0000-0000-000000000000	845	lkg4afcogd7n	3a90fa1a-c502-40ab-8d7a-3fff14060570	f	2026-06-04 20:00:50.340946+00	2026-06-04 20:00:50.340946+00	pacqlneaevbo	48436920-6440-4dc6-ab5e-ccc38c1e1018
00000000-0000-0000-0000-000000000000	461	tbr3qtklo6dq	6bd6fd48-7433-4526-8803-516660c1103a	f	2026-01-22 16:27:30.038646+00	2026-01-22 16:27:30.038646+00	\N	904af32b-42c8-4161-a8fd-90b9f87b34b2
00000000-0000-0000-0000-000000000000	701	c2anavakt6zh	8d999d39-7910-409f-a2ef-1b83c369843a	f	2026-05-23 14:29:13.907462+00	2026-05-23 14:29:13.907462+00	\N	96bb8670-7812-4db8-a89b-0bb9b6759732
00000000-0000-0000-0000-000000000000	528	a72ndbg6gcid	88bbd661-7479-4a84-b9ef-4f32da93ff26	f	2026-02-09 14:40:47.159514+00	2026-02-09 14:40:47.159514+00	\N	984fe04c-d7c1-4da3-bf65-bc9dbfb2e78e
00000000-0000-0000-0000-000000000000	531	emnf2ijbgo3p	811c750f-97ad-4705-8156-9cdf28b37323	f	2026-02-09 14:48:57.138227+00	2026-02-09 14:48:57.138227+00	\N	c2046a2c-c7e1-4fd9-879f-db77facdd399
00000000-0000-0000-0000-000000000000	537	f3cgvkkgvzau	a12584c4-19a5-4716-83d9-e0bb42fbf002	f	2026-02-09 15:02:13.339468+00	2026-02-09 15:02:13.339468+00	\N	ef87e6ff-57a2-497d-bc82-b8dd0c54abb1
00000000-0000-0000-0000-000000000000	542	6cb2a2tgehc2	f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e	f	2026-02-09 15:12:41.582656+00	2026-02-09 15:12:41.582656+00	\N	e98c5f58-05f5-469e-a029-f1aee849a7ae
00000000-0000-0000-0000-000000000000	807	v6cuzhl2lacg	07010bce-5076-4553-9a09-2a95b20e0e8b	f	2026-06-02 03:15:10.749919+00	2026-06-02 03:15:10.749919+00	\N	873d6507-898e-4560-b2ac-399ebc365111
00000000-0000-0000-0000-000000000000	556	jvloq3574sm6	9247ea7b-2d1d-45b3-b037-6ec04945be81	f	2026-02-10 15:17:41.31867+00	2026-02-10 15:17:41.31867+00	\N	fd66d27e-82cc-4469-b853-701d0da933e5
00000000-0000-0000-0000-000000000000	564	uc6smel2rp2i	7524e67f-698f-40b6-8424-26f05bac35e1	f	2026-02-10 15:27:16.061651+00	2026-02-10 15:27:16.061651+00	\N	27c4c83d-5e6f-4c60-ba07-65d817018b34
00000000-0000-0000-0000-000000000000	565	bpb26dkhvy4l	02d3430e-9601-4b3b-a6d6-e9390872b54b	f	2026-02-10 15:28:14.402145+00	2026-02-10 15:28:14.402145+00	\N	4dfea4d6-64c5-4881-9bc5-3308a3612fe0
00000000-0000-0000-0000-000000000000	566	7wzbuz4fnxkk	f5def64f-2c9e-4165-9302-4c4870991dad	f	2026-02-10 15:29:01.459582+00	2026-02-10 15:29:01.459582+00	\N	ef420784-7f91-4bd5-a43c-be4b7f858cf5
00000000-0000-0000-0000-000000000000	567	zx7i3whselez	9b79fcf6-f192-4364-80ec-ab95b18c87e3	f	2026-02-10 15:29:58.859159+00	2026-02-10 15:29:58.859159+00	\N	dd7a901f-3406-4c37-aa5c-cb5d027da249
00000000-0000-0000-0000-000000000000	569	njtqkdcryxpy	7bab67c8-74d3-4a9e-a2b1-990223186d4e	f	2026-02-10 15:31:18.342784+00	2026-02-10 15:31:18.342784+00	\N	28319db4-fc62-42d7-9d5c-fea746073c1f
00000000-0000-0000-0000-000000000000	578	npusrplve3s5	27356752-78d4-4833-bdbc-ac5ceb23883e	f	2026-02-10 15:40:40.927636+00	2026-02-10 15:40:40.927636+00	\N	7f82ac4c-af88-4a66-b2e1-8f541e84ca66
00000000-0000-0000-0000-000000000000	580	qneasitbzuml	a883d161-ec1f-497b-91c6-16543a922792	f	2026-02-10 15:42:12.699445+00	2026-02-10 15:42:12.699445+00	\N	5f226324-632f-40ed-b8c1-357e9527dc42
00000000-0000-0000-0000-000000000000	834	ltbchhzuk7ma	3a90fa1a-c502-40ab-8d7a-3fff14060570	f	2026-06-02 04:50:00.95729+00	2026-06-02 04:50:00.95729+00	\N	6ef4f562-48fa-4757-a576-f93189fecf5c
00000000-0000-0000-0000-000000000000	837	hm4oz4tij7vl	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-03 23:04:14.867658+00	2026-06-04 00:02:36.974661+00	r5fizu4grlta	3d9ae19a-4853-4f9e-a731-1840ef689672
00000000-0000-0000-0000-000000000000	840	yad6k6km3dbe	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-04 01:59:54.630331+00	2026-06-04 03:02:58.617964+00	pzvf6x4yjazg	3d9ae19a-4853-4f9e-a731-1840ef689672
00000000-0000-0000-0000-000000000000	843	l4ydaxi54nve	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-04 17:03:14.564546+00	2026-06-04 19:01:28.698919+00	\N	48436920-6440-4dc6-ab5e-ccc38c1e1018
00000000-0000-0000-0000-000000000000	846	m2xuvhg5nf5g	3a90fa1a-c502-40ab-8d7a-3fff14060570	t	2026-06-06 15:32:57.909113+00	2026-06-08 22:02:27.32025+00	337ixisub5tl	374b974c-ac24-4f9d-87be-a331e33dbbae
00000000-0000-0000-0000-000000000000	699	agejr5w7viin	bc729450-c4d8-450a-bf83-215288d70e0a	f	2026-05-20 03:31:09.663971+00	2026-05-20 03:31:09.663971+00	\N	8aa50bca-575e-4407-9041-12c06b377c61
00000000-0000-0000-0000-000000000000	520	thteh6dvx47l	5d623cd2-7471-4ffc-8341-f55de82f5b7c	f	2026-02-09 13:50:12.51808+00	2026-02-09 13:50:12.51808+00	\N	29f8bd95-4db3-446a-8419-28a8bb8457e5
00000000-0000-0000-0000-000000000000	521	b3kkfxzp5iy5	a6a516f4-345e-4af4-a95d-fcab95a375c4	f	2026-02-09 13:51:32.727892+00	2026-02-09 13:51:32.727892+00	\N	a28c68aa-7f49-4751-a759-75eb7104c377
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
48436920-6440-4dc6-ab5e-ccc38c1e1018	3a90fa1a-c502-40ab-8d7a-3fff14060570	2026-06-04 17:03:14.533617+00	2026-06-04 20:00:50.360951+00	\N	aal1	\N	2026-06-04 20:00:50.360849	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
d2184e84-daff-4601-8b86-ba5a586ba2a7	29181cd1-c18d-42e9-b0a8-7f13ec976837	2026-06-02 02:47:13.033467+00	2026-06-02 02:47:13.033467+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
9aa114af-caed-4e23-abb1-9d42c8b217c3	1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7	2026-02-10 15:32:18.881673+00	2026-02-10 15:32:18.881673+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
9ca93e6f-cc2f-4ffc-a9ab-e60f9012c2b5	47739d07-5148-4e33-9aee-d236406d760e	2026-02-10 15:32:55.890392+00	2026-02-10 15:32:55.890392+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
6ac8c977-ae1c-4dac-991b-3e1975be6e7b	83bb0944-5672-4759-b72b-37deea537a47	2026-02-10 15:36:26.893772+00	2026-02-10 15:36:26.893772+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
48a42d8d-3e2b-468e-9b5b-19f36e892592	5dc9910f-4d2e-4fae-8907-0fe3b596cde0	2026-02-10 15:37:15.556523+00	2026-02-10 15:37:15.556523+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
1144fabc-c0f0-42aa-910c-becb5c7a358a	937926f9-3c6b-46d2-9cf3-341479442747	2026-02-10 15:38:11.881493+00	2026-02-10 15:38:11.881493+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
ab3a3e04-0ced-4e6c-9d6b-c37949b8e0c5	29181cd1-c18d-42e9-b0a8-7f13ec976837	2026-06-02 02:47:21.341215+00	2026-06-02 02:47:21.341215+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
3d9ae19a-4853-4f9e-a731-1840ef689672	3a90fa1a-c502-40ab-8d7a-3fff14060570	2026-06-03 20:49:17.51537+00	2026-06-04 16:51:02.495836+00	\N	aal1	\N	2026-06-04 16:51:02.495726	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
c04aab6c-cb3a-41dc-b22b-84ceef8ba03e	29181cd1-c18d-42e9-b0a8-7f13ec976837	2026-06-02 02:47:44.278993+00	2026-06-02 02:47:44.278993+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
ceec6a65-1fb9-4e9a-9b92-e8c3771a8e07	29181cd1-c18d-42e9-b0a8-7f13ec976837	2026-06-02 02:47:47.936655+00	2026-06-02 02:47:47.936655+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
24f9b27b-6e90-4a5f-a9a5-956880b3e2ad	29181cd1-c18d-42e9-b0a8-7f13ec976837	2026-06-02 02:48:08.54637+00	2026-06-02 02:48:08.54637+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
7866603f-b82d-4b43-83d4-1d5e3c93d66e	29181cd1-c18d-42e9-b0a8-7f13ec976837	2026-06-02 02:48:10.991771+00	2026-06-02 02:48:10.991771+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
fd9058a2-3f27-4351-ad53-86728f5b2d91	7ebe0e88-8f7d-4583-9e84-0b1c5d561918	2026-06-02 03:10:49.784737+00	2026-06-02 03:10:49.784737+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
fd64124a-8c46-45e7-b0f5-76a790159fae	0e495a05-fc94-4a96-b7d8-0ebed3cf3f95	2026-06-02 03:18:41.506662+00	2026-06-02 03:18:41.506662+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
23715c15-14fc-48de-b7bc-631fb0d0117c	e836b53c-0eb8-4c93-9e8c-e972aab5b995	2026-01-19 19:02:23.64549+00	2026-01-19 19:02:23.64549+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	186.178.64.250	\N	\N	\N	\N	\N
19228195-8fa6-4e89-851f-7ac0200b9f44	55db67b3-bc35-4671-81f3-a996a5350425	2026-01-19 19:06:30.739003+00	2026-01-19 19:06:30.739003+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	186.178.64.250	\N	\N	\N	\N	\N
132441ca-ddc1-4684-807a-b8963422747e	009551f7-f973-4e33-82c5-cc7f2171e07f	2026-01-19 19:08:45.451003+00	2026-01-19 19:08:45.451003+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	186.178.64.250	\N	\N	\N	\N	\N
0897c0fc-a151-4d9e-85af-0ef20dec0ccf	27226334-0bfb-4d86-9a02-1fe3763995ed	2026-01-19 19:12:47.326816+00	2026-01-19 19:12:47.326816+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	186.178.64.250	\N	\N	\N	\N	\N
427497da-88cc-4f40-b912-4b9785237ae6	29181cd1-c18d-42e9-b0a8-7f13ec976837	2026-06-02 02:46:39.769051+00	2026-06-02 02:46:39.769051+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
53b5a674-cd1e-43e4-84bb-ac00c44e2092	92a11fb0-ed08-4d87-9ae4-e7bac360a51d	2026-02-12 14:24:04.529354+00	2026-02-12 14:24:04.529354+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
fed8dd6c-9bc9-494c-92e7-f077e8d7b46f	91976250-d16f-48f5-9315-c89017ed5980	2026-02-12 14:24:54.798+00	2026-02-12 16:32:52.791375+00	\N	aal1	\N	2026-02-12 16:32:52.790665	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	187.251.166.129	\N	\N	\N	\N	\N
904af32b-42c8-4161-a8fd-90b9f87b34b2	6bd6fd48-7433-4526-8803-516660c1103a	2026-01-22 16:27:30.018841+00	2026-01-22 16:27:30.018841+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	187.251.166.129	\N	\N	\N	\N	\N
9556e7b7-f450-47ce-9c0f-6c255cf91a59	3a90fa1a-c502-40ab-8d7a-3fff14060570	2026-06-02 04:47:21.003206+00	2026-06-02 04:47:21.003206+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
29f8bd95-4db3-446a-8419-28a8bb8457e5	5d623cd2-7471-4ffc-8341-f55de82f5b7c	2026-02-09 13:50:12.516743+00	2026-02-09 13:50:12.516743+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
a28c68aa-7f49-4751-a759-75eb7104c377	a6a516f4-345e-4af4-a95d-fcab95a375c4	2026-02-09 13:51:32.726567+00	2026-02-09 13:51:32.726567+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
fd66d27e-82cc-4469-b853-701d0da933e5	9247ea7b-2d1d-45b3-b037-6ec04945be81	2026-02-10 15:17:41.296544+00	2026-02-10 15:17:41.296544+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
374b974c-ac24-4f9d-87be-a331e33dbbae	3a90fa1a-c502-40ab-8d7a-3fff14060570	2026-06-02 04:41:22.067713+00	2026-06-08 22:02:27.367232+00	\N	aal1	\N	2026-06-08 22:02:27.367103	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	200.85.80.14	\N	\N	\N	\N	\N
3a673fa5-9437-406b-af7a-17fa3958dd4f	18a33406-19e8-4e01-a292-bf1cd1af8c65	2026-02-10 15:24:03.518309+00	2026-02-10 15:24:03.518309+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
1aabb745-3212-4877-a984-08ecb3fbd15c	28f6c2fe-742e-4188-b53d-700ba85aec4c	2026-02-09 14:36:25.343509+00	2026-02-09 14:36:25.343509+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
984fe04c-d7c1-4da3-bf65-bc9dbfb2e78e	88bbd661-7479-4a84-b9ef-4f32da93ff26	2026-02-09 14:40:47.156416+00	2026-02-09 14:40:47.156416+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
e130642a-fa10-4b28-a9b1-a6290e61be6c	7b542b46-6fbd-4176-bbbb-5cf594c49da2	2026-02-09 14:45:35.278429+00	2026-02-09 14:45:35.278429+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
a0c39278-6d8e-4fa6-8163-9284414d7395	6c94d34d-5856-4649-8998-7eb1090fdf09	2026-02-09 14:47:13.86703+00	2026-02-09 14:47:13.86703+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
c2046a2c-c7e1-4fd9-879f-db77facdd399	811c750f-97ad-4705-8156-9cdf28b37323	2026-02-09 14:48:57.136327+00	2026-02-09 14:48:57.136327+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
f3441fdd-bcd3-4f19-84cb-ab295e359592	75424ae3-8fbd-4752-8c5c-2bb5e38be82f	2026-02-09 14:50:48.039901+00	2026-02-09 14:50:48.039901+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
77b2fb2d-4d26-499a-806b-822122780a0f	520498cc-f65a-42a2-97b6-22f766b06cfc	2026-02-09 14:53:18.23019+00	2026-02-09 14:53:18.23019+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
304a3bd2-f2f3-4e03-afee-90b6ecb88f13	d39fd319-3593-4ddc-840a-5a89f73a3d75	2026-02-09 14:58:09.199118+00	2026-02-09 14:58:09.199118+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
e6064adf-07d4-49db-8f6e-f14066cb0bf6	2e05a86b-6966-4266-a17a-cedc2aad1567	2026-02-09 15:00:31.435413+00	2026-02-09 15:00:31.435413+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
ef87e6ff-57a2-497d-bc82-b8dd0c54abb1	a12584c4-19a5-4716-83d9-e0bb42fbf002	2026-02-09 15:02:13.338104+00	2026-02-09 15:02:13.338104+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
d00b2cbb-ff8a-4d10-88f6-9d5a2a5fec17	e180edb5-9a66-4602-9e4a-17a4c9c70d92	2026-02-09 15:04:53.487845+00	2026-02-09 15:04:53.487845+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
c554c052-2d7f-4209-a2ba-a0e3c17eaed0	d81fa5d0-b828-47be-bf4f-d04e151c937f	2026-02-09 15:07:00.887923+00	2026-02-09 15:07:00.887923+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
c36a6312-7838-4e8b-ba18-bc234c897a34	f681ddbe-c67f-44f1-9969-31b64b4c879a	2026-02-09 15:07:53.55057+00	2026-02-09 15:07:53.55057+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
f56bd577-ce66-49f1-9d0c-203a01afcdc7	00aff592-6206-428c-9476-2ca0e5c985bf	2026-02-09 15:08:45.921242+00	2026-02-09 15:08:45.921242+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
e98c5f58-05f5-469e-a029-f1aee849a7ae	f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e	2026-02-09 15:12:41.581258+00	2026-02-09 15:12:41.581258+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
27c4c83d-5e6f-4c60-ba07-65d817018b34	7524e67f-698f-40b6-8424-26f05bac35e1	2026-02-10 15:27:16.060911+00	2026-02-10 15:27:16.060911+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
4dfea4d6-64c5-4881-9bc5-3308a3612fe0	02d3430e-9601-4b3b-a6d6-e9390872b54b	2026-02-10 15:28:14.401471+00	2026-02-10 15:28:14.401471+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
ef420784-7f91-4bd5-a43c-be4b7f858cf5	f5def64f-2c9e-4165-9302-4c4870991dad	2026-02-10 15:29:01.458266+00	2026-02-10 15:29:01.458266+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
dd7a901f-3406-4c37-aa5c-cb5d027da249	9b79fcf6-f192-4364-80ec-ab95b18c87e3	2026-02-10 15:29:58.858421+00	2026-02-10 15:29:58.858421+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
28319db4-fc62-42d7-9d5c-fea746073c1f	7bab67c8-74d3-4a9e-a2b1-990223186d4e	2026-02-10 15:31:18.342029+00	2026-02-10 15:31:18.342029+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
b62eeba1-d92b-4804-86e7-8b49eb3591ce	40e4b506-1d73-4298-8d8b-2011f8e24bef	2026-02-10 15:34:51.33021+00	2026-02-10 15:34:51.33021+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
06551f01-fca2-41b9-954d-b9545e6dc7cd	8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8	2026-02-10 15:35:47.051965+00	2026-02-10 15:35:47.051965+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
7f82ac4c-af88-4a66-b2e1-8f541e84ca66	27356752-78d4-4833-bdbc-ac5ceb23883e	2026-02-10 15:40:40.9264+00	2026-02-10 15:40:40.9264+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
5f226324-632f-40ed-b8c1-357e9527dc42	a883d161-ec1f-497b-91c6-16543a922792	2026-02-10 15:42:12.698686+00	2026-02-10 15:42:12.698686+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
9e3772ee-2bcb-42be-85a0-ffa1119d27f9	242a6366-d3f0-4a5a-ba81-0db7aed6ac63	2026-02-10 15:46:03.442768+00	2026-02-10 15:46:03.442768+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	200.107.59.82	\N	\N	\N	\N	\N
873d6507-898e-4560-b2ac-399ebc365111	07010bce-5076-4553-9a09-2a95b20e0e8b	2026-06-02 03:15:10.746386+00	2026-06-02 03:15:10.746386+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
0e1a97bd-90ea-4c99-a61b-e090336da21b	14ce5450-53d1-4997-aa2d-6c182759611d	2026-06-02 03:22:40.751426+00	2026-06-02 03:22:40.751426+00	\N	aal1	\N	\N	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
8aa50bca-575e-4407-9041-12c06b377c61	bc729450-c4d8-450a-bf83-215288d70e0a	2026-05-20 03:31:09.651188+00	2026-05-20 03:31:09.651188+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	157.100.199.242	\N	\N	\N	\N	\N
6ef4f562-48fa-4757-a576-f93189fecf5c	3a90fa1a-c502-40ab-8d7a-3fff14060570	2026-06-02 04:50:00.953947+00	2026-06-02 04:50:00.953947+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	200.124.249.158	\N	\N	\N	\N	\N
96bb8670-7812-4db8-a89b-0bb9b6759732	8d999d39-7910-409f-a2ef-1b83c369843a	2026-05-23 14:29:13.891706+00	2026-05-23 14:29:13.891706+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	177.234.226.114	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	3a90fa1a-c502-40ab-8d7a-3fff14060570	authenticated	authenticated	ynlldom@gmail.com	$2a$10$DnS3vFSQT9tjgG26arLK2OrptvyHHUeVQUya2EZwHMEyEHZOIxDPi	2025-10-18 21:23:37.280796+00	\N		2025-10-18 21:23:06.603111+00		\N			\N	2026-06-04 17:03:14.532545+00	{"provider": "email", "providers": ["email"]}	{"rol": "visitante", "sub": "3a90fa1a-c502-40ab-8d7a-3fff14060570", "email": "ynlldom@gmail.com", "nombre": "Administrador", "email_verified": true, "phone_verified": false}	\N	2025-10-18 21:23:06.472876+00	2026-06-08 22:02:27.354645+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	0e773dca-0696-446d-8700-d934e7cd5151	authenticated	authenticated	tatiana.zambrano@utm.edu.ec	$2a$10$YaKjmr4ob5Mj6tDsqQ9Nqetx6N03pkUdJlT5b7F64oJjLCGE2aa6W	2025-10-21 13:23:43.053889+00	\N		2025-10-21 13:22:28.35064+00		\N			\N	2025-10-21 13:46:47.037699+00	{"provider": "email", "providers": ["email"]}	{"rol": "visitante", "sub": "0e773dca-0696-446d-8700-d934e7cd5151", "email": "tatiana.zambrano@utm.edu.ec", "nombre": "Tatiana Zambrano", "email_verified": true, "phone_verified": false}	\N	2025-10-21 13:22:28.174197+00	2025-10-21 15:32:19.688657+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e26adb54-7dcd-48a7-96c9-df6604bed15a	authenticated	authenticated	arteagayanelly23@gmail.com	$2a$10$/SAiFPXavbzhh/YnuusAluFIFLLANJnNmaabfkyyQekKSBL7yWZ/K	2025-10-20 23:18:38.973113+00	\N		2025-10-20 23:07:38.924272+00		\N			\N	2025-10-21 02:36:05.75391+00	{"provider": "email", "providers": ["email"]}	{"rol": "visitante", "sub": "e26adb54-7dcd-48a7-96c9-df6604bed15a", "email": "arteagayanelly23@gmail.com", "nombre": "estudiante 1", "email_verified": true, "phone_verified": false}	\N	2025-10-20 23:07:38.839691+00	2025-10-21 02:36:05.757677+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a721cb76-7b06-4025-afed-d62c9f579550	authenticated	authenticated	yanellyart@didactikapp.com	$2a$10$mn40C0ZgqvgP3dSbuqjoSu5jPMCctYSwM3N07WzQAmOrlGftrS94W	\N	\N	62685d918e60e970f18a6c855174b6cc7f0b20d7077658396935d569	2026-01-19 03:49:52.14357+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "a721cb76-7b06-4025-afed-d62c9f579550", "email": "yanellyart@didactikapp.com", "nombre": "Yanelly Arteaga", "usuario": "yanellyart", "email_verified": false, "phone_verified": false}	\N	2026-01-19 03:49:52.047855+00	2026-01-19 03:49:52.382489+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	233d26ed-f72e-4ff7-b859-2b8b48b8c6b3	authenticated	authenticated	merart@didactikapp.com	$2a$10$8cdfOUgvgOgIuLDkrswQWeinFKhF7dzn2bKEQFD.oUaFaRHr7oZPK	\N	\N	2d9313b64b529ae368f1372c5b6ec2a5c8cfab4f6848820f065525ae	2026-01-19 04:07:42.036659+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "233d26ed-f72e-4ff7-b859-2b8b48b8c6b3", "email": "merart@didactikapp.com", "nombre": "Mercedes Arteaga", "usuario": "merart", "email_verified": false, "phone_verified": false}	\N	2026-01-19 04:07:41.977447+00	2026-01-19 04:07:42.214239+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	84d3eaaf-2a36-42c4-b3e5-b93ac3fe9ae9	authenticated	authenticated	yarteaga23@didactikapp.com	$2a$10$N5qlVNCv4cbS91mWTiOtGea7o3ABqBGh.hdEYLkRLNWna9SVbAJOG	\N	\N	ff8acc3e9186e6c35298a6e49fc5fc0fc8a4cf837f165e3b3fbfb815	2026-01-19 04:01:33.563065+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "84d3eaaf-2a36-42c4-b3e5-b93ac3fe9ae9", "email": "yarteaga23@didactikapp.com", "nombre": "Yanelly Arteaga", "usuario": "yarteaga23", "email_verified": false, "phone_verified": false}	\N	2026-01-19 04:01:33.501441+00	2026-01-19 04:01:33.807033+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	9d0f2934-0bf1-4eae-9fa4-234870fb66cb	authenticated	authenticated	danivm@didactikapp.com	$2a$10$y1Khod9.S5z.WVSmVnFkMeDiXyMg4xiW/JfGO/8dn2HsP1sArX2cy	\N	\N	e2935630d29cfc885fec819682910e0e995a6553b019d1288373ea75	2026-01-19 04:21:18.541889+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "9d0f2934-0bf1-4eae-9fa4-234870fb66cb", "email": "danivm@didactikapp.com", "nombre": "Daniela Villamarin", "usuario": "danivm", "email_verified": false, "phone_verified": false}	\N	2026-01-19 04:21:18.519607+00	2026-01-19 04:21:18.811721+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d1fd4826-8e5a-4cae-9222-aef526df4961	authenticated	authenticated	estudiante1@didactikapp.com	$2a$10$aDVykFK/Sf09duQQBcsum.eIgMGxbUa8b7VFYzvOowwN8XsXR6u12	2026-01-19 18:51:24.341063+00	\N		\N		\N			\N	2026-01-19 18:51:24.348731+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "d1fd4826-8e5a-4cae-9222-aef526df4961", "email": "estudiante1@didactikapp.com", "nombre": "Estudiante1", "usuario": "estudiante1", "email_verified": true, "phone_verified": false}	\N	2026-01-19 18:51:24.303582+00	2026-01-19 18:51:24.374074+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ecfe53a4-3b92-472e-bcf0-f77807681f84	authenticated	authenticated	kengart@didactikapp.com	$2a$10$qLjyvfyWRcM0SnQXieJr6.7GB/8vovmjy9IUEM2AxGdBiTBZ3eqCC	\N	\N	b1615c6b98a06d6a9401aaacfcaf505cf19032672711b4415694abc5	2026-01-19 04:11:08.631531+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "ecfe53a4-3b92-472e-bcf0-f77807681f84", "email": "kengart@didactikapp.com", "nombre": "Kevin Arteaga", "usuario": "kengart", "email_verified": false, "phone_verified": false}	\N	2026-01-19 04:11:08.579855+00	2026-01-19 04:11:08.820365+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e836b53c-0eb8-4c93-9e8c-e972aab5b995	authenticated	authenticated	estudiante1@didactikapp.local	$2a$10$XF1kppvtE2pw0cFE2VRCHOgcW9DoS.y9OE7unzpCuvpTKTPyVBKeS	2026-01-19 19:02:23.637437+00	\N		\N		\N			\N	2026-01-19 19:02:23.645377+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "e836b53c-0eb8-4c93-9e8c-e972aab5b995", "email": "estudiante1@didactikapp.local", "nombre": "Estudiante1", "usuario": "estudiante1", "email_verified": true, "phone_verified": false}	\N	2026-01-19 19:02:23.603037+00	2026-01-19 19:02:23.648175+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	009551f7-f973-4e33-82c5-cc7f2171e07f	authenticated	authenticated	estudiante3@didactikapp.com	$2a$10$FhSm88VbfC1NDJ/y/D1R/ef5nEPk7sCRP7GT6Bed6Odn68o4S/zzi	2026-01-19 19:08:45.446701+00	\N		\N		\N			\N	2026-01-19 19:08:45.450902+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "009551f7-f973-4e33-82c5-cc7f2171e07f", "email": "estudiante3@didactikapp.com", "nombre": "Estudiante3", "usuario": "estudiante3", "email_verified": true, "phone_verified": false}	\N	2026-01-19 19:08:45.435601+00	2026-01-19 19:08:45.453617+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	0aff3647-bda6-48f4-9e6a-4bf9d1f9e118	authenticated	authenticated	donobansarangundi@didactikapp.com	$2a$10$72ArmUhmkeZUJVi9kumt5.FXrVpzCCy/cFFQIW7qJF9qbGdTuUkAy	2026-02-09 13:48:17.29961+00	\N		\N		\N			\N	2026-02-09 15:21:27.767636+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "0aff3647-bda6-48f4-9e6a-4bf9d1f9e118", "email": "donobansarangundi@didactikapp.com", "nombre": "Donoban S Arangundi Criollo", "usuario": "donobansarangundi", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 13:48:17.288639+00	2026-02-09 15:21:27.77143+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7ebe0e88-8f7d-4583-9e84-0b1c5d561918	authenticated	authenticated	merlypaola@didactikapp.com	$2a$10$Jw8e6uXjhtaKtG7LxtOjuOHAsdYQqZHHeUDM.urFUhQj923FdXxRm	2026-06-02 03:10:49.774419+00	\N		\N		\N			\N	2026-06-02 03:10:49.783665+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "7ebe0e88-8f7d-4583-9e84-0b1c5d561918", "email": "merlypaola@didactikapp.com", "nombre": "admin2", "usuario": "merlypaola", "email_verified": true, "phone_verified": false}	\N	2026-06-02 03:10:49.70806+00	2026-06-02 03:10:49.821685+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a6a516f4-345e-4af4-a95d-fcab95a375c4	authenticated	authenticated	pedrocampos@didactikapp.com	$2a$10$keEOQqYchPfBtgeKqujWXOjC.RIf6P1TD/8vFDSUkuzohgG/M23lK	2026-02-09 13:51:32.722651+00	\N		\N		\N			\N	2026-02-09 13:51:32.726481+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "a6a516f4-345e-4af4-a95d-fcab95a375c4", "email": "pedrocampos@didactikapp.com", "nombre": "Pedro Elias Campos Chiguita", "usuario": "pedrocampos", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 13:51:32.711918+00	2026-02-09 13:51:32.729979+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4	authenticated	authenticated	estudiante5@didactikapp.com	$2a$10$WphnDOXZ0UrORVqIGay45.TCNRPXIzO5qlRKusi/o1jaINVqaZhqm	2026-02-09 04:07:36.174145+00	\N		\N		\N			\N	2026-02-09 04:08:17.620567+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "e19b8658-6ab4-455d-a6f1-ca3da2aa1ad4", "email": "estudiante5@didactikapp.com", "nombre": "estudiante5", "usuario": "estudiante5", "grupo_id": "3c37d832-e781-44e8-bf45-e4a82e42ae72", "email_verified": true, "phone_verified": false}	\N	2026-02-09 04:07:36.118603+00	2026-02-09 13:34:53.331676+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6bd6fd48-7433-4526-8803-516660c1103a	authenticated	authenticated	mer123@didactikapp.com	$2a$10$eCybVL4ZwjbNVrL99OpH9OJDKGMC66Zt6cwwmyunZw3K/6XnP7k76	2026-01-22 16:27:29.991272+00	\N		\N		\N			\N	2026-01-22 16:27:30.016741+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "6bd6fd48-7433-4526-8803-516660c1103a", "email": "mer123@didactikapp.com", "nombre": "Merly Zambrannn", "usuario": "mer123", "grupo_id": "d305e415-7036-4bbb-ae94-af93c858d220", "email_verified": true, "phone_verified": false}	\N	2026-01-22 16:27:29.890378+00	2026-01-22 16:27:30.044262+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	29181cd1-c18d-42e9-b0a8-7f13ec976837	authenticated	authenticated	yarteaga4576@utm.edu.ec	$2a$10$m1i2lKiqUlKgBKAqpxFPxuu6Qz/DvK0VY69F8dVGaz0WmvR.d3WfG	2026-06-02 02:46:39.755877+00	\N		\N		\N			\N	2026-06-02 02:48:10.991672+00	{"provider": "email", "providers": ["email"]}	{"rol": "visitante", "sub": "29181cd1-c18d-42e9-b0a8-7f13ec976837", "email": "yarteaga4576@utm.edu.ec", "nombre": "Merly Paola", "email_verified": true, "phone_verified": false}	\N	2026-06-02 02:46:39.727401+00	2026-06-02 02:48:10.993356+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	28f6c2fe-742e-4188-b53d-700ba85aec4c	authenticated	authenticated	juandavidcarreno@didactikapp.com	$2a$10$/8JRTOCRv0zlpMq9WSJxpuaWGbQQZcG7hcKrYPxQxuu2Uv2yxXUbC	2026-02-09 14:36:25.329192+00	\N		\N		\N			\N	2026-02-09 14:36:25.342159+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "28f6c2fe-742e-4188-b53d-700ba85aec4c", "email": "juandavidcarreno@didactikapp.com", "nombre": "Juan David Carreño Guatarama", "usuario": "juandavidcarreno", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 14:36:25.261229+00	2026-02-09 14:36:25.386795+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7b542b46-6fbd-4176-bbbb-5cf594c49da2	authenticated	authenticated	luischilan@didactikapp.com	$2a$10$QY4fSgFYXXSoWgijX0txN.dy09FtHcm5Nw5Q0Z1mx0Vc/1xlJbB.m	2026-02-09 14:45:35.273825+00	\N		\N		\N			\N	2026-02-09 14:45:35.277713+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "7b542b46-6fbd-4176-bbbb-5cf594c49da2", "email": "luischilan@didactikapp.com", "nombre": "Luis Sebastian Chilan Bachicorea", "usuario": "luischilan", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 14:45:35.238535+00	2026-02-09 14:45:35.285662+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	55db67b3-bc35-4671-81f3-a996a5350425	authenticated	authenticated	estudiante2@didactikapp.com	$2a$10$UxBd5Im0GuokSMfm9zD9VeI4e8hqCvenaTXddNew1SFTebGrPS6se	2026-01-19 19:06:30.727153+00	\N		\N		\N			\N	2026-01-19 19:06:30.738897+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "55db67b3-bc35-4671-81f3-a996a5350425", "email": "estudiante2@didactikapp.com", "nombre": "Estudiante2", "usuario": "estudiante2", "email_verified": true, "phone_verified": false}	\N	2026-01-19 19:06:30.681415+00	2026-01-19 19:06:30.750273+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	811c750f-97ad-4705-8156-9cdf28b37323	authenticated	authenticated	sashachilan@didactikapp.com	$2a$10$/jWGtw/wctWe85JIKWZ2C.j5M9Ybsjpcs7aZWRDMMRx9F72uTwMUO	2026-02-09 14:48:57.132041+00	\N		\N		\N			\N	2026-02-09 14:48:57.136232+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "811c750f-97ad-4705-8156-9cdf28b37323", "email": "sashachilan@didactikapp.com", "nombre": "Sasha Ariana Chilan Posligua", "usuario": "sashachilan", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 14:48:57.117922+00	2026-02-09 14:48:57.140259+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	5d623cd2-7471-4ffc-8341-f55de82f5b7c	authenticated	authenticated	renathaarteaga@didactikapp.com	$2a$10$8r8SQG2GiBz9Js5.YV1TEOKPKZmvI6hnZiIvPE0HHTq2KFO.6CqLy	2026-02-09 13:50:12.511469+00	\N		\N		\N			\N	2026-02-09 13:50:12.515029+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "5d623cd2-7471-4ffc-8341-f55de82f5b7c", "email": "renathaarteaga@didactikapp.com", "nombre": "Renatha Isabella Arteaga Cedeño", "usuario": "renathaarteaga", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 13:50:12.499389+00	2026-02-09 13:50:12.52005+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	27226334-0bfb-4d86-9a02-1fe3763995ed	authenticated	authenticated	estudiante4@didactikapp.com	$2a$10$KIL/FAIiOKJ5UrysoOJ.x.fmUvEvvgDD40HblpTk/NGgPKO2kV3qy	2026-01-19 19:12:47.322575+00	\N		\N		\N			\N	2026-01-19 19:12:47.326719+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "27226334-0bfb-4d86-9a02-1fe3763995ed", "email": "estudiante4@didactikapp.com", "nombre": "Estudiante4", "usuario": "estudiante4", "email_verified": true, "phone_verified": false}	\N	2026-01-19 19:12:47.308991+00	2026-01-19 19:12:47.329256+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e6059964-8108-4ff1-a812-f6eca0cbd3f7	authenticated	authenticated	miaalava@didactikapp.com	$2a$10$BQJoLjnYkXlrQiHi5VP3XO/zCg9xX6UQOI9YzSvVL2jLdVMU1x3oW	2026-02-09 13:46:49.868799+00	\N		\N		\N			\N	2026-02-09 15:19:40.842424+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "e6059964-8108-4ff1-a812-f6eca0cbd3f7", "email": "miaalava@didactikapp.com", "nombre": "Mia Fiorella Alava Pin", "usuario": "miaalava", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 13:46:49.813894+00	2026-02-09 15:19:40.844341+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ce486e2e-89f5-49ed-91f1-95c760d9e602	authenticated	authenticated	puchi.merart@gmail.com	$2a$10$viXf6Qj.OPi7Bi6wIiJVyOFIco6CzDT8B01pSjh1i5.8rQ2Ylr9kG	2026-06-02 02:52:01.568385+00	\N		\N		\N			\N	2026-06-02 02:52:01.575753+00	{"provider": "email", "providers": ["email"]}	{"rol": "visitante", "sub": "ce486e2e-89f5-49ed-91f1-95c760d9e602", "email": "puchi.merart@gmail.com", "nombre": "Merly", "email_verified": true, "phone_verified": false}	\N	2026-06-02 02:52:01.544994+00	2026-06-02 02:52:01.578953+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	88bbd661-7479-4a84-b9ef-4f32da93ff26	authenticated	authenticated	ainhoachavez@didactikapp.com	$2a$10$W7D/KZRwz8Af9bHeiklZ5.bOJXn5Bz1/BN1lfexy4HZr2ERHxVltO	2026-02-09 14:40:47.145222+00	\N		\N		\N			\N	2026-02-09 14:40:47.155706+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "88bbd661-7479-4a84-b9ef-4f32da93ff26", "email": "ainhoachavez@didactikapp.com", "nombre": "Ainhoa Kaitlin Chavez Palma", "usuario": "ainhoachavez", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 14:40:47.121855+00	2026-02-09 14:40:47.163046+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	db36010b-60f9-4d38-bfd1-1fd9063149d7	authenticated	authenticated	spidergay@didactikapp.com	$2a$10$fGD9ASnerRHER1E/DZ5ueOhLKEd6AEQw86P6tpo/F8yxCXBXQ/TNa	2026-01-29 04:18:36.399455+00	\N		\N		\N			\N	2026-01-29 04:18:36.412257+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "db36010b-60f9-4d38-bfd1-1fd9063149d7", "email": "spidergay@didactikapp.com", "nombre": "sneyder", "usuario": "spidergay", "email_verified": true, "phone_verified": false}	\N	2026-01-29 04:18:36.33819+00	2026-01-29 16:26:50.198921+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	1326d366-a9f6-4216-9395-fb904afcb5eb	authenticated	authenticated	josechavez@didactikapp.com	$2a$10$Bjt.VNSe/DQbcFKV2BgbTuOW/hmSMVLgooUGskumMd/wVc4C5KvL6	2026-02-09 13:54:55.658133+00	\N		\N		\N			\N	2026-02-09 14:08:27.019984+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "1326d366-a9f6-4216-9395-fb904afcb5eb", "email": "josechavez@didactikapp.com", "nombre": "Jose Ramon Chavez Rivas", "usuario": "josechavez", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 13:54:55.602631+00	2026-02-09 14:08:27.027706+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6c94d34d-5856-4649-8998-7eb1090fdf09	authenticated	authenticated	matheochilan@didactikapp.com	$2a$10$cHl4fC5tLJ4/krxUDsSmI.P4dK7nJ2dRNwgjAM88Dj7JGGSdmWYBa	2026-02-09 14:47:13.856542+00	\N		\N		\N			\N	2026-02-09 14:47:13.865771+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "6c94d34d-5856-4649-8998-7eb1090fdf09", "email": "matheochilan@didactikapp.com", "nombre": "Matheo Leonel Chilan Pinargote", "usuario": "matheochilan", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 14:47:13.831339+00	2026-02-09 14:47:13.87573+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	75424ae3-8fbd-4752-8c5c-2bb5e38be82f	authenticated	authenticated	guillermofernandez@didactikapp.com	$2a$10$TOYIjwxomBkFK.0gYA5XMOOmRBNrgYlX6jJf9BmtjZen3EdzvDj8K	2026-02-09 14:50:48.034629+00	\N		\N		\N			\N	2026-02-09 14:50:48.039812+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "75424ae3-8fbd-4752-8c5c-2bb5e38be82f", "email": "guillermofernandez@didactikapp.com", "nombre": "Guillermo F Fernandez Alcivar", "usuario": "guillermofernandez", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 14:50:48.024858+00	2026-02-09 14:50:48.042528+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d81fa5d0-b828-47be-bf4f-d04e151c937f	authenticated	authenticated	ailenmolina@didactikapp.com	$2a$10$zUoPvnnyAYouhtCw3vhYvOvFaVY9YI/nT4bs47Q91nLMAZ6u03Kze	2026-02-09 15:07:00.882606+00	\N		\N		\N			\N	2026-02-09 15:07:00.88784+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "d81fa5d0-b828-47be-bf4f-d04e151c937f", "email": "ailenmolina@didactikapp.com", "nombre": "Ailen Dariela Molina Palma", "usuario": "ailenmolina", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 15:07:00.866967+00	2026-02-09 15:07:00.894052+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2e05a86b-6966-4266-a17a-cedc2aad1567	authenticated	authenticated	jimmymedranda@didactikapp.com	$2a$10$JdujeXrDaz2B541MgCTGLeLz75v8fGQqiUO2CRv6gmoL8IgMAcsKO	2026-02-09 15:00:31.431635+00	\N		\N		\N			\N	2026-02-09 15:00:31.435325+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "2e05a86b-6966-4266-a17a-cedc2aad1567", "email": "jimmymedranda@didactikapp.com", "nombre": "Jimmy Jael Medranda Pico", "usuario": "jimmymedranda", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 15:00:31.42134+00	2026-02-09 15:00:31.437969+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	520498cc-f65a-42a2-97b6-22f766b06cfc	authenticated	authenticated	ahitannamiley@didactikapp.com	$2a$10$oNCEwl1mL0xkhvdNsLaQGuKP46/ncSpaetsURogz1sqnnZ3bwWyb2	2026-02-09 14:53:18.22501+00	\N		\N		\N			\N	2026-02-09 14:53:18.230105+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "520498cc-f65a-42a2-97b6-22f766b06cfc", "email": "ahitannamiley@didactikapp.com", "nombre": "Mendoza", "usuario": "ahitannamiley", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 14:53:18.215193+00	2026-02-09 14:53:18.232785+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d39fd319-3593-4ddc-840a-5a89f73a3d75	authenticated	authenticated	sophiemala@didactikapp.com	$2a$10$GOWHKzFYo7tRXFIsdaEHguzhoL7f0lgbMi9tpHZZCZaAlL8OEVpMy	2026-02-09 14:58:09.194771+00	\N		\N		\N			\N	2026-02-09 14:58:09.19903+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "d39fd319-3593-4ddc-840a-5a89f73a3d75", "email": "sophiemala@didactikapp.com", "nombre": "Sophie Monserrat Mala Palma", "usuario": "sophiemala", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 14:58:09.1848+00	2026-02-09 14:58:09.201666+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f681ddbe-c67f-44f1-9969-31b64b4c879a	authenticated	authenticated	keylamolina@didactikapp.com	$2a$10$6U6iDJt9RoGo7ef87pHjwuh6mMDwWKHJSGpvvczBUJ.fY4lcOftFm	2026-02-09 15:07:53.547555+00	\N		\N		\N			\N	2026-02-09 15:07:53.550491+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "f681ddbe-c67f-44f1-9969-31b64b4c879a", "email": "keylamolina@didactikapp.com", "nombre": "Keyla Oana Molina Garcia", "usuario": "keylamolina", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 15:07:53.541865+00	2026-02-09 15:07:53.552896+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a12584c4-19a5-4716-83d9-e0bb42fbf002	authenticated	authenticated	tiagomendoza@didactikapp.com	$2a$10$R2aNJkTx6wsIC/WkOk6xE.bko4lkuG1YwuqHoke4h3Oopr9sDa0KG	2026-02-09 15:02:13.331904+00	\N		\N		\N			\N	2026-02-09 15:02:13.33526+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "a12584c4-19a5-4716-83d9-e0bb42fbf002", "email": "tiagomendoza@didactikapp.com", "nombre": "Tiago Alexander Mendoza Reina", "usuario": "tiagomendoza", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 15:02:13.319156+00	2026-02-09 15:02:13.340767+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e180edb5-9a66-4602-9e4a-17a4c9c70d92	authenticated	authenticated	gaelmiranda@didactikapp.com	$2a$10$db6z9eOsBGtuIA7.iUvyOulQ.2UiNE0HkgggfcoiPVbKBYHM2VND.	2026-02-09 15:04:53.474895+00	\N		\N		\N			\N	2026-02-09 15:04:53.487761+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "e180edb5-9a66-4602-9e4a-17a4c9c70d92", "email": "gaelmiranda@didactikapp.com", "nombre": "Gael Dominic Miranda Laz", "usuario": "gaelmiranda", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 15:04:53.436502+00	2026-02-09 15:04:53.507612+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ba0d8cac-1ab0-4319-86cd-6e9840a12111	authenticated	authenticated	ahitannamileylaz@didactikapp.com	$2a$10$ky5rwnZ3P.V9gNbAgWhYdOE0JD2zwOFxmmzkhGwc5Zv5RC2S1KFZ6	2026-02-09 14:56:44.609073+00	\N		\N		\N			\N	2026-02-09 15:24:55.923061+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "ba0d8cac-1ab0-4319-86cd-6e9840a12111", "email": "ahitannamileylaz@didactikapp.com", "nombre": "Ahitanna Miley Laz Mendoza", "usuario": "ahitannamileylaz", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 14:56:44.589269+00	2026-02-09 15:24:55.958393+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	00aff592-6206-428c-9476-2ca0e5c985bf	authenticated	authenticated	marielmolina@didactikapp.com	$2a$10$M/jH6hRhAYIC0.C.xoO6j.XOyK2v/i8LsQRWoDLXpNf1rniSCdjo.	2026-02-09 15:08:45.914692+00	\N		\N		\N			\N	2026-02-09 15:08:45.921153+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "00aff592-6206-428c-9476-2ca0e5c985bf", "email": "marielmolina@didactikapp.com", "nombre": "Mariel Sarahi Molina Vera", "usuario": "marielmolina", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 15:08:45.907309+00	2026-02-09 15:08:45.923627+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	07698bac-d8fb-4e65-982d-27c4d482f909	authenticated	authenticated	yasbethbarrezueta@didactikapp.com	$2a$10$hWSH953kMSlohwvcJeR0n.Ht6OnQXGfeBfcdsXJQKSQRBPbx/I0Ru	2026-02-10 15:19:35.84854+00	\N		\N		\N			\N	2026-02-10 16:26:46.606549+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "07698bac-d8fb-4e65-982d-27c4d482f909", "email": "yasbethbarrezueta@didactikapp.com", "nombre": "Yasbeth Fiorela Barrezueta Cano", "usuario": "yasbethbarrezueta", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:19:35.833086+00	2026-02-10 16:26:46.608353+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2244697e-3126-4d57-af2d-ab28686fc83d	authenticated	authenticated	yuliethrivas@didactikapp.com	$2a$10$VsY1LQM.2Q3uhd3krwIKKutiLgf0SOR93/pya06ris.M1qnb0KbEO	2026-02-09 15:16:15.440644+00	\N		\N		\N			\N	2026-02-09 15:16:38.165382+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "2244697e-3126-4d57-af2d-ab28686fc83d", "email": "yuliethrivas@didactikapp.com", "nombre": "Yulieth Paulette Rivas Palma", "usuario": "yuliethrivas", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 15:16:15.407813+00	2026-02-09 15:16:38.168014+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e	authenticated	authenticated	damarispalacios@didactikapp.com	$2a$10$42w80HMehrcMCeoXxNWvCeAF1IEJKapLyyDobRxN4MWs6mtTfyd9i	2026-02-09 15:12:41.577179+00	\N		\N		\N			\N	2026-02-09 15:12:41.581172+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e", "email": "damarispalacios@didactikapp.com", "nombre": "Damaris Sophia Palacios Lopez", "usuario": "damarispalacios", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 15:12:41.565719+00	2026-02-09 15:12:41.584082+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	9247ea7b-2d1d-45b3-b037-6ec04945be81	authenticated	authenticated	arisleyalava@didactikapp.com	$2a$10$hNGPrk7hScjFuBVdqUnoiugizhe/0g5WFvmf9C0p5JHwccyR6uKNu	2026-02-10 15:17:41.279907+00	\N		\N		\N			\N	2026-02-10 15:17:41.295781+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "9247ea7b-2d1d-45b3-b037-6ec04945be81", "email": "arisleyalava@didactikapp.com", "nombre": "Arisley Ahinoa Alava Arteaga", "usuario": "arisleyalava", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:17:41.208827+00	2026-02-10 15:17:41.341243+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	11133b74-e96b-46b7-9c9c-585824841fe6	authenticated	authenticated	dayrapalma@didactikapp.com	$2a$10$CNK/LGLk4oC1BHUr8wXU1.HcaRU0CtVKAGZRTnxCYKWUW386mlh6a	2026-02-09 15:27:55.156724+00	\N		\N		\N			\N	2026-02-09 15:28:12.994362+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "11133b74-e96b-46b7-9c9c-585824841fe6", "email": "dayrapalma@didactikapp.com", "nombre": "Dayra Iveth Palma Alarcon", "usuario": "dayrapalma", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-09 15:27:55.12912+00	2026-02-09 15:28:12.996123+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8faf560f-ba50-4fc1-b96c-384072c80c90	authenticated	authenticated	josedelgado@didactikapp.com	$2a$10$LJdjWTQ7cc/VZ/yqpmnjZuhBL4TnrbhQ8YvdEvco.MeYmJMma13mO	2026-02-10 15:23:20.8742+00	\N		\N		\N			\N	2026-02-10 15:54:40.295374+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "8faf560f-ba50-4fc1-b96c-384072c80c90", "email": "josedelgado@didactikapp.com", "nombre": "Jose Gerardo Delgado Molina", "usuario": "josedelgado", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:23:20.854009+00	2026-02-10 15:54:40.302061+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	9b07c741-12ea-4816-83ff-6eec722cd7da	authenticated	authenticated	roselinecedeno@didactikapp.com	$2a$10$AP2EOHwlCD0SxC0Ro5bq.uckUl9frtFyUV.qKH5EYR/LLqELAqKNq	2026-02-10 15:22:17.308355+00	\N		\N		\N			\N	2026-02-10 16:21:26.627777+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "9b07c741-12ea-4816-83ff-6eec722cd7da", "email": "roselinecedeno@didactikapp.com", "nombre": "Roselyne Elizabeth Cedeño Posligua", "usuario": "roselinecedeno", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:22:17.297168+00	2026-02-10 16:21:26.632491+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	b60a73bd-7f4b-4062-8407-62cefee3b0d0	authenticated	authenticated	juantuala@didactikapp.com	$2a$10$ScKrzMC.notbvy5XJA6ZveXaDx/WBUqxe1Z7Ic9CLds80aVIrxnJa	2026-02-10 15:20:39.553139+00	\N		\N		\N			\N	2026-02-10 16:24:14.620009+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "b60a73bd-7f4b-4062-8407-62cefee3b0d0", "email": "juantuala@didactikapp.com", "nombre": "Juan Issac Buste Tuala", "usuario": "juantuala", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:20:39.505992+00	2026-02-10 16:24:14.629396+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	18a33406-19e8-4e01-a292-bf1cd1af8c65	authenticated	authenticated	edisongarcia@didactikapp.com	$2a$10$.Q.bGawbtfAVwsKhUFsX6ue24sevesT58TC0hQamSOEriVvroZ.9K	2026-02-10 15:24:03.509495+00	\N		\N		\N			\N	2026-02-10 15:24:03.518189+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "18a33406-19e8-4e01-a292-bf1cd1af8c65", "email": "edisongarcia@didactikapp.com", "nombre": "Edison Gabriel Garcia Tuala", "usuario": "edisongarcia", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:24:03.493359+00	2026-02-10 15:24:03.520605+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	23830ef8-baf0-4b79-bae5-b8c2cfda4931	authenticated	authenticated	dekerlaz@didactikapp.com	$2a$10$JDd5KhzjlsURyk/AviVZF.OzFqq0dRBFsB/HxV0rYCiAz/etIp.oW	2026-02-10 15:26:28.12357+00	\N		\N		\N			\N	2026-02-10 16:00:02.540582+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "23830ef8-baf0-4b79-bae5-b8c2cfda4931", "email": "dekerlaz@didactikapp.com", "nombre": "Deker jose Laz Rodriguez", "usuario": "dekerlaz", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:26:28.112536+00	2026-02-10 16:00:02.542926+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	4ba36fc8-7010-4374-96b4-51d95257be5a	authenticated	authenticated	moisespalma@didactikapp.com	$2a$10$xHscxTSTIwMnOwNsURfv..CrD7P1kllJ4uZp4uhNa7f0ZXNV6X8tS	2026-02-10 15:30:40.119651+00	\N		\N		\N			\N	2026-02-10 16:13:59.740004+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "4ba36fc8-7010-4374-96b4-51d95257be5a", "email": "moisespalma@didactikapp.com", "nombre": "Moises Oseias Palma Correa", "usuario": "moisespalma", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:30:40.109831+00	2026-02-10 16:13:59.753791+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	02d3430e-9601-4b3b-a6d6-e9390872b54b	authenticated	authenticated	jostinmolina@didactikapp.com	$2a$10$HcKpFTMu5GzEJ6ybTID9C.B05xYdVyASWRgeneJApVEJn4WfG4B2G	2026-02-10 15:28:14.398505+00	\N		\N		\N			\N	2026-02-10 15:28:14.401388+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "02d3430e-9601-4b3b-a6d6-e9390872b54b", "email": "jostinmolina@didactikapp.com", "nombre": "Jostin Yeriel Molina Angulo", "usuario": "jostinmolina", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:28:14.392586+00	2026-02-10 15:28:14.403001+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7524e67f-698f-40b6-8424-26f05bac35e1	authenticated	authenticated	samaramarin@didactikapp.com	$2a$10$wALXlXcfOUw2/QXOc2nanO4p7lN0TWbL73FDNiloxjP7bzgYZn54K	2026-02-10 15:27:16.057375+00	\N		\N		\N			\N	2026-02-10 15:27:16.06083+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "7524e67f-698f-40b6-8424-26f05bac35e1", "email": "samaramarin@didactikapp.com", "nombre": "Samara Sherazade Marin Laz", "usuario": "samaramarin", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:27:16.051141+00	2026-02-10 15:27:16.062492+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	771ad79b-34ce-4812-9d05-3914d9ada480	authenticated	authenticated	maytehormaza@didactikapp.com	$2a$10$.8srijPjV6VYv0SqpYOnruYUjpPPBycU2eylM298K9Ob.h.kFqEP6	2026-02-10 15:25:15.771404+00	\N		\N		\N			\N	2026-02-10 16:31:54.251762+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "771ad79b-34ce-4812-9d05-3914d9ada480", "email": "maytehormaza@didactikapp.com", "nombre": "Andrainna Mayte Hormaza Falconez", "usuario": "maytehormaza", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:25:15.759702+00	2026-02-10 16:31:54.265561+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f5def64f-2c9e-4165-9302-4c4870991dad	authenticated	authenticated	mariamoreira@didactikapp.com	$2a$10$BLp6mNLRebUqAYSJ0xWuAudJar9DwnOvFXafmHBzmce001kmrENZ6	2026-02-10 15:29:01.455427+00	\N		\N		\N			\N	2026-02-10 15:29:01.458182+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "f5def64f-2c9e-4165-9302-4c4870991dad", "email": "mariamoreira@didactikapp.com", "nombre": "Maria Jose Moreira Vera", "usuario": "mariamoreira", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:29:01.448404+00	2026-02-10 15:29:01.460425+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	9b79fcf6-f192-4364-80ec-ab95b18c87e3	authenticated	authenticated	ashleymurillo@didactikapp.com	$2a$10$ImRKYvQv4xy4ZkC4v6kVR.o1zvnbpIZ7dpQR6eyx7GpjQLTvh2O.a	2026-02-10 15:29:58.855606+00	\N		\N		\N			\N	2026-02-10 15:29:58.858339+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "9b79fcf6-f192-4364-80ec-ab95b18c87e3", "email": "ashleymurillo@didactikapp.com", "nombre": "Ashley Krilley Murillo Mantuano", "usuario": "ashleymurillo", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:29:58.849723+00	2026-02-10 15:29:58.859984+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	5dc9910f-4d2e-4fae-8907-0fe3b596cde0	authenticated	authenticated	gregorioposligua@didactikapp.com	$2a$10$E6Q.2Myo/Q5P.HTHDv.nJOA76EEjh46O0C/KUTDK6eypmqIt.Yvyy	2026-02-10 15:37:15.553245+00	\N		\N		\N			\N	2026-02-10 15:37:15.556439+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "5dc9910f-4d2e-4fae-8907-0fe3b596cde0", "email": "gregorioposligua@didactikapp.com", "nombre": "Gregorio Xavier Posligua Tejena", "usuario": "gregorioposligua", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:37:15.54618+00	2026-02-10 15:37:15.559053+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	937926f9-3c6b-46d2-9cf3-341479442747	authenticated	authenticated	carlosreyes@didactikapp.com	$2a$10$lRI5v6eR9PDgokQqNMV1LOyoFUq4nPKqLK9fvDGlbs.hyKzzibYfi	2026-02-10 15:38:11.878063+00	\N		\N		\N			\N	2026-02-10 15:38:11.881413+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "937926f9-3c6b-46d2-9cf3-341479442747", "email": "carlosreyes@didactikapp.com", "nombre": "Carlos Mathias Reyes Loor", "usuario": "carlosreyes", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:38:11.872743+00	2026-02-10 15:38:11.883774+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7bab67c8-74d3-4a9e-a2b1-990223186d4e	authenticated	authenticated	miapalma@didactikapp.com	$2a$10$6KapCDEU/o1gyFDsycCKsuFO8AhjChXfIKMTxEn99962EZLRo31xW	2026-02-10 15:31:18.337755+00	\N		\N		\N			\N	2026-02-10 15:31:18.341936+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "7bab67c8-74d3-4a9e-a2b1-990223186d4e", "email": "miapalma@didactikapp.com", "nombre": "Mia Fiorella Palma Laz", "usuario": "miapalma", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:31:18.33068+00	2026-02-10 15:31:18.343662+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	47739d07-5148-4e33-9aee-d236406d760e	authenticated	authenticated	raulpalma@didactikapp.com	$2a$10$7t8E9AeQj40jjPetgGMoSeURpKXNSUTenHvksLcuT1t9QdHEKpUKW	2026-02-10 15:32:55.886629+00	\N		\N		\N			\N	2026-02-10 15:32:55.890257+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "47739d07-5148-4e33-9aee-d236406d760e", "email": "raulpalma@didactikapp.com", "nombre": "Raul Felipe Palma Vera", "usuario": "raulpalma", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:32:55.880009+00	2026-02-10 15:32:55.892098+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8	authenticated	authenticated	domenicaponce@didactikapp.com	$2a$10$Z3Saut1oniUrLn4i8qf9buBpUyYBtoWLpz2pcBiIMljW3Ld2xp4Se	2026-02-10 15:35:47.048383+00	\N		\N		\N			\N	2026-02-10 15:35:47.051878+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8", "email": "domenicaponce@didactikapp.com", "nombre": "Domenica Adamaris Ponce España", "usuario": "domenicaponce", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:35:47.04178+00	2026-02-10 15:35:47.053494+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	40e4b506-1d73-4298-8d8b-2011f8e24bef	authenticated	authenticated	dereckpinargote@didactikapp.com	$2a$10$Fw3072e7lL5YllkXwu1iceUHlCrHjw7wZim/AQbFdYhdJYCZEGJIO	2026-02-10 15:34:51.326787+00	\N		\N		\N			\N	2026-02-10 15:34:51.330127+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "40e4b506-1d73-4298-8d8b-2011f8e24bef", "email": "dereckpinargote@didactikapp.com", "nombre": "Dereck Joel Pinargote Cordoba", "usuario": "dereckpinargote", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:34:51.319869+00	2026-02-10 15:34:51.331765+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7	authenticated	authenticated	enzopalmas@didactikapp.com	$2a$10$6RhDzOMs16P0fYpAuBni1e7mkws1wn70ZwbWGpUvKZZ0h.X0QkdDS	2026-02-10 15:32:18.875415+00	\N		\N		\N			\N	2026-02-10 15:32:18.88157+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7", "email": "enzopalmas@didactikapp.com", "nombre": "Enzo Mathias Palmas Menendez", "usuario": "enzopalmas", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:32:18.831497+00	2026-02-10 15:32:18.893726+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	83bb0944-5672-4759-b72b-37deea537a47	authenticated	authenticated	joseposligua@didactikapp.com	$2a$10$Sh4S1/EqG8gdtRXeU1bVH.QRiTJry0B1iMQpRBwysmlrA1ifka1b6	2026-02-10 15:36:26.890651+00	\N		\N		\N			\N	2026-02-10 15:36:26.893679+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "83bb0944-5672-4759-b72b-37deea537a47", "email": "joseposligua@didactikapp.com", "nombre": "Jose Antonio Posligua Chilan", "usuario": "joseposligua", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:36:26.882958+00	2026-02-10 15:36:26.895767+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03	authenticated	authenticated	ninoskapin@didactikapp.com	$2a$10$Jpr3t1szc5Zv8KwWvceE2.nBhGCI3Z6KYrHviAI7U.HMTyXG98s4e	2026-02-10 15:34:02.269167+00	\N		\N		\N			\N	2026-02-10 16:35:27.839815+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03", "email": "ninoskapin@didactikapp.com", "nombre": "Ninoska Yurani Pin Molina", "usuario": "ninoskapin", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:34:02.258942+00	2026-02-10 16:35:27.844363+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	27356752-78d4-4833-bdbc-ac5ceb23883e	authenticated	authenticated	emmarivas@didactikapp.com	$2a$10$/EQ8RBgcsbjpvl1qcpHOfe6K7eTBAFVt4ps9Ye2Byu8.At0VKHLrO	2026-02-10 15:40:40.921111+00	\N		\N		\N			\N	2026-02-10 15:40:40.926316+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "27356752-78d4-4833-bdbc-ac5ceb23883e", "email": "emmarivas@didactikapp.com", "nombre": "Emma Asuncion Rivas Barcia", "usuario": "emmarivas", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:40:40.911174+00	2026-02-10 15:40:40.929644+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d656273e-e4fe-448d-9aa1-7e87839688d6	authenticated	authenticated	jusneyrivas@didactikapp.com	$2a$10$AIVuEVtRntMLb6ueyo9cm.OEJHrPdnyPhb2JoqYyy9RXx1U600go2	2026-02-10 15:41:30.22627+00	\N		\N		\N			\N	2026-02-10 16:02:21.022717+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "d656273e-e4fe-448d-9aa1-7e87839688d6", "email": "jusneyrivas@didactikapp.com", "nombre": "Jusney Joel Rivas Chilan", "usuario": "jusneyrivas", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:41:30.138181+00	2026-02-10 16:02:21.046289+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a883d161-ec1f-497b-91c6-16543a922792	authenticated	authenticated	lizsanchez@didactikapp.com	$2a$10$up6Hy8cQRGnWAr2n7E2rHeuaLKliw2kB12r6XHw5hdnLFIXY6MFNu	2026-02-10 15:42:12.69359+00	\N		\N		\N			\N	2026-02-10 15:42:12.698601+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "a883d161-ec1f-497b-91c6-16543a922792", "email": "lizsanchez@didactikapp.com", "nombre": "Liz Maria Sanchez Rivas", "usuario": "lizsanchez", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:42:12.661717+00	2026-02-10 15:42:12.700456+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	085e1141-b596-4dd7-8bbc-cccb55bf46fa	authenticated	authenticated	carlostejena@didactikapp.com	$2a$10$X06ay.xnvy8MZSKklh5naeo/DODHiQP5fRcwdbBNELtju/hIqmjne	2026-02-10 15:45:14.514268+00	\N		\N		\N			\N	2026-02-10 16:08:16.119101+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "085e1141-b596-4dd7-8bbc-cccb55bf46fa", "email": "carlostejena@didactikapp.com", "nombre": "Carlos Noriel Tejena Zambrano", "usuario": "carlostejena", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:45:14.500399+00	2026-02-10 16:08:16.121211+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ac8e6da9-87c7-49a5-8791-31208c8005f2	authenticated	authenticated	breynertejena@didactikapp.com	$2a$10$qBD5bBE5OiBN9ZGcLYnpK.fAt10FEmGKBXVAwn3bb.n8NpDQtU9Ey	2026-02-10 15:43:14.846137+00	\N		\N		\N			\N	2026-05-31 18:37:43.036211+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "ac8e6da9-87c7-49a5-8791-31208c8005f2", "email": "breynertejena@didactikapp.com", "nombre": "Breyner German Tejena Chilan", "usuario": "breynertejena", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:43:14.824453+00	2026-05-31 18:37:43.070136+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ed3fc59a-eab6-4126-9062-d79a3153f5da	authenticated	authenticated	samirtejena@didactikapp.com	$2a$10$nQcbwrBojrCS81c9cBFIiuvGnEsXd3YRIFnrWRvJg5U7ZUj8Xrun.	2026-02-10 15:43:51.494107+00	\N		\N		\N			\N	2026-02-10 16:10:37.536776+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "ed3fc59a-eab6-4126-9062-d79a3153f5da", "email": "samirtejena@didactikapp.com", "nombre": "Samir Randy Tejena Vera", "usuario": "samirtejena", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:43:51.487601+00	2026-02-10 16:10:37.538589+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f1ff761b-109b-46ac-8ffd-991130b7cfe7	authenticated	authenticated	brihanatorres@didactikapp.com	$2a$10$xd/T7xH3DYLu1TzfWqUkrepryhOgr0xl65Wgr1cM1qqxHlid1Xu4C	2026-02-10 15:47:33.707743+00	\N		\N		\N			\N	2026-02-10 16:17:45.802011+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "f1ff761b-109b-46ac-8ffd-991130b7cfe7", "email": "brihanatorres@didactikapp.com", "nombre": "Brihana Samara Torres Vera", "usuario": "brihanatorres", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:47:33.697965+00	2026-02-10 16:17:45.806197+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	242a6366-d3f0-4a5a-ba81-0db7aed6ac63	authenticated	authenticated	breylivelez@didactikapp.com	$2a$10$AxfvP8xm33QOsp6e1Oram.0AumiZYebp/7lQnvFJo6nhYkNh0JVPO	2026-02-10 15:46:03.435782+00	\N		\N		\N			\N	2026-02-10 15:46:03.442672+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "242a6366-d3f0-4a5a-ba81-0db7aed6ac63", "email": "breylivelez@didactikapp.com", "nombre": "Breyli Gregoria Velez Aragundi", "usuario": "breylivelez", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:46:03.430047+00	2026-02-10 15:46:03.445221+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ca71cb86-8002-48da-8292-cbd21b04c618	authenticated	authenticated	ikerzambrano@didactikapp.com	$2a$10$9oh9AFJorXS7W/N416bLK.WCw9YVi7zE7ny7b/23qcQ9KEfUdd/tC	2026-02-10 15:48:13.390259+00	\N		\N		\N			\N	2026-02-10 16:38:15.265712+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "ca71cb86-8002-48da-8292-cbd21b04c618", "email": "ikerzambrano@didactikapp.com", "nombre": "Iker Santiago Zambrano Laz", "usuario": "ikerzambrano", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:48:13.377142+00	2026-02-10 16:38:15.267616+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	92a11fb0-ed08-4d87-9ae4-e7bac360a51d	authenticated	authenticated	dastinparedes@didactikapp.com	$2a$10$ND7WpxB9NPTU6qDAJsEuUuKuWDHrf2B55EPko6.e6mzIEZGIkHVJy	2026-02-12 14:24:04.516946+00	\N		\N		\N			\N	2026-02-12 14:24:04.528593+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "92a11fb0-ed08-4d87-9ae4-e7bac360a51d", "email": "dastinparedes@didactikapp.com", "nombre": "Dastin Isaias Paredes Garcia", "usuario": "dastinparedes", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-12 14:24:04.45933+00	2026-02-12 14:24:04.546601+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	4f59b75d-bb02-40d9-9cd2-b653d198a438	authenticated	authenticated	jesuspin@didactikapp.com	$2a$10$Iya9MD3SAmncgG3wv4xt3ur8T.MwIfkY3wH921fqz3yef62.015xe	2026-02-12 14:16:26.673406+00	\N		\N		\N			\N	2026-02-12 14:17:05.919476+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "4f59b75d-bb02-40d9-9cd2-b653d198a438", "email": "jesuspin@didactikapp.com", "nombre": "Jesus David Pin Vera", "usuario": "jesuspin", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-12 14:16:26.594122+00	2026-02-12 14:17:05.924591+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ba9207cf-7064-435f-8ab0-0ac8a9679084	authenticated	authenticated	sherylzambrabo@didactikapp.com	$2a$10$dbrXmGGd6FikeLTT9ltCGeqbQIo1V6WDZ83OAXZW7DiWAJpFapTcO	2026-02-10 15:49:00.836221+00	\N		\N		\N			\N	2026-02-10 15:49:00.839323+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "ba9207cf-7064-435f-8ab0-0ac8a9679084", "email": "sherylzambrabo@didactikapp.com", "nombre": "Sheryl Keyveveth Zambrano Palma", "usuario": "sherylzambrabo", "grupo_id": "e0dd019c-0367-41a6-986f-bfa53d26e9e0", "email_verified": true, "phone_verified": false}	\N	2026-02-10 15:49:00.830804+00	2026-02-10 15:49:00.840952+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	91976250-d16f-48f5-9315-c89017ed5980	authenticated	authenticated	sofiapin@didactikapp.com	$2a$10$eQsx6EZFtQQCnk6cpgwjgu6RDL7ndwGapb88utHr45zCw7wQoBJrC	2026-02-12 14:24:54.794335+00	\N		\N		\N			\N	2026-02-12 14:24:54.7979+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "91976250-d16f-48f5-9315-c89017ed5980", "email": "sofiapin@didactikapp.com", "nombre": "Sofia Cristel Pin Tejena", "usuario": "sofiapin", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-02-12 14:24:54.782842+00	2026-02-12 16:32:52.780597+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bc729450-c4d8-450a-bf83-215288d70e0a	authenticated	authenticated	adrianmikko@didactikapp.com	$2a$10$Y8sKNycj4a0KMwBzCw5Hw.vmau3.9I7QkBMHp4NXexBDPd62DelSS	2026-05-20 03:25:08.331754+00	\N		\N		\N			\N	2026-05-20 03:31:09.65108+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "bc729450-c4d8-450a-bf83-215288d70e0a", "email": "adrianmikko@didactikapp.com", "nombre": "Adrianmikko", "usuario": "adrianmikko", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-05-20 03:25:08.226919+00	2026-05-20 03:31:09.677139+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8d999d39-7910-409f-a2ef-1b83c369843a	authenticated	authenticated	carlos23@didactikapp.com	$2a$10$kk1MnpxHW.3vSN3MuaHUt.NtiLixZgfqn6TbfWh/HajB0iLRPqXf2	2026-05-23 14:29:13.879002+00	\N		\N		\N			\N	2026-05-23 14:29:13.890609+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "8d999d39-7910-409f-a2ef-1b83c369843a", "email": "carlos23@didactikapp.com", "nombre": "carlos", "usuario": "carlos23", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-05-23 14:29:13.789108+00	2026-05-23 14:29:13.914532+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	07010bce-5076-4553-9a09-2a95b20e0e8b	authenticated	authenticated	admin2@didactikapp.com	$2a$10$5sKeh5RMKG.SBYQCiwvmzeECwD0iclYOe6xqobvNkTSzdWU1NpxOS	2026-06-02 03:15:10.73534+00	\N		\N		\N			\N	2026-06-02 03:15:10.745707+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "07010bce-5076-4553-9a09-2a95b20e0e8b", "email": "admin2@didactikapp.com", "nombre": "Merly Paola Zambrano", "usuario": "admin2", "email_verified": true, "phone_verified": false}	\N	2026-06-02 03:15:10.702635+00	2026-06-02 03:15:10.759622+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	0e495a05-fc94-4a96-b7d8-0ebed3cf3f95	authenticated	authenticated	admin3@didactikapp.com	$2a$10$k1ANEjt9SGfahemZtmPCFO8aEWv7gyC3IZw/fkStqHu17i95459pq	2026-06-02 03:18:41.49653+00	\N		\N		\N			\N	2026-06-02 03:18:41.505809+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "0e495a05-fc94-4a96-b7d8-0ebed3cf3f95", "email": "admin3@didactikapp.com", "nombre": "admin3", "usuario": "admin3", "email_verified": true, "phone_verified": false}	\N	2026-06-02 03:18:41.457582+00	2026-06-02 03:18:41.52079+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	14ce5450-53d1-4997-aa2d-6c182759611d	authenticated	authenticated	anaja@didactikapp.com	$2a$10$sZxCFyPAFCe.lSH90ePcAewHW5kMBzJwxIxJSOpp5kFme5YLncgfm	2026-06-02 03:22:40.740391+00	\N		\N		\N			\N	2026-06-02 03:22:40.749454+00	{"provider": "email", "providers": ["email"]}	{"rol": "estudiante", "sub": "14ce5450-53d1-4997-aa2d-6c182759611d", "email": "anaja@didactikapp.com", "nombre": "ana karen", "usuario": "anaja", "grupo_id": "f49d08aa-d2b5-4bdd-aa8e-7472785e11c9", "email_verified": true, "phone_verified": false}	\N	2026-06-02 03:22:40.699+00	2026-06-02 03:22:40.772668+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	14076186-432f-49f8-87c2-093a3ae9804f	authenticated	authenticated	paolamerly1@gmail.com	$2a$10$RR62Rtr6p1VwxMKk5bZVw.rqIxoxSD71SW09XaJYJM2OPrO6wRW82	2026-06-02 03:51:15.788885+00	\N		\N		\N			\N	2026-06-09 16:29:41.744523+00	{"provider": "email", "providers": ["email"]}	{"rol": "visitante", "sub": "14076186-432f-49f8-87c2-093a3ae9804f", "email": "paolamerly1@gmail.com", "nombre": "Merly Zambrano Bravo ", "email_verified": true, "phone_verified": false}	\N	2026-06-02 03:51:15.745711+00	2026-06-09 16:29:41.790095+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: actividad_diaria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actividad_diaria (id, usuario_id, fecha, puntos_ganados, recursos_completados, quizzes_completados, logros_obtenidos, tiempo_estudiado, created_at) FROM stdin;
d809b944-92a7-4d8c-8b21-8c219f5244b0	b0f8ff61-98f5-413b-900b-5a3626c3d328	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
3bab7462-a80f-4d89-a057-6f45b35f7bb6	b0f8ff61-98f5-413b-900b-5a3626c3d328	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
fd9edb9f-d38e-4dcc-a85a-e30bac4b4fb6	b0f8ff61-98f5-413b-900b-5a3626c3d328	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
7ed78ab8-e9ef-485b-b259-aec54c27fc4b	b0f8ff61-98f5-413b-900b-5a3626c3d328	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
00d55e6f-54e1-4e63-8e35-e7072940d09b	b0f8ff61-98f5-413b-900b-5a3626c3d328	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
d27ae8d0-1351-4978-beeb-bc95cc365e88	b0f8ff61-98f5-413b-900b-5a3626c3d328	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
97ebbdd5-ced7-4125-b57e-6ab7c6baba70	b0f8ff61-98f5-413b-900b-5a3626c3d328	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
1b8ef4f0-7972-4fbe-bb6b-5771580e6eb0	e6090c60-7141-44f8-95e9-017cb844fc34	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
0d7ed6b7-ce62-4ff7-8e2e-7298e67fbd2f	e6090c60-7141-44f8-95e9-017cb844fc34	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
72c6049e-f2e5-451f-b2e7-dcef5a976388	e6090c60-7141-44f8-95e9-017cb844fc34	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
f7ecf7d2-870f-44e9-b733-f479bd6e4385	e6090c60-7141-44f8-95e9-017cb844fc34	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
e7bfcc79-366f-4162-8e2a-f031ea76aeef	e6090c60-7141-44f8-95e9-017cb844fc34	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
78a7bc0a-8eb1-410c-a821-695d255220a3	e6090c60-7141-44f8-95e9-017cb844fc34	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
c4631b31-c5fc-476a-99f7-4005e19fbe79	e6090c60-7141-44f8-95e9-017cb844fc34	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
a6402fc4-1d00-4f81-8083-4cdfcca0df77	9e24b9cc-4c16-4092-8158-88e6361b8ccc	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
e6dd462a-295d-485b-8fd8-472f19da08fa	9e24b9cc-4c16-4092-8158-88e6361b8ccc	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
b96d532e-65e2-4c82-bc4c-8c39d1b193af	9e24b9cc-4c16-4092-8158-88e6361b8ccc	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
77447f6e-770e-4f8e-9b15-8ae3bf79e76c	9e24b9cc-4c16-4092-8158-88e6361b8ccc	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
8ee249ca-137c-41f5-b15d-d9e2fdc0e094	9e24b9cc-4c16-4092-8158-88e6361b8ccc	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
a662f7a8-08df-4d0e-8dc7-a42e93dd5ddf	9e24b9cc-4c16-4092-8158-88e6361b8ccc	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
f6054856-66c8-42ed-9767-b2b597aef452	9e24b9cc-4c16-4092-8158-88e6361b8ccc	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
1f249fa6-ffe0-419e-944d-3236e6229c45	7ddf8681-7824-4556-bd1d-b6762639494d	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
f161e7f2-086f-4c8e-b6a4-0fdb80300c2f	7ddf8681-7824-4556-bd1d-b6762639494d	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
7b0ada73-a1d6-448b-95c0-86bec87b49a6	7ddf8681-7824-4556-bd1d-b6762639494d	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
755a5aa8-aefb-4d12-b68d-928e1f40f2a1	7ddf8681-7824-4556-bd1d-b6762639494d	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
aeaab4cd-a24f-4bcd-832f-b294c50f2481	7ddf8681-7824-4556-bd1d-b6762639494d	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
42950238-c1cf-48d9-be3c-5453107c0887	7ddf8681-7824-4556-bd1d-b6762639494d	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
a4720ac9-095a-4770-b9e2-e99edb9e802d	7ddf8681-7824-4556-bd1d-b6762639494d	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
8753d544-053c-4bc7-955d-35bec7335e42	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
f173f825-97a3-47ef-83f7-1d3c0d69be29	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
f506994a-50f8-4d27-bd01-154478e5a6a7	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
f3d9f8ab-af27-4492-98b5-f19a034105a0	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
822692e4-76bb-43f9-b46f-4ffa301b5690	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
6217251b-4c8e-4360-9d34-1c897150b88d	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
3eaf0fdc-c158-4f60-8cf8-71d2479359c2	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
bb1a9bb3-77a1-4a08-a586-0755a772eb62	26688e35-629c-454e-acde-484d41aa3898	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
3cd4d28d-013b-4a4a-9f0b-6b69ad89d521	26688e35-629c-454e-acde-484d41aa3898	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
c0a70a14-0eac-4d40-b041-5070d5bd9ad2	26688e35-629c-454e-acde-484d41aa3898	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
66d387c4-17b8-4277-be36-88ddb6980d8d	26688e35-629c-454e-acde-484d41aa3898	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
763e8a25-9bf0-4122-a32c-6b890a3c4b5b	26688e35-629c-454e-acde-484d41aa3898	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
1adb1830-81a8-4685-82fc-22465def292f	26688e35-629c-454e-acde-484d41aa3898	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
266d7e3a-d762-4da5-b6e2-5f45f66688f2	26688e35-629c-454e-acde-484d41aa3898	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
5407cdad-d4be-4720-898b-85f42d10b63b	2a8d5621-1e97-4086-8fdf-691f322f2da6	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
c1faf644-bc67-4a39-87d2-d5fdb3e6d328	2a8d5621-1e97-4086-8fdf-691f322f2da6	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
8261e777-d3d2-428b-b26c-9e0f526bbe26	2a8d5621-1e97-4086-8fdf-691f322f2da6	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
3eeaf053-0c83-4bf7-ad3a-7a2bc9087bc2	2a8d5621-1e97-4086-8fdf-691f322f2da6	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
5c8b13b0-9fe3-49a6-bfbd-5882cbf703ea	2a8d5621-1e97-4086-8fdf-691f322f2da6	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
433983bb-016a-4323-a385-638bb3f02c79	2a8d5621-1e97-4086-8fdf-691f322f2da6	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
081e972c-a419-4a9f-8ef4-4ff00a12da92	2a8d5621-1e97-4086-8fdf-691f322f2da6	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
666b1979-247f-4922-b6d5-eca7a7b62b03	a642c609-fee9-439a-81b6-8f0cbea00dd5	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
c710746d-8022-4453-be70-a34941903272	a642c609-fee9-439a-81b6-8f0cbea00dd5	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
653b479d-2619-4977-a2cc-1d8836ea042e	a642c609-fee9-439a-81b6-8f0cbea00dd5	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
44273fae-6b18-4384-ac3d-f7d1fe58ef55	a642c609-fee9-439a-81b6-8f0cbea00dd5	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
68c76f3b-a0e0-4d03-93a9-44b56cfcd488	a642c609-fee9-439a-81b6-8f0cbea00dd5	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
e7664152-9c27-4a6c-87af-7049e7c85e81	a642c609-fee9-439a-81b6-8f0cbea00dd5	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
e3f8fab7-c968-4bc3-bfd1-4a3846354d7d	a642c609-fee9-439a-81b6-8f0cbea00dd5	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
754d2a26-f0e9-4913-98cd-d2cea874e80c	00178fa6-2f3f-4e27-834a-b85a72009406	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
0bf1846f-cedc-493d-91bc-a8e3decb42a6	00178fa6-2f3f-4e27-834a-b85a72009406	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
e60d7fc1-4186-4a63-b099-9ae20ac6c506	00178fa6-2f3f-4e27-834a-b85a72009406	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
e24b9ca8-8078-4e78-83e8-8c894ae6741d	00178fa6-2f3f-4e27-834a-b85a72009406	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
af4c1496-f3d3-4578-acfb-0371eb6790f7	00178fa6-2f3f-4e27-834a-b85a72009406	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
1b6afea3-6d20-4553-83d2-ac4a99880c34	00178fa6-2f3f-4e27-834a-b85a72009406	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
2d58ab2b-e9fa-41f0-9327-4ca928d8fb0e	00178fa6-2f3f-4e27-834a-b85a72009406	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
8f3681fc-b712-4833-acc3-d8fc1ec07fd1	779382f6-1c9f-45c8-b016-e057e4409004	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
c495598c-f8b1-4d82-84e8-07026286be4d	779382f6-1c9f-45c8-b016-e057e4409004	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
00bded8e-b319-4b50-847f-ed928d616e7f	779382f6-1c9f-45c8-b016-e057e4409004	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
1095da82-0005-4b56-968b-b30508724bc4	779382f6-1c9f-45c8-b016-e057e4409004	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
e90f2979-31fc-4aa5-b466-529b54e945e0	779382f6-1c9f-45c8-b016-e057e4409004	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
2feb3242-764a-42a7-bf40-133aab4b1610	779382f6-1c9f-45c8-b016-e057e4409004	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
651a686d-af95-4c01-9b8f-e699f781284b	779382f6-1c9f-45c8-b016-e057e4409004	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
c5151279-00ac-43c6-99e3-3f6591559e1a	232ea473-5be2-4940-b307-f408e425c394	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
ee049662-3d9d-4be4-b4fd-3d024b76c8cb	232ea473-5be2-4940-b307-f408e425c394	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
708bd3c0-5d26-4c91-9024-13743aa63601	232ea473-5be2-4940-b307-f408e425c394	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
1902b8db-7901-45ef-87c3-67760e32eef2	232ea473-5be2-4940-b307-f408e425c394	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
9c1be14e-1cbe-4365-90ee-57bb7c5f8df6	232ea473-5be2-4940-b307-f408e425c394	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
3588ca5b-6475-4c7d-bc80-588a19fab1f6	232ea473-5be2-4940-b307-f408e425c394	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
2d815c3f-d5bf-43da-aa73-677eade2ae8b	232ea473-5be2-4940-b307-f408e425c394	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
1ce33ea9-6fa8-439e-971c-ac859346cb25	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
bf84d584-b400-4fec-8d53-6632fecf0b6a	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
2e2a720d-0171-4369-9666-fa3691e79358	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
71dd1ba3-94fa-476d-857c-31b047166a1e	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
30b2d6fc-72f7-458c-9e35-ca289ccdc459	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
f42b851f-173d-4f36-8129-2a58cc7cb35d	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
db362597-6db0-46fa-9628-983ba3a9a882	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
0cc2e033-9b14-447f-8e2a-a19a7126fda5	1ff5e152-0c12-4004-9d71-0e05c0318282	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
183d2b18-3888-482d-8585-61356ae1c7da	1ff5e152-0c12-4004-9d71-0e05c0318282	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
c0b7d604-662c-4515-8171-e49049704bc2	1ff5e152-0c12-4004-9d71-0e05c0318282	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
b98fb99a-6e13-4b5e-a748-c695633fc561	1ff5e152-0c12-4004-9d71-0e05c0318282	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
71dad79f-fe88-4d48-b27a-f9ac9414b8c9	1ff5e152-0c12-4004-9d71-0e05c0318282	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
7cd645af-0cbb-4720-a118-5660afc13207	1ff5e152-0c12-4004-9d71-0e05c0318282	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
7e6f7620-30e2-49df-b07d-7c19b2a2d0f1	1ff5e152-0c12-4004-9d71-0e05c0318282	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
b3938c89-7541-4b6a-9e26-268d774b77d5	482d28a2-3771-4ea9-97ab-0aaff07f08ca	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
252033bd-316e-46e6-aff9-31e4374a57d7	482d28a2-3771-4ea9-97ab-0aaff07f08ca	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
145aee0c-c7c5-4ffa-8369-92c20622a1a6	482d28a2-3771-4ea9-97ab-0aaff07f08ca	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
b642e2ab-e3f6-4734-a3c6-f9dd2609a9c2	482d28a2-3771-4ea9-97ab-0aaff07f08ca	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
144c0ee3-a872-449e-8cfd-5c797a97af08	482d28a2-3771-4ea9-97ab-0aaff07f08ca	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
43aba7a6-8ecb-42b0-a929-f542c79bbb8c	482d28a2-3771-4ea9-97ab-0aaff07f08ca	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
f2240c7e-b5ef-4c67-8329-a37f44a5e01e	482d28a2-3771-4ea9-97ab-0aaff07f08ca	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
6e42ba09-b0c1-4327-bb41-2e2e347cf53f	3dbfbfd0-744a-45ba-8e54-cd53e216853a	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
0ddcb939-e3bb-48dc-9e08-cf5095fc2787	3dbfbfd0-744a-45ba-8e54-cd53e216853a	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
001671aa-c4b3-4f60-ab46-84e859400b4f	3dbfbfd0-744a-45ba-8e54-cd53e216853a	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
05835054-1ea2-4716-890a-06460bd056d0	3dbfbfd0-744a-45ba-8e54-cd53e216853a	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
e5fd9402-903b-46fd-8877-d878c628900d	3dbfbfd0-744a-45ba-8e54-cd53e216853a	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
609cf864-ee9b-4479-938b-6cb06bad3790	3dbfbfd0-744a-45ba-8e54-cd53e216853a	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
4ac58f97-22fa-4b04-99c4-01300b065e86	3dbfbfd0-744a-45ba-8e54-cd53e216853a	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
b045db3c-03cc-4fe5-b9d0-70fd6a7ebb1c	32f09e62-2442-422a-be58-67e834637275	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
ae08f421-0a35-4c8e-beed-3aa25a0a1279	32f09e62-2442-422a-be58-67e834637275	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
307efcdb-1cec-4a5a-b4de-d98a17aecef7	32f09e62-2442-422a-be58-67e834637275	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
083b12f5-7060-4dff-895e-a6930b726dcd	32f09e62-2442-422a-be58-67e834637275	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
995cbc5b-6665-4d13-8020-6fc1ae97efef	32f09e62-2442-422a-be58-67e834637275	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
d0d27d26-d2a5-48db-b5c7-ab3a00c49be6	32f09e62-2442-422a-be58-67e834637275	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
ce816d3f-eb14-45d4-b2d9-f268d15d1e59	32f09e62-2442-422a-be58-67e834637275	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
76119727-1a23-4187-b926-8cfbac9ecd00	43719c9b-96a8-4c86-9a15-11fdf767e47c	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
5a09f997-ad2d-4ee3-9492-f5c3358e3a71	43719c9b-96a8-4c86-9a15-11fdf767e47c	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
b151336a-51fb-4866-8f14-40b7c3167af9	43719c9b-96a8-4c86-9a15-11fdf767e47c	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
5e0d5aa5-9c0f-43a3-a661-47dfc75a8502	43719c9b-96a8-4c86-9a15-11fdf767e47c	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
36da3c32-0dd3-42e9-9b4d-7b2291a6608e	43719c9b-96a8-4c86-9a15-11fdf767e47c	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
e61bead2-54b5-4fda-8d7f-fbc79a1c1785	43719c9b-96a8-4c86-9a15-11fdf767e47c	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
f3563cb0-7aa8-4625-b1af-ef922f9dfc21	43719c9b-96a8-4c86-9a15-11fdf767e47c	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
4aba54cd-4bb8-48fd-b3f8-8d96261bd164	de898141-8c5a-4c06-a4ab-156c42c5423f	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
52e37505-c70c-4f56-8e63-4040068dedf1	de898141-8c5a-4c06-a4ab-156c42c5423f	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
2c0710ad-71b9-4b58-9254-da42b0a021df	de898141-8c5a-4c06-a4ab-156c42c5423f	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
13f1c390-4308-4ef4-af7c-dc2b90a73003	de898141-8c5a-4c06-a4ab-156c42c5423f	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
854b8180-6301-491f-b9c7-a3d322d39c05	de898141-8c5a-4c06-a4ab-156c42c5423f	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
10129540-42cb-4a3b-bc50-18464fe717a5	de898141-8c5a-4c06-a4ab-156c42c5423f	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
47f274f9-a290-45a4-8fe1-b8e486888616	de898141-8c5a-4c06-a4ab-156c42c5423f	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
8f570805-fe8a-4f03-8b62-f9e39e726dbf	6a6c6706-0b1b-4eca-b269-446091719c1f	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
b8618178-76cf-4098-8b1e-28cbeaca2db8	6a6c6706-0b1b-4eca-b269-446091719c1f	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
f2d99d10-5fa9-440c-84f9-f289dde7f392	6a6c6706-0b1b-4eca-b269-446091719c1f	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
9aca8ff5-fe6f-42e7-87b5-25e7eeb674da	6a6c6706-0b1b-4eca-b269-446091719c1f	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
54a17166-178b-4613-a8c4-0d2dab7d880c	6a6c6706-0b1b-4eca-b269-446091719c1f	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
eb736fd6-59f7-444e-ad3c-4e181c924655	6a6c6706-0b1b-4eca-b269-446091719c1f	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
8d84dafe-e4fc-4276-bbb3-d83430f4785a	6a6c6706-0b1b-4eca-b269-446091719c1f	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
a4e31a74-63c7-4eb0-b36b-117e666f6c96	a28ba234-4391-4854-9d52-66a1e5a1d9a6	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
77afea7a-1ae6-49bc-82c1-fa69974e2a56	a28ba234-4391-4854-9d52-66a1e5a1d9a6	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
24ed97f5-5f58-4c66-bbcc-2f32ec26cb7d	a28ba234-4391-4854-9d52-66a1e5a1d9a6	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
a2d2885d-1758-48a6-8f6b-8bd544472305	a28ba234-4391-4854-9d52-66a1e5a1d9a6	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
a95ee991-57f5-4165-8ffb-2304cb1e00bf	a28ba234-4391-4854-9d52-66a1e5a1d9a6	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
e70256b4-9e0b-4738-b1e1-3438937f0961	a28ba234-4391-4854-9d52-66a1e5a1d9a6	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
e9a2f22e-1384-486c-afe8-7196aa9ae394	a28ba234-4391-4854-9d52-66a1e5a1d9a6	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
6b8fea8a-5824-40c3-9855-36fce6d5158c	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
ad30b2c0-9468-454a-ad2a-97a1a61de7ad	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
46b33a00-1a9d-4f0c-ba0c-d8f65ccabcef	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
f69a7266-bf71-4d34-9a05-4b27fd3f5e99	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
35e80ea1-a7f2-4959-abe8-a1afaef1c8db	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
55c3c30d-1c81-4229-88c3-62156910be00	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
1a93f2bf-5ea6-454e-ad03-b53155fc533c	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
04c6df22-a470-497b-b35e-5a96b44d2c1d	580ba549-750e-4aba-9602-9a867dddfadb	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
d9ea223e-144e-472b-ad8f-ff971aed54ad	580ba549-750e-4aba-9602-9a867dddfadb	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
b0c21d99-ec6e-422c-bead-558f5e696f15	580ba549-750e-4aba-9602-9a867dddfadb	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
2ad93afc-31ef-4cff-82dd-8f74fb2d4bc7	580ba549-750e-4aba-9602-9a867dddfadb	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
96bed657-77c1-46b7-ae25-1efa0d8904c3	580ba549-750e-4aba-9602-9a867dddfadb	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
fb97a4ee-d88b-489c-98f3-8d74475f9267	580ba549-750e-4aba-9602-9a867dddfadb	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
cfa5e989-818c-4b7b-be88-7af553be8825	580ba549-750e-4aba-9602-9a867dddfadb	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
6b58f15f-7d9a-4824-a86b-b03cd850ebe4	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
de460532-d3d5-40ff-8b92-d2daeafb940f	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
0c5d46c3-be71-41e6-bc19-b5e7f2d889ea	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
a4ed2907-308c-421c-80e7-8e20dde040f2	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
3ccdffd6-2d0f-4f4c-ac82-2bf68f5879e9	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
e0102310-4967-419f-b143-9030b3096295	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
0bc9c97d-b5c9-4c5d-b3ed-085bbdfee481	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
54659b0c-5cf5-4f75-a176-e1905719cf13	785e224c-54c1-42dc-b2e9-60842ce1ba99	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
bf0bdf0a-0a6d-4d5f-bf8d-b8cbb111466d	785e224c-54c1-42dc-b2e9-60842ce1ba99	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
bf54c847-9316-46f6-82d0-081893160ff3	785e224c-54c1-42dc-b2e9-60842ce1ba99	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
78a8083f-fa1f-416c-803d-84d640bac222	785e224c-54c1-42dc-b2e9-60842ce1ba99	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
f54a4e47-5b0c-4da5-b6ad-3886e574ff79	785e224c-54c1-42dc-b2e9-60842ce1ba99	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
bbffe578-26fa-422a-996b-f54e8ee3c439	785e224c-54c1-42dc-b2e9-60842ce1ba99	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
c5d1a25c-5711-4470-a879-798b77629f56	785e224c-54c1-42dc-b2e9-60842ce1ba99	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
5be420b0-e47f-4c7e-9bd8-243ec140089c	ec701f35-da9c-4f6a-a7bf-16b3f4646384	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
e4fb3455-b6a5-4f41-8c8c-9493911f5a0d	ec701f35-da9c-4f6a-a7bf-16b3f4646384	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
793cefce-4b43-487c-87b4-d6a95ff98812	ec701f35-da9c-4f6a-a7bf-16b3f4646384	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
2eaab3bc-a691-4e0d-88b7-4cb77e4b789f	ec701f35-da9c-4f6a-a7bf-16b3f4646384	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
fe77634f-cace-4459-9ad5-70b8cf79c33b	ec701f35-da9c-4f6a-a7bf-16b3f4646384	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
d964a45f-8bcd-4fa8-9804-77c803507766	ec701f35-da9c-4f6a-a7bf-16b3f4646384	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
a846ffd0-a97c-4a58-b28f-01574ba6c37d	ec701f35-da9c-4f6a-a7bf-16b3f4646384	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
a585f273-60b3-48a3-9d32-3adb8bd5bcda	d4b91756-4c44-4a23-8efc-9d71b2fc5090	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
cd75d04c-c5b0-4277-81d6-dfa74fd9bf11	d4b91756-4c44-4a23-8efc-9d71b2fc5090	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
050d7c99-83f6-435f-8c5e-c434293ca74f	d4b91756-4c44-4a23-8efc-9d71b2fc5090	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
79d0fe0a-e085-424e-8eb6-16d8cc161ddd	d4b91756-4c44-4a23-8efc-9d71b2fc5090	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
54304662-2f66-4016-8701-51776375ad46	d4b91756-4c44-4a23-8efc-9d71b2fc5090	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
d3fdeffb-0498-4ec6-b75b-c14b51dbdd08	d4b91756-4c44-4a23-8efc-9d71b2fc5090	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
cd21c7a8-5747-439f-a6a6-15b3d2c2cba3	d4b91756-4c44-4a23-8efc-9d71b2fc5090	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
6f95b785-5e95-43d4-8065-497f425c8231	7e5bfd44-8365-44f6-98bf-7e6325688a4c	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
90c65a84-84f1-44a7-a0cc-de81019cce4a	7e5bfd44-8365-44f6-98bf-7e6325688a4c	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
8fd305c9-e248-4e03-9737-e45d337e9193	7e5bfd44-8365-44f6-98bf-7e6325688a4c	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
bdf02adb-701b-4dea-8202-d57934a09261	7e5bfd44-8365-44f6-98bf-7e6325688a4c	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
462b2525-9070-453a-a1af-c27134037c23	7e5bfd44-8365-44f6-98bf-7e6325688a4c	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
255c42f5-8449-4034-abe8-e34027bbe654	7e5bfd44-8365-44f6-98bf-7e6325688a4c	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
5f24ca17-eb42-40fa-915e-21c621f0321b	7e5bfd44-8365-44f6-98bf-7e6325688a4c	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
984ec594-d7aa-408f-b76f-2590d2a432f6	dc89d075-e87f-4eb0-af3b-de9979123693	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
c1dea173-8d7b-4b8b-b35b-0d2e6c5bb26b	dc89d075-e87f-4eb0-af3b-de9979123693	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
4360d7be-42b6-4d8a-a518-8593247425ef	dc89d075-e87f-4eb0-af3b-de9979123693	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
252e7878-1767-459d-af96-06c06249e24d	dc89d075-e87f-4eb0-af3b-de9979123693	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
1f9e91b7-fa05-4332-b679-40f812bba195	dc89d075-e87f-4eb0-af3b-de9979123693	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
b599f7fb-94b3-4226-a8d6-eb18cc482872	dc89d075-e87f-4eb0-af3b-de9979123693	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
b306afc5-8430-4a81-8855-ee46a507c1ea	dc89d075-e87f-4eb0-af3b-de9979123693	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
717a2334-9647-4da5-a616-0b5cb3794570	fd9c1c4a-2e54-456d-b348-29236f48e6ad	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
47127923-4f3c-4e2c-b528-75c55211b340	fd9c1c4a-2e54-456d-b348-29236f48e6ad	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
65709ad8-dfa1-4374-b1d9-3c4514cdac28	fd9c1c4a-2e54-456d-b348-29236f48e6ad	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
715d3ecf-82da-46ed-aad4-e67d6c550663	fd9c1c4a-2e54-456d-b348-29236f48e6ad	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
1886cc56-a18d-431a-8c0f-a8ce6977e83f	fd9c1c4a-2e54-456d-b348-29236f48e6ad	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
2026b8ca-9d55-4753-811d-de2a479f63d9	fd9c1c4a-2e54-456d-b348-29236f48e6ad	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
c3142bb0-f3d1-4bc4-ac60-4a948cac13a1	fd9c1c4a-2e54-456d-b348-29236f48e6ad	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
c8ac5261-cad5-46ec-b017-d84cddb06526	905f655a-0fbd-487a-ad7b-59038d764266	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
98ca7ee0-d988-4614-a7ec-78e7e1bc52e9	905f655a-0fbd-487a-ad7b-59038d764266	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
ee1dc896-8d39-4a9d-8373-fc69ede531a8	905f655a-0fbd-487a-ad7b-59038d764266	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
dd268d26-c30a-4cf7-88d8-cc77421dff59	905f655a-0fbd-487a-ad7b-59038d764266	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
13981b96-387c-4275-a203-80c7efe255e2	905f655a-0fbd-487a-ad7b-59038d764266	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
3cadbbc7-4d52-4ecc-84dc-f46b65340e8a	905f655a-0fbd-487a-ad7b-59038d764266	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
38890476-4ae3-446a-be3b-f5be32606a2a	905f655a-0fbd-487a-ad7b-59038d764266	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
e14e1b5b-b280-4405-b62d-bf91951be962	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
48d12663-9b32-40e6-bae7-ab87b18e3ffb	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
91fe7acc-e095-4f31-b6e6-435ca55ef58c	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
426c3692-a597-4819-aab5-645c9b5f9c9c	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
4903f5f7-8142-484d-8175-d9dab9453a9b	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
9608a1ec-65c2-4a3e-a3c8-2184d4102675	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
b561039a-d615-406d-b26c-241f240a6181	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
854288a1-7d3e-495c-9cde-97b80d0479b8	e6fccc63-1e3f-4626-87d2-d5d50a49823d	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
145c3786-1389-41d0-bf30-b364abdf5ffd	e6fccc63-1e3f-4626-87d2-d5d50a49823d	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
989a63d7-d221-44a3-989c-0be3775ac4c8	e6fccc63-1e3f-4626-87d2-d5d50a49823d	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
e0f108ed-9b9f-46ac-b75d-43905abb2563	e6fccc63-1e3f-4626-87d2-d5d50a49823d	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
fecaaec5-820f-41fb-8ad3-69c34729bcd4	e6fccc63-1e3f-4626-87d2-d5d50a49823d	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
5d20a21e-4719-41be-b9ad-3543c0e44565	e6fccc63-1e3f-4626-87d2-d5d50a49823d	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
a7637aee-5d85-40da-a94f-fe5051dbbbe3	e6fccc63-1e3f-4626-87d2-d5d50a49823d	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
da12a936-425b-4846-a2f9-1ca5c4414150	8001f39c-8317-4978-a843-e418a960935e	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
173d889a-6c1d-4b13-bc3f-7de4da08864f	8001f39c-8317-4978-a843-e418a960935e	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
cbc53822-31c5-4fbc-aaa1-b95e30259b7f	8001f39c-8317-4978-a843-e418a960935e	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
8320d635-877a-496d-bdf8-510cdb53309a	8001f39c-8317-4978-a843-e418a960935e	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
dbd4be59-2e0e-448c-8d5d-c1e2f1c99ea2	8001f39c-8317-4978-a843-e418a960935e	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
ed01c95b-d603-4124-adac-6b55ff3ac565	8001f39c-8317-4978-a843-e418a960935e	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
66e9a418-215c-4c45-8533-8251f064300c	8001f39c-8317-4978-a843-e418a960935e	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
23385155-1c0a-4f69-ac24-ddaadb899d6d	affcad27-1178-40e2-978a-e6417dd3584e	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
bc7d9f5b-d446-4328-b02e-39cb07d267dd	affcad27-1178-40e2-978a-e6417dd3584e	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
237f6672-c0a3-4d55-a312-1ee0b107359a	affcad27-1178-40e2-978a-e6417dd3584e	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
cc0eb4f3-3cf1-4344-bfb4-d35551e1d48c	affcad27-1178-40e2-978a-e6417dd3584e	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
04d8fcc0-3735-4156-b38a-8e33717b7b61	affcad27-1178-40e2-978a-e6417dd3584e	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
5df82c1c-4df6-4504-aede-bcb53321abe1	affcad27-1178-40e2-978a-e6417dd3584e	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
641e6500-9c27-4c79-bf96-d5999c6078cf	affcad27-1178-40e2-978a-e6417dd3584e	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
3105d91c-0416-4543-a1cb-0ea47193c85f	d10972bb-7465-4c66-aa17-8b8fd5bfb557	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
f80fe5b7-5b54-4b62-9f04-73e9aaf4760e	d10972bb-7465-4c66-aa17-8b8fd5bfb557	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
a1e7758b-6130-426f-987a-d5a3d09a9f47	d10972bb-7465-4c66-aa17-8b8fd5bfb557	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
d714ea08-8043-439e-a6c2-5f63bed2400a	d10972bb-7465-4c66-aa17-8b8fd5bfb557	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
8378a23d-07c8-4b5d-9e83-f449aa9d9471	d10972bb-7465-4c66-aa17-8b8fd5bfb557	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
558191ef-f97d-4045-bfda-0593ce6f0629	d10972bb-7465-4c66-aa17-8b8fd5bfb557	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
fca02469-a60e-4a27-a758-32cd60248e2c	d10972bb-7465-4c66-aa17-8b8fd5bfb557	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
d50c73e5-2b21-4da1-991b-a73da0b0bf9a	e38b0586-f894-491a-a30e-6d40f70673d3	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
e758ca2e-bcce-4b0a-9ca3-1b08d8260943	e38b0586-f894-491a-a30e-6d40f70673d3	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
6a06dbda-8370-4f81-9d14-72f58ac7bbb8	e38b0586-f894-491a-a30e-6d40f70673d3	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
39267fb1-3b15-48d9-bf78-f464c48e36bb	e38b0586-f894-491a-a30e-6d40f70673d3	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
701310e3-8c9c-4ba5-897f-7d4e6171fab0	e38b0586-f894-491a-a30e-6d40f70673d3	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
e2fe6988-cf78-4952-8f70-6016d9ce645f	e38b0586-f894-491a-a30e-6d40f70673d3	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
2432b580-10d3-4b07-bdfe-95cf5bea2775	e38b0586-f894-491a-a30e-6d40f70673d3	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
052c118f-4787-4b90-874f-86704ac68b87	de713c42-2907-4e6b-9630-b6452aaa85e8	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
acf110b3-92e6-4040-ae7f-7c12cd44a0e7	de713c42-2907-4e6b-9630-b6452aaa85e8	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
795f90c8-f411-4483-9e0c-bb33c3082ff0	de713c42-2907-4e6b-9630-b6452aaa85e8	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
8920ca0a-d505-410b-909b-9b299125bb5b	de713c42-2907-4e6b-9630-b6452aaa85e8	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
ce4fa8f1-59a7-452f-9c1b-0bf49c32c2f5	de713c42-2907-4e6b-9630-b6452aaa85e8	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
089593b0-b6ca-4b51-af5c-da3522ac97e6	de713c42-2907-4e6b-9630-b6452aaa85e8	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
87bb86f5-d77f-4611-ad06-805c05c257dc	de713c42-2907-4e6b-9630-b6452aaa85e8	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
b100e1f4-843a-45c8-9764-88ff578c2730	978b6007-734d-495c-b05d-5dcc00c31840	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
0af8245e-f394-4105-96a5-56af527487e0	978b6007-734d-495c-b05d-5dcc00c31840	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
713dd03a-0063-4bb4-82be-8841cdef928a	978b6007-734d-495c-b05d-5dcc00c31840	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
d3830611-5a5a-4010-b642-4876236ebdd5	978b6007-734d-495c-b05d-5dcc00c31840	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
a939036f-7801-4b5a-baab-f7c0f1070ac8	978b6007-734d-495c-b05d-5dcc00c31840	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
44367491-9b97-43bf-a801-dcb25e07397b	978b6007-734d-495c-b05d-5dcc00c31840	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
30115e77-8205-43b1-b07f-1336aad81953	978b6007-734d-495c-b05d-5dcc00c31840	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
ea484800-4f8e-4b9c-a411-15922d70730e	d5518614-7ec1-41a4-be7f-7766def7c2a3	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
3628d87a-58e8-4c08-9fc1-03763a4884d2	d5518614-7ec1-41a4-be7f-7766def7c2a3	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
dd61a6e3-f4e3-465c-8a54-7d4c9092847e	d5518614-7ec1-41a4-be7f-7766def7c2a3	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
2a302c12-5c22-43b6-99ba-abc463bbb30c	d5518614-7ec1-41a4-be7f-7766def7c2a3	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
178f194b-d00a-4e46-9185-3b000b704d57	d5518614-7ec1-41a4-be7f-7766def7c2a3	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
3d793b78-d01d-4eb1-9bf0-1a8c60c86bc3	d5518614-7ec1-41a4-be7f-7766def7c2a3	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
4c044ca9-dd15-47a7-bfc0-89cbe8874d3b	d5518614-7ec1-41a4-be7f-7766def7c2a3	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
437f49d0-a72e-4e2a-8554-8219930afbe4	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
897c1736-9488-4ee4-ac31-cb130f950356	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
03ad9e8f-8e12-4d85-906c-181a70843ce0	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
57bf0c59-a4b8-4f83-b4b7-bc329118c9fd	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
97759143-5e30-4ca1-b924-6bd1bb7fa431	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
b6fe720c-d051-47a4-8dfb-902e3b14aa3d	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
0f94ae6d-bab4-4cfa-a08c-4e7a31065224	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
0ffa8479-832d-43b2-b8cb-bb5846c4adcd	0dcd8b52-a8cb-4504-9593-390ad57248b1	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
1cfc3bcd-f0f9-4bee-bcc0-e71b057ee58e	0dcd8b52-a8cb-4504-9593-390ad57248b1	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
0cd52389-0e36-4fcf-aa19-6eaf73415dd2	0dcd8b52-a8cb-4504-9593-390ad57248b1	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
16fed02e-f7b3-4b61-9437-6c28c0b4e3b1	0dcd8b52-a8cb-4504-9593-390ad57248b1	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
68eb8240-128a-4034-bf01-8a4eb279fbbb	0dcd8b52-a8cb-4504-9593-390ad57248b1	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
0fc2985f-c1cf-4ab8-98d5-755fcc95e4b6	0dcd8b52-a8cb-4504-9593-390ad57248b1	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
44fd8593-f63d-43f0-b7b0-b2f74a8ff815	0dcd8b52-a8cb-4504-9593-390ad57248b1	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
d845a7f6-b392-42c8-b148-a14a44b6dab4	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
ae2c2e3b-1b00-453b-be0d-e65d27c06a53	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
79eb3e36-bc0a-4fcd-863c-d87adc43d475	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
1c10ec22-d8f0-43d5-bc2b-ec24835465aa	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
5daa9281-6055-4fc7-b16c-c592fde8056d	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
e2a4db69-be69-4e65-b715-d9615eb64eb9	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
3d9d2fde-15ae-4cc8-bcff-f91051490915	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
104b48ce-a83f-4607-a27f-9959afec87c4	27906aaa-d898-45df-94fa-f0d56ba93b96	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
1e106c87-9c59-41ff-aac3-ba5a7920d3cb	27906aaa-d898-45df-94fa-f0d56ba93b96	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
d91f8155-02ab-4e75-8da8-48351d55ba62	27906aaa-d898-45df-94fa-f0d56ba93b96	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
8be7fba4-91d4-4dee-ac59-0cfe71fa6734	27906aaa-d898-45df-94fa-f0d56ba93b96	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
1d249e07-a0d2-4742-a6e9-40b2671242f6	27906aaa-d898-45df-94fa-f0d56ba93b96	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
4cae9a1f-ac01-4d7a-9436-aa919908b690	27906aaa-d898-45df-94fa-f0d56ba93b96	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
385beb45-0511-4e23-ba72-639e0270e42c	27906aaa-d898-45df-94fa-f0d56ba93b96	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
00b5e408-2e91-48d7-8111-fcf6b1622030	59910a4d-1cc1-4672-9c47-dbe41610f895	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
052552a9-4015-496a-8759-383fb43ebcb7	59910a4d-1cc1-4672-9c47-dbe41610f895	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
8bd4447b-0a61-435e-be8c-2be18f91465b	59910a4d-1cc1-4672-9c47-dbe41610f895	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
7da56703-6196-4b61-9526-2048dc86a131	59910a4d-1cc1-4672-9c47-dbe41610f895	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
eed91dfb-1cf7-4c29-a37e-b30ed080b8ac	59910a4d-1cc1-4672-9c47-dbe41610f895	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
4d5fe220-9ef2-413e-91be-ceea8ea6e2d3	59910a4d-1cc1-4672-9c47-dbe41610f895	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
9fa3ffe5-c080-4196-a8e5-3fa5996f545b	59910a4d-1cc1-4672-9c47-dbe41610f895	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
a156d009-484c-4a09-855d-42d8a3859f65	65d94971-bffc-41f6-9bdf-1584a894afcf	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
57a6db34-59ef-4f6d-a8bf-a60e01b2b759	65d94971-bffc-41f6-9bdf-1584a894afcf	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
b8838297-72af-4fb5-9f55-57dcfe468e1c	65d94971-bffc-41f6-9bdf-1584a894afcf	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
aef6ea03-fa9d-4d9a-bba6-7d1080704ffe	65d94971-bffc-41f6-9bdf-1584a894afcf	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
0f539c2e-a958-4080-b2be-aa182d8ed42f	65d94971-bffc-41f6-9bdf-1584a894afcf	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
a8c75a7e-d992-40e9-a5f0-8e21b28762a5	65d94971-bffc-41f6-9bdf-1584a894afcf	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
eddc1aad-9fc6-47e9-9c16-fef806af3909	65d94971-bffc-41f6-9bdf-1584a894afcf	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
33b09d0a-6e87-4d9e-9113-4bbfe72ac194	7e4db97e-10a8-4d5b-a09f-e1413829218f	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
583660ff-8eff-4de1-870c-9f7a196449d8	7e4db97e-10a8-4d5b-a09f-e1413829218f	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
51f94e24-e235-4e8a-9271-1e5364b556a6	7e4db97e-10a8-4d5b-a09f-e1413829218f	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
eeaa8486-66de-4bcf-ae5a-2b15f7439e78	7e4db97e-10a8-4d5b-a09f-e1413829218f	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
db17e8b3-625e-4268-b5cd-7736a4faadd5	7e4db97e-10a8-4d5b-a09f-e1413829218f	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
fdd510be-2bf2-49d1-b96c-5684e345a156	7e4db97e-10a8-4d5b-a09f-e1413829218f	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
ca45f30e-cda9-442f-b0cc-3c7aac2d5644	7e4db97e-10a8-4d5b-a09f-e1413829218f	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
b2f6bb01-1294-403e-a2c3-645bf031ebb8	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
9b112171-5f38-4eca-bafd-455fe8898dbf	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
3899618a-acdc-4806-9578-d60f99559549	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
7ae1c5c3-6728-499c-ad1f-4c4a05905ebe	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
d65d9d98-29ef-4d1c-ac43-208b9e461748	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
4b4a2b40-a955-42c1-a595-0dcc5fce3bd6	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
a3ad429d-cbd3-4e19-a630-764d289837e9	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
84435d31-8bb2-4eb9-8777-0b940bdfc38d	18662390-acc3-4c97-89b3-936e72933d64	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
0a1508c9-966e-4249-b87b-a91d05b8cd8f	18662390-acc3-4c97-89b3-936e72933d64	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
aee390bb-0ce9-4de0-ac2c-b1181e0fb09b	18662390-acc3-4c97-89b3-936e72933d64	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
43bf8f71-5cb2-4758-ae4e-7bdbe1f14799	18662390-acc3-4c97-89b3-936e72933d64	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
e5960a2c-5ef8-49b0-a632-04bdc2274702	18662390-acc3-4c97-89b3-936e72933d64	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
5826a91e-ba6c-4cbe-989f-3baa6ea68afb	18662390-acc3-4c97-89b3-936e72933d64	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
036a9b0f-4271-4928-bbb2-5333768e82c3	18662390-acc3-4c97-89b3-936e72933d64	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
3acdb1f9-5c24-4dc9-9019-e7a5eedd75bb	2bfcd3ea-b43f-4848-8755-09e46c9488e4	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
8e96ffe2-a3ee-4c54-9b8b-17f3c6805e6e	2bfcd3ea-b43f-4848-8755-09e46c9488e4	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
d2150e17-17b6-4a2e-8202-efb75a4920c6	2bfcd3ea-b43f-4848-8755-09e46c9488e4	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
3ac1e213-005f-4f66-acf2-ac7ba57eba6a	2bfcd3ea-b43f-4848-8755-09e46c9488e4	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
c8ee1f85-f823-498c-a350-2036cc4ac4ca	2bfcd3ea-b43f-4848-8755-09e46c9488e4	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
9024952a-be74-4c99-8356-cf71946d0a91	2bfcd3ea-b43f-4848-8755-09e46c9488e4	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
1c15535a-19b1-411d-bea6-9ff79780e311	2bfcd3ea-b43f-4848-8755-09e46c9488e4	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
1f1ee6b1-b463-4c89-9a7c-9449fbc75a1b	90e76908-6274-4636-854d-830f2859c402	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
399c6a3c-652e-4b2b-9f28-5759cd0809e3	90e76908-6274-4636-854d-830f2859c402	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
d0addef6-90e2-4929-930e-69fb0e22a25d	90e76908-6274-4636-854d-830f2859c402	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
6bcf4208-3646-488f-ab9e-39fd7cca458d	90e76908-6274-4636-854d-830f2859c402	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
d91b9f4a-5624-45b2-9f84-2203e2cb155f	90e76908-6274-4636-854d-830f2859c402	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
863d8aec-5091-4cf5-9d1d-1d080d8f81d2	90e76908-6274-4636-854d-830f2859c402	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
46e75bbe-79a3-4a8e-a1f7-2019864d9118	90e76908-6274-4636-854d-830f2859c402	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
5a63827a-807a-40bb-ba91-05ea0c101a1b	986bdf94-1c26-4b82-a9b6-e77684300369	2026-02-08	95	2	2	0	28	2026-06-01 04:25:20.457894
c04bc15d-8653-47c4-bb80-c745b6967254	986bdf94-1c26-4b82-a9b6-e77684300369	2026-02-09	95	2	2	0	28	2026-06-01 04:25:20.457894
190b5d50-6581-437b-a991-99c831d3e12b	986bdf94-1c26-4b82-a9b6-e77684300369	2026-02-10	95	2	2	0	28	2026-06-01 04:25:20.457894
34981150-8624-4964-a988-c5c5ca564174	986bdf94-1c26-4b82-a9b6-e77684300369	2026-02-11	95	2	2	0	28	2026-06-01 04:25:20.457894
04cf080b-45f2-4dc0-b84e-8861e5394b89	986bdf94-1c26-4b82-a9b6-e77684300369	2026-02-12	95	2	2	0	28	2026-06-01 04:25:20.457894
11e71f52-f319-4d9b-8470-8bd769479464	986bdf94-1c26-4b82-a9b6-e77684300369	2026-02-13	95	2	2	0	28	2026-06-01 04:25:20.457894
255532ea-e917-4741-a463-effa655813d4	986bdf94-1c26-4b82-a9b6-e77684300369	2026-02-14	95	2	2	0	28	2026-06-01 04:25:20.457894
1809adb6-c79a-4007-abf6-acc67da3d765	7ad720b2-4d99-433c-bf6b-4a54affca5a9	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
e8c4b9f4-73b2-4ccf-8dc5-b7f0b5f02eb6	7ad720b2-4d99-433c-bf6b-4a54affca5a9	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
9b8e3e1b-dee0-43b8-a5d7-bfad29902f37	7ad720b2-4d99-433c-bf6b-4a54affca5a9	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
d8a65fcb-e513-4f48-b758-daec92de0c19	7ad720b2-4d99-433c-bf6b-4a54affca5a9	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
1b343d97-2f40-4df6-8ab0-f61f865cb409	7ad720b2-4d99-433c-bf6b-4a54affca5a9	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
d1e53538-2146-46e8-bd6b-85f324411136	7ad720b2-4d99-433c-bf6b-4a54affca5a9	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
dfbc878e-4986-4916-b8d4-447cbf0270b7	7ad720b2-4d99-433c-bf6b-4a54affca5a9	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
4739687a-8504-4c2d-a8d7-3ee963d15710	bde6795d-84dd-422d-896c-539f8ac4420b	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
bfccd5ad-6397-4247-9fe6-a94eb0db98e3	bde6795d-84dd-422d-896c-539f8ac4420b	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
ebe08a8f-8baa-4a12-9e68-5ef2e1ac4d5e	bde6795d-84dd-422d-896c-539f8ac4420b	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
06d40acc-955a-4472-a1b0-4ed68e11c3ec	bde6795d-84dd-422d-896c-539f8ac4420b	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
36831354-9189-4235-b956-da0cf27ec69d	bde6795d-84dd-422d-896c-539f8ac4420b	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
48ee7c21-691c-4ece-8112-c7c0a1ab668b	bde6795d-84dd-422d-896c-539f8ac4420b	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
4a0b335b-c7a1-4789-ae2b-01d0129aa563	bde6795d-84dd-422d-896c-539f8ac4420b	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
7b3d1fe1-a652-4dfb-8eff-0706f52be528	d1b1069d-030c-4d4d-8964-205b6c225edc	2026-02-08	55	1	1	0	15	2026-06-01 04:25:20.457894
d57fc37a-31f4-4594-8abd-e702bab8180e	d1b1069d-030c-4d4d-8964-205b6c225edc	2026-02-09	55	1	1	0	15	2026-06-01 04:25:20.457894
0563e0ed-9967-4e78-8732-6ece81d3d45d	d1b1069d-030c-4d4d-8964-205b6c225edc	2026-02-10	55	1	1	0	15	2026-06-01 04:25:20.457894
c274620d-b6ba-4188-a37f-2390937d6745	d1b1069d-030c-4d4d-8964-205b6c225edc	2026-02-11	55	1	1	0	15	2026-06-01 04:25:20.457894
f8d9660b-f8bb-4cc3-bf30-db9dc07b40f3	d1b1069d-030c-4d4d-8964-205b6c225edc	2026-02-12	55	1	1	0	15	2026-06-01 04:25:20.457894
1680688b-653d-4b51-be60-4924d7e01a5e	d1b1069d-030c-4d4d-8964-205b6c225edc	2026-02-13	55	1	1	0	15	2026-06-01 04:25:20.457894
24bfc6a1-8fe1-4093-9d0a-b0e7e4317421	d1b1069d-030c-4d4d-8964-205b6c225edc	2026-02-14	55	1	1	0	15	2026-06-01 04:25:20.457894
f152f887-9569-4ee2-8a11-d9d175c630c6	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
ac6b8ac5-2e1c-4c7d-b93d-c8c98e6c87a7	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
c831416f-fa1c-403d-8911-419a6f88cbbb	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
f9a106c7-6b73-4ae2-b6a4-5fa202e64d93	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
5e451d44-0ccb-44ad-b154-e856885a325c	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
fd4d49be-3939-4bd0-b61d-d7829ac9cbf8	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
54a66fb9-5ba2-4a98-bec7-4e7ccc0722dc	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
aa7d8838-876a-4ccd-a8b0-a28da3288c34	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
b1e31d04-27bf-4fe7-a135-00c6c5aae540	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
dfcd5b99-44fc-4065-8034-2850761d065c	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
dcdbc9c0-c08b-4ab3-90dc-ea549709f3ac	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
f96132d6-01bd-4d9a-89e9-385ae2d1d839	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
bfc3cf21-61d3-4f5c-bcb6-70d62fa47d56	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
f0a52b8c-53ba-4dbf-9237-8ccaa61420da	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
633e2193-faae-44ae-96cb-8fa1b3197003	e27fe51b-9439-43d1-9c68-7be8df445e1e	2026-02-08	20	0	0	0	6	2026-06-01 04:25:20.457894
d5c2a307-a900-49d2-bed5-de33ceefb3b5	e27fe51b-9439-43d1-9c68-7be8df445e1e	2026-02-09	20	0	0	0	6	2026-06-01 04:25:20.457894
28b66906-f148-4116-aa78-9be1e7bafc8e	e27fe51b-9439-43d1-9c68-7be8df445e1e	2026-02-10	20	0	0	0	6	2026-06-01 04:25:20.457894
3a2b48a7-db0f-4aff-aec0-7251f0d01254	e27fe51b-9439-43d1-9c68-7be8df445e1e	2026-02-11	20	0	0	0	6	2026-06-01 04:25:20.457894
c008fa7d-a74c-42c9-9181-1ce29534a324	e27fe51b-9439-43d1-9c68-7be8df445e1e	2026-02-12	20	0	0	0	6	2026-06-01 04:25:20.457894
931c874c-5852-42da-894a-ee5a583bcb7e	e27fe51b-9439-43d1-9c68-7be8df445e1e	2026-02-13	20	0	0	0	6	2026-06-01 04:25:20.457894
9432ec54-6335-468d-ada7-e7a067b8cee5	e27fe51b-9439-43d1-9c68-7be8df445e1e	2026-02-14	20	0	0	0	6	2026-06-01 04:25:20.457894
\.


--
-- Data for Name: auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auditoria (id, tabla, operacion, usuario_id, registro_id, datos_anteriores, datos_nuevos, "timestamp") FROM stdin;
\.


--
-- Data for Name: biblioteca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.biblioteca (id, titulo, descripcion, tipo_archivo, url_archivo, "tamaño_archivo", categoria, tags, subido_por, descargas, publico, activo, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: contenido_favoritos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contenido_favoritos (id, user_id, contenido_id, created_at) FROM stdin;
\.


--
-- Data for Name: contenido_generado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contenido_generado (id, type, prompt, title, content, created_by, created_at, updated_at, status) FROM stdin;
13	quiz	CREA UN QUIZ SOBRE LOS COLORES TIPO CUAL ES ESTE COLOR Y SOLO POENR EL COLOR Y ELEGIR LA OPCION	❓ Quiz Interactivo: CREA UN QUIZ SOBRE LOS COLORES TIPO CUAL...	{"questions": [{"id": 1, "text": "¿Cuál es el color del cielo?", "image": "", "correct": 1, "options": ["Rojo", "Azul", "Verde", "Amarillo"], "explanation": "El cielo es azul"}, {"id": 2, "text": "¿Cuál es el color de la hierba?", "correct": 2, "options": ["Rojo", "Azul", "Verde", "Amarillo"], "explanation": "La hierba es verde"}, {"id": 3, "text": "¿Cuál es el color del sol?", "correct": 3, "options": ["Rojo", "Azul", "Verde", "Amarillo"], "explanation": "El sol es amarillo"}, {"id": 4, "text": "¿Cuál es el color de las manzanas?", "correct": 0, "options": ["Rojo", "Azul", "Verde", "Amarillo"], "explanation": "Las manzanas son rojas"}, {"id": 5, "text": "¿Cuál es el color del mar?", "correct": 1, "options": ["Rojo", "Azul", "Verde", "Amarillo"], "explanation": "El mar es azul"}], "timeLimit": 300, "totalPoints": 50}	3a90fa1a-c502-40ab-8d7a-3fff14060570	2026-01-30 03:39:10.914446+00	2026-01-30 03:53:00.030267+00	generated
14	quiz	hazme un quiz de cultura general 	❓ Quiz Interactivo: hazme un quiz de cultura general 	{"questions": [{"id": 1, "text": "¿Quién pintó la Mona Lisa?", "correct": 0, "options": ["Leonardo", "Miguel Ángel", "Rafael", "Caravaggio"], "explanation": "Leonardo da Vinci la pintó", "image_options": ["🎨", "🖌️", "📸", "👨‍🎤"]}, {"id": 2, "text": "¿Cuál es el planeta más grande?", "correct": 2, "options": ["Tierra", "Saturno", "Júpiter", "Urano"], "explanation": "Júpiter es el planeta más grande", "image_options": ["🌎", "🌌", "🚀", "👽"]}, {"id": 3, "text": "¿Quién escribió Romeo y Julieta?", "correct": 0, "options": ["Shakespeare", "Cervantes", "Dante", "Aristóteles"], "explanation": "Shakespeare lo escribió", "image_options": ["📚", "👑", "💔", "📝"]}, {"id": 4, "text": "¿Cuál es el río más largo?", "correct": 0, "options": ["Nilo", "Amazonas", "Misisipi", "Yangtsé"], "explanation": "El Nilo es el río más largo", "image_options": ["🌊", "🌴", "🚣", "🌻"]}, {"id": 5, "text": "¿Quién fue el primer hombre en la luna?", "correct": 0, "options": ["Neil Armstrong", "Buzz Aldrin", "John Glenn", "Alan Shepard"], "explanation": "Neil Armstrong fue el primero", "image_options": ["🚀", "👽", "🌕", "👨‍🚀"]}], "timeLimit": 300, "totalPoints": 50}	3a90fa1a-c502-40ab-8d7a-3fff14060570	2026-04-26 21:57:25.722003+00	2026-04-26 21:57:25.722003+00	generated
17	quiz	Hazme preguntas de cultura general 	Quiz Interactivo: Hazme preguntas de cultura general 	{"questions": [{"id": 1, "puntos": 10, "opciones": ["Júpiter", "Tierra", "Marte", "Saturno"], "pregunta": "¿Cuál es el planeta más grande en nuestro sistema solar?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "Júpiter es el planeta más grande en nuestro sistema solar, con un diámetro de aproximadamente 142.984 kilómetros.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 2, "puntos": 10, "opciones": ["J.R.R. Tolkien", "C.S. Lewis", "J.K. Rowling", "George R.R. Martin"], "pregunta": "¿Quién es el autor de la famosa novela 'El Señor de los Anillos'?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "J.R.R. Tolkien es el autor de la novela 'El Señor de los Anillos', publicada en 1954-1955.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 3, "puntos": 10, "opciones": ["Ballena", "Tiburón", "Delfín", "Pez globo"], "pregunta": "¿Cuál es el animal más grande que vive en el agua?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "La ballena azul es el animal más grande que vive en el agua, con una longitud de hasta 33 metros.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 4, "puntos": 10, "opciones": ["Leonardo da Vinci", "Miguel Ángel", "Rafael", "Caravaggio"], "pregunta": "¿Quién es el pintor que creó la famosa pintura 'La Gioconda'?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "Leonardo da Vinci pintó la famosa obra 'La Gioconda', también conocida como la Mona Lisa.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 5, "puntos": 10, "opciones": ["Cristóbal Colón", "Fernando Magallanes", "Vasco Núñez de Balboa", "Juan Sebastián Elcano"], "pregunta": "¿Cuál es el nombre del famoso explorador que descubrió América?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "Cristóbal Colón es el explorador que descubrió América en 1492.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}], "totalPoints": 50}	3a90fa1a-c502-40ab-8d7a-3fff14060570	2026-06-06 15:33:28.952825+00	2026-06-06 15:33:28.952825+00	generated
18	quiz	hazme de basica elemental	Quiz Interactivo: hazme de basica elemental	{"questions": [{"id": 1, "puntos": 10, "opciones": ["6", "7", "8", "9"], "pregunta": "¿Cuál es el número que viene después del 5?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "El número que viene después del 5 es 6.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 2, "puntos": 10, "opciones": ["Rojo", "Azul", "Amarillo", "Verde"], "pregunta": "¿Cuál es el color de la bandera de España?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "La bandera de España es roja y amarilla, pero la pregunta es sobre el color principal.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 3, "puntos": 10, "opciones": ["3", "4", "5", "6"], "pregunta": "¿Cuántos lados tiene un cuadrado?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 2, "retroalimentacion_correcta": "Un cuadrado tiene 4 lados.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 4, "puntos": 10, "opciones": ["Lunes", "Martes", "Miércoles", "Jueves"], "pregunta": "¿Cuál es el nombre del primer día de la semana?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "El primer día de la semana se llama lunes.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 5, "puntos": 10, "opciones": ["1", "2", "3", "4"], "pregunta": "¿Cuántos ojos tiene un gato?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 1, "retroalimentacion_correcta": "Un gato tiene 2 ojos.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}], "totalPoints": 50}	14076186-432f-49f8-87c2-093a3ae9804f	2026-06-09 16:31:28.071248+00	2026-06-09 16:31:28.071248+00	generated
\.


--
-- Data for Name: contenido_usos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contenido_usos (id, contenido_id, usuario_id, tipo_uso, detalles, created_at) FROM stdin;
\.


--
-- Data for Name: cursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cursos (id, titulo, descripcion, nivel_id, imagen_url, color, orden, activo, created_by, created_at, updated_at) FROM stdin;
99999999-9999-9999-9999-999999999999	Aprendizajes Básicos - Segundo Grado	Contenido educativo para niños de 6-7 años. Matemáticas y Lenguaje divertidas.	\N	\N	#3B82F6	1	t	\N	2026-06-01 04:25:20.457894	2026-06-01 04:25:20.457894
\.


--
-- Data for Name: evaluaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evaluaciones (id, titulo, descripcion, curso_id, preguntas, puntuacion_maxima, tiempo_limite, intentos_permitidos, activo, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: foros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.foros (id, titulo, descripcion, curso_id, nivel_id, created_by, activo, created_at) FROM stdin;
\.


--
-- Data for Name: grupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupos (id, nombre, descripcion, activo, created_at, updated_at) FROM stdin;
f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	Segundo EGB		t	2026-02-09 13:39:49.491	2026-02-09 13:39:50.628428
e0dd019c-0367-41a6-986f-bfa53d26e9e0	Tercero EGB		t	2026-02-09 13:43:10.876	2026-02-09 13:43:12.487658
38d9544d-79ef-47e7-b666-c485e8d7498a	Cuarto EGB		t	2026-02-09 13:43:28.905	2026-02-09 13:43:30.486162
\.


--
-- Data for Name: logros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logros (id, nombre, descripcion, icono, color, condicion, puntos_requeridos, puntos_recompensa, rareza, categoria, activo, created_at) FROM stdin;
9589169b-f2fa-437e-a352-32e56e302a77	Filosofico		💡	#FFD700	\N	100	50	comun	general	t	2025-12-13 17:51:21.101
00cde776-ad17-4ddd-8153-b0b5be4c11a9	Matemáticos		🥇	#FFD700	\N	100	50	comun	general	t	2025-12-15 03:25:39.707
\.


--
-- Data for Name: mensajes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mensajes (id, usuario_id, destinatario_id, curso_id, tipo, mensaje, leido, created_at) FROM stdin;
\.


--
-- Data for Name: mentorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mentorias (id, mentor_id, estudiante_id, curso_id, estado, notas, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: niveles_aprendizaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.niveles_aprendizaje (id, nombre, descripcion, orden, activo, created_at, updated_at) FROM stdin;
02f1fe6e-5c43-4e6f-8a2d-9c1705cf452a	Básico	Nivel introductorio para principiantes	1	t	2025-10-18 21:18:30.660236	2025-10-18 21:18:30.660236
bc044bd3-1769-444d-ac66-d054f4fe8c2a	Intermedio	Nivel para estudiantes con conocimientos previos	2	t	2025-10-18 21:18:30.660236	2025-10-18 21:18:30.660236
9ed6ff43-6dd3-46c3-b6d3-b43229146df5	Avanzado	Nivel para estudiantes experimentados	3	t	2025-10-18 21:18:30.660236	2025-10-18 21:18:30.660236
24ad9a2c-dcd5-4f38-ab9b-445ff2783717	Experto	Nivel para usuarios avanzados	4	t	2025-10-18 21:18:30.660236	2025-10-18 21:18:30.660236
a99ac2ea-989a-4ef2-a3fa-ba19e9381c78	Segundo de Básica	Segundo grado de educación básica elemental (6-7 años)	2	t	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
\.


--
-- Data for Name: progreso_estudiantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.progreso_estudiantes (id, usuario_id, recurso_id, completado, tiempo_dedicado, puntuacion, mejor_puntuacion, respuestas_quiz, fecha_completado, intentos, created_at, updated_at, progreso, retroalimentacion, respuestas_dadas, iniciado_en) FROM stdin;
318086e4-d666-4bd3-bd04-586ad6f5b049	0dcd8b52-a8cb-4504-9593-390ad57248b1	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	150	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	87	\N	{}	2026-06-01 04:33:48.823371
d3ffa55d-7e2e-4ce5-8aa0-7141e3215194	0dcd8b52-a8cb-4504-9593-390ad57248b1	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	265	\N	0	\N	\N	3	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
3d913a89-641b-4785-b41e-3a5cc37a6957	de898141-8c5a-4c06-a4ab-156c42c5423f	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	232	\N	0	\N	\N	2	2026-02-08 10:00:00	2026-02-08 10:00:00	51	\N	{}	2026-06-01 04:33:48.823371
6103a9dd-aa40-4a70-b422-ed4de432deb1	de898141-8c5a-4c06-a4ab-156c42c5423f	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	282	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	61	\N	{}	2026-06-01 04:33:48.823371
e33fbb44-72c4-4ea6-99f0-7b533a89ac73	905f655a-0fbd-487a-ad7b-59038d764266	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	379	\N	0	\N	\N	5	2026-02-08 08:00:00	2026-02-08 08:00:00	20	\N	{}	2026-06-01 04:33:48.823371
097c9d11-068c-46c5-aaaa-b29e0a6c6d2b	905f655a-0fbd-487a-ad7b-59038d764266	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	349	\N	0	\N	\N	5	2026-02-10 09:00:00	2026-02-10 09:00:00	14	\N	{}	2026-06-01 04:33:48.823371
c82af3ff-62b7-4fa8-bab1-3755967c0b89	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	129	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	92	\N	{}	2026-06-01 04:33:48.823371
230e5c71-5d30-417d-abf1-33a8e5d08619	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	224	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
3bf1f0c1-261f-462e-910d-56584d209a99	26688e35-629c-454e-acde-484d41aa3898	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	228	\N	0	\N	\N	2	2026-02-08 10:00:00	2026-02-08 10:00:00	79	\N	{}	2026-06-01 04:33:48.823371
ce72d777-ea72-417b-88db-dbc4d39660c4	26688e35-629c-454e-acde-484d41aa3898	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	223	\N	0	\N	\N	2	2026-02-13 11:00:00	2026-02-13 11:00:00	78	\N	{}	2026-06-01 04:33:48.823371
af5d10be-ce69-4785-8006-703c7903eaa5	d10972bb-7465-4c66-aa17-8b8fd5bfb557	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	433	\N	0	\N	\N	7	2026-02-08 08:00:00	2026-02-08 08:00:00	49	\N	{}	2026-06-01 04:33:48.823371
f7468673-71f2-4e65-9ed1-e403fc178064	d10972bb-7465-4c66-aa17-8b8fd5bfb557	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	373	\N	0	\N	\N	6	2026-02-10 09:00:00	2026-02-10 09:00:00	37	\N	{}	2026-06-01 04:33:48.823371
f91fecd6-21e0-4025-b5cc-175df4bb102f	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	157	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	95	\N	{}	2026-06-01 04:33:48.823371
6c4e581c-8f04-48ff-bea4-b9ad276dc85a	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	207	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
e1d497a5-d616-4a5d-a0e7-f792ed2eb027	b0f8ff61-98f5-413b-900b-5a3626c3d328	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	239	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	71	\N	{}	2026-06-01 04:33:48.823371
e7329d6b-326a-493b-b170-cf74ac24ea48	b0f8ff61-98f5-413b-900b-5a3626c3d328	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	244	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	72	\N	{}	2026-06-01 04:33:48.823371
9bfdf6dd-7559-471f-8721-b93f9d7750d9	27906aaa-d898-45df-94fa-f0d56ba93b96	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	499	\N	0	\N	\N	5	2026-02-08 08:00:00	2026-02-08 08:00:00	37	\N	{}	2026-06-01 04:33:48.823371
b9952cbe-15b4-4a3e-a018-d4fb479a610e	27906aaa-d898-45df-94fa-f0d56ba93b96	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	409	\N	0	\N	\N	4	2026-02-10 09:00:00	2026-02-10 09:00:00	19	\N	{}	2026-06-01 04:33:48.823371
a4f07b6a-72c3-433d-a8c7-d9327d64bf92	e38b0586-f894-491a-a30e-6d40f70673d3	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	269	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	80	\N	{}	2026-06-01 04:33:48.823371
b77641dc-595c-4eaf-9bbc-b2017998038e	e38b0586-f894-491a-a30e-6d40f70673d3	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	299	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	86	\N	{}	2026-06-01 04:33:48.823371
660c0af0-ac6c-4058-bfeb-b04ff73f071b	59910a4d-1cc1-4672-9c47-dbe41610f895	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	400	\N	0	\N	\N	6	2026-02-08 08:00:00	2026-02-08 08:00:00	15	\N	{}	2026-06-01 04:33:48.823371
16d5c12d-d97a-44e6-b8e8-bc9381b19dcf	59910a4d-1cc1-4672-9c47-dbe41610f895	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	390	\N	0	\N	\N	6	2026-02-10 09:00:00	2026-02-10 09:00:00	13	\N	{}	2026-06-01 04:33:48.823371
1b3c683e-39e1-4ff6-9f56-955bb8b2c68b	6a6c6706-0b1b-4eca-b269-446091719c1f	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	138	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	86	\N	{}	2026-06-01 04:33:48.823371
e3acd8b4-6916-4b4b-8aeb-dc6436f3b27f	6a6c6706-0b1b-4eca-b269-446091719c1f	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	258	\N	0	\N	\N	3	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
291c3d2f-570d-48c9-b621-11a6195f1e67	a28ba234-4391-4854-9d52-66a1e5a1d9a6	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	252	\N	0	\N	\N	2	2026-02-08 10:00:00	2026-02-08 10:00:00	54	\N	{}	2026-06-01 04:33:48.823371
87636b77-1a9b-401e-9485-25eb8aef8c3b	a28ba234-4391-4854-9d52-66a1e5a1d9a6	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	277	\N	0	\N	\N	2	2026-02-13 11:00:00	2026-02-13 11:00:00	59	\N	{}	2026-06-01 04:33:48.823371
c28925a4-fcc8-44f2-8b62-90f017b63475	90e76908-6274-4636-854d-830f2859c402	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	407	\N	0	\N	\N	6	2026-02-08 08:00:00	2026-02-08 08:00:00	19	\N	{}	2026-06-01 04:33:48.823371
1b6695cc-eea5-4dc4-b8f7-6692f69bb190	90e76908-6274-4636-854d-830f2859c402	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	352	\N	0	\N	\N	5	2026-02-10 09:00:00	2026-02-10 09:00:00	8	\N	{}	2026-06-01 04:33:48.823371
b8a023f0-f8f7-4bda-ad3f-be449263913b	986bdf94-1c26-4b82-a9b6-e77684300369	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	136	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	97	\N	{}	2026-06-01 04:33:48.823371
b629f310-c8a5-4b91-bb56-4cc60317f33f	986bdf94-1c26-4b82-a9b6-e77684300369	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	191	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
1c471e4e-ca8e-494f-ac43-a5612228328f	e6090c60-7141-44f8-95e9-017cb844fc34	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	229	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	69	\N	{}	2026-06-01 04:33:48.823371
6b30082b-6753-4915-8edf-88c59d0e9e36	e6090c60-7141-44f8-95e9-017cb844fc34	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	264	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	76	\N	{}	2026-06-01 04:33:48.823371
f43a81b6-bca6-46a3-a2f7-ca2c13add765	482d28a2-3771-4ea9-97ab-0aaff07f08ca	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	388	\N	0	\N	\N	6	2026-02-08 08:00:00	2026-02-08 08:00:00	25	\N	{}	2026-06-01 04:33:48.823371
9ed08f54-b91c-488f-95d9-5f3ca568e4b7	482d28a2-3771-4ea9-97ab-0aaff07f08ca	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	368	\N	0	\N	\N	6	2026-02-10 09:00:00	2026-02-10 09:00:00	21	\N	{}	2026-06-01 04:33:48.823371
fb5897e4-c325-4af8-b1fb-ee405277bd79	9e24b9cc-4c16-4092-8158-88e6361b8ccc	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	156	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	94	\N	{}	2026-06-01 04:33:48.823371
445ff841-039f-4614-b0e9-8bff7601fac9	9e24b9cc-4c16-4092-8158-88e6361b8ccc	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	276	\N	0	\N	\N	3	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
d7af7838-add8-4c54-8010-2113b38a89d2	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	250	\N	0	\N	\N	4	2026-02-08 10:00:00	2026-02-08 10:00:00	52	\N	{}	2026-06-01 04:33:48.823371
b61dea18-8ba9-4a3b-a437-765a7d4c4af6	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	310	\N	0	\N	\N	5	2026-02-13 11:00:00	2026-02-13 11:00:00	64	\N	{}	2026-06-01 04:33:48.823371
8e5f9c7f-1f2e-47c0-a443-41426fe66f46	2a8d5621-1e97-4086-8fdf-691f322f2da6	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	394	\N	0	\N	\N	6	2026-02-08 08:00:00	2026-02-08 08:00:00	25	\N	{}	2026-06-01 04:33:48.823371
d78f0e2e-9f76-4692-a621-169083916625	2a8d5621-1e97-4086-8fdf-691f322f2da6	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	359	\N	0	\N	\N	6	2026-02-10 09:00:00	2026-02-10 09:00:00	18	\N	{}	2026-06-01 04:33:48.823371
9049a76e-1d29-471b-b69e-091d61ed6c78	3dbfbfd0-744a-45ba-8e54-cd53e216853a	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	152	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	85	\N	{}	2026-06-01 04:33:48.823371
ff9f1df4-5663-41ec-9049-9a313db8af14	3dbfbfd0-744a-45ba-8e54-cd53e216853a	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	297	\N	0	\N	\N	3	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
8470a2a2-e591-458f-abad-e2c0c903429e	32f09e62-2442-422a-be58-67e834637275	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	291	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	56	\N	{}	2026-06-01 04:33:48.823371
05a282ad-f51f-4087-a5be-c2361f352d15	32f09e62-2442-422a-be58-67e834637275	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	306	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	59	\N	{}	2026-06-01 04:33:48.823371
75d6ca9f-d0c4-4ba9-a610-cfcfc2996bf3	580ba549-750e-4aba-9602-9a867dddfadb	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	463	\N	0	\N	\N	6	2026-02-08 08:00:00	2026-02-08 08:00:00	26	\N	{}	2026-06-01 04:33:48.823371
3dc49369-f51b-4b99-b4f1-73e9bdc01767	580ba549-750e-4aba-9602-9a867dddfadb	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	393	\N	0	\N	\N	5	2026-02-10 09:00:00	2026-02-10 09:00:00	12	\N	{}	2026-06-01 04:33:48.823371
8b08ef73-8fff-4d71-af0a-cd33460a8787	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	156	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	99	\N	{}	2026-06-01 04:33:48.823371
d7a7576d-ff35-4ede-94f6-81154d4130ea	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	236	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
21d3d5a8-690a-42a1-a1bf-34e87b425103	a642c609-fee9-439a-81b6-8f0cbea00dd5	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	240	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	62	\N	{}	2026-06-01 04:33:48.823371
fbfa118b-dd40-48ab-a8c7-adeb1f8ecb0f	a642c609-fee9-439a-81b6-8f0cbea00dd5	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	310	\N	0	\N	\N	4	2026-02-13 11:00:00	2026-02-13 11:00:00	76	\N	{}	2026-06-01 04:33:48.823371
04cbde5a-98fb-4578-bc69-8acd137baa3a	7ad720b2-4d99-433c-bf6b-4a54affca5a9	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	386	\N	0	\N	\N	4	2026-02-08 08:00:00	2026-02-08 08:00:00	44	\N	{}	2026-06-01 04:33:48.823371
b3c08b9b-efa1-4679-bdea-34808f10835b	7ad720b2-4d99-433c-bf6b-4a54affca5a9	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	306	\N	0	\N	\N	3	2026-02-10 09:00:00	2026-02-10 09:00:00	28	\N	{}	2026-06-01 04:33:48.823371
88979fba-0b91-4739-aca7-31eca70a39b5	e6fccc63-1e3f-4626-87d2-d5d50a49823d	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	147	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	88	\N	{}	2026-06-01 04:33:48.823371
20eda462-228e-4751-8dd4-d95eaa05ce68	e6fccc63-1e3f-4626-87d2-d5d50a49823d	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	222	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
728cd02d-c170-4ddf-8591-5165d92b2bc4	785e224c-54c1-42dc-b2e9-60842ce1ba99	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	228	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	69	\N	{}	2026-06-01 04:33:48.823371
664aea34-4260-48d8-9f3a-eff24514c740	785e224c-54c1-42dc-b2e9-60842ce1ba99	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	233	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	70	\N	{}	2026-06-01 04:33:48.823371
ee47515c-f15e-408f-89f8-db03a00510bb	bde6795d-84dd-422d-896c-539f8ac4420b	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	402	\N	0	\N	\N	6	2026-02-08 08:00:00	2026-02-08 08:00:00	24	\N	{}	2026-06-01 04:33:48.823371
5ece2be0-3ec9-4efe-98c5-abaf1a87ff5e	bde6795d-84dd-422d-896c-539f8ac4420b	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	332	\N	0	\N	\N	5	2026-02-10 09:00:00	2026-02-10 09:00:00	10	\N	{}	2026-06-01 04:33:48.823371
73415e7d-0684-4534-a3ba-f5e14af058a9	65d94971-bffc-41f6-9bdf-1584a894afcf	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	137	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	95	\N	{}	2026-06-01 04:33:48.823371
c5afe728-4de2-446e-b809-348fc04ce160	65d94971-bffc-41f6-9bdf-1584a894afcf	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	267	\N	0	\N	\N	3	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
f4a7d19c-9bc0-4055-869c-4fc9cfccdd46	de713c42-2907-4e6b-9630-b6452aaa85e8	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	239	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	67	\N	{}	2026-06-01 04:33:48.823371
d86ae03f-6033-46d8-8f23-c264b4994cd6	de713c42-2907-4e6b-9630-b6452aaa85e8	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	254	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	70	\N	{}	2026-06-01 04:33:48.823371
d4a6d535-7409-4e2f-92b5-e70b247df242	8001f39c-8317-4978-a843-e418a960935e	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	385	\N	0	\N	\N	6	2026-02-08 08:00:00	2026-02-08 08:00:00	32	\N	{}	2026-06-01 04:33:48.823371
eb76906c-7f1b-4e3d-a51f-f827677b46b7	8001f39c-8317-4978-a843-e418a960935e	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	365	\N	0	\N	\N	6	2026-02-10 09:00:00	2026-02-10 09:00:00	28	\N	{}	2026-06-01 04:33:48.823371
9ad5cdd5-9816-4805-bae4-66a198477201	7ddf8681-7824-4556-bd1d-b6762639494d	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	135	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	92	\N	{}	2026-06-01 04:33:48.823371
c6857d84-eeca-4623-bdf2-b8d597b27409	7ddf8681-7824-4556-bd1d-b6762639494d	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	190	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
8485a8ae-954a-4e3a-bd3f-e4a9edae9190	d1b1069d-030c-4d4d-8964-205b6c225edc	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	206	\N	0	\N	\N	2	2026-02-08 10:00:00	2026-02-08 10:00:00	58	\N	{}	2026-06-01 04:33:48.823371
0a310918-1320-43f0-b569-1693eb86c82c	d1b1069d-030c-4d4d-8964-205b6c225edc	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	236	\N	0	\N	\N	2	2026-02-13 11:00:00	2026-02-13 11:00:00	64	\N	{}	2026-06-01 04:33:48.823371
e8691c42-43c5-41ea-8fa2-edbee3f005fa	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	421	\N	0	\N	\N	5	2026-02-08 08:00:00	2026-02-08 08:00:00	41	\N	{}	2026-06-01 04:33:48.823371
2bae8000-e4f3-4fba-9a84-33c7cf95df1c	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	341	\N	0	\N	\N	4	2026-02-10 09:00:00	2026-02-10 09:00:00	25	\N	{}	2026-06-01 04:33:48.823371
ce035b85-26d1-409a-8591-163e6d860a87	978b6007-734d-495c-b05d-5dcc00c31840	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	134	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	91	\N	{}	2026-06-01 04:33:48.823371
61a206b8-da5e-4b53-ae1c-ed512ff5bef3	978b6007-734d-495c-b05d-5dcc00c31840	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	279	\N	0	\N	\N	3	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
484afb2e-8288-41d7-a06d-a55e1636af9e	00178fa6-2f3f-4e27-834a-b85a72009406	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	265	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	70	\N	{}	2026-06-01 04:33:48.823371
6057ac76-1d87-4970-bfa0-a981f5d795e3	00178fa6-2f3f-4e27-834a-b85a72009406	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	245	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	66	\N	{}	2026-06-01 04:33:48.823371
9208d2ac-4730-4e89-a6f0-a73aea05c81d	ec701f35-da9c-4f6a-a7bf-16b3f4646384	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	491	\N	0	\N	\N	4	2026-02-08 08:00:00	2026-02-08 08:00:00	22	\N	{}	2026-06-01 04:33:48.823371
ac4aa6c7-0a98-4fdc-90e8-bcd2bc36561f	ec701f35-da9c-4f6a-a7bf-16b3f4646384	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	466	\N	0	\N	\N	4	2026-02-10 09:00:00	2026-02-10 09:00:00	17	\N	{}	2026-06-01 04:33:48.823371
02853cea-4892-4cb1-aba1-b06d612c043f	d4b91756-4c44-4a23-8efc-9d71b2fc5090	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	131	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	95	\N	{}	2026-06-01 04:33:48.823371
893c4d8e-b61c-4723-9161-cc0fd6b2cac8	d4b91756-4c44-4a23-8efc-9d71b2fc5090	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	241	\N	0	\N	\N	3	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
427ee9b0-c5bb-4d54-a92d-7dfdef30ca00	43719c9b-96a8-4c86-9a15-11fdf767e47c	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	295	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	60	\N	{}	2026-06-01 04:33:48.823371
91d419aa-5e09-4b98-afcf-1af4f1024ad1	43719c9b-96a8-4c86-9a15-11fdf767e47c	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	330	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	67	\N	{}	2026-06-01 04:33:48.823371
da6f2018-a01c-4460-bcf9-d0f581237ea3	7e4db97e-10a8-4d5b-a09f-e1413829218f	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	489	\N	0	\N	\N	5	2026-02-08 08:00:00	2026-02-08 08:00:00	41	\N	{}	2026-06-01 04:33:48.823371
d99df157-b743-436d-9883-01ff350c8502	7e4db97e-10a8-4d5b-a09f-e1413829218f	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	474	\N	0	\N	\N	5	2026-02-10 09:00:00	2026-02-10 09:00:00	38	\N	{}	2026-06-01 04:33:48.823371
b709310b-77a4-47b4-b020-268774808f5f	d5518614-7ec1-41a4-be7f-7766def7c2a3	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	124	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	98	\N	{}	2026-06-01 04:33:48.823371
9a441b9c-c833-4bf6-a3a4-acf1d94b1ef6	d5518614-7ec1-41a4-be7f-7766def7c2a3	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	204	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
77798cd5-bf95-4272-aa92-ce124074c2a0	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	264	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	79	\N	{}	2026-06-01 04:33:48.823371
8e2609c3-b765-4eaf-a108-b5d96304eb3b	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	324	\N	0	\N	\N	4	2026-02-13 11:00:00	2026-02-13 11:00:00	91	\N	{}	2026-06-01 04:33:48.823371
c59c9423-a664-46fb-9146-7174eeee7e69	779382f6-1c9f-45c8-b016-e057e4409004	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	435	\N	0	\N	\N	5	2026-02-08 08:00:00	2026-02-08 08:00:00	48	\N	{}	2026-06-01 04:33:48.823371
7d7a6485-dc16-4c84-9b8e-51fc5d5afe1f	779382f6-1c9f-45c8-b016-e057e4409004	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	405	\N	0	\N	\N	5	2026-02-10 09:00:00	2026-02-10 09:00:00	42	\N	{}	2026-06-01 04:33:48.823371
ef1ac7aa-1e9e-40ae-a367-a7eaa71e4fe3	232ea473-5be2-4940-b307-f408e425c394	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	164	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	90	\N	{}	2026-06-01 04:33:48.823371
e4ac2653-6e0d-4ef3-b6de-4efff74abba2	232ea473-5be2-4940-b307-f408e425c394	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	274	\N	0	\N	\N	3	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
511c55d8-73e3-4707-8e7e-11b08c5a49f4	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	259	\N	0	\N	\N	2	2026-02-08 10:00:00	2026-02-08 10:00:00	78	\N	{}	2026-06-01 04:33:48.823371
4cbc8741-fca5-4247-9041-bced52ae9215	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	274	\N	0	\N	\N	2	2026-02-13 11:00:00	2026-02-13 11:00:00	81	\N	{}	2026-06-01 04:33:48.823371
34d8e99e-ab70-45ad-86ba-cc2430ab6edd	7e5bfd44-8365-44f6-98bf-7e6325688a4c	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	413	\N	0	\N	\N	5	2026-02-08 08:00:00	2026-02-08 08:00:00	26	\N	{}	2026-06-01 04:33:48.823371
81562a3e-4005-4055-8d5a-959b1b002c1e	7e5bfd44-8365-44f6-98bf-7e6325688a4c	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	363	\N	0	\N	\N	4	2026-02-10 09:00:00	2026-02-10 09:00:00	16	\N	{}	2026-06-01 04:33:48.823371
6330707a-e644-4381-8b98-66e5405c0ec0	e27fe51b-9439-43d1-9c68-7be8df445e1e	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	168	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	87	\N	{}	2026-06-01 04:33:48.823371
b2ea103d-efe1-47f3-8404-1bc5f052ab86	e27fe51b-9439-43d1-9c68-7be8df445e1e	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	273	\N	0	\N	\N	3	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
06ba8e1d-bb1b-4a38-9a11-0346ff7df457	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	268	\N	0	\N	\N	3	2026-02-08 10:00:00	2026-02-08 10:00:00	62	\N	{}	2026-06-01 04:33:48.823371
90a5b28c-4e23-40fd-bd16-980318d070c3	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	293	\N	0	\N	\N	3	2026-02-13 11:00:00	2026-02-13 11:00:00	67	\N	{}	2026-06-01 04:33:48.823371
1bc8038f-c8db-44ac-b5ef-368d161798eb	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	429	\N	0	\N	\N	5	2026-02-08 08:00:00	2026-02-08 08:00:00	39	\N	{}	2026-06-01 04:33:48.823371
7032fc3c-7eb7-4604-8804-a9c3bae19132	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	409	\N	0	\N	\N	5	2026-02-10 09:00:00	2026-02-10 09:00:00	35	\N	{}	2026-06-01 04:33:48.823371
5b2023e3-84e6-4a1f-88ba-b8baa8788b18	dc89d075-e87f-4eb0-af3b-de9979123693	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	173	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	100	\N	{}	2026-06-01 04:33:48.823371
eea93955-72fe-44b0-aefd-fcb62479bfed	dc89d075-e87f-4eb0-af3b-de9979123693	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	228	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
fc3c9669-e393-4223-86b2-074048083525	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	226	\N	0	\N	\N	2	2026-02-08 10:00:00	2026-02-08 10:00:00	67	\N	{}	2026-06-01 04:33:48.823371
8e0fe312-5c84-43b9-828c-00bfca41d250	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	221	\N	0	\N	\N	2	2026-02-13 11:00:00	2026-02-13 11:00:00	66	\N	{}	2026-06-01 04:33:48.823371
ed57bc18-7702-4d09-89ed-26d8978c5906	fd9c1c4a-2e54-456d-b348-29236f48e6ad	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	440	\N	0	\N	\N	6	2026-02-08 08:00:00	2026-02-08 08:00:00	46	\N	{}	2026-06-01 04:33:48.823371
9f937402-ad1d-4b1b-b6f8-c31798dee9b5	fd9c1c4a-2e54-456d-b348-29236f48e6ad	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	400	\N	0	\N	\N	6	2026-02-10 09:00:00	2026-02-10 09:00:00	38	\N	{}	2026-06-01 04:33:48.823371
c26062ed-a8cd-4eaf-9883-9d20bfd17378	affcad27-1178-40e2-978a-e6417dd3584e	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	136	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	96	\N	{}	2026-06-01 04:33:48.823371
383dd365-710e-4d53-b945-a37a30f91ed9	affcad27-1178-40e2-978a-e6417dd3584e	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	191	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
07c30e4d-9141-42be-a662-83def041a9c2	1ff5e152-0c12-4004-9d71-0e05c0318282	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	203	\N	0	\N	\N	2	2026-02-08 10:00:00	2026-02-08 10:00:00	68	\N	{}	2026-06-01 04:33:48.823371
872de767-4e98-45b3-9a99-ee0e4984a20a	1ff5e152-0c12-4004-9d71-0e05c0318282	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	178	\N	0	\N	\N	2	2026-02-13 11:00:00	2026-02-13 11:00:00	63	\N	{}	2026-06-01 04:33:48.823371
8f6ca075-6d1f-4497-8c33-6c48694179d5	18662390-acc3-4c97-89b3-936e72933d64	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	f	474	\N	0	\N	\N	7	2026-02-08 08:00:00	2026-02-08 08:00:00	25	\N	{}	2026-06-01 04:33:48.823371
11cfc3fd-fb38-4835-85ca-096ca22903d4	18662390-acc3-4c97-89b3-936e72933d64	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	f	464	\N	0	\N	\N	7	2026-02-10 09:00:00	2026-02-10 09:00:00	23	\N	{}	2026-06-01 04:33:48.823371
e529001e-48ca-4073-b93b-3778d018b0ca	2bfcd3ea-b43f-4848-8755-09e46c9488e4	aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	t	147	\N	0	\N	\N	1	2026-02-08 09:00:00	2026-02-08 09:00:00	93	\N	{}	2026-06-01 04:33:48.823371
85f29a02-aa36-4c97-8923-d1b4b931ed6c	2bfcd3ea-b43f-4848-8755-09e46c9488e4	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	207	\N	0	\N	\N	2	2026-02-14 10:00:00	2026-02-14 10:00:00	100	\N	{}	2026-06-01 04:33:48.823371
106c19f7-145f-4791-bb39-e8d6e6d1b342	14076186-432f-49f8-87c2-093a3ae9804f	bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	t	0	40	40	\N	2026-06-08 22:11:30.549	1	2026-06-08 22:11:31.474696	2026-06-08 22:11:31.474696	0	\N	{}	2026-06-08 22:11:31.474696
\.


--
-- Data for Name: publicaciones_foro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publicaciones_foro (id, foro_id, usuario_id, titulo, contenido, padre_id, likes, activo, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: puntos_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.puntos_usuario (id, usuario_id, puntos_totales, experiencia, nivel_actual, racha_dias, ultima_actividad, estadisticas, created_at, updated_at) FROM stdin;
fa35671f-4eaf-4b60-879a-2d689b225476	2cc8a612-00ce-4281-959f-4fe2b239f700	0	0	1	0	2025-12-01	{}	2025-12-01 22:40:38.189813	2025-12-01 22:40:38.189813
618db656-8711-422e-98fe-ac08ef83e849	0dcd8b52-a8cb-4504-9593-390ad57248b1	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-09 15:24:57.581121	2026-02-09 15:24:57.581121
0dd0c802-64ef-4b94-a273-cf1c0568e44f	de898141-8c5a-4c06-a4ab-156c42c5423f	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
751e0589-f779-44de-9ed0-62b81c230144	905f655a-0fbd-487a-ad7b-59038d764266	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
a28d37ca-99ad-4d11-a605-aa0944571072	a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:31:55.672132	2026-02-10 16:31:55.672132
7f64599b-d182-4e61-abd0-b636255e4575	26688e35-629c-454e-acde-484d41aa3898	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
85e5f8b4-44e0-4dd3-a245-ea82b97df34b	d10972bb-7465-4c66-aa17-8b8fd5bfb557	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
ec6ee79a-6616-499b-8e90-3b31d0d31373	a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
ec310685-028c-4a1c-9de3-38144d0d16e7	b0f8ff61-98f5-413b-900b-5a3626c3d328	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:28:45.010227	2026-02-10 16:28:45.010227
ccd636d5-6560-44de-92d8-a21125481188	27906aaa-d898-45df-94fa-f0d56ba93b96	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:17:46.966257	2026-02-10 16:17:46.966257
f2b634dd-e88a-430a-857b-2cc6838e0d1c	14076186-432f-49f8-87c2-093a3ae9804f	0	0	1	0	2026-06-08	{}	2026-06-08 22:08:23.227019	2026-06-08 22:08:23.227019
bef6b51e-6815-40d5-b93d-a0fd3056a624	e38b0586-f894-491a-a30e-6d40f70673d3	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
64c52ff1-c1a6-40ed-8a8c-cc42b37cec68	59910a4d-1cc1-4672-9c47-dbe41610f895	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:08:17.36815	2026-02-10 16:08:17.36815
f49f015d-99fb-4e56-b8be-1acca9255b04	6a6c6706-0b1b-4eca-b269-446091719c1f	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
0701e95b-5b8d-4b7f-82a4-2e206e742f21	a28ba234-4391-4854-9d52-66a1e5a1d9a6	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
a12fc1dd-d633-425a-9652-7c5fca3d2b58	90e76908-6274-4636-854d-830f2859c402	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-09 15:28:14.312166	2026-02-09 15:28:14.312166
144bb816-c3ef-48a4-8bd0-84fd4d202761	986bdf94-1c26-4b82-a9b6-e77684300369	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:00:04.131246	2026-02-10 16:00:04.131246
467f52f2-9ba7-4751-afae-f6bef3dcf529	e6090c60-7141-44f8-95e9-017cb844fc34	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
a0c41a10-48e8-4d76-a84b-21cdddda7817	482d28a2-3771-4ea9-97ab-0aaff07f08ca	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
11e8097e-305f-4f06-a4c0-282a3f9453de	9e24b9cc-4c16-4092-8158-88e6361b8ccc	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-09 15:21:28.608463	2026-02-09 15:21:28.608463
ed511989-c31c-4966-9856-7f96e01f5da6	5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
eb96161c-09b3-4417-bdbb-77c6ec778f2e	2a8d5621-1e97-4086-8fdf-691f322f2da6	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
4616710b-997b-41aa-8418-04103fc333d6	3dbfbfd0-744a-45ba-8e54-cd53e216853a	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
dc4ece4e-35bc-496c-b876-9551cc98bbe6	32f09e62-2442-422a-be58-67e834637275	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
71edae3d-25e6-4977-80d8-23b4fb919fa5	580ba549-750e-4aba-9602-9a867dddfadb	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
82c5aa25-6fb3-48c9-beff-89700721011d	cf71a249-fbcc-4ea4-bed0-0e12662d04ab	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
9f4f070e-6db1-4607-bcf5-42fb7ee8a95b	a642c609-fee9-439a-81b6-8f0cbea00dd5	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:38:16.428595	2026-02-10 16:38:16.428595
d00af258-e568-4777-84c3-ee0086773081	7ad720b2-4d99-433c-bf6b-4a54affca5a9	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-12 14:17:08.156375	2026-02-12 14:17:08.156375
d3a158b6-a57b-422d-9dbc-4e15d55156a5	e6fccc63-1e3f-4626-87d2-d5d50a49823d	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
5f61370a-932c-4957-a7ed-129f410f738a	785e224c-54c1-42dc-b2e9-60842ce1ba99	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
f3854feb-d3cc-47bf-9641-b41fd5eef3fa	bde6795d-84dd-422d-896c-539f8ac4420b	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 15:54:43.265991	2026-02-10 15:54:43.265991
1c563738-009e-4975-a13b-325c486d1350	65d94971-bffc-41f6-9bdf-1584a894afcf	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-09 13:58:32.86629	2026-02-09 13:58:32.86629
6a30d80c-95f5-48af-ac28-db4a543856b0	de713c42-2907-4e6b-9630-b6452aaa85e8	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
c7bb28f2-32d4-47fb-bf92-4876c692ab7f	8001f39c-8317-4978-a843-e418a960935e	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
b19e0d2c-b455-4d0b-86be-7d9d80d08d21	7ddf8681-7824-4556-bd1d-b6762639494d	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:24:16.595092	2026-02-10 16:24:16.595092
63caa1e3-209f-432d-9978-03d08cc89671	d1b1069d-030c-4d4d-8964-205b6c225edc	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:02:22.937315	2026-02-10 16:02:22.937315
d79bd5e2-d578-48f5-a5cf-275f9fe53b04	b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
bffdbbb1-9ae9-42bd-8451-4db2f0e13530	978b6007-734d-495c-b05d-5dcc00c31840	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
008f16b3-2f21-4fcb-9f2a-d96d2096d34b	00178fa6-2f3f-4e27-834a-b85a72009406	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
74efd20c-4d1f-410a-8c30-8f8265b89637	ec701f35-da9c-4f6a-a7bf-16b3f4646384	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
c24e4241-608e-41b3-b7e2-b65e80515360	d4b91756-4c44-4a23-8efc-9d71b2fc5090	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
85b9d91e-f3ed-45b8-b30f-9dcb52f8854c	43719c9b-96a8-4c86-9a15-11fdf767e47c	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
2088210a-c156-46df-8e26-7c7c326e164e	7e4db97e-10a8-4d5b-a09f-e1413829218f	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-09 15:19:42.240778	2026-02-09 15:19:42.240778
e46b2e76-1faa-4242-89b6-bbd384590f69	d5518614-7ec1-41a4-be7f-7766def7c2a3	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
a969e79d-b783-4bf1-9347-eb376831ce9e	6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:14:01.259609	2026-02-10 16:14:01.259609
db2afb8d-8094-4311-915a-b083cf08c5f5	779382f6-1c9f-45c8-b016-e057e4409004	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:35:29.00465	2026-02-10 16:35:29.00465
7598ebfa-260b-474a-aefe-9cd495663863	232ea473-5be2-4940-b307-f408e425c394	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
a354b0c4-2562-4359-b684-93c5db415697	10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
5e4fe33c-ebc6-4d51-a5ef-0180683a3393	7e5bfd44-8365-44f6-98bf-7e6325688a4c	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
6f5bb2f7-1316-4172-9cd1-d4684ec01c21	e27fe51b-9439-43d1-9c68-7be8df445e1e	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:21:27.811511	2026-02-10 16:21:27.811511
3858c79a-04ee-4688-9116-67b263248ac7	83de3b76-25a7-4029-b9f9-81ca51cd7a4b	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
c2da9773-a93a-4ed5-8d1b-74ac924c0788	7cd9c5af-064a-4cc5-87f1-981015fa3f3b	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:10:39.007025	2026-02-10 16:10:39.007025
6b0c0292-2836-4724-b779-f842a742b588	dc89d075-e87f-4eb0-af3b-de9979123693	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
e2486423-4d06-468d-9fdb-2803153d1b73	8a4021ac-4471-4ba9-9b46-bc1a715ea72e	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
a6f1252c-0185-4685-86b9-5c77fd4fbe7a	fd9c1c4a-2e54-456d-b348-29236f48e6ad	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
3c462ddd-57a9-4f2b-8563-4062e3376b63	affcad27-1178-40e2-978a-e6417dd3584e	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
c46e92db-f0c8-451a-a4e2-b35d7f53c94e	1ff5e152-0c12-4004-9d71-0e05c0318282	350	1200	3	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-05-31 18:58:29.057547	2026-05-31 18:58:29.057547
c48424ba-4605-44a2-b57b-920c8a5d778e	18662390-acc3-4c97-89b3-936e72933d64	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-10 16:04:54.734279	2026-02-10 16:04:54.734279
5aab33bb-782c-4955-9208-da4acad2d242	2bfcd3ea-b43f-4848-8755-09e46c9488e4	350	1200	1	6	2026-05-14	{"tiempo_total": 28, "puntaje_promedio": 100, "quizzes_completados": 2}	2026-02-09 15:16:39.451971	2026-02-09 15:16:39.451971
\.


--
-- Data for Name: recursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recursos (id, titulo, descripcion, tipo, url, contenido, contenido_quiz, metadata, dificultad, curso_id, orden, puntos_recompensa, tiempo_estimado, activo, created_by, created_at, updated_at) FROM stdin;
bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb	Quiz: Animales de la Granja	Adivina el animal por su sonido o descripción	quiz	\N	\N	[{"puntos": 10, "opciones": ["Perro", "Gato", "Vaca", "Cerdo"], "pregunta": "¿Qué animal hace \\"muuu\\"?", "imagen_url": "🐮", "imagen_opciones": ["🐕", "🐈", "🐄", "🐖"], "respuesta_correcta": 2, "retroalimentacion_correcta": "¡Correcto! La vaca hace \\"muuu\\"", "retroalimentacion_incorrecta": "¡Inténtalo! La vaca hace \\"muuu\\""}, {"puntos": 10, "opciones": ["Vaca", "Gallina", "Cerdo", "Caballo"], "pregunta": "¿Qué animal pone huevos?", "imagen_url": "🐔", "imagen_opciones": ["🐄", "🐔", "🐖", "🐴"], "respuesta_correcta": 1, "retroalimentacion_correcta": "¡Muy bien! La gallina pone huevos", "retroalimentacion_incorrecta": "¡Sigue intentando! La gallina pone huevos"}, {"puntos": 10, "opciones": ["Gallina", "Pato", "Pavo", "Ganso"], "pregunta": "¿Qué animal dice \\"cuac cuac\\"?", "imagen_url": "🦆", "imagen_opciones": ["🐔", "🦆", "🦃", "🦢"], "respuesta_correcta": 1, "retroalimentacion_correcta": "¡Excelente! El pato dice \\"cuac cuac\\"", "retroalimentacion_incorrecta": "¡Vamos! El pato dice \\"cuac cuac\\""}, {"puntos": 10, "opciones": ["Cerdo", "Caballo", "Vaca", "Oveja"], "pregunta": "¿Qué animal da leche?", "imagen_url": "🥛", "imagen_opciones": ["🐖", "🐴", "🐄", "🐑"], "respuesta_correcta": 2, "retroalimentacion_correcta": "¡Perfecto! La vaca da leche", "retroalimentacion_incorrecta": "¡Inténtalo! La vaca da leche"}, {"puntos": 10, "opciones": ["Vaca", "Cerdo", "Oveja", "Cabra"], "pregunta": "¿Qué animal tiene lana?", "imagen_url": "🐑", "imagen_opciones": ["🐄", "🐖", "🐑", "🐐"], "respuesta_correcta": 2, "retroalimentacion_correcta": "¡Correcto! La oveja tiene lana", "retroalimentacion_incorrecta": "¡Sigue aprendiendo! La oveja tiene lana"}]	{}	media	99999999-9999-9999-9999-999999999999	1	10	3	t	\N	2026-06-01 04:25:20.457894	2026-06-01 04:25:20.457894
aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa	Quiz: Sumas Básicas	Aprende a sumar números del 1 al 10	quiz	\N	\N	[{"id": "quiz_1780301245269_0", "tipo": "multiple", "puntos": 10, "opciones": ["4", "5", "6", "7"], "pregunta": "¿Cuánto es 2 + 3?", "video_url": "", "imagen_url": "🍎", "tiempo_limite": 45, "audio_opciones": ["", "", "", ""], "audio_pregunta": true, "imagen_opciones": ["🔴", "🟢", "🔵", "🟡"], "respuesta_correcta": 1, "audio_retroalimentacion": true, "retroalimentacion_correcta": "¡Excelente! 2 + 3 = 5", "retroalimentacion_incorrecta": "¡Inténtalo de nuevo! 2 + 3 = 5"}, {"id": "quiz_1780301245269_1", "tipo": "multiple", "puntos": 10, "opciones": ["6", "7", "8", "9"], "pregunta": "¿Cuánto es 5 + 2?", "video_url": "", "imagen_url": "🍌", "tiempo_limite": 45, "audio_opciones": ["", "", "", ""], "audio_pregunta": true, "imagen_opciones": ["🔴", "🟢", "🔵", "🟡"], "respuesta_correcta": 1, "audio_retroalimentacion": true, "retroalimentacion_correcta": "¡Muy bien! 5 + 2 = 7", "retroalimentacion_incorrecta": "¡Sigue intentando! 5 + 2 = 7"}, {"id": "quiz_1780301245269_2", "tipo": "multiple", "puntos": 10, "opciones": ["6", "7", "8", "9"], "pregunta": "¿Cuánto es 4 + 4?", "video_url": "", "imagen_url": "🍕", "tiempo_limite": 45, "audio_opciones": ["", "", "", ""], "audio_pregunta": true, "imagen_opciones": ["🔴", "🟢", "🔵", "🟡"], "respuesta_correcta": 2, "audio_retroalimentacion": true, "retroalimentacion_correcta": "¡Perfecto! 4 + 4 = 8", "retroalimentacion_incorrecta": "¡Vamos! 4 + 4 = 8"}, {"id": "quiz_1780301245270_3", "tipo": "multiple", "puntos": 10, "opciones": ["5", "6", "7", "8"], "pregunta": "¿Cuánto es 1 + 6?", "video_url": "", "imagen_url": "🍉", "tiempo_limite": 45, "audio_opciones": ["", "", "", ""], "audio_pregunta": true, "imagen_opciones": ["🔴", "🟢", "🔵", "🟡"], "respuesta_correcta": 2, "audio_retroalimentacion": true, "retroalimentacion_correcta": "¡Excelente! 1 + 6 = 7", "retroalimentacion_incorrecta": "¡Inténtalo! 1 + 6 = 7"}, {"id": "quiz_1780301245270_4", "tipo": "multiple", "puntos": 10, "opciones": ["9", "10", "8", "11"], "pregunta": "¿Cuánto es 3 + 7?", "video_url": "", "imagen_url": "🌟", "tiempo_limite": 45, "audio_opciones": ["", "", "", ""], "audio_pregunta": true, "imagen_opciones": ["🔴", "🟢", "🔵", "🟡"], "respuesta_correcta": 1, "audio_retroalimentacion": true, "retroalimentacion_correcta": "¡Felicidades! 3 + 7 = 10", "retroalimentacion_incorrecta": "¡Sigue practicando! 3 + 7 = 10"}]	{"tiene_audio": true, "tiene_video": false, "actualizado_en": "2026-06-01T08:08:05.334Z", "puntos_totales": 50, "tiene_imagenes": true, "total_preguntas": 5}	media	99999999-9999-9999-9999-999999999999	1	10	3	t	\N	2026-06-01 04:25:20.457894	2026-06-01 08:08:05.334
3030f5f6-a66b-4bde-b473-7c314b457929	Quiz Interactivo: hazme de basica elemental	Contenido generado: hazme de basica elemental	quiz	\N	\N	{"questions": [{"id": 1, "puntos": 10, "opciones": ["6", "7", "8", "9"], "pregunta": "¿Cuál es el número que viene después del 5?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "El número que viene después del 5 es 6.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 2, "puntos": 10, "opciones": ["Rojo", "Azul", "Amarillo", "Verde"], "pregunta": "¿Cuál es el color de la bandera de España?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "La bandera de España es roja y amarilla, pero la pregunta es sobre el color principal.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 3, "puntos": 10, "opciones": ["3", "4", "5", "6"], "pregunta": "¿Cuántos lados tiene un cuadrado?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 2, "retroalimentacion_correcta": "Un cuadrado tiene 4 lados.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 4, "puntos": 10, "opciones": ["Lunes", "Martes", "Miércoles", "Jueves"], "pregunta": "¿Cuál es el nombre del primer día de la semana?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 0, "retroalimentacion_correcta": "El primer día de la semana se llama lunes.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}, {"id": 5, "puntos": 10, "opciones": ["1", "2", "3", "4"], "pregunta": "¿Cuántos ojos tiene un gato?", "imagen_url": "❓", "imagen_opciones": ["🔴", "🔵", "🟢", "🟡"], "respuesta_correcta": 1, "retroalimentacion_correcta": "Un gato tiene 2 ojos.", "retroalimentacion_incorrecta": "¡Intenta otra vez! 💪"}], "totalPoints": 50}	{}	media	99999999-9999-9999-9999-999999999999	1	50	10	t	14076186-432f-49f8-87c2-093a3ae9804f	2026-06-09 16:33:01.854	2026-06-09 16:33:01.940563
\.


--
-- Data for Name: resultados_evaluaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resultados_evaluaciones (id, evaluacion_id, usuario_id, respuestas, puntuacion, porcentaje, tiempo_dedicado, intento_numero, aprobado, created_at) FROM stdin;
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, auth_id, nombre, email, rol, created_at, updated_at, roles_adicionales, grupo_id, activo, ultimo_acceso, puntos_totales, grupos_adicionales, usuario) FROM stdin;
2cc8a612-00ce-4281-959f-4fe2b239f700	3a90fa1a-c502-40ab-8d7a-3fff14060570	Admin	ynlldom@gmail.com	admin	2025-10-18 21:23:06.47253	2026-06-08 22:45:05.496	{estudiante}	\N	t	2026-06-08 22:02:32.735	0	{}	ynlldom
b0f8ff61-98f5-413b-900b-5a3626c3d328	ac8e6da9-87c7-49a5-8791-31208c8005f2	Breyner German Tejena Chilan	breynertejena@didactikapp.com	estudiante	2026-02-10 15:43:14.824108	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	breynertejena
e6090c60-7141-44f8-95e9-017cb844fc34	40e4b506-1d73-4298-8d8b-2011f8e24bef	Dereck Joel Pinargote Cordoba	dereckpinargote@didactikapp.com	estudiante	2026-02-10 15:34:51.319557	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	dereckpinargote
9e24b9cc-4c16-4092-8158-88e6361b8ccc	0aff3647-bda6-48f4-9e6a-4bf9d1f9e118	Donoban S Arangundi Criollo	donobansarangundi@didactikapp.com	estudiante	2026-02-09 13:48:17.288289	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	donobansarangundi
7ddf8681-7824-4556-bd1d-b6762639494d	b60a73bd-7f4b-4062-8407-62cefee3b0d0	Juan Issac Buste Tuala	juantuala@didactikapp.com	estudiante	2026-02-10 15:20:39.504854	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-14 10:00:00	0	{}	juantuala
a500f34d-dc5a-4e4a-bbe3-c321a56a9e00	771ad79b-34ce-4812-9d05-3914d9ada480	Andrainna Mayte Hormaza Falconez	maytehormaza@didactikapp.com	estudiante	2026-02-10 15:25:15.759142	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-14 10:00:00	0	{}	maytehormaza
26688e35-629c-454e-acde-484d41aa3898	9247ea7b-2d1d-45b3-b037-6ec04945be81	Arisley Ahinoa Alava Arteaga	arisleyalava@didactikapp.com	estudiante	2026-02-10 15:17:41.208471	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	arisleyalava
2a8d5621-1e97-4086-8fdf-691f322f2da6	27356752-78d4-4833-bdbc-ac5ceb23883e	Emma Asuncion Rivas Barcia	emmarivas@didactikapp.com	estudiante	2026-02-10 15:40:40.910849	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	emmarivas
a642c609-fee9-439a-81b6-8f0cbea00dd5	ca71cb86-8002-48da-8292-cbd21b04c618	Iker Santiago Zambrano Laz	ikerzambrano@didactikapp.com	estudiante	2026-02-10 15:48:13.376077	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	ikerzambrano
00178fa6-2f3f-4e27-834a-b85a72009406	7b542b46-6fbd-4176-bbbb-5cf594c49da2	Luis Sebastian Chilan Bachicorea	luischilan@didactikapp.com	estudiante	2026-02-09 14:45:35.23817	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-13 11:00:00	0	{}	luischilan
779382f6-1c9f-45c8-b016-e057e4409004	d8c0e70f-ec4a-4f82-88a2-8d2d6be35e03	Ninoska Yurani Pin Molina	ninoskapin@didactikapp.com	estudiante	2026-02-10 15:34:02.258616	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	ninoskapin
232ea473-5be2-4940-b307-f408e425c394	a6a516f4-345e-4af4-a95d-fcab95a375c4	Pedro Elias Campos Chiguita	pedrocampos@didactikapp.com	estudiante	2026-02-09 13:51:32.71158	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	pedrocampos
10a4d10c-c6ad-43c1-ba2a-ab4c40624e35	47739d07-5148-4e33-9aee-d236406d760e	Raul Felipe Palma Vera	raulpalma@didactikapp.com	estudiante	2026-02-10 15:32:55.879646	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	raulpalma
1ff5e152-0c12-4004-9d71-0e05c0318282	a12584c4-19a5-4716-83d9-e0bb42fbf002	Tiago Alexander Mendoza Reina	tiagomendoza@didactikapp.com	estudiante	2026-02-09 15:02:13.318832	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-13 11:00:00	0	{}	tiagomendoza
14076186-432f-49f8-87c2-093a3ae9804f	14076186-432f-49f8-87c2-093a3ae9804f	Merly Zambrano Bravo 	paolamerly1@gmail.com	admin	2026-06-02 03:51:15.745378	2026-06-08 22:26:59.302	{estudiante}	\N	t	2026-06-09 16:53:28.119	0	{}	paolamerly1
482d28a2-3771-4ea9-97ab-0aaff07f08ca	8ab7aa02-e0d4-4b20-8689-4cb0922bb5e8	Domenica Adamaris Ponce España	domenicaponce@didactikapp.com	estudiante	2026-02-10 15:35:47.041439	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	domenicaponce
3dbfbfd0-744a-45ba-8e54-cd53e216853a	1ab2b7a0-85ae-4f0b-83e3-6f7ac0431eb7	Enzo Mathias Palmas Menendez	enzopalmas@didactikapp.com	estudiante	2026-02-10 15:32:18.83112	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-14 10:00:00	0	{}	enzopalmas
32f09e62-2442-422a-be58-67e834637275	e180edb5-9a66-4602-9e4a-17a4c9c70d92	Gael Dominic Miranda Laz	gaelmiranda@didactikapp.com	estudiante	2026-02-09 15:04:53.436178	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-13 11:00:00	0	{}	gaelmiranda
43719c9b-96a8-4c86-9a15-11fdf767e47c	6c94d34d-5856-4649-8998-7eb1090fdf09	Matheo Leonel Chilan Pinargote	matheochilan@didactikapp.com	estudiante	2026-02-09 14:47:13.830251	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-13 11:00:00	0	{}	matheochilan
0e773dca-0696-446d-8700-d934e7cd5151	0e773dca-0696-446d-8700-d934e7cd5151	Tatiana Zambrano	tatiana.zambrano@utm.edu.ec	estudiante	2025-10-21 13:22:28.174197	2026-06-02 03:17:49.387269	{}	\N	t	\N	0	{}	\N
520498cc-f65a-42a2-97b6-22f766b06cfc	520498cc-f65a-42a2-97b6-22f766b06cfc	Mendoza	ahitannamiley@didactikapp.com	estudiante	2026-02-09 14:53:18.215193	2026-06-02 03:17:49.387269	{}	\N	t	\N	0	{}	\N
de898141-8c5a-4c06-a4ab-156c42c5423f	d81fa5d0-b828-47be-bf4f-d04e151c937f	Ailen Dariela Molina Palma	ailenmolina@didactikapp.com	estudiante	2026-02-09 15:07:00.866619	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-13 11:00:00	0	{}	ailenmolina
6a6c6706-0b1b-4eca-b269-446091719c1f	f01696d1-6d9b-4d61-a9dd-fbd2901f4a7e	Damaris Sophia Palacios Lopez	damarispalacios@didactikapp.com	estudiante	2026-02-09 15:12:41.565392	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	damarispalacios
a28ba234-4391-4854-9d52-66a1e5a1d9a6	92a11fb0-ed08-4d87-9ae4-e7bac360a51d	Dastin Isaias Paredes Garcia	dastinparedes@didactikapp.com	estudiante	2026-02-12 14:24:04.457672	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-13 11:00:00	0	{}	dastinparedes
5fbbdd6e-5c9f-4c18-9f88-9d5839cf2b67	18a33406-19e8-4e01-a292-bf1cd1af8c65	Edison Gabriel Garcia Tuala	edisongarcia@didactikapp.com	estudiante	2026-02-10 15:24:03.492523	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	edisongarcia
580ba549-750e-4aba-9602-9a867dddfadb	5dc9910f-4d2e-4fae-8907-0fe3b596cde0	Gregorio Xavier Posligua Tejena	gregorioposligua@didactikapp.com	estudiante	2026-02-10 15:37:15.545842	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	gregorioposligua
b7328cc6-10c2-4aa7-a0f6-f31828f16e3a	f681ddbe-c67f-44f1-9969-31b64b4c879a	Keyla Oana Molina Garcia	keylamolina@didactikapp.com	estudiante	2026-02-09 15:07:53.541561	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-10 09:00:00	0	{}	keylamolina
785e224c-54c1-42dc-b2e9-60842ce1ba99	83bb0944-5672-4759-b72b-37deea537a47	Jose Antonio Posligua Chilan	joseposligua@didactikapp.com	estudiante	2026-02-10 15:36:26.882638	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	joseposligua
ec701f35-da9c-4f6a-a7bf-16b3f4646384	f5def64f-2c9e-4165-9302-4c4870991dad	Maria Jose Moreira Vera	mariamoreira@didactikapp.com	estudiante	2026-02-10 15:29:01.448071	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	mariamoreira
d4b91756-4c44-4a23-8efc-9d71b2fc5090	00aff592-6206-428c-9476-2ca0e5c985bf	Mariel Sarahi Molina Vera	marielmolina@didactikapp.com	estudiante	2026-02-09 15:08:45.906965	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	marielmolina
7e5bfd44-8365-44f6-98bf-7e6325688a4c	5d623cd2-7471-4ffc-8341-f55de82f5b7c	Renatha Isabella Arteaga Cedeño	renathaarteaga@didactikapp.com	estudiante	2026-02-09 13:50:12.499042	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-10 09:00:00	0	{}	renathaarteaga
dc89d075-e87f-4eb0-af3b-de9979123693	811c750f-97ad-4705-8156-9cdf28b37323	Sasha Ariana Chilan Posligua	sashachilan@didactikapp.com	estudiante	2026-02-09 14:48:57.117553	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	sashachilan
fd9c1c4a-2e54-456d-b348-29236f48e6ad	91976250-d16f-48f5-9315-c89017ed5980	Sofia Cristel Pin Tejena	sofiapin@didactikapp.com	estudiante	2026-02-12 14:24:54.782527	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-10 09:00:00	0	{}	sofiapin
905f655a-0fbd-487a-ad7b-59038d764266	88bbd661-7479-4a84-b9ef-4f32da93ff26	Ainhoa Kaitlin Chavez Palma	ainhoachavez@didactikapp.com	estudiante	2026-02-09 14:40:47.121505	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-10 09:00:00	0	{}	ainhoachavez
cf71a249-fbcc-4ea4-bed0-0e12662d04ab	75424ae3-8fbd-4752-8c5c-2bb5e38be82f	Guillermo F Fernandez Alcivar	guillermofernandez@didactikapp.com	estudiante	2026-02-09 14:50:48.02455	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	guillermofernandez
e6fccc63-1e3f-4626-87d2-d5d50a49823d	2e05a86b-6966-4266-a17a-cedc2aad1567	Jimmy Jael Medranda Pico	jimmymedranda@didactikapp.com	estudiante	2026-02-09 15:00:31.42098	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	jimmymedranda
8001f39c-8317-4978-a843-e418a960935e	28f6c2fe-742e-4188-b53d-700ba85aec4c	Juan David Carreño Guatarama	juandavidcarreno@didactikapp.com	estudiante	2026-02-09 14:36:25.260895	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-10 09:00:00	0	{}	juandavidcarreno
affcad27-1178-40e2-978a-e6417dd3584e	d39fd319-3593-4ddc-840a-5a89f73a3d75	Sophie Monserrat Mala Palma	sophiemala@didactikapp.com	estudiante	2026-02-09 14:58:09.18444	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	sophiemala
d10972bb-7465-4c66-aa17-8b8fd5bfb557	9b79fcf6-f192-4364-80ec-ab95b18c87e3	Ashley Krilley Murillo Mantuano	ashleymurillo@didactikapp.com	estudiante	2026-02-10 15:29:58.849423	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	ashleymurillo
e38b0586-f894-491a-a30e-6d40f70673d3	937926f9-3c6b-46d2-9cf3-341479442747	Carlos Mathias Reyes Loor	carlosreyes@didactikapp.com	estudiante	2026-02-10 15:38:11.872436	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	carlosreyes
de713c42-2907-4e6b-9630-b6452aaa85e8	02d3430e-9601-4b3b-a6d6-e9390872b54b	Jostin Yeriel Molina Angulo	jostinmolina@didactikapp.com	estudiante	2026-02-10 15:28:14.392261	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	jostinmolina
978b6007-734d-495c-b05d-5dcc00c31840	a883d161-ec1f-497b-91c6-16543a922792	Liz Maria Sanchez Rivas	lizsanchez@didactikapp.com	estudiante	2026-02-10 15:42:12.660722	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-14 10:00:00	0	{}	lizsanchez
d5518614-7ec1-41a4-be7f-7766def7c2a3	7bab67c8-74d3-4a9e-a2b1-990223186d4e	Mia Fiorella Palma Laz	miapalma@didactikapp.com	estudiante	2026-02-10 15:31:18.330366	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-14 10:00:00	0	{}	miapalma
83de3b76-25a7-4029-b9f9-81ca51cd7a4b	7524e67f-698f-40b6-8424-26f05bac35e1	Samara Sherazade Marin Laz	samaramarin@didactikapp.com	estudiante	2026-02-10 15:27:16.050808	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	samaramarin
0dcd8b52-a8cb-4504-9593-390ad57248b1	ba0d8cac-1ab0-4319-86cd-6e9840a12111	Ahitanna Miley Laz Mendoza	ahitannamileylaz@didactikapp.com	estudiante	2026-02-09 14:56:44.588943	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	ahitannamileylaz
a6d728b9-5bfc-4b5f-bb12-fe9b53f9a951	242a6366-d3f0-4a5a-ba81-0db7aed6ac63	Breyli Gregoria Velez Aragundi	breylivelez@didactikapp.com	estudiante	2026-02-10 15:46:03.429721	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-14 10:00:00	0	{}	breylivelez
27906aaa-d898-45df-94fa-f0d56ba93b96	f1ff761b-109b-46ac-8ffd-991130b7cfe7	Brihana Samara Torres Vera	brihanatorres@didactikapp.com	estudiante	2026-02-10 15:47:33.697631	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	brihanatorres
59910a4d-1cc1-4672-9c47-dbe41610f895	085e1141-b596-4dd7-8bbc-cccb55bf46fa	Carlos Noriel Tejena Zambrano	carlostejena@didactikapp.com	estudiante	2026-02-10 15:45:14.500054	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	carlostejena
65d94971-bffc-41f6-9bdf-1584a894afcf	1326d366-a9f6-4216-9395-fb904afcb5eb	Jose Ramon Chavez Rivas	josechavez@didactikapp.com	estudiante	2026-02-09 13:54:55.601647	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	josechavez
7e4db97e-10a8-4d5b-a09f-e1413829218f	e6059964-8108-4ff1-a812-f6eca0cbd3f7	Mia Fiorella Alava Pin	miaalava@didactikapp.com	estudiante	2026-02-09 13:46:49.813545	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-10 09:00:00	0	{}	miaalava
8a4021ac-4471-4ba9-9b46-bc1a715ea72e	ba9207cf-7064-435f-8ab0-0ac8a9679084	Sheryl Keyveveth Zambrano Palma	sherylzambrabo@didactikapp.com	estudiante	2026-02-10 15:49:00.830481	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	sherylzambrabo
18662390-acc3-4c97-89b3-936e72933d64	07698bac-d8fb-4e65-982d-27c4d482f909	Yasbeth Fiorela Barrezueta Cano	yasbethbarrezueta@didactikapp.com	estudiante	2026-02-10 15:19:35.832734	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	yasbethbarrezueta
2bfcd3ea-b43f-4848-8755-09e46c9488e4	2244697e-3126-4d57-af2d-ab28686fc83d	Yulieth Paulette Rivas Palma	yuliethrivas@didactikapp.com	estudiante	2026-02-09 15:16:15.407477	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-14 10:00:00	0	{}	yuliethrivas
90e76908-6274-4636-854d-830f2859c402	11133b74-e96b-46b7-9c9c-585824841fe6	Dayra Iveth Palma Alarcon	dayrapalma@didactikapp.com	estudiante	2026-02-09 15:27:55.128783	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-10 09:00:00	0	{}	dayrapalma
986bdf94-1c26-4b82-a9b6-e77684300369	23830ef8-baf0-4b79-bae5-b8c2cfda4931	Deker jose Laz Rodriguez	dekerlaz@didactikapp.com	estudiante	2026-02-10 15:26:28.112163	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-14 10:00:00	0	{}	dekerlaz
7ad720b2-4d99-433c-bf6b-4a54affca5a9	4f59b75d-bb02-40d9-9cd2-b653d198a438	Jesus David Pin Vera	jesuspin@didactikapp.com	estudiante	2026-02-12 14:16:26.593047	2026-05-31 01:19:24.620088	{}	f49d08aa-d2b5-4bdd-aa8e-7472785e11c9	t	2026-02-10 09:00:00	0	{}	jesuspin
bde6795d-84dd-422d-896c-539f8ac4420b	8faf560f-ba50-4fc1-b96c-384072c80c90	Jose Gerardo Delgado Molina	josedelgado@didactikapp.com	estudiante	2026-02-10 15:23:20.852372	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	josedelgado
d1b1069d-030c-4d4d-8964-205b6c225edc	d656273e-e4fe-448d-9aa1-7e87839688d6	Jusney Joel Rivas Chilan	jusneyrivas@didactikapp.com	estudiante	2026-02-10 15:41:30.136514	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	jusneyrivas
6dc09a6e-3fd8-4f31-86d4-6d1fba9dd497	4ba36fc8-7010-4374-96b4-51d95257be5a	Moises Oseias Palma Correa	moisespalma@didactikapp.com	estudiante	2026-02-10 15:30:40.10951	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-13 11:00:00	0	{}	moisespalma
7cd9c5af-064a-4cc5-87f1-981015fa3f3b	ed3fc59a-eab6-4126-9062-d79a3153f5da	Samir Randy Tejena Vera	samirtejena@didactikapp.com	estudiante	2026-02-10 15:43:51.487274	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-10 09:00:00	0	{}	samirtejena
e27fe51b-9439-43d1-9c68-7be8df445e1e	9b07c741-12ea-4816-83ff-6eec722cd7da	Roselyne Elizabeth Cedeño Posligua	roselinecedeno@didactikapp.com	estudiante	2026-02-10 15:22:17.29686	2026-05-31 01:19:24.620088	{}	e0dd019c-0367-41a6-986f-bfa53d26e9e0	t	2026-02-14 10:00:00	0	{}	roselinecedeno
\.


--
-- Data for Name: usuarios_logros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios_logros (id, usuario_id, logro_id, progreso, completado, fecha_obtenido) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-09-03 19:19:04
20211116045059	2025-09-03 19:19:07
20211116050929	2025-09-03 19:19:09
20211116051442	2025-09-03 19:19:11
20211116212300	2025-09-03 19:19:14
20211116213355	2025-09-03 19:19:16
20211116213934	2025-09-03 19:19:18
20211116214523	2025-09-03 19:19:21
20211122062447	2025-09-03 19:19:23
20211124070109	2025-09-03 19:19:25
20211202204204	2025-09-03 19:19:27
20211202204605	2025-09-03 19:19:30
20211210212804	2025-09-03 19:19:37
20211228014915	2025-09-03 19:19:39
20220107221237	2025-09-03 19:19:41
20220228202821	2025-09-03 19:19:43
20220312004840	2025-09-03 19:19:45
20220603231003	2025-09-03 19:19:49
20220603232444	2025-09-03 19:19:51
20220615214548	2025-09-03 19:19:53
20220712093339	2025-09-03 19:19:55
20220908172859	2025-09-03 19:19:57
20220916233421	2025-09-03 19:20:00
20230119133233	2025-09-03 19:20:02
20230128025114	2025-09-03 19:20:05
20230128025212	2025-09-03 19:20:07
20230227211149	2025-09-03 19:20:09
20230228184745	2025-09-03 19:20:11
20230308225145	2025-09-03 19:20:13
20230328144023	2025-09-03 19:20:15
20231018144023	2025-09-03 19:20:18
20231204144023	2025-09-03 19:20:21
20231204144024	2025-09-03 19:20:23
20231204144025	2025-09-03 19:20:26
20240108234812	2025-09-03 19:20:28
20240109165339	2025-09-03 19:20:30
20240227174441	2025-09-03 19:20:34
20240311171622	2025-09-03 19:20:37
20240321100241	2025-09-03 19:20:42
20240401105812	2025-09-03 19:20:48
20240418121054	2025-09-03 19:20:51
20240523004032	2025-09-03 19:20:59
20240618124746	2025-09-03 19:21:01
20240801235015	2025-09-03 19:21:03
20240805133720	2025-09-03 19:21:05
20240827160934	2025-09-03 19:21:07
20240919163303	2025-09-03 19:21:10
20240919163305	2025-09-03 19:21:12
20241019105805	2025-09-03 19:21:14
20241030150047	2025-09-03 19:21:23
20241108114728	2025-09-03 19:21:25
20241121104152	2025-09-03 19:21:28
20241130184212	2025-09-03 19:21:30
20241220035512	2025-09-03 19:21:32
20241220123912	2025-09-03 19:21:34
20241224161212	2025-09-03 19:21:37
20250107150512	2025-09-03 19:21:39
20250110162412	2025-09-03 19:21:41
20250123174212	2025-09-03 19:21:43
20250128220012	2025-09-03 19:21:45
20250506224012	2025-09-03 19:21:47
20250523164012	2025-09-03 19:21:49
20250714121412	2025-09-03 19:21:51
20250905041441	2025-10-15 14:59:31
20251103001201	2025-11-19 14:10:33
20251120212548	2026-02-12 17:34:13
20251120215549	2026-02-12 17:34:13
20260218120000	2026-06-11 05:18:58
20260326120000	2026-06-11 05:18:58
20260514120000	2026-06-11 05:18:58
20260527120000	2026-06-11 05:18:58
20260528120000	2026-06-11 05:18:58
20260603120000	2026-06-11 05:18:58
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter, selected_columns) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-09-03 19:19:00.698712
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-09-03 19:19:00.717288
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-09-03 19:19:00.919757
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-09-03 19:19:01.51331
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-09-03 19:19:01.523119
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-09-03 19:19:01.543949
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-09-03 19:19:01.573896
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-09-03 19:19:01.652354
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-09-03 19:19:01.674505
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-09-03 19:19:01.688001
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-09-03 19:19:01.693711
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-09-03 19:19:01.953949
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-09-03 19:19:01.95822
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-09-03 19:19:01.965386
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-09-03 19:19:01.981687
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-09-03 19:19:01.991959
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-09-03 19:19:01.999164
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-09-03 19:19:02.005624
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-09-03 19:19:02.05968
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-09-03 19:19:02.11591
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-09-03 19:19:02.119471
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-09-03 19:19:02.123234
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-09-06 04:13:31.651172
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2025-11-19 14:10:22.84814
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2025-11-19 14:10:22.896686
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2025-11-19 14:10:22.970025
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2025-11-19 14:10:22.976002
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-01-11 23:32:58.071681
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2025-09-03 19:19:00.739778
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2025-09-03 19:19:01.53682
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2025-09-03 19:19:01.59256
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2025-09-03 19:19:01.602448
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2025-09-06 04:13:31.428404
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2025-09-06 04:13:31.555109
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2025-09-06 04:13:31.568061
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2025-09-06 04:13:31.579979
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2025-09-06 04:13:31.58824
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2025-09-06 04:13:31.596452
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2025-09-06 04:13:31.606999
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2025-09-06 04:13:31.614814
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2025-09-06 04:13:31.616946
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2025-09-06 04:13:31.628441
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2025-09-06 04:13:31.635736
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2025-09-06 04:13:31.659103
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2025-10-09 21:19:26.801956
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2025-10-09 21:19:26.834101
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2025-10-09 21:19:26.849862
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2025-10-09 21:19:26.853268
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2025-10-09 21:19:26.8575
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2025-11-19 14:10:22.981307
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-02-25 02:28:11.128324
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-02-25 02:28:11.193633
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-02-25 02:28:11.195314
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-02-25 02:28:11.224771
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-02-25 02:28:11.22788
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-02-25 02:28:11.229515
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-04-12 14:38:40.77567
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-04-12 14:38:40.799309
56	fix-optimized-search-function	b823ed1e418101032fa01374edc9a436e54e3ed4	2026-02-25 02:28:11.237952
59	drop-unused-functions	38456f13e39691c2bbb4b5151d0d1cdbabd4a8c4	2026-05-08 13:38:25.812366
60	optimize-existing-functions-again	db35e1c91a9201e59f4fef8d972c2f277d68b157	2026-05-08 13:38:25.839656
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 861, true);


--
-- Name: contenido_favoritos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contenido_favoritos_id_seq', 1, false);


--
-- Name: contenido_generado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contenido_generado_id_seq', 18, true);


--
-- Name: contenido_usos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contenido_usos_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: actividad_diaria actividad_diaria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad_diaria
    ADD CONSTRAINT actividad_diaria_pkey PRIMARY KEY (id);


--
-- Name: actividad_diaria actividad_diaria_usuario_id_fecha_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad_diaria
    ADD CONSTRAINT actividad_diaria_usuario_id_fecha_key UNIQUE (usuario_id, fecha);


--
-- Name: auditoria auditoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id);


--
-- Name: biblioteca biblioteca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biblioteca
    ADD CONSTRAINT biblioteca_pkey PRIMARY KEY (id);


--
-- Name: contenido_favoritos contenido_favoritos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenido_favoritos
    ADD CONSTRAINT contenido_favoritos_pkey PRIMARY KEY (id);


--
-- Name: contenido_favoritos contenido_favoritos_user_id_contenido_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenido_favoritos
    ADD CONSTRAINT contenido_favoritos_user_id_contenido_id_key UNIQUE (user_id, contenido_id);


--
-- Name: contenido_generado contenido_generado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenido_generado
    ADD CONSTRAINT contenido_generado_pkey PRIMARY KEY (id);


--
-- Name: contenido_usos contenido_usos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenido_usos
    ADD CONSTRAINT contenido_usos_pkey PRIMARY KEY (id);


--
-- Name: cursos cursos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_pkey PRIMARY KEY (id);


--
-- Name: evaluaciones evaluaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_pkey PRIMARY KEY (id);


--
-- Name: foros foros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foros
    ADD CONSTRAINT foros_pkey PRIMARY KEY (id);


--
-- Name: grupos grupos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_nombre_key UNIQUE (nombre);


--
-- Name: grupos grupos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_pkey PRIMARY KEY (id);


--
-- Name: logros logros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logros
    ADD CONSTRAINT logros_pkey PRIMARY KEY (id);


--
-- Name: mensajes mensajes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes
    ADD CONSTRAINT mensajes_pkey PRIMARY KEY (id);


--
-- Name: mentorias mentorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentorias
    ADD CONSTRAINT mentorias_pkey PRIMARY KEY (id);


--
-- Name: niveles_aprendizaje niveles_aprendizaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles_aprendizaje
    ADD CONSTRAINT niveles_aprendizaje_pkey PRIMARY KEY (id);


--
-- Name: progreso_estudiantes progreso_estudiantes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progreso_estudiantes
    ADD CONSTRAINT progreso_estudiantes_pkey PRIMARY KEY (id);


--
-- Name: progreso_estudiantes progreso_estudiantes_usuario_id_recurso_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progreso_estudiantes
    ADD CONSTRAINT progreso_estudiantes_usuario_id_recurso_id_key UNIQUE (usuario_id, recurso_id);


--
-- Name: publicaciones_foro publicaciones_foro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones_foro
    ADD CONSTRAINT publicaciones_foro_pkey PRIMARY KEY (id);


--
-- Name: puntos_usuario puntos_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puntos_usuario
    ADD CONSTRAINT puntos_usuario_pkey PRIMARY KEY (id);


--
-- Name: puntos_usuario puntos_usuario_usuario_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puntos_usuario
    ADD CONSTRAINT puntos_usuario_usuario_id_key UNIQUE (usuario_id);


--
-- Name: recursos recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recursos
    ADD CONSTRAINT recursos_pkey PRIMARY KEY (id);


--
-- Name: resultados_evaluaciones resultados_evaluaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultados_evaluaciones
    ADD CONSTRAINT resultados_evaluaciones_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_auth_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_auth_id_key UNIQUE (auth_id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios_logros usuarios_logros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_logros
    ADD CONSTRAINT usuarios_logros_pkey PRIMARY KEY (id);


--
-- Name: usuarios_logros usuarios_logros_usuario_id_logro_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_logros
    ADD CONSTRAINT usuarios_logros_usuario_id_logro_id_key UNIQUE (usuario_id, logro_id);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usuario_key UNIQUE (usuario);


--
-- Name: messages messages_payload_exclusive; Type: CHECK CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages
    ADD CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL))) NOT VALID;


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: idx_actividad_usuario_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_actividad_usuario_fecha ON public.actividad_diaria USING btree (usuario_id, fecha);


--
-- Name: idx_auditoria_tabla; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auditoria_tabla ON public.auditoria USING btree (tabla);


--
-- Name: idx_auditoria_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auditoria_timestamp ON public.auditoria USING btree ("timestamp" DESC);


--
-- Name: idx_auditoria_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auditoria_usuario ON public.auditoria USING btree (usuario_id);


--
-- Name: idx_biblioteca_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_biblioteca_activo ON public.biblioteca USING btree (activo);


--
-- Name: idx_biblioteca_publico; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_biblioteca_publico ON public.biblioteca USING btree (publico);


--
-- Name: idx_contenido_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contenido_created_at ON public.contenido_generado USING btree (created_at);


--
-- Name: idx_contenido_created_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contenido_created_by ON public.contenido_generado USING btree (created_by);


--
-- Name: idx_contenido_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contenido_status ON public.contenido_generado USING btree (status);


--
-- Name: idx_contenido_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contenido_type ON public.contenido_generado USING btree (type);


--
-- Name: idx_cursos_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cursos_activo ON public.cursos USING btree (activo);


--
-- Name: idx_cursos_created_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cursos_created_by ON public.cursos USING btree (created_by);


--
-- Name: idx_cursos_nivel_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cursos_nivel_activo ON public.cursos USING btree (nivel_id, activo);


--
-- Name: idx_cursos_nivel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cursos_nivel_id ON public.cursos USING btree (nivel_id);


--
-- Name: idx_estadisticas_usuario_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_estadisticas_usuario_id ON public.estadisticas_usuario_optimizada USING btree (usuario_id);


--
-- Name: idx_evaluaciones_curso_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_evaluaciones_curso_id ON public.evaluaciones USING btree (curso_id);


--
-- Name: idx_favoritos_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_favoritos_user ON public.contenido_favoritos USING btree (user_id);


--
-- Name: idx_foros_curso_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_foros_curso_id ON public.foros USING btree (curso_id);


--
-- Name: idx_foros_nivel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_foros_nivel_id ON public.foros USING btree (nivel_id);


--
-- Name: idx_logros_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_logros_activo ON public.logros USING btree (activo);


--
-- Name: idx_logros_categoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_logros_categoria ON public.logros USING btree (categoria);


--
-- Name: idx_mensajes_destinatario_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mensajes_destinatario_id ON public.mensajes USING btree (destinatario_id);


--
-- Name: idx_mensajes_tipo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mensajes_tipo ON public.mensajes USING btree (tipo);


--
-- Name: idx_mensajes_usuario_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mensajes_usuario_id ON public.mensajes USING btree (usuario_id);


--
-- Name: idx_mentorias_estudiante_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mentorias_estudiante_id ON public.mentorias USING btree (estudiante_id);


--
-- Name: idx_mentorias_mentor_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mentorias_mentor_id ON public.mentorias USING btree (mentor_id);


--
-- Name: idx_niveles_orden; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_niveles_orden ON public.niveles_aprendizaje USING btree (orden);


--
-- Name: idx_progreso_completado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progreso_completado ON public.progreso_estudiantes USING btree (completado);


--
-- Name: idx_progreso_iniciado_en; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progreso_iniciado_en ON public.progreso_estudiantes USING btree (iniciado_en);


--
-- Name: idx_progreso_recurso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progreso_recurso ON public.progreso_estudiantes USING btree (recurso_id);


--
-- Name: idx_progreso_recurso_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progreso_recurso_id ON public.progreso_estudiantes USING btree (recurso_id);


--
-- Name: idx_progreso_tiempo_dedicado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progreso_tiempo_dedicado ON public.progreso_estudiantes USING btree (tiempo_dedicado) WHERE (tiempo_dedicado > 0);


--
-- Name: idx_progreso_tiempo_valido; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progreso_tiempo_valido ON public.progreso_estudiantes USING btree (tiempo_dedicado) WHERE ((tiempo_dedicado >= 10) AND (tiempo_dedicado <= 300));


--
-- Name: idx_progreso_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progreso_usuario ON public.progreso_estudiantes USING btree (usuario_id);


--
-- Name: idx_progreso_usuario_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progreso_usuario_id ON public.progreso_estudiantes USING btree (usuario_id);


--
-- Name: idx_progreso_usuario_recurso_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_progreso_usuario_recurso_unique ON public.progreso_estudiantes USING btree (usuario_id, recurso_id);


--
-- Name: idx_publicaciones_foro_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_publicaciones_foro_id ON public.publicaciones_foro USING btree (foro_id);


--
-- Name: idx_publicaciones_usuario_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_publicaciones_usuario_id ON public.publicaciones_foro USING btree (usuario_id);


--
-- Name: idx_puntos_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_puntos_usuario ON public.puntos_usuario USING btree (usuario_id);


--
-- Name: idx_puntos_usuario_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_puntos_usuario_id ON public.puntos_usuario USING btree (usuario_id);


--
-- Name: idx_recursos_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recursos_activo ON public.recursos USING btree (activo);


--
-- Name: idx_recursos_curso_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recursos_curso_id ON public.recursos USING btree (curso_id);


--
-- Name: idx_recursos_curso_tipo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recursos_curso_tipo ON public.recursos USING btree (curso_id, tipo) WHERE (activo = true);


--
-- Name: idx_recursos_orden_curso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recursos_orden_curso ON public.recursos USING btree (curso_id, orden) WHERE (activo = true);


--
-- Name: idx_recursos_tipo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recursos_tipo ON public.recursos USING btree (tipo);


--
-- Name: idx_resultados_evaluacion_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resultados_evaluacion_id ON public.resultados_evaluaciones USING btree (evaluacion_id);


--
-- Name: idx_resultados_usuario_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resultados_usuario_id ON public.resultados_evaluaciones USING btree (usuario_id);


--
-- Name: idx_usos_contenido; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usos_contenido ON public.contenido_usos USING btree (contenido_id);


--
-- Name: idx_usos_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usos_usuario ON public.contenido_usos USING btree (usuario_id);


--
-- Name: idx_usuarios_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_activo ON public.usuarios USING btree (activo);


--
-- Name: idx_usuarios_auth_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_auth_id ON public.usuarios USING btree (auth_id);


--
-- Name: idx_usuarios_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_created_at ON public.usuarios USING btree (created_at DESC);


--
-- Name: idx_usuarios_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_email ON public.usuarios USING btree (email);


--
-- Name: idx_usuarios_grupo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_grupo ON public.usuarios USING btree (grupo_id) WHERE (activo = true);


--
-- Name: idx_usuarios_grupo_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_grupo_id ON public.usuarios USING btree (grupo_id);


--
-- Name: idx_usuarios_grupos_adicionales; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_grupos_adicionales ON public.usuarios USING gin (grupos_adicionales);


--
-- Name: idx_usuarios_logros_completado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_logros_completado ON public.usuarios_logros USING btree (completado) WHERE (completado = true);


--
-- Name: idx_usuarios_logros_logro; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_logros_logro ON public.usuarios_logros USING btree (logro_id);


--
-- Name: idx_usuarios_logros_logro_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_logros_logro_id ON public.usuarios_logros USING btree (logro_id);


--
-- Name: idx_usuarios_logros_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_logros_usuario ON public.usuarios_logros USING btree (usuario_id);


--
-- Name: idx_usuarios_logros_usuario_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_logros_usuario_id ON public.usuarios_logros USING btree (usuario_id);


--
-- Name: idx_usuarios_rol; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_rol ON public.usuarios USING btree (rol);


--
-- Name: idx_usuarios_rol_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_rol_activo ON public.usuarios USING btree (rol) WHERE (activo = true);


--
-- Name: idx_usuarios_roles_adicionales; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_roles_adicionales ON public.usuarios USING gin (roles_adicionales);


--
-- Name: idx_usuarios_ultimo_acceso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_ultimo_acceso ON public.usuarios USING btree (ultimo_acceso);


--
-- Name: idx_usuarios_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_usuario ON public.usuarios USING btree (usuario);


--
-- Name: idx_usuarios_usuario_lower; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_usuario_lower ON public.usuarios USING btree (lower((usuario)::text));


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_selec; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_selec ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter, COALESCE(selected_columns, '{}'::text[]));


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: progreso_estudiantes trigger_calcular_tiempo_al_completar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_calcular_tiempo_al_completar BEFORE UPDATE ON public.progreso_estudiantes FOR EACH ROW WHEN (((old.completado = false) AND (new.completado = true))) EXECUTE FUNCTION public.calcular_tiempo_al_completar();


--
-- Name: contenido_generado trigger_contenido_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_contenido_updated_at BEFORE UPDATE ON public.contenido_generado FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- Name: progreso_estudiantes update_progreso_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_progreso_updated_at BEFORE UPDATE ON public.progreso_estudiantes FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: actividad_diaria actividad_diaria_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad_diaria
    ADD CONSTRAINT actividad_diaria_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: auditoria auditoria_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria
    ADD CONSTRAINT auditoria_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE SET NULL;


--
-- Name: biblioteca biblioteca_subido_por_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biblioteca
    ADD CONSTRAINT biblioteca_subido_por_fkey FOREIGN KEY (subido_por) REFERENCES public.usuarios(id) ON DELETE SET NULL;


--
-- Name: contenido_favoritos contenido_favoritos_contenido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenido_favoritos
    ADD CONSTRAINT contenido_favoritos_contenido_id_fkey FOREIGN KEY (contenido_id) REFERENCES public.contenido_generado(id) ON DELETE CASCADE;


--
-- Name: contenido_favoritos contenido_favoritos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenido_favoritos
    ADD CONSTRAINT contenido_favoritos_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: contenido_generado contenido_generado_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenido_generado
    ADD CONSTRAINT contenido_generado_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: contenido_usos contenido_usos_contenido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenido_usos
    ADD CONSTRAINT contenido_usos_contenido_id_fkey FOREIGN KEY (contenido_id) REFERENCES public.contenido_generado(id) ON DELETE CASCADE;


--
-- Name: contenido_usos contenido_usos_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenido_usos
    ADD CONSTRAINT contenido_usos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: cursos cursos_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.usuarios(id) ON DELETE SET NULL;


--
-- Name: cursos cursos_nivel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_nivel_id_fkey FOREIGN KEY (nivel_id) REFERENCES public.niveles_aprendizaje(id) ON DELETE CASCADE;


--
-- Name: evaluaciones evaluaciones_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.usuarios(id) ON DELETE SET NULL;


--
-- Name: evaluaciones evaluaciones_curso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_curso_id_fkey FOREIGN KEY (curso_id) REFERENCES public.cursos(id) ON DELETE CASCADE;


--
-- Name: usuarios fk_usuarios_grupo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuarios_grupo FOREIGN KEY (grupo_id) REFERENCES public.grupos(id) ON DELETE SET NULL;


--
-- Name: foros foros_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foros
    ADD CONSTRAINT foros_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.usuarios(id) ON DELETE SET NULL;


--
-- Name: foros foros_curso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foros
    ADD CONSTRAINT foros_curso_id_fkey FOREIGN KEY (curso_id) REFERENCES public.cursos(id) ON DELETE CASCADE;


--
-- Name: foros foros_nivel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foros
    ADD CONSTRAINT foros_nivel_id_fkey FOREIGN KEY (nivel_id) REFERENCES public.niveles_aprendizaje(id) ON DELETE CASCADE;


--
-- Name: mensajes mensajes_curso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes
    ADD CONSTRAINT mensajes_curso_id_fkey FOREIGN KEY (curso_id) REFERENCES public.cursos(id) ON DELETE CASCADE;


--
-- Name: mensajes mensajes_destinatario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes
    ADD CONSTRAINT mensajes_destinatario_id_fkey FOREIGN KEY (destinatario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: mensajes mensajes_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes
    ADD CONSTRAINT mensajes_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: mentorias mentorias_curso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentorias
    ADD CONSTRAINT mentorias_curso_id_fkey FOREIGN KEY (curso_id) REFERENCES public.cursos(id) ON DELETE SET NULL;


--
-- Name: mentorias mentorias_estudiante_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentorias
    ADD CONSTRAINT mentorias_estudiante_id_fkey FOREIGN KEY (estudiante_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: mentorias mentorias_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentorias
    ADD CONSTRAINT mentorias_mentor_id_fkey FOREIGN KEY (mentor_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: progreso_estudiantes progreso_estudiantes_recurso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progreso_estudiantes
    ADD CONSTRAINT progreso_estudiantes_recurso_id_fkey FOREIGN KEY (recurso_id) REFERENCES public.recursos(id) ON DELETE CASCADE;


--
-- Name: progreso_estudiantes progreso_estudiantes_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progreso_estudiantes
    ADD CONSTRAINT progreso_estudiantes_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: publicaciones_foro publicaciones_foro_foro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones_foro
    ADD CONSTRAINT publicaciones_foro_foro_id_fkey FOREIGN KEY (foro_id) REFERENCES public.foros(id) ON DELETE CASCADE;


--
-- Name: publicaciones_foro publicaciones_foro_padre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones_foro
    ADD CONSTRAINT publicaciones_foro_padre_id_fkey FOREIGN KEY (padre_id) REFERENCES public.publicaciones_foro(id) ON DELETE CASCADE;


--
-- Name: publicaciones_foro publicaciones_foro_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones_foro
    ADD CONSTRAINT publicaciones_foro_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: puntos_usuario puntos_usuario_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puntos_usuario
    ADD CONSTRAINT puntos_usuario_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: recursos recursos_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recursos
    ADD CONSTRAINT recursos_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.usuarios(id) ON DELETE SET NULL;


--
-- Name: recursos recursos_curso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recursos
    ADD CONSTRAINT recursos_curso_id_fkey FOREIGN KEY (curso_id) REFERENCES public.cursos(id) ON DELETE CASCADE;


--
-- Name: resultados_evaluaciones resultados_evaluaciones_evaluacion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultados_evaluaciones
    ADD CONSTRAINT resultados_evaluaciones_evaluacion_id_fkey FOREIGN KEY (evaluacion_id) REFERENCES public.evaluaciones(id) ON DELETE CASCADE;


--
-- Name: resultados_evaluaciones resultados_evaluaciones_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultados_evaluaciones
    ADD CONSTRAINT resultados_evaluaciones_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: usuarios usuarios_auth_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_auth_id_fkey FOREIGN KEY (auth_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: usuarios_logros usuarios_logros_logro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_logros
    ADD CONSTRAINT usuarios_logros_logro_id_fkey FOREIGN KEY (logro_id) REFERENCES public.logros(id) ON DELETE CASCADE;


--
-- Name: usuarios_logros usuarios_logros_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_logros
    ADD CONSTRAINT usuarios_logros_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: contenido_favoritos Users can delete their favorites; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their favorites" ON public.contenido_favoritos FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: contenido_generado Users can delete their own content; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own content" ON public.contenido_generado FOR DELETE USING ((auth.uid() = created_by));


--
-- Name: contenido_generado Users can insert their own content; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own content" ON public.contenido_generado FOR INSERT WITH CHECK ((auth.uid() = created_by));


--
-- Name: contenido_favoritos Users can manage their favorites; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can manage their favorites" ON public.contenido_favoritos FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: contenido_generado Users can update their own content; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own content" ON public.contenido_generado FOR UPDATE USING ((auth.uid() = created_by)) WITH CHECK ((auth.uid() = created_by));


--
-- Name: contenido_favoritos Users can view their favorites; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their favorites" ON public.contenido_favoritos FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: contenido_generado Users can view their own content; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own content" ON public.contenido_generado FOR SELECT USING ((auth.uid() = created_by));


--
-- Name: contenido_favoritos; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.contenido_favoritos ENABLE ROW LEVEL SECURITY;

--
-- Name: contenido_generado; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.contenido_generado ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION actualizar_ultimo_acceso_mejorado(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.actualizar_ultimo_acceso_mejorado() TO authenticated;


--
-- Name: FUNCTION actualizar_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.actualizar_updated_at() TO authenticated;


--
-- Name: FUNCTION calcular_siguiente_nivel(puntos_actuales integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.calcular_siguiente_nivel(puntos_actuales integer) TO authenticated;


--
-- Name: FUNCTION calcular_tiempo_al_completar(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.calcular_tiempo_al_completar() TO authenticated;


--
-- Name: FUNCTION calcular_tiempo_dedicado_real(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.calcular_tiempo_dedicado_real() TO authenticated;


--
-- Name: FUNCTION clasificar_estudiante(p_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.clasificar_estudiante(p_id uuid) TO authenticated;


--
-- Name: FUNCTION get_estado_usuario(p_usuario_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_estado_usuario(p_usuario_id uuid) TO authenticated;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;


--
-- Name: FUNCTION obtener_todos_grupos(user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.obtener_todos_grupos(user_id uuid) TO authenticated;


--
-- Name: FUNCTION obtener_todos_roles(user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.obtener_todos_roles(user_id uuid) TO authenticated;


--
-- Name: FUNCTION puntos_faltantes_proximo_nivel(puntos_actuales integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.puntos_faltantes_proximo_nivel(puntos_actuales integer) TO authenticated;


--
-- Name: FUNCTION puntos_para_siguiente_nivel(nivel_actual integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.puntos_para_siguiente_nivel(nivel_actual integer) TO authenticated;


--
-- Name: FUNCTION registrar_acceso_automatico(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.registrar_acceso_automatico() TO authenticated;


--
-- Name: FUNCTION registrar_inicio_actividad(p_usuario_id uuid, p_recurso_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.registrar_inicio_actividad(p_usuario_id uuid, p_recurso_id uuid) TO authenticated;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;


--
-- Name: FUNCTION usuario_en_grupo(user_id uuid, target_grupo_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.usuario_en_grupo(user_id uuid, target_grupo_id uuid) TO authenticated;


--
-- Name: FUNCTION usuario_tiene_rol(user_id uuid, target_rol text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.usuario_tiene_rol(user_id uuid, target_rol text) TO authenticated;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION send_binary(payload bytea, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION wal2json_escape_identifier(name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO postgres;
GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE actividad_diaria; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.actividad_diaria TO authenticated;


--
-- Name: TABLE auditoria; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auditoria TO authenticated;


--
-- Name: TABLE biblioteca; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.biblioteca TO authenticated;


--
-- Name: TABLE contenido_favoritos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.contenido_favoritos TO authenticated;


--
-- Name: SEQUENCE contenido_favoritos_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.contenido_favoritos_id_seq TO authenticated;


--
-- Name: TABLE contenido_generado; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.contenido_generado TO authenticated;


--
-- Name: SEQUENCE contenido_generado_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.contenido_generado_id_seq TO authenticated;


--
-- Name: TABLE contenido_usos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.contenido_usos TO authenticated;


--
-- Name: SEQUENCE contenido_usos_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.contenido_usos_id_seq TO authenticated;


--
-- Name: TABLE cursos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cursos TO authenticated;


--
-- Name: TABLE progreso_estudiantes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.progreso_estudiantes TO authenticated;


--
-- Name: TABLE puntos_usuario; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.puntos_usuario TO authenticated;


--
-- Name: TABLE recursos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.recursos TO authenticated;


--
-- Name: TABLE usuarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.usuarios TO authenticated;
GRANT SELECT,INSERT ON TABLE public.usuarios TO anon;


--
-- Name: TABLE usuarios_logros; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.usuarios_logros TO authenticated;


--
-- Name: TABLE estadisticas_usuario_optimizada; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.estadisticas_usuario_optimizada TO authenticated;


--
-- Name: TABLE evaluaciones; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.evaluaciones TO authenticated;


--
-- Name: TABLE foros; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.foros TO authenticated;


--
-- Name: TABLE grupos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.grupos TO authenticated;
GRANT ALL ON TABLE public.grupos TO anon;


--
-- Name: TABLE logros; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.logros TO authenticated;


--
-- Name: TABLE mensajes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mensajes TO authenticated;


--
-- Name: TABLE mentorias; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mentorias TO authenticated;


--
-- Name: TABLE niveles_aprendizaje; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.niveles_aprendizaje TO authenticated;


--
-- Name: TABLE publicaciones_foro; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.publicaciones_foro TO authenticated;


--
-- Name: TABLE ranking_estudiantes_v2; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ranking_estudiantes_v2 TO authenticated;


--
-- Name: TABLE resultados_evaluaciones; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.resultados_evaluaciones TO authenticated;


--
-- Name: TABLE vista_usuarios_completa; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vista_usuarios_completa TO authenticated;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- Name: estadisticas_usuario_optimizada; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: postgres
--

REFRESH MATERIALIZED VIEW public.estadisticas_usuario_optimizada;


--
-- PostgreSQL database dump complete
--

\unrestrict 27zUlcgBkbfPQKJQ53sw5JBdkfTEPLALo6hTWBgemF3JqxpLLiFHBgaPQmAWaj8

