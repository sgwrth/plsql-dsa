CREATE OR REPLACE TYPE t_number_list AS TABLE OF NUMBER;
/
CREATE OR REPLACE PACKAGE bubblesort
IS
	PROCEDURE print_values(numbers IN t_number_list);
END;
/

CREATE OR REPLACE PACKAGE BODY bubblesort
IS
	PROCEDURE print_values(numbers IN t_number_list)
	AS
	BEGIN
		FOR i IN 1..numbers.COUNT
		LOOP
			dbms_output.put_line(numbers(i));
		END LOOP;
	END;
END;
/

DECLARE
	v_numbers t_number_list;
	v_temp PLS_INTEGER;
BEGIN
	SELECT DISTINCT salary BULK COLLECT INTO v_numbers FROM hr.employees;

	bubblesort.print_values(v_numbers);

	FOR i IN 1..v_numbers.COUNT
	LOOP
		FOR j IN 1..(v_numbers.COUNT - 1)
		LOOP
			IF v_numbers(j) > v_numbers(j + 1)
			THEN
				v_temp := v_numbers(j);
				v_numbers(j) := v_numbers(j + 1);
				v_numbers(j + 1) := v_temp;
			END IF;
		END LOOP;
	END LOOP;

	bubblesort.print_values(v_numbers);
END;
/
