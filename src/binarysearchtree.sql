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
	PROCEDURE find_and_insert_node
	(
		side		IN	VARCHAR2,
		found_node	IN OUT	BOOLEAN,
		tree		IN OUT	node_table,
		crnt_nodeid	IN OUT	NUMBER,
		value		IN	NUMBER
	);
	PROCEDURE insert_left_or_right
	(
		side		IN	VARCHAR2,
		found_node	IN OUT	BOOLEAN,
		tree		IN OUT	node_table,
		crnt_nodeid	IN	INTEGER,
		value		IN	NUMBER
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
		crnt_nodeid	INTEGER;
		found_node	BOOLEAN := FALSE;
	BEGIN
		IF tree.COUNT = 0 THEN
			tree.EXTEND;
			tree(tree.LAST) := t_node(value, NULL, NULL);
			RETURN;
		END IF;
		crnt_nodeid := tree.FIRST;
		WHILE found_node = FALSE AND crnt_nodeid IS NOT NULL LOOP
			IF value < tree(crnt_nodeid).value THEN
				find_and_insert_node('l', found_node, tree,
						     crnt_nodeid, value);
			ELSIF value > tree(crnt_nodeid).value THEN
				find_and_insert_node('r', found_node, tree,
						     crnt_nodeid, value);
			ELSE
				RETURN;
			END IF;
		END LOOP;
	END;


	PROCEDURE find_and_insert_node
	(
		side		IN	VARCHAR2,
		found_node	IN OUT	BOOLEAN,
		tree		IN OUT	node_table,
		crnt_nodeid	IN OUT	NUMBER,
		value		IN	NUMBER
	)
	IS
	BEGIN
		IF tree(crnt_nodeid).left IS NULL THEN
			insert_left_or_right(side, found_node, tree,
					     crnt_nodeid, value);
		ELSE
			crnt_nodeid := tree(crnt_nodeid).left;
		END IF;
	END;
	

	PROCEDURE insert_left_or_right
	(
		side		IN	VARCHAR2,
		found_node	IN OUT	BOOLEAN,
		tree		IN OUT	node_table,
		crnt_nodeid	IN	INTEGER,
		value		IN	NUMBER
	)
	IS
	BEGIN
		found_node := TRUE;
		tree.EXTEND;
		tree(tree.LAST) := t_node(value, NULL, NULL);
		IF side = 'l' THEN
			tree(crnt_nodeid).left := tree.LAST;
		ELSIF side = 'r' THEN
			tree(crnt_nodeid).right := tree.LAST;
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
