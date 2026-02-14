CREATE OR REPLACE TYPE t_node
IS
OBJECT
(
	key		NUMBER,
	value		NUMBER,
	left_node	NUMBER,
	right_node	NUMBER
);
/

CREATE OR REPLACE TYPE node_table
IS
TABLE OF t_node;
/

CREATE OR REPLACE PACKAGE binary_tree_search_pkg
IS
	FUNCTION init_tree RETURN node_table;
	PROCEDURE insert_node;
END;
/

CREATE OR REPLACE PACKAGE BODY binary_tree_search_pkg
IS
	FUNCTION init_tree RETURN node_table
	IS
		tree node_table;
	BEGIN
		tree := node_table();
		return tree;
	END;

	PROCEDURE insert_node
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('inserting');
	END;
END;
/

DECLARE
	tree node_table;
BEGIN
	tree := binary_tree_search_pkg.init_tree;
	DBMS_OUTPUT.PUT_LINE('tree size: ' || tree.COUNT);
	binary_tree_search_pkg.insert_node;
END;
/
