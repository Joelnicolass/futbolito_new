Estructura de la base de datos (schema: public)
A continuación tienes un resumen en Markdown de las tablas, columnas, claves primarias, restricciones relevantes y relaciones foráneas que hay actualmente en el esquema public.

public.matches
Descripción: Partidos de fútbol organizados por usuarios
Primary key: id (uuid, default: extensions.uuid_generate_v4())
Columnas:
id: uuid
admin_id: uuid
match_type_id: uuid
mode: text (check: mode ∈ {teams_private, no_teams_public, no_teams_private, teams_public})
title: text (check: length 3..100)
description: text (nullable)
date: timestamptz
location: text (check: length 3..200)
location_lat: numeric (nullable)
location_lng: numeric (nullable)
max_starters_per_team: integer (check: > 0)
invitation_code: text (nullable, unique) — código único para partidos privados
status: text (default 'scheduled', check: ∈ {scheduled, in_progress, finished, cancelled})
created_at: timestamptz (default now())
updated_at: timestamptz (default now())
Foreign keys:
admin_id → public.users(id)
match_type_id → public.match_types(id)
Relacionado por FK desde public.match_teams.match_id, public.match_players.match_id, public.invitations.match_id
public.match_players
Descripción: Jugadores participantes en un partido con su posición
Primary key: id (uuid)
Columnas:
id: uuid
match_id: uuid
match_team_id: uuid
user_id: uuid
position: text (nullable)
is_starter: boolean (default false)
status: text (default 'pending', check: ∈ {pending, confirmed, declined})
joined_at: timestamptz (default now())
Foreign keys:
match_id → public.matches(id)
match_team_id → public.match_teams(id)
user_id → public.users(id)
public.match_teams
Descripción: Equipos asignados a un partido (puede ser NULL para modos sin equipos)
Primary key: id (uuid)
Columnas:
id: uuid
match_id: uuid
team_id: uuid (nullable)
team_number: integer (check: ∈ {1, 2})
formation_id: uuid (nullable)
Foreign keys:
match_id → public.matches(id)
team_id → public.teams(id)
formation_id → public.formations(id)
Relacionado por FK desde public.match_players.match_team_id
public.invitations
Descripción: Sistema de invitaciones para partidos, equipos y amistades
Primary key: id (uuid)
Columnas:
id: uuid
type: text (check: ∈ {match, team, friend})
sender_id: uuid
receiver_id: uuid (nullable) — NULL si el destinatario aún no tiene cuenta
receiver_email: text (nullable, check: formato email)
receiver_phone: text (nullable)
match_id: uuid (nullable)
team_id: uuid (nullable)
assigned_position: text (nullable) — sólo para type = match
status: text (default 'sent', check: ∈ {sent, pending, accepted, declined})
message: text (nullable)
created_at: timestamptz (default now())
responded_at: timestamptz (nullable)
Foreign keys:
sender_id → public.users(id)
receiver_id → public.users(id)
match_id → public.matches(id)
team_id → public.teams(id)
public.users
Descripción: Usuarios de la aplicación, vinculados con Firebase Auth
Primary key: id (uuid)
Columnas:
id: uuid
firebase_uid: text (unique) — UID único de Firebase Auth
email: text (unique, check: formato email)
display_name: text (nullable)
photo_url: text (nullable)
created_at: timestamptz (default now())
updated_at: timestamptz (default now())
matches_played: integer (default 0, check: >= 0)
matches_won: integer (default 0, check: >= 0)
matches_lost: integer (default 0, check: >= 0)
matches_drawn: integer (default 0, check: >= 0)
Foreign keys:
Referenciado por muchas tablas: teams.admin_id, team_members.user_id, match_types.created_by, matches.admin_id, match_players.user_id, invitations.sender_id/receiver_id, friendships.user_id/friend_id, etc.
public.teams
Descripción: Equipos con roster permanente de jugadores
Primary key: id (uuid)
Columnas:
id: uuid
name: text (check: length 2..50)
shield_url: text (nullable)
admin_id: uuid — usuario administrador del equipo (creador)
created_at: timestamptz (default now())
updated_at: timestamptz (default now())
matches_played: integer (default 0, check: >= 0)
matches_won: integer (default 0, check: >= 0)
matches_lost: integer (default 0, check: >= 0)
matches_drawn: integer (default 0, check: >= 0)
Foreign keys:
admin_id → public.users(id)
Relacionado por FK desde public.team_members.team_id, public.match_teams.team_id, public.invitations.team_id
public.formations
Descripción: Formaciones tácticas para cada tipo de partido
Primary key: id (uuid)
Filas actuales: 6
Columnas:
id: uuid
name: text (check: length 2..50)
match_type_id: uuid
positions: jsonb (check: jsonb_typeof(positions) = 'array') — ejemplo: [{ "position": "GK", "x": 0.5, "y": 0.1 }, ...]
is_default: boolean (default false)
created_at: timestamptz (default now())
Foreign keys:
match_type_id → public.match_types(id)
Relacionado por FK desde public.match_teams.formation_id
public.friendships
Descripción: Relaciones de amistad entre usuarios
Primary key: id (uuid)
Columnas:
id: uuid
user_id: uuid
friend_id: uuid
status: text (default 'pending', check: ∈ {pending, accepted})
created_at: timestamptz (default now())
Foreign keys:
user_id → public.users(id)
friend_id → public.users(id)
public.team_members
Descripción: Relación muchos-a-muchos entre equipos y usuarios
Primary key: id (uuid)
Columnas:
id: uuid
team_id: uuid
user_id: uuid
joined_at: timestamptz (default now())
Foreign keys:
team_id → public.teams(id)
user_id → public.users(id)
public.match_types
Descripción: Tipos de partido (5vs5, 7vs7, 11vs11, etc.)
Primary key: id (uuid)
Filas actuales: 4
Columnas:
id: uuid
name: text (check: length 2..50)
players_per_team: integer (check: >0 and <=22)
created_by: uuid (nullable)
is_default: boolean (default false)
created_at: timestamptz (default now())
Foreign keys:
created_by → public.users(id)
Relacionado por FK desde public.formations.match_type_id, public.matches.match_type_id
public.fcm_tokens
Descripción: (Recientemente creada) Tokens FCM para notificaciones push
Primary key: id (uuid, default gen_random_uuid())
Columnas:
id: uuid
user_id: uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE
token: text NOT NULL
created_at: timestamptz NOT NULL DEFAULT now()
updated_at: timestamptz NOT NULL DEFAULT now()
Índices:
UNIQUE idx_fcm_tokens_token ON (token)
idx_fcm_tokens_user_id ON (user_id)
Trigger / función:
function public.fcm_tokens_set_updated_at() — pone NEW.updated_at = now()
trigger trg_fcm_tokens_updated_at — BEFORE UPDATE -> ejecuta la función
