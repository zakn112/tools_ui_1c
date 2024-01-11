#Область ОписаниеПеременных

&НаКлиенте
Перем ЗакрытиеФормыПодтверждено;

&НаКлиенте
Перем УИ_РедакторКодаКлиентскиеДанные Экспорт;

&НаКлиенте
Перем УИ_ИдентификаторТекущейСтрокиАлгоритмов; //Число

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УИ_РедакторКодаСервер.ФормаПриСозданииНаСервере(ЭтотОбъект);

	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект,
													   "Код",
													   Элементы.ПолеАлгоритма,
													   ,
													   ,
													   Элементы.ГруппаПолеАлгоритмаКоманднаяПанель);


	УИ_ОбщегоНазначения.ФормаИнструментаПриСозданииНаСервере(ЭтотОбъект,
															 Отказ,
															 СтандартнаяОбработка,
															 Элементы.ОсновнаяКоманднаяПанель);

	НоваяСтрокаАлгоритма = Алгоритмы.ПолучитьЭлементы().Добавить();
	НоваяСтрокаАлгоритма.Имя = "Алгоритм";
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Если Не ЗакрытиеФормыПодтверждено Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ЗакрытиеФормыПодтверждено = Ложь;
	УИ_РедакторКодаКлиент.ФормаПриОткрытии(ЭтотОбъект, Новый ОписаниеОповещения("ПриОткрытииЗавершение",ЭтотОбъект));
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПолеРедактораДокументСформирован(Элемент)
	УИ_РедакторКодаКлиент.ПолеРедактораHTMLДокументСформирован(ЭтотОбъект, Элемент);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПолеРедактораПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	УИ_РедакторКодаКлиент.ПолеРедактораHTMLПриНажатии(ЭтотОбъект, Элемент, ДанныеСобытия, СтандартнаяОбработка);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыАлгоритмыПеременные

&НаКлиенте
Процедура АлгоритмыПеременныеПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	ДобавитьДополнительныйКонтекстВРедакторКода();
КонецПроцедуры

