-- OpenReplay PostgreSQL Schema
-- Exported from working v1.23.0 instance (includes all fixes)
-- Replaces upstream init_schema.sql which had missing columns/schemas

\set ON_ERROR_STOP true
SELECT EXISTS (SELECT 1
               FROM information_schema.tables
               WHERE table_schema = 'public'
                 AND table_name = 'tenants') AS db_exists;
\gset
\if :db_exists
\echo >DB already exists, stopping script
\q
\endif

--
-- PostgreSQL database dump
--


-- Dumped from database version 17.9
-- Dumped by pg_dump version 17.9

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
-- Name: events; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA events;


--
-- Name: events_common; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA events_common;


--
-- Name: events_ios; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA events_ios;


--
-- Name: spots; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA spots;


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: custom_level; Type: TYPE; Schema: events_common; Owner: -
--

CREATE TYPE events_common.custom_level AS ENUM (
    'info',
    'error'
);


--
-- Name: alert_change_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.alert_change_type AS ENUM (
    'percent',
    'change'
);


--
-- Name: alert_detection_method; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.alert_detection_method AS ENUM (
    'threshold',
    'change'
);


--
-- Name: announcement_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.announcement_type AS ENUM (
    'notification',
    'alert'
);


--
-- Name: country; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.country AS ENUM (
    'UN',
    'RW',
    'SO',
    'YE',
    'IQ',
    'SA',
    'IR',
    'CY',
    'TZ',
    'SY',
    'AM',
    'KE',
    'CD',
    'DJ',
    'UG',
    'CF',
    'SC',
    'JO',
    'LB',
    'KW',
    'OM',
    'QA',
    'BH',
    'AE',
    'IL',
    'TR',
    'ET',
    'ER',
    'EG',
    'SD',
    'GR',
    'BI',
    'EE',
    'LV',
    'AZ',
    'LT',
    'SJ',
    'GE',
    'MD',
    'BY',
    'FI',
    'AX',
    'UA',
    'MK',
    'HU',
    'BG',
    'AL',
    'PL',
    'RO',
    'XK',
    'ZW',
    'ZM',
    'KM',
    'MW',
    'LS',
    'BW',
    'MU',
    'SZ',
    'RE',
    'ZA',
    'YT',
    'MZ',
    'MG',
    'AF',
    'PK',
    'BD',
    'TM',
    'TJ',
    'LK',
    'BT',
    'IN',
    'MV',
    'IO',
    'NP',
    'MM',
    'UZ',
    'KZ',
    'KG',
    'TF',
    'HM',
    'CC',
    'PW',
    'VN',
    'TH',
    'ID',
    'LA',
    'TW',
    'PH',
    'MY',
    'CN',
    'HK',
    'BN',
    'MO',
    'KH',
    'KR',
    'JP',
    'KP',
    'SG',
    'CK',
    'TL',
    'RU',
    'MN',
    'AU',
    'CX',
    'MH',
    'FM',
    'PG',
    'SB',
    'TV',
    'NR',
    'VU',
    'NC',
    'NF',
    'NZ',
    'FJ',
    'LY',
    'CM',
    'SN',
    'CG',
    'PT',
    'LR',
    'CI',
    'GH',
    'GQ',
    'NG',
    'BF',
    'TG',
    'GW',
    'MR',
    'BJ',
    'GA',
    'SL',
    'ST',
    'GI',
    'GM',
    'GN',
    'TD',
    'NE',
    'ML',
    'EH',
    'TN',
    'ES',
    'MA',
    'MT',
    'DZ',
    'FO',
    'DK',
    'IS',
    'GB',
    'CH',
    'SE',
    'NL',
    'AT',
    'BE',
    'DE',
    'LU',
    'IE',
    'MC',
    'FR',
    'AD',
    'LI',
    'JE',
    'IM',
    'GG',
    'SK',
    'CZ',
    'NO',
    'VA',
    'SM',
    'IT',
    'SI',
    'ME',
    'HR',
    'BA',
    'AO',
    'NA',
    'SH',
    'BV',
    'BB',
    'CV',
    'GY',
    'GF',
    'SR',
    'PM',
    'GL',
    'PY',
    'UY',
    'BR',
    'FK',
    'GS',
    'JM',
    'DO',
    'CU',
    'MQ',
    'BS',
    'BM',
    'AI',
    'TT',
    'KN',
    'DM',
    'AG',
    'LC',
    'TC',
    'AW',
    'VG',
    'VC',
    'MS',
    'MF',
    'BL',
    'GP',
    'GD',
    'KY',
    'BZ',
    'SV',
    'GT',
    'HN',
    'NI',
    'CR',
    'VE',
    'EC',
    'CO',
    'PA',
    'HT',
    'AR',
    'CL',
    'BO',
    'PE',
    'MX',
    'PF',
    'PN',
    'KI',
    'TK',
    'TO',
    'WF',
    'WS',
    'NU',
    'MP',
    'GU',
    'PR',
    'VI',
    'UM',
    'AS',
    'CA',
    'US',
    'PS',
    'RS',
    'AQ',
    'SX',
    'CW',
    'BQ',
    'SS',
    'AC',
    'AN',
    'BU',
    'CP',
    'CS',
    'CT',
    'DD',
    'DG',
    'DY',
    'EA',
    'FQ',
    'FX',
    'HV',
    'IC',
    'JT',
    'MI',
    'NH',
    'NQ',
    'NT',
    'PC',
    'PU',
    'PZ',
    'RH',
    'SU',
    'TA',
    'TP',
    'VD',
    'WK',
    'YD',
    'YU',
    'ZR'
);


--
-- Name: device_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.device_type AS ENUM (
    'desktop',
    'tablet',
    'mobile',
    'other'
);


--
-- Name: error_source; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.error_source AS ENUM (
    'js_exception',
    'bugsnag',
    'cloudwatch',
    'datadog',
    'newrelic',
    'rollbar',
    'sentry',
    'stackdriver',
    'sumologic',
    'elasticsearch'
);


--
-- Name: error_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.error_status AS ENUM (
    'unresolved',
    'resolved',
    'ignored'
);


--
-- Name: http_method; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.http_method AS ENUM (
    'GET',
    'HEAD',
    'POST',
    'PUT',
    'DELETE',
    'CONNECT',
    'OPTIONS',
    'TRACE',
    'PATCH'
);


--
-- Name: integration_provider; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.integration_provider AS ENUM (
    'bugsnag',
    'cloudwatch',
    'datadog',
    'newrelic',
    'rollbar',
    'sentry',
    'stackdriver',
    'sumologic',
    'elasticsearch',
    'dynatrace'
);


--
-- Name: issue_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.issue_type AS ENUM (
    'click_rage',
    'tap_rage',
    'dead_click',
    'excessive_scrolling',
    'bad_request',
    'missing_resource',
    'memory',
    'cpu',
    'slow_resource',
    'slow_page_load',
    'crash',
    'ml_cpu',
    'ml_memory',
    'ml_dead_click',
    'ml_click_rage',
    'ml_mouse_thrashing',
    'ml_excessive_scrolling',
    'ml_slow_resources',
    'custom',
    'js_exception',
    'mouse_thrashing',
    'app_crash',
    'incident'
);


--
-- Name: job_action; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.job_action AS ENUM (
    'delete_user_data'
);


--
-- Name: job_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.job_status AS ENUM (
    'scheduled',
    'running',
    'cancelled',
    'failed',
    'completed'
);


--
-- Name: oauth_provider; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.oauth_provider AS ENUM (
    'jira',
    'github'
);


--
-- Name: platform; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.platform AS ENUM (
    'web',
    'ios',
    'android'
);


--
-- Name: ui_tests_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ui_tests_status AS ENUM (
    'preview',
    'in-progress',
    'paused',
    'closed'
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'owner',
    'admin',
    'member'
);


--
-- Name: ut_signal_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ut_signal_status AS ENUM (
    'begin',
    'done',
    'skipped'
);


--
-- Name: webhook_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.webhook_type AS ENUM (
    'webhook',
    'slack',
    'email',
    'msteams'
);


