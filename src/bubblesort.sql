CREATE OR REPLACE TYPE t_number_list AS TABLE OF NUMBER;
/

CREATE OR REPLACE PACKAGE bubblesort_pkg
IS
	PROCEDURE print_values(numbers IN t_number_list);
	PROCEDURE sort(numbers IN OUT t_number_list);
END;
/

CREATE OR REPLACE PACKAGE BODY bubblesort_pkg
IS
	PROCEDURE print_values(numbers IN t_number_list)
	AS
	BEGIN
		FOR i IN 1..numbers.COUNT
		LOOP
			DBMS_OUTPUT.PUT_LINE(numbers(i));
		END LOOP;
	END;

	PROCEDURE sort(numbers IN OUT t_number_list)
	AS
		temp PLS_INTEGER;
	BEGIN
		FOR i IN 1..numbers.COUNT
		LOOP
			FOR j IN 1..(numbers.COUNT - 1)
			LOOP
				IF numbers(j) > numbers(j + 1)
				THEN
					temp := numbers(j);
					numbers(j) := numbers(j + 1);
					numbers(j + 1) := temp;
				END IF;
			END LOOP;
		END LOOP;
	END;
END;
/

DECLARE
	v_numbers t_number_list;
BEGIN
	SELECT DISTINCT salary BULK COLLECT INTO v_numbers FROM hr.employees;

	bubblesort_pkg.print_values(v_numbers);

	bubblesort_pkg.sort(v_numbers);

	bubblesort_pkg.print_values(v_numbers);
END;
/
