-- Work in progress


CREATE OR REPLACE PACKAGE twosum
IS
	TYPE t_nums IS TABLE OF INTEGER;
	TYPE t_indices IS TABLE OF INTEGER INDEX BY BINARY_INTEGER;

	FUNCTION has_twosum(p_nums IN OUT t_nums, p_sum IN INTEGER) RETURN BOOLEAN;


	PROCEDURE sort
	(
		p_nums	IN OUT	t_nums,
		p_begin	IN	INTEGER,
		p_end	IN	INTEGER
	);


	FUNCTION partition
	(
		p_nums	IN OUT	t_nums,
		p_begin	IN	INTEGER,
		p_end	IN	INTEGER
	) RETURN INTEGER;


	PROCEDURE swap
	(
		p_nums	IN OUT	t_nums,
		p_idx_a	IN	INTEGER,
		p_idx_b	IN	INTEGER
	);


	FUNCTION find_twosum_element
	(
		p_nums	IN OUT	t_nums,
		p_sum	IN	INTEGER
	) RETURN INTEGER;

	FUNCTION are_equal(p_nums_a IN t_nums, p_nums_b IN t_nums) RETURN BOOLEAN;


	FUNCTION find
	(
		p_nums	IN t_nums,
		p_begin	IN INTEGER,
		p_end	IN INTEGER,
		p_value	IN INTEGER
	) RETURN INTEGER;


	PROCEDURE print(nums IN t_nums);
END;
/

