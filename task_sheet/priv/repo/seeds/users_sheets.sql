ALTER TABLE users_sheets DISABLE TRIGGER ALL;

INSERT INTO users_sheets
(
    user_id,
    sheet_id
)
VALUES
(
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000001'
);

ALTER TABLE users_sheets ENABLE TRIGGER ALL;