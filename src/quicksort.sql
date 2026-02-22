CREATE OR REPLACE PACKAGE qsort
IS
	TYPE nums_t IS VARRAY(8) OF INTEGER;

	PROCEDURE print(nums nums_t);
	PROCEDURE swap(a IN OUT INTEGER, b IN OUT INTEGER);

	PROCEDURE quicksort
	(
		nums		IN OUT	nums_t,
		lower_bound	IN	INTEGER,
		upper_bound	IN	INTEGER
	);

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


	PROCEDURE quicksort
	(
		nums		IN OUT	nums_t,
		lower_bound	IN	INTEGER,
		upper_bound	IN	INTEGER
	)
	IS
		pivot INTEGER;
	BEGIN
		IF lower_bound < upper_bound THEN
			pivot := partition(nums, lower_bound, upper_bound);
			quicksort(nums, lower_bound, pivot - 1);
			quicksort(nums, pivot + 1, upper_bound);
		END IF;
	END quicksort;


	FUNCTION partition
	(
		nums		IN OUT	nums_t,
		lower_bound	IN	INTEGER,
		upper_bound	IN	INTEGER
	) RETURN INTEGER
	IS
		l_ptr INTEGER := lower_bound;
		r_ptr INTEGER := upper_bound;
		pivot INTEGER := nums(lower_bound);
	BEGIN
		WHILE l_ptr < r_ptr LOOP
			WHILE nums(l_ptr) <= pivot LOOP
				l_ptr := l_ptr + 1;
			END LOOP;


			WHILE nums(r_ptr) > pivot LOOP
				r_ptr := r_ptr - 1;
			END LOOP;


			IF l_ptr < r_ptr THEN
				swap(nums(l_ptr), nums(r_ptr));
			END IF;
		END LOOP;
		swap(nums(lower_bound), nums(r_ptr));
		RETURN r_ptr;
	END partition;
END;
/

DECLARE
	nums	qsort.nums_t := qsort.nums_t(3, 6, 1, 7, 5, 2, 9, 4);
BEGIN
	qsort.print(nums);
	qsort.quicksort(nums, nums.FIRST, nums.LAST);
	qsort.print(nums);

	nums := qsort.nums_t(0, 0, 0, 0, 0, 0, 0, 0);
	qsort.print(nums);
	qsort.quicksort(nums, nums.FIRST, nums.LAST);
	qsort.print(nums);

	nums := qsort.nums_t(1, 2, 3, 4, 5, 6, 7, 8);
	qsort.print(nums);
	qsort.quicksort(nums, nums.FIRST, nums.LAST);
	qsort.print(nums);

	nums := qsort.nums_t(8, 7, 6, 5, 4, 3, 2, 1);
	qsort.print(nums);
	qsort.quicksort(nums, nums.FIRST, nums.LAST);
	qsort.print(nums);
END;
/
