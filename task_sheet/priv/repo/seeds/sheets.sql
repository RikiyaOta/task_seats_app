ALTER TABLE sheets DISABLE TRIGGER ALL;

INSERT INTO sheets
(
    id,
    name,
    created_at,
    created_by,
    modified_at,
    modified_by
)
VALUES
(
    '00000000-0000-0000-0000-000000000001',
    'default_sheets1',
    '2018-12-11 12:00:00',
    '00000000-0000-0000-0000-000000000000',
    '2018-12-11 12:00:00',
    '00000000-0000-0000-0000-000000000000'
);

ALTER TABLE sheets ENABLE TRIGGER ALL;
