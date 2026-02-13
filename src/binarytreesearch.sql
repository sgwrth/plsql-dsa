CREATE OR REPLACE PACKAGE binary_tree_search_pkg
IS
	PROCEDURE insert_node;
END;
/

CREATE OR REPLACE PACKAGE BODY binary_tree_search_pkg
IS
	PROCEDURE insert_node
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('inserting');
	END;
END;
/

DECLARE
BEGIN
	binary_tree_search_pkg.insert_node();
END;
/
