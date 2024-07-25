CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO toyota_macbook;

--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: toyota_macbook
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 32538)
-- Name: tb_m_distributions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_m_distributions (
    distribution_id integer NOT NULL,
    distribution_nm character varying(255) NOT NULL,
    distribution_desc character varying,
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    created_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_by character varying(100),
    deleted_dt timestamp without time zone,
    system_std_used character varying(50)
);


ALTER TABLE public.tb_m_distributions OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 32547)
-- Name: tb_m_lines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_m_lines (
    line_id integer NOT NULL,
    line_nm character varying(100) NOT NULL,
    line_desc character varying(255),
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    created_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_by character varying(100),
    deleted_dt timestamp without time zone
);


ALTER TABLE public.tb_m_lines OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 32497)
-- Name: tb_m_machines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_m_machines (
    machine_id integer NOT NULL,
    machine_nm character varying(255) NOT NULL,
    op_no character varying(100),
    maker character varying(100),
    created_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    deleted_dt timestamp without time zone,
    deleted_by character varying(100),
    line_id integer NOT NULL
);


ALTER TABLE public.tb_m_machines OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 32420)
-- Name: tb_m_systems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_m_systems (
    system_id integer NOT NULL,
    system_type character varying(100) NOT NULL,
    system_value character varying(255) NOT NULL,
    system_desc text,
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    created_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_by character varying(100),
    deleted_dt timestamp without time zone
);


ALTER TABLE public.tb_m_systems OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 32405)
-- Name: tb_m_tool_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_m_tool_types (
    tool_type_id integer NOT NULL,
    tool_type_nm character varying(255) NOT NULL,
    tool_type_desc character varying(255),
    maker character varying(100),
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    created_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_by character varying(100),
    deleted_dt timestamp without time zone,
    tool_material character varying(100),
    ilustrations text,
    std_counter integer
);


ALTER TABLE public.tb_m_tool_types OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 32439)
-- Name: tb_m_tools_type_std; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_m_tools_type_std (
    tool_type_std_id integer NOT NULL,
    tool_type_id integer NOT NULL,
    measuring_portion character varying(255),
    dimension numeric,
    upper_limit numeric,
    lower_limit numeric,
    units character varying(20),
    created_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    is_judgment boolean DEFAULT false,
    deleted_by character varying(100),
    deleted_dt timestamp without time zone,
    system_std_used character varying(50)
);


ALTER TABLE public.tb_m_tools_type_std OWNER TO postgres;

--
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 214
-- Name: COLUMN tb_m_tools_type_std.measuring_portion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_m_tools_type_std.measuring_portion IS 'untuk nilai parameter pengukuran';


--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 214
-- Name: COLUMN tb_m_tools_type_std.is_judgment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_m_tools_type_std.is_judgment IS 'value for paremter check only ok & ng';


--
-- TOC entry 222 (class 1259 OID 32647)
-- Name: tb_m_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_m_users (
    user_id integer NOT NULL,
    noreg character varying(20) NOT NULL,
    fullname character varying(255) NOT NULL,
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    created_dt date DEFAULT now() NOT NULL
);


ALTER TABLE public.tb_m_users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 32646)
-- Name: tb_m_users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_m_users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_m_users_user_id_seq OWNER TO postgres;

--
-- TOC entry 3723 (class 0 OID 0)
-- Dependencies: 221
-- Name: tb_m_users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_m_users_user_id_seq OWNED BY public.tb_m_users.user_id;


--
-- TOC entry 216 (class 1259 OID 32523)
-- Name: tb_r_tool_checks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_r_tool_checks (
    tool_check_id integer NOT NULL,
    measuring_portion character varying(255) NOT NULL,
    value_check character varying(10),
    tool_history_id integer NOT NULL,
    upper_limit double precision,
    lower_limit double precision,
    tool_type_std_id integer NOT NULL,
    system_judgment character varying(2) NOT NULL
);


ALTER TABLE public.tb_r_tool_checks OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 32578)
-- Name: tb_r_tool_problems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_r_tool_problems (
    tool_problem_id integer NOT NULL,
    std_counter integer,
    act_counter integer,
    system_problem character varying(50),
    notes character varying(255) NOT NULL,
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    created_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_by character varying(100),
    deleted_dt timestamp without time zone,
    tool_history_id integer NOT NULL
);


ALTER TABLE public.tb_r_tool_problems OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 32410)
-- Name: tb_r_tools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_r_tools (
    tool_id integer NOT NULL,
    tool_type_id integer NOT NULL,
    tool_qr character varying(10) NOT NULL,
    created_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying NOT NULL,
    deleted_dt timestamp without time zone,
    deleted_by character varying(100),
    std_counter integer DEFAULT 0 NOT NULL,
    tool_no character varying(100) NOT NULL,
    tool_verify_qr character varying(10)
);


ALTER TABLE public.tb_r_tools OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 32429)
-- Name: tb_r_tools_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_r_tools_histories (
    tool_history_id integer NOT NULL,
    system_activity character varying(20) NOT NULL,
    tool_id integer NOT NULL,
    pic_check character varying(255) NOT NULL,
    created_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    distribution_id integer NOT NULL,
    machine_id integer,
    act_counter bigint,
    reason character varying(255),
    system_problem character varying(50)
);


ALTER TABLE public.tb_r_tools_histories OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 32415)
-- Name: tb_t_tools_positions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_t_tools_positions (
    tool_position_id integer NOT NULL,
    tool_id integer NOT NULL,
    act_counter integer,
    is_scrab boolean DEFAULT false NOT NULL,
    regrinding_count integer,
    distribution_id integer NOT NULL,
    machine_id integer,
    system_problem character varying(100)
);


ALTER TABLE public.tb_t_tools_positions OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 32598)
-- Name: v_tools_histories; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_tools_histories AS
 SELECT trth.tool_history_id,
    to_char(trth.created_dt, 'YYYY-MM-DD'::text) AS date_check,
    trth.system_activity,
    trt.tool_no,
    tmtt.tool_type_desc,
    tmd.distribution_nm,
    tmtt.std_counter,
    trth.act_counter,
    trth.pic_check,
    trth.system_problem,
    trth.reason,
    trt.tool_qr
   FROM (((public.tb_r_tools_histories trth
     JOIN public.tb_r_tools trt ON ((trt.tool_id = trth.tool_id)))
     JOIN public.tb_m_tool_types tmtt ON ((tmtt.tool_type_id = trt.tool_type_id)))
     JOIN public.tb_m_distributions tmd ON ((tmd.distribution_id = trth.distribution_id)));


ALTER TABLE public.v_tools_histories OWNER TO postgres;

--
-- TOC entry 3520 (class 2604 OID 32650)
-- Name: tb_m_users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_users ALTER COLUMN user_id SET DEFAULT nextval('public.tb_m_users_user_id_seq'::regclass);


