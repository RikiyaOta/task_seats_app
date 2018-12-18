ALTER TABLE system_accounts DISABLE TRIGGER ALL;

INSERT INTO system_accounts
(
    id,
    name,
    email,
    password
)
VALUES
(
    '00000000-0000-0000-0000-000000000000',
    'default_system_account_1',
    'foobar1@hoge.com',
    'password'
);

ALTER TABLE system_accounts ENABLE TRIGGER ALL;
