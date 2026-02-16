-- Work in progress

DECLARE
	TYPE numbers_t IS VARRAY(6) OF INTEGER;
	numbers numbers_t := numbers_t(3, 1, 7, 5, 9, 4);
	pivot INTEGER;
	l_pointer INTEGER;
	r_pointer INTEGER;
BEGIN
	-- Print numbers
	FOR i IN numbers.FIRST..numbers.LAST LOOP
		DBMS_OUTPUT.PUT(numbers(i));
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('');
	
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
		DECLARE
			temp INTEGER;
		BEGIN
			-- Swap l/r numbers
			temp := numbers(l_pointer);
			numbers(l_pointer) := numbers(r_pointer);
			numbers(r_pointer) := temp;
			-- Swap pivot and r number
			temp := numbers(pivot);
			numbers(pivot) := numbers(r_pointer);
			numbers(r_pointer) := temp;
		END;
	ELSE
		DECLARE
			temp INTEGER;
		BEGIN
			-- Swap pivot and l number
			temp := numbers(pivot);
			numbers(pivot) := numbers(l_pointer);
			numbers(l_pointer) := temp;
		END;
	END IF;


	-- Print numbers
	FOR i IN numbers.FIRST..numbers.LAST LOOP
		DBMS_OUTPUT.PUT(numbers(i));
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('');
END;
/
