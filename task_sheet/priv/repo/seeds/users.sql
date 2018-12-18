ALTER TABLE users DISABLE TRIGGER ALL;

INSERT INTO users
(
    id,
    name,
    email,
    password,
    created_at,
    created_by
)
VALUES
(
    '00000000-0000-0000-0000-000000000001',
    'default_user_1',
    'foobar1@hoge.com',
    '$2b$12$xJelyjse7vvsrZmd7.L0SuVsREQEpIaTziOTNUnzrGg.lV5XgMzVK',
    '2018-12-11 12:00:00',
    '00000000-0000-0000-0000-000000000000'
);

ALTER TABLE users ENABLE TRIGGER ALL;