&НаКлиенте
Процедура АлгоритмыПеременныеПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	ТекДанные = Элементы.АлгоритмыПеременные.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Не УИ_ОбщегоНазначенияКлиентСервер.ИмяПеременнойКорректно(ТекДанные.Имя) Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура АлгоритмыПеременныеЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ТекДанные = Элементы.АлгоритмыПеременные.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		ВозвраТ;
	КонецЕсли;
	
	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияНачалоВыбораЗначения(ЭтотОбъект,
																										  Элемент,
																										  "Значение");
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.Значение = ТекДанные.Значение;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ТекДанные;
	ПараметрыОбработчика.НаборТипов = УИ_ОбщегоНазначенияКлиентСервер.ВсеНаборыТиповДляРедактирования();

	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикНачалоВыбораЗначения(ПараметрыОбработчика, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура АлгоритмыПеременныеЗначениеОчистка(Элемент, СтандартнаяОбработка)
	ТекДанные = Элементы.АлгоритмыПеременные.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияОчистка(ЭтотОбъект,
																							 Элемент,
																							 "Значение");
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ТекДанные;

	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикОчистка(ПараметрыОбработчика, СтандартнаяОбработка);

КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыАлгоритмы

&НаКлиенте
Процедура АлгоритмыПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	ТекДанные = Элементы.Алгоритмы.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Не УИ_ОбщегоНазначенияКлиентСервер.ИмяПеременнойКорректно(ТекДанные.Имя) Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура АлгоритмыПриАктивизацииСтроки(Элемент)
	СохранитьДанныеРедактораВТаблицуАлгоритмов();
	
	ТекДанные = Элементы.Алгоритмы.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	УИ_ИдентификаторТекущейСтрокиАлгоритмов = ТекДанные.ПолучитьИдентификатор();

	УИ_РедакторКодаКлиент.УстановитьТекстРедактора(ЭтотОбъект, "Код", ТекДанные.Текст);
	УИ_РедакторКодаКлиент.УстановитьОригинальныйТекстРедактора(ЭтотОбъект, "Код", ТекДанные.ОригинальныйТекст);
	УИ_РедакторКодаКлиент.УстановитьРежимИспользованияОбработкиДляВыполненияКодаРедактора(ЭтотОбъект,
																						  "Код",
																						  ТекДанные.ИспользоватьОбработкуДляВыполненияКода);

	ДобавитьДополнительныйКонтекстВРедакторКода();
КонецПроцедуры


&НаКлиенте
Процедура АлгоритмыПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	ТекДанные = Элементы.Алгоритмы.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		ВозвраТ;
	КонецЕсли;
	
	Если НоваяСтрока Тогда
		ТекДанные.Имя = "Алгоритм"+Формат(ТекДанные.ПолучитьИдентификатор(), "ЧГ=0;");
	КонецЕсли;
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура ЗакрытьКонсоль(Команда)
	ПоказатьВопрос(Новый ОписаниеОповещения("ЗакрытьКонсольЗавершение", ЭтаФорма), "Выйти из консоли кода?",
		РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКод(Команда)
	Если УИ_ИдентификаторТекущейСтрокиАлгоритмов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СохранитьДанныеРедактораВТаблицуАлгоритмов();
	
	СтрокаАлгоритма = Алгоритмы.НайтиПоИдентификатору(УИ_ИдентификаторТекущейСтрокиАлгоритмов);
	
	КлиентскиеРедакторы = Новый Массив;
	Если СтрокаАлгоритма.НаКлиенте Тогда
		КлиентскиеРедакторы.Добавить("Код");
	КонецЕсли;
	
	СтруктураИменПеременныхРедакторов = Новый Структура;
	
	МассивИмен = Новый Массив;
	Для Каждого Стр Из СтрокаАлгоритма.Переменные Цикл
		МассивИмен.Добавить(стр.Имя);
	КонецЦикла;
	МассивИмен.Добавить("СтруктураПередачи");
	СтруктураИменПеременныхРедакторов.Вставить("Код", МассивИмен);
	
	ПараметрыОповещения = Новый Структура;
	ПараметрыОповещения.Вставить("Начало", ТекущаяУниверсальнаяДатаВМиллисекундах());
	ПараметрыОповещения.Вставить("СтрокаАлгоритма", СтрокаАлгоритма);

	УИ_РедакторКодаКлиент.НачатьСборкуОбработокДляИсполненияКода(ЭтотОбъект,
																 Новый ОписаниеОповещения("ВыполнитьКодЗавершениеСборкиОбработок",
		ЭтотОбъект, ПараметрыОповещения),
																 СтруктураИменПеременныхРедакторов,
																 КлиентскиеРедакторы);

КонецПроцедуры

&НаКлиенте
Процедура РедактироватьЗначениеПеременной(Команда)
	ТекДанные=Элементы.АлгоритмыПеременные.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	УИ_ОбщегоНазначенияКлиент.РедактироватьОбъект(ТекДанные.Значение);
КонецПроцедуры


&НаКлиенте
Процедура НовыйАлгоритм(Команда)
	СтрокиАлгоритмов = Алгоритмы.ПолучитьЭлементы();
	СтрокиАлгоритмов.Очистить();
	
	НоваяСтрокаАлгоритма = СтрокиАлгоритмов.Добавить();
	НоваяСтрокаАлгоритма.Имя = "Алгоритм";
	
	ИмяФайлаАлгоритма="";

	УстановитьЗаголовок();
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайл(Команда)
	УИ_ОбщегоНазначенияКлиент.ПрочитатьДанныеКонсолиИзФайла("КонсольКода", СтруктураОписанияСохраняемогоФайла(),
		Новый ОписаниеОповещения("ОткрытьФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайл(Команда)
	СохранитьФайлНаДиск();
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлКак(Команда)
	СохранитьФайлНаДиск(Истина);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ВыполнитьОбщуюКомандуИнструментов(Команда) 
	УИ_ОбщегоНазначенияКлиент.Подключаемый_ВыполнитьОбщуюКомандуИнструментов(ЭтотОбъект, Команда);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуРедактораКода(Команда)
	УИ_РедакторКодаКлиент.ВыполнитьКомандуРедактораКода(ЭтотОбъект, Команда);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура СохранитьДанныеРедактораВТаблицуАлгоритмов()
	Если УИ_ИдентификаторТекущейСтрокиАлгоритмов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ТекДанные = Алгоритмы.НайтиПоИдентификатору(УИ_ИдентификаторТекущейСтрокиАлгоритмов);
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ТекДанные.Текст = УИ_РедакторКодаКлиент.ТекстКодаРедактора(ЭтотОбъект, "Код");
	ТекДанные.ИспользоватьОбработкуДляВыполненияКода = УИ_РедакторКодаКлиент.РежимИспользованияОбработкиДляВыполненияКодаРедактора(ЭтотОбъект,
																																   "Код");
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКодЗавершениеСборкиОбработок(Результат, ДополнительныеПараметры) Экспорт
		
	СтрокаАлгоритма = ДополнительныеПараметры.СтрокаАлгоритма;	
	Если Не ЗначениеЗаполнено(СокрЛП(СтрокаАлгоритма.Текст)) Тогда
		Возврат;
	КонецЕсли;

	Если СтрокаАлгоритма.НаКлиенте Тогда
		ВыполнитьКодНаКлиенте(СтрокаАлгоритма.ПолучитьИдентификатор());
	Иначе
		ВыполнитьКодНаСервере(СтрокаАлгоритма.ПолучитьИдентификатор());
	КонецЕсли;
	
КонецПроцедуры 

&НаКлиенте
Процедура ВыполнитьКодНаКлиенте(ИдентификаторСтрокиАлгоритмов)
	ВыполнитьКодАлгоритма(ЭтотОбъект, Алгоритмы, ИдентификаторСтрокиАлгоритмов);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКодНаСервере(ИдентификаторСтрокиАлгоритмов)
	ВыполнитьКодАлгоритма(ЭтотОбъект, Алгоритмы, ИдентификаторСтрокиАлгоритмов);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ВыполнитьКодАлгоритма(Форма, Алгоритмы, ИдентификаторСтрокиАлгоритмов)
	СтрокаАлгоритма = Алгоритмы.НайтиПоИдентификатору(ИдентификаторСтрокиАлгоритмов);
	
	КонтекстВыполнения = КонтекстВыполненияАлгоритма(СтрокаАлгоритма.Переменные);

	РезультатВыполнения = УИ_РедакторКодаКлиентСервер.ВыполнитьАлгоритм(СтрокаАлгоритма.Текст,
																		КонтекстВыполнения,
																		СтрокаАлгоритма.НаКлиенте,
																		Форма,
																		"Код");

	СтрокаАлгоритма.Инфо = Строка((РезультатВыполнения.ВремяВыполнения) / 1000) + " сек.";
	
КонецПроцедуры
 
&НаКлиенте
Функция ПеременныеКонтекста(ТЧПеременных)
	МассивПеременных=Новый Массив;
	Для Каждого ТекПеременная Из ТЧПеременных Цикл
		СтруктураПеременной=Новый Структура;
		СтруктураПеременной.Вставить("Имя", ТекПеременная.Имя);
		СтруктураПеременной.Вставить("Тип", ТипЗнч(ТекПеременная.Значение));

		МассивПеременных.Добавить(СтруктураПеременной);
	КонецЦикла;
	
	Возврат МассивПеременных;
КонецФункции


&НаКлиенте
Процедура ДобавитьДополнительныйКонтекстВРедакторКода()
	Если УИ_ИдентификаторТекущейСтрокиАлгоритмов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаАлгоритма = Алгоритмы.НайтиПоИдентификатору(УИ_ИдентификаторТекущейСтрокиАлгоритмов);
	
	СтруктураДополнительногоКонтекста = Новый Структура;

	ПеременныеКонтекста =ПеременныеКонтекста(СтрокаАлгоритма.Переменные); 
	Для Каждого Пер Из ПеременныеКонтекста Цикл
		Если Не УИ_ОбщегоНазначенияКлиентСервер.ИмяПеременнойКорректно(Пер.Имя) Тогда
			Продолжить;
		КонецЕсли;
		
		СтруктураДополнительногоКонтекста.Вставить(Пер.Имя, Пер.Тип);
	КонецЦикла;
	
	УИ_РедакторКодаКлиент.ДобавитьКонтекстРедактораКода(ЭтотОбъект, "Код", СтруктураДополнительногоКонтекста);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, ДополнительныеПараметры) Экспорт

КонецПроцедуры

&НаКлиенте
Функция СтруктураОписанияСохраняемогоФайла()
	Структура=УИ_ОбщегоНазначенияКлиент.ПустаяСтруктураОписанияВыбираемогоФайла();
	Структура.ИмяФайла=ИмяФайлаАлгоритма;

	УИ_ОбщегоНазначенияКлиент.ДобавитьФорматВОписаниеФайлаСохранения(Структура, "Файл алгоритма(*.xbsl)", "xbsl");
	Возврат Структура;
КонецФункции

&НаКлиенте
Процедура СохранитьФайлНаДиск(СохранитьКак = Ложь)
	СохранитьДанныеРедактораВТаблицуАлгоритмов();
	
	УИ_ОбщегоНазначенияКлиент.СохранитьДанныеКонсолиВФайл("КонсольКода", СохранитьКак,
		СтруктураОписанияСохраняемогоФайла(), ПолучитьСтрокуСохранения(),
		Новый ОписаниеОповещения("СохранитьФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлЗавершение(ИмяФайлаСохранения, ДополнительныеПараметры) Экспорт
	Если ИмяФайлаСохранения = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИмяФайлаСохранения) Тогда
		Возврат;
	КонецЕсли;

	Модифицированность=Ложь;
	ИмяФайлаАлгоритма=ИмяФайлаСохранения;
	УстановитьЗаголовок();
	
	УИ_РедакторКодаКлиент.УстановитьОригинальныйТекстРедактораРавнымТекущему(ЭтотОбъект, "Код");
	
//	Сообщить("Алгоритм успешно сохранен");

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайлЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Модифицированность = Ложь;
	ИмяФайлаАлгоритма = Результат.ИмяФайла;

	ОткрытьАлгоритмНаСервере(Результат.Адрес);

	УстановитьЗаголовок();
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьКонсольЗавершение(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = КодВозвратаДиалога.Да Тогда
		ЗакрытиеФормыПодтверждено = Истина;
		Закрыть();
	КонецЕсли;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция КонтекстВыполненияАлгоритма(Переменные)
	КонтекстВыполнения = Новый Структура;

	Для Каждого СтрокаТЧ Из Переменные Цикл
		СтруктураХраненияПоля = УИ_ОбщегоНазначенияКлиентСервер.НовыйСтруктураХраненияРеквизитаНаФормеСКонейнером("Значение");
		
		КонтекстВыполнения.Вставить(СтрокаТЧ.Имя,
									УИ_ОбщегоНазначенияКлиентСервер.ЗначениеПоляСКонтейнеромЗначения(СтрокаТЧ,
																									 СтруктураХраненияПоля));
	КонецЦикла;

	Возврат КонтекстВыполнения;
КонецФункции

&НаСервере
Функция ПолучитьСтрокуСохранения()

	СохраняемыеДанные = Новый Структура;
	СохраняемыеДанные.Вставить("ВерсияФормата", 2);
	СохраняемыеДанные.Вставить("Алгоритмы", Новый Массив);
	
	Для Каждого СтрокаАлгоритма Из Алгоритмы.ПолучитьЭлементы() Цикл
		СохраняемыеДанные.Алгоритмы.Добавить(ОписаниеАлгоритмаДляСохраненияВФайл(СтрокаАлгоритма));
	КонецЦикла;
	
	Возврат УИ_ОбщегоНазначенияКлиентСервер.мЗаписатьJSON(СохраняемыеДанные);

КонецФункции

&НаСервере
Функция ОписаниеАлгоритмаДляСохраненияВФайл(СтрокаАлгоритма)
	СтруктураХраненияЗначения = УИ_ОбщегоНазначенияКлиентСервер.НовыйСтруктураХраненияРеквизитаНаФормеСКонейнером("Значение");
	
	ОписаниеАлгоритма = Новый Структура;
	ОписаниеАлгоритма.Вставить("Имя", СтрокаАлгоритма.Имя);
	ОписаниеАлгоритма.Вставить("Текст", СтрокаАлгоритма.Текст);
	ОписаниеАлгоритма.Вставить("НаКлиенте", СтрокаАлгоритма.НаКлиенте);
	ОписаниеАлгоритма.Вставить("ИспользоватьОбработкуДляВыполненияКода",
							   СтрокаАлгоритма.ИспользоватьОбработкуДляВыполненияКода);
							   
	ОписаниеАлгоритма.Вставить("Переменные", Новый Массив);
	Для Каждого ТекПеременная Из СтрокаАлгоритма.Переменные Цикл
		СтруктураПеременной=Новый Структура;
		СтруктураПеременной.Вставить("Имя", ТекПеременная.Имя);
		
		ТекЗначениеПеременной = УИ_ОбщегоНазначенияКлиентСервер.ЗначениеПоляСКонтейнеромЗначения(ТекПеременная,
																								 СтруктураХраненияЗначения);

		СтруктураПеременной.Вставить("Значение", ЗначениеВСтрокуВнутр(ТекЗначениеПеременной));
		СтруктураПеременной.Вставить("Тип", ЗначениеВСтрокуВнутр(ТипЗнч(ТекЗначениеПеременной)));

		ОписаниеАлгоритма.Переменные.Добавить(СтруктураПеременной);
	КонецЦикла;
	
	ОписаниеАлгоритма.Вставить("Строки", Новый Массив);
	
	Для Каждого Стр Из СтрокаАлгоритма.ПолучитьЭлементы() Цикл
		ОписаниеАлгоритма.Строки.Добавить(ОписаниеАлгоритмаДляСохраненияВФайл(Стр));
	КонецЦикла;

	Возврат ОписаниеАлгоритма;
КонецФункции

&НаСервере
Процедура ОткрытьАлгоритмНаСервере(АдресФайлаВоВременномХранилище)
	ДанныеФайла=ПолучитьИзВременногоХранилища(АдресФайлаВоВременномХранилище);

	ЧтениеJSON=Новый ЧтениеJSON;
	ЧтениеJSON.ОткрытьПоток(ДанныеФайла.ОткрытьПотокДляЧтения());

	СтруктураФайла=ПрочитатьJSON(ЧтениеJSON);
	ЧтениеJSON.Закрыть();

	ВерсияФормата = 1;
	Если СтруктураФайла.Свойство("ВерсияФормата") Тогда
		ВерсияФормата = СтруктураФайла.ВерсияФормата;
	КонецЕсли;
	
	Алгоритмы.ПолучитьЭлементы().Очистить();
	
	Если ВерсияФормата = 1 Тогда
		ЗаполнитьФормуПоФорматуВерсии_1(СтруктураФайла);
	Иначе
		ЗаполнитьАлгоритмыПоФорматуВерсии_2(СтруктураФайла);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьФормуПоФорматуВерсии_1(СтруктураФайла)
	СтруктураХраненияЗначения = УИ_ОбщегоНазначенияКлиентСервер.НовыйСтруктураХраненияРеквизитаНаФормеСКонейнером("Значение");

	ЭлементыАлгоритмов =  Алгоритмы.ПолучитьЭлементы();
	
	Если ЗначениеЗаполнено(СтруктураФайла.ТекстАлгоритмаКлиент) Или СтруктураФайла.ПеременныеКлиент.Количество() > 0 Тогда
		НоваяСтрокаАлгоритма = ЭлементыАлгоритмов.Добавить();
		НоваяСтрокаАлгоритма.ОригинальныйТекст = СтруктураФайла.ТекстАлгоритмаКлиент;
		НоваяСтрокаАлгоритма.Текст = СтруктураФайла.ТекстАлгоритмаКлиент;
		НоваяСтрокаАлгоритма.НаКлиенте = Истина;
		НоваяСтрокаАлгоритма.Имя = "Клиент";

		Для Каждого Переменная Из СтруктураФайла.ПеременныеКлиент Цикл
			НС = НоваяСтрокаАлгоритма.Переменные.Добавить();
			НС.Имя=Переменная.Имя;
			
			УИ_ОбщегоНазначенияКлиентСервер.УстановитьЗначениеПоляСКонтейнером(НС,
																			   СтруктураХраненияЗначения,
																			   ЗначениеИзСтрокиВнутр(Переменная.Значение));
		КонецЦикла;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СтруктураФайла.ТекстАлгоритмаСервер) Или СтруктураФайла.ПеременныеСервер.Количество() > 0 Тогда
		НоваяСтрокаАлгоритма = ЭлементыАлгоритмов.Добавить();
		НоваяСтрокаАлгоритма.ОригинальныйТекст = СтруктураФайла.ТекстАлгоритмаСервер;
		НоваяСтрокаАлгоритма.Текст = СтруктураФайла.ТекстАлгоритмаСервер;
		НоваяСтрокаАлгоритма.НаКлиенте = Ложь;
		НоваяСтрокаАлгоритма.Имя = "Сервер";

		Для Каждого Переменная Из СтруктураФайла.ПеременныеСервер Цикл
			НС = НоваяСтрокаАлгоритма.Переменные.Добавить();
			НС.Имя=Переменная.Имя;

			УИ_ОбщегоНазначенияКлиентСервер.УстановитьЗначениеПоляСКонтейнером(НС,
																			   СтруктураХраненияЗначения,
																			   ЗначениеИзСтрокиВнутр(Переменная.Значение));
		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьАлгоритмыПоФорматуВерсии_2(СтруктураФайла)
	ЭлементыАлгоритмов =  Алгоритмы.ПолучитьЭлементы();
	
	Для Каждого ТекАлгоритм Из СтруктураФайла.Алгоритмы Цикл
		ЗаполнитьАлгоритмыИзФайла(ТекАлгоритм, ЭлементыАлгоритмов);	
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьАлгоритмыИзФайла(АлгоритмФайла, КоллекцияЭлементовАлгоритмов)
	СтруктураХраненияЗначения = УИ_ОбщегоНазначенияКлиентСервер.НовыйСтруктураХраненияРеквизитаНаФормеСКонейнером("Значение");
	
	НоваяСтрокаАлгоритмов = КоллекцияЭлементовАлгоритмов.Добавить();
	НоваяСтрокаАлгоритмов.Имя = АлгоритмФайла.Имя;
	НоваяСтрокаАлгоритмов.Текст = АлгоритмФайла.Текст;
	НоваяСтрокаАлгоритмов.ОригинальныйТекст = АлгоритмФайла.Текст;
	НоваяСтрокаАлгоритмов.НаКлиенте = АлгоритмФайла.НаКлиенте;
	НоваяСтрокаАлгоритмов.ИспользоватьОбработкуДляВыполненияКода = АлгоритмФайла.ИспользоватьОбработкуДляВыполненияКода;
	
	Для Каждого ТекПеременная Из АлгоритмФайла.Переменные Цикл
		НС = НоваяСтрокаАлгоритмов.Переменные.Добавить();
		НС.Имя = ТекПеременная.Имя;

		УИ_ОбщегоНазначенияКлиентСервер.УстановитьЗначениеПоляСКонтейнером(НС,
																		   СтруктураХраненияЗначения,
																		   ЗначениеИзСтрокиВнутр(ТекПеременная.Значение));
	КонецЦикла;	

	КоллекцияСтрок = НоваяСтрокаАлгоритмов.ПолучитьЭлементы();
	Для Каждого ПодчиненныйАлгоритм Из АлгоритмФайла.Строки Цикл
		ЗаполнитьАлгоритмыИзФайла(ПодчиненныйАлгоритм, КоллекцияСтрок)
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗаголовок()
	Заголовок=ИмяФайлаАлгоритма;
КонецПроцедуры


//@skip-warning
&НаКлиенте
Процедура Подключаемый_РедакторКодаОтложеннаяИнициализацияРедакторов()
	УИ_РедакторКодаКлиент.РедакторКодаОтложеннаяИнициализацияРедакторов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте 
Процедура Подключаемый_РедакторКодаЗавершениеИнициализации() Экспорт
	Если ЗначениеЗаполнено(ИмяФайлаАлгоритма) Тогда
		УИ_ОбщегоНазначенияКлиент.ПрочитатьДанныеКонсолиИзФайла("КонсольКода", СтруктураОписанияСохраняемогоФайла(),
			Новый ОписаниеОповещения("ОткрытьФайлЗавершение", ЭтотОбъект), Истина);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РедакторКодаОтложеннаяОбработкаСобытийРедактора() Экспорт
	УИ_РедакторКодаКлиент.ОтложеннаяОбработкаСобытийРедактора(ЭтотОбъект);
КонецПроцедуры






#КонецОбласти

