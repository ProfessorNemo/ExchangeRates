# Funbox test task

###### Ruby: `3.0.3` Rails: `7.0.4` Yarn: `3.2.4` Nodejs: `12.22.9` Node: `17.1.0`

### About:

Applications for viewing the dollar to ruble exchange rate. With the ability to create your own exchange rate.

## App requirements:

Реализуйте web-приложение (Rails проект), которое удовлетворяет нижеизложенным требованиям.
* Приложение содержит две страницы: / и /admin
* На странице / отображается текущий курс доллара к рублю, известный
приложению.
* Приложение фоновым скриптом периодически обновляет курс из любого
выбранного вами доступного источника (сайт CBR, главная страница
http://www.rbc.ru, и т.д.).
* При обновлении курса в приложении он обновляется на всех открытых в
текущий момент страницах /.
* На странице /admin находится форма, содержащая поле для ввода числа,
поле для ввода даты-времени и сабмит.
* При сабмите введенное число делается форсированным курсом до введённого
времени, т.е. до этого времени реальный курс игнорируется, вместо него
страницах / отображается форсированный курс.
• Страница /admin «помнит» введенные предыдущий раз значения, они
отображаются уже введенными при загрузке страницы.
• При сабмите форсированного курса он, конечно же, cразу обновляется на всех
открытых страницах /. При истечении времени действия форсированного
курса на всех страницах начинает отображаться реальный курс.
* Форма содержит разумные валидации.
* Внешний вид приложения должен быть аккуратным в рамках разумного
(например, использовать Twitter Bootstrap).
* Плюсом будет использование какого-либо JS-фреймворка на клиентской
стороне.
* Web-приложение должно корректно работать в браузерах Firefox и Chrome
последних версий.
* Код должен быть покрыт тестами.
* Все необходимое для локального запуска приложения должно быть
оформлено в виде Procfile-а для Foreman.


### Installing

Clone repo ```git clone git@github.com:ProfessorNemo/ExchangeRates.git```

Install gems ```bundle```

The App can be installed with ```make initially``` command.

### Running

The App can be run with  ```bin/dev``` command.

## Running the tests

Tests can be run with ```make rspec``` command.


Open `localhost:3000` in browser
