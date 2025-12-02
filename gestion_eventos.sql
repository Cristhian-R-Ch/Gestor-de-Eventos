-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-12-2025 a las 02:36:08
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_eventos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `authtoken_token`
--

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`) VALUES
('2768b136a0f91dbc5aed284fc04c2f785d97e65d', '2025-12-02 00:30:50.626881', 3),
('4ca9a5d45c3634a121700f359a6de8423978afeb', '2025-12-02 01:10:08.867016', 4),
('5b467a39cf2bfe5052c071f003d7f6bd23f66124', '2025-12-02 00:13:52.424884', 1),
('887be67b3ec7119197a2bbfe0f08185bb4bad961', '2025-12-02 01:13:10.127600', 5),
('de8609f98195a8cfe851875e65e90d35b2590515', '2025-12-02 01:13:53.853060', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add Token', 6, 'add_token'),
(22, 'Can change Token', 6, 'change_token'),
(23, 'Can delete Token', 6, 'delete_token'),
(24, 'Can view Token', 6, 'view_token'),
(25, 'Can add Token', 7, 'add_tokenproxy'),
(26, 'Can change Token', 7, 'change_tokenproxy'),
(27, 'Can delete Token', 7, 'delete_tokenproxy'),
(28, 'Can view Token', 7, 'view_tokenproxy'),
(29, 'Can add evento', 8, 'add_evento'),
(30, 'Can change evento', 8, 'change_evento'),
(31, 'Can delete evento', 8, 'delete_evento'),
(32, 'Can view evento', 8, 'view_evento'),
(33, 'Can add user', 9, 'add_usuario'),
(34, 'Can change user', 9, 'change_usuario'),
(35, 'Can delete user', 9, 'delete_usuario'),
(36, 'Can view user', 9, 'view_usuario'),
(37, 'Can add reserva', 10, 'add_reserva'),
(38, 'Can change reserva', 10, 'change_reserva'),
(39, 'Can delete reserva', 10, 'delete_reserva'),
(40, 'Can view reserva', 10, 'view_reserva');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_evento`
--

CREATE TABLE `core_evento` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `descripcion` longtext NOT NULL,
  `fecha_inicio` datetime(6) NOT NULL,
  `fecha_fin` datetime(6) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `ubicacion` varchar(200) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_evento`
--

INSERT INTO `core_evento` (`id`, `nombre`, `descripcion`, `fecha_inicio`, `fecha_fin`, `capacidad`, `ubicacion`, `estado`) VALUES
(1, 'Taller', 'Taller de prueba', '2025-12-01 23:09:38.000000', '2025-12-05 23:09:50.000000', 15, 'Sala 001', 'activo'),
(2, 'Charla', 'Charla de prueba', '2025-12-01 23:10:27.000000', '2025-12-05 23:10:28.000000', 20, 'Sala 009', 'activo'),
(3, 'Lanzamiento Nueva Colección', 'Presentación exclusiva de productos de temporada para clientes VIP.', '2025-12-10 19:00:00.000000', '2025-12-10 22:00:00.000000', 80, 'Showroom Principal', 'activo'),
(4, 'Cena de Aniversario', 'Celebración de los 10 años de la empresa con todo el personal.', '2025-12-19 20:00:00.000000', '2025-12-20 02:00:00.000000', 150, 'Centro de Eventos El Parque', 'activo'),
(5, 'Capacitación: Excel Intermedio', 'Curso práctico para el área administrativa y ventas.', '2026-01-08 09:00:00.000000', '2026-01-08 13:00:00.000000', 20, 'Sala de Reuniones A', 'activo'),
(6, 'Desayuno de Networking', 'Encuentro con proveedores y socios estratégicos locales.', '2025-12-15 08:30:00.000000', '2025-12-15 11:00:00.000000', 40, 'Cafetería Central', 'activo'),
(7, 'Taller de Liderazgo', 'Mejorando las habilidades blandas para jefaturas.', '2026-01-12 15:00:00.000000', '2026-01-12 18:00:00.000000', 15, 'Sala de Directorio', 'activo'),
(8, 'Gran Venta de Bodega', 'Apertura especial al público con descuentos de liquidación.', '2025-12-28 10:00:00.000000', '2025-12-28 18:00:00.000000', 300, 'Bodega Central', 'activo'),
(9, 'Charla: Atención al Cliente', 'Cómo mejorar la experiencia de compra y fidelizar.', '2026-02-05 10:00:00.000000', '2026-02-05 12:00:00.000000', 50, 'Auditorio Pyme', 'activo'),
(10, 'Jornada de Planificación 2026', 'Definición de objetivos estratégicos para el próximo año.', '2026-01-03 09:00:00.000000', '2026-01-03 18:00:00.000000', 10, 'Sala de Gerencia', 'activo'),
(11, 'After Office de Fin de Mes', 'Instancia recreativa para integración de equipos.', '2025-12-27 18:30:00.000000', '2025-12-27 21:00:00.000000', 60, 'Terraza del Edificio', 'activo'),
(12, 'Seminario: Marketing Digital', 'Estrategias básicas para redes sociales en PYMES.', '2026-01-20 16:00:00.000000', '2026-01-20 19:00:00.000000', 40, 'Sala de Capacitación B', 'activo'),
(13, 'Feria de Emprendedores', 'Espacio para mostrar productos locales a la comunidad.', '2026-02-14 11:00:00.000000', '2026-02-14 20:00:00.000000', 500, 'Plaza Mayor', 'activo'),
(14, 'Inducción Nuevos Ingresos', 'Bienvenida y capacitación para el personal contratado.', '2026-03-02 09:00:00.000000', '2026-03-02 11:00:00.000000', 10, 'Sala RRHH', 'activo'),
(15, 'Charla: Gestión Tributaria', 'Actualización sobre nuevas normativas de impuestos.', '2026-01-15 10:00:00.000000', '2026-01-15 12:00:00.000000', 30, 'Sala de Reuniones A', 'cancelado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_reserva`
--