--
-- TOC entry 3709 (class 0 OID 32538)
-- Dependencies: 217
-- Data for Name: tb_m_distributions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_m_distributions VALUES (0, 'Repair in Tool Regrinding', 'Tool at Tool Regrinding', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (1, 'Ready Delivery to Clean Room', 'Tool Delivery To GEL', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (2, 'Setting in Clean Room', 'Clean Room Poisition', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (1000, 'SCRAB', 'Tool Already not in used', 'SYSTEM', '2024-07-15 10:52:50.948105', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (15, 'Ready to Tool Regrinding', 'Tool Delivery To Tool Regrinding', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, 'CR');
INSERT INTO public.tb_m_distributions VALUES (7, 'In Machine Cam Shaft', 'Tool at machine CAM Line', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (8, 'In Machine Cylinder Head', 'Tool at machine CH Line', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (9, 'In Machine Clynder Block', 'Tool at machine CB Line', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (10, 'In Machine Crank ', 'Tool at machine CR Line', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (11, 'Ready to Cam Shaft', 'Tool Delivery To CAM', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, 'CR');
INSERT INTO public.tb_m_distributions VALUES (12, 'Ready to Cylinder Head', 'Tool Delivery To CH', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, 'CR');
INSERT INTO public.tb_m_distributions VALUES (13, 'Ready to Clynder Block', 'Tool Delivery To CB', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, 'CR');
INSERT INTO public.tb_m_distributions VALUES (14, 'Ready to Crank Shaft', 'Tool Delivery To CR', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, 'CR');
INSERT INTO public.tb_m_distributions VALUES (6, 'Storage Crank Shaft', 'Tool at CR Line', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (5, 'Storage Cylinder Block', 'Tool at CB Line', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (4, 'Storage Cylinder Head', 'Tool at CH Line', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);
INSERT INTO public.tb_m_distributions VALUES (3, 'Storage Cam Shaft', 'Tool at CAM Line', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL, NULL);


--
-- TOC entry 3710 (class 0 OID 32547)
-- Dependencies: 218
-- Data for Name: tb_m_lines; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_m_lines VALUES (0, 'Cam Shaft', 'Cam Shaft machining process', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL);
INSERT INTO public.tb_m_lines VALUES (1, 'Crank Shaft', 'Crank Shaft Machining process', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL);
INSERT INTO public.tb_m_lines VALUES (2, 'Cylinder Head', 'Cylinder Head Machining process', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL);
INSERT INTO public.tb_m_lines VALUES (3, 'Cylinder Block', 'Cylinder Block Machining process', 'Fajar Tri Cahyono', '2024-07-13 00:00:00', NULL, NULL);


--
-- TOC entry 3707 (class 0 OID 32497)
-- Dependencies: 215
-- Data for Name: tb_m_machines; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_m_machines VALUES (0, 'IMGR-0012', '70A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (1, 'IMGR-0011', '60A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (2, 'IMGR-0010', '50B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (3, 'IMGR-0009', '50A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (4, 'IMSP-0112', '30C', 'YASUNAGA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (5, 'IMSP-0111', '30B', 'YASUNAGA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (6, 'IMSP-0110', '30A', 'YASUNAGA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (7, 'IMSP-0109', '10A', 'YASUNAGA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (8, 'IMTS-0026', '100B', 'TOSEI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (9, 'IMGR-0016', '70B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (10, 'IMGR-0015', '60B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (11, 'IMGR-0014', '50D', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (12, 'IMGR-0013', '50C', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (13, 'IMSP-0090', '30D', 'YASUNAGA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (14, 'IMSP-0091', '30E', 'YASUNAGA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (15, 'IMSP-0092', '30F', 'YASUNAGA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (16, 'IMSP-0089', '10B', 'YASUNAGA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0);
INSERT INTO public.tb_m_machines VALUES (17, 'IMSP-0010', '100A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (18, 'IMSP-0009', '90A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (19, 'IMSP-0008', '80A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (20, 'IMSP-0007', '70A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (21, 'IMSP-0006', '60A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (22, 'IMSP-0005', '50A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (23, 'IMSP-0004', '40A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (24, 'IMSP-0003', '30A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (25, 'IMSP-0002', '20A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (26, 'IMSP-0001', '10A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (27, 'IMSP-0020', '100B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (28, 'IMSP-0019', '90B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (29, 'IMSP-0018', '80B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (30, 'IMSP-0017', '70B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (31, 'IMSP-0016', '60B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (32, 'IMSP-0015', '50B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (33, 'IMSP-0014', '40B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (34, 'IMSP-0013', '30B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (35, 'IMSP-0012', '20B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (36, 'IMSP-0011', '10B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (37, 'IMSP-0026', '180A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (38, 'IMSP-0025', '170A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (39, 'IMSP-0024', '160A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (40, 'IMSP-0023', '150A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (41, 'IMSP-0022', '140A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (42, 'IMSP-0021', '135A', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (43, 'IMSP-0052', '180B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (44, 'IMSP-0051', '170B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (45, 'IMSP-0050', '160B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (46, 'IMSP-0049', '150B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (47, 'IMSP-0048', '140B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (48, 'IMSP-0047', '135B', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (49, 'IMSP-0036', '100C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (50, 'IMSP-0035', '90C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (51, 'IMSP-0034', '80C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (52, 'IMSP-0033', '70C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (53, 'IMSP-0032', '60C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (54, 'IMSP-0031', '50C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (55, 'IMSP-0030', '40C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (56, 'IMSP-0029', '30C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (57, 'IMSP-0028', '20C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (58, 'IMSP-0027', '10C', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (59, 'IMSP-0046', '100D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (60, 'IMSP-0045', '90D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (61, 'IMSP-0044', '80D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (62, 'IMSP-0043', '70D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (63, 'IMSP-0042', '60D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (64, 'IMSP-0041', '50D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (65, 'IMSP-0040', '40D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (66, 'IMSP-0039', '30D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (67, 'IMSP-0038', '20D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (68, 'IMSP-0037', '10D', 'NTC', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2);
INSERT INTO public.tb_m_machines VALUES (69, 'IMSP-0061', '100A', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (70, 'IMSP-0060', '90A', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (71, 'IMSP-0059', '80A', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (72, 'IMSP-0058', '70A', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (73, 'IMSP-0057', '50A', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (74, 'IMSP-0056', '40A', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (75, 'IMSP-0055', '30A', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (76, 'IMSP-0054', '20A', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (77, 'IMSP-0053', '10A', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (78, 'IMSP-0070', '100B', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (79, 'IMSP-0069', '90B', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (80, 'IMSP-0068', '80B', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (81, 'IMSP-0067', '70B', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (82, 'IMSP-0066', '50B', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (83, 'IMSP-0065', '40B', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (84, 'IMSP-0064', '30B', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (85, 'IMSP-0063', '20B', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (86, 'IMSP-0062', '10B', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (87, 'IMMM-0024', '210A', 'CHITA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (88, 'IMGR-0001', '200A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (89, 'IMMM-0023', '182A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (90, 'IMMM-0022', '180B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (91, 'IMMM-0021', '180A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (92, 'IMBR-0001', '160A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (93, 'IMSP-0079', '100C', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (94, 'IMSP-0078', '90C', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (95, 'IMSP-0077', '80C', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (96, 'IMSP-0076', '70C', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (97, 'IMSP-0075', '50C', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (98, 'IMSP-0074', '40C', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (99, 'IMSP-0073', '30C', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (100, 'IMSP-0072', '20C', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (101, 'IMSP-0071', '10C', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (102, 'Gondola CD', '-', 'Kaizen Group', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (103, 'IMMM-0028', '210B', 'CHITA', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (104, 'IMGR-0002', '200B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (105, 'IMMM-0027', '182B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (106, 'IMMM-0026', '181B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (107, 'IMMM-0025', '180B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (108, 'IMBR-0002', '160B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (109, 'IMSP-0088', '100D', 'Yasunaga', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (110, 'IMSP-0087', '90D', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (111, 'IMSP-0086', '80D', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (112, 'IMSP-0085', '70D', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (113, 'IMSP-0084', '50D', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (114, 'IMSP-0083', '40D', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (115, 'IMSP-0082', '30D', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (116, 'IMSP-0081', '20D', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (117, 'IMSP-0080', '10D', 'DMG Mori', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3);
INSERT INTO public.tb_m_machines VALUES (118, 'IMSP-0107', '800A', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (119, 'IMGR-0007', '180A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (120, 'IMGR-0005', '170A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (121, 'IMGR-0003', '150A', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (122, 'IMSP-0105', '110A', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (123, 'IMSP-0102', '105A', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (124, 'IMSP-0101', '100A', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (125, 'IMSP-0098', '40A', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (126, 'IMSP-0097', '30A', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (127, 'IMSP-0095', '10A', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (128, 'IMCK-0001 1', '-', 'SHINMEI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (129, 'IMSP-0108', '800B', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (130, 'IMGR-0008', '180B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (131, 'IMGR-0006', '170B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (132, 'IMGR-0004', '150B', 'JTEKT', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (133, 'IMSP-0106', '110B', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (134, 'IMSP-0104', '105B', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (135, 'IMSP-0103', '100B', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (136, 'IMSP-0100', '40A', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (137, 'IMSP-0099', '30B', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);
INSERT INTO public.tb_m_machines VALUES (138, 'IMSP-0096', '10B', 'FUJIKOSHI', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1);


--
-- TOC entry 3704 (class 0 OID 32420)
-- Dependencies: 212
-- Data for Name: tb_m_systems; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_m_systems VALUES (1, 'SYSTEM_JUDGMENT', 'OK', 'Tool OK', 'SYSTEM', '2024-07-15 08:43:31.796693', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (2, 'SYSTEM_JUDGMENT', 'NG', 'Tool NG', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (3, 'SYSTEM_LINE', 'Cam Shaft', 'Cam Shaft', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (4, 'SYSTEM_LINE', 'Crank Shaft', 'Crank Shaft', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (5, 'SYSTEM_LINE', 'Cylinder Block', 'Cylinder Block', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (6, 'SYSTEM_LINE', 'Cylinder Head', 'Cylinder Head', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (9, 'SYSTEM_ACTIVITY', 'IN USED', 'Digunakan di mesin', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (10, 'SYSTEM_ACTIVITY', 'SETTING', 'Di setting GEL', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (11, 'SYSTEM_ACTIVITY', 'REGRINDING', 'Regrinding Tool', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (12, 'SYSTEM_ACTIVITY', 'SCRAB', 'Tool NG', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (13, 'SYSTEM_ACTIVITY', 'NEW', 'Tool Baru', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (14, 'SYSTEM_ACTIVITY', 'USED', 'Tool Sudah digunakan', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (7, 'SYSTEM_STD_USED', 'CR', 'Standard using in Clean Room', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (8, 'SYSTEM_STD_USED', 'TR', 'Standard using in Tool Regrinding', 'SYSTEM', '2024-07-15 08:43:31.799869', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (15, 'SYSTEM_ACTIVITY', 'TRANSFER', 'Tool Akan Di kirim', 'SYSTEM', '2024-07-15 11:33:52.735662', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (16, 'SYSTEM_PROBLEM', 'PATAH', 'PATAH', 'SYSTEM', '2024-07-15 19:18:39.074609', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (17, 'SYSTEM_PROBLEM', 'TUMPUL', 'TUMPUL', 'SYSTEM', '2024-07-15 19:18:39.074609', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (18, 'SYSTEM_PROBLEM', 'INTERNAL COOLANT MAMPET', 'INTERNAL COOLANT MAMPET', 'SYSTEM', '2024-07-15 19:18:39.074609', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (19, 'SYSTEM_PROBLEM', 'KIRIKO NEMPEL', 'KIRIKO NEMPEL', 'SYSTEM', '2024-07-15 19:18:39.074609', NULL, NULL);
INSERT INTO public.tb_m_systems VALUES (20, 'SYSTEM_PROBLEM', 'LAIN LAIN', 'LAIN LAIN', 'SYSTEM', '2024-07-15 19:27:13.458828', NULL, NULL);


--
-- TOC entry 3701 (class 0 OID 32405)
-- Dependencies: 209
-- Data for Name: tb_m_tool_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_m_tool_types VALUES (1, 'DSDW - 08466TIN', 'Drilling Front End', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-08466TIN.jpg', 650);
INSERT INTO public.tb_m_tool_types VALUES (2, ' DSSW - 12258 TIN', 'Drilling FR & RR Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-12258TIN.jpg', 1500);
INSERT INTO public.tb_m_tool_types VALUES (3, ' MC - 1041', 'Drilling Oil Hole', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'MC-1041.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (4, 'BC - 2224', 'Rought Drilling Valve Seat, Press Fitting', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'BC-2224 NR.jpg', 500);
INSERT INTO public.tb_m_tool_types VALUES (5, 'CD-989', 'Centering Front', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'CD-989.jpg', 1800);
INSERT INTO public.tb_m_tool_types VALUES (6, 'DGN - 0880', 'Drilling HLA Oil Holes, Front Face', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DGN-0880 NR.jpg', 300);
INSERT INTO public.tb_m_tool_types VALUES (7, 'DSDW - 0340', 'Drilling Chain Cover Assembly, Knock Pin Press', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-0340 NR.jpg', 1500);
INSERT INTO public.tb_m_tool_types VALUES (8, 'DSDW - 05177TIN', 'Drillling Front, Knock Hole', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-05177TIN.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (9, 'DSDW - 05260', 'Drilling Piston Oil Jet Mounting Holes', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-05260.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (10, 'DSDW - 05261', 'Drilling & Chamfering, Earth Mounting', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-05261 NR.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (11, 'DSDW - 06465', 'Drilling Oil Pant Mounting Hole Lower Face', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-06465 NR.jpg', 1500);
INSERT INTO public.tb_m_tool_types VALUES (12, 'DSDW - 06466', 'Drilling Chain Cover Mounting Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-06466 b.jpg', 1700);
INSERT INTO public.tb_m_tool_types VALUES (13, 'DSDW - 06467', 'Drilling & Chamfering, Earth Mounting', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-06467 NR.jpg', 20000);
INSERT INTO public.tb_m_tool_types VALUES (14, 'DSDW - 07148', 'Drilling Oil Pant Assemby Knock Pin Press', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-07148 NR.jpg', 7500);
INSERT INTO public.tb_m_tool_types VALUES (15, 'DSDW - 07151', 'Drilling HLA Mounting Holes,Exhause Side', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-07151 NR.JPG', 10000);
INSERT INTO public.tb_m_tool_types VALUES (16, 'DSDW - 08462', 'Drilling Chain Cover Mounting Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-08462.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (17, 'DSDW - 08463', 'Drilling Piston Oil Jet Insert', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-08463 b.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (18, 'DSDW - 08464', 'Drilling Oil Preasure Switch Mounting Hole', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-08464 b.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (19, 'DSDW - 08465', 'Drilling & Chamfering, Earth Mounting', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-08465 NR.jpg', 4000);
INSERT INTO public.tb_m_tool_types VALUES (20, 'DSDW - 09271 DIC', NULL, NULL, 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'NO PICTURE.jpg', NULL);
INSERT INTO public.tb_m_tool_types VALUES (21, 'DSDW - 09272   DIC', 'Drilling Head,Mounting Hole, Upper Face', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'DSDW-09271DIC b.jpg', 1000);
INSERT INTO public.tb_m_tool_types VALUES (22, 'DSDW - 09273 DIC', 'Drilling Chain Slipeer MOUTING', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'DSDW-09273 NR.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (23, 'DSDW - 09274 DIC', 'Drilling Crank Cap Mounting Hole (With Conroud)', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'DSDW-09274.tif', 5000);
INSERT INTO public.tb_m_tool_types VALUES (24, 'DSDW - 10399', 'Drilling Oil Drop Hole, Upper Face', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-10399 NR.JPG', 10000);
INSERT INTO public.tb_m_tool_types VALUES (25, 'DSDW - 10400', 'Drilling Transmition Mounting Holes Rear', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-10400 NR.jpg', 15000);
INSERT INTO public.tb_m_tool_types VALUES (26, 'DSDW - 10401', 'Drilling & Chamfering, Earth Mounting', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-10401 NR.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (27, 'DSDW - 11235', 'Drilling & Chamfering, Earth Mounting', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-11235 NR.jpg', 20000);
INSERT INTO public.tb_m_tool_types VALUES (28, 'DSDW - 11236', 'Drilling HLA Mounting Holes,Exhause Side', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-11236 NR.jpg', 600);
INSERT INTO public.tb_m_tool_types VALUES (29, 'DSDW - 11241', 'Drilling HLA Mounting Holes,Exhause Side', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'NO PICTURE.jpg', 600);
INSERT INTO public.tb_m_tool_types VALUES (30, 'DSDW - 1693', 'Drilling & Chamfering, Earth Mounting', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-1693NR.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (31, 'DSS - 1157', 'Breaking Through,Casting Film Knock hole', 'FUJIKOSHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'HSS', 'DSS-1157 NR.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (32, 'DSSW - 0381', NULL, NULL, 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-0381.jpg', NULL);
INSERT INTO public.tb_m_tool_types VALUES (33, 'DSSW - 04120', 'Drilling & Chamfering, Earth Mounting', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-04120A NR.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (34, 'DSSW-0487-00031', 'Drilling Oil Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-0487TIN.jpg', 150);
INSERT INTO public.tb_m_tool_types VALUES (35, 'DSSW - 05114 TIN', 'Drilling Oil Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-05114 TIN.jpg', 150);
INSERT INTO public.tb_m_tool_types VALUES (36, 'DSSW - 06301', 'Drilling Jurnal Oil Filling Holes Lower Face', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-06301 b.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (37, 'DSSW - 08270', 'Drilling HLA Oil Holes, Front Face', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-08270 NR.jpg', 2500);
INSERT INTO public.tb_m_tool_types VALUES (38, 'DSSW - 08271', 'Drilling HLA Oil Holes, Front Face', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-08271 NR.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (39, 'DSSW - 08291', 'Drilling Head Oil Filling Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-08291NR.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (40, 'DSSW - 08292 TIN', 'Drilling FR & RR Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-08292TIN.jpg', 400);
INSERT INTO public.tb_m_tool_types VALUES (41, 'DSSW - 09131', 'Rought Drilling Valve Seat, Press Fitting', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-09131 NR.jpg', 600);
INSERT INTO public.tb_m_tool_types VALUES (42, 'DSSW - 09132 TIN', 'Drilling Balance Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-09132TIN.jpg', 1200);
INSERT INTO public.tb_m_tool_types VALUES (43, 'DSSW - 11125', 'Rought Milling Lower Face', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-11125 NR.jpg', 2000);
INSERT INTO public.tb_m_tool_types VALUES (44, 'MC - 1038', 'Rouht Milling Upper Face', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'MC-1038 NR.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (45, 'MC - 1039', 'Machinning,M/C Identification', 'OSG', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'MC-1039 NR.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (46, 'MC - 1040', 'Chamfering Axial Direction VVT Oil Hole', 'OSG', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'MC-1040 NR.jpg', 2500);
INSERT INTO public.tb_m_tool_types VALUES (47, 'MC - 931', 'Drilling FR & RR Hole', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'MC-931.jpg', 1000);
INSERT INTO public.tb_m_tool_types VALUES (48, 'MC - 952', 'Drilling FR & RR Hole', 'OKAYA', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'MC-952.jpg', 1500);
INSERT INTO public.tb_m_tool_types VALUES (49, 'RSW - 01678', 'Drilling & Chamfering, Earth Mounting', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW-1678 NR.jpg', 4000);
INSERT INTO public.tb_m_tool_types VALUES (50, 'RSW - 04104', 'Reaming Chain Cover Assemby Knck Holes', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW - 04104.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (51, 'RSW - 05006', 'Finishing Intake Valve Seat', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW-5006 NR.jpg', 250);
INSERT INTO public.tb_m_tool_types VALUES (52, 'RSW - 08169', 'Drilling HLA Mounting Holes,Exhause Side', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW-08169 NR.jpg', 4000);
INSERT INTO public.tb_m_tool_types VALUES (53, 'RSW - 08170', 'Reaming, Oil Pant Assembly Knock Hole', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW-08170.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (54, 'RSW - 08177', 'Reaming, Oil Pant Assembly Knock Hole', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW - 08177.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (55, 'RSW - 09130', 'Reaming PistonOil Jet Insert Holes, Lower Face', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW - 09130.jpg', 1500);
INSERT INTO public.tb_m_tool_types VALUES (56, 'RSW - 10249', 'Rought Drilling Valve Seat, Press Fitting', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW-10249 DIC NR.jpg', 7000);
INSERT INTO public.tb_m_tool_types VALUES (57, 'RSW - 10250 DIC', 'Rought Drilling Valve Seat, Press Fitting', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW-10250DIC NR.jpg', 7000);
INSERT INTO public.tb_m_tool_types VALUES (58, 'RSW - 10279', 'Finish Boring Stator Mounting Hole', 'NT TOOL', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW - 10279.jpg', 2000);
INSERT INTO public.tb_m_tool_types VALUES (59, 'RSW - 11178 DIC', 'Finish Reaming Head Mounting Holes Upper', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'No Picture.png', 25000);
INSERT INTO public.tb_m_tool_types VALUES (60, 'RSW - 11180', 'Rouht Milling Upper Face', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW-11180 NR.jpg', 2000);
INSERT INTO public.tb_m_tool_types VALUES (61, 'RSW - 13004 DIC', 'Reaming MachinningDatum Knoc', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'No Picture.png', 50000);
INSERT INTO public.tb_m_tool_types VALUES (62, 'RSW - 13005 DIC', 'Debring Head Mounting Face', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'RSW-13005.tif', 75000);
INSERT INTO public.tb_m_tool_types VALUES (63, 'TP - 10167 TIN', 'Tapping, Front End', 'OSG', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'TP-10167TIN.jpg', 250);
INSERT INTO public.tb_m_tool_types VALUES (64, 'TP - 1483', 'Drilling FR & RR Hole', 'OSG', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'TP-1483.jpg', 300);
INSERT INTO public.tb_m_tool_types VALUES (65, 'ZC - 0301', 'Drilling guide hole water Holes', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'ZC-0301 NR.jpg', 1000);
INSERT INTO public.tb_m_tool_types VALUES (66, 'ZC - 0603 CB', 'Drilling Guide Hole Jurnal Oil Filling Holes', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'ZC-0603 NR b.jpg', 2500);
INSERT INTO public.tb_m_tool_types VALUES (67, 'ZC - 1012', 'Drilling HLA Mounting Holes,Exhause Side', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'ZC-1012 NR.jpg', 250);
INSERT INTO public.tb_m_tool_types VALUES (68, 'DSSW - 04121', 'DRILLING AXIAL DIRECTION VVT OIL HOLE', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-04121TIN NR.jpg', 220);
INSERT INTO public.tb_m_tool_types VALUES (69, 'CD - 1001TIN', 'Centre Hole Sproket Crank Shaft', 'OKAYA', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'CD-1001 NR.jpg', 1200);
INSERT INTO public.tb_m_tool_types VALUES (70, 'DSSW - 11124', 'Driiling Fuel delivery Pipe Mounting Hole Intake faceou', 'NT TOOL', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, NULL, 'No Picture.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (71, 'DSSW-14011 NT', NULL, 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'HSS', 'DSSW-14011 NR.jpg', NULL);
INSERT INTO public.tb_m_tool_types VALUES (72, 'DSSW-0487', NULL, 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', '1678856655061.jpg', 150);
INSERT INTO public.tb_m_tool_types VALUES (73, 'TP - 010171', NULL, 'OSG', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'TP-10171.jpg', 150);
INSERT INTO public.tb_m_tool_types VALUES (74, 'DSSW - 11126 TIN ', NULL, 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-11126 NR.jpg', 300);
INSERT INTO public.tb_m_tool_types VALUES (75, 'DSSW - 11126 TIN', NULL, 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-11126 NR.jpg', NULL);
INSERT INTO public.tb_m_tool_types VALUES (76, 'EC - 0544 TIN', 'Drilling Oil Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'EC-0544TIN.jpg', 300);
INSERT INTO public.tb_m_tool_types VALUES (77, 'TP - 10171 TIN', 'Tap Hole Fly Wheel', 'OSG', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'HSS', 'TP-10171.jpg', 150);
INSERT INTO public.tb_m_tool_types VALUES (78, 'TEST', 'Tap Hole Fly Wheels', 'OSG', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'HSS', 'TP-10171.jpg', 150);
INSERT INTO public.tb_m_tool_types VALUES (79, 'DSDW - 05177 TIN', 'Drillling Front, Knock Hole', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-05177TIN.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (80, 'DSSW - 04120A', 'Drilling Chain Tansioner Oil Hole', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-04120A.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (81, 'DSSW - 04120A ', 'Drilling Chain Tansioner Oil Hole', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-04120A.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (82, 'RSW - 12128', 'Finish Reaming Dadum Knock Holes', 'NT TOOL', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'RSW - 12128.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (83, 'RSW - 12142', 'Finish Reaming HLA, Mounting HLA', 'NT TOOL', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'RSW - 12129 .jpg', 1500);
INSERT INTO public.tb_m_tool_types VALUES (84, 'RSW - 2428', NULL, 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'RSW - 2428 DIC.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (85, 'DSDW - 2234', 'OH Step SF Drill', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW - 2234.jpg', 2000);
INSERT INTO public.tb_m_tool_types VALUES (86, 'DSSW - 10297', 'Drilling WT Oil Supply By-Pas Hole', 'NT TOOL', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-10297.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (87, 'EZDL - 110', NULL, 'DIJET', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'HSS', 'EZDL-110.jpg', NULL);
INSERT INTO public.tb_m_tool_types VALUES (88, 'DSSW - 12256', 'Rought Milling Lower Face', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-12256 NR.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (89, 'DSSW - 14010', 'Drilling Oil Return Holes, Lower Face', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW - 14010.jpg', 2000);
INSERT INTO public.tb_m_tool_types VALUES (90, 'DSSW - 06311', 'Drilling Cam Journal, Oil Supply Hole', 'OSG', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW - 06311.jpg', 2000);
INSERT INTO public.tb_m_tool_types VALUES (91, 'DSDW - 06465 CH OP 10', 'Drilling & Champering Cam Housing', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW - 06465.jpg', 1000);
INSERT INTO public.tb_m_tool_types VALUES (92, 'DSDW - 06465 CH OP 70', 'Drilling Intake Manifold Mounting Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-06465 NR.jpg', 1200);
INSERT INTO public.tb_m_tool_types VALUES (93, ' DSDW 10458', NULL, 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW - 10458.jpg', 2500);
INSERT INTO public.tb_m_tool_types VALUES (94, 'DSDW - 10403', 'Drilling Spark Plug Mounting Holes', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW - 10403.jpg', 1500);
INSERT INTO public.tb_m_tool_types VALUES (95, 'DSS - 0550', 'Drilling Champer Oil Hole', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'HSS', 'NO PICTURE.jpg', 500);
INSERT INTO public.tb_m_tool_types VALUES (96, 'ZC - 1507', 'Spot Facing Injector Hole Seat Faces,Intake Faces', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'ZC - 1507.jpg', 3000);
INSERT INTO public.tb_m_tool_types VALUES (97, 'ZC - 1917', 'Drilling Spark Plug Mounting Holes', 'TUNGALOY', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'ZC-1917.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (98, 'DSDW - 11235 CB (OP-70)', 'Drilling Startor Motor Mounting Holes, Rear face', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSDW-11235 NR.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (99, 'MC - 1038 CB (OP-70)', 'Drilling & Chamfering, Earth Mounting', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'MC-1038 NR.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (100, 'DSSW - 12256 CB', 'Drilling Head Assembly Knock Pin Finish', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-12256 NR.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (101, 'DSSW - 12257', 'Drilling Main Hole, Lower Face', 'MITSUBISHI', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-12257 NR.jpg', 10000);
INSERT INTO public.tb_m_tool_types VALUES (102, 'DSSW - 08292', 'Drilling Mounting Holes Fly Wheels', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-08292TIN.jpg', 400);
INSERT INTO public.tb_m_tool_types VALUES (103, 'DSSW - 06466', 'Drilling oilpan mounting holes', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'OP080-08.pdf', 6000);
INSERT INTO public.tb_m_tool_types VALUES (104, 'MC - 1041', NULL, 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'MC-931.jpg', 5000);
INSERT INTO public.tb_m_tool_types VALUES (105, 'DSDW - 064650', 'DRILLING OILPAN MOUNTING HOLES', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'OP080-07.pdf', 1700);
INSERT INTO public.tb_m_tool_types VALUES (106, 'CD - 1001', 'CENTER DRILL', 'OKABE', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'HSS', 'MC-952.jpg', 1200);
INSERT INTO public.tb_m_tool_types VALUES (107, 'DSSW - 0487TIN', 'Drilling Oil Hole', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-05114 NR.jpg', 250);
INSERT INTO public.tb_m_tool_types VALUES (108, 'DSDW - 06466 ', 'DRILLING OILPAN MOUNTING HOLE DEPTH 27', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'OP080-08.pdf', 6000);
INSERT INTO public.tb_m_tool_types VALUES (109, 'RSW - 10250', 'Finish Reaming VALVE SEATS', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'OP100-04.pdf', 7000);
INSERT INTO public.tb_m_tool_types VALUES (110, 'DSSW - 12258 TIN8', 'DRILING', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-14011TIN.jpg', 1500);
INSERT INTO public.tb_m_tool_types VALUES (111, 'DSDW - 112360', 'DRILLING HLA MOUNTING HOLES EXHOUST SIDE', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'OP080-01-2.pdf', 600);
INSERT INTO public.tb_m_tool_types VALUES (112, 'DSSW - 14011', 'DRILLING FRONT HOLE', 'SUMITOMO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'CARBIDE', 'DSSW-14011TIN.jpg', 2000);
INSERT INTO public.tb_m_tool_types VALUES (113, 'RSW - 13006DIC', 'Finish Reaming Dadum Knock Holes', 'FUJISEIKO', 'Fajar Tri Cahyono', '2024-07-12 00:00:00', NULL, NULL, 'Diamond', 'OP020-06.pdf', 10000);


--
-- TOC entry 3706 (class 0 OID 32439)
-- Dependencies: 214
-- Data for Name: tb_m_tools_type_std; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_m_tools_type_std VALUES (174, 7, 'Ketinggian Tool', 1315, 1318, 1312, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (175, 7, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (176, 7, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (177, 9, 'Ketinggian Tool', 18662, 18692, 18632, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (178, 9, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (179, 9, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (180, 11, 'Ketinggian Tool', 17196, 17226, 17166, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (181, 11, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (182, 11, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (183, 12, 'Ketinggian Tool', 17202, 17232, 17172, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (184, 12, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (185, 12, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (186, 14, 'Ketinggian Tool', 142, 1423, 1417, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (187, 14, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (188, 14, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (189, 16, 'Ketinggian Tool', 17235, 17265, 17205, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (190, 16, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (191, 16, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (192, 17, 'Ketinggian Tool', 20742, 20772, 20712, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (193, 17, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (194, 17, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (195, 18, 'Ketinggian Tool', 16231, 16261, 16201, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (196, 18, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (197, 18, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (198, 20, 'Ketinggian Tool', 22948, 22978, 22918, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (199, 20, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (200, 20, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (201, 21, 'Ketinggian Tool', 22948, 22978, 22918, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (202, 21, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (203, 21, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (204, 23, 'Ketinggian Tool', 20296, 20326, 20266, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (205, 23, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (206, 23, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (207, 24, 'Ketinggian Tool', 16166, 16196, 16136, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (208, 24, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (209, 24, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (210, 25, 'Ketinggian Tool', 17283, 17313, 17253, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (211, 25, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (212, 25, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (213, 27, 'Ketinggian Tool', 17299, 17329, 17269, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (214, 27, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (215, 27, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (216, 31, 'Ketinggian Tool', 3083, 3086, 308, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (217, 31, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (218, 31, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (219, 32, 'Ketinggian Tool', 1607, 161, 1604, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (220, 32, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (221, 32, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (222, 36, 'Ketinggian Tool', 241, 2413, 2407, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (223, 36, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (224, 36, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (225, 39, 'Ketinggian Tool', 2415, 2418, 2412, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (226, 39, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (227, 39, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (228, 88, 'Ketinggian Tool', 1776, 1779, 1773, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (229, 88, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (230, 88, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (231, 101, 'Ketinggian Tool', 2475, 2478, 2472, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (232, 101, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (233, 101, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (234, 44, 'Ketinggian Tool', 17719, 17749, 17689, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (235, 44, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (236, 50, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (237, 54, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (238, 55, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (239, 58, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (240, 59, 'Ketinggian Tool', 19496, 19526, 19466, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (241, 59, 'Runout', 10, 20, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (242, 59, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (243, 61, 'Ketinggian Tool', 15487, 15517, 15457, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (244, 61, 'Runout', 10, 20, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (245, 61, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (246, 62, 'Ketinggian Tool', 1464, 1467, 1461, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (247, 62, 'Runout', 10, 20, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (248, 62, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (249, 63, 'Ketinggian Tool', 160, 1603, 1597, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (250, 63, 'Runout', 25, 50, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (251, 63, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (252, 65, 'Ketinggian Tool', 1453, 1456, 145, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (253, 65, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (254, 4, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (255, 6, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (256, 10, 'Ketinggian Tool', 15662, 15692, 15632, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (257, 10, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (258, 10, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (259, 11, 'Ketinggian Tool', 17196, 17226, 17166, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (260, 11, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (261, 11, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (262, 13, 'Ketinggian Tool', 16699, 16729, 16669, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (263, 13, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (264, 13, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (265, 15, 'Ketinggian Tool', 15756, 15786, 15726, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (266, 15, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (267, 15, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (268, 19, 'Ketinggian Tool', 17235, 17265, 17205, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (269, 19, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (270, 19, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (271, 26, 'Ketinggian Tool', 16281, 16311, 16251, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (272, 26, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (273, 26, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (274, 94, 'Ketinggian Tool', 17281, 17311, 17251, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (275, 94, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (276, 94, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (277, 27, 'Ketinggian Tool', 17298, 17328, 17268, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (278, 27, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (279, 27, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (280, 28, 'Ketinggian Tool', 1889, 1892, 1886, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (281, 28, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (282, 28, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (283, 29, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (284, 30, 'Ketinggian Tool', 19375, 19405, 19345, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (285, 30, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (286, 30, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (287, 85, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (288, 33, 'Ketinggian Tool', 1658, 1661, 1655, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (289, 33, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (290, 33, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (291, 90, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (22, 74, 'point angle', 135, 138, 132, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (23, 74, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (24, 2, 'Point angle', 140, 143, 137, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (25, 2, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (26, 112, 'point angle', 140, 143, 137, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (27, 112, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (28, 76, 'gash angle', 40, 50, 30, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (29, 76, 'gash offset', 0, 0.03, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (30, 45, 'point angle', 90, 92, 88, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (31, 45, 'run out', 0.05, 0.05, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (32, 46, 'point angle', 90, 92, 88, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (33, 46, 'run out', 0.05, 0.05, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (34, 3, 'chamfer angle', 120, 150, 90, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (35, 3, 'margin width', 0.5, 0.7, 0.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (36, 3, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (37, 47, 'chamfer angle', 45, 47, 43, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (38, 47, 'margin width', 0.5, 0.5, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (39, 48, 'chamfer angle', 60, 90, 30, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (40, 48, 'margin width', 0.3, 0.5, 0.1, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (41, 48, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (42, 64, 'run out', 0.04, 0.04, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (43, 66, 'gash angle', 40, 50, 30, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (44, 66, 'gash offset', 0.1, 0.35, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (45, 66, 'run out', 0.03, 0.03, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (46, 7, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (47, 7, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (48, 7, 'step length', 10.5, 10.7, 10.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (49, 9, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (50, 9, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (51, 9, 'step length', 16.5, 16.7, 16.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (52, 12, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (53, 12, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (54, 12, 'step length', 27.5, 27.7, 27.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (292, 37, 'Ketinggian Tool', 2529, 2532, 2526, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (293, 37, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (294, 37, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (295, 39, 'Ketinggian Tool', 2417, 242, 2414, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (296, 39, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (297, 39, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (298, 41, 'Ketinggian Tool', 187, 1873, 1867, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (299, 41, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (300, 41, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (301, 86, 'Ketinggian Tool', 217, 2173, 2167, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (302, 86, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (303, 86, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (304, 70, 'Ketinggian Tool', 15006, 15036, 14976, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (305, 70, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (306, 70, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (307, 43, 'Ketinggian Tool', 2073, 2076, 207, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (308, 43, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (309, 43, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (310, 88, 'Ketinggian Tool', 1776, 1779, 1773, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (311, 88, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (312, 88, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (313, 89, 'Ketinggian Tool', 2229, 2232, 2226, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (55, 17, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (56, 17, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (57, 17, 'step length', 10.5, 10.7, 10.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (58, 18, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (59, 18, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (60, 18, 'step length', 22.5, 22.7, 22.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (61, 22, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (62, 22, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (63, 22, 'step length', 21.5, 21.7, 21.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (64, 25, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (65, 25, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (66, 25, 'step length', 30.5, 30.7, 30.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (67, 16, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (68, 16, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (69, 16, 'step length', 29.5, 29.7, 29.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (70, 31, 'point angle', 118, 120, 116, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (71, 31, 'run out', 0.05, 0.05, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (72, 32, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (73, 32, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (74, 36, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (75, 36, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (76, 39, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (77, 39, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (78, 101, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (79, 101, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (80, 54, 'Chamfer width', 1, 1.5, 0.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (81, 54, 'Chamfer angle', 60, 61, 59, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (82, 54, 'margin width', 0.1, 0.15, 0.05, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (83, 54, 'run out', 0.01, 0.01, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (84, 65, 'point angle', 160, 162, 158, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (85, 65, 'run out', 0.03, 0.03, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (86, 4, 'step length 1', 12.8, 12.9, 12.7, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (87, 4, 'step length 2', 4927, 4977, 4877, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (88, 4, 'step length 3', 1.61, 1.71, 1.51, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (89, 4, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (90, 6, 'point angle', 45, 46, 44, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (91, 6, 'margin width', 0.20, 0.40, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (92, 10, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (93, 10, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (94, 10, 'step length', 22.5, 22.7, 22.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (95, 11, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (96, 11, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (97, 11, 'step length', 24, 24.1, 23.9, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (98, 13, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (99, 13, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (100, 13, 'step length', 20, 20.2, 19.8, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (101, 14, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (102, 14, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (103, 14, 'step length', 13.5, 13.7, 13.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (104, 15, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (105, 15, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (106, 15, 'step length', 23.5, 24, 23, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (107, 19, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (108, 19, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (109, 19, 'step length', 27.5, 27.7, 27.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (110, 24, 'point angle', 160, 162, 158, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (111, 24, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (112, 24, 'step length', 23, 235, 22.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (113, 26, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (114, 26, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (115, 26, 'step length', 22, 22.5, 21.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (116, 94, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (117, 94, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (118, 94, 'step length', 30, 30.5, 29.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (119, 27, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (120, 27, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (121, 27, 'step length', 29, 29.2, 28.8, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (122, 28, 'point angle', 118, 120, 116, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (123, 28, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (124, 28, 'step length', 5.5, 6, 5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (125, 30, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (126, 30, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (127, 30, 'step length', 40, 40.5, 39.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (128, 80, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (129, 80, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (130, 37, 'point angle', 130, 132, 128, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (164, 49, 'chamfer width', 1, 1.5, 0.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (165, 49, 'chamfer angle', 120, 121, 119, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (166, 49, 'run out', 0.01, 0.01, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (167, 51, 'chamfer width', 1, 1.5, 0.46, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (168, 51, 'chamfer angle', 45, 46, 44, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (169, 51, 'margin width', 0.3, 0.3, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (170, 63, 'run out', 0.04, 0.04, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (171, 67, 'run out', 0.03, 0.03, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (172, 67, 'gash angle', 30, 40, 20, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (173, 67, 'gash offset', 0.1, 0.13, 0.07, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (0, 69, 'Point angle', 120, 123, 117, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (1, 69, 'run out', 0.05, 0.05, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (2, 5, 'Point angle', 128, 131, 125, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (3, 5, 'run out', 0.05, 0.05, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (4, 8, 'point angle', 140, 142, 138, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (5, 8, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (6, 8, 'Step length', 5.8, 6.3, 5.3, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (7, 1, 'Point angle', 140, 143, 137, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (8, 1, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (9, 1, 'Step length', 30, 30.5, 29.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (10, 80, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (11, 80, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (12, 68, 'Point angle', 140, 143, 137, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (13, 68, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (14, 107, 'point angle', 140, 142, 138, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (15, 107, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (16, 35, 'point angle', 160, 162, 158, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (17, 35, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (18, 40, 'Point angle', 140, 143, 137, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (19, 40, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (20, 42, 'point angle', 135, 138, 132, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (21, 42, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (314, 89, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (315, 89, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (316, 44, 'Ketinggian Tool', 17717, 17747, 17687, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (317, 44, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (318, 51, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (319, 52, 'Ketinggian Tool', 17406, 17436, 17376, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (320, 52, 'Runout', 10, 20, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (321, 52, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (322, 53, 'Ketinggian Tool', 18806, 18836, 18776, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (323, 53, 'Runout', 10, 20, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (324, 53, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (325, 57, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (326, 60, 'Ketinggian Tool', 17506, 17536, 17476, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (327, 60, 'Runout', 10, 20, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (328, 60, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (329, 113, 'Ketinggian Tool', 15689, 15719, 15659, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (330, 113, 'Runout', 10, 20, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (331, 113, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (332, 63, 'Ketinggian Tool', 160, 1603, 1597, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (333, 63, 'Runout', 25, 50, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (334, 63, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (131, 37, 'run out', 0.05, 0.05, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (132, 38, 'point angle', 130, 132, 128, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (133, 38, 'run out', 0.05, 0.05, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (134, 41, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (135, 41, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (136, 86, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (137, 86, 'run out', 0.02, 1000, 0.02, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (138, 70, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (139, 70, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (140, 43, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (335, 67, 'Ketinggian Tool', 145, 1453, 1447, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (336, 67, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (337, 96, 'Ketinggian Tool', 160, 1603, 1597, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (338, 96, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (339, 97, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (340, 5, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (341, 8, 'Ketinggian Tool', 300.00, 300.30, 299.70, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (342, 8, 'Runout', 15, 30, 0, 'mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (343, 8, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (344, 1, 'Ketinggian Tool', 300.00, 300.30, 299.70, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (345, 1, 'Runout', 15, 30, 0, 'mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (346, 1, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (347, 80, 'Ketinggian Tool', 300.00, 300.30, 299.70, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (348, 80, 'Runout', 15, 30, 0, 'mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (349, 80, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (350, 45, 'Ketinggian Tool', 300.00, 300.30, 299.70, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (351, 45, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (352, 46, 'Ketinggian Tool', 300.00, 300.30, 299.70, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (353, 46, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (354, 63, 'Ketinggian Tool', 300.00, 300.30, 299.70, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (355, 63, 'Runout', 25, 50, 0, 'mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (356, 63, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (357, 69, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (358, 107, 'Ketinggian Tool', 241, 2413, 2407, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (359, 107, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (360, 107, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (361, 35, 'Ketinggian Tool', 1504, 1507, 1501, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (362, 35, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (363, 35, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (364, 40, 'Ketinggian Tool', 1615, 1618, 1612, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (365, 40, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (366, 40, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (367, 42, 'Ketinggian Tool', 1618, 1621, 1615, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (141, 43, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (142, 88, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (143, 88, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (144, 89, 'point angle', 135, 137, 133, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (145, 89, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (146, 44, 'Chamfer width', 9, 9.5, 8.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (147, 44, 'chamfer angle', 90, 0, 0, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (148, 44, 'margin width', 0.7, 0.7, 0, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (149, 44, 'run out', 0.02, 0.02, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (150, 52, 'chamfer width', 1, 1.5, 0.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (151, 52, 'margin width', 0.5, 0.55, 0.45, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (152, 52, 'run out', 0.01, 0.01, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (153, 53, 'chamfer width', 1, 1.5, 0.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (154, 53, 'chamfer angle', 120, 121, 119, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (155, 53, 'run out', 0.01, 0.01, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (156, 53, 'step length', 9, 9.3, 8.7, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (157, 56, 'chamfer width', 0.48, 0.5, 0.46, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (158, 56, 'step length', 64.5, 64.8, 64.2, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (159, 57, 'chamfer width', 0.48, 0.5, 0.46, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (160, 57, 'step length', 63, 63.5, 62.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (161, 60, 'chamfer width', 1, 1.5, 0.5, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (162, 60, 'chamfer angle', 90, 91, 89, '°', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (163, 60, 'run out', 0.01, 0.01, 0, 'mm', '2024-07-13 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'TR');
INSERT INTO public.tb_m_tools_type_std VALUES (368, 42, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (369, 42, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (370, 74, 'Ketinggian Tool', 1822, 1825, 1819, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (371, 74, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (372, 74, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (373, 2, 'Ketinggian Tool', 182, 1823, 1817, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (374, 2, 'Runout', 15, 30, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (375, 2, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (376, 76, 'Ketinggian Tool', 1333, 1336, 133, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (377, 76, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (378, 3, 'Ketinggian Tool', 300, 3003, 2997, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (379, 3, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (380, 47, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (381, 48, 'Ketinggian Tool', 300, 3003, 2997, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (382, 48, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (383, 63, 'Ketinggian Tool', 160, 1603, 1597, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (384, 63, 'Runout', 25, 50, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (385, 63, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (386, 64, 'Ketinggian Tool', 185, 1853, 1847, 'mm', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (387, 64, 'Runout', 25, 50, 0, 'Mikron', '2024-07-16 00:00:00', 'Fajar Tri Cahyono', false, NULL, NULL, 'CR');
INSERT INTO public.tb_m_tools_type_std VALUES (388, 64, 'Internal Coolant', NULL, NULL, NULL, NULL, '2024-07-16 00:00:00', 'Fajar Tri Cahyono', true, NULL, NULL, 'CR');


--
-- TOC entry 3713 (class 0 OID 32647)
-- Dependencies: 222
-- Data for Name: tb_m_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_m_users VALUES (1, '0', 'Supriyadi', 'SYSTEM', '2024-07-23');
INSERT INTO public.tb_m_users VALUES (2, '0', 'Darul Tauziri', 'SYSTEM', '2024-07-23');
INSERT INTO public.tb_m_users VALUES (3, '0', 'Ahmad Lutpi', 'SYSTEM', '2024-07-23');
INSERT INTO public.tb_m_users VALUES (4, '0', 'Tri Suroto', 'SYSTEM', '2024-07-23');
INSERT INTO public.tb_m_users VALUES (5, '0', 'Aji Wahyu', 'SYSTEM', '2024-07-23');
INSERT INTO public.tb_m_users VALUES (6, '0', 'Tubagus Hidayatulloh', 'SYSTEM', '2024-07-23');


--
-- TOC entry 3708 (class 0 OID 32523)
-- Dependencies: 216
-- Data for Name: tb_r_tool_checks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_r_tool_checks VALUES (13, 'Point angle', '140', 40, 143, 137, 7, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (14, 'run out', '0', 40, 0.02, 0, 8, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (15, 'Step length', '30', 40, 30.5, 29.5, 9, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (16, 'Point angle', '140', 41, 143, 137, 7, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (17, 'run out', '0', 41, 0.02, 0, 8, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (18, 'Step length', '0', 41, 30.5, 29.5, 9, 'NG');
INSERT INTO public.tb_r_tool_checks VALUES (19, 'Point angle', '140', 42, 143, 137, 7, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (20, 'run out', '0', 42, 0.02, 0, 8, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (21, 'Step length', '30', 42, 30.5, 29.5, 9, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (22, 'Point angle', '140', 47, 143, 137, 7, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (23, 'run out', '0', 47, 0.02, 0, 8, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (24, 'Step length', '30', 47, 30.5, 29.5, 9, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (1, 'point angle', '134', 2, 137, 133, 67, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (2, 'run out', '0', 2, 0.02, 0, 68, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (3, 'step length', '29.6', 2, 29.7, 29.3, 69, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (4, 'Point angle', '137', 35, 143, 137, 7, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (5, 'run out', '0', 35, 0.02, 0, 8, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (6, 'Step length', '30', 35, 30.5, 29.5, 9, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (7, 'Point angle', '140', 37, 143, 137, 7, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (8, 'run out', '0', 37, 0.02, 0, 8, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (9, 'Step length', '30', 37, 30.5, 29.5, 9, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (10, 'Point angle', '140', 38, 143, 137, 7, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (11, 'run out', '0', 38, 0.02, 0, 8, 'OK');
INSERT INTO public.tb_r_tool_checks VALUES (12, 'Step length', '30', 38, 30.5, 29.5, 9, 'OK');


--
-- TOC entry 3711 (class 0 OID 32578)
-- Dependencies: 219
-- Data for Name: tb_r_tool_problems; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3702 (class 0 OID 32410)
-- Dependencies: 210
-- Data for Name: tb_r_tools; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_r_tools VALUES (1, 1, 'A0028', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN-00001', NULL);
INSERT INTO public.tb_r_tools VALUES (2, 1, 'A0029', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN-00002', NULL);
INSERT INTO public.tb_r_tools VALUES (3, 2, 'A0035', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000001', 'A0035');
INSERT INTO public.tb_r_tools VALUES (4, 2, 'A0036', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000002', 'A0036');
INSERT INTO public.tb_r_tools VALUES (5, 3, 'A0037', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, ' MC - 1041 - 000001', 'A0037');
INSERT INTO public.tb_r_tools VALUES (6, 3, 'A0038', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, ' MC - 1041 - 000002', 'A0038');
INSERT INTO public.tb_r_tools VALUES (7, 3, 'A0039', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, ' MC - 1041 - 000003', 'A0039');
INSERT INTO public.tb_r_tools VALUES (8, 3, 'A0040', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, ' MC - 1041 - 000004', 'A0040');
INSERT INTO public.tb_r_tools VALUES (9, 4, 'A0041', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000001', NULL);
INSERT INTO public.tb_r_tools VALUES (10, 4, 'A0042', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000002', NULL);
INSERT INTO public.tb_r_tools VALUES (11, 4, 'A0043', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (12, 4, 'A0044', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (13, 4, 'A0045', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (14, 4, 'A0046', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (15, 4, 'A0047', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (16, 4, 'A0048', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (17, 4, 'A0049', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000009', NULL);
INSERT INTO public.tb_r_tools VALUES (18, 4, 'A0050', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000010', NULL);
INSERT INTO public.tb_r_tools VALUES (19, 4, 'A0051', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000011', NULL);
INSERT INTO public.tb_r_tools VALUES (20, 4, 'A0052', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 000012', NULL);
INSERT INTO public.tb_r_tools VALUES (21, 5, 'A0053', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000001', 'A0053');
INSERT INTO public.tb_r_tools VALUES (22, 5, 'A0054', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000002', 'A0054');
INSERT INTO public.tb_r_tools VALUES (23, 5, 'A0055', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000003', 'A0055');
INSERT INTO public.tb_r_tools VALUES (24, 5, 'A0057', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000004', 'A0057');
INSERT INTO public.tb_r_tools VALUES (25, 5, 'A0058', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (26, 5, 'A0059', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (27, 5, 'A0060', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (28, 5, 'A0061', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (29, 5, 'A0063', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000009', NULL);
INSERT INTO public.tb_r_tools VALUES (30, 5, 'A0064', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000010', NULL);
INSERT INTO public.tb_r_tools VALUES (31, 5, 'A0065', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000011', NULL);
INSERT INTO public.tb_r_tools VALUES (32, 5, 'A0066', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1800, 'CD-989 - 000012', NULL);
INSERT INTO public.tb_r_tools VALUES (33, 6, 'A0067', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DGN - 0880 - 000001', 'A0067');
INSERT INTO public.tb_r_tools VALUES (34, 6, 'A0068', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DGN - 0880 - 000002', NULL);
INSERT INTO public.tb_r_tools VALUES (35, 6, 'A0069', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DGN - 0880 - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (36, 6, 'A0073', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DGN - 0880 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (37, 6, 'A0074', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DGN - 0880 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (38, 6, 'A0075', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DGN - 0880 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (39, 6, 'A0076', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DGN - 0880 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (40, 6, 'A0077', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DGN - 0880 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (41, 7, 'A0081', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 0340 - 000001', 'A0081');
INSERT INTO public.tb_r_tools VALUES (42, 7, 'A0082', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 0340 - 000002', 'A0082');
INSERT INTO public.tb_r_tools VALUES (43, 7, 'A0083', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 0340 - 000003', 'A0083');
INSERT INTO public.tb_r_tools VALUES (44, 7, 'A0084', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 0340 - 000004', 'A0084');
INSERT INTO public.tb_r_tools VALUES (45, 7, 'A0085', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 0340 - 000005', 'A0085');
INSERT INTO public.tb_r_tools VALUES (46, 7, 'A0086', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 0340 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (47, 7, 'A0087', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 0340 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (48, 7, 'A0088', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 0340 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (49, 8, 'A0089', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00009', NULL);
INSERT INTO public.tb_r_tools VALUES (50, 8, 'A0090', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00010', NULL);
INSERT INTO public.tb_r_tools VALUES (51, 8, 'A0091', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00011', NULL);
INSERT INTO public.tb_r_tools VALUES (52, 8, 'A0092', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00012', NULL);
INSERT INTO public.tb_r_tools VALUES (53, 8, 'A0093', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00013', NULL);
INSERT INTO public.tb_r_tools VALUES (54, 8, 'A0094', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00014', NULL);
INSERT INTO public.tb_r_tools VALUES (55, 8, 'A0095', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00015', NULL);
INSERT INTO public.tb_r_tools VALUES (56, 8, 'A0096', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00016', NULL);
INSERT INTO public.tb_r_tools VALUES (57, 9, 'A0097', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 05260 - 000001', 'A0097');
INSERT INTO public.tb_r_tools VALUES (58, 9, 'A0098', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 05260 - 000002', 'A0098');
INSERT INTO public.tb_r_tools VALUES (59, 9, 'A0099', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 05260 - 000003', 'A0099');
INSERT INTO public.tb_r_tools VALUES (60, 9, 'A0100', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 05260 - 000004', 'A0100');
INSERT INTO public.tb_r_tools VALUES (61, 9, 'A0101', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 05260 - 000005', 'A0101');
INSERT INTO public.tb_r_tools VALUES (62, 9, 'A0102', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 05260 - 000006', 'A0102');
INSERT INTO public.tb_r_tools VALUES (63, 9, 'A0103', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 05260 - 000007', 'A0103');
INSERT INTO public.tb_r_tools VALUES (64, 9, 'A0104', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 05260 - 000008', 'A0104');
INSERT INTO public.tb_r_tools VALUES (65, 10, 'A0105', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05261 - 000001', 'A0105');
INSERT INTO public.tb_r_tools VALUES (66, 10, 'A0106', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05261 - 000002', 'A0106');
INSERT INTO public.tb_r_tools VALUES (67, 10, 'A0107', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05261 - 000003', 'A0107');
INSERT INTO public.tb_r_tools VALUES (68, 10, 'A0108', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05261 - 000004', 'A0108');
INSERT INTO public.tb_r_tools VALUES (69, 10, 'A0109', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05261 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (70, 10, 'A0110', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05261 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (71, 10, 'A0111', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05261 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (72, 10, 'A0112', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05261 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (73, 11, 'A0113', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 06465 - 000001', 'A0113');
INSERT INTO public.tb_r_tools VALUES (74, 11, 'A0114', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 06465 - 000002', 'A0114');
INSERT INTO public.tb_r_tools VALUES (75, 11, 'A0115', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 06465 - 000003', 'A0115');
INSERT INTO public.tb_r_tools VALUES (76, 11, 'A0116', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 06465 - 000004', 'A0116');
INSERT INTO public.tb_r_tools VALUES (77, 11, 'A0117', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 06465 - 000005', 'A0117');
INSERT INTO public.tb_r_tools VALUES (78, 11, 'A0118', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 06465 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (79, 11, 'A0119', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 06465 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (80, 11, 'A0120', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 06465 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (81, 12, 'A0122', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06466 - 000001', 'A0122');
INSERT INTO public.tb_r_tools VALUES (82, 12, 'A0123', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06466 - 000002', 'A0123');
INSERT INTO public.tb_r_tools VALUES (83, 12, 'A0124', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06466 - 000003', 'A0124');
INSERT INTO public.tb_r_tools VALUES (84, 12, 'A0125', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06466 - 000004', 'A0125');
INSERT INTO public.tb_r_tools VALUES (85, 12, 'A0126', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06466 - 000005', 'A0126');
INSERT INTO public.tb_r_tools VALUES (86, 12, 'A0127', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06466 - 000006', 'A0127');
INSERT INTO public.tb_r_tools VALUES (87, 12, 'A0128', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06466 - 000007', 'A0128');
INSERT INTO public.tb_r_tools VALUES (88, 12, 'A0131', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06466 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (89, 13, 'A0132', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 06467 - 000001', 'A0132');
INSERT INTO public.tb_r_tools VALUES (90, 13, 'A0133', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 06467 - 000002', 'A0133');
INSERT INTO public.tb_r_tools VALUES (91, 13, 'A0135', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 06467 - 000004', 'A0135');
INSERT INTO public.tb_r_tools VALUES (92, 13, 'A0137', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 06467 - 000005', 'A0137');
INSERT INTO public.tb_r_tools VALUES (93, 13, 'A0138', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 06467 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (94, 13, 'A0139', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 06467 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (95, 13, 'A0140', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 06467 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (96, 14, 'A0141', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7500, 'DSDW - 07148 - 000001', 'A0141');
INSERT INTO public.tb_r_tools VALUES (97, 14, 'A0142', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7500, 'DSDW - 07148 - 000002', 'A0142');
INSERT INTO public.tb_r_tools VALUES (98, 14, 'A0143', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7500, 'DSDW - 07148 - 000003', 'A0143');
INSERT INTO public.tb_r_tools VALUES (99, 14, 'A0144', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7500, 'DSDW - 07148 - 000004', 'A0144');
INSERT INTO public.tb_r_tools VALUES (100, 14, 'A0145', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7500, 'DSDW - 07148 - 000005', 'A0145');
INSERT INTO public.tb_r_tools VALUES (101, 14, 'A0148', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7500, 'DSDW - 07148 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (102, 14, 'A0150', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7500, 'DSDW - 07148 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (103, 14, 'A0152', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7500, 'DSDW - 07148 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (104, 15, 'A0153', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 000001', 'A0153');
INSERT INTO public.tb_r_tools VALUES (105, 15, 'A0154', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 000002', 'A0154');
INSERT INTO public.tb_r_tools VALUES (106, 15, 'A0155', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 000003', 'A0155');
INSERT INTO public.tb_r_tools VALUES (107, 15, 'A0156', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 000004', 'A0156');
INSERT INTO public.tb_r_tools VALUES (108, 15, 'A0157', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (109, 15, 'A0158', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (110, 15, 'A0159', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (111, 15, 'A0161', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (112, 16, 'A0162', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08462 - 000001', 'A0162');
INSERT INTO public.tb_r_tools VALUES (113, 16, 'A0164', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08462 - 000002', 'A0164');
INSERT INTO public.tb_r_tools VALUES (114, 16, 'A0165', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08462 - 000003', 'A0165');
INSERT INTO public.tb_r_tools VALUES (115, 16, 'A0166', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08462 - 000004', 'A0166');
INSERT INTO public.tb_r_tools VALUES (116, 16, 'A0167', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08462 - 000005', 'A0167');
INSERT INTO public.tb_r_tools VALUES (117, 16, 'A0168', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08462 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (118, 16, 'A0169', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08462 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (119, 16, 'A0170', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08462 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (120, 17, 'A0171', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 08463 - 000001', 'A0171');
INSERT INTO public.tb_r_tools VALUES (121, 17, 'A0172', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 08463 - 000002', 'A0172');
INSERT INTO public.tb_r_tools VALUES (122, 17, 'A0173', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 08463 - 000003', 'A0173');
INSERT INTO public.tb_r_tools VALUES (123, 17, 'A0174', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 08463 - 000004', 'A0174');
INSERT INTO public.tb_r_tools VALUES (124, 17, 'A0175', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 08463 - 000005', 'A0175');
INSERT INTO public.tb_r_tools VALUES (125, 17, 'A0176', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 08463 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (126, 17, 'A0177', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 08463 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (127, 17, 'A0178', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 08463 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (128, 18, 'A0179', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08464 - 000001', 'A0179');
INSERT INTO public.tb_r_tools VALUES (129, 18, 'A0180', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08464 - 000002', 'A0180');
INSERT INTO public.tb_r_tools VALUES (130, 18, 'A0181', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08464 - 000003', 'A0181');
INSERT INTO public.tb_r_tools VALUES (131, 18, 'A0182', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08464 - 000004', 'A0182');
INSERT INTO public.tb_r_tools VALUES (132, 18, 'A0183', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08464 - 000005', 'A0183');
INSERT INTO public.tb_r_tools VALUES (133, 18, 'A0184', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08464 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (134, 18, 'A0185', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08464 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (135, 18, 'A0186', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 08464 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (136, 19, 'A0187', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'DSDW - 08465 - 000001', 'A0187');
INSERT INTO public.tb_r_tools VALUES (137, 19, 'A0188', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'DSDW - 08465 - 000002', 'A0188');
INSERT INTO public.tb_r_tools VALUES (138, 19, 'A0189', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'DSDW - 08465 - 000003', 'A0189');
INSERT INTO public.tb_r_tools VALUES (139, 19, 'A0190', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'DSDW - 08465 - 000004', 'A0190');
INSERT INTO public.tb_r_tools VALUES (140, 19, 'A0191', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'DSDW - 08465 - 000005', 'A0191');
INSERT INTO public.tb_r_tools VALUES (141, 19, 'A0192', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'DSDW - 08465 - 000006', 'A0192');
INSERT INTO public.tb_r_tools VALUES (142, 19, 'A0193', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'DSDW - 08465 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (143, 19, 'A0194', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'DSDW - 08465 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (144, 1, 'A0195', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN - 000001', 'A0195');
INSERT INTO public.tb_r_tools VALUES (145, 1, 'A0196', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN - 000002', 'A0196');
INSERT INTO public.tb_r_tools VALUES (146, 1, 'A0197', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN - 000003', 'A0197');
INSERT INTO public.tb_r_tools VALUES (147, 1, 'A0199', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN - 000004', 'A0199');
INSERT INTO public.tb_r_tools VALUES (148, 1, 'A0200', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN - 000005', 'A0200');
INSERT INTO public.tb_r_tools VALUES (149, 1, 'A0201', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN - 000006', 'A0201');
INSERT INTO public.tb_r_tools VALUES (150, 1, 'A0202', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN - 000007', 'A0202');
INSERT INTO public.tb_r_tools VALUES (151, 1, 'A0203', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 650, 'DSDW - 08466TIN - 000008', 'A0203');
INSERT INTO public.tb_r_tools VALUES (152, 20, 'A0204', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 09271 DIC - 000001', 'A0204');
INSERT INTO public.tb_r_tools VALUES (153, 20, 'A0205', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 09271 DIC - 000002', 'A0205');
INSERT INTO public.tb_r_tools VALUES (154, 20, 'A0206', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 09271 DIC - 000003', 'A0206');
INSERT INTO public.tb_r_tools VALUES (155, 20, 'A0207', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 09271 DIC - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (156, 20, 'A0208', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 09271 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (157, 20, 'A0209', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 09271 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (158, 20, 'A0210', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 09271 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (159, 20, 'A0211', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 09271 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (160, 21, 'A0212', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 09272 DIC - 000001', 'A0212');
INSERT INTO public.tb_r_tools VALUES (161, 21, 'A0213', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 09272 DIC - 000002', NULL);
INSERT INTO public.tb_r_tools VALUES (162, 21, 'A0214', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 09272 DIC - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (163, 21, 'A0215', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 09272 DIC - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (164, 21, 'A0216', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 09272 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (165, 21, 'A0217', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 09272 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (166, 21, 'A0218', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 09272 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (167, 21, 'A0219', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 09272 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (168, 22, 'A0220', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09273 DIC - 000001', 'A0220');
INSERT INTO public.tb_r_tools VALUES (169, 22, 'A0221', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09273 DIC - 000002', 'A0221');
INSERT INTO public.tb_r_tools VALUES (170, 22, 'A0222', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09273 DIC - 000003', 'A0222');
INSERT INTO public.tb_r_tools VALUES (171, 22, 'A0223', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09273 DIC - 000004', 'A0223');
INSERT INTO public.tb_r_tools VALUES (172, 22, 'A0224', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09273 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (173, 22, 'A0225', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09273 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (174, 22, 'A0226', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09273 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (175, 22, 'A0227', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09273 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (176, 23, 'A0228', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09274 DIC - 000001', 'A0228');
INSERT INTO public.tb_r_tools VALUES (177, 23, 'A0229', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09274 DIC - 000002', 'A0229');
INSERT INTO public.tb_r_tools VALUES (178, 23, 'A0230', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09274 DIC - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (179, 23, 'A0231', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09274 DIC - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (180, 23, 'A0232', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09274 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (181, 23, 'A0233', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09274 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (182, 23, 'A0234', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09274 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (183, 23, 'A0235', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 09274 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (184, 24, 'A0236', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10399 - 000001', 'A0236');
INSERT INTO public.tb_r_tools VALUES (185, 24, 'A0237', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10399 - 000002', 'A0237');
INSERT INTO public.tb_r_tools VALUES (186, 24, 'A0238', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10399 - 000003', 'A0238');
INSERT INTO public.tb_r_tools VALUES (187, 24, 'A0239', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10399 - 000004', 'A0239');
INSERT INTO public.tb_r_tools VALUES (188, 24, 'A0240', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10399 - 000005', 'A0240');
INSERT INTO public.tb_r_tools VALUES (189, 24, 'A0241', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10399 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (190, 24, 'A0242', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10399 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (191, 24, 'A0243', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10399 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (192, 25, 'A0244', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 15000, 'DSDW - 10400 - 000001', 'A0244');
INSERT INTO public.tb_r_tools VALUES (193, 25, 'A0245', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 15000, 'DSDW - 10400 - 000002', 'A0245');
INSERT INTO public.tb_r_tools VALUES (194, 25, 'A0247', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 15000, 'DSDW - 10400 - 000003', 'A0247');
INSERT INTO public.tb_r_tools VALUES (195, 25, 'A0248', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 15000, 'DSDW - 10400 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (196, 25, 'A0249', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 15000, 'DSDW - 10400 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (197, 25, 'A0250', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 15000, 'DSDW - 10400 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (198, 25, 'A0251', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 15000, 'DSDW - 10400 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (199, 25, 'A0252', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 15000, 'DSDW - 10400 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (200, 26, 'A0253', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10401 - 000001', 'A0253');
INSERT INTO public.tb_r_tools VALUES (201, 26, 'A0254', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10401 - 000002', 'A0254');
INSERT INTO public.tb_r_tools VALUES (202, 26, 'A0256', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10401 - 000003', 'A0256');
INSERT INTO public.tb_r_tools VALUES (203, 26, 'A0257', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10401 - 000004', 'A0257');
INSERT INTO public.tb_r_tools VALUES (204, 26, 'A0258', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10401 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (205, 26, 'A0259', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10401 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (206, 26, 'A0260', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10401 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (207, 26, 'A0261', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 10401 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (208, 27, 'A0262', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 11235 - 000001', 'A0262');
INSERT INTO public.tb_r_tools VALUES (209, 27, 'A0263', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 11235 - 000002', 'A0263');
INSERT INTO public.tb_r_tools VALUES (210, 27, 'A0264', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 11235 - 000003', 'A0264');
INSERT INTO public.tb_r_tools VALUES (211, 27, 'A0265', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 11235 - 000004', 'A0265');
INSERT INTO public.tb_r_tools VALUES (212, 27, 'A0266', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 11235 - 000005', 'A0266');
INSERT INTO public.tb_r_tools VALUES (213, 27, 'A0267', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 11235 - 000006', 'A0267');
INSERT INTO public.tb_r_tools VALUES (214, 27, 'A0268', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 11235 - 000007', 'A0268');
INSERT INTO public.tb_r_tools VALUES (215, 27, 'A0270', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 20000, 'DSDW - 11235 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (216, 28, 'A0271', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000001', 'A0271');
INSERT INTO public.tb_r_tools VALUES (217, 28, 'A0272', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000002', 'A0272');
INSERT INTO public.tb_r_tools VALUES (218, 28, 'A0273', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000003', 'A0273');
INSERT INTO public.tb_r_tools VALUES (219, 28, 'A0274', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000004', 'A0274');
INSERT INTO public.tb_r_tools VALUES (220, 28, 'A0275', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000005', 'A0275');
INSERT INTO public.tb_r_tools VALUES (221, 28, 'A0276', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000006', 'A0276');
INSERT INTO public.tb_r_tools VALUES (222, 28, 'A0278', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000007', 'A0278');
INSERT INTO public.tb_r_tools VALUES (223, 28, 'A0279', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (224, 29, 'A0280', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11241 - 000001', 'A0280');
INSERT INTO public.tb_r_tools VALUES (225, 29, 'A0281', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11241 - 000002', 'A0281');
INSERT INTO public.tb_r_tools VALUES (226, 29, 'A0282', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11241 - 000003', 'A0282');
INSERT INTO public.tb_r_tools VALUES (227, 29, 'A0283', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11241 - 000004', 'A0283');
INSERT INTO public.tb_r_tools VALUES (228, 29, 'A0284', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11241 - 000005', 'A0284');
INSERT INTO public.tb_r_tools VALUES (229, 29, 'A0285', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11241 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (230, 30, 'A0286', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 1693 - 000001', 'A0286');
INSERT INTO public.tb_r_tools VALUES (231, 30, 'A0287', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 1693 - 000002', 'A0287');
INSERT INTO public.tb_r_tools VALUES (232, 30, 'A0288', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 1693 - 000003', 'A0288');
INSERT INTO public.tb_r_tools VALUES (233, 30, 'A0289', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 1693 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (234, 30, 'A0290', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 1693 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (235, 30, 'A0291', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 1693 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (236, 30, 'A0292', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 1693 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (237, 30, 'A0293', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 1693 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (238, 31, 'A0294', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSS - 1157 - 000001', 'A0294');
INSERT INTO public.tb_r_tools VALUES (239, 31, 'A0295', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSS - 1157 - 000002', 'A0295');
INSERT INTO public.tb_r_tools VALUES (240, 31, 'A0296', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSS - 1157 - 000003', 'A0296');
INSERT INTO public.tb_r_tools VALUES (241, 31, 'A0297', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSS - 1157 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (242, 31, 'A0298', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSS - 1157 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (243, 31, 'A0299', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSS - 1157 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (244, 31, 'A0301', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSS - 1157 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (245, 31, 'A0302', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSS - 1157 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (246, 32, 'A0303', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 0381 - 000001', 'A0303');
INSERT INTO public.tb_r_tools VALUES (247, 32, 'A0304', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 0381 - 000002', 'A0304');
INSERT INTO public.tb_r_tools VALUES (248, 32, 'A0305', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 0381 - 000003', 'A0305');
INSERT INTO public.tb_r_tools VALUES (249, 32, 'A0306', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 0381 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (250, 32, 'A0307', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 0381 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (251, 32, 'A0308', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 0381 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (252, 32, 'A0309', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 0381 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (253, 32, 'A0310', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 0381 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (254, 33, 'A0311', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 04120A - 00024', 'A0311');
INSERT INTO public.tb_r_tools VALUES (255, 33, 'A0312', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 04120A - 00023', NULL);
INSERT INTO public.tb_r_tools VALUES (256, 33, 'A0313', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 04120A - 00022', NULL);
INSERT INTO public.tb_r_tools VALUES (257, 33, 'A0314', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 04120A - 00021', NULL);
INSERT INTO public.tb_r_tools VALUES (258, 33, 'A0315', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 04120A - 00020', 'A0315');
INSERT INTO public.tb_r_tools VALUES (259, 33, 'A0316', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 04120A - 00019', 'A0316');
INSERT INTO public.tb_r_tools VALUES (260, 33, 'A0317', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 04120A - 00018', 'A0317');
INSERT INTO public.tb_r_tools VALUES (261, 33, 'A0318', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 04120A - 00017', 'A0318');
INSERT INTO public.tb_r_tools VALUES (262, 34, 'A0320', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000001', 'A0320');
INSERT INTO public.tb_r_tools VALUES (263, 34, 'A0321', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000002', 'A0321');
INSERT INTO public.tb_r_tools VALUES (264, 34, 'A0322', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000003', 'A0322');
INSERT INTO public.tb_r_tools VALUES (265, 34, 'A0323', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000004', 'A0323');
INSERT INTO public.tb_r_tools VALUES (266, 34, 'A0324', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000005', 'A0324');
INSERT INTO public.tb_r_tools VALUES (267, 34, 'A0325', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000006', 'A0325');
INSERT INTO public.tb_r_tools VALUES (268, 34, 'A0326', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000007', 'A0326');
INSERT INTO public.tb_r_tools VALUES (269, 34, 'A0327', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000008', 'A0327');
INSERT INTO public.tb_r_tools VALUES (270, 35, 'A0328', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000001', 'A0328');
INSERT INTO public.tb_r_tools VALUES (271, 35, 'A0329', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000002', 'A0329');
INSERT INTO public.tb_r_tools VALUES (272, 35, 'A0330', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000003', 'A0330');
INSERT INTO public.tb_r_tools VALUES (273, 35, 'A0331', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000004', 'A0331');
INSERT INTO public.tb_r_tools VALUES (274, 35, 'A0332', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000005', 'A0332');
INSERT INTO public.tb_r_tools VALUES (275, 35, 'A0333', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000006', 'A0333');
INSERT INTO public.tb_r_tools VALUES (276, 35, 'A0334', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000007', 'A0334');
INSERT INTO public.tb_r_tools VALUES (277, 35, 'A0335', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000008', 'A0335');
INSERT INTO public.tb_r_tools VALUES (278, 36, 'A0338', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 06301 - 000001', 'A0338');
INSERT INTO public.tb_r_tools VALUES (279, 36, 'A0339', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 06301 - 000002', 'A0339');
INSERT INTO public.tb_r_tools VALUES (280, 36, 'A0340', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 06301 - 000003', 'A0340');
INSERT INTO public.tb_r_tools VALUES (281, 36, 'A0341', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 06301 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (282, 36, 'A0342', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 06301 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (283, 36, 'A0343', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 06301 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (284, 36, 'A0344', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 06301 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (285, 36, 'A0345', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 06301 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (286, 37, 'A0346', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'DSSW - 08270 - 000001', 'A0346');
INSERT INTO public.tb_r_tools VALUES (287, 37, 'A0347', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'DSSW - 08270 - 000002', 'A0347');
INSERT INTO public.tb_r_tools VALUES (288, 37, 'A0348', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'DSSW - 08270 - 000003', 'A0348');
INSERT INTO public.tb_r_tools VALUES (289, 37, 'A0349', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'DSSW - 08270 - 000004', 'A0349');
INSERT INTO public.tb_r_tools VALUES (290, 37, 'A0350', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'DSSW - 08270 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (291, 37, 'A0351', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'DSSW - 08270 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (292, 37, 'A0352', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'DSSW - 08270 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (293, 37, 'A0353', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'DSSW - 08270 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (294, 38, 'A0354', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 08271 - 000001', 'A0354');
INSERT INTO public.tb_r_tools VALUES (295, 38, 'A0355', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 08271 - 000002', 'A0355');
INSERT INTO public.tb_r_tools VALUES (296, 38, 'A0356', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 08271 - 000003', 'A0356');
INSERT INTO public.tb_r_tools VALUES (297, 38, 'A0357', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 08271 - 000004', 'A0357');
INSERT INTO public.tb_r_tools VALUES (298, 38, 'A0358', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 08271 - 000005', 'A0358');
INSERT INTO public.tb_r_tools VALUES (299, 38, 'A0359', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 08271 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (300, 38, 'A0360', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 08271 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (301, 38, 'A0361', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 08271 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (302, 39, 'A0363', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 08291 - CH - OP 50 - 00001', 'A0363');
INSERT INTO public.tb_r_tools VALUES (303, 39, 'A0364', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 08291 - CH - OP 50 - 00002', 'A0364');
INSERT INTO public.tb_r_tools VALUES (304, 39, 'A0365', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 08291 - CH - OP 50 - 00003', 'A0365');
INSERT INTO public.tb_r_tools VALUES (305, 39, 'A0366', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 08291 - CH - OP 50 - 00004', 'A0366');
INSERT INTO public.tb_r_tools VALUES (306, 39, 'A0367', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 08291 - 000001', 'A0367');
INSERT INTO public.tb_r_tools VALUES (307, 39, 'A0368', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 08291 - 000002', 'A0368');
INSERT INTO public.tb_r_tools VALUES (308, 39, 'A0369', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 08291 - 000003', 'A0369');
INSERT INTO public.tb_r_tools VALUES (309, 39, 'A0370', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 08291 - 000004', 'A0370');
INSERT INTO public.tb_r_tools VALUES (310, 40, 'A0371', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 000001', 'A0371');
INSERT INTO public.tb_r_tools VALUES (311, 40, 'A0372', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 000002', 'A0372');
INSERT INTO public.tb_r_tools VALUES (312, 40, 'A0373', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 000003', 'A0373');
INSERT INTO public.tb_r_tools VALUES (313, 40, 'A0374', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 000004', 'A0374');
INSERT INTO public.tb_r_tools VALUES (314, 40, 'A0375', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 000005', 'A0375');
INSERT INTO public.tb_r_tools VALUES (315, 40, 'A0376', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 000006', 'A0376');
INSERT INTO public.tb_r_tools VALUES (316, 40, 'A0377', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 000007', 'A0377');
INSERT INTO public.tb_r_tools VALUES (317, 40, 'A0380', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 000008', 'A0380');
INSERT INTO public.tb_r_tools VALUES (318, 41, 'A0381', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSSW - 09131 - 000001', 'A0381');
INSERT INTO public.tb_r_tools VALUES (319, 41, 'A0382', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSSW - 09131 - 000002', 'A0382');
INSERT INTO public.tb_r_tools VALUES (320, 41, 'A0383', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSSW - 09131 - 000003', 'A0383');
INSERT INTO public.tb_r_tools VALUES (321, 41, 'A0386', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSSW - 09131 - 000004', 'A0386');
INSERT INTO public.tb_r_tools VALUES (322, 41, 'A0389', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSSW - 09131 - 000005', 'A0389');
INSERT INTO public.tb_r_tools VALUES (323, 41, 'A0390', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSSW - 09131 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (324, 41, 'A0391', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSSW - 09131 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (325, 41, 'A0392', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSSW - 09131 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (326, 42, 'A0393', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSSW - 09132 TIN - 000001', 'A0393');
INSERT INTO public.tb_r_tools VALUES (327, 42, 'A0394', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSSW - 09132 TIN - 000002', 'A0394');
INSERT INTO public.tb_r_tools VALUES (328, 42, 'A0395', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSSW - 09132 TIN - 000003', 'A0395');
INSERT INTO public.tb_r_tools VALUES (329, 42, 'A0396', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSSW - 09132 TIN - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (330, 42, 'A0397', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSSW - 09132 TIN - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (331, 42, 'A0398', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSSW - 09132 TIN - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (332, 42, 'A0399', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSSW - 09132 TIN - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (333, 42, 'A0400', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSSW - 09132 TIN - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (334, 43, 'A0412', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 11125 - 000001', NULL);
INSERT INTO public.tb_r_tools VALUES (335, 43, 'A0413', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 11125 - 000002', NULL);
INSERT INTO public.tb_r_tools VALUES (336, 43, 'A0414', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 11125 - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (337, 43, 'A0415', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 11125 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (338, 43, 'A0416', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 11125 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (339, 43, 'A0417', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 11125 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (340, 43, 'A0418', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 11125 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (341, 43, 'A0419', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 11125 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (342, 44, 'A0431', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000001', 'A0431');
INSERT INTO public.tb_r_tools VALUES (343, 44, 'A0432', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000002', 'A0432');
INSERT INTO public.tb_r_tools VALUES (344, 44, 'A0433', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000003', 'A0433');
INSERT INTO public.tb_r_tools VALUES (345, 44, 'A0434', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000004', 'A0434');
INSERT INTO public.tb_r_tools VALUES (346, 44, 'A0435', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000005', 'A0435');
INSERT INTO public.tb_r_tools VALUES (347, 44, 'A0436', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000006', 'A0436');
INSERT INTO public.tb_r_tools VALUES (348, 44, 'A0437', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000007', 'A0437');
INSERT INTO public.tb_r_tools VALUES (349, 44, 'A0438', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000008', 'A0438');
INSERT INTO public.tb_r_tools VALUES (350, 45, 'A0440', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'MC - 1039 - 000001', 'A0440');
INSERT INTO public.tb_r_tools VALUES (351, 45, 'A0441', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'MC - 1039 - 000002', 'A0441');
INSERT INTO public.tb_r_tools VALUES (352, 45, 'A0442', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'MC - 1039 - 000003', 'A0442');
INSERT INTO public.tb_r_tools VALUES (353, 45, 'A0443', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'MC - 1039 - 000004', 'A0443');
INSERT INTO public.tb_r_tools VALUES (354, 45, 'A0444', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'MC - 1039 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (355, 45, 'A0445', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'MC - 1039 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (356, 45, 'A0446', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'MC - 1039 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (357, 45, 'A0447', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'MC - 1039 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (358, 46, 'A0448', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'MC - 1040 - 000001', 'A0448');
INSERT INTO public.tb_r_tools VALUES (359, 46, 'A0449', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'MC - 1040 - 000002', 'A0449');
INSERT INTO public.tb_r_tools VALUES (360, 46, 'A0450', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'MC - 1040 - 000003', 'A0450');
INSERT INTO public.tb_r_tools VALUES (361, 46, 'A0451', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'MC - 1040 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (362, 46, 'A0452', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'MC - 1040 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (363, 46, 'A0453', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'MC - 1040 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (364, 46, 'A0454', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'MC - 1040 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (365, 46, 'A0455', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'MC - 1040 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (366, 47, 'A0456', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000001', 'A0456');
INSERT INTO public.tb_r_tools VALUES (367, 47, 'A0457', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000002', 'A0457');
INSERT INTO public.tb_r_tools VALUES (368, 47, 'A0458', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000003', 'A0458');
INSERT INTO public.tb_r_tools VALUES (369, 47, 'A0459', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000004', 'A0459');
INSERT INTO public.tb_r_tools VALUES (370, 47, 'A0460', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000005', 'A0460');
INSERT INTO public.tb_r_tools VALUES (371, 47, 'A0461', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000006', 'A0461');
INSERT INTO public.tb_r_tools VALUES (372, 47, 'A0462', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000007', 'A0462');
INSERT INTO public.tb_r_tools VALUES (373, 47, 'A0463', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000008', 'A0463');
INSERT INTO public.tb_r_tools VALUES (374, 48, 'A0464', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'MC - 952 - 000001', 'A0464');
INSERT INTO public.tb_r_tools VALUES (375, 48, 'A0465', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'MC - 952 - 000002', 'A0465');
INSERT INTO public.tb_r_tools VALUES (376, 48, 'A0466', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'MC - 952 - 000003', 'A0466');
INSERT INTO public.tb_r_tools VALUES (377, 48, 'A0467', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'MC - 952 - 000004', 'A0467');
INSERT INTO public.tb_r_tools VALUES (378, 48, 'A0468', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'MC - 952 - 000005', 'A0468');
INSERT INTO public.tb_r_tools VALUES (379, 48, 'A0469', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'MC - 952 - 000006', 'A0469');
INSERT INTO public.tb_r_tools VALUES (380, 48, 'A0470', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'MC - 952 - 000007', 'A0470');
INSERT INTO public.tb_r_tools VALUES (381, 48, 'A0471', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'MC - 952 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (382, 49, 'A0473', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 01678 - 000001', 'A0473');
INSERT INTO public.tb_r_tools VALUES (383, 49, 'A0474', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 01678 - 000002', 'A0474');
INSERT INTO public.tb_r_tools VALUES (384, 49, 'A0475', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 01678 - 000003', 'A0475');
INSERT INTO public.tb_r_tools VALUES (385, 49, 'A0476', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 01678 - 000004', 'A0476');
INSERT INTO public.tb_r_tools VALUES (386, 49, 'A0477', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 01678 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (387, 49, 'A0478', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 01678 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (388, 49, 'A0479', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 01678 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (389, 49, 'A0480', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 01678 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (390, 50, 'A0481', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 04104 - 000001', 'A0481');
INSERT INTO public.tb_r_tools VALUES (391, 50, 'A0482', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 04104 - 000002', 'A0482');
INSERT INTO public.tb_r_tools VALUES (392, 50, 'A0483', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 04104 - 000003', 'A0483');
INSERT INTO public.tb_r_tools VALUES (393, 50, 'A0484', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 04104 - 000004', 'A0484');
INSERT INTO public.tb_r_tools VALUES (394, 50, 'A0485', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 04104 - 000005', 'A0485');
INSERT INTO public.tb_r_tools VALUES (395, 50, 'A0486', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 04104 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (396, 50, 'A0487', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 04104 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (397, 50, 'A0488', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 04104 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (398, 51, 'A0489', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000001', 'A0489');
INSERT INTO public.tb_r_tools VALUES (399, 51, 'A0490', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000002', 'A0490');
INSERT INTO public.tb_r_tools VALUES (400, 51, 'A0491', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000003', 'A0491');
INSERT INTO public.tb_r_tools VALUES (401, 51, 'A0492', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000004', 'A0492');
INSERT INTO public.tb_r_tools VALUES (402, 51, 'A0493', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000005', 'A0493');
INSERT INTO public.tb_r_tools VALUES (403, 51, 'A0494', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000006', 'A0494');
INSERT INTO public.tb_r_tools VALUES (404, 51, 'A0495', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000007', 'A0495');
INSERT INTO public.tb_r_tools VALUES (405, 51, 'A0496', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000008', 'A0496');
INSERT INTO public.tb_r_tools VALUES (406, 51, 'A0497', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000009', 'A0497');
INSERT INTO public.tb_r_tools VALUES (407, 51, 'A0498', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000010', NULL);
INSERT INTO public.tb_r_tools VALUES (408, 51, 'A0499', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000011', NULL);
INSERT INTO public.tb_r_tools VALUES (409, 51, 'A0500', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000012', NULL);
INSERT INTO public.tb_r_tools VALUES (410, 52, 'A0501', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 08169 - 000001', 'A0501');
INSERT INTO public.tb_r_tools VALUES (411, 52, 'A0502', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 08169 - 000002', 'A0502');
INSERT INTO public.tb_r_tools VALUES (412, 52, 'A0503', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 08169 - 000003', 'A0503');
INSERT INTO public.tb_r_tools VALUES (413, 52, 'A0504', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 08169 - 000004', 'A0504');
INSERT INTO public.tb_r_tools VALUES (414, 52, 'A0505', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 08169 - 000005', 'A0505');
INSERT INTO public.tb_r_tools VALUES (415, 52, 'A0506', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 08169 - 000006', 'A0506');
INSERT INTO public.tb_r_tools VALUES (416, 52, 'A0507', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 08169 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (417, 52, 'A0508', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 08169 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (418, 53, 'A0510', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000001', 'A0510');
INSERT INTO public.tb_r_tools VALUES (419, 53, 'A0511', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000002', 'A0511');
INSERT INTO public.tb_r_tools VALUES (420, 53, 'A0512', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000003', 'A0512');
INSERT INTO public.tb_r_tools VALUES (421, 53, 'A0513', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000004', 'A0513');
INSERT INTO public.tb_r_tools VALUES (422, 53, 'A0514', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000005', 'A0514');
INSERT INTO public.tb_r_tools VALUES (423, 53, 'A0515', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000006', 'A0515');
INSERT INTO public.tb_r_tools VALUES (424, 53, 'A0516', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000007', 'A0516');
INSERT INTO public.tb_r_tools VALUES (425, 53, 'A0517', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000008', 'A0517');
INSERT INTO public.tb_r_tools VALUES (426, 54, 'A0518', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000001', 'A0518');
INSERT INTO public.tb_r_tools VALUES (427, 54, 'A0519', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000002', 'A0519');
INSERT INTO public.tb_r_tools VALUES (428, 54, 'A0520', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000003', 'A0520');
INSERT INTO public.tb_r_tools VALUES (429, 54, 'A0521', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000004', 'A0521');
INSERT INTO public.tb_r_tools VALUES (430, 54, 'A0522', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000005', 'A0522');
INSERT INTO public.tb_r_tools VALUES (431, 54, 'A0523', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (432, 54, 'A0524', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (433, 54, 'A0525', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (434, 55, 'A0526', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 09130 - 000001', 'A0526');
INSERT INTO public.tb_r_tools VALUES (435, 55, 'A0527', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 09130 - 000002', 'A0527');
INSERT INTO public.tb_r_tools VALUES (436, 55, 'A0528', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 09130 - 000003', 'A0528');
INSERT INTO public.tb_r_tools VALUES (437, 55, 'A0529', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 09130 - 000004', 'A0529');
INSERT INTO public.tb_r_tools VALUES (438, 55, 'A0530', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 09130 - 000005', 'A0530');
INSERT INTO public.tb_r_tools VALUES (439, 55, 'A0531', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 09130 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (440, 55, 'A0532', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 09130 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (441, 55, 'A0533', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 09130 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (442, 56, 'A0534', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10249 - 000001', 'A0534');
INSERT INTO public.tb_r_tools VALUES (443, 56, 'A0536', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10249 - 000002', 'A0536');
INSERT INTO public.tb_r_tools VALUES (444, 56, 'A0537', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10249 - 000003', 'A0537');
INSERT INTO public.tb_r_tools VALUES (445, 56, 'A0538', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10249 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (446, 56, 'A0539', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10249 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (447, 56, 'A0540', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10249 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (448, 56, 'A0541', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10249 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (449, 56, 'A0542', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10249 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (450, 57, 'A0545', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10250 DIC - 000001', 'A0545');
INSERT INTO public.tb_r_tools VALUES (451, 57, 'A0546', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10250 DIC - 000002', 'A0546');
INSERT INTO public.tb_r_tools VALUES (452, 57, 'A0547', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10250 DIC - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (453, 57, 'A0548', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10250 DIC - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (454, 57, 'A0549', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10250 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (455, 57, 'A0550', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10250 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (456, 57, 'A0551', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10250 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (457, 57, 'A0552', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10250 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (458, 58, 'A0553', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 10279 DIC - 000001', 'A0553');
INSERT INTO public.tb_r_tools VALUES (459, 58, 'A0554', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 10279 DIC - 000002', 'A0554');
INSERT INTO public.tb_r_tools VALUES (460, 58, 'A0555', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 10279 DIC - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (461, 58, 'A0556', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 10279 DIC - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (462, 58, 'A0557', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 10279 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (463, 58, 'A0558', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 10279 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (464, 58, 'A0559', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 10279 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (465, 58, 'A0560', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 10279 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (466, 59, 'A0562', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 25000, 'RSW - 11178 DIC - 000001', 'A0562');
INSERT INTO public.tb_r_tools VALUES (467, 59, 'A0563', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 25000, 'RSW - 11178 DIC - 000002', NULL);
INSERT INTO public.tb_r_tools VALUES (468, 59, 'A0564', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 25000, 'RSW - 11178 DIC - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (469, 59, 'A0565', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 25000, 'RSW - 11178 DIC - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (470, 59, 'A0566', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 25000, 'RSW - 11178 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (471, 59, 'A0567', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 25000, 'RSW - 11178 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (472, 59, 'A0568', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 25000, 'RSW - 11178 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (473, 59, 'A0569', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 25000, 'RSW - 11178 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (474, 60, 'A0574', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 11180 DIC - 000001', 'A0574');
INSERT INTO public.tb_r_tools VALUES (475, 60, 'A0575', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 11180 DIC - 000002', 'A0575');
INSERT INTO public.tb_r_tools VALUES (476, 60, 'A0576', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 11180 DIC - 000003', 'A0576');
INSERT INTO public.tb_r_tools VALUES (477, 60, 'A0577', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 11180 DIC - 000004', 'A0577');
INSERT INTO public.tb_r_tools VALUES (478, 60, 'A0580', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 11180 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (479, 60, 'A0582', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 11180 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (480, 60, 'A0583', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 11180 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (481, 60, 'A0587', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'RSW - 11180 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (482, 61, 'A0591', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 50000, 'RSW - 13004 DIC - 000001', 'A0591');
INSERT INTO public.tb_r_tools VALUES (483, 61, 'A0592', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 50000, 'RSW - 13004 DIC - 000002', 'A0592');
INSERT INTO public.tb_r_tools VALUES (484, 61, 'A0593', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 50000, 'RSW - 13004 DIC - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (485, 61, 'A0594', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 50000, 'RSW - 13004 DIC - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (486, 61, 'A0595', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 50000, 'RSW - 13004 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (487, 61, 'A0596', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 50000, 'RSW - 13004 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (488, 61, 'A0597', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 50000, 'RSW - 13004 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (489, 61, 'A0598', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 50000, 'RSW - 13004 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (490, 62, 'A0600', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 75000, 'RSW - 13005 DIC - 000001', 'A0600');
INSERT INTO public.tb_r_tools VALUES (491, 62, 'A0601', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 75000, 'RSW - 13005 DIC - 000002', 'A0601');
INSERT INTO public.tb_r_tools VALUES (492, 62, 'A0602', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 75000, 'RSW - 13005 DIC - 000003', 'A0602');
INSERT INTO public.tb_r_tools VALUES (493, 62, 'A0603', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 75000, 'RSW - 13005 DIC - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (494, 62, 'A0604', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 75000, 'RSW - 13005 DIC - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (495, 62, 'A0605', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 75000, 'RSW - 13005 DIC - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (496, 62, 'A0606', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 75000, 'RSW - 13005 DIC - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (497, 62, 'A0607', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 75000, 'RSW - 13005 DIC - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (498, 63, 'A0616', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000001', 'A0616');
INSERT INTO public.tb_r_tools VALUES (499, 63, 'A0617', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000002', 'A0617');
INSERT INTO public.tb_r_tools VALUES (500, 63, 'A0618', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000003', 'A0618');
INSERT INTO public.tb_r_tools VALUES (501, 63, 'A0619', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000004', 'A0619');
INSERT INTO public.tb_r_tools VALUES (502, 63, 'A0620', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000005', 'A0620');
INSERT INTO public.tb_r_tools VALUES (503, 63, 'A0621', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000006', 'A0621');
INSERT INTO public.tb_r_tools VALUES (504, 63, 'A0622', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000007', 'A0622');
INSERT INTO public.tb_r_tools VALUES (505, 63, 'A0623', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000008', 'A0623');
INSERT INTO public.tb_r_tools VALUES (506, 64, 'A0624', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000001', 'A0624');
INSERT INTO public.tb_r_tools VALUES (507, 64, 'A0625', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000002', 'A0625');
INSERT INTO public.tb_r_tools VALUES (508, 64, 'A0626', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000003', 'A0626');
INSERT INTO public.tb_r_tools VALUES (509, 64, 'A0627', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000004', 'A0627');
INSERT INTO public.tb_r_tools VALUES (510, 64, 'A0628', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000005', 'A0628');
INSERT INTO public.tb_r_tools VALUES (511, 64, 'A0629', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000006', 'A0629');
INSERT INTO public.tb_r_tools VALUES (512, 64, 'A0630', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000007', 'A0630');
INSERT INTO public.tb_r_tools VALUES (513, 64, 'A0631', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000008', 'A0631');
INSERT INTO public.tb_r_tools VALUES (514, 65, 'A0634', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'ZC - 0301 - 000001', 'A0634');
INSERT INTO public.tb_r_tools VALUES (515, 65, 'A0635', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'ZC - 0301 - 000002', 'A0635');
INSERT INTO public.tb_r_tools VALUES (516, 65, 'A0636', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'ZC - 0301 - 000003', 'A0636');
INSERT INTO public.tb_r_tools VALUES (517, 65, 'A0637', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'ZC - 0301 - 000004', 'A0637');
INSERT INTO public.tb_r_tools VALUES (518, 65, 'A0638', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'ZC - 0301 - 000005', 'A0638');
INSERT INTO public.tb_r_tools VALUES (519, 65, 'A0639', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'ZC - 0301 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (520, 65, 'A0640', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'ZC - 0301 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (521, 65, 'A0641', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'ZC - 0301 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (522, 66, 'A0642', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'ZC - 0603 - 000001', 'A0642');
INSERT INTO public.tb_r_tools VALUES (523, 66, 'A0643', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'ZC - 0603 - 000002', 'A0643');
INSERT INTO public.tb_r_tools VALUES (524, 66, 'A0644', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'ZC - 0603 - 000003', 'A0644');
INSERT INTO public.tb_r_tools VALUES (525, 66, 'A0645', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'ZC - 0603 - 000004', 'A0645');
INSERT INTO public.tb_r_tools VALUES (526, 66, 'A0646', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'ZC - 0603 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (527, 66, 'A0647', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'ZC - 0603 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (528, 66, 'A0648', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'ZC - 0603 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (529, 66, 'A0649', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'ZC - 0603 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (530, 67, 'A0650', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'ZC - 1012 - 000001', 'A0650');
INSERT INTO public.tb_r_tools VALUES (531, 67, 'A0651', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'ZC - 1012 - 000002', 'A0651');
INSERT INTO public.tb_r_tools VALUES (532, 67, 'A0652', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'ZC - 1012 - 000003', 'A0652');
INSERT INTO public.tb_r_tools VALUES (533, 67, 'A0653', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'ZC - 1012 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (534, 67, 'A0654', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'ZC - 1012 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (535, 67, 'A0655', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'ZC - 1012 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (536, 67, 'A0656', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'ZC - 1012 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (537, 67, 'A0657', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'ZC - 1012 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (538, 68, 'A0661', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000001', 'A0661');
INSERT INTO public.tb_r_tools VALUES (539, 68, 'A0662', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000002', 'A0662');
INSERT INTO public.tb_r_tools VALUES (540, 68, 'A0663', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000003', 'A0663');
INSERT INTO public.tb_r_tools VALUES (541, 68, 'A0664', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000004', 'A0664');
INSERT INTO public.tb_r_tools VALUES (542, 68, 'A0665', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000005', 'A0665');
INSERT INTO public.tb_r_tools VALUES (543, 68, 'A0666', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000006', 'A0666');
INSERT INTO public.tb_r_tools VALUES (544, 68, 'A0667', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (545, 68, 'A0668', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000008', 'A0668');
INSERT INTO public.tb_r_tools VALUES (546, 69, 'A0672', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001TIN - 000001', 'A0672');
INSERT INTO public.tb_r_tools VALUES (547, 69, 'A0673', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001TIN - 000002', 'A0673');
INSERT INTO public.tb_r_tools VALUES (548, 69, 'A0674', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001TIN - 000003', 'A0674');
INSERT INTO public.tb_r_tools VALUES (549, 69, 'A0675', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001TIN - 000004', 'A0675');
INSERT INTO public.tb_r_tools VALUES (550, 69, 'A0676', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001TIN - 000005', 'A0676');
INSERT INTO public.tb_r_tools VALUES (551, 69, 'A0677', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001TIN - 000006', 'A0677');
INSERT INTO public.tb_r_tools VALUES (552, 69, 'A0678', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001TIN - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (553, 69, 'A0679', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001TIN - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (554, 15, 'A0683', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 001', 'A0683');
INSERT INTO public.tb_r_tools VALUES (555, 52, 'A0684', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 4000, 'RSW - 08169 - 001', 'A0684');
INSERT INTO public.tb_r_tools VALUES (556, 15, 'A0685', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 07151 - 002', 'A0685');
INSERT INTO public.tb_r_tools VALUES (557, 2, 'A0686', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000003', 'A0686');
INSERT INTO public.tb_r_tools VALUES (558, 70, 'A0688', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00001', 'A0688');
INSERT INTO public.tb_r_tools VALUES (559, 2, 'A0690', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000002', 'A0690');
INSERT INTO public.tb_r_tools VALUES (560, 71, 'A0692', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-14011-0001', 'A0692');
INSERT INTO public.tb_r_tools VALUES (561, 71, 'A0694', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-14011-0002', NULL);
INSERT INTO public.tb_r_tools VALUES (562, 72, 'A0695', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000009', 'A0695');
INSERT INTO public.tb_r_tools VALUES (563, 72, 'A0699', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000010', 'A0699');
INSERT INTO public.tb_r_tools VALUES (564, 72, 'A0701', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000011', 'A0701');
INSERT INTO public.tb_r_tools VALUES (565, 72, 'A0703', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000012', 'A0703');
INSERT INTO public.tb_r_tools VALUES (566, 72, 'A0704', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000013', 'A0704');
INSERT INTO public.tb_r_tools VALUES (567, 72, 'A0705', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW-0487-00014', 'A0705');
INSERT INTO public.tb_r_tools VALUES (568, 72, 'A0706', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW-0487-00015', 'A0706');
INSERT INTO public.tb_r_tools VALUES (569, 72, 'A0707', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW-0487-00016', 'A0707');
INSERT INTO public.tb_r_tools VALUES (570, 72, 'A0708', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW-0487-00017', 'A0708');
INSERT INTO public.tb_r_tools VALUES (571, 72, 'A0709', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00018', 'A0709');
INSERT INTO public.tb_r_tools VALUES (572, 72, 'A0710', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00019', 'A0710');
INSERT INTO public.tb_r_tools VALUES (573, 72, 'A0712', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00020', 'A0712');
INSERT INTO public.tb_r_tools VALUES (574, 72, 'A0713', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00021', 'A0713');
INSERT INTO public.tb_r_tools VALUES (575, 72, 'A0714', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00022', 'A0714');
INSERT INTO public.tb_r_tools VALUES (576, 72, 'A0715', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00023', 'A0715');
INSERT INTO public.tb_r_tools VALUES (577, 72, 'A0716', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00024', 'A0716');
INSERT INTO public.tb_r_tools VALUES (578, 72, 'A0717', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00025', 'A0717');
INSERT INTO public.tb_r_tools VALUES (579, 72, 'A0718', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00026', 'A0718');
INSERT INTO public.tb_r_tools VALUES (580, 72, 'A0719', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00027', 'A0719');
INSERT INTO public.tb_r_tools VALUES (581, 72, 'A0720', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00028', 'A0720');
INSERT INTO public.tb_r_tools VALUES (582, 72, 'A0721', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00029', NULL);
INSERT INTO public.tb_r_tools VALUES (583, 72, 'A0722', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW-0487-00030', 'A0722');
INSERT INTO public.tb_r_tools VALUES (584, 73, 'A0724', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 010171 - 000001', 'A0724');
INSERT INTO public.tb_r_tools VALUES (585, 73, 'A0725', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 010171 - 000002', 'A0725');
INSERT INTO public.tb_r_tools VALUES (586, 73, 'A0726', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 010171 - 000003', 'A0726');
INSERT INTO public.tb_r_tools VALUES (587, 73, 'A0727', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 010171 - 000004', 'A0727');
INSERT INTO public.tb_r_tools VALUES (588, 73, 'A0728', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 010171 - 000005', 'A0728');
INSERT INTO public.tb_r_tools VALUES (589, 73, 'A0729', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 010171 - 000006', 'A0729');
INSERT INTO public.tb_r_tools VALUES (590, 73, 'A0730', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 010171 - 000007', 'A0730');
INSERT INTO public.tb_r_tools VALUES (591, 73, 'A0731', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 010171 - 000008', 'A0731');
INSERT INTO public.tb_r_tools VALUES (592, 74, 'A0734', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN  - 00001', 'A0734');
INSERT INTO public.tb_r_tools VALUES (593, 75, 'A0735', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 11126 TIN  - 00002', 'A0735');
INSERT INTO public.tb_r_tools VALUES (594, 75, 'A0738', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 11126 TIN  - 00003', 'A0738');
INSERT INTO public.tb_r_tools VALUES (595, 75, 'A0739', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 11126 TIN - 00004', 'A0739');
INSERT INTO public.tb_r_tools VALUES (596, 75, 'A0740', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 11126 TIN - 00005', 'A0740');
INSERT INTO public.tb_r_tools VALUES (597, 75, 'A0741', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 11126 TIN - 00006', 'A0741');
INSERT INTO public.tb_r_tools VALUES (598, 75, 'A0742', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 11126 TIN - 00007', 'A0742');
INSERT INTO public.tb_r_tools VALUES (599, 75, 'A0743', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 11126 TIN - 00008', 'A0743');
INSERT INTO public.tb_r_tools VALUES (600, 74, 'A0744', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN - 00009', 'A0744');
INSERT INTO public.tb_r_tools VALUES (601, 71, 'A0745', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00001', 'A0745');
INSERT INTO public.tb_r_tools VALUES (602, 71, 'A0747', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00002', 'A0747');
INSERT INTO public.tb_r_tools VALUES (603, 71, 'A0749', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00003', 'A0749');
INSERT INTO public.tb_r_tools VALUES (604, 71, 'A0750', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00004', 'A0750');
INSERT INTO public.tb_r_tools VALUES (605, 71, 'A0751', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00005', 'A0751');
INSERT INTO public.tb_r_tools VALUES (606, 71, 'A0752', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00006', 'A0752');
INSERT INTO public.tb_r_tools VALUES (607, 71, 'A0755', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00007', 'A0755');
INSERT INTO public.tb_r_tools VALUES (608, 71, 'A0758', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00008', 'A0758');
INSERT INTO public.tb_r_tools VALUES (609, 76, 'A0759', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'EC - 0544 TIN - 00001', 'A0759');
INSERT INTO public.tb_r_tools VALUES (610, 76, 'A0760', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'EC - 0544 TIN - 00002', 'A0760');
INSERT INTO public.tb_r_tools VALUES (611, 76, 'A0761', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EC - 0544 TIN - 00003', 'A0761');
INSERT INTO public.tb_r_tools VALUES (612, 76, 'A0762', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EC - 0544 TIN - 00004', 'A0762');
INSERT INTO public.tb_r_tools VALUES (613, 76, 'A0763', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EC - 0544 TIN - 00005', 'A0763');
INSERT INTO public.tb_r_tools VALUES (614, 76, 'A0764', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EC - 0544 TIN - 00006', 'A0764');
INSERT INTO public.tb_r_tools VALUES (615, 76, 'A0765', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EC - 0544 TIN - 00007', 'A0765');
INSERT INTO public.tb_r_tools VALUES (616, 76, 'A0766', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EC - 0544 TIN - 00008', 'A0766');
INSERT INTO public.tb_r_tools VALUES (617, 77, 'A0769', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00001', 'A0769');
INSERT INTO public.tb_r_tools VALUES (618, 77, 'A0770', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00002', 'A0770');
INSERT INTO public.tb_r_tools VALUES (619, 77, 'A0771', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00003', 'A0771');
INSERT INTO public.tb_r_tools VALUES (620, 77, 'A0772', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00004', 'A0772');
INSERT INTO public.tb_r_tools VALUES (621, 77, 'A0775', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00005', 'A0775');
INSERT INTO public.tb_r_tools VALUES (622, 77, 'A0776', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00006', 'A0776');
INSERT INTO public.tb_r_tools VALUES (623, 77, 'A0777', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00007', 'A0777');
INSERT INTO public.tb_r_tools VALUES (624, 77, 'A0778', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00008', 'A0778');
INSERT INTO public.tb_r_tools VALUES (625, 40, 'A0781', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00009', 'A0781');
INSERT INTO public.tb_r_tools VALUES (626, 40, 'A0782', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00010', 'A0782');
INSERT INTO public.tb_r_tools VALUES (627, 40, 'A0784', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00011', 'A0784');
INSERT INTO public.tb_r_tools VALUES (628, 40, 'A0785', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00012', 'A0785');
INSERT INTO public.tb_r_tools VALUES (629, 40, 'A0786', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00013', 'A0786');
INSERT INTO public.tb_r_tools VALUES (630, 40, 'A0787', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00014', 'A0787');
INSERT INTO public.tb_r_tools VALUES (631, 40, 'A0788', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00015', 'A0788');
INSERT INTO public.tb_r_tools VALUES (632, 40, 'A0789', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00016', 'A0789');
INSERT INTO public.tb_r_tools VALUES (633, 35, 'A0790', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 00009', 'A0790');
INSERT INTO public.tb_r_tools VALUES (634, 35, 'A0791', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 00010', 'A0791');
INSERT INTO public.tb_r_tools VALUES (635, 35, 'A0792', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 00011', 'A0792');
INSERT INTO public.tb_r_tools VALUES (636, 35, 'A0793', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 00012', 'A0793');
INSERT INTO public.tb_r_tools VALUES (637, 35, 'A0794', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 00013', 'A0794');
INSERT INTO public.tb_r_tools VALUES (638, 35, 'A0795', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 00014', 'A0795');
INSERT INTO public.tb_r_tools VALUES (639, 35, 'A0796', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 00015', 'A0796');
INSERT INTO public.tb_r_tools VALUES (640, 35, 'A0797', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 00016', 'A0797');
INSERT INTO public.tb_r_tools VALUES (641, 40, 'A0799', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00017', 'A0799');
INSERT INTO public.tb_r_tools VALUES (642, 77, 'A0800', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00010', 'A0800');
INSERT INTO public.tb_r_tools VALUES (643, 77, 'A0801', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00011', 'A0801');
INSERT INTO public.tb_r_tools VALUES (644, 77, 'A0802', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00012', 'A0802');
INSERT INTO public.tb_r_tools VALUES (645, 77, 'A0804', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00013', 'A0804');
INSERT INTO public.tb_r_tools VALUES (646, 77, 'A0805', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00014', 'A0805');
INSERT INTO public.tb_r_tools VALUES (647, 77, 'A0806', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00015', 'A0806');
INSERT INTO public.tb_r_tools VALUES (648, 77, 'A0807', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00016', 'A0807');
INSERT INTO public.tb_r_tools VALUES (649, 78, 'A0808', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TEST', 'A0808');
INSERT INTO public.tb_r_tools VALUES (650, 77, 'A0811', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00009', 'A0811');
INSERT INTO public.tb_r_tools VALUES (651, 79, 'A0815', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00001', 'A0815');
INSERT INTO public.tb_r_tools VALUES (652, 79, 'A0816', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00002', 'A0816');
INSERT INTO public.tb_r_tools VALUES (653, 79, 'A0817', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00003', 'A0817');
INSERT INTO public.tb_r_tools VALUES (654, 79, 'A0818', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00004', 'A0818');
INSERT INTO public.tb_r_tools VALUES (655, 79, 'A0819', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (656, 79, 'A0820', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (657, 79, 'A0821', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (658, 79, 'A0822', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW - 05177 TIN - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (659, 80, 'A0825', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00001', 'A0825');
INSERT INTO public.tb_r_tools VALUES (660, 81, 'A0827', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00002', 'A0827');
INSERT INTO public.tb_r_tools VALUES (661, 81, 'A0828', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00003', 'A0828');
INSERT INTO public.tb_r_tools VALUES (662, 81, 'A0829', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00004', 'A0829');
INSERT INTO public.tb_r_tools VALUES (663, 81, 'A0830', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00005', 'A0830');
INSERT INTO public.tb_r_tools VALUES (664, 81, 'A0831', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (665, 81, 'A0832', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (666, 81, 'A0833', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (667, 81, 'A0834', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00009', NULL);
INSERT INTO public.tb_r_tools VALUES (668, 81, 'A0835', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00010', NULL);
INSERT INTO public.tb_r_tools VALUES (669, 81, 'A0836', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00011', NULL);
INSERT INTO public.tb_r_tools VALUES (670, 81, 'A0837', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00012', NULL);
INSERT INTO public.tb_r_tools VALUES (671, 81, 'A0838', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00013', NULL);
INSERT INTO public.tb_r_tools VALUES (672, 81, 'A0839', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00014', NULL);
INSERT INTO public.tb_r_tools VALUES (673, 81, 'A0840', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00015', NULL);
INSERT INTO public.tb_r_tools VALUES (674, 81, 'A0841', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSSW - 04120A  - 00016', NULL);
INSERT INTO public.tb_r_tools VALUES (675, 53, 'A0843', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000009', 'A0843');
INSERT INTO public.tb_r_tools VALUES (676, 82, 'A0844', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'RSW - 12128 - 00001', 'A0844');
INSERT INTO public.tb_r_tools VALUES (677, 82, 'A0845', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'RSW - 12128 - 00002', 'A0845');
INSERT INTO public.tb_r_tools VALUES (678, 82, 'A0846', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'RSW - 12128 - 00003', NULL);
INSERT INTO public.tb_r_tools VALUES (679, 82, 'A0847', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'RSW - 12128 - 00004', NULL);
INSERT INTO public.tb_r_tools VALUES (680, 82, 'A0848', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'RSW - 12128 - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (681, 82, 'A0849', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'RSW - 12128 - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (682, 82, 'A0850', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'RSW - 12128 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (683, 82, 'A0852', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'RSW - 12128 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (684, 83, 'A0853', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 12142 - 00001', 'A0853');
INSERT INTO public.tb_r_tools VALUES (685, 83, 'A0854', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 12142 - 00002', 'A0854');
INSERT INTO public.tb_r_tools VALUES (686, 84, 'A0855', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 2428 - 00001', 'A0855');
INSERT INTO public.tb_r_tools VALUES (687, 84, 'A0856', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 2428 - 00002', 'A0856');
INSERT INTO public.tb_r_tools VALUES (688, 84, 'A0857', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 2428 - 00003', 'A0857');
INSERT INTO public.tb_r_tools VALUES (689, 84, 'A0858', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 2428 - 00004', NULL);
INSERT INTO public.tb_r_tools VALUES (690, 84, 'A0859', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 2428 - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (691, 84, 'A0860', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 2428 - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (692, 84, 'A0861', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 2428 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (693, 84, 'A0862', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 2428 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (694, 85, 'A0863', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSDW - 2234 - 00001', 'A0863');
INSERT INTO public.tb_r_tools VALUES (695, 85, 'A0864', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSDW - 2234 - 00002', 'A0864');
INSERT INTO public.tb_r_tools VALUES (696, 85, 'A0865', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSDW - 2234 - 00003', 'A0865');
INSERT INTO public.tb_r_tools VALUES (697, 85, 'A0866', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSDW - 2234 - 00004', 'A0866');
INSERT INTO public.tb_r_tools VALUES (698, 85, 'A0867', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSDW - 2234 - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (699, 85, 'A0868', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSDW - 2234 - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (700, 85, 'A0869', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSDW - 2234 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (701, 85, 'A0870', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSDW - 2234 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (702, 16, 'A0872', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'DSDW -8462- 000009', 'A0872');
INSERT INTO public.tb_r_tools VALUES (703, 86, 'A0873', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 10297 - 00001', 'A0873');
INSERT INTO public.tb_r_tools VALUES (704, 86, 'A0874', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSSW - 10297 - 00002', 'A0874');
INSERT INTO public.tb_r_tools VALUES (705, 86, 'A0875', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 10297 - 00003', 'A0875');
INSERT INTO public.tb_r_tools VALUES (706, 86, 'A0876', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 10297 - 00004', 'A0876');
INSERT INTO public.tb_r_tools VALUES (707, 86, 'A0877', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 10297 - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (708, 86, 'A0878', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 10297 - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (709, 86, 'A0879', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 10297 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (710, 86, 'A0880', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 10297 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (711, 70, 'A0882', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00002', 'A0882');
INSERT INTO public.tb_r_tools VALUES (712, 70, 'A0883', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00003', 'A0883');
INSERT INTO public.tb_r_tools VALUES (713, 70, 'A0884', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00004', 'A0884');
INSERT INTO public.tb_r_tools VALUES (714, 70, 'A0885', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00005', 'A0885');
INSERT INTO public.tb_r_tools VALUES (715, 70, 'A0886', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (716, 70, 'A0887', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (717, 70, 'A0888', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (718, 70, 'A0889', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00009', NULL);
INSERT INTO public.tb_r_tools VALUES (719, 70, 'A0890', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 11124 - 00010', NULL);
INSERT INTO public.tb_r_tools VALUES (720, 87, 'A0893', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EZDL - 110 - 00001', 'A0893');
INSERT INTO public.tb_r_tools VALUES (721, 87, 'A0894', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EZDL - 110 - 00002', 'A0894');
INSERT INTO public.tb_r_tools VALUES (722, 87, 'A0895', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EZDL - 110 - 00003', 'A0895');
INSERT INTO public.tb_r_tools VALUES (723, 87, 'A0896', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EZDL - 110 - 00004', 'A0896');
INSERT INTO public.tb_r_tools VALUES (724, 87, 'A0897', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EZDL - 110 - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (725, 87, 'A0898', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EZDL - 110 - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (726, 87, 'A0899', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EZDL - 110 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (727, 87, 'A0900', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'EZDL - 110 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (728, 88, 'A0904', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12256 - 00001', 'A0904');
INSERT INTO public.tb_r_tools VALUES (729, 88, 'A0905', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12256 - 00002', 'A0905');
INSERT INTO public.tb_r_tools VALUES (730, 88, 'A0906', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12256 - 00003', 'A0906');
INSERT INTO public.tb_r_tools VALUES (731, 88, 'A0907', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12256 - 00004', NULL);
INSERT INTO public.tb_r_tools VALUES (732, 88, 'A0908', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12256 - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (733, 88, 'A0909', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12256 - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (734, 88, 'A0910', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12256 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (735, 88, 'A0911', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12256 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (736, 89, 'A0913', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 14010 - 00001', 'A0913');
INSERT INTO public.tb_r_tools VALUES (737, 89, 'A0914', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 14010 - 00002', 'A0914');
INSERT INTO public.tb_r_tools VALUES (738, 89, 'A0915', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 14010 - 00003', 'A0915');
INSERT INTO public.tb_r_tools VALUES (739, 89, 'A0916', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 14010 - 00004', 'A0916');
INSERT INTO public.tb_r_tools VALUES (740, 89, 'A0917', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 14010 - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (741, 89, 'A0918', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 14010 - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (742, 89, 'A0919', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 14010 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (743, 89, 'A0920', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 14010 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (744, 90, 'A0923', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 06311 - 00001', 'A0923');
INSERT INTO public.tb_r_tools VALUES (745, 90, 'A0924', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 06311 - 00002', 'A0924');
INSERT INTO public.tb_r_tools VALUES (746, 90, 'A0925', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 06311 - 00003', 'A0925');
INSERT INTO public.tb_r_tools VALUES (747, 90, 'A0926', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 06311 - 00004', NULL);
INSERT INTO public.tb_r_tools VALUES (748, 90, 'A0927', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 06311 - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (749, 90, 'A0928', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 06311 - 00006', NULL);
INSERT INTO public.tb_r_tools VALUES (750, 90, 'A0929', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 06311 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (751, 90, 'A0930', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 06311 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (752, 91, 'A0933', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 06465 CH OP 10 - 000001', 'A0933');
INSERT INTO public.tb_r_tools VALUES (753, 91, 'A0934', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 06465 CH OP 10 - 000002', 'A0934');
INSERT INTO public.tb_r_tools VALUES (754, 91, 'A0935', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 06465 CH OP 10 - 000003', 'A0935');
INSERT INTO public.tb_r_tools VALUES (755, 91, 'A0936', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 06465 CH OP 10 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (756, 91, 'A0937', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 06465 CH OP 10 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (757, 91, 'A0938', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 06465 CH OP 10 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (758, 91, 'A0939', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 06465 CH OP 10 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (759, 91, 'A0940', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 06465 CH OP 10 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (760, 92, 'A0942', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSDW - 06465 CH OP 70 - 000001', 'A0942');
INSERT INTO public.tb_r_tools VALUES (761, 92, 'A0943', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSDW - 06465 CH OP 70 - 000002', 'A0943');
INSERT INTO public.tb_r_tools VALUES (762, 92, 'A0944', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSDW - 06465 CH OP 70 - 000003', 'A0944');
INSERT INTO public.tb_r_tools VALUES (763, 92, 'A0945', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSDW - 06465 CH OP 70 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (764, 92, 'A0946', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSDW - 06465 CH OP 70 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (765, 92, 'A0947', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSDW - 06465 CH OP 70 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (766, 92, 'A0948', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSDW - 06465 CH OP 70 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (767, 92, 'A0949', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'DSDW - 06465 CH OP 70 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (768, 93, 'A0951', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, ' DSDW 10458 - 000001', 'A0951');
INSERT INTO public.tb_r_tools VALUES (769, 93, 'A0952', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, ' DSDW 10458 - 000002', 'A0952');
INSERT INTO public.tb_r_tools VALUES (770, 93, 'A0954', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, ' DSDW 10458 - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (771, 93, 'A0955', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, ' DSDW 10458 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (772, 93, 'A0957', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, ' DSDW 10458 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (773, 93, 'A0958', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, ' DSDW 10458 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (774, 93, 'A0959', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, ' DSDW 10458 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (775, 93, 'A0960', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, ' DSDW 10458 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (776, 94, 'A0962', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 10403 - 00001', 'A0962');
INSERT INTO public.tb_r_tools VALUES (777, 94, 'A0963', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 10403 - 00002', 'A0963');
INSERT INTO public.tb_r_tools VALUES (778, 94, 'A0964', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 10403 - 00003', 'A0964');
INSERT INTO public.tb_r_tools VALUES (779, 94, 'A0965', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 10403 - 00004', 'A0965');
INSERT INTO public.tb_r_tools VALUES (780, 94, 'A0966', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 10403 - 00005', NULL);
INSERT INTO public.tb_r_tools VALUES (781, 94, 'A0967', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 10403 - 00007', NULL);
INSERT INTO public.tb_r_tools VALUES (782, 94, 'A0968', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 10403 - 00008', NULL);
INSERT INTO public.tb_r_tools VALUES (783, 95, 'A0970', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'DSS - 0550 - 000001', 'A0970');
INSERT INTO public.tb_r_tools VALUES (784, 95, 'A0971', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'DSS - 0550 - 000002', 'A0971');
INSERT INTO public.tb_r_tools VALUES (785, 95, 'A0972', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'DSS - 0550 - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (786, 95, 'A0973', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'DSS - 0550 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (787, 95, 'A0974', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'DSS - 0550 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (788, 95, 'A0975', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'DSS - 0550 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (789, 95, 'A0976', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'DSS - 0550 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (790, 95, 'A0977', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'DSS - 0550 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (791, 44, 'A0980', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000009', 'A0980');
INSERT INTO public.tb_r_tools VALUES (792, 44, 'A0982', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000010', 'A0982');
INSERT INTO public.tb_r_tools VALUES (793, 44, 'A0983', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000011', 'A0983');
INSERT INTO public.tb_r_tools VALUES (794, 44, 'A0984', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000012', 'A0984');
INSERT INTO public.tb_r_tools VALUES (795, 44, 'A0985', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000013', NULL);
INSERT INTO public.tb_r_tools VALUES (796, 44, 'A0986', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000014', NULL);
INSERT INTO public.tb_r_tools VALUES (797, 44, 'A0987', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000015', 'A0987');
INSERT INTO public.tb_r_tools VALUES (798, 44, 'A0988', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 - 000016', NULL);
INSERT INTO public.tb_r_tools VALUES (799, 96, 'A0990', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'ZC - 1507 - 000001', 'A0990');
INSERT INTO public.tb_r_tools VALUES (800, 96, 'A0991', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'ZC - 1507 - 000002', 'A0991');
INSERT INTO public.tb_r_tools VALUES (801, 96, 'A0992', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'ZC - 1507 - 000003', 'A0992');
INSERT INTO public.tb_r_tools VALUES (802, 96, 'A0993', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'ZC - 1507 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (803, 96, 'A0994', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'ZC - 1507 - 000005', 'A0994');
INSERT INTO public.tb_r_tools VALUES (804, 96, 'A0995', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'ZC - 1507 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (805, 96, 'A0996', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'ZC - 1507 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (806, 96, 'A0997', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'ZC - 1507 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (807, 97, 'A0999', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'ZC - 1917 - 000001', 'A0999');
INSERT INTO public.tb_r_tools VALUES (808, 97, 'A1000', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'ZC - 1917 - 000002', 'A1000');
INSERT INTO public.tb_r_tools VALUES (809, 97, 'A1001', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'ZC - 1917 - 000003', 'A1001');
INSERT INTO public.tb_r_tools VALUES (810, 97, 'A1002', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'ZC - 1917 - 000004', 'A1002');
INSERT INTO public.tb_r_tools VALUES (811, 97, 'A1003', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'ZC - 1917 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (812, 97, 'A1004', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'ZC - 1917 - 000005', 'A1004');
INSERT INTO public.tb_r_tools VALUES (813, 97, 'A1005', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'ZC - 1917 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (814, 97, 'A1006', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'ZC - 1917 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (815, 98, 'A1008', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 11235 CB (OP-70) - 000001', 'A1008');
INSERT INTO public.tb_r_tools VALUES (816, 98, 'A1009', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 11235 CB (OP-70) - 000002', 'A1009');
INSERT INTO public.tb_r_tools VALUES (817, 98, 'A1010', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 11235 CB (OP-70) - 000003', NULL);
INSERT INTO public.tb_r_tools VALUES (818, 98, 'A1011', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 11235 CB (OP-70) - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (819, 98, 'A1012', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 11235 CB (OP-70) - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (820, 98, 'A1013', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 11235 CB (OP-70) - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (821, 98, 'A1014', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 11235 CB (OP-70) - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (822, 98, 'A1015', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSDW - 11235 CB (OP-70) - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (823, 99, 'A1016', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 CB (OP-70) - 000001', 'A1016');
INSERT INTO public.tb_r_tools VALUES (824, 99, 'A1017', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 CB (OP-70) - 000002', 'A1017');
INSERT INTO public.tb_r_tools VALUES (825, 99, 'A1018', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 CB (OP-70) - 000003', 'A1018');
INSERT INTO public.tb_r_tools VALUES (826, 99, 'A1019', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 CB (OP-70) - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (827, 99, 'A1020', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 CB (OP-70) - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (828, 99, 'A1021', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 CB (OP-70) - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (829, 99, 'A1022', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 CB (OP-70) - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (830, 99, 'A1023', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1038 CB (OP-70) - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (831, 100, 'A1025', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 12256 CB - 000001', 'A1025');
INSERT INTO public.tb_r_tools VALUES (832, 100, 'A1026', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 12256 CB - 000002', 'A1026');
INSERT INTO public.tb_r_tools VALUES (833, 100, 'A1027', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 12256 CB - 000003', 'A1027');
INSERT INTO public.tb_r_tools VALUES (834, 100, 'A1028', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 12256 CB - 000004', 'A1028');
INSERT INTO public.tb_r_tools VALUES (835, 100, 'A1029', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 12256 CB - 000005', 'A1029');
INSERT INTO public.tb_r_tools VALUES (836, 100, 'A1030', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 12256 CB - 000006', 'A1030');
INSERT INTO public.tb_r_tools VALUES (837, 100, 'A1031', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 12256 CB - 000007', 'A1031');
INSERT INTO public.tb_r_tools VALUES (838, 100, 'A1032', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'DSSW - 12256 CB - 000008', 'A1032');
INSERT INTO public.tb_r_tools VALUES (839, 101, 'A1035', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12257 - 000001', 'A1035');
INSERT INTO public.tb_r_tools VALUES (840, 101, 'A1036', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12257 - 000002', 'A1036');
INSERT INTO public.tb_r_tools VALUES (841, 101, 'A1037', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12257 - 000003', 'A1037');
INSERT INTO public.tb_r_tools VALUES (842, 101, 'A1038', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12257 - 000004', NULL);
INSERT INTO public.tb_r_tools VALUES (843, 101, 'A1039', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12257 - 000005', NULL);
INSERT INTO public.tb_r_tools VALUES (844, 101, 'A1040', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12257 - 000006', NULL);
INSERT INTO public.tb_r_tools VALUES (845, 101, 'A1041', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12257 - 000007', NULL);
INSERT INTO public.tb_r_tools VALUES (846, 101, 'A1042', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSSW - 12257 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (847, 3, 'A1046', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, ' MC - 1041 - 000005', 'A1046');
INSERT INTO public.tb_r_tools VALUES (848, 3, 'A1047', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, ' MC - 1041 - 000006', 'A1047');
INSERT INTO public.tb_r_tools VALUES (849, 3, 'A1048', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, ' MC - 1041 - 000007', 'A1048');
INSERT INTO public.tb_r_tools VALUES (850, 3, 'A1049', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, ' MC - 1041 - 000008', NULL);
INSERT INTO public.tb_r_tools VALUES (851, 102, 'A1052', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00018', 'A1052');
INSERT INTO public.tb_r_tools VALUES (852, 102, 'A1053', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00019', 'A1053');
INSERT INTO public.tb_r_tools VALUES (853, 102, 'A1054', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00020', 'A1054');
INSERT INTO public.tb_r_tools VALUES (854, 102, 'A1055', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00021', 'A1055');
INSERT INTO public.tb_r_tools VALUES (855, 102, 'A1056', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00022', 'A1056');
INSERT INTO public.tb_r_tools VALUES (856, 102, 'A1057', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00023', 'A1057');
INSERT INTO public.tb_r_tools VALUES (857, 102, 'A1058', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00024', 'A1058');
INSERT INTO public.tb_r_tools VALUES (858, 102, 'A1059', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00025', 'A1059');
INSERT INTO public.tb_r_tools VALUES (859, 102, 'A1060', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00026', 'A1060');
INSERT INTO public.tb_r_tools VALUES (860, 102, 'A1061', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00027', 'A1061');
INSERT INTO public.tb_r_tools VALUES (861, 102, 'A1062', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00028', 'A1062');
INSERT INTO public.tb_r_tools VALUES (862, 102, 'A1063', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00030', 'A1063');
INSERT INTO public.tb_r_tools VALUES (863, 64, 'A1066', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000010', 'A1066');
INSERT INTO public.tb_r_tools VALUES (864, 64, 'A1067', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000011', 'A1067');
INSERT INTO public.tb_r_tools VALUES (865, 64, 'A1068', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000012', 'A1068');
INSERT INTO public.tb_r_tools VALUES (866, 64, 'A1069', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000013', 'A1069');
INSERT INTO public.tb_r_tools VALUES (867, 64, 'A1070', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000014', 'A1070');
INSERT INTO public.tb_r_tools VALUES (868, 64, 'A1071', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000015', 'A1071');
INSERT INTO public.tb_r_tools VALUES (869, 64, 'A1072', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000016', 'A1072');
INSERT INTO public.tb_r_tools VALUES (870, 64, 'A1073', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000017', 'A1073');
INSERT INTO public.tb_r_tools VALUES (871, 64, 'A1074', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000018', 'A1074');
INSERT INTO public.tb_r_tools VALUES (872, 64, 'A1075', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000019', 'A1075');
INSERT INTO public.tb_r_tools VALUES (873, 64, 'A1076', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000020', 'A1076');
INSERT INTO public.tb_r_tools VALUES (874, 2, 'A1079', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000004', 'A1079');
INSERT INTO public.tb_r_tools VALUES (875, 2, 'A1080', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000005', 'A1080');
INSERT INTO public.tb_r_tools VALUES (876, 2, 'A1081', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000006', 'A1081');
INSERT INTO public.tb_r_tools VALUES (877, 2, 'A1082', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000007', 'A1082');
INSERT INTO public.tb_r_tools VALUES (878, 2, 'A1083', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000008', 'A1083');
INSERT INTO public.tb_r_tools VALUES (879, 2, 'A1084', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000009', 'A1084');
INSERT INTO public.tb_r_tools VALUES (880, 2, 'A1085', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000010', 'A1085');
INSERT INTO public.tb_r_tools VALUES (881, 2, 'A1086', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000011', 'A1086');
INSERT INTO public.tb_r_tools VALUES (882, 2, 'A1087', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000012', 'A1087');
INSERT INTO public.tb_r_tools VALUES (883, 2, 'A1088', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000013', NULL);
INSERT INTO public.tb_r_tools VALUES (884, 2, 'A1089', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000014', NULL);
INSERT INTO public.tb_r_tools VALUES (885, 2, 'A1090', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000015', NULL);
INSERT INTO public.tb_r_tools VALUES (886, 2, 'A1091', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 000016', NULL);
INSERT INTO public.tb_r_tools VALUES (887, 28, 'A1093', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000009', 'A1093');
INSERT INTO public.tb_r_tools VALUES (888, 102, 'A1094', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00031', 'A1094');
INSERT INTO public.tb_r_tools VALUES (889, 102, 'A1095', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00032', 'A1095');
INSERT INTO public.tb_r_tools VALUES (890, 102, 'A1096', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00033', 'A1096');
INSERT INTO public.tb_r_tools VALUES (891, 102, 'A1097', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00034', 'A1097');
INSERT INTO public.tb_r_tools VALUES (892, 102, 'A1098', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00035', 'A1098');
INSERT INTO public.tb_r_tools VALUES (893, 102, 'A1099', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00036', 'A1099');
INSERT INTO public.tb_r_tools VALUES (894, 102, 'A1102', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00037', 'A1102');
INSERT INTO public.tb_r_tools VALUES (895, 102, 'A1103', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00038', 'A1103');
INSERT INTO public.tb_r_tools VALUES (896, 102, 'A1104', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00039', 'A1104');
INSERT INTO public.tb_r_tools VALUES (897, 102, 'A1105', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00040', 'A1105');
INSERT INTO public.tb_r_tools VALUES (898, 102, 'A1106', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00041', 'A1106');
INSERT INTO public.tb_r_tools VALUES (899, 102, 'A1107', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00042', 'A1107');
INSERT INTO public.tb_r_tools VALUES (900, 102, 'A1108', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00043', 'A1108');
INSERT INTO public.tb_r_tools VALUES (901, 102, 'A1109', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00044', 'A1109');
INSERT INTO public.tb_r_tools VALUES (902, 102, 'A1110', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00045', 'A1110');
INSERT INTO public.tb_r_tools VALUES (903, 102, 'A1111', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00046', 'A1111');
INSERT INTO public.tb_r_tools VALUES (904, 102, 'A1112', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00047', 'A1112');
INSERT INTO public.tb_r_tools VALUES (905, 102, 'A1113', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00048', 'A1113');
INSERT INTO public.tb_r_tools VALUES (906, 102, 'A1114', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00049', 'A1114');
INSERT INTO public.tb_r_tools VALUES (907, 102, 'A1115', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00050', 'A1115');
INSERT INTO public.tb_r_tools VALUES (908, 72, 'A1117', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00033', 'A1117');
INSERT INTO public.tb_r_tools VALUES (909, 72, 'A1118', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00034', 'A1118');
INSERT INTO public.tb_r_tools VALUES (910, 72, 'A1119', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00035', 'A1119');
INSERT INTO public.tb_r_tools VALUES (911, 72, 'A1120', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00036', 'A1120');
INSERT INTO public.tb_r_tools VALUES (912, 72, 'A1121', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00037', 'A1121');
INSERT INTO public.tb_r_tools VALUES (913, 72, 'A1122', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00038', 'A1122');
INSERT INTO public.tb_r_tools VALUES (914, 72, 'A1123', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00039', 'A1123');
INSERT INTO public.tb_r_tools VALUES (915, 72, 'A1124', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00040', 'A1124');
INSERT INTO public.tb_r_tools VALUES (916, 72, 'A1125', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00041', 'A1125');
INSERT INTO public.tb_r_tools VALUES (917, 72, 'A1126', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00042', 'A1126');
INSERT INTO public.tb_r_tools VALUES (918, 72, 'A1127', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00043', 'A1127');
INSERT INTO public.tb_r_tools VALUES (919, 72, 'A1128', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00044', 'A1128');
INSERT INTO public.tb_r_tools VALUES (920, 72, 'A1129', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00045', 'A1129');
INSERT INTO public.tb_r_tools VALUES (921, 72, 'A1130', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00046', 'A1130');
INSERT INTO public.tb_r_tools VALUES (922, 72, 'A1131', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00047', 'A1131');
INSERT INTO public.tb_r_tools VALUES (923, 72, 'A1132', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00048', 'A1132');
INSERT INTO public.tb_r_tools VALUES (924, 72, 'A1133', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00049', 'A1133');
INSERT INTO public.tb_r_tools VALUES (925, 72, 'A1134', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00050', 'A1134');
INSERT INTO public.tb_r_tools VALUES (926, 47, 'A1137', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000009', 'A1137');
INSERT INTO public.tb_r_tools VALUES (927, 47, 'A1138', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000010', 'A1138');
INSERT INTO public.tb_r_tools VALUES (928, 47, 'A1139', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000011', NULL);
INSERT INTO public.tb_r_tools VALUES (929, 47, 'A1140', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000012', NULL);
INSERT INTO public.tb_r_tools VALUES (930, 47, 'A1141', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000013', NULL);
INSERT INTO public.tb_r_tools VALUES (931, 47, 'A1142', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000014', NULL);
INSERT INTO public.tb_r_tools VALUES (932, 47, 'A1143', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000015', NULL);
INSERT INTO public.tb_r_tools VALUES (933, 47, 'A1144', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000016', NULL);
INSERT INTO public.tb_r_tools VALUES (934, 47, 'A1145', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000017', NULL);
INSERT INTO public.tb_r_tools VALUES (935, 47, 'A1146', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000018', NULL);
INSERT INTO public.tb_r_tools VALUES (936, 47, 'A1147', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000019', NULL);
INSERT INTO public.tb_r_tools VALUES (937, 47, 'A1148', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000020', NULL);
INSERT INTO public.tb_r_tools VALUES (938, 47, 'A1149', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000021', NULL);
INSERT INTO public.tb_r_tools VALUES (939, 47, 'A1150', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000022', NULL);
INSERT INTO public.tb_r_tools VALUES (940, 47, 'A1151', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000023', NULL);
INSERT INTO public.tb_r_tools VALUES (941, 47, 'A1152', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000024', NULL);
INSERT INTO public.tb_r_tools VALUES (942, 47, 'A1153', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000025', NULL);
INSERT INTO public.tb_r_tools VALUES (943, 47, 'A1154', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000026', NULL);
INSERT INTO public.tb_r_tools VALUES (944, 47, 'A1155', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000027', NULL);
INSERT INTO public.tb_r_tools VALUES (945, 47, 'A1156', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000028', NULL);
INSERT INTO public.tb_r_tools VALUES (946, 47, 'A1157', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000029', NULL);
INSERT INTO public.tb_r_tools VALUES (947, 47, 'A1158', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'MC - 931 - 000030', NULL);
INSERT INTO public.tb_r_tools VALUES (948, 40, 'A1163', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00051', 'A1163');
INSERT INTO public.tb_r_tools VALUES (949, 103, 'A1164', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 6000, 'DSSW - 06466 - 00001', 'A1164');
INSERT INTO public.tb_r_tools VALUES (950, 2, 'A1165', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 - 000017', 'A1165');
INSERT INTO public.tb_r_tools VALUES (951, 104, 'A1167', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 5000, 'MC - 1041', 'A1167');
INSERT INTO public.tb_r_tools VALUES (952, 11, 'A1168', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06465 - 000009', 'A1168');
INSERT INTO public.tb_r_tools VALUES (953, 105, 'A1169', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1700, 'DSDW - 06465 - 000010', 'A1169');
INSERT INTO public.tb_r_tools VALUES (954, 106, 'A1172', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001 - 000005', 'A1172');
INSERT INTO public.tb_r_tools VALUES (955, 107, 'A1174', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'DSSW - 0487TIN - 000001', 'A1174');
INSERT INTO public.tb_r_tools VALUES (956, 107, 'A1175', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'DSSW - 0487TIN - 000002', 'A1175');
INSERT INTO public.tb_r_tools VALUES (957, 40, 'A1176', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00052', 'A1176');
INSERT INTO public.tb_r_tools VALUES (958, 108, 'A1177', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 6000, 'DSDW - 06466 - 000009', 'A1177');
INSERT INTO public.tb_r_tools VALUES (959, 12, 'A1178', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 6000, 'DSDW - 06466 - 000010', 'A1178');
INSERT INTO public.tb_r_tools VALUES (960, 40, 'A1179', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00053', 'A1179');
INSERT INTO public.tb_r_tools VALUES (961, 40, 'A1180', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00054', 'A1180');
INSERT INTO public.tb_r_tools VALUES (962, 109, 'A1181', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10250 - 000009', 'A1181');
INSERT INTO public.tb_r_tools VALUES (963, 56, 'A1182', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 7000, 'RSW - 10249 - 000009', 'A1182');
INSERT INTO public.tb_r_tools VALUES (964, 110, 'A1183', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000018', 'A1183');
INSERT INTO public.tb_r_tools VALUES (965, 111, 'A1184', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11236 - 000010', 'A1184');
INSERT INTO public.tb_r_tools VALUES (966, 107, 'A1185', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'DSSW - 0487TIN - 00003', 'A1185');
INSERT INTO public.tb_r_tools VALUES (967, 77, 'A1186', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00017', 'A1186');
INSERT INTO public.tb_r_tools VALUES (968, 54, 'A1187', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000009', 'A1187');
INSERT INTO public.tb_r_tools VALUES (969, 75, 'A1189', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN - 00011', 'A1189');
INSERT INTO public.tb_r_tools VALUES (970, 75, 'A1190', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN - 00012', 'A1190');
INSERT INTO public.tb_r_tools VALUES (971, 75, 'A1191', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN - 00013', 'A1191');
INSERT INTO public.tb_r_tools VALUES (972, 75, 'A1192', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN - 00014', 'A1192');
INSERT INTO public.tb_r_tools VALUES (973, 75, 'A1193', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN - 00015', NULL);
INSERT INTO public.tb_r_tools VALUES (974, 75, 'A1194', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN - 00016', NULL);
INSERT INTO public.tb_r_tools VALUES (975, 75, 'A1195', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN - 00017', NULL);
INSERT INTO public.tb_r_tools VALUES (976, 75, 'A1196', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DSSW - 11126 TIN - 00018', 'A1196');
INSERT INTO public.tb_r_tools VALUES (977, 29, 'A1197', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 600, 'DSDW - 11241 - 000007', 'A1197');
INSERT INTO public.tb_r_tools VALUES (978, 40, 'A1198', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00055', 'A1198');
INSERT INTO public.tb_r_tools VALUES (979, 63, 'A1199', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 - 00009', 'A1199');
INSERT INTO public.tb_r_tools VALUES (980, 112, 'A1202', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'Not Used 2', 'A1202');
INSERT INTO public.tb_r_tools VALUES (981, 63, 'A1204', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000009', 'A1204');
INSERT INTO public.tb_r_tools VALUES (982, 63, 'A1205', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000010', NULL);
INSERT INTO public.tb_r_tools VALUES (983, 63, 'A1206', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000011', NULL);
INSERT INTO public.tb_r_tools VALUES (984, 63, 'A1207', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000012', NULL);
INSERT INTO public.tb_r_tools VALUES (985, 63, 'A1208', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000013', NULL);
INSERT INTO public.tb_r_tools VALUES (986, 63, 'A1209', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000014', NULL);
INSERT INTO public.tb_r_tools VALUES (987, 63, 'A1210', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000015', NULL);
INSERT INTO public.tb_r_tools VALUES (988, 63, 'A1211', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000016', NULL);
INSERT INTO public.tb_r_tools VALUES (989, 63, 'A1212', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000017', NULL);
INSERT INTO public.tb_r_tools VALUES (990, 63, 'A1213', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000018', NULL);
INSERT INTO public.tb_r_tools VALUES (991, 63, 'A1214', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000019', NULL);
INSERT INTO public.tb_r_tools VALUES (992, 63, 'A1215', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000020', NULL);
INSERT INTO public.tb_r_tools VALUES (993, 63, 'A1216', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000021', NULL);
INSERT INTO public.tb_r_tools VALUES (994, 63, 'A1217', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000022', NULL);
INSERT INTO public.tb_r_tools VALUES (995, 63, 'A1218', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000023', NULL);
INSERT INTO public.tb_r_tools VALUES (996, 63, 'A1219', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000024', NULL);
INSERT INTO public.tb_r_tools VALUES (997, 63, 'A1220', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000025', NULL);
INSERT INTO public.tb_r_tools VALUES (998, 63, 'A1221', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000026', NULL);
INSERT INTO public.tb_r_tools VALUES (999, 63, 'A1222', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000027', NULL);
INSERT INTO public.tb_r_tools VALUES (1000, 63, 'A1223', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000028', NULL);
INSERT INTO public.tb_r_tools VALUES (1001, 63, 'A1224', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000029', NULL);
INSERT INTO public.tb_r_tools VALUES (1002, 63, 'A1225', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000030', NULL);
INSERT INTO public.tb_r_tools VALUES (1003, 63, 'A1226', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000031', NULL);
INSERT INTO public.tb_r_tools VALUES (1004, 63, 'A1227', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000032', NULL);
INSERT INTO public.tb_r_tools VALUES (1005, 63, 'A1228', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000033', NULL);
INSERT INTO public.tb_r_tools VALUES (1006, 63, 'A1229', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000034', NULL);
INSERT INTO public.tb_r_tools VALUES (1007, 63, 'A1230', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000035', NULL);
INSERT INTO public.tb_r_tools VALUES (1008, 63, 'A1231', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000036', NULL);
INSERT INTO public.tb_r_tools VALUES (1009, 63, 'A1232', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000037', NULL);
INSERT INTO public.tb_r_tools VALUES (1010, 63, 'A1233', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000038', NULL);
INSERT INTO public.tb_r_tools VALUES (1011, 63, 'A1234', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000039', NULL);
INSERT INTO public.tb_r_tools VALUES (1012, 63, 'A1235', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000040', NULL);
INSERT INTO public.tb_r_tools VALUES (1013, 63, 'A1236', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000041', NULL);
INSERT INTO public.tb_r_tools VALUES (1014, 63, 'A1237', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000042', NULL);
INSERT INTO public.tb_r_tools VALUES (1015, 63, 'A1238', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000043', NULL);
INSERT INTO public.tb_r_tools VALUES (1016, 63, 'A1239', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000044', NULL);
INSERT INTO public.tb_r_tools VALUES (1017, 63, 'A1240', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000045', NULL);
INSERT INTO public.tb_r_tools VALUES (1018, 63, 'A1241', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000048', NULL);
INSERT INTO public.tb_r_tools VALUES (1019, 63, 'A1243', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000049', NULL);
INSERT INTO public.tb_r_tools VALUES (1020, 63, 'A1245', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000050', NULL);
INSERT INTO public.tb_r_tools VALUES (1021, 9, 'A1246', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 05260 - 000009', 'A1246');
INSERT INTO public.tb_r_tools VALUES (1022, 9, 'A1248', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 05260 - 000010', 'A1248');
INSERT INTO public.tb_r_tools VALUES (1023, 112, 'A1255', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'Not Used', 'A1255');
INSERT INTO public.tb_r_tools VALUES (1024, 2, 'A1257', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000019', 'A1257');
INSERT INTO public.tb_r_tools VALUES (1025, 2, 'A1258', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000020', 'A1258');
INSERT INTO public.tb_r_tools VALUES (1026, 46, 'A1260', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2500, 'MC - 1040 - 00009', 'A1260');
INSERT INTO public.tb_r_tools VALUES (1027, 107, 'A1261', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'DSSW - 0487TIN - 00050', 'A1261');
INSERT INTO public.tb_r_tools VALUES (1028, 107, 'A1262', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'DSSW - 0487 - 00051', 'A1262');
INSERT INTO public.tb_r_tools VALUES (1029, 6, 'A1263', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'DGN - 0880 - 000009', 'A1263');
INSERT INTO public.tb_r_tools VALUES (1030, 83, 'A1265', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 12142 - 00009', 'A1265');
INSERT INTO public.tb_r_tools VALUES (1031, 35, 'A1270', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000017', 'A1270');
INSERT INTO public.tb_r_tools VALUES (1032, 35, 'A1271', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000018', 'A1271');
INSERT INTO public.tb_r_tools VALUES (1033, 35, 'A1272', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000019', 'A1272');
INSERT INTO public.tb_r_tools VALUES (1034, 35, 'A1273', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000020', 'A1273');
INSERT INTO public.tb_r_tools VALUES (1035, 35, 'A1274', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000021', 'A1274');
INSERT INTO public.tb_r_tools VALUES (1036, 35, 'A1275', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000022', 'A1275');
INSERT INTO public.tb_r_tools VALUES (1037, 35, 'A1276', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000023', 'A1276');
INSERT INTO public.tb_r_tools VALUES (1038, 35, 'A1277', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000024', 'A1277');
INSERT INTO public.tb_r_tools VALUES (1039, 35, 'A1278', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000025', NULL);
INSERT INTO public.tb_r_tools VALUES (1040, 35, 'A1279', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000026', 'A1279');
INSERT INTO public.tb_r_tools VALUES (1041, 35, 'A1280', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000027', 'A1280');
INSERT INTO public.tb_r_tools VALUES (1042, 35, 'A1281', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000028', 'A1281');
INSERT INTO public.tb_r_tools VALUES (1043, 35, 'A1282', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000029', NULL);
INSERT INTO public.tb_r_tools VALUES (1044, 35, 'A1283', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000030', NULL);
INSERT INTO public.tb_r_tools VALUES (1045, 35, 'A1284', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000031', NULL);
INSERT INTO public.tb_r_tools VALUES (1046, 35, 'A1285', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000032', NULL);
INSERT INTO public.tb_r_tools VALUES (1047, 35, 'A1286', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000033', NULL);
INSERT INTO public.tb_r_tools VALUES (1048, 35, 'A1287', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000034', NULL);
INSERT INTO public.tb_r_tools VALUES (1049, 35, 'A1288', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000035', NULL);
INSERT INTO public.tb_r_tools VALUES (1050, 35, 'A1289', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000036', NULL);
INSERT INTO public.tb_r_tools VALUES (1051, 35, 'A1290', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000037', NULL);
INSERT INTO public.tb_r_tools VALUES (1052, 35, 'A1291', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000038', NULL);
INSERT INTO public.tb_r_tools VALUES (1053, 35, 'A1292', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000039', NULL);
INSERT INTO public.tb_r_tools VALUES (1054, 35, 'A1293', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000040', NULL);
INSERT INTO public.tb_r_tools VALUES (1055, 2, 'A1295', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 - 00021', 'A1295');
INSERT INTO public.tb_r_tools VALUES (1056, 2, 'A1296', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, ' DSSW - 12258 TIN - 00022', 'A1296');
INSERT INTO public.tb_r_tools VALUES (1057, 76, 'A1297', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'EC - 0544 TIN - 00009', 'A1297');
INSERT INTO public.tb_r_tools VALUES (1058, 76, 'A1298', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'EC - 0544 TIN - 00010', 'A1298');
INSERT INTO public.tb_r_tools VALUES (1059, 35, 'A1299', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000041', 'A1299');
INSERT INTO public.tb_r_tools VALUES (1060, 35, 'A1300', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000042', NULL);
INSERT INTO public.tb_r_tools VALUES (1061, 40, 'A1303', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00057', 'A1303');
INSERT INTO public.tb_r_tools VALUES (1062, 21, 'A1304', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'DSDW - 09272DIC - 00009', 'A1304');
INSERT INTO public.tb_r_tools VALUES (1063, 72, 'A1305', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00051', 'A1305');
INSERT INTO public.tb_r_tools VALUES (1064, 72, 'A1306', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00052', 'A1306');
INSERT INTO public.tb_r_tools VALUES (1065, 72, 'A1307', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00053', 'A1307');
INSERT INTO public.tb_r_tools VALUES (1066, 72, 'A1308', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00054', 'A1308');
INSERT INTO public.tb_r_tools VALUES (1067, 72, 'A1310', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00055', 'A1310');
INSERT INTO public.tb_r_tools VALUES (1068, 72, 'A1311', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00056', 'A1311');
INSERT INTO public.tb_r_tools VALUES (1069, 72, 'A1312', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00057', 'A1312');
INSERT INTO public.tb_r_tools VALUES (1070, 72, 'A1313', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00058', 'A1313');
INSERT INTO public.tb_r_tools VALUES (1071, 72, 'A1314', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00059', 'A1314');
INSERT INTO public.tb_r_tools VALUES (1072, 72, 'A1315', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00060', 'A1315');
INSERT INTO public.tb_r_tools VALUES (1073, 72, 'A1316', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00061', 'A1316');
INSERT INTO public.tb_r_tools VALUES (1074, 72, 'A1317', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00062', 'A1317');
INSERT INTO public.tb_r_tools VALUES (1075, 72, 'A1318', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00063', 'A1318');
INSERT INTO public.tb_r_tools VALUES (1076, 72, 'A1319', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00064', 'A1319');
INSERT INTO public.tb_r_tools VALUES (1077, 72, 'A1320', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00065', 'A1320');
INSERT INTO public.tb_r_tools VALUES (1078, 72, 'A1321', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00066', 'A1321');
INSERT INTO public.tb_r_tools VALUES (1079, 72, 'A1322', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00067', 'A1322');
INSERT INTO public.tb_r_tools VALUES (1080, 72, 'A1323', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00068', 'A1323');
INSERT INTO public.tb_r_tools VALUES (1081, 72, 'A1324', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00069', NULL);
INSERT INTO public.tb_r_tools VALUES (1082, 72, 'A1325', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00070', NULL);
INSERT INTO public.tb_r_tools VALUES (1083, 72, 'A1326', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00071', NULL);
INSERT INTO public.tb_r_tools VALUES (1084, 72, 'A1327', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00072', NULL);
INSERT INTO public.tb_r_tools VALUES (1085, 72, 'A1328', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00073', NULL);
INSERT INTO public.tb_r_tools VALUES (1086, 72, 'A1329', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00074', NULL);
INSERT INTO public.tb_r_tools VALUES (1087, 72, 'A1330', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00075', NULL);
INSERT INTO public.tb_r_tools VALUES (1088, 72, 'A1331', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00076', NULL);
INSERT INTO public.tb_r_tools VALUES (1089, 72, 'A1332', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00077', NULL);
INSERT INTO public.tb_r_tools VALUES (1090, 72, 'A1333', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00078', NULL);
INSERT INTO public.tb_r_tools VALUES (1091, 72, 'A1334', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00079', NULL);
INSERT INTO public.tb_r_tools VALUES (1092, 72, 'A1335', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 00080', NULL);
INSERT INTO public.tb_r_tools VALUES (1093, 77, 'A1337', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00018', 'A1337');
INSERT INTO public.tb_r_tools VALUES (1094, 77, 'A1338', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00019', 'A1338');
INSERT INTO public.tb_r_tools VALUES (1095, 77, 'A1339', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00020', 'A1339');
INSERT INTO public.tb_r_tools VALUES (1096, 77, 'A1340', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00021', 'A1340');
INSERT INTO public.tb_r_tools VALUES (1097, 77, 'A1341', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00022', 'A1341');
INSERT INTO public.tb_r_tools VALUES (1098, 77, 'A1342', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00023', 'A1342');
INSERT INTO public.tb_r_tools VALUES (1099, 77, 'A1343', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00024', 'A1343');
INSERT INTO public.tb_r_tools VALUES (1100, 77, 'A1344', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00025', 'A1344');
INSERT INTO public.tb_r_tools VALUES (1101, 77, 'A1345', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00028', 'A1345');
INSERT INTO public.tb_r_tools VALUES (1102, 77, 'A1346', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00029', 'A1346');
INSERT INTO public.tb_r_tools VALUES (1103, 77, 'A1347', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00030', 'A1347');
INSERT INTO public.tb_r_tools VALUES (1104, 9, 'A1351', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 05260 - 000011', 'A1351');
INSERT INTO public.tb_r_tools VALUES (1105, 9, 'A1352', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'DSDW - 05260 - 000012', 'A1352');
INSERT INTO public.tb_r_tools VALUES (1106, 54, 'A1353', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08177 - 000010', 'A1353');
INSERT INTO public.tb_r_tools VALUES (1107, 72, 'A1354', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487TIN - 000081', 'A1354');
INSERT INTO public.tb_r_tools VALUES (1108, 68, 'A1355', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000009', 'A1355');
INSERT INTO public.tb_r_tools VALUES (1109, 35, 'A1356', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000043', 'A1356');
INSERT INTO public.tb_r_tools VALUES (1110, 35, 'A1358', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 05114 TIN - 000044', 'A1358');
INSERT INTO public.tb_r_tools VALUES (1111, 51, 'A1361', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000013', 'A1361');
INSERT INTO public.tb_r_tools VALUES (1112, 51, 'A1362', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'RSW - 05006 - 000014', 'A1362');
INSERT INTO public.tb_r_tools VALUES (1113, 1, 'A1363', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 08466 - 000009', 'A1363');
INSERT INTO public.tb_r_tools VALUES (1114, 76, 'A1364', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'EC - 0544TIN - 000010', 'A1364');
INSERT INTO public.tb_r_tools VALUES (1115, 76, 'A1365', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'EC - 0544 TIN - 000011', 'A1365');
INSERT INTO public.tb_r_tools VALUES (1116, 72, 'A1367', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000082', 'A1367');
INSERT INTO public.tb_r_tools VALUES (1117, 72, 'A1368', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000083', 'A1368');
INSERT INTO public.tb_r_tools VALUES (1118, 72, 'A1369', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'DSSW - 0487 TIN - 000084', 'A1369');
INSERT INTO public.tb_r_tools VALUES (1119, 53, 'A1370', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 3000, 'RSW - 08170 - 000010', 'A1370');
INSERT INTO public.tb_r_tools VALUES (1120, 68, 'A1371', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 220, 'DSSW - 04121 - 000010', 'A1371');
INSERT INTO public.tb_r_tools VALUES (1121, 65, 'A1372', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1000, 'ZC - 0301 - 000010', 'A1372');
INSERT INTO public.tb_r_tools VALUES (1122, 11, 'A1375', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSDW - 06465 - 000011', 'A1375');
INSERT INTO public.tb_r_tools VALUES (1123, 63, 'A1376', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 250, 'TP - 10167 TIN - 000052', 'A1376');
INSERT INTO public.tb_r_tools VALUES (1124, 40, 'A1381', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00058', 'A1381');
INSERT INTO public.tb_r_tools VALUES (1125, 102, 'A1382', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00059', 'A1382');
INSERT INTO public.tb_r_tools VALUES (1126, 102, 'A1383', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00060', 'A1383');
INSERT INTO public.tb_r_tools VALUES (1127, 102, 'A1384', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00061', 'A1384');
INSERT INTO public.tb_r_tools VALUES (1128, 102, 'A1385', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00062', 'A1385');
INSERT INTO public.tb_r_tools VALUES (1129, 102, 'A1386', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00063', 'A1386');
INSERT INTO public.tb_r_tools VALUES (1130, 102, 'A1387', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00064', NULL);
INSERT INTO public.tb_r_tools VALUES (1131, 102, 'A1388', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00065', NULL);
INSERT INTO public.tb_r_tools VALUES (1132, 102, 'A1389', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00066', NULL);
INSERT INTO public.tb_r_tools VALUES (1133, 102, 'A1390', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00067', NULL);
INSERT INTO public.tb_r_tools VALUES (1134, 102, 'A1391', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00068', NULL);
INSERT INTO public.tb_r_tools VALUES (1135, 102, 'A1392', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00069', NULL);
INSERT INTO public.tb_r_tools VALUES (1136, 102, 'A1393', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00070', NULL);
INSERT INTO public.tb_r_tools VALUES (1137, 112, 'A1394', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW - 14011 - 00003', 'A1394');
INSERT INTO public.tb_r_tools VALUES (1138, 77, 'A1395', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00031', 'A1395');
INSERT INTO public.tb_r_tools VALUES (1139, 77, 'A1396', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00032', 'A1396');
INSERT INTO public.tb_r_tools VALUES (1140, 1, 'A1397', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 08466TIN - 00010', 'A1397');
INSERT INTO public.tb_r_tools VALUES (1141, 112, 'A1401', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00009', 'A1401');
INSERT INTO public.tb_r_tools VALUES (1142, 112, 'A1402', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00010', 'A1402');
INSERT INTO public.tb_r_tools VALUES (1143, 112, 'A1403', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00011', 'A1403');
INSERT INTO public.tb_r_tools VALUES (1144, 112, 'A1404', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00012', 'A1404');
INSERT INTO public.tb_r_tools VALUES (1145, 112, 'A1405', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00013', 'A1405');
INSERT INTO public.tb_r_tools VALUES (1146, 112, 'A1406', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00014', 'A1406');
INSERT INTO public.tb_r_tools VALUES (1147, 112, 'A1407', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00015', 'A1407');
INSERT INTO public.tb_r_tools VALUES (1148, 112, 'A1408', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00016', 'A1408');
INSERT INTO public.tb_r_tools VALUES (1149, 112, 'A1409', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00017', NULL);
INSERT INTO public.tb_r_tools VALUES (1150, 112, 'A1410', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00018', NULL);
INSERT INTO public.tb_r_tools VALUES (1151, 112, 'A1411', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00019', NULL);
INSERT INTO public.tb_r_tools VALUES (1152, 112, 'A1412', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00020', NULL);
INSERT INTO public.tb_r_tools VALUES (1153, 112, 'A1413', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00021', NULL);
INSERT INTO public.tb_r_tools VALUES (1154, 112, 'A1414', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00022', NULL);
INSERT INTO public.tb_r_tools VALUES (1155, 112, 'A1415', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00023', NULL);
INSERT INTO public.tb_r_tools VALUES (1156, 112, 'A1416', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00024', NULL);
INSERT INTO public.tb_r_tools VALUES (1157, 112, 'A1417', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00025', NULL);
INSERT INTO public.tb_r_tools VALUES (1158, 112, 'A1418', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00026', NULL);
INSERT INTO public.tb_r_tools VALUES (1159, 112, 'A1419', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00027', NULL);
INSERT INTO public.tb_r_tools VALUES (1160, 112, 'A1420', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00028', NULL);
INSERT INTO public.tb_r_tools VALUES (1161, 112, 'A1421', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00029', NULL);
INSERT INTO public.tb_r_tools VALUES (1162, 112, 'A1422', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 2000, 'DSSW-14011 NT - 00030', NULL);
INSERT INTO public.tb_r_tools VALUES (1163, 77, 'A1424', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 - 000032', NULL);
INSERT INTO public.tb_r_tools VALUES (1164, 64, 'A1425', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000021', 'A1425');
INSERT INTO public.tb_r_tools VALUES (1165, 64, 'A1426', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000022', 'A1426');
INSERT INTO public.tb_r_tools VALUES (1166, 64, 'A1427', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000023', 'A1427');
INSERT INTO public.tb_r_tools VALUES (1167, 64, 'A1428', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000024', 'A1428');
INSERT INTO public.tb_r_tools VALUES (1168, 64, 'A1429', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000025', NULL);
INSERT INTO public.tb_r_tools VALUES (1169, 64, 'A1430', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000026', NULL);
INSERT INTO public.tb_r_tools VALUES (1170, 64, 'A1431', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000027', NULL);
INSERT INTO public.tb_r_tools VALUES (1171, 64, 'A1432', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000028', NULL);
INSERT INTO public.tb_r_tools VALUES (1172, 64, 'A1433', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000029', NULL);
INSERT INTO public.tb_r_tools VALUES (1173, 64, 'A1434', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000030', NULL);
INSERT INTO public.tb_r_tools VALUES (1174, 64, 'A1435', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000031', NULL);
INSERT INTO public.tb_r_tools VALUES (1175, 64, 'A1436', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000032', NULL);
INSERT INTO public.tb_r_tools VALUES (1176, 64, 'A1437', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000033', NULL);
INSERT INTO public.tb_r_tools VALUES (1177, 64, 'A1438', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000034', NULL);
INSERT INTO public.tb_r_tools VALUES (1178, 64, 'A1439', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000035', NULL);
INSERT INTO public.tb_r_tools VALUES (1179, 64, 'A1440', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000036', NULL);
INSERT INTO public.tb_r_tools VALUES (1180, 64, 'A1441', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000037', NULL);
INSERT INTO public.tb_r_tools VALUES (1181, 64, 'A1442', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000038', NULL);
INSERT INTO public.tb_r_tools VALUES (1182, 64, 'A1443', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000039', NULL);
INSERT INTO public.tb_r_tools VALUES (1183, 64, 'A1444', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 300, 'TP - 1483 - 000040', NULL);
INSERT INTO public.tb_r_tools VALUES (1184, 77, 'A1448', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00033', 'A1448');
INSERT INTO public.tb_r_tools VALUES (1185, 83, 'A1449', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 12142 - 00003', 'A1449');
INSERT INTO public.tb_r_tools VALUES (1186, 5, 'A1450', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'CD - 989 - 00002', 'A1450');
INSERT INTO public.tb_r_tools VALUES (1187, 40, 'A1452', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00071', 'A1452');
INSERT INTO public.tb_r_tools VALUES (1188, 69, 'A1453', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1200, 'CD - 1001 - 000009', NULL);
INSERT INTO public.tb_r_tools VALUES (1189, 113, 'A1455', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 10000, 'RSW - 13006DIC - 00001', 'A1455');
INSERT INTO public.tb_r_tools VALUES (1190, 102, 'A1456', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292TIN - 000064', 'A1456');
INSERT INTO public.tb_r_tools VALUES (1191, 40, 'A1457', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292TIN - 000065', 'A1457');
INSERT INTO public.tb_r_tools VALUES (1192, 40, 'A1458', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292TIN - 000066', 'A1458');
INSERT INTO public.tb_r_tools VALUES (1193, 40, 'A1459', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292TIN - 000067', 'A1459');
INSERT INTO public.tb_r_tools VALUES (1194, 40, 'A1460', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292TIN - 000068', 'A1460');
INSERT INTO public.tb_r_tools VALUES (1195, 77, 'A1462', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00034', 'A1462');
INSERT INTO public.tb_r_tools VALUES (1196, 77, 'A1463', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 150, 'TP - 10171 TIN - 00035', 'A1463');
INSERT INTO public.tb_r_tools VALUES (1197, 1, 'A1464', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 0, 'DSDW - 08466TIN - 00011', 'A1464');
INSERT INTO public.tb_r_tools VALUES (1198, 83, 'A1465', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'RSW - 12142 - 00004', 'A1465');
INSERT INTO public.tb_r_tools VALUES (1199, 25, 'A1466', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 15000, 'DSDW - 10400 - 00009', 'A1466');
INSERT INTO public.tb_r_tools VALUES (1200, 40, 'A1472', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 400, 'DSSW - 08292 TIN - 00072', 'A1472');
INSERT INTO public.tb_r_tools VALUES (1201, 2, 'A1473', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000021', 'A1473');
INSERT INTO public.tb_r_tools VALUES (1202, 2, 'A1474', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000022', 'A1474');
INSERT INTO public.tb_r_tools VALUES (1203, 2, 'A1475', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000023', NULL);
INSERT INTO public.tb_r_tools VALUES (1204, 2, 'A1476', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000024', NULL);
INSERT INTO public.tb_r_tools VALUES (1205, 2, 'A1477', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000025', NULL);
INSERT INTO public.tb_r_tools VALUES (1206, 2, 'A1478', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000026', NULL);
INSERT INTO public.tb_r_tools VALUES (1207, 2, 'A1479', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000027', NULL);
INSERT INTO public.tb_r_tools VALUES (1208, 2, 'A1480', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000028', NULL);
INSERT INTO public.tb_r_tools VALUES (1209, 2, 'A1481', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000029', NULL);
INSERT INTO public.tb_r_tools VALUES (1210, 2, 'A1482', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000030', NULL);
INSERT INTO public.tb_r_tools VALUES (1211, 2, 'A1483', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000031', NULL);
INSERT INTO public.tb_r_tools VALUES (1212, 2, 'A1484', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000032', NULL);
INSERT INTO public.tb_r_tools VALUES (1213, 2, 'A1485', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000033', NULL);
INSERT INTO public.tb_r_tools VALUES (1214, 2, 'A1486', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000034', NULL);
INSERT INTO public.tb_r_tools VALUES (1215, 2, 'A1487', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000035', NULL);
INSERT INTO public.tb_r_tools VALUES (1216, 2, 'A1488', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000036', NULL);
INSERT INTO public.tb_r_tools VALUES (1217, 2, 'A1489', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000037', NULL);
INSERT INTO public.tb_r_tools VALUES (1218, 2, 'A1490', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000038', NULL);
INSERT INTO public.tb_r_tools VALUES (1219, 2, 'A1491', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000039', NULL);
INSERT INTO public.tb_r_tools VALUES (1220, 2, 'A1492', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 1500, 'DSSW - 12258 TIN - 000040', NULL);
INSERT INTO public.tb_r_tools VALUES (1221, 4, 'A1493', '2024-07-12 00:00:00', 'Fajar Tri Cahyono', NULL, NULL, 500, 'BC - 2224 - 00001', 'A1493');
INSERT INTO public.tb_r_tools VALUES (1222, 3, 'A1494', '2024-07-13 20:38:52.175269', 'SYSTEM', NULL, NULL, 5000, ' MC - 1041-9', 'A1494');
INSERT INTO public.tb_r_tools VALUES (1223, 107, 'A1495', '2024-07-14 12:31:58.932292', 'SYSTEM', NULL, NULL, 250, 'DSSW - 0487TIN-6', 'A1495');
INSERT INTO public.tb_r_tools VALUES (1224, 107, 'A1496', '2024-07-14 12:39:43.433918', 'SYSTEM', NULL, NULL, 250, 'DSSW - 0487TIN-7', 'A1496');
INSERT INTO public.tb_r_tools VALUES (1225, 107, 'A1497', '2024-07-14 15:41:40.567285', 'SYSTEM', NULL, NULL, 250, 'DSSW - 0487TIN-8', 'A1497');
INSERT INTO public.tb_r_tools VALUES (1226, 107, 'A1498', '2024-07-14 15:42:21.569949', 'SYSTEM', NULL, NULL, 250, 'DSSW - 0487TIN-9', 'A1498');
INSERT INTO public.tb_r_tools VALUES (1227, 107, 'A1499', '2024-07-14 15:43:37.368357', 'SYSTEM', NULL, NULL, 250, 'DSSW - 0487TIN-10', 'A1499');
INSERT INTO public.tb_r_tools VALUES (1228, 1, 'A1500', '2024-07-14 15:45:11.144056', 'SYSTEM', NULL, NULL, 650, 'DSDW - 08466TIN-14', 'A1500');
INSERT INTO public.tb_r_tools VALUES (1229, 1, 'A1501', '2024-07-14 15:45:41.449008', 'SYSTEM', NULL, NULL, 650, 'DSDW - 08466TIN-15', 'A1501');


--
-- TOC entry 3705 (class 0 OID 32429)
-- Dependencies: 213
-- Data for Name: tb_r_tools_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_r_tools_histories VALUES (6, 'SETTING', 116, 'FAJAR TRI CAHYONO', '2024-07-12 09:31:52.196254', 2, NULL, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (7, 'IN USED', 116, 'FAJAR TRI CAHYONO', '2024-07-12 10:33:30.158796', 7, 7, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (10, 'SETTING', 116, 'FAJAR TRI CAHYONO', '2024-07-14 09:31:52.196254', 2, NULL, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (11, 'IN USED', 116, 'FAJAR TRI CAHYONO', '2024-07-14 10:33:30.158796', 7, 7, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (14, 'SETTING', 116, 'FAJAR TRI CAHYONO', '2024-07-18 09:31:52.196254', 2, NULL, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (15, 'IN USED', 116, 'FAJAR TRI CAHYONO', '2024-07-18 10:33:30.158796', 7, 7, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (19, 'SETTING', 202, 'FAJAR TRI CAHYONO', '2024-07-02 09:31:52.196254', 2, NULL, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (20, 'IN USED', 202, 'FAJAR TRI CAHYONO', '2024-07-02 10:33:30.158796', 7, 7, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (21, 'USED', 202, 'FAJAR TRI CAHYONO', '2024-07-02 13:33:45.767048', 3, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (23, 'SETTING', 202, 'FAJAR TRI CAHYONO', '2024-07-12 09:31:52.196254', 2, NULL, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (24, 'IN USED', 202, 'FAJAR TRI CAHYONO', '2024-07-12 10:33:30.158796', 7, 7, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (25, 'USED', 202, 'FAJAR TRI CAHYONO', '2024-07-12 13:33:45.767048', 3, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (27, 'SETTING', 202, 'FAJAR TRI CAHYONO', '2024-07-14 09:31:52.196254', 2, NULL, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (28, 'IN USED', 202, 'FAJAR TRI CAHYONO', '2024-07-14 10:33:30.158796', 7, 7, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (29, 'USED', 202, 'FAJAR TRI CAHYONO', '2024-07-14 13:33:45.767048', 3, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (31, 'SETTING', 202, 'FAJAR TRI CAHYONO', '2024-07-18 09:31:52.196254', 2, NULL, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (32, 'IN USED', 202, 'FAJAR TRI CAHYONO', '2024-07-18 10:33:30.158796', 7, 7, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (33, 'USED', 202, 'FAJAR TRI CAHYONO', '2024-07-18 13:33:45.767048', 3, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (8, 'USED', 116, 'FAJAR TRI CAHYONO', '2024-07-12 13:33:45.767048', 3, NULL, 9100, NULL, 'TUMPUL');
INSERT INTO public.tb_r_tools_histories VALUES (4, 'USED', 116, 'FAJAR TRI CAHYONO', '2024-07-02 13:33:45.767048', 3, NULL, 9200, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (16, 'USED', 116, 'FAJAR TRI CAHYONO', '2024-07-18 13:33:45.767048', 3, NULL, 9000, NULL, 'TUMPUL');
INSERT INTO public.tb_r_tools_histories VALUES (12, 'USED', 116, 'FAJAR TRI CAHYONO', '2024-07-14 13:33:45.767048', 3, NULL, 9000, NULL, 'TUMPUL');
INSERT INTO public.tb_r_tools_histories VALUES (34, 'REGRINDING', 1229, 'FAJAR TRI CAHYONO', '2024-07-23 14:12:54.579114', 0, NULL, 650, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (30, 'REGRINDING', 202, 'BAMBANG WICAKSONO', '2024-07-18 08:30:46.903993', 0, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (5, 'REGRINDING', 116, 'BAMBANG WICAKSONO', '2024-07-12 08:30:46.903993', 0, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (9, 'REGRINDING', 116, 'BAMBANG WICAKSONO', '2024-07-14 08:30:46.903993', 0, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (13, 'REGRINDING', 116, 'BAMBANG WICAKSONO', '2024-07-18 08:30:46.903993', 0, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (18, 'REGRINDING', 202, 'BAMBANG WICAKSONO', '2024-07-02 08:30:46.903993', 0, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (22, 'REGRINDING', 202, 'BAMBANG WICAKSONO', '2024-07-12 08:30:46.903993', 0, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (26, 'REGRINDING', 202, 'BAMBANG WICAKSONO', '2024-07-14 08:30:46.903993', 0, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (1, 'REGRINDING', 116, 'BAMBANG WICAKSONO', '2024-07-02 08:30:46.903993', 0, NULL, 10000, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (35, 'USED', 1229, 'FAJAR TRI CAHYONO', '2024-07-23 14:37:53.731958', 3, NULL, 500, NULL, 'TUMPUL');
INSERT INTO public.tb_r_tools_histories VALUES (36, 'REGRINDING', 1229, 'FAJAR TRI CAHYONO', '2024-07-23 14:38:08.351057', 0, NULL, 500, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (37, 'REGRINDING', 1229, 'BAMBANG WICAKSONO', '2024-07-23 14:39:29.724699', 0, NULL, 500, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (38, 'USED', 1229, 'BAMBANG WICAKSONO', '2024-07-24 10:43:02.361522', 3, NULL, 600, NULL, 'INTERNAL COOLANT MAMPET');
INSERT INTO public.tb_r_tools_histories VALUES (39, 'REGRINDING', 1229, 'FAJAR TRI CAHYONO', '2024-07-24 10:44:47.395827', 0, NULL, 600, NULL, 'INTERNAL COOLANT MAMPET');
INSERT INTO public.tb_r_tools_histories VALUES (40, 'REGRINDING', 1229, 'BAMBANG WICAKSONO', '2024-07-24 10:45:53.1172', 0, NULL, 600, NULL, 'INTERNAL COOLANT MAMPET');
INSERT INTO public.tb_r_tools_histories VALUES (2, 'SETTING', 116, 'FAJAR TRI CAHYONO', '2024-07-02 09:31:52.196254', 2, NULL, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (3, 'IN USED', 116, 'FAJAR TRI CAHYONO', '2024-07-02 10:33:30.158796', 7, 7, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (41, 'REGRINDING', 1229, 'BAMBANG WICAKSONO', '2024-07-24 10:50:36.946519', 0, NULL, 600, NULL, 'INTERNAL COOLANT MAMPET');
INSERT INTO public.tb_r_tools_histories VALUES (42, 'SETTING', 1229, 'BAMBANG WICAKSONO', '2024-07-24 10:51:31.398004', 2, NULL, 600, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (43, 'SETTING', 1229, 'FAJAR TRI CAHYONO', '2024-07-24 10:53:40.404523', 2, NULL, 600, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (44, 'SETTING', 1229, 'FAJAR TRI CAHYONO', '2024-07-24 10:55:10.775769', 2, NULL, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (45, 'IN USED', 1229, 'TUBAGUS HIDAYATULLOH', '2024-07-24 13:08:34.988497', 7, 5, 0, NULL, NULL);
INSERT INTO public.tb_r_tools_histories VALUES (46, 'USED', 1229, 'TUBAGUS HIDAYATULLOH', '2024-07-24 13:09:26.977483', 3, NULL, 500, NULL, 'TUMPUL');
INSERT INTO public.tb_r_tools_histories VALUES (47, 'REGRINDING', 1229, 'TUBAGUS HIDAYATULLOH', '2024-07-24 13:10:02.697905', 0, NULL, 500, NULL, 'TUMPUL');


--
-- TOC entry 3703 (class 0 OID 32415)
-- Dependencies: 211
-- Data for Name: tb_t_tools_positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_t_tools_positions VALUES (116, 116, 10000, false, 8, 15, 7, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1225, 1225, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1227, 1227, 0, true, 19, 1000, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1228, 1228, 0, true, 1, 1000, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (10000, 1228, 0, true, 1, 1000, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1226, 1226, 0, false, 0, 14, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1, 1, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (2, 2, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (3, 3, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (4, 4, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (5, 5, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (6, 6, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (7, 7, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (8, 8, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (9, 9, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (10, 10, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (11, 11, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (12, 12, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (13, 13, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (14, 14, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (15, 15, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (16, 16, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (17, 17, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (18, 18, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (19, 19, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (20, 20, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (21, 21, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (22, 22, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (23, 23, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (24, 24, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (25, 25, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (26, 26, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (27, 27, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (28, 28, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (29, 29, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (30, 30, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (31, 31, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (32, 32, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (33, 33, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (34, 34, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (35, 35, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (36, 36, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (37, 37, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (38, 38, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (39, 39, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (40, 40, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (41, 41, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (42, 42, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (43, 43, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (44, 44, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (45, 45, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (46, 46, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (47, 47, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (48, 48, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (49, 49, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (50, 50, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (51, 51, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (52, 52, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (53, 53, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (54, 54, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (55, 55, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (56, 56, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (57, 57, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (58, 58, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (59, 59, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (60, 60, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (61, 61, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (62, 62, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (63, 63, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (64, 64, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (65, 65, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (66, 66, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (67, 67, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (68, 68, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (69, 69, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (70, 70, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (71, 71, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (72, 72, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (73, 73, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (74, 74, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (75, 75, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (76, 76, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (77, 77, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (78, 78, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (79, 79, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (80, 80, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (81, 81, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (82, 82, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (83, 83, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (84, 84, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (85, 85, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (86, 86, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (87, 87, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (88, 88, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (89, 89, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (90, 90, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (91, 91, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (92, 92, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (93, 93, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (94, 94, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (95, 95, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (96, 96, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (97, 97, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (98, 98, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (99, 99, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (100, 100, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (101, 101, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (102, 102, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (103, 103, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (104, 104, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (105, 105, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (106, 106, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (107, 107, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (108, 108, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (109, 109, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (110, 110, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (111, 111, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (112, 112, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (113, 113, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (114, 114, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (115, 115, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (117, 117, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (118, 118, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (119, 119, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (120, 120, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (121, 121, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (122, 122, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (123, 123, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (124, 124, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (125, 125, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (126, 126, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (127, 127, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (128, 128, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (129, 129, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (130, 130, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (131, 131, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (132, 132, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (133, 133, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (134, 134, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (135, 135, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (136, 136, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (137, 137, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (138, 138, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (139, 139, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (140, 140, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (141, 141, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (142, 142, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (143, 143, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (144, 144, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (145, 145, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (146, 146, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (147, 147, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (148, 148, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (149, 149, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (150, 150, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (151, 151, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (152, 152, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (153, 153, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (154, 154, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (155, 155, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (156, 156, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (157, 157, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (158, 158, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (159, 159, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (160, 160, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (161, 161, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (162, 162, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (163, 163, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (164, 164, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (165, 165, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (166, 166, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (167, 167, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (168, 168, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (169, 169, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (170, 170, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (171, 171, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (172, 172, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (173, 173, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (174, 174, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (175, 175, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (176, 176, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (177, 177, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (178, 178, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (179, 179, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (180, 180, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (181, 181, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (182, 182, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (183, 183, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (184, 184, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (185, 185, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (186, 186, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (187, 187, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (188, 188, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (189, 189, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (190, 190, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (191, 191, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (192, 192, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (193, 193, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (194, 194, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (195, 195, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (196, 196, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (197, 197, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (198, 198, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (199, 199, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (200, 200, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (201, 201, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (202, 202, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (203, 203, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (204, 204, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (205, 205, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (206, 206, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (207, 207, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (208, 208, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (209, 209, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (210, 210, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (211, 211, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (212, 212, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (213, 213, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (214, 214, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (215, 215, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (216, 216, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (217, 217, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (218, 218, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (219, 219, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (220, 220, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (221, 221, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (222, 222, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (223, 223, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (224, 224, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (225, 225, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (226, 226, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (227, 227, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (228, 228, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (229, 229, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (230, 230, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (231, 231, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (232, 232, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (233, 233, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (234, 234, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (235, 235, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (236, 236, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (237, 237, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (238, 238, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (239, 239, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (240, 240, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (241, 241, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (242, 242, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (243, 243, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (244, 244, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (245, 245, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (246, 246, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (247, 247, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (248, 248, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (249, 249, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (250, 250, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (251, 251, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (252, 252, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (253, 253, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (254, 254, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (255, 255, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (256, 256, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (257, 257, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (258, 258, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (259, 259, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (260, 260, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (261, 261, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (262, 262, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (263, 263, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (264, 264, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (265, 265, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (266, 266, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (267, 267, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (268, 268, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (269, 269, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (270, 270, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (271, 271, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (272, 272, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (273, 273, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (274, 274, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (275, 275, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (276, 276, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (277, 277, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (278, 278, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (279, 279, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (280, 280, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (281, 281, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (282, 282, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (283, 283, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (284, 284, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (285, 285, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (286, 286, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (287, 287, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (288, 288, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (289, 289, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (290, 290, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (291, 291, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (292, 292, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (293, 293, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (294, 294, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (295, 295, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (296, 296, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (297, 297, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (298, 298, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (299, 299, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (300, 300, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (301, 301, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (302, 302, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (303, 303, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (304, 304, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (305, 305, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (306, 306, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (307, 307, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (308, 308, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (309, 309, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (310, 310, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (311, 311, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (312, 312, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (313, 313, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (314, 314, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (315, 315, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (316, 316, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (317, 317, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (318, 318, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (319, 319, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (320, 320, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (321, 321, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (322, 322, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (323, 323, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (324, 324, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (325, 325, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (326, 326, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (327, 327, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (328, 328, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (329, 329, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (330, 330, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (331, 331, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (332, 332, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (333, 333, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (334, 334, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (335, 335, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (336, 336, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (337, 337, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (338, 338, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (339, 339, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (340, 340, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (341, 341, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (342, 342, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (343, 343, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (344, 344, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (345, 345, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (346, 346, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (347, 347, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (348, 348, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (349, 349, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (350, 350, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (351, 351, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (352, 352, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (353, 353, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (354, 354, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (355, 355, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (356, 356, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (357, 357, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (358, 358, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (359, 359, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (360, 360, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (361, 361, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (362, 362, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (363, 363, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (364, 364, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (365, 365, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (366, 366, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (367, 367, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (368, 368, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (369, 369, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (370, 370, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (371, 371, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (372, 372, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (373, 373, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (374, 374, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (375, 375, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (376, 376, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (377, 377, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (378, 378, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (379, 379, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (380, 380, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (381, 381, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (382, 382, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (383, 383, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (384, 384, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (385, 385, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (386, 386, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (387, 387, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (388, 388, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (389, 389, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (390, 390, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (391, 391, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (392, 392, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (393, 393, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (394, 394, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (395, 395, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (396, 396, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (397, 397, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (398, 398, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (399, 399, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (400, 400, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (401, 401, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (402, 402, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (403, 403, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (404, 404, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (405, 405, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (406, 406, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (407, 407, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (408, 408, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (409, 409, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (410, 410, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (411, 411, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (412, 412, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (413, 413, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (414, 414, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (415, 415, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (416, 416, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (417, 417, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (418, 418, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (419, 419, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (420, 420, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (421, 421, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (422, 422, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (423, 423, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (424, 424, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (425, 425, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (426, 426, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (427, 427, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (428, 428, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (429, 429, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (430, 430, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (431, 431, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (432, 432, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (433, 433, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (434, 434, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (435, 435, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (436, 436, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (437, 437, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (438, 438, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (439, 439, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (440, 440, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (441, 441, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (442, 442, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (443, 443, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (444, 444, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (445, 445, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (446, 446, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (447, 447, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (448, 448, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (449, 449, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (450, 450, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (451, 451, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (452, 452, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (453, 453, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (454, 454, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (455, 455, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (456, 456, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (457, 457, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (458, 458, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (459, 459, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (460, 460, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (461, 461, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (462, 462, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (463, 463, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (464, 464, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (465, 465, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (466, 466, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (467, 467, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (468, 468, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (469, 469, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (470, 470, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (471, 471, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (472, 472, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (473, 473, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (474, 474, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (475, 475, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (476, 476, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (477, 477, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (478, 478, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (479, 479, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (480, 480, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (481, 481, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (482, 482, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (483, 483, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (484, 484, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (485, 485, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (486, 486, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (487, 487, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (488, 488, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (489, 489, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (490, 490, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (491, 491, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (492, 492, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (493, 493, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (494, 494, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (495, 495, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (496, 496, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (497, 497, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (498, 498, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (499, 499, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (500, 500, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (501, 501, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (502, 502, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (503, 503, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (504, 504, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (505, 505, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (506, 506, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (507, 507, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (508, 508, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (509, 509, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (510, 510, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (511, 511, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (512, 512, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (513, 513, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (514, 514, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (515, 515, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (516, 516, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (517, 517, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (518, 518, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (519, 519, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (520, 520, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (521, 521, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (522, 522, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (523, 523, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (524, 524, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (525, 525, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (526, 526, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (527, 527, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (528, 528, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (529, 529, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (530, 530, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (531, 531, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (532, 532, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (533, 533, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (534, 534, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (535, 535, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (536, 536, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (537, 537, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (538, 538, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (539, 539, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (540, 540, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (541, 541, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (542, 542, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (543, 543, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (544, 544, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (545, 545, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (546, 546, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (547, 547, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (548, 548, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (549, 549, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (550, 550, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (551, 551, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (552, 552, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (553, 553, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (554, 554, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (555, 555, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (556, 556, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (557, 557, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (558, 558, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (559, 559, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (560, 560, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (561, 561, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (562, 562, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (563, 563, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (564, 564, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (565, 565, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (566, 566, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (567, 567, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (568, 568, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (569, 569, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (570, 570, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (571, 571, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (572, 572, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (573, 573, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (574, 574, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (575, 575, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (576, 576, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (577, 577, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (578, 578, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (579, 579, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (580, 580, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (581, 581, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (582, 582, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (583, 583, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (584, 584, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (585, 585, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (586, 586, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (587, 587, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (588, 588, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (589, 589, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (590, 590, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (591, 591, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (592, 592, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (593, 593, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (594, 594, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (595, 595, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (596, 596, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (597, 597, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (598, 598, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (599, 599, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (600, 600, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (601, 601, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (602, 602, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (603, 603, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (604, 604, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (605, 605, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (606, 606, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (607, 607, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (608, 608, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (609, 609, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (610, 610, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (611, 611, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (612, 612, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (613, 613, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (614, 614, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (615, 615, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (616, 616, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (617, 617, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (618, 618, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (619, 619, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (620, 620, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (621, 621, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (622, 622, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (623, 623, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (624, 624, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (625, 625, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (626, 626, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (627, 627, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (628, 628, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (629, 629, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (630, 630, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (631, 631, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (632, 632, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (633, 633, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (634, 634, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (635, 635, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (636, 636, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (637, 637, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (638, 638, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (639, 639, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (640, 640, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (641, 641, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (642, 642, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (643, 643, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (644, 644, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (645, 645, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (646, 646, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (647, 647, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (648, 648, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (649, 649, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (650, 650, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (651, 651, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (652, 652, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (653, 653, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (654, 654, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (655, 655, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (656, 656, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (657, 657, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (658, 658, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (659, 659, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (660, 660, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (661, 661, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (662, 662, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (663, 663, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (664, 664, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (665, 665, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (666, 666, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (667, 667, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (668, 668, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (669, 669, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (670, 670, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (671, 671, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (672, 672, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (673, 673, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (674, 674, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (675, 675, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (676, 676, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (677, 677, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (678, 678, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (679, 679, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (680, 680, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (681, 681, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (682, 682, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (683, 683, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (684, 684, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (685, 685, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (686, 686, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (687, 687, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (688, 688, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (689, 689, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (690, 690, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (691, 691, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (692, 692, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (693, 693, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (694, 694, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (695, 695, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (696, 696, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (697, 697, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (698, 698, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (699, 699, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (700, 700, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (701, 701, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (702, 702, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (703, 703, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (704, 704, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (705, 705, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (706, 706, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (707, 707, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (708, 708, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (709, 709, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (710, 710, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (711, 711, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (712, 712, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (713, 713, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (714, 714, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (715, 715, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (716, 716, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (717, 717, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (718, 718, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (719, 719, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (720, 720, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (721, 721, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (722, 722, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (723, 723, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (724, 724, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (725, 725, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (726, 726, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (727, 727, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (728, 728, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (729, 729, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (730, 730, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (731, 731, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (732, 732, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (733, 733, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (734, 734, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (735, 735, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (736, 736, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (737, 737, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (738, 738, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (739, 739, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (740, 740, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (741, 741, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (742, 742, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (743, 743, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (744, 744, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (745, 745, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (746, 746, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (747, 747, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (748, 748, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (749, 749, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (750, 750, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (751, 751, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (752, 752, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (753, 753, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (754, 754, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (755, 755, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (756, 756, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (757, 757, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (758, 758, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (759, 759, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (760, 760, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (761, 761, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (762, 762, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (763, 763, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (764, 764, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (765, 765, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (766, 766, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (767, 767, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (768, 768, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (769, 769, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (770, 770, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (771, 771, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (772, 772, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (773, 773, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (774, 774, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (775, 775, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (776, 776, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (777, 777, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (778, 778, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (779, 779, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (780, 780, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (781, 781, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (782, 782, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (783, 783, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (784, 784, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (785, 785, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (786, 786, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (787, 787, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (788, 788, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (789, 789, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (790, 790, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (791, 791, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (792, 792, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (793, 793, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (794, 794, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (795, 795, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (796, 796, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (797, 797, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (798, 798, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (799, 799, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (800, 800, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (801, 801, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (802, 802, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (803, 803, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (804, 804, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (805, 805, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (806, 806, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (807, 807, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (808, 808, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (809, 809, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (810, 810, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (811, 811, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (812, 812, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (813, 813, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (814, 814, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (815, 815, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (816, 816, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (817, 817, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (818, 818, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (819, 819, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (820, 820, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (821, 821, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (822, 822, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (823, 823, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (824, 824, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (825, 825, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (826, 826, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (827, 827, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (828, 828, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (829, 829, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (830, 830, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (831, 831, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (832, 832, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (833, 833, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (834, 834, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (835, 835, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (836, 836, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (837, 837, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (838, 838, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (839, 839, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (840, 840, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (841, 841, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (842, 842, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (843, 843, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (844, 844, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (845, 845, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (846, 846, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (847, 847, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (848, 848, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (849, 849, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (850, 850, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (851, 851, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (852, 852, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (853, 853, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (854, 854, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (855, 855, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (856, 856, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (857, 857, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (858, 858, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (859, 859, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (860, 860, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (861, 861, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (862, 862, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (863, 863, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (864, 864, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (865, 865, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (866, 866, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (867, 867, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (868, 868, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (869, 869, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (870, 870, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (871, 871, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (872, 872, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (873, 873, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (874, 874, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (875, 875, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (876, 876, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (877, 877, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (878, 878, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (879, 879, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (880, 880, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (881, 881, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (882, 882, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (883, 883, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (884, 884, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (885, 885, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (886, 886, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (887, 887, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (888, 888, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (889, 889, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (890, 890, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (891, 891, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (892, 892, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (893, 893, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (894, 894, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (895, 895, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (896, 896, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (897, 897, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (898, 898, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (899, 899, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (900, 900, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (901, 901, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (902, 902, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (903, 903, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (904, 904, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (905, 905, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (906, 906, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (907, 907, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (908, 908, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (909, 909, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (910, 910, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (911, 911, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (912, 912, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (913, 913, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (914, 914, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (915, 915, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (916, 916, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (917, 917, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (918, 918, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (919, 919, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (920, 920, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (921, 921, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (922, 922, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (923, 923, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (924, 924, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (925, 925, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (926, 926, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (927, 927, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (928, 928, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (929, 929, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (930, 930, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (931, 931, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (932, 932, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (933, 933, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (934, 934, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (935, 935, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (936, 936, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (937, 937, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (938, 938, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (939, 939, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (940, 940, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (941, 941, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (942, 942, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (943, 943, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (944, 944, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (945, 945, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (946, 946, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (947, 947, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (948, 948, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (949, 949, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (950, 950, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (951, 951, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (952, 952, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (953, 953, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (954, 954, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (955, 955, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (956, 956, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (957, 957, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (958, 958, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (959, 959, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (960, 960, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (961, 961, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (962, 962, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (963, 963, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (964, 964, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (965, 965, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (966, 966, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (967, 967, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (968, 968, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (969, 969, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (970, 970, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (971, 971, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (972, 972, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (973, 973, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (974, 974, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (975, 975, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (976, 976, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (977, 977, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (978, 978, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (979, 979, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (980, 980, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (981, 981, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (982, 982, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (983, 983, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (984, 984, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (985, 985, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (986, 986, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (987, 987, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (988, 988, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (989, 989, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (990, 990, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (991, 991, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (992, 992, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (993, 993, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (994, 994, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (995, 995, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (996, 996, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (997, 997, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (998, 998, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (999, 999, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1000, 1000, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1001, 1001, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1002, 1002, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1003, 1003, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1004, 1004, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1005, 1005, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1006, 1006, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1007, 1007, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1008, 1008, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1009, 1009, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1010, 1010, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1011, 1011, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1012, 1012, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1013, 1013, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1014, 1014, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1015, 1015, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1016, 1016, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1017, 1017, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1018, 1018, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1019, 1019, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1020, 1020, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1021, 1021, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1022, 1022, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1023, 1023, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1024, 1024, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1025, 1025, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1026, 1026, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1027, 1027, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1028, 1028, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1029, 1029, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1030, 1030, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1031, 1031, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1032, 1032, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1033, 1033, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1034, 1034, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1035, 1035, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1036, 1036, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1037, 1037, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1038, 1038, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1039, 1039, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1040, 1040, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1041, 1041, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1042, 1042, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1043, 1043, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1044, 1044, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1045, 1045, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1046, 1046, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1047, 1047, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1048, 1048, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1049, 1049, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1050, 1050, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1051, 1051, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1052, 1052, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1053, 1053, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1054, 1054, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1055, 1055, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1056, 1056, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1057, 1057, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1058, 1058, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1059, 1059, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1060, 1060, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1061, 1061, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1062, 1062, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1063, 1063, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1064, 1064, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1065, 1065, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1066, 1066, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1067, 1067, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1068, 1068, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1069, 1069, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1070, 1070, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1071, 1071, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1072, 1072, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1073, 1073, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1074, 1074, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1075, 1075, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1076, 1076, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1077, 1077, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1078, 1078, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1079, 1079, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1080, 1080, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1081, 1081, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1082, 1082, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1083, 1083, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1084, 1084, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1085, 1085, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1086, 1086, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1087, 1087, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1088, 1088, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1089, 1089, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1090, 1090, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1091, 1091, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1092, 1092, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1093, 1093, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1094, 1094, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1095, 1095, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1096, 1096, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1097, 1097, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1098, 1098, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1099, 1099, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1100, 1100, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1101, 1101, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1102, 1102, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1103, 1103, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1104, 1104, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1105, 1105, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1106, 1106, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1107, 1107, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1108, 1108, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1109, 1109, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1110, 1110, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1111, 1111, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1112, 1112, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1113, 1113, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1114, 1114, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1115, 1115, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1116, 1116, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1117, 1117, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1118, 1118, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1119, 1119, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1120, 1120, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1121, 1121, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1122, 1122, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1123, 1123, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1124, 1124, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1125, 1125, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1126, 1126, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1127, 1127, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1128, 1128, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1129, 1129, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1130, 1130, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1131, 1131, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1132, 1132, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1133, 1133, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1134, 1134, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1135, 1135, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1136, 1136, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1137, 1137, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1138, 1138, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1139, 1139, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1140, 1140, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1141, 1141, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1142, 1142, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1143, 1143, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1144, 1144, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1145, 1145, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1146, 1146, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1147, 1147, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1148, 1148, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1149, 1149, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1150, 1150, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1151, 1151, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1152, 1152, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1153, 1153, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1154, 1154, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1155, 1155, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1156, 1156, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1157, 1157, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1158, 1158, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1159, 1159, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1160, 1160, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1161, 1161, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1162, 1162, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1163, 1163, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1164, 1164, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1165, 1165, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1166, 1166, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1167, 1167, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1168, 1168, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1169, 1169, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1170, 1170, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1171, 1171, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1172, 1172, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1173, 1173, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1174, 1174, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1175, 1175, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1176, 1176, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1177, 1177, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1178, 1178, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1179, 1179, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1180, 1180, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1181, 1181, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1182, 1182, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1183, 1183, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1184, 1184, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1185, 1185, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1186, 1186, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1187, 1187, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1188, 1188, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1189, 1189, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1190, 1190, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1191, 1191, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1192, 1192, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1193, 1193, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1194, 1194, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1195, 1195, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1196, 1196, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1197, 1197, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1198, 1198, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1199, 1199, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1200, 1200, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1201, 1201, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1202, 1202, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1203, 1203, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1204, 1204, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1205, 1205, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1206, 1206, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1207, 1207, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1208, 1208, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1209, 1209, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1210, 1210, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1211, 1211, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1212, 1212, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1213, 1213, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1214, 1214, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1215, 1215, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1216, 1216, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1217, 1217, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1218, 1218, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1219, 1219, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1220, 1220, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1221, 1221, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1222, 1222, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1223, 1223, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1224, 1224, 0, false, 0, 1, NULL, NULL);
INSERT INTO public.tb_t_tools_positions VALUES (1229, 1229, 0, false, 6, 1, NULL, NULL);


--
-- TOC entry 3724 (class 0 OID 0)
-- Dependencies: 221
-- Name: tb_m_users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_m_users_user_id_seq', 2, true);


--
-- TOC entry 3543 (class 2606 OID 32546)
-- Name: tb_m_distributions pk_tb_m_distributions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_distributions
    ADD CONSTRAINT pk_tb_m_distributions PRIMARY KEY (distribution_id);


--
-- TOC entry 3545 (class 2606 OID 32555)
-- Name: tb_m_lines pk_tb_m_lines; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_lines
    ADD CONSTRAINT pk_tb_m_lines PRIMARY KEY (line_id);


--
-- TOC entry 3539 (class 2606 OID 32501)
-- Name: tb_m_machines pk_tb_m_machines; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_machines
    ADD CONSTRAINT pk_tb_m_machines PRIMARY KEY (machine_id);


--
-- TOC entry 3533 (class 2606 OID 32428)
-- Name: tb_m_systems pk_tb_m_system; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_systems
    ADD CONSTRAINT pk_tb_m_system PRIMARY KEY (system_id);


--
-- TOC entry 3524 (class 2606 OID 32409)
-- Name: tb_m_tool_types pk_tb_m_tool_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_tool_types
    ADD CONSTRAINT pk_tb_m_tool_types PRIMARY KEY (tool_type_id);


--
-- TOC entry 3537 (class 2606 OID 32443)
-- Name: tb_m_tools_type_std pk_tb_m_tools_type_std; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_tools_type_std
    ADD CONSTRAINT pk_tb_m_tools_type_std PRIMARY KEY (tool_type_std_id);


--
-- TOC entry 3541 (class 2606 OID 32527)
-- Name: tb_r_tool_checks pk_tb_r_tool_checks; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tool_checks
    ADD CONSTRAINT pk_tb_r_tool_checks PRIMARY KEY (tool_check_id);


--
-- TOC entry 3547 (class 2606 OID 32586)
-- Name: tb_r_tool_problems pk_tb_r_tool_problems; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tool_problems
    ADD CONSTRAINT pk_tb_r_tool_problems PRIMARY KEY (tool_problem_id);


--
-- TOC entry 3528 (class 2606 OID 32414)
-- Name: tb_r_tools pk_tb_r_tools; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tools
    ADD CONSTRAINT pk_tb_r_tools PRIMARY KEY (tool_id);


--
-- TOC entry 3535 (class 2606 OID 32433)
-- Name: tb_r_tools_histories pk_tb_r_tools_histories; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tools_histories
    ADD CONSTRAINT pk_tb_r_tools_histories PRIMARY KEY (tool_history_id);


--
-- TOC entry 3531 (class 2606 OID 32419)
-- Name: tb_t_tools_positions pk_tb_r_tools_inventory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_t_tools_positions
    ADD CONSTRAINT pk_tb_r_tools_inventory PRIMARY KEY (tool_position_id);


--
-- TOC entry 3549 (class 2606 OID 32654)
-- Name: tb_m_users tb_m_users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_users
    ADD CONSTRAINT tb_m_users_pk PRIMARY KEY (user_id);


--
-- TOC entry 3526 (class 2606 OID 32516)
-- Name: tb_m_tool_types unq_tb_m_tool_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_tool_types
    ADD CONSTRAINT unq_tb_m_tool_types UNIQUE (tool_type_nm);


--
-- TOC entry 3529 (class 1259 OID 32597)
-- Name: uq_tool_qr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_tool_qr ON public.tb_r_tools USING btree (tool_qr);


--
-- TOC entry 3558 (class 2606 OID 32556)
-- Name: tb_m_machines fk_tb_m_machines_line; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_machines
    ADD CONSTRAINT fk_tb_m_machines_line FOREIGN KEY (line_id) REFERENCES public.tb_m_lines(line_id);


--
-- TOC entry 3557 (class 2606 OID 32468)
-- Name: tb_m_tools_type_std fk_tb_m_tools_type_std; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_m_tools_type_std
    ADD CONSTRAINT fk_tb_m_tools_type_std FOREIGN KEY (tool_type_id) REFERENCES public.tb_m_tool_types(tool_type_id);


--
-- TOC entry 3559 (class 2606 OID 32532)
-- Name: tb_r_tool_checks fk_tb_r_tool_checkshistory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tool_checks
    ADD CONSTRAINT fk_tb_r_tool_checkshistory FOREIGN KEY (tool_history_id) REFERENCES public.tb_r_tools_histories(tool_history_id);


--
-- TOC entry 3560 (class 2606 OID 32587)
-- Name: tb_r_tool_problems fk_tb_r_tool_history_problems; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tool_problems
    ADD CONSTRAINT fk_tb_r_tool_history_problems FOREIGN KEY (tool_history_id) REFERENCES public.tb_r_tools_histories(tool_history_id);


--
-- TOC entry 3555 (class 2606 OID 32561)
-- Name: tb_r_tools_histories fk_tb_r_tools_distribution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tools_histories
    ADD CONSTRAINT fk_tb_r_tools_distribution FOREIGN KEY (distribution_id) REFERENCES public.tb_m_distributions(distribution_id);


--
-- TOC entry 3556 (class 2606 OID 32571)
-- Name: tb_r_tools_histories fk_tb_r_tools_machine; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tools_histories
    ADD CONSTRAINT fk_tb_r_tools_machine FOREIGN KEY (machine_id) REFERENCES public.tb_m_machines(machine_id);


--
-- TOC entry 3551 (class 2606 OID 32478)
-- Name: tb_t_tools_positions fk_tb_r_tools_positions; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_t_tools_positions
    ADD CONSTRAINT fk_tb_r_tools_positions FOREIGN KEY (tool_id) REFERENCES public.tb_r_tools(tool_id);


--
-- TOC entry 3550 (class 2606 OID 32463)
-- Name: tb_r_tools fk_tb_r_tools_tb_m_tool_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tools
    ADD CONSTRAINT fk_tb_r_tools_tb_m_tool_types FOREIGN KEY (tool_type_id) REFERENCES public.tb_m_tool_types(tool_type_id);


--
-- TOC entry 3552 (class 2606 OID 32566)
-- Name: tb_t_tools_positions fk_tb_t_distributin_positions; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_t_tools_positions
    ADD CONSTRAINT fk_tb_t_distributin_positions FOREIGN KEY (distribution_id) REFERENCES public.tb_m_distributions(distribution_id);


--
-- TOC entry 3553 (class 2606 OID 32592)
-- Name: tb_t_tools_positions fk_tb_t_tools_mcs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_t_tools_positions
    ADD CONSTRAINT fk_tb_t_tools_mcs FOREIGN KEY (machine_id) REFERENCES public.tb_m_machines(machine_id);


--
-- TOC entry 3554 (class 2606 OID 32491)
-- Name: tb_r_tools_histories fk_tool_his_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_r_tools_histories
    ADD CONSTRAINT fk_tool_his_id FOREIGN KEY (tool_id) REFERENCES public.tb_r_tools(tool_id);


-- Completed on 2024-07-25 11:28:19 WIB

--
-- PostgreSQL database dump complete
--

