Комплексный умножитель
Задание:
Реализовать комплексный умножитель.Доступен всего один физический модуль умножения
целых чисел. Входные данные поступают каждые 3 такта, размерность 8 бит, знаковые
целые числа.

в качестве промежуточных значений используются data1..2
Размерность результата:
8бит + 8бит = 9 бит (0xff * 0xff = ox1fe)
9 бит * 8 бит = 17 бит (0x1fe * 0xff)
17 бит * 3 = 19 бит