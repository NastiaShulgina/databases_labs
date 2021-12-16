# Лабораторна робота 7
ЗБЕРЕЖУВАНІ ПРОЦЕДУРИ / КОРИСТУВАЦЬКІ ФУНКЦІЇ / ТРИГЕРИ
1. Забезпечити параметризовану вставку нових значень у таблицю Сімейні супутники.
2. Створити пакет, який вставляє 10 стрічок в таблицю Статі у форматі < Noname+№> , наприклад: Noname5, Noname6, Noname7 і т.д.
3. Використовуючи курсор, забезпечити динамічне створення БД з іменами Сімейні супутники, з випадковою кількістю таблиць для кожної БД (від 1 до 9). Структура таблиць довільна. Імена таблиць відповідають імені Сімейні супутники з порядковим номером від 1 до 9.
1. Для таблиці Сімейні супутники написати функцію як буде шукати MIN стовпця Дата народження . Потім зробити вибірку даних (SELECT), використовуючи дану функцію.
2. Написати функцію, яка витягує за ключем між таблицями Фамільне дерево та Сімейні супутники об’єднане значення полів Прізвище та Дата народження . Потім зробити вибірку усіх даних (SELECT) з таблиці Сімейні супутники, використовуючи дану функцію. 
1. Забезпечити цілісність значень для структури БД.
2. Сімейні супутники →Прізвище не може починатися на букву 'A' та закінчуватися на 'ін' чи 'іна' ; 
3. для Фамільні цінності→Код у каталозі цінностей забезпечити формат:  1 довільна буква, окрім F  + 3 цифри + '/' + 2 довільні букви.
4. Створити таблицю-журнал, в якій вести логи зі штампом часу при модифікації даних для таблиці Фамільні цінності.