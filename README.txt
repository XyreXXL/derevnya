ДЕРЕВНЯ ЗА 1 РУБЛЬ — версия для ПК

Запуск: откройте index.html (или "Запустить игру.bat") в Chrome / Edge / Firefox.
Папку cutscenes не удаляйте — там видеоролики.

Клавиши: Пробел — следующий день, Esc — пауза/меню,
Ctrl+S — сохранить, F11 — полный экран, F2 — админ-панель (только для аккаунта из ADMIN_IDS).
Сохранения хранятся в браузере. Облачные сохранения и таблица лидеров требуют интернет.

СВОЙ SUPABASE (облачные сохранения, аккаунты, таблица лидеров)
1. supabase.com → New project (бесплатно).
2. SQL Editor → вставьте содержимое supabase_setup.sql → Run.
3. Project Settings → API: скопируйте Project URL и anon/publishable key.
4. Откройте index.html в блокноте, найдите SUPABASE_URL и SUPABASE_ANON_KEY (около строки 1830) и вставьте значения в кавычки.
5. Authentication → Sign In / Providers → Email: при желании отключите "Confirm email".
Ключи уже вписаны. Не забудьте выполнить supabase_setup.sql в SQL Editor.