CREATE TABLE `core_reserva` (
  `id` bigint(20) NOT NULL,
  `cantidad_plazas` int(11) NOT NULL,
  `estado_reserva` varchar(20) NOT NULL,
  `fecha_reserva` datetime(6) NOT NULL,
  `codigo_reserva` varchar(50) NOT NULL,
  `nombre_contacto` varchar(100) DEFAULT NULL,
  `email_contacto` varchar(254) DEFAULT NULL,
  `rut_contacto` varchar(12) DEFAULT NULL,
  `evento_id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_reserva`
--

INSERT INTO `core_reserva` (`id`, `cantidad_plazas`, `estado_reserva`, `fecha_reserva`, `codigo_reserva`, `nombre_contacto`, `email_contacto`, `rut_contacto`, `evento_id`, `usuario_id`) VALUES
(1, 2, 'confirmada', '2025-12-02 01:26:26.754768', 'RES-58BCFA24', NULL, NULL, NULL, 4, 4),
(2, 1, 'confirmada', '2025-12-02 01:26:43.939006', 'RES-F862EA6B', NULL, NULL, NULL, 5, 4),
(3, 5, 'confirmada', '2025-12-02 01:27:12.292880', 'RES-8C5B55AE', 'Empresa Partner', 'contacto@partner.cl', '76.111.222-3', 4, NULL),
(4, 3, 'confirmada', '2025-12-02 01:27:21.830702', 'RES-2F76C677', 'Consultora Externa', 'rrhh@externos.cl', NULL, 5, NULL),
(5, 16, 'confirmada', '2025-12-02 01:27:41.778416', 'RES-B4AA432E', 'Grupo Masivo', 'masivo@test.com', NULL, 5, NULL),
(6, 40, 'confirmada', '2025-12-02 01:29:31.038478', 'RES-1138B347', 'Invitados', 'invt@test.com', NULL, 8, NULL),
(7, 10, 'cancelada', '2025-12-02 01:30:17.060401', 'RES-1EFF3E45', NULL, NULL, NULL, 8, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_usuario`
--

CREATE TABLE `core_usuario` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) NOT NULL,
  `rol` varchar(20) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `apellido` varchar(150) NOT NULL,
  `nombre` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_usuario`
--

INSERT INTO `core_usuario` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `email`, `rol`, `estado`, `apellido`, `nombre`) VALUES
(1, 'pbkdf2_sha256$600000$D15tP6uQzaIFFwKzJ0iQqn$mLYx2nKA1EUS4ijamr2BVMU9wM71VBTzQV/K98ZQjcU=', '2025-12-02 00:25:12.962476', 1, 'admin@test.com', '', '', 1, 1, '2025-12-01 23:07:14.000000', 'admin@test.com', 'admin', 'activo', 'administrador', 'usuario'),
(3, 'pbkdf2_sha256$600000$wklXPjVL93BynhUnSutSHU$AdXKmFwKOupHgvdyyqi6IEbZBRfRL05KMPnuwqgZyYU=', '2025-12-02 00:56:28.709926', 0, 'cristhian@test.com', '', '', 0, 1, '2025-12-01 23:17:34.000000', 'cristhian@test.com', 'cliente', 'activo', 'test', 'usuario'),
(4, 'pbkdf2_sha256$600000$WU7E39hKlWTMkZA1ZrnbJC$OmPNloM9Np45p274QMuc/uQJSpibxbg6RByEaKg00+I=', '2025-12-02 01:21:38.850836', 0, 'juan.perez@test.com', '', '', 0, 1, '2025-12-02 00:17:11.305710', 'juan.perez@test.com', 'cliente', 'activo', 'Perez', 'Juan'),
(5, 'pbkdf2_sha256$600000$vtnMPbZlWmLufjoZM42tzG$nKqiiux8RbkHCqPkTRRmWYXWveonNKXbwsXT4lvqKq0=', '2025-12-02 01:13:10.123490', 0, 'maria.gonzalez@test.com', '', '', 0, 1, '2025-12-02 00:17:39.677325', 'maria.gonzalez@test.com', 'cliente', 'activo', 'Gonzalez', 'Maria'),
(6, 'pbkdf2_sha256$600000$LyRq4AHEc8bcvlu4Bombij$pwqvRlYVPtvtiQMkVJRbPSb9YAjTos6M34TWM+8Rd7o=', '2025-12-02 01:13:53.848489', 0, 'roberto.mendez@tes.com', '', '', 0, 1, '2025-12-02 00:18:21.291044', 'roberto.mendez@test.com', 'admin', 'activo', 'Mendez', 'Roberto'),
(7, 'pbkdf2_sha256$600000$dzLi3Ez4ffnRvjS591mwPA$foLAv0u4Z2xmkA9EW2HXx+vkGh6KsB4KLkpo/lik7dU=', NULL, 0, 'john.doe@test.com', '', '', 0, 1, '2025-12-02 00:18:34.954422', 'john.doe@test.com', 'cliente', 'activo', 'Doe', 'John');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_usuario_groups`
--

CREATE TABLE `core_usuario_groups` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_usuario_user_permissions`
--

CREATE TABLE `core_usuario_user_permissions` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-12-01 23:10:14.798226', '1', 'Taller', 1, '[{\"added\": {}}]', 8, 1),
(2, '2025-12-01 23:10:41.200423', '2', 'Charla', 1, '[{\"added\": {}}]', 8, 1),
(3, '2025-12-01 23:12:27.569795', '1', 'admin@test.com', 2, '[{\"changed\": {\"fields\": [\"Nombre\"]}}]', 9, 1),
(4, '2025-12-01 23:13:04.538118', '2', '', 1, '[{\"added\": {}}]', 9, 1),
(5, '2025-12-01 23:17:34.495898', '3', '', 1, '[{\"added\": {}}]', 9, 1),
(6, '2025-12-01 23:18:22.466707', '3', 'cristhian@test.com', 2, '[{\"changed\": {\"fields\": [\"Email\", \"Nombre\", \"Apellido\"]}}]', 9, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(6, 'authtoken', 'token'),
(7, 'authtoken', 'tokenproxy'),
(4, 'contenttypes', 'contenttype'),
(8, 'core', 'evento'),
(10, 'core', 'reserva'),
(9, 'core', 'usuario'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-12-01 22:49:53.988253'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-12-01 22:49:54.013317'),
(3, 'auth', '0001_initial', '2025-12-01 22:49:54.100724'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-12-01 22:49:54.123796'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-12-01 22:49:54.128956'),
(6, 'auth', '0004_alter_user_username_opts', '2025-12-01 22:49:54.132650'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-12-01 22:49:54.138271'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-12-01 22:49:54.138777'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-12-01 22:49:54.141850'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-12-01 22:49:54.146514'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-12-01 22:49:54.149596'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-12-01 22:49:54.155833'),
(13, 'auth', '0011_update_proxy_permissions', '2025-12-01 22:49:54.158874'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-12-01 22:49:54.163458'),
(15, 'core', '0001_initial', '2025-12-01 22:49:54.323792'),
(16, 'admin', '0001_initial', '2025-12-01 22:49:54.377269'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-12-01 22:49:54.382915'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-12-01 22:49:54.388564'),
(19, 'authtoken', '0001_initial', '2025-12-01 22:49:54.427016'),
(20, 'authtoken', '0002_auto_20160226_1747', '2025-12-01 22:49:54.446015'),
(21, 'authtoken', '0003_tokenproxy', '2025-12-01 22:49:54.447575'),
(22, 'authtoken', '0004_alter_tokenproxy_options', '2025-12-01 22:49:54.450151'),
(23, 'core', '0002_usuario_apellido_usuario_nombre', '2025-12-01 22:49:54.469630'),
(24, 'sessions', '0001_initial', '2025-12-01 22:49:54.487993');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `core_evento`
--
ALTER TABLE `core_evento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `core_reserva`
--
ALTER TABLE `core_reserva`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo_reserva` (`codigo_reserva`),
  ADD KEY `core_reserva_evento_id_c407b8e9_fk_core_evento_id` (`evento_id`),
  ADD KEY `core_reserva_usuario_id_ad825496_fk_core_usuario_id` (`usuario_id`);

--
-- Indices de la tabla `core_usuario`
--
ALTER TABLE `core_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `core_usuario_groups`
--
ALTER TABLE `core_usuario_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_usuario_groups_usuario_id_group_id_bde3c750_uniq` (`usuario_id`,`group_id`),
  ADD KEY `core_usuario_groups_group_id_55312a9a_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `core_usuario_user_permissions`
--
ALTER TABLE `core_usuario_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_usuario_user_permis_usuario_id_permission_id_7a048d24_uniq` (`usuario_id`,`permission_id`),
  ADD KEY `core_usuario_user_pe_permission_id_7f881653_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_core_usuario_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `core_evento`
--
ALTER TABLE `core_evento`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `core_reserva`
--
ALTER TABLE `core_reserva`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `core_usuario`
--
ALTER TABLE `core_usuario`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `core_usuario_groups`
--
ALTER TABLE `core_usuario_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_usuario_user_permissions`
--
ALTER TABLE `core_usuario_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_core_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `core_usuario` (`id`);

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `core_reserva`
--
ALTER TABLE `core_reserva`
  ADD CONSTRAINT `core_reserva_evento_id_c407b8e9_fk_core_evento_id` FOREIGN KEY (`evento_id`) REFERENCES `core_evento` (`id`),
  ADD CONSTRAINT `core_reserva_usuario_id_ad825496_fk_core_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `core_usuario` (`id`);

--
-- Filtros para la tabla `core_usuario_groups`
--
ALTER TABLE `core_usuario_groups`
  ADD CONSTRAINT `core_usuario_groups_group_id_55312a9a_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `core_usuario_groups_usuario_id_97385234_fk_core_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `core_usuario` (`id`);

--
-- Filtros para la tabla `core_usuario_user_permissions`
--
ALTER TABLE `core_usuario_user_permissions`
  ADD CONSTRAINT `core_usuario_user_pe_permission_id_7f881653_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `core_usuario_user_pe_usuario_id_ce4108a7_fk_core_usua` FOREIGN KEY (`usuario_id`) REFERENCES `core_usuario` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_core_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `core_usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
