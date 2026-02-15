CREATE OR REPLACE TYPE t_node
IS
OBJECT
(
	value	NUMBER,
	left	INTEGER,
	right	INTEGER
);
/

CREATE OR REPLACE TYPE node_table
IS
TABLE OF t_node;
/

CREATE OR REPLACE PACKAGE bst_pkg
IS
	FUNCTION init_tree RETURN node_table;
	PROCEDURE insert_node(tree IN OUT node_table, value IN NUMBER);
	PROCEDURE insert_left_or_right
	(
		side		IN	VARCHAR2,
		found_node	IN OUT	BOOLEAN,
		tree		IN OUT	node_table,
		current_node_id	IN	INTEGER,
		new_node	IN	t_node
	);
	PROCEDURE print_size(tree IN node_table);
END;
/

CREATE OR REPLACE PACKAGE BODY bst_pkg
IS
	FUNCTION init_tree RETURN node_table
	IS
		tree node_table;
	BEGIN
		tree := node_table();
		return tree;
	END;


	PROCEDURE insert_node(tree IN OUT node_table, value IN NUMBER)
	IS
		new_node	t_node;
		current_node_id	INTEGER;
		found_node	BOOLEAN := FALSE;
	BEGIN
		new_node := t_node(value, NULL, NULL);
		IF tree.COUNT = 0 THEN
			tree.EXTEND;
			tree(tree.LAST) := new_node;
		ELSE
			current_node_id := tree.FIRST;
			WHILE found_node = FALSE AND current_node_id IS NOT NULL LOOP
				IF value < tree(current_node_id).value THEN
					IF tree(current_node_id).left IS NULL THEN
						insert_left_or_right('l', found_node, tree,
								     current_node_id, new_node);
					ELSE
						current_node_id := tree(current_node_id).left;
					END IF;
				ELSIF value > tree(current_node_id).value THEN
					IF tree(current_node_id).right IS NULL THEN
						insert_left_or_right('r', found_node, tree,
								     current_node_id, new_node);
					ELSE
						current_node_id := tree(current_node_id).right;
					END IF;
				ELSE
					EXIT;
				END IF;
			END LOOP;
		END IF;
	END;


	PROCEDURE insert_left_or_right
	(
		side		IN	VARCHAR2,
		found_node	IN OUT	BOOLEAN,
		tree		IN OUT	node_table,
		current_node_id	IN	INTEGER,
		new_node	IN	t_node
	)
	IS
	BEGIN
		found_node := TRUE;
		tree.EXTEND;
		tree(tree.LAST) := new_node;
		IF side = 'l' THEN
			tree(current_node_id).left := tree.LAST;
		ELSIF side = 'r' THEN
			tree(current_node_id).right := tree.LAST;
		END IF;
	END;


	PROCEDURE print_size(tree IN node_table)
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('tree size: ' || tree.COUNT);
	END;
END;
/

DECLARE
	tree node_table;
BEGIN
	tree := bst_pkg.init_tree;
	bst_pkg.print_size(tree);
	bst_pkg.insert_node(tree, 42);
	bst_pkg.insert_node(tree, 404);
	bst_pkg.insert_node(tree, -42);
	bst_pkg.insert_node(tree, 0);
	bst_pkg.insert_node(tree, 42);
	bst_pkg.print_size(tree);
END;
/
