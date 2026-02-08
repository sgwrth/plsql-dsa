DECLARE
	TYPE type_va_numbers IS VARRAY(10) OF PLS_INTEGER;
	va_numbers type_va_numbers := TYPE_VA_NUMBERS(5, 2, 7, 0, 3, 4, 1, 9, 8, 6);
	v_temp PLS_INTEGER;
BEGIN
	FOR i IN 1..va_numbers.count
	LOOP
		FOR j IN 1..(va_numbers.count - 1)
		LOOP
			IF va_numbers(j) > va_numbers(j + 1)
			THEN
				v_temp := va_numbers(j);
				va_numbers(j) := va_numbers(j + 1);
				va_numbers(j + 1) := v_temp;
			END IF;
		END LOOP;
	END LOOP;

	FOR i IN 1..va_numbers.count
	LOOP
		dbms_output.put_line(va_numbers(i));
	END LOOP;

END;
/
