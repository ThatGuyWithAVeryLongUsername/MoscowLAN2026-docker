PRAGMA foreign_keys = ON;

BEGIN;

UPDATE "channels" SET "name" = 'Root' WHERE "server_id" = 1 AND "channel_id" = 0;

INSERT OR IGNORE INTO "channels" ("server_id", "channel_id", "parent_id", "name", "inheritacl") VALUES
    (1, 1,  0, 'admin',                  1),
    (1, 2,  0, 'первый вагончик',        1),
    (1, 3,  0, 'SNUS HAPPENS',           1),
    (1, 4,  0, 'bowie knife99',          1),
    (1, 5,  0, 'Goodwater',              1),
    (1, 6,  0, 'no1d_the_bomj$s',        1),
    (1, 7,  0, 'Аллапульские Бревна',    1),
    (1, 8,  0, '6 ДРАКОНОВ С ПРОПИТЫМИ МОЗГАМИ', 1),
    (1, 9,  0, 'Blasted bulls',          1),
    (1, 10, 0, 'Arasaka',                1),
    (1, 11, 0, 'Въеби ему, Донателло!',  1),
    (1, 12, 0, 'RIP AND TEAR',           1),
    (1, 13, 0, 'турник оффлайн',         1),
    (1, 14, 0, 'старыйсычуань.рус',      1),
    (1, 15, 0, 'Vitaliki',               1),
    (1, 16, 0, 'Пузики на Москоу Лане!', 1),
    (1, 17, 0, 'Last Hope Team',         1),
    (1, 18, 0, 'Airshot Victims',        1),
    (1, 19, 0, 'Moscow Funkers',         1),
    (1, 20, 0, 'Air danger',             1),
    (1, 21, 0, 'bLANt',                  1),
    (1, 22, 0, 'Blast from past',        1),
    (1, 23, 0, 'T-team',                 1);

COMMIT;
