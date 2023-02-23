# ExchangeRates

###### Ruby: `3.2.1` Rails: `7.0.4` Yarn: `3.2.4` Nodejs: `12.22.9` Node: `17.1.0`
![Снимок экрана от 2022-11-16 00-52-17](https://user-images.githubusercontent.com/102049907/202033542-8e36d0c8-1435-45e2-b042-f07dfb58b66a.png)
![Снимок экрана от 2022-11-16 00-55-50](https://user-images.githubusercontent.com/102049907/202033549-3702f3bd-4cbd-40b7-aa74-e8c249ddc746.png)


### About:

Applications for viewing the dollar to ruble exchange rate. With the ability to create your own exchange rate.

### App requirements:

Web-приложение на RoR, которое удовлетворяет нижеизложенным требованиям.
* Приложение содержит две страницы: /user и /admin
* На странице /user отображается текущий курс доллара к рублю, известный
приложению.
* Приложение фоновым скриптом периодически обновляет курс из любого
выбранного вами доступного источника (сайт CBR, главная страница
http://www.rbc.ru, и т.д.).
* При обновлении курса в приложении он обновляется на всех открытых в
текущий момент страницах /user.
* На странице /admin находится форма, содержащая поле для ввода числа,
поле для ввода даты-времени и сабмит.
* При сабмите введенное число делается форсированным курсом до введённого
времени, т.е. до этого времени реальный курс игнорируется, вместо него
страницах /user отображается форсированный курс.
• Страница /admin «помнит» введенные предыдущий раз значения, они
отображаются уже введенными при загрузке страницы.
• При сабмите форсированного курса он, конечно же, cразу обновляется на всех
открытых страницах /user. При истечении времени действия форсированного
курса на всех страницах начинает отображаться реальный курс.
* Код покрыт тестами.

### Installing:

Clone repo ```git clone git@github.com:ProfessorNemo/ExchangeRates.git```

Install gems ```bundle```

The App can be installed with ```make initially``` command.

### Running:

The App can be run with  ```bin/dev``` command.

### Running the tests:

Tests can be run with ```make rspec``` command.

### Start:

Open `localhost:3000` in browser
