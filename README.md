Библиотека для работы с полиномами на perl
==========================================

Данная библиотека написана мной для исследования поляризованных полиномов.
**Поддерживаются только полиномы от одной переменной**. Основные возможности
это:
* Для полиномов — класс Polynomial
  - Создание поляризованных полиномов в поле по простому модулю.
  - Изменение поляризации полинома.
  - Сложение полиномов и умножение на число.
  - Вывод полиномов в удобном виде (для вставки в tex или csv файл).
* Для систем полиномов — класс AOP
  - Создание систем поляризованных полиномов в поле по простому модулю.
  - Проверка системы на сложность.
  - Вывод систем полиномов в виде tex или csv файла.

### Установка и тестирование ###
Для установки требутся perl версии не ниже `5.14`, тестировалась программа на
perl версии `5.22` и `5.24`. Также для работы требуются следующие модули perl:
- `Data::Printer`
- `Math::Prime::Util`
- `Moose`

Для установки этих модулей можно использовать команду `cpanm`, которую на
Linux обычно можно установить скачав пакет `cpanminus`. Далее нужно просто
ввести:
```
cpanm Data::Printer
cpanm Math::Prime::Util
cpanm Moose
```

Затем для установки и тестирования выполните следующие команды:
```
git clone https://github.com/Obirvalger/SymbolicPolynomial.git
cd SymbolicPolynomial
prove -l
```

### Структура и использование ###
Класс полиномов описан в файле `lib/Polynomial.pm`, а систем полиномов в файле
`lib/AOP.pm`. В каталоге `t/` содержатся тесты. Примеры использования можно
найти в файлах `polynomial_example.pl` и `aop_example.pl` для полиномов и
систем полиномов соответственно.
