ALTER TABLE tasks DISABLE TRIGGER ALL;

INSERT INTO tasks
(
    id,
    title,
    content,
    category_id,
    sheet_id,
    created_at,
    created_by,
    modified_at,
    modified_by,
    importance,
    urgency
)
VALUES
(
    '00000000-0000-0000-0000-000000000001',
    'default_task_1',
    'This is a default task 1.',
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000001',
    '2018-12-11 12:00:00',
    '00000000-0000-0000-0000-000000000000',
    '2018-12-11 12:00:00',
    '00000000-0000-0000-0000-000000000000',
    0,
    0
);

ALTER TABLE tasks ENABLE TRIGGER ALL;
