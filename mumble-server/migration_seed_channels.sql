PRAGMA foreign_keys = ON;

BEGIN;

-- Ensure the root channel has a clear name on the default virtual server.
UPDATE "channels" SET "name" = 'Root' WHERE "server_id" = 1 AND "channel_id" = 0;

-- Admin channel + 22 team channels, all directly under Root.
INSERT OR IGNORE INTO "channels" ("server_id", "channel_id", "parent_id", "name", "inheritacl") VALUES
    (1, 1, 0, 'admin', 1),
    (1, 2, 0, 'первый вагончик', 1),
    (1, 3, 0, 'SNUS HAPPENS', 1),
    (1, 4, 0, 'bowie knife99', 1),
    (1, 5, 0, 'Goodwater', 1),
    (1, 6, 0, 'no1d_the_bomj$s', 1),
    (1, 7, 0, 'Аллапульские Бревна', 1),
    (1, 8, 0, '6 ДРАКОНОВ С ПРОПИТЫМИ МОЗГАМИ', 1),
    (1, 9, 0, 'Blasted bulls', 1),
    (1, 10, 0, 'Arasaka', 1),
    (1, 11, 0, 'Въеби ему, Донателло!', 1),
    (1, 12, 0, 'RIP AND TEAR', 1),
    (1, 13, 0, 'турник оффлайн', 1),
    (1, 14, 0, 'старыйсычуань.рус', 1),
    (1, 15, 0, 'Vitaliki', 1),
    (1, 16, 0, 'Пузики на Москоу Лане!', 1),
    (1, 17, 0, 'Last Hope Team', 1),
    (1, 18, 0, 'Airshot Victims', 1),
    (1, 19, 0, 'Moscow Funkers', 1),
    (1, 20, 0, 'Air danger', 1),
    (1, 21, 0, 'bLANt', 1),
    (1, 22, 0, 'Blast from past', 1),
    (1, 23, 0, 'T-team', 1);

-- Wipe any previous ACLs for the seeded channels so this migration always wins.
DELETE FROM "acl" WHERE "server_id" = 1 AND "channel_id" IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23);

-- Lock down every channel with its own access token.
-- Permission mask: Traverse(2)+Enter(4)+Speak(8)+LinkChannel(128)+Whisper(256)+TextMessage(512) = 910
-- Team tokens omit LinkChannel (mask 782) so only the admin token can link channels.
-- The admin token is also granted on every team channel so admins can join everywhere.

-- admin (token: Zr4Pj8Xq2Wv9Tc6L)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 1, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 1, 6, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- первый вагончик (token: Nm7Kx3Lp9Ds5Qw8R)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 2, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 2, 6, NULL, '#Nm7Kx3Lp9Ds5Qw8R', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 2, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- SNUS HAPPENS (token: Bt2Yh6Vc4Wn8Mz1K)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 3, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 3, 6, NULL, '#Bt2Yh6Vc4Wn8Mz1K', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 3, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- bowie knife99 (token: Qp9Fs3Jk7Hg6Dw2X)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 4, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 4, 6, NULL, '#Qp9Fs3Jk7Hg6Dw2X', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 4, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Goodwater (token: Ly5Gn1Bv8Tx4Rq9P)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 5, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 5, 6, NULL, '#Ly5Gn1Bv8Tx4Rq9P', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 5, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- no1d_the_bomj$s (token: Hc8Wm2Zr6Qj9Vk3D)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 6, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 6, 6, NULL, '#Hc8Wm2Zr6Qj9Vk3D', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 6, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Аллапульские Бревна (token: Ea4Tc7Xy1Nl5Bw8H)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 7, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 7, 6, NULL, '#Ea4Tc7Xy1Nl5Bw8H', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 7, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- 6 ДРАКОНОВ С ПРОПИТЫМИ МОЗГАМИ (token: Uf3Jk9Pq2Vm6Ls5R)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 8, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 8, 6, NULL, '#Uf3Jk9Pq2Vm6Ls5R', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 8, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Blasted bulls (token: Yx8Qn1Wc4Ts7Gj2B)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 9, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 9, 6, NULL, '#Yx8Qn1Wc4Ts7Gj2B', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 9, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Arasaka (token: Ds6Hg2Mv9Kx5Zr8N)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 10, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 10, 6, NULL, '#Ds6Hg2Mv9Kx5Zr8N', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 10, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Въеби ему, Донателло! (token: Wl7Tb4Yp1Hj6Vc3Q)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 11, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 11, 6, NULL, '#Wl7Tb4Yp1Hj6Vc3Q', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 11, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- RIP AND TEAR (token: Km9Rz2Xn5Bp8Dw4T)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 12, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 12, 6, NULL, '#Km9Rz2Xn5Bp8Dw4T', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 12, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- турник оффлайн (token: Pf5Js8Gq1Vk7Yc3L)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 13, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 13, 6, NULL, '#Pf5Js8Gq1Vk7Yc3L', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 13, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- старыйсычуань.рус (token: Cv2Xk6Nd9Wm4Hq1B)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 14, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 14, 6, NULL, '#Cv2Xk6Nd9Wm4Hq1B', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 14, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Vitaliki (token: Hq7Yb3Tr8Zl5Kp2J)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 15, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 15, 6, NULL, '#Hq7Yb3Tr8Zl5Kp2J', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 15, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Пузики на Москоу Лане! (token: Xw4Md1Vs9Tn6Rk7Q)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 16, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 16, 6, NULL, '#Xw4Md1Vs9Tn6Rk7Q', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 16, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Last Hope Team (token: Gj8Pq2Lf5Bc3Wx9D)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 17, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 17, 6, NULL, '#Gj8Pq2Lf5Bc3Wx9D', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 17, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Airshot Victims (token: Rv6Hc4Yw1Nk9Tj5X)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 18, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 18, 6, NULL, '#Rv6Hc4Yw1Nk9Tj5X', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 18, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Moscow Funkers (token: Zk3Bn7Vs2Qp8Mr9J)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 19, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 19, 6, NULL, '#Zk3Bn7Vs2Qp8Mr9J', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 19, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Air danger (token: Tn9Wq5Yr1Dc4Xk7L)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 20, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 20, 6, NULL, '#Tn9Wq5Yr1Dc4Xk7L', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 20, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- bLANt (token: Bp7Jm3Kx8Vs2Tz6Q)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 21, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 21, 6, NULL, '#Bp7Jm3Kx8Vs2Tz6Q', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 21, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- Blast from past (token: Yc1Rd6Hw4Nl9Fj5V)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 22, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 22, 6, NULL, '#Yc1Rd6Hw4Nl9Fj5V', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 22, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

-- T-team (token: Mw5Vs9Qj2Kp7Xn4G)
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 23, 5, NULL, 'all', 1, 0, 0, 910);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 23, 6, NULL, '#Mw5Vs9Qj2Kp7Xn4G', 1, 0, 782, 0);
INSERT INTO "acl" ("server_id", "channel_id", "priority", "user_id", "group_name", "apply_here", "apply_sub", "grantpriv", "revokepriv") VALUES (1, 23, 7, NULL, '#Zr4Pj8Xq2Wv9Tc6L', 1, 0, 910, 0);

COMMIT;
