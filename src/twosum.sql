-- Work in progress


CREATE OR REPLACE PACKAGE twosum
IS
	TYPE t_nums IS TABLE OF INTEGER;

	FUNCTION has_two_sum(p_nums IN t_nums, p_sum IN INTEGER) RETURN BOOLEAN;

	PROCEDURE sort
	(
		p_nums	IN t_nums,
		p_begin	IN INTEGER,
		p_end	IN INTEGER
	);

	PROCEDURE partition
	(
		p_nums	IN t_nums,
		p_begin	IN INTEGER,
		p_end	IN INTEGER
	);

	PROCEDURE swap
	(
		p_nums	IN OUT t_nums,
		p_val_a	IN INTEGER,
		p_val_b	IN INTEGER
	);

	FUNCTION find_twosum_element
	(
		p_nums	IN t_nums,
		p_sum	IN INTEGER
	) RETURN INTEGER;

	FUNCTION are_equal(p_nums_a IN t_nums, p_nums_b IN t_nums) RETURN BOOLEAN;

	FUNCTION find
	(
		p_nums	IN t_nums,
		p_begin	IN INTEGER,
		p_end	IN INTEGER,
		p_value	IN INTEGER
	) RETURN INTEGER;
END;
/

CREATE OR REPLACE PACKAGE BODY twosum
IS
	FUNCTION has_two_sum(p_nums IN t_nums, p_sum IN INTEGER) RETURN BOOLEAN
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('has two sum');
	END;


	PROCEDURE sort
	(
		p_nums	IN t_nums,
		p_begin	IN INTEGER,
		p_end	IN INTEGER
	)
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('sort');
	END;


	PROCEDURE partition
	(
		p_nums	IN t_nums,
		p_begin	IN INTEGER,
		p_end	IN INTEGER
	)
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('partition');
	END;

	
	PROCEDURE swap
	(
		p_nums	IN OUT t_nums,
		p_val_a	IN INTEGER,
		p_val_b	IN INTEGER
	)
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('swap');
	END;


	FUNCTION find_twosum_element
	(
		p_nums	IN t_nums,
		p_sum	IN INTEGER
	) RETURN INTEGER
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('find twosum element');
	END;


	FUNCTION are_equal(p_nums_a IN t_nums, p_nums_b IN t_nums) RETURN BOOLEAN
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('are equal');
	END;

	
	FUNCTION find
	(
		p_nums	IN t_nums,
		p_begin	IN INTEGER,
		p_end	IN INTEGER,
		p_value	IN INTEGER
	) RETURN INTEGER
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('find');
	END;
END;
/

DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Two Sum');
END;
/
