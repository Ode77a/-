-- ============================================================
--  БД «НАУЧНО-ПРОИЗВОДСТВЕННОЕ ПРЕДПРИЯТИЕ»
--  Модуль 2 — PostgreSQL
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- 1. СОЗДАНИЕ ТАБЛИЦ
-- ────────────────────────────────────────────────────────────

-- Таблица: СОТРУДНИКИ
CREATE TABLE employees (
    employee_id   SERIAL        PRIMARY KEY,
    department_id INTEGER       NOT NULL,
    last_name     VARCHAR(60)   NOT NULL,
    first_name    VARCHAR(60)   NOT NULL,
    middle_name   VARCHAR(60),
    position      VARCHAR(100)  NOT NULL,
    salary        NUMERIC(10,2) NOT NULL CHECK (salary > 0),
    bonus         NUMERIC(10,2) DEFAULT 0,
    hire_month    DATE          NOT NULL
);

-- Таблица: ДОГОВОРЫ
CREATE TABLE contracts (
    contract_id   SERIAL        PRIMARY KEY,
    contract_no   VARCHAR(30)   NOT NULL UNIQUE,
    org_name      VARCHAR(200)  NOT NULL,
    sign_date     DATE          NOT NULL,
    employee_id   INTEGER       NOT NULL REFERENCES employees(employee_id)
);

-- Таблица: ОРГАНИЗАЦИИ
CREATE TABLE organizations (
    org_id        SERIAL        PRIMARY KEY,
    contract_id   INTEGER       NOT NULL REFERENCES contracts(contract_id),
    country_code  VARCHAR(10)   NOT NULL,
    city          VARCHAR(100)  NOT NULL,
    address       VARCHAR(200)  NOT NULL,
    phone         VARCHAR(30),
    email         VARCHAR(100),
    website       VARCHAR(150)
);

-- Таблица: ПОСТАВКИ
CREATE TABLE deliveries (
    delivery_id   SERIAL        PRIMARY KEY,
    contract_id   INTEGER       NOT NULL REFERENCES contracts(contract_id),
    org_id        INTEGER       NOT NULL REFERENCES organizations(org_id),
    equipment     VARCHAR(200)  NOT NULL,
    comment       TEXT,
    employee_id   INTEGER       NOT NULL REFERENCES employees(employee_id)
);


-- ────────────────────────────────────────────────────────────
-- 2. ТЕСТОВЫЕ ДАННЫЕ
-- ────────────────────────────────────────────────────────────

-- СОТРУДНИКИ (10 записей)
INSERT INTO employees (department_id, last_name, first_name, middle_name, position, salary, bonus, hire_month) VALUES
(1, 'Иванов',    'Алексей',   'Петрович',   'Разработчик ПО',        75000.00, 5000.00, '2021-03-01'),
(1, 'Петрова',   'Мария',     'Сергеевна',  'Ведущий разработчик',   95000.00, 8000.00, '2019-06-01'),
(2, 'Сидоров',   'Дмитрий',   'Иванович',   'Системный аналитик',    80000.00, 6000.00, '2020-01-01'),
(2, 'Козлова',   'Анна',      'Викторовна', 'Менеджер проектов',     85000.00, 7000.00, '2018-09-01'),
(3, 'Новиков',   'Сергей',    'Андреевич',  'Тестировщик ПО',        60000.00, 3000.00, '2022-04-01'),
(3, 'Морозова',  'Елена',     'Дмитриевна', 'Разработчик ПО',        72000.00, 4500.00, '2021-11-01'),
(1, 'Волков',    'Андрей',    'Николаевич', 'Архитектор ПО',        110000.00, 12000.00,'2017-02-01'),
(4, 'Соколова',  'Ирина',     'Павловна',   'Технический писатель',  55000.00, 2000.00, '2023-01-01'),
(4, 'Зайцев',    'Павел',     'Олегович',   'Системный администратор',65000.00, 3500.00, '2020-07-01'),
(2, 'Лебедева',  'Ольга',     'Александровна','Бизнес-аналитик',     88000.00, 7500.00, '2019-03-01');

-- ДОГОВОРЫ (8 записей)
INSERT INTO contracts (contract_no, org_name, sign_date, employee_id) VALUES
('ДГ-2023-001', 'ООО "ТехноСофт"',         '2023-01-15', 2),
('ДГ-2023-002', 'АО "ИнфоСистемы"',         '2023-03-20', 4),
('ДГ-2023-003', 'ЗАО "ДатаКорп"',           '2023-05-10', 7),
('ДГ-2023-004', 'ООО "СофтВэй"',            '2023-06-25', 1),
('ДГ-2024-001', 'ПАО "ГлобалТех"',          '2024-01-12', 2),
('ДГ-2024-002', 'ООО "МегаСофт"',           '2024-02-28', 4),
('ДГ-2024-003', 'АО "ПрогрессИТ"',          '2024-04-05', 7),
('ДГ-2024-004', 'ООО "СмартСистемс"',       '2024-06-18', 3);

