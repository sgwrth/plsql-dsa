-- Work in progress

CREATE OR REPLACE PACKAGE qsort
IS
	TYPE numbers_t IS VARRAY(6) OF INTEGER;

	PROCEDURE print(numbers numbers_t);
	PROCEDURE swap(a IN OUT INTEGER, b IN OUT INTEGER);
END;
/

CREATE OR REPLACE PACKAGE BODY qsort
IS
	PROCEDURE print(numbers numbers_t)
	IS
	BEGIN
		FOR i IN numbers.FIRST..numbers.LAST LOOP
			DBMS_OUTPUT.PUT(numbers(i));
		END LOOP;
		DBMS_OUTPUT.PUT_LINE('');
	END;
	

	PROCEDURE swap(a IN OUT INTEGER, b IN OUT INTEGER)
	IS
		temp INTEGER;
	BEGIN
		temp := a;
		a := b;
		b := temp;
	END;
END;
/

DECLARE
	numbers qsort.numbers_t := qsort.numbers_t(3, 1, 7, 5, 9, 4);
	pivot INTEGER;
	l_pointer INTEGER;
	r_pointer INTEGER;
BEGIN
	qsort.print(numbers);
	
	pivot := numbers.LAST;
	r_pointer := numbers.LAST - 1;
	l_pointer := numbers.FIRST;
	WHILE numbers(r_pointer) >= numbers(pivot) AND r_pointer >= 0 LOOP
		r_pointer := r_pointer - 1;
	END LOOP;
	WHILE numbers(l_pointer) <= numbers(pivot) AND l_pointer <= numbers.LAST LOOP
		l_pointer := l_pointer + 1;
	END LOOP;
	IF l_pointer < r_pointer THEN
		qsort.swap(numbers(l_pointer), numbers(r_pointer));
		qsort.swap(numbers(pivot), numbers(r_pointer));
	ELSE
		qsort.swap(numbers(pivot), numbers(l_pointer));
	END IF;
	qsort.print(numbers);
END;
/
