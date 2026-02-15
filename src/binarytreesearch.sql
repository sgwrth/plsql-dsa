CREATE OR REPLACE TYPE t_node
IS
OBJECT
(
	id		NUMBER,
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
	PROCEDURE insert_node(tree IN OUT node_table, value IN NUMBER);
	PROCEDURE print_size(tree IN node_table);
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


	PROCEDURE insert_node(tree IN OUT node_table, value IN NUMBER)
	IS
		new_node t_node;
		target_node_id NUMBER;
		found_node BOOLEAN := FALSE;
		node_inserted BOOLEAN := FALSE;
		counter PLS_INTEGER := 0;
	BEGIN
		new_node := t_node(tree.COUNT + 1, value, NULL, NULL);
		IF tree.COUNT = 0 THEN
			tree.EXTEND;
			tree(tree.LAST) := new_node;
			DBMS_OUTPUT.PUT_LINE('inserted as root node');
		ELSE
			target_node_id := tree.FIRST;
			WHILE found_node = FALSE AND target_node_id IS NOT NULL LOOP
				IF value < tree(target_node_id).value THEN
					IF tree(target_node_id).left_node IS NULL THEN
						found_node := TRUE;
						tree.EXTEND;
						tree(tree.LAST) := new_node;
						tree(target_node_id).left_node := new_node.id;
						node_inserted := TRUE;
					ELSE
						target_node_id := tree(target_node_id).left_node;
					END IF;
				ELSIF value > tree(target_node_id).value THEN
					IF tree(target_node_id).right_node IS NULL THEN
						found_node := TRUE;
						tree.EXTEND;
						tree(tree.LAST) := new_node;
						tree(target_node_id).right_node := new_node.id;
						node_inserted := TRUE;
					ELSE
						target_node_id := tree(target_node_id).right_node;
					END IF;
				ELSE
					EXIT;
				END IF;
			END LOOP;
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
	tree := binary_tree_search_pkg.init_tree;
	binary_tree_search_pkg.print_size(tree);
	binary_tree_search_pkg.insert_node(tree, 42);
	binary_tree_search_pkg.insert_node(tree, 404);
	binary_tree_search_pkg.print_size(tree);
END;
/