-- ОРГАНИЗАЦИИ (8 записей)
INSERT INTO organizations (contract_id, country_code, city, address, phone, email, website) VALUES
(1, 'RU', 'Москва',          'ул. Ленина, 15',        '+7 495 123-45-67', 'info@technosoft.ru',    'www.technosoft.ru'),
(2, 'RU', 'Санкт-Петербург', 'пр. Невский, 88',       '+7 812 987-65-43', 'contact@infosys.ru',    NULL),
(3, 'MD', 'Кишинёв',         'бул. Штефан чел Маре, 2','+373 22 123456',   'info@datacorp.md',      'www.datacorp.md'),
(4, 'UA', 'Одесса',          'ул. Дерибасовская, 10', '+380 48 765-43-21','office@softway.ua',     NULL),
(5, 'RU', 'Казань',          'ул. Баумана, 54',        '+7 843 234-56-78', 'info@globaltech.ru',    'www.globaltech.ru'),
(6, 'RU', 'Новосибирск',     'ул. Советская, 33',     '+7 383 345-67-89', 'support@megasoft.ru',   'www.megasoft.ru'),
(7, 'BY', 'Минск',           'пр. Независимости, 77', '+375 17 456-78-90','info@progressit.by',    'www.progressit.by'),
(8, 'MD', 'Тирасполь',       'ул. 25 Октября, 100',   '+373 533 12345',   'smart@systems.md',      NULL);

-- ПОСТАВКИ (10 записей)
INSERT INTO deliveries (contract_id, org_id, equipment, comment, employee_id) VALUES
(1, 1, 'Система управления складом WMS 3.0',        'Установлено без замечаний',          1),
(1, 1, 'Модуль отчётности ReportPro',               NULL,                                  2),
(2, 2, 'CRM-система SalesForce Local',              'Требуется обучение персонала',        3),
(3, 3, 'ERP-система 1С:Предприятие 8.3',            'Поставлено с документацией',          7),
(4, 4, 'Антивирусное ПО Dr.Web Enterprise',         NULL,                                  1),
(5, 5, 'Система электронного документооборота',     'Заказчик доволен',                    4),
(6, 6, 'BI-система аналитики DataLens',             'Настройка заняла 3 дня',             6),
(7, 7, 'Система резервного копирования Veeam',      NULL,                                  7),
(8, 8, 'Комплекс защиты информации КЗИ-2',         'Поставлено в срок',                   9),
(5, 5, 'Модуль интеграции с 1С',                   'Доработка по требованию заказчика',   2);


-- ────────────────────────────────────────────────────────────
-- 3. ЗАПРОСЫ
-- ────────────────────────────────────────────────────────────

-- ── ЗАПРОС 1: Выборка ───────────────────────────────────────
-- Список всех поставок с данными о сотруднике и организации
SELECT
    d.delivery_id                              AS "№ поставки",
    d.equipment                                AS "Оборудование / ПО",
    c.contract_no                              AS "Номер договора",
    o.city                                     AS "Город",
    o.org_name AS "Организация",
    e.last_name || ' ' || LEFT(e.first_name,1) || '.' ||
        LEFT(COALESCE(e.middle_name,''),1) || '.' AS "Сотрудник",
    COALESCE(d.comment, '—')                   AS "Комментарий"
FROM deliveries d
JOIN contracts     c ON d.contract_id  = c.contract_id
JOIN organizations o ON d.org_id       = o.org_id
JOIN employees     e ON d.employee_id  = e.employee_id
ORDER BY d.delivery_id;


-- ── ЗАПРОС 2: Группировка ───────────────────────────────────
-- Количество поставок и договоров по каждому сотруднику
SELECT
    e.last_name || ' ' || e.first_name         AS "Сотрудник",
    e.position                                 AS "Должность",
    COUNT(DISTINCT c.contract_id)              AS "Кол-во договоров",
    COUNT(DISTINCT d.delivery_id)              AS "Кол-во поставок"
FROM employees e
LEFT JOIN contracts  c ON c.employee_id = e.employee_id
LEFT JOIN deliveries d ON d.employee_id = e.employee_id
GROUP BY e.employee_id, e.last_name, e.first_name, e.position
ORDER BY "Кол-во поставок" DESC;


-- ── ЗАПРОС 3: Агрегированный (сумма, среднее, максимум) ─────
-- Статистика зарплат по отделам с количеством сотрудников
SELECT
    department_id                              AS "Отдел",
    COUNT(*)                                   AS "Кол-во сотрудников",
    SUM(salary)                                AS "Фонд зарплаты, руб.",
    ROUND(AVG(salary), 2)                      AS "Средняя зарплата, руб.",
    MAX(salary)                                AS "Макс. зарплата, руб.",
    MIN(salary)                                AS "Мин. зарплата, руб.",
    SUM(bonus)                                 AS "Сумма премий, руб."
FROM employees
GROUP BY department_id
ORDER BY department_id;


-- ── ДОПОЛНИТЕЛЬНЫЕ ЗАПРОСЫ ───────────────────────────────────

-- Сотрудники с премией (премирование выше среднего)
SELECT
    last_name || ' ' || first_name             AS "Сотрудник",
    position                                   AS "Должность",
    salary                                     AS "Оклад",
    bonus                                      AS "Премия"
FROM employees
WHERE bonus > (SELECT AVG(bonus) FROM employees)
ORDER BY bonus DESC;

-- Договоры за 2024 год с наименованием организации и ФИО сотрудника
SELECT
    c.contract_no                              AS "Номер договора",
    c.org_name                                 AS "Организация",
    c.sign_date                                AS "Дата подписания",
    e.last_name || ' ' || e.first_name         AS "Заключил"
FROM contracts c
JOIN employees e ON c.employee_id = e.employee_id
WHERE EXTRACT(YEAR FROM c.sign_date) = 2024
ORDER BY c.sign_date;

-- Поставки в организации из Молдовы (код страны MD)
SELECT
    d.equipment                                AS "Программное обеспечение",
    o.city                                     AS "Город",
    o.address                                  AS "Адрес",
    c.contract_no                              AS "Договор"
FROM deliveries d
JOIN organizations o ON d.org_id      = o.org_id
JOIN contracts     c ON d.contract_id = c.contract_id
WHERE o.country_code = 'MD'
ORDER BY o.city;
