ALTER TABLE categories DISABLE TRIGGER ALL;

INSERT INTO categories
(
    id,
    name,
    color,
    sheet_id,
    created_at,
    created_by,
    modified_at,
    modified_by
)
VALUES
(
    '00000000-0000-0000-0000-000000000001',
    'default_category_1',
    'red',
    '00000000-0000-0000-0000-000000000001',
    '2018-12-11 12:00:00',
    '00000000-0000-0000-0000-000000000000',
    '2018-12-11 12:00:00',
    '00000000-0000-0000-0000-000000000000'
);

ALTER TABLE categories ENABLE TRIGGER ALL;
