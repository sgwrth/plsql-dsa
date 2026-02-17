-- Work in progress

CREATE OR REPLACE PACKAGE qsort
IS
	TYPE nums_t IS VARRAY(6) OF INTEGER;

	PROCEDURE print(nums nums_t);
	PROCEDURE swap(a IN OUT INTEGER, b IN OUT INTEGER);
	FUNCTION partition
	(
		nums		IN OUT	nums_t,
		lower_bound	IN	INTEGER,
		upper_bound	IN	INTEGER
	) RETURN INTEGER;
END;
/

CREATE OR REPLACE PACKAGE BODY qsort
IS
	PROCEDURE print(nums nums_t)
	IS
	BEGIN
		FOR i IN nums.FIRST..nums.LAST LOOP
			DBMS_OUTPUT.PUT(nums(i));
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


	FUNCTION partition
	(
		nums		IN OUT	nums_t,
		lower_bound	IN	INTEGER,
		upper_bound	IN	INTEGER
	) RETURN INTEGER
	IS
		pivot INTEGER;
		r_ptr INTEGER;
		l_ptr INTEGER;
	BEGIN
		pivot := upper_bound;
		r_ptr := upper_bound - 1;
		l_ptr := lower_bound;


		WHILE nums(r_ptr) >= nums(pivot) AND r_ptr > 1 LOOP
			r_ptr := r_ptr - 1;
		END LOOP;


		WHILE nums(l_ptr) <= nums(pivot) AND l_ptr < upper_bound LOOP
			l_ptr := l_ptr + 1;
		END LOOP;


		IF l_ptr < r_ptr THEN
			swap(nums(l_ptr), nums(r_ptr));
			swap(nums(pivot), nums(r_ptr));
			RETURN r_ptr;
		ELSE
			swap(nums(pivot), nums(l_ptr));
			RETURN l_ptr;
		END IF;
	END;
END;
/

DECLARE
	nums	qsort.nums_t := qsort.nums_t(3, 1, 7, 5, 9, 4);
	pivot	INTEGER;
	temp	INTEGER;
BEGIN
	qsort.print(nums);
	pivot := qsort.partition(nums, nums.FIRST, nums.LAST);
	qsort.print(nums);
	temp := qsort.partition(nums, nums.FIRST, pivot - 1);
	temp := qsort.partition(nums, pivot + 1, nums.LAST);
	qsort.print(nums);
END;
/