--
-- Name: generate_api_key(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_api_key(length integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    chars  text[]  := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
    result text    := '';
    i      integer := 0;
begin
    if length < 0 then
        raise exception 'Given length cannot be less than 0';
    end if;
    for i in 1..length
        loop
            result := result || chars[1 + random() * (array_length(chars, 1) - 1)];
        end loop;
    return result;
end;
$$;


--
-- Name: notify_alert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.notify_alert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    clone jsonb;
BEGIN
    clone = to_jsonb(NEW);
    clone = jsonb_set(clone, '{created_at}', to_jsonb(CAST(EXTRACT(epoch FROM NEW.created_at) * 1000 AS BIGINT)));
    IF NEW.deleted_at NOTNULL THEN
        clone = jsonb_set(clone, '{deleted_at}', to_jsonb(CAST(EXTRACT(epoch FROM NEW.deleted_at) * 1000 AS BIGINT)));
    END IF;
    PERFORM pg_notify('alert', clone::text);
    RETURN NEW;
END ;
$$;


--
-- Name: notify_integration(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.notify_integration() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW IS NULL THEN
        PERFORM pg_notify('integration',
                          jsonb_build_object('project_id', OLD.project_id, 'provider', OLD.provider, 'options',
                                             null)::text);
    ELSIF (OLD IS NULL) OR (OLD.options <> NEW.options) THEN
        PERFORM pg_notify('integration', row_to_json(NEW)::text);
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: notify_project(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.notify_project() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM pg_notify('project', row_to_json(NEW)::text);
    RETURN NEW;
END;
$$;


--
-- Name: openreplay_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.openreplay_version() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT 'v1.25.0'
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: canvas_recordings; Type: TABLE; Schema: events; Owner: -
--

CREATE TABLE events.canvas_recordings (
    session_id bigint NOT NULL,
    recording_id text NOT NULL,
    "timestamp" bigint NOT NULL
);


--
-- Name: clicks; Type: TABLE; Schema: events; Owner: -
--

CREATE TABLE events.clicks (
    session_id bigint NOT NULL,
    message_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    label text,
    url text DEFAULT ''::text NOT NULL,
    path text,
    selector text DEFAULT ''::text NOT NULL,
    hesitation integer,
    normalized_x numeric,
    normalized_y numeric
);


--
-- Name: errors; Type: TABLE; Schema: events; Owner: -
--

CREATE TABLE events.errors (
    session_id bigint NOT NULL,
    message_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    error_id text NOT NULL
);


--
-- Name: graphql; Type: TABLE; Schema: events; Owner: -
--

CREATE TABLE events.graphql (
    session_id bigint NOT NULL,
    message_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    name text NOT NULL,
    request_body text,
    response_body text,
    method public.http_method
);


--
-- Name: inputs; Type: TABLE; Schema: events; Owner: -
--

CREATE TABLE events.inputs (
    session_id bigint NOT NULL,
    message_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    label text,
    value text,
    duration integer,
    hesitation integer
);


--
-- Name: pages; Type: TABLE; Schema: events; Owner: -
--

CREATE TABLE events.pages (
    session_id bigint NOT NULL,
    message_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    host text NOT NULL,
    path text NOT NULL,
    query text,
    referrer text,
    base_referrer text,
    dom_building_time integer,
    dom_content_loaded_time integer,
    load_time integer,
    first_paint_time integer,
    first_contentful_paint_time integer,
    speed_index integer,
    visually_complete integer,
    time_to_interactive integer,
    response_time bigint,
    response_end bigint,
    ttfb integer,
    web_vitals text
);


--
-- Name: performance; Type: TABLE; Schema: events; Owner: -
--

CREATE TABLE events.performance (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    message_id bigint NOT NULL,
    host text,
    path text,
    query text,
    min_fps smallint NOT NULL,
    avg_fps smallint NOT NULL,
    max_fps smallint NOT NULL,
    min_cpu smallint NOT NULL,
    avg_cpu smallint NOT NULL,
    max_cpu smallint NOT NULL,
    min_total_js_heap_size bigint NOT NULL,
    avg_total_js_heap_size bigint NOT NULL,
    max_total_js_heap_size bigint NOT NULL,
    min_used_js_heap_size bigint NOT NULL,
    avg_used_js_heap_size bigint NOT NULL,
    max_used_js_heap_size bigint NOT NULL
);


--
-- Name: state_actions; Type: TABLE; Schema: events; Owner: -
--

CREATE TABLE events.state_actions (
    session_id bigint NOT NULL,
    message_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    name text NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: events; Owner: -
--

CREATE TABLE events.tags (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    seq_index integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: crashes; Type: TABLE; Schema: events_common; Owner: -
--

CREATE TABLE events_common.crashes (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    seq_index integer NOT NULL,
    crash_ios_id text
);


--
-- Name: customs; Type: TABLE; Schema: events_common; Owner: -
--

CREATE TABLE events_common.customs (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    seq_index integer NOT NULL,
    name text NOT NULL,
    payload jsonb NOT NULL,
    level events_common.custom_level DEFAULT 'info'::events_common.custom_level NOT NULL
);


--
-- Name: issues; Type: TABLE; Schema: events_common; Owner: -
--

CREATE TABLE events_common.issues (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    seq_index integer NOT NULL,
    issue_id text NOT NULL,
    payload jsonb
);


--
-- Name: requests; Type: TABLE; Schema: events_common; Owner: -
--

CREATE TABLE events_common.requests (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    seq_index integer NOT NULL,
    url text NOT NULL,
    duration integer NOT NULL,
    success boolean NOT NULL,
    request_body text,
    response_body text,
    status_code smallint,
    method public.http_method,
    host text,
    path text,
    query text,
    transfer_size bigint
);


--
-- Name: inputs; Type: TABLE; Schema: events_ios; Owner: -
--

CREATE TABLE events_ios.inputs (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    seq_index integer NOT NULL,
    label text NOT NULL
);


--
-- Name: swipes; Type: TABLE; Schema: events_ios; Owner: -
--

CREATE TABLE events_ios.swipes (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    seq_index integer NOT NULL,
    label text NOT NULL,
    direction text NOT NULL,
    x integer,
    y integer
);


--
-- Name: taps; Type: TABLE; Schema: events_ios; Owner: -
--

CREATE TABLE events_ios.taps (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    seq_index integer NOT NULL,
    label text NOT NULL
);


--
-- Name: views; Type: TABLE; Schema: events_ios; Owner: -
--

CREATE TABLE events_ios.views (
    session_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    seq_index integer NOT NULL,
    name text NOT NULL
);


--
-- Name: actions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actions (
    action_id uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id integer NOT NULL,
    user_id integer,
    name character varying(255) NOT NULL,
    description character varying(1024) DEFAULT NULL::character varying,
    filters jsonb DEFAULT '[]'::jsonb NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: alerts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alerts (
    alert_id integer NOT NULL,
    project_id integer NOT NULL,
    series_id integer,
    name text NOT NULL,
    description text,
    active boolean DEFAULT true NOT NULL,
    detection_method public.alert_detection_method NOT NULL,
    change public.alert_change_type DEFAULT 'change'::public.alert_change_type NOT NULL,
    query jsonb NOT NULL,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    options jsonb DEFAULT '{"renotifyInterval": 1440}'::jsonb NOT NULL
);


--
-- Name: alerts_alert_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.alerts ALTER COLUMN alert_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.alerts_alert_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcements (
    announcement_id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    button_text character varying(30),
    button_url text,
    image_url text,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    type public.announcement_type DEFAULT 'notification'::public.announcement_type NOT NULL
);


--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.announcements_announcement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.announcements_announcement_id_seq OWNED BY public.announcements.announcement_id;


--
-- Name: assigned_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.assigned_sessions (
    session_id bigint NOT NULL,
    issue_id text NOT NULL,
    provider public.oauth_provider NOT NULL,
    created_by integer NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    provider_data jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: autocomplete; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.autocomplete (
    value text NOT NULL,
    type text NOT NULL,
    project_id integer NOT NULL
);


--
-- Name: basic_authentication; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.basic_authentication (
    user_id integer NOT NULL,
    password text,
    invitation_token text,
    invited_at timestamp without time zone,
    change_pwd_token text,
    change_pwd_expire_at timestamp without time zone,
    changed_at timestamp without time zone
);


--
-- Name: crashes_ios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.crashes_ios (
    crash_ios_id text NOT NULL,
    project_id integer NOT NULL,
    name text NOT NULL,
    reason text NOT NULL,
    stacktrace text NOT NULL
);


--
-- Name: dashboard_widgets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dashboard_widgets (
    widget_id integer NOT NULL,
    dashboard_id integer NOT NULL,
    metric_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    config jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: dashboard_widgets_widget_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.dashboard_widgets ALTER COLUMN widget_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.dashboard_widgets_widget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: dashboards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dashboards (
    dashboard_id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer,
    name text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    is_public boolean DEFAULT true NOT NULL,
    is_pinned boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: dashboards_dashboard_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.dashboards ALTER COLUMN dashboard_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.dashboards_dashboard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: errors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.errors (
    error_id text NOT NULL,
    project_id integer NOT NULL,
    source public.error_source NOT NULL,
    name text,
    message text NOT NULL,
    payload jsonb NOT NULL,
    status public.error_status DEFAULT 'unresolved'::public.error_status NOT NULL,
    parent_error_id text,
    stacktrace jsonb,
    stacktrace_parsed_at timestamp without time zone
);


--
-- Name: errors_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.errors_tags (
    key text NOT NULL,
    value text NOT NULL,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    error_id text NOT NULL,
    session_id bigint NOT NULL,
    message_id bigint NOT NULL
);


--
-- Name: feature_flags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feature_flags (
    feature_flag_id integer NOT NULL,
    project_id integer NOT NULL,
    flag_key text NOT NULL,
    description text,
    payload jsonb,
    flag_type text NOT NULL,
    is_persist boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    created_by integer,
    updated_by integer,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: feature_flags_conditions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feature_flags_conditions (
    condition_id integer NOT NULL,
    feature_flag_id integer NOT NULL,
    name text NOT NULL,
    rollout_percentage integer NOT NULL,
    filters jsonb DEFAULT '[]'::jsonb NOT NULL
);


--
-- Name: feature_flags_conditions_condition_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.feature_flags_conditions ALTER COLUMN condition_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.feature_flags_conditions_condition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: feature_flags_feature_flag_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.feature_flags ALTER COLUMN feature_flag_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.feature_flags_feature_flag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: feature_flags_variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feature_flags_variants (
    variant_id integer NOT NULL,
    feature_flag_id integer NOT NULL,
    value text NOT NULL,
    description text,
    payload jsonb,
    rollout_percentage integer DEFAULT 0
);


--
-- Name: feature_flags_variants_variant_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.feature_flags_variants ALTER COLUMN variant_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.feature_flags_variants_variant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: integrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.integrations (
    project_id integer NOT NULL,
    provider public.integration_provider NOT NULL,
    options jsonb NOT NULL,
    request_data jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: issues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issues (
    issue_id text NOT NULL,
    project_id integer NOT NULL,
    type public.issue_type NOT NULL,
    context_string text NOT NULL,
    context jsonb
);


--
-- Name: jira_cloud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jira_cloud (
    user_id integer NOT NULL,
    username text NOT NULL,
    token text NOT NULL,
    url text
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    job_id integer NOT NULL,
    description text NOT NULL,
    status public.job_status NOT NULL,
    project_id integer NOT NULL,
    action public.job_action NOT NULL,
    reference_id text NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone DEFAULT timezone('utc'::text, now()),
    start_at timestamp without time zone NOT NULL,
    errors text
);


--
-- Name: jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.jobs ALTER COLUMN job_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.jobs_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: metric_series; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metric_series (
    series_id integer NOT NULL,
    metric_id integer,
    index integer NOT NULL,
    name text,
    filter jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: metric_series_series_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.metric_series ALTER COLUMN series_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.metric_series_series_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: metrics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metrics (
    metric_id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer,
    name text NOT NULL,
    is_public boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    deleted_at timestamp without time zone,
    edited_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    metric_type text DEFAULT 'timeseries'::text NOT NULL,
    view_type text DEFAULT 'lineChart'::text NOT NULL,
    metric_of text DEFAULT 'sessionCount'::text NOT NULL,
    metric_value text[] DEFAULT '{}'::text[] NOT NULL,
    metric_format text DEFAULT 'sessionCount'::text NOT NULL,
    thumbnail text,
    is_pinned boolean DEFAULT false NOT NULL,
    default_config jsonb DEFAULT '{"col": 2, "row": 2, "position": 0}'::jsonb NOT NULL,
    data jsonb,
    card_info jsonb
);


--
-- Name: metrics_metric_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.metrics ALTER COLUMN metric_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.metrics_metric_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    user_id integer,
    title text NOT NULL,
    description text NOT NULL,
    button_text character varying(80),
    button_url text,
    image_url text,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    options jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.notifications ALTER COLUMN notification_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.notifications_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: oauth_authentication; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_authentication (
    user_id integer NOT NULL,
    provider public.oauth_provider NOT NULL,
    provider_user_id text NOT NULL,
    token text NOT NULL
);


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    project_id integer NOT NULL,
    project_key character varying(20) DEFAULT public.generate_api_key(20) NOT NULL,
    name text NOT NULL,
    platform public.platform DEFAULT 'web'::public.platform NOT NULL,
    active boolean NOT NULL,
    sample_rate smallint DEFAULT 100 NOT NULL,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    deleted_at timestamp without time zone,
    max_session_duration integer DEFAULT 7200000 NOT NULL,
    metadata_1 text,
    metadata_2 text,
    metadata_3 text,
    metadata_4 text,
    metadata_5 text,
    metadata_6 text,
    metadata_7 text,
    metadata_8 text,
    metadata_9 text,
    metadata_10 text,
    save_request_payloads boolean DEFAULT false NOT NULL,
    gdpr jsonb DEFAULT '{"maskEmails": true, "sampleRate": 33, "maskNumbers": false, "defaultInputMode": "obscured"}'::jsonb NOT NULL,
    first_recorded_session_at timestamp without time zone,
    sessions_last_check_at timestamp without time zone,
    beacon_size integer DEFAULT 0 NOT NULL,
    conditional_capture boolean DEFAULT false NOT NULL,
    CONSTRAINT projects_sample_rate_check CHECK (((sample_rate >= 0) AND (sample_rate <= 100)))
);


--
-- Name: projects_conditions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects_conditions (
    condition_id integer NOT NULL,
    project_id integer NOT NULL,
    name character varying(255) NOT NULL,
    capture_rate integer NOT NULL,
    filters jsonb DEFAULT '[]'::jsonb NOT NULL,
    CONSTRAINT projects_conditions_capture_rate_check CHECK (((capture_rate >= 0) AND (capture_rate <= 100)))
);


--
-- Name: projects_conditions_condition_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.projects_conditions ALTER COLUMN condition_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.projects_conditions_condition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: projects_project_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.projects ALTER COLUMN project_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.projects_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: projects_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects_stats (
    project_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    sessions_count integer DEFAULT 0 NOT NULL,
    events_count bigint DEFAULT 0 NOT NULL,
    last_update_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text)
);


--
-- Name: saved_searches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.saved_searches (
    search_id uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    is_public boolean DEFAULT false NOT NULL,
    is_share boolean DEFAULT false NOT NULL,
    search_data jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    expires_at timestamp without time zone,
    deleted_at timestamp without time zone
);


--
-- Name: searches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.searches (
    search_id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    name text NOT NULL,
    filter jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    deleted_at timestamp without time zone,
    is_public boolean DEFAULT false NOT NULL
);


--
-- Name: searches_search_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.searches ALTER COLUMN search_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.searches_search_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: session_integrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session_integrations (
    session_id bigint NOT NULL,
    project_id integer NOT NULL,
    provider text NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    session_id bigint NOT NULL,
    project_id integer NOT NULL,
    tracker_version text NOT NULL,
    start_ts bigint NOT NULL,
    timezone text,
    duration integer,
    rev_id text,
    platform public.platform DEFAULT 'web'::public.platform NOT NULL,
    is_snippet boolean DEFAULT false NOT NULL,
    user_id text,
    user_anonymous_id text,
    user_uuid uuid NOT NULL,
    user_os text NOT NULL,
    user_os_version text,
    user_browser text,
    user_browser_version text,
    user_device text NOT NULL,
    user_device_type public.device_type NOT NULL,
    user_device_memory_size integer,
    user_device_heap_size bigint,
    user_country public.country NOT NULL,
    user_city text,
    user_state text,
    pages_count integer DEFAULT 0 NOT NULL,
    events_count integer DEFAULT 0 NOT NULL,
    errors_count integer DEFAULT 0 NOT NULL,
    watchdogs_score bigint DEFAULT 0 NOT NULL,
    issue_types public.issue_type[] DEFAULT '{}'::public.issue_type[] NOT NULL,
    utm_source text,
    utm_medium text,
    utm_campaign text,
    referrer text,
    base_referrer text,
    has_ut_test boolean DEFAULT false,
    screen_width integer,
    screen_height integer,
    metadata_1 text,
    metadata_2 text,
    metadata_3 text,
    metadata_4 text,
    metadata_5 text,
    metadata_6 text,
    metadata_7 text,
    metadata_8 text,
    metadata_9 text,
    metadata_10 text,
    CONSTRAINT web_browser_constraint CHECK ((((platform = 'web'::public.platform) AND (user_browser IS NOT NULL)) OR ((platform <> 'web'::public.platform) AND (user_browser IS NULL)))),
    CONSTRAINT web_user_browser_version_constraint CHECK (((platform = 'web'::public.platform) OR (user_browser_version IS NULL)))
);


--
-- Name: sessions_feature_flags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions_feature_flags (
    session_id bigint NOT NULL,
    feature_flag_id integer NOT NULL,
    condition_id integer
);


--
-- Name: sessions_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions_notes (
    note_id integer NOT NULL,
    message text,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    user_id integer,
    deleted_at timestamp without time zone,
    tag text,
    session_id bigint NOT NULL,
    project_id integer NOT NULL,
    "timestamp" integer DEFAULT '-1'::integer NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    thumbnail text,
    updated_at timestamp without time zone,
    start_at integer,
    end_at integer
);


--
-- Name: sessions_notes_note_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.sessions_notes ALTER COLUMN note_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sessions_notes_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    tag_id integer NOT NULL,
    name text NOT NULL,
    project_id integer NOT NULL,
    selector text NOT NULL,
    ignore_click_rage boolean NOT NULL,
    ignore_dead_click boolean NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: tags_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tags_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tags_tag_id_seq OWNED BY public.tags.tag_id;


--
-- Name: tenants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tenants (
    tenant_id integer DEFAULT 1 NOT NULL,
    tenant_key text DEFAULT public.generate_api_key(20) NOT NULL,
    name text NOT NULL,
    api_key text DEFAULT public.generate_api_key(20) NOT NULL,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    license text,
    opt_out boolean DEFAULT false NOT NULL,
    t_projects integer DEFAULT 1 NOT NULL,
    t_sessions bigint DEFAULT 0 NOT NULL,
    t_users integer DEFAULT 1 NOT NULL,
    t_integrations integer DEFAULT 0 NOT NULL,
    last_telemetry bigint DEFAULT ((EXTRACT(epoch FROM date_trunc('day'::text, now())) * (1000)::numeric))::bigint NOT NULL,
    scope_state smallint DEFAULT 2 NOT NULL,
    CONSTRAINT onerow_uni CHECK ((tenant_id = 1))
);


--
-- Name: user_favorite_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_favorite_sessions (
    user_id integer NOT NULL,
    session_id bigint NOT NULL
);


--
-- Name: user_viewed_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_viewed_notifications (
    user_id integer NOT NULL,
    notification_id integer NOT NULL
);


--
-- Name: user_viewed_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_viewed_sessions (
    user_id integer NOT NULL,
    session_id bigint NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    email text NOT NULL,
    role public.user_role DEFAULT 'member'::public.user_role NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    deleted_at timestamp without time zone,
    api_key text DEFAULT public.generate_api_key(20) NOT NULL,
    jwt_iat timestamp without time zone,
    jwt_refresh_jti integer,
    jwt_refresh_iat timestamp without time zone,
    spot_jwt_iat timestamp without time zone,
    spot_jwt_refresh_jti integer,
    spot_jwt_refresh_iat timestamp without time zone,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    weekly_report boolean DEFAULT true NOT NULL,
    settings jsonb DEFAULT '{"modules": ["usability-tests", "feature-flags"]}'::jsonb
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ut_tests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ut_tests (
    test_id integer NOT NULL,
    project_id integer NOT NULL,
    title character varying(255) NOT NULL,
    starting_path character varying(255),
    status public.ui_tests_status NOT NULL,
    require_mic boolean DEFAULT false,
    require_camera boolean DEFAULT false,
    description text,
    guidelines text,
    conclusion_message text,
    created_by integer,
    updated_by integer,
    visibility boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: ut_tests_signals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ut_tests_signals (
    signal_id integer NOT NULL,
    session_id bigint,
    test_id integer NOT NULL,
    task_id integer,
    status public.ut_signal_status NOT NULL,
    comment text,
    "timestamp" bigint NOT NULL,
    duration bigint
);


--
-- Name: ut_tests_signals_signal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ut_tests_signals ALTER COLUMN signal_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ut_tests_signals_signal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ut_tests_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ut_tests_tasks (
    task_id integer NOT NULL,
    test_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    allow_typing boolean DEFAULT false
);


--
-- Name: ut_tests_tasks_task_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ut_tests_tasks ALTER COLUMN task_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ut_tests_tasks_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ut_tests_test_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ut_tests ALTER COLUMN test_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ut_tests_test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhooks (
    webhook_id integer NOT NULL,
    endpoint text NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    deleted_at timestamp without time zone,
    auth_header text,
    type public.webhook_type DEFAULT 'webhook'::public.webhook_type NOT NULL,
    index integer DEFAULT 0 NOT NULL,
    name character varying(100)
);


--
-- Name: webhooks_webhook_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.webhooks ALTER COLUMN webhook_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.webhooks_webhook_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: keys; Type: TABLE; Schema: spots; Owner: -
--

CREATE TABLE spots.keys (
    spot_key text NOT NULL,
    spot_id bigint NOT NULL,
    user_id bigint NOT NULL,
    expiration bigint NOT NULL,
    expired_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


--
-- Name: spots; Type: TABLE; Schema: spots; Owner: -
--

CREATE TABLE spots.spots (
    spot_id bigint NOT NULL,
    name text NOT NULL,
    user_id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    duration integer NOT NULL,
    crop integer[],
    comments text[],
    status text DEFAULT 'pending'::text,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


--
-- Name: streams; Type: TABLE; Schema: spots; Owner: -
--

CREATE TABLE spots.streams (
    spot_id bigint NOT NULL,
    original_playlist text NOT NULL,
    modified_playlist text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    expired_at timestamp without time zone NOT NULL
);


--
-- Name: tasks; Type: TABLE; Schema: spots; Owner: -
--

CREATE TABLE spots.tasks (
    spot_id bigint NOT NULL,
    duration integer NOT NULL,
    crop integer[],
    status text NOT NULL,
    error text,
    added_time timestamp without time zone NOT NULL
);


--
-- Name: announcements announcement_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements ALTER COLUMN announcement_id SET DEFAULT nextval('public.announcements_announcement_id_seq'::regclass);


--
-- Name: tags tag_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags ALTER COLUMN tag_id SET DEFAULT nextval('public.tags_tag_id_seq'::regclass);


--
-- Name: clicks clicks_pkey; Type: CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.clicks
    ADD CONSTRAINT clicks_pkey PRIMARY KEY (session_id, message_id);


--
-- Name: errors errors_pkey; Type: CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.errors
    ADD CONSTRAINT errors_pkey PRIMARY KEY (session_id, message_id);


--
-- Name: graphql graphql_pkey; Type: CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.graphql
    ADD CONSTRAINT graphql_pkey PRIMARY KEY (session_id, message_id);


--
-- Name: inputs inputs_pkey; Type: CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.inputs
    ADD CONSTRAINT inputs_pkey PRIMARY KEY (session_id, message_id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (session_id, message_id);


--
-- Name: performance performance_pkey; Type: CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.performance
    ADD CONSTRAINT performance_pkey PRIMARY KEY (session_id, message_id);


--
-- Name: state_actions state_actions_pkey; Type: CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.state_actions
    ADD CONSTRAINT state_actions_pkey PRIMARY KEY (session_id, message_id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (session_id, "timestamp", seq_index);


--
-- Name: crashes crashes_pkey; Type: CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.crashes
    ADD CONSTRAINT crashes_pkey PRIMARY KEY (session_id, "timestamp", seq_index);


--
-- Name: customs customs_pkey; Type: CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.customs
    ADD CONSTRAINT customs_pkey PRIMARY KEY (session_id, "timestamp", seq_index);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (session_id, "timestamp", seq_index);


--
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (session_id, "timestamp", seq_index);


--
-- Name: inputs inputs_pkey; Type: CONSTRAINT; Schema: events_ios; Owner: -
--

ALTER TABLE ONLY events_ios.inputs
    ADD CONSTRAINT inputs_pkey PRIMARY KEY (session_id, "timestamp", seq_index);


--
-- Name: swipes swipes_pkey; Type: CONSTRAINT; Schema: events_ios; Owner: -
--

ALTER TABLE ONLY events_ios.swipes
    ADD CONSTRAINT swipes_pkey PRIMARY KEY (session_id, "timestamp", seq_index);


--
-- Name: taps taps_pkey; Type: CONSTRAINT; Schema: events_ios; Owner: -
--

ALTER TABLE ONLY events_ios.taps
    ADD CONSTRAINT taps_pkey PRIMARY KEY (session_id, "timestamp", seq_index);


--
-- Name: views views_pkey; Type: CONSTRAINT; Schema: events_ios; Owner: -
--

ALTER TABLE ONLY events_ios.views
    ADD CONSTRAINT views_pkey PRIMARY KEY (session_id, "timestamp", seq_index);


--
-- Name: actions actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (action_id);


--
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (alert_id);


--
-- Name: announcements announcements_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pk PRIMARY KEY (announcement_id);


--
-- Name: basic_authentication basic_authentication_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basic_authentication
    ADD CONSTRAINT basic_authentication_user_id_key UNIQUE (user_id);


--
-- Name: crashes_ios crashes_ios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.crashes_ios
    ADD CONSTRAINT crashes_ios_pkey PRIMARY KEY (crash_ios_id);


--
-- Name: dashboard_widgets dashboard_widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dashboard_widgets
    ADD CONSTRAINT dashboard_widgets_pkey PRIMARY KEY (widget_id);


--
-- Name: dashboards dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dashboards
    ADD CONSTRAINT dashboards_pkey PRIMARY KEY (dashboard_id);


--
-- Name: errors errors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_pkey PRIMARY KEY (error_id);


--
-- Name: feature_flags_conditions feature_flags_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_flags_conditions
    ADD CONSTRAINT feature_flags_conditions_pkey PRIMARY KEY (condition_id);


--
-- Name: feature_flags feature_flags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_flags
    ADD CONSTRAINT feature_flags_pkey PRIMARY KEY (feature_flag_id);


--
-- Name: feature_flags_variants feature_flags_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_flags_variants
    ADD CONSTRAINT feature_flags_variants_pkey PRIMARY KEY (variant_id);


--
-- Name: integrations integrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integrations
    ADD CONSTRAINT integrations_pkey PRIMARY KEY (project_id, provider);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (issue_id);


--
-- Name: jira_cloud jira_cloud_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jira_cloud
    ADD CONSTRAINT jira_cloud_pk PRIMARY KEY (user_id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (job_id);


--
-- Name: metric_series metric_series_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_series
    ADD CONSTRAINT metric_series_pkey PRIMARY KEY (series_id);


--
-- Name: metrics metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metrics
    ADD CONSTRAINT metrics_pkey PRIMARY KEY (metric_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: projects_conditions projects_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects_conditions
    ADD CONSTRAINT projects_conditions_pkey PRIMARY KEY (condition_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- Name: projects projects_project_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_project_key_key UNIQUE (project_key);


--
-- Name: projects_stats projects_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects_stats
    ADD CONSTRAINT projects_stats_pkey PRIMARY KEY (project_id, created_at);


--
-- Name: saved_searches saved_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.saved_searches
    ADD CONSTRAINT saved_searches_pkey PRIMARY KEY (search_id);


--
-- Name: searches searches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.searches
    ADD CONSTRAINT searches_pkey PRIMARY KEY (search_id);


--
-- Name: session_integrations session_integrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_integrations
    ADD CONSTRAINT session_integrations_pkey PRIMARY KEY (session_id, project_id, provider);


--
-- Name: sessions_notes sessions_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions_notes
    ADD CONSTRAINT sessions_notes_pkey PRIMARY KEY (note_id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: feature_flags unique_project_flag_deleted; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_flags
    ADD CONSTRAINT unique_project_flag_deleted UNIQUE (project_id, flag_key, deleted_at);


--
-- Name: user_favorite_sessions user_favorite_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_favorite_sessions
    ADD CONSTRAINT user_favorite_sessions_pkey PRIMARY KEY (user_id, session_id);


--
-- Name: user_viewed_notifications user_viewed_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_viewed_notifications
    ADD CONSTRAINT user_viewed_notifications_pkey PRIMARY KEY (user_id, notification_id);


--
-- Name: user_viewed_sessions user_viewed_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_viewed_sessions
    ADD CONSTRAINT user_viewed_sessions_pkey PRIMARY KEY (user_id, session_id);


--
-- Name: users users_api_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_api_key_key UNIQUE (api_key);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: ut_tests ut_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests
    ADD CONSTRAINT ut_tests_pkey PRIMARY KEY (test_id);


--
-- Name: ut_tests_signals ut_tests_signals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests_signals
    ADD CONSTRAINT ut_tests_signals_pkey PRIMARY KEY (signal_id);


--
-- Name: ut_tests_tasks ut_tests_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests_tasks
    ADD CONSTRAINT ut_tests_tasks_pkey PRIMARY KEY (task_id);


--
-- Name: webhooks webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks
    ADD CONSTRAINT webhooks_pkey PRIMARY KEY (webhook_id);


--
-- Name: keys keys_pkey; Type: CONSTRAINT; Schema: spots; Owner: -
--

ALTER TABLE ONLY spots.keys
    ADD CONSTRAINT keys_pkey PRIMARY KEY (spot_key);


--
-- Name: keys keys_spot_id_key; Type: CONSTRAINT; Schema: spots; Owner: -
--

ALTER TABLE ONLY spots.keys
    ADD CONSTRAINT keys_spot_id_key UNIQUE (spot_id);


--
-- Name: spots spots_pkey; Type: CONSTRAINT; Schema: spots; Owner: -
--

ALTER TABLE ONLY spots.spots
    ADD CONSTRAINT spots_pkey PRIMARY KEY (spot_id);


--
-- Name: streams streams_pkey; Type: CONSTRAINT; Schema: spots; Owner: -
--

ALTER TABLE ONLY spots.streams
    ADD CONSTRAINT streams_pkey PRIMARY KEY (spot_id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: spots; Owner: -
--

ALTER TABLE ONLY spots.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (spot_id);


--
-- Name: canvas_recordings_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX canvas_recordings_session_id_idx ON events.canvas_recordings USING btree (session_id);


--
-- Name: clicks_label_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_label_gin_idx ON events.clicks USING gin (label public.gin_trgm_ops);


--
-- Name: clicks_label_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_label_idx ON events.clicks USING btree (label);


--
-- Name: clicks_label_session_id_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_label_session_id_timestamp_idx ON events.clicks USING btree (label, session_id, "timestamp");


--
-- Name: clicks_path_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_path_gin_idx ON events.clicks USING gin (path public.gin_trgm_ops);


--
-- Name: clicks_path_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_path_idx ON events.clicks USING btree (path);


--
-- Name: clicks_selector_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_selector_idx ON events.clicks USING btree (selector);


--
-- Name: clicks_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_session_id_idx ON events.clicks USING btree (session_id);


--
-- Name: clicks_session_id_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_session_id_timestamp_idx ON events.clicks USING btree (session_id, "timestamp");


--
-- Name: clicks_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_timestamp_idx ON events.clicks USING btree ("timestamp");


--
-- Name: clicks_url_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_url_idx ON events.clicks USING btree (url);


--
-- Name: clicks_url_session_id_timestamp_selector_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX clicks_url_session_id_timestamp_selector_idx ON events.clicks USING btree (url, session_id, "timestamp", selector);


--
-- Name: errors_error_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX errors_error_id_idx ON events.errors USING btree (error_id);


--
-- Name: errors_error_id_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX errors_error_id_timestamp_idx ON events.errors USING btree (error_id, "timestamp");


--
-- Name: errors_error_id_timestamp_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX errors_error_id_timestamp_session_id_idx ON events.errors USING btree (error_id, "timestamp", session_id);


--
-- Name: errors_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX errors_session_id_idx ON events.errors USING btree (session_id);


--
-- Name: errors_session_id_timestamp_error_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX errors_session_id_timestamp_error_id_idx ON events.errors USING btree (session_id, "timestamp", error_id);


--
-- Name: errors_timestamp_error_id_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX errors_timestamp_error_id_session_id_idx ON events.errors USING btree ("timestamp", error_id, session_id);


--
-- Name: errors_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX errors_timestamp_idx ON events.errors USING btree ("timestamp");


--
-- Name: graphql_name_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX graphql_name_gin_idx ON events.graphql USING gin (name public.gin_trgm_ops);


--
-- Name: graphql_name_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX graphql_name_idx ON events.graphql USING btree (name);


--
-- Name: graphql_request_body_nn_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX graphql_request_body_nn_gin_idx ON events.graphql USING gin (request_body public.gin_trgm_ops) WHERE (request_body IS NOT NULL);


--
-- Name: graphql_request_body_nn_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX graphql_request_body_nn_idx ON events.graphql USING btree (request_body) WHERE (request_body IS NOT NULL);


--
-- Name: graphql_response_body_nn_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX graphql_response_body_nn_gin_idx ON events.graphql USING gin (response_body public.gin_trgm_ops) WHERE (response_body IS NOT NULL);


--
-- Name: graphql_response_body_nn_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX graphql_response_body_nn_idx ON events.graphql USING btree (response_body) WHERE (response_body IS NOT NULL);


--
-- Name: graphql_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX graphql_session_id_idx ON events.graphql USING btree (session_id);


--
-- Name: graphql_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX graphql_timestamp_idx ON events.graphql USING btree ("timestamp");


--
-- Name: inputs_label_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX inputs_label_gin_idx ON events.inputs USING gin (label public.gin_trgm_ops);


--
-- Name: inputs_label_session_id_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX inputs_label_session_id_timestamp_idx ON events.inputs USING btree (label, session_id, "timestamp");


--
-- Name: inputs_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX inputs_session_id_idx ON events.inputs USING btree (session_id);


--
-- Name: inputs_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX inputs_timestamp_idx ON events.inputs USING btree ("timestamp");


--
-- Name: pages_base_referrer_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_base_referrer_gin_idx ON events.pages USING gin (base_referrer public.gin_trgm_ops);


--
-- Name: pages_base_referrer_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_base_referrer_idx ON events.pages USING btree (base_referrer);


--
-- Name: pages_dom_building_time_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_dom_building_time_idx ON events.pages USING btree (dom_building_time) WHERE (dom_building_time > 0);


--
-- Name: pages_dom_content_loaded_time_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_dom_content_loaded_time_idx ON events.pages USING btree (dom_content_loaded_time) WHERE (dom_content_loaded_time > 0);


--
-- Name: pages_first_contentful_paint_time_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_first_contentful_paint_time_idx ON events.pages USING btree (first_contentful_paint_time) WHERE (first_contentful_paint_time > 0);


--
-- Name: pages_first_paint_time_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_first_paint_time_idx ON events.pages USING btree (first_paint_time) WHERE (first_paint_time > 0);


--
-- Name: pages_load_time_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_load_time_idx ON events.pages USING btree (load_time) WHERE (load_time > 0);


--
-- Name: pages_path_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_path_gin_idx ON events.pages USING gin (path public.gin_trgm_ops);


--
-- Name: pages_path_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_path_idx ON events.pages USING btree (path);


--
-- Name: pages_path_pathlngt2_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_path_pathlngt2_idx ON events.pages USING btree (path) WHERE (length(path) > 2);


--
-- Name: pages_path_session_id_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_path_session_id_timestamp_idx ON events.pages USING btree (path, session_id, "timestamp");


--
-- Name: pages_query_nn_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_query_nn_gin_idx ON events.pages USING gin (query public.gin_trgm_ops) WHERE (query IS NOT NULL);


--
-- Name: pages_query_nn_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_query_nn_idx ON events.pages USING btree (query) WHERE (query IS NOT NULL);


--
-- Name: pages_response_end_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_response_end_idx ON events.pages USING btree (response_end);


--
-- Name: pages_response_time_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_response_time_idx ON events.pages USING btree (response_time);


--
-- Name: pages_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_session_id_idx ON events.pages USING btree (session_id);


--
-- Name: pages_session_id_speed_indexgt0nn_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_session_id_speed_indexgt0nn_idx ON events.pages USING btree (session_id, speed_index) WHERE ((speed_index > 0) AND (speed_index IS NOT NULL));


--
-- Name: pages_session_id_timestamp_dom_building_timegt0nn_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_session_id_timestamp_dom_building_timegt0nn_idx ON events.pages USING btree (session_id, "timestamp", dom_building_time) WHERE ((dom_building_time > 0) AND (dom_building_time IS NOT NULL));


--
-- Name: pages_session_id_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_session_id_timestamp_idx ON events.pages USING btree (session_id, "timestamp");


--
-- Name: pages_session_id_timestamp_loadgt0nn_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_session_id_timestamp_loadgt0nn_idx ON events.pages USING btree (session_id, "timestamp") WHERE ((load_time > 0) AND (load_time IS NOT NULL));


--
-- Name: pages_session_id_timestamp_visualgt0nn_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_session_id_timestamp_visualgt0nn_idx ON events.pages USING btree (session_id, "timestamp") WHERE ((visually_complete > 0) AND (visually_complete IS NOT NULL));


--
-- Name: pages_time_to_interactive_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_time_to_interactive_idx ON events.pages USING btree (time_to_interactive) WHERE (time_to_interactive > 0);


--
-- Name: pages_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_timestamp_idx ON events.pages USING btree ("timestamp");


--
-- Name: pages_timestamp_metgt0_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_timestamp_metgt0_idx ON events.pages USING btree ("timestamp") WHERE ((response_time > 0) OR (first_paint_time > 0) OR (dom_content_loaded_time > 0) OR (ttfb > 0) OR (time_to_interactive > 0));


--
-- Name: pages_ttfb_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_ttfb_idx ON events.pages USING btree (ttfb) WHERE (ttfb > 0);


--
-- Name: pages_visually_complete_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX pages_visually_complete_idx ON events.pages USING btree (visually_complete) WHERE (visually_complete > 0);


--
-- Name: performance_avg_cpu_gt0_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX performance_avg_cpu_gt0_idx ON events.performance USING btree (avg_cpu) WHERE (avg_cpu > 0);


--
-- Name: performance_avg_used_js_heap_size_gt0_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX performance_avg_used_js_heap_size_gt0_idx ON events.performance USING btree (avg_used_js_heap_size) WHERE (avg_used_js_heap_size > 0);


--
-- Name: performance_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX performance_session_id_idx ON events.performance USING btree (session_id);


--
-- Name: performance_session_id_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX performance_session_id_timestamp_idx ON events.performance USING btree (session_id, "timestamp");


--
-- Name: performance_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX performance_timestamp_idx ON events.performance USING btree ("timestamp");


--
-- Name: state_actions_name_gin_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX state_actions_name_gin_idx ON events.state_actions USING gin (name public.gin_trgm_ops);


--
-- Name: state_actions_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX state_actions_timestamp_idx ON events.state_actions USING btree ("timestamp");


--
-- Name: tags_session_id_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX tags_session_id_idx ON events.tags USING btree (session_id);


--
-- Name: tags_timestamp_idx; Type: INDEX; Schema: events; Owner: -
--

CREATE INDEX tags_timestamp_idx ON events.tags USING btree ("timestamp");


--
-- Name: crashes_crash_ios_id_timestamp_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX crashes_crash_ios_id_timestamp_idx ON events_common.crashes USING btree (crash_ios_id, "timestamp");


--
-- Name: crashes_session_id_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX crashes_session_id_idx ON events_common.crashes USING btree (session_id);


--
-- Name: crashes_timestamp_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX crashes_timestamp_idx ON events_common.crashes USING btree ("timestamp");


--
-- Name: customs_name_gin_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX customs_name_gin_idx ON events_common.customs USING gin (name public.gin_trgm_ops);


--
-- Name: customs_name_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX customs_name_idx ON events_common.customs USING btree (name);


--
-- Name: customs_timestamp_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX customs_timestamp_idx ON events_common.customs USING btree ("timestamp");


--
-- Name: issues_issue_id_timestamp_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX issues_issue_id_timestamp_idx ON events_common.issues USING btree (issue_id, "timestamp");


--
-- Name: issues_timestamp_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX issues_timestamp_idx ON events_common.issues USING btree ("timestamp");


--
-- Name: requests_duration_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_duration_idx ON events_common.requests USING btree (duration);


--
-- Name: requests_host_nn_gin_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_host_nn_gin_idx ON events_common.requests USING gin (host public.gin_trgm_ops) WHERE (host IS NOT NULL);


--
-- Name: requests_path_nn_gin_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_path_nn_gin_idx ON events_common.requests USING gin (path public.gin_trgm_ops) WHERE (path IS NOT NULL);


--
-- Name: requests_path_nn_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_path_nn_idx ON events_common.requests USING btree (path) WHERE (path IS NOT NULL);


--
-- Name: requests_query_nn_gin_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_query_nn_gin_idx ON events_common.requests USING gin (query public.gin_trgm_ops) WHERE (query IS NOT NULL);


--
-- Name: requests_request_body_nn_gin_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_request_body_nn_gin_idx ON events_common.requests USING gin (request_body public.gin_trgm_ops) WHERE (request_body IS NOT NULL);


--
-- Name: requests_response_body_nn_gin_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_response_body_nn_gin_idx ON events_common.requests USING gin (response_body public.gin_trgm_ops) WHERE (response_body IS NOT NULL);


--
-- Name: requests_session_id_status_code_nn_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_session_id_status_code_nn_idx ON events_common.requests USING btree (session_id, status_code) WHERE (status_code IS NOT NULL);


--
-- Name: requests_status_code_nn_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_status_code_nn_idx ON events_common.requests USING btree (status_code) WHERE (status_code IS NOT NULL);


--
-- Name: requests_timestamp_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_timestamp_idx ON events_common.requests USING btree ("timestamp");


--
-- Name: requests_timestamp_session_id_failed_idx; Type: INDEX; Schema: events_common; Owner: -
--

CREATE INDEX requests_timestamp_session_id_failed_idx ON events_common.requests USING btree ("timestamp", session_id) WHERE (success = false);


--
-- Name: inputs_label_gin_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX inputs_label_gin_idx ON events_ios.inputs USING gin (label public.gin_trgm_ops);


--
-- Name: inputs_label_session_id_timestamp_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX inputs_label_session_id_timestamp_idx ON events_ios.inputs USING btree (label, session_id, "timestamp");


--
-- Name: inputs_session_id_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX inputs_session_id_idx ON events_ios.inputs USING btree (session_id);


--
-- Name: inputs_timestamp_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX inputs_timestamp_idx ON events_ios.inputs USING btree ("timestamp");


--
-- Name: swipes_label_gin_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX swipes_label_gin_idx ON events_ios.swipes USING gin (label public.gin_trgm_ops);


--
-- Name: swipes_label_session_id_timestamp_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX swipes_label_session_id_timestamp_idx ON events_ios.swipes USING btree (label, session_id, "timestamp");


--
-- Name: swipes_session_id_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX swipes_session_id_idx ON events_ios.swipes USING btree (session_id);


--
-- Name: swipes_timestamp_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX swipes_timestamp_idx ON events_ios.swipes USING btree ("timestamp");


--
-- Name: taps_label_gin_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX taps_label_gin_idx ON events_ios.taps USING gin (label public.gin_trgm_ops);


--
-- Name: taps_label_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX taps_label_idx ON events_ios.taps USING btree (label);


--
-- Name: taps_label_session_id_timestamp_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX taps_label_session_id_timestamp_idx ON events_ios.taps USING btree (label, session_id, "timestamp");


--
-- Name: taps_session_id_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX taps_session_id_idx ON events_ios.taps USING btree (session_id);


--
-- Name: taps_session_id_timestamp_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX taps_session_id_timestamp_idx ON events_ios.taps USING btree (session_id, "timestamp");


--
-- Name: taps_timestamp_idx; Type: INDEX; Schema: events_ios; Owner: -
--

CREATE INDEX taps_timestamp_idx ON events_ios.taps USING btree ("timestamp");


--
-- Name: actions_name_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actions_name_gin_idx ON public.actions USING gin (name public.gin_trgm_ops);


--
-- Name: actions_project_id_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actions_project_id_created_at_idx ON public.actions USING btree (project_id, created_at DESC);


--
-- Name: actions_project_id_is_public_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actions_project_id_is_public_idx ON public.actions USING btree (project_id, is_public);


--
-- Name: actions_project_id_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX actions_project_id_name_idx ON public.actions USING btree (project_id, name);


--
-- Name: actions_project_id_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actions_project_id_user_id_idx ON public.actions USING btree (project_id, user_id);


--
-- Name: actions_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX actions_user_id_idx ON public.actions USING btree (user_id);


--
-- Name: alerts_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX alerts_project_id_idx ON public.alerts USING btree (project_id);


--
-- Name: alerts_series_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX alerts_series_id_idx ON public.alerts USING btree (series_id);


--
-- Name: assigned_sessions_session_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX assigned_sessions_session_id_idx ON public.assigned_sessions USING btree (session_id);


--
-- Name: autocomplete_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_project_id_idx ON public.autocomplete USING btree (project_id);


--
-- Name: autocomplete_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_type_idx ON public.autocomplete USING btree (type);


--
-- Name: autocomplete_unique_project_id_md5value_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX autocomplete_unique_project_id_md5value_type_idx ON public.autocomplete USING btree (project_id, md5(value), type);


--
-- Name: autocomplete_value_clickonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_clickonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'CLICK'::text);


--
-- Name: autocomplete_value_customonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_customonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'CUSTOM'::text);


--
-- Name: autocomplete_value_graphqlonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_graphqlonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'GRAPHQL'::text);


--
-- Name: autocomplete_value_inputonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_inputonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'INPUT'::text);


--
-- Name: autocomplete_value_locationonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_locationonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'LOCATION'::text);


--
-- Name: autocomplete_value_referreronly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_referreronly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'REFERRER'::text);


--
-- Name: autocomplete_value_requestonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_requestonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'REQUEST'::text);


--
-- Name: autocomplete_value_revidonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_revidonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'REVID'::text);


--
-- Name: autocomplete_value_stateactiononly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_stateactiononly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'STATEACTION'::text);


--
-- Name: autocomplete_value_useranonymousidonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_useranonymousidonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'USERANONYMOUSID'::text);


--
-- Name: autocomplete_value_userbrowseronly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_userbrowseronly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'USERBROWSER'::text);


--
-- Name: autocomplete_value_usercountryonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_usercountryonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'USERCOUNTRY'::text);


--
-- Name: autocomplete_value_userdeviceonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_userdeviceonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'USERDEVICE'::text);


--
-- Name: autocomplete_value_useridonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_useridonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'USERID'::text);


--
-- Name: autocomplete_value_userosonly_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autocomplete_value_userosonly_gin_idx ON public.autocomplete USING gin (value public.gin_trgm_ops) WHERE (type = 'USEROS'::text);


--
-- Name: crashes_ios_project_id_crash_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX crashes_ios_project_id_crash_id_idx ON public.crashes_ios USING btree (project_id, crash_ios_id);


--
-- Name: crashes_ios_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX crashes_ios_project_id_idx ON public.crashes_ios USING btree (project_id);


--
-- Name: errors_error_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_error_id_idx ON public.errors USING btree (error_id);


--
-- Name: errors_message_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_message_gin_idx ON public.errors USING gin (message public.gin_trgm_ops);


--
-- Name: errors_name_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_name_gin_idx ON public.errors USING gin (name public.gin_trgm_ops);


--
-- Name: errors_parent_error_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_parent_error_id_idx ON public.errors USING btree (parent_error_id);


--
-- Name: errors_project_id_error_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_project_id_error_id_idx ON public.errors USING btree (project_id, error_id);


--
-- Name: errors_project_id_error_id_integration_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_project_id_error_id_integration_idx ON public.errors USING btree (project_id, error_id) WHERE (source <> 'js_exception'::public.error_source);


--
-- Name: errors_project_id_error_id_js_exception_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_project_id_error_id_js_exception_idx ON public.errors USING btree (project_id, error_id) WHERE (source = 'js_exception'::public.error_source);


--
-- Name: errors_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_project_id_idx ON public.errors USING btree (project_id);


--
-- Name: errors_project_id_source_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_project_id_source_idx ON public.errors USING btree (project_id, source);


--
-- Name: errors_project_id_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_project_id_status_idx ON public.errors USING btree (project_id, status);


--
-- Name: errors_tags_error_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_tags_error_id_idx ON public.errors_tags USING btree (error_id);


--
-- Name: errors_tags_message_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_tags_message_id_idx ON public.errors_tags USING btree (message_id);


--
-- Name: errors_tags_session_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX errors_tags_session_id_idx ON public.errors_tags USING btree (session_id);


--
-- Name: idx_feature_flags_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feature_flags_project_id ON public.feature_flags USING btree (project_id);


--
-- Name: issues_issue_id_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX issues_issue_id_type_idx ON public.issues USING btree (issue_id, type);


--
-- Name: issues_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX issues_project_id_idx ON public.issues USING btree (project_id);


--
-- Name: issues_project_id_issue_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX issues_project_id_issue_id_idx ON public.issues USING btree (project_id, issue_id);


--
-- Name: jobs_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_project_id_idx ON public.jobs USING btree (project_id);


--
-- Name: jobs_start_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_start_at_idx ON public.jobs USING btree (start_at);


--
-- Name: jobs_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_status_idx ON public.jobs USING btree (status);


--
-- Name: metric_series_metric_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX metric_series_metric_id_idx ON public.metric_series USING btree (metric_id);


--
-- Name: metrics_user_id_is_public_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX metrics_user_id_is_public_idx ON public.metrics USING btree (user_id, is_public);


--
-- Name: notifications_created_at_epoch_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_created_at_epoch_idx ON public.notifications USING btree ((((EXTRACT(epoch FROM created_at) * (1000)::numeric))::bigint) DESC);


--
-- Name: notifications_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_created_at_index ON public.notifications USING btree (created_at DESC);


--
-- Name: notifications_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_user_id_index ON public.notifications USING btree (user_id);


--
-- Name: oauth_authentication_unique_user_id_provider_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX oauth_authentication_unique_user_id_provider_idx ON public.oauth_authentication USING btree (user_id, provider);


--
-- Name: projects_project_id_deleted_at_n_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projects_project_id_deleted_at_n_idx ON public.projects USING btree (project_id) WHERE (deleted_at IS NULL);


--
-- Name: projects_project_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projects_project_key_idx ON public.projects USING btree (project_key);


--
-- Name: projects_stats_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX projects_stats_project_id_idx ON public.projects_stats USING btree (project_id);


--
-- Name: saved_searches_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX saved_searches_project_id_idx ON public.saved_searches USING btree (project_id);


--
-- Name: searches_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX searches_project_id_idx ON public.searches USING btree (project_id);


--
-- Name: searches_user_id_is_public_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX searches_user_id_is_public_idx ON public.searches USING btree (user_id, is_public);


--
-- Name: sessions_base_referrer_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_base_referrer_gin_idx ON public.sessions USING gin (base_referrer public.gin_trgm_ops);


--
-- Name: sessions_metadata10_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata10_gin_idx ON public.sessions USING gin (metadata_10 public.gin_trgm_ops);


--
-- Name: sessions_metadata1_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata1_gin_idx ON public.sessions USING gin (metadata_1 public.gin_trgm_ops);


--
-- Name: sessions_metadata2_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata2_gin_idx ON public.sessions USING gin (metadata_2 public.gin_trgm_ops);


--
-- Name: sessions_metadata3_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata3_gin_idx ON public.sessions USING gin (metadata_3 public.gin_trgm_ops);


--
-- Name: sessions_metadata4_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata4_gin_idx ON public.sessions USING gin (metadata_4 public.gin_trgm_ops);


--
-- Name: sessions_metadata5_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata5_gin_idx ON public.sessions USING gin (metadata_5 public.gin_trgm_ops);


--
-- Name: sessions_metadata6_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata6_gin_idx ON public.sessions USING gin (metadata_6 public.gin_trgm_ops);


--
-- Name: sessions_metadata7_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata7_gin_idx ON public.sessions USING gin (metadata_7 public.gin_trgm_ops);


--
-- Name: sessions_metadata8_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata8_gin_idx ON public.sessions USING gin (metadata_8 public.gin_trgm_ops);


--
-- Name: sessions_metadata9_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_metadata9_gin_idx ON public.sessions USING gin (metadata_9 public.gin_trgm_ops);


--
-- Name: sessions_platform_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_platform_idx ON public.sessions USING btree (platform);


--
-- Name: sessions_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_idx ON public.sessions USING btree (project_id) WHERE (duration > 0);


--
-- Name: sessions_project_id_metadata_10_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_10_idx ON public.sessions USING btree (project_id, metadata_10);


--
-- Name: sessions_project_id_metadata_1_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_1_idx ON public.sessions USING btree (project_id, metadata_1);


--
-- Name: sessions_project_id_metadata_2_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_2_idx ON public.sessions USING btree (project_id, metadata_2);


--
-- Name: sessions_project_id_metadata_3_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_3_idx ON public.sessions USING btree (project_id, metadata_3);


--
-- Name: sessions_project_id_metadata_4_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_4_idx ON public.sessions USING btree (project_id, metadata_4);


--
-- Name: sessions_project_id_metadata_5_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_5_idx ON public.sessions USING btree (project_id, metadata_5);


--
-- Name: sessions_project_id_metadata_6_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_6_idx ON public.sessions USING btree (project_id, metadata_6);


--
-- Name: sessions_project_id_metadata_7_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_7_idx ON public.sessions USING btree (project_id, metadata_7);


--
-- Name: sessions_project_id_metadata_8_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_8_idx ON public.sessions USING btree (project_id, metadata_8);


--
-- Name: sessions_project_id_metadata_9_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_metadata_9_idx ON public.sessions USING btree (project_id, metadata_9);


--
-- Name: sessions_project_id_start_ts_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_start_ts_idx ON public.sessions USING btree (project_id, start_ts);


--
-- Name: sessions_project_id_user_anonymous_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_user_anonymous_id_idx ON public.sessions USING btree (project_id, user_anonymous_id);


--
-- Name: sessions_project_id_user_browser_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_user_browser_idx ON public.sessions USING btree (project_id, user_browser);


--
-- Name: sessions_project_id_user_city_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_user_city_idx ON public.sessions USING btree (project_id, user_city);


--
-- Name: sessions_project_id_user_country_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_user_country_idx ON public.sessions USING btree (project_id, user_country);


--
-- Name: sessions_project_id_user_device_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_user_device_idx ON public.sessions USING btree (project_id, user_device);


--
-- Name: sessions_project_id_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_user_id_idx ON public.sessions USING btree (project_id, user_id);


--
-- Name: sessions_project_id_user_state_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_user_state_idx ON public.sessions USING btree (project_id, user_state);


--
-- Name: sessions_project_id_watchdogs_score_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_project_id_watchdogs_score_idx ON public.sessions USING btree (project_id, watchdogs_score DESC);


--
-- Name: sessions_session_id_has_ut_test_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_session_id_has_ut_test_idx ON public.sessions USING btree (session_id, has_ut_test);


--
-- Name: sessions_session_id_project_id_start_ts_durationnn_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_session_id_project_id_start_ts_durationnn_idx ON public.sessions USING btree (session_id, project_id, start_ts) WHERE (duration IS NOT NULL);


--
-- Name: sessions_session_id_project_id_start_ts_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_session_id_project_id_start_ts_idx ON public.sessions USING btree (session_id, project_id, start_ts) WHERE (duration > 0);


--
-- Name: sessions_start_ts_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_start_ts_idx ON public.sessions USING btree (start_ts) WHERE (duration > 0);


--
-- Name: sessions_uid_projectid_startts_sessionid_uidnn_durgtz_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_uid_projectid_startts_sessionid_uidnn_durgtz_idx ON public.sessions USING btree (user_id, project_id, start_ts, session_id) WHERE ((user_id IS NOT NULL) AND (duration > 0));


--
-- Name: sessions_user_anonymous_id_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_anonymous_id_gin_idx ON public.sessions USING gin (user_anonymous_id public.gin_trgm_ops);


--
-- Name: sessions_user_device_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_device_gin_idx ON public.sessions USING gin (user_device public.gin_trgm_ops);


--
-- Name: sessions_user_id_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_gin_idx ON public.sessions USING gin (user_id public.gin_trgm_ops);


--
-- Name: sessions_user_id_useridnn_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_useridnn_idx ON public.sessions USING btree (user_id) WHERE (user_id IS NOT NULL);


--
-- Name: sessions_utm_campaign_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_utm_campaign_gin_idx ON public.sessions USING gin (utm_campaign public.gin_trgm_ops);


--
-- Name: sessions_utm_medium_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_utm_medium_gin_idx ON public.sessions USING gin (utm_medium public.gin_trgm_ops);


--
-- Name: sessions_utm_source_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_utm_source_gin_idx ON public.sessions USING gin (utm_source public.gin_trgm_ops);


--
-- Name: tags_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tags_project_id_idx ON public.tags USING btree (project_id);


--
-- Name: user_favorite_sessions_user_id_session_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_favorite_sessions_user_id_session_id_idx ON public.user_favorite_sessions USING btree (user_id, session_id);


--
-- Name: ut_tests_signals_session_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ut_tests_signals_session_id_idx ON public.ut_tests_signals USING btree (session_id);


--
-- Name: ut_tests_signals_unique_session_id_test_id_task_id_ts_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ut_tests_signals_unique_session_id_test_id_task_id_ts_idx ON public.ut_tests_signals USING btree (session_id, test_id, task_id, "timestamp");


--
-- Name: projects on_insert_or_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_insert_or_update AFTER INSERT OR UPDATE ON public.projects FOR EACH ROW EXECUTE FUNCTION public.notify_project();


--
-- Name: alerts on_insert_or_update_or_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_insert_or_update_or_delete AFTER INSERT OR DELETE OR UPDATE ON public.alerts FOR EACH ROW EXECUTE FUNCTION public.notify_alert();


--
-- Name: integrations on_insert_or_update_or_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_insert_or_update_or_delete AFTER INSERT OR DELETE OR UPDATE ON public.integrations FOR EACH ROW EXECUTE FUNCTION public.notify_integration();


--
-- Name: canvas_recordings canvas_recordings_session_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.canvas_recordings
    ADD CONSTRAINT canvas_recordings_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: clicks clicks_session_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.clicks
    ADD CONSTRAINT clicks_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: errors errors_error_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.errors
    ADD CONSTRAINT errors_error_id_fkey FOREIGN KEY (error_id) REFERENCES public.errors(error_id) ON DELETE CASCADE;


--
-- Name: errors errors_session_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.errors
    ADD CONSTRAINT errors_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: graphql graphql_session_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.graphql
    ADD CONSTRAINT graphql_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: inputs inputs_session_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.inputs
    ADD CONSTRAINT inputs_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: pages pages_session_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.pages
    ADD CONSTRAINT pages_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: performance performance_session_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.performance
    ADD CONSTRAINT performance_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: state_actions state_actions_session_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.state_actions
    ADD CONSTRAINT state_actions_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: tags tags_session_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.tags
    ADD CONSTRAINT tags_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: tags tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: events; Owner: -
--

ALTER TABLE ONLY events.tags
    ADD CONSTRAINT tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(tag_id) ON DELETE CASCADE;


--
-- Name: crashes crashes_crash_ios_id_fkey; Type: FK CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.crashes
    ADD CONSTRAINT crashes_crash_ios_id_fkey FOREIGN KEY (crash_ios_id) REFERENCES public.crashes_ios(crash_ios_id) ON DELETE CASCADE;


--
-- Name: crashes crashes_session_id_fkey; Type: FK CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.crashes
    ADD CONSTRAINT crashes_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: customs customs_session_id_fkey; Type: FK CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.customs
    ADD CONSTRAINT customs_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: issues issues_issue_id_fkey; Type: FK CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.issues
    ADD CONSTRAINT issues_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(issue_id) ON DELETE CASCADE;


--
-- Name: issues issues_session_id_fkey; Type: FK CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.issues
    ADD CONSTRAINT issues_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: requests requests_session_id_fkey; Type: FK CONSTRAINT; Schema: events_common; Owner: -
--

ALTER TABLE ONLY events_common.requests
    ADD CONSTRAINT requests_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: inputs inputs_session_id_fkey; Type: FK CONSTRAINT; Schema: events_ios; Owner: -
--

ALTER TABLE ONLY events_ios.inputs
    ADD CONSTRAINT inputs_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: swipes swipes_session_id_fkey; Type: FK CONSTRAINT; Schema: events_ios; Owner: -
--

ALTER TABLE ONLY events_ios.swipes
    ADD CONSTRAINT swipes_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: taps taps_session_id_fkey; Type: FK CONSTRAINT; Schema: events_ios; Owner: -
--

ALTER TABLE ONLY events_ios.taps
    ADD CONSTRAINT taps_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: views views_session_id_fkey; Type: FK CONSTRAINT; Schema: events_ios; Owner: -
--

ALTER TABLE ONLY events_ios.views
    ADD CONSTRAINT views_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: actions actions_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: actions actions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: alerts alerts_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: alerts alerts_series_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_series_id_fkey FOREIGN KEY (series_id) REFERENCES public.metric_series(series_id) ON DELETE CASCADE;


--
-- Name: assigned_sessions assigned_sessions_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assigned_sessions
    ADD CONSTRAINT assigned_sessions_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: autocomplete autocomplete_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.autocomplete
    ADD CONSTRAINT autocomplete_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: basic_authentication basic_authentication_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basic_authentication
    ADD CONSTRAINT basic_authentication_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: crashes_ios crashes_ios_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.crashes_ios
    ADD CONSTRAINT crashes_ios_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: dashboard_widgets dashboard_widgets_dashboard_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dashboard_widgets
    ADD CONSTRAINT dashboard_widgets_dashboard_id_fkey FOREIGN KEY (dashboard_id) REFERENCES public.dashboards(dashboard_id) ON DELETE CASCADE;


--
-- Name: dashboard_widgets dashboard_widgets_metric_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dashboard_widgets
    ADD CONSTRAINT dashboard_widgets_metric_id_fkey FOREIGN KEY (metric_id) REFERENCES public.metrics(metric_id) ON DELETE CASCADE;


--
-- Name: dashboard_widgets dashboard_widgets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dashboard_widgets
    ADD CONSTRAINT dashboard_widgets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: dashboards dashboards_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dashboards
    ADD CONSTRAINT dashboards_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: dashboards dashboards_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dashboards
    ADD CONSTRAINT dashboards_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: errors errors_parent_error_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_parent_error_id_fkey FOREIGN KEY (parent_error_id) REFERENCES public.errors(error_id) ON DELETE SET NULL;


--
-- Name: errors errors_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: errors_tags errors_tags_error_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.errors_tags
    ADD CONSTRAINT errors_tags_error_id_fkey FOREIGN KEY (error_id) REFERENCES public.errors(error_id) ON DELETE CASCADE;


--
-- Name: errors_tags errors_tags_session_id_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.errors_tags
    ADD CONSTRAINT errors_tags_session_id_message_id_fkey FOREIGN KEY (session_id, message_id) REFERENCES events.errors(session_id, message_id) ON DELETE CASCADE;


--
-- Name: feature_flags_conditions feature_flags_conditions_feature_flag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_flags_conditions
    ADD CONSTRAINT feature_flags_conditions_feature_flag_id_fkey FOREIGN KEY (feature_flag_id) REFERENCES public.feature_flags(feature_flag_id) ON DELETE CASCADE;


--
-- Name: feature_flags feature_flags_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_flags
    ADD CONSTRAINT feature_flags_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: feature_flags feature_flags_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_flags
    ADD CONSTRAINT feature_flags_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: feature_flags feature_flags_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_flags
    ADD CONSTRAINT feature_flags_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: feature_flags_variants feature_flags_variants_feature_flag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_flags_variants
    ADD CONSTRAINT feature_flags_variants_feature_flag_id_fkey FOREIGN KEY (feature_flag_id) REFERENCES public.feature_flags(feature_flag_id) ON DELETE CASCADE;


--
-- Name: integrations integrations_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integrations
    ADD CONSTRAINT integrations_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: issues issues_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: jira_cloud jira_cloud_users_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jira_cloud
    ADD CONSTRAINT jira_cloud_users_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: jobs jobs_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: metric_series metric_series_metric_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_series
    ADD CONSTRAINT metric_series_metric_id_fkey FOREIGN KEY (metric_id) REFERENCES public.metrics(metric_id) ON DELETE CASCADE;


--
-- Name: metrics metrics_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metrics
    ADD CONSTRAINT metrics_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: metrics metrics_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metrics
    ADD CONSTRAINT metrics_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: oauth_authentication oauth_authentication_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_authentication
    ADD CONSTRAINT oauth_authentication_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: projects_conditions projects_conditions_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects_conditions
    ADD CONSTRAINT projects_conditions_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: saved_searches saved_searches_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.saved_searches
    ADD CONSTRAINT saved_searches_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: saved_searches saved_searches_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.saved_searches
    ADD CONSTRAINT saved_searches_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: searches searches_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.searches
    ADD CONSTRAINT searches_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: searches searches_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.searches
    ADD CONSTRAINT searches_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: session_integrations session_integrations_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_integrations
    ADD CONSTRAINT session_integrations_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: session_integrations session_integrations_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_integrations
    ADD CONSTRAINT session_integrations_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: sessions_feature_flags sessions_feature_flags_condition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions_feature_flags
    ADD CONSTRAINT sessions_feature_flags_condition_id_fkey FOREIGN KEY (condition_id) REFERENCES public.feature_flags_conditions(condition_id) ON DELETE SET NULL;


--
-- Name: sessions_feature_flags sessions_feature_flags_feature_flag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions_feature_flags
    ADD CONSTRAINT sessions_feature_flags_feature_flag_id_fkey FOREIGN KEY (feature_flag_id) REFERENCES public.feature_flags(feature_flag_id) ON DELETE CASCADE;


--
-- Name: sessions_feature_flags sessions_feature_flags_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions_feature_flags
    ADD CONSTRAINT sessions_feature_flags_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: sessions_notes sessions_notes_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions_notes
    ADD CONSTRAINT sessions_notes_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: sessions_notes sessions_notes_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions_notes
    ADD CONSTRAINT sessions_notes_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: sessions_notes sessions_notes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions_notes
    ADD CONSTRAINT sessions_notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: sessions sessions_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: tags tags_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: user_favorite_sessions user_favorite_sessions_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_favorite_sessions
    ADD CONSTRAINT user_favorite_sessions_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: user_favorite_sessions user_favorite_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_favorite_sessions
    ADD CONSTRAINT user_favorite_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_viewed_notifications user_viewed_notifications_notification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_viewed_notifications
    ADD CONSTRAINT user_viewed_notifications_notification_id_fkey FOREIGN KEY (notification_id) REFERENCES public.notifications(notification_id) ON DELETE CASCADE;


--
-- Name: user_viewed_notifications user_viewed_notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_viewed_notifications
    ADD CONSTRAINT user_viewed_notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_viewed_sessions user_viewed_sessions_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_viewed_sessions
    ADD CONSTRAINT user_viewed_sessions_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;


--
-- Name: user_viewed_sessions user_viewed_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_viewed_sessions
    ADD CONSTRAINT user_viewed_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: ut_tests ut_tests_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests
    ADD CONSTRAINT ut_tests_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: ut_tests ut_tests_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests
    ADD CONSTRAINT ut_tests_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- Name: ut_tests_signals ut_tests_signals_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests_signals
    ADD CONSTRAINT ut_tests_signals_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE SET NULL;


--
-- Name: ut_tests_signals ut_tests_signals_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests_signals
    ADD CONSTRAINT ut_tests_signals_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.ut_tests_tasks(task_id) ON DELETE CASCADE;


--
-- Name: ut_tests_signals ut_tests_signals_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests_signals
    ADD CONSTRAINT ut_tests_signals_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.ut_tests(test_id) ON DELETE CASCADE;


--
-- Name: ut_tests_tasks ut_tests_tasks_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests_tasks
    ADD CONSTRAINT ut_tests_tasks_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.ut_tests(test_id) ON DELETE CASCADE;


--
-- Name: ut_tests ut_tests_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ut_tests
    ADD CONSTRAINT ut_tests_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: keys keys_spot_id_fkey; Type: FK CONSTRAINT; Schema: spots; Owner: -
--

ALTER TABLE ONLY spots.keys
    ADD CONSTRAINT keys_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES spots.spots(spot_id) ON DELETE CASCADE;


--
-- Name: spots spots_user_id_fkey; Type: FK CONSTRAINT; Schema: spots; Owner: -
--

ALTER TABLE ONLY spots.spots
    ADD CONSTRAINT spots_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: streams streams_spot_id_fkey; Type: FK CONSTRAINT; Schema: spots; Owner: -
--

ALTER TABLE ONLY spots.streams
    ADD CONSTRAINT streams_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES spots.spots(spot_id) ON DELETE CASCADE;


--
-- Name: tasks tasks_spot_id_fkey; Type: FK CONSTRAINT; Schema: spots; Owner: -
--

ALTER TABLE ONLY spots.tasks
    ADD CONSTRAINT tasks_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES spots.spots(spot_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict xblnN6LEEehgK2xYYyob2T9G9uX6vV4VT6864xFzljdAEj8Pc5PJoMgHkpodULE