CREATE OR REPLACE PACKAGE BODY twosum
IS
	FUNCTION has_twosum(p_nums IN OUT t_nums, p_sum IN INTEGER) RETURN BOOLEAN
	IS
		v_twosum_element_index	INTEGER;
	BEGIN
		sort(p_nums, p_nums.FIRST, p_nums.LAST);		
		v_twosum_element_index := find_twosum_element(p_nums, p_sum);
		IF v_twosum_element_index <> NULL THEN
			RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;
	END;


	PROCEDURE sort
	(
		p_nums	IN OUT	t_nums,
		p_begin	IN	INTEGER,
		p_end	IN	INTEGER
	)
	IS
		v_pivot		INTEGER;
		v_left_end	INTEGER;
		v_right_begin	INTEGER;
	BEGIN
		IF p_begin IS NULL
		  OR p_end IS NULL THEN
			RETURN;
		END IF;

		IF p_begin < p_end THEN
			v_pivot := partition(p_nums, p_begin, p_end);

			v_left_end := p_nums.PRIOR(v_pivot);
			v_right_begin := p_nums.NEXT(v_pivot);

			IF v_left_end IS NOT NULL
			  AND p_begin < v_left_end THEN
				sort(p_nums, p_begin, v_left_end);
			END IF;

			IF v_right_begin IS NOT NULL
			  AND v_right_begin < p_end THEN
				sort(p_nums, v_right_begin, p_end);
			END IF;
		END IF;
	END;


	FUNCTION partition
	(
		p_nums	IN OUT	t_nums,
		p_begin	IN	INTEGER,
		p_end	IN	INTEGER
	) RETURN INTEGER
	IS
		v_left_ptr	INTEGER := p_begin;
		v_right_ptr	INTEGER := p_nums.PRIOR(p_end);
		v_pivot_val	INTEGER := p_nums(p_end);
	BEGIN
		IF v_right_ptr IS NULL THEN
			RETURN p_begin;
		END IF;
		
		WHILE v_left_ptr IS NOT NULL
		  AND v_right_ptr IS NOT NULL LOOP

			WHILE v_left_ptr IS NOT NULL
			  AND v_left_ptr <= v_right_ptr
			  AND p_nums(v_left_ptr) <= v_pivot_val LOOP
				v_left_ptr := p_nums.NEXT(v_left_ptr);
			END LOOP;

			WHILE v_right_ptr IS NOT NULL
			  AND v_left_ptr IS NOT NULL
			  AND v_left_ptr <= v_right_ptr
			  AND p_nums(v_right_ptr) >= v_pivot_val LOOP
				v_right_ptr := p_nums.PRIOR(v_right_ptr);
			END LOOP;

			EXIT WHEN v_left_ptr IS NULL
			  OR v_right_ptr IS NULL
			  OR v_left_ptr > v_right_ptr;

			swap(p_nums, v_left_ptr, v_right_ptr);
			v_left_ptr := p_nums.NEXT(v_left_ptr);
			v_right_ptr := p_nums.PRIOR(v_right_ptr);
		END LOOP;

		IF v_left_ptr IS NULL THEN
			RETURN p_end;
		ELSE
			swap(p_nums, p_end, v_left_ptr);
			RETURN v_left_ptr;
		END IF;
	END;


	PROCEDURE swap
	(
		p_nums	IN OUT	t_nums,
		p_idx_a	IN	INTEGER,
		p_idx_b	IN	INTEGER
	)
	IS
		temp INTEGER;
	BEGIN
		temp := p_nums(p_idx_a);
		p_nums(p_idx_a) := p_nums(p_idx_b);
		p_nums(p_idx_b) := temp;
	END;

	
	FUNCTION find_twosum_element
	(
		p_nums	IN OUT	t_nums,
		p_sum	IN	INTEGER
	) RETURN INTEGER
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('find twosum element');
	END;


	FUNCTION are_equal(p_nums_a IN t_nums, p_nums_b IN t_nums) RETURN BOOLEAN
	IS
		v_index_a INTEGER := p_nums_a.FIRST;
		v_index_b INTEGER := p_nums_b.FIRST;
	BEGIN
		IF p_nums_a.COUNT <> p_nums_b.COUNT THEN
			RETURN FALSE;
		END IF;

		WHILE v_index_a IS NOT NULL LOOP
			IF p_nums_a(v_index_a) <> p_nums_b(v_index_b) THEN
				RETURN FALSE;
			END IF;

			v_index_a := p_nums_a.NEXT(v_index_a);
			v_index_b := p_nums_b.NEXT(v_index_b);
		END LOOP;

		RETURN TRUE;
	END;

	
	FUNCTION find
	(
		p_nums	IN t_nums,
		p_begin	IN INTEGER,
		p_end	IN INTEGER,
		p_value	IN INTEGER
	) RETURN INTEGER
	IS
		v_indices	t_indices;
		v_nums_idx	INTEGER := p_nums.FIRST;
		v_indices_idx	INTEGER := 1;
		v_middle_idx	INTEGER;
		v_value_idx	INTEGER;
	BEGIN
		-- Empty table
		IF p_begin = p_end THEN
			RETURN NULL;
		END IF;


		-- MOVE THIS OUTSIDE OF RECURSION!
		-- Copy p_nums indices to v_indices table
		WHILE p_nums.EXISTS(v_nums_idx) LOOP
			v_indices(v_indices_idx) := v_nums_idx;
			v_nums_idx := p_nums.NEXT(v_nums_idx);
			v_indices_idx := v_indices_idx + 1;
		END LOOP;


		v_middle_idx := FLOOR(
			(
				(v_indices(v_indices.FIRST)
				+ v_indices(v_indices.LAST))
				/ 2
			)
		);


		-- Print v_indices values
		DECLARE
			i INTEGER := 1;
		BEGIN
			WHILE v_indices.EXISTS(i) LOOP
				DBMS_OUTPUT.PUT_LINE(i);
				i := i + 1;
			END LOOP;
		END;


		RETURN -1;
	END;


	PROCEDURE print(nums IN t_nums)
	IS
	BEGIN
		FOR i IN nums.FIRST..nums.LAST LOOP
			DBMS_OUTPUT.PUT(nums(i));
		END LOOP;
		DBMS_OUTPUT.PUT_LINE('');
	END;
END;
/

DECLARE
	nums	twosum.t_nums;
	nums_a	twosum.t_nums;
	nums_b	twosum.t_nums;
	temp	INTEGER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Two Sum');

	nums := twosum.t_nums(3, 6, 1, 2, 0, 7);
	twosum.print(nums);
	twosum.sort(nums, nums.FIRST, nums.LAST);
	twosum.print(nums);

	nums_a := twosum.t_nums(3, 6, 1, 2, 0, 7);
	nums_b := twosum.t_nums(3, 5, 1, 2, 0, 7);

	IF twosum.are_equal(nums_a, nums_b) THEN
		DBMS_OUTPUT.PUT_LINE('are equal');
	ELSE
		DBMS_OUTPUT.PUT_LINE('are not equal');
	END IF;

	temp := twosum.find(nums, nums.FIRST, nums.LAST, 1);
END;
/
