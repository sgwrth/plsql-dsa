CREATE OR REPLACE PACKAGE linked_list
AS
	TYPE t_node
	IS
	RECORD (
		id PLS_INTEGER,
		value PLS_INTEGER,
		next PLS_INTEGER
	);

	TYPE t_storage
	IS
	TABLE OF t_node INDEX BY PLS_INTEGER;

	PROCEDURE print_list_values(nodes IN t_storage,
				    head IN PLS_INTEGER);
END;
/

CREATE OR REPLACE PACKAGE BODY linked_list
AS
	PROCEDURE print_list_values(nodes IN t_storage,
				    head IN PLS_INTEGER)
	IS
		v_index PLS_INTEGER;
	BEGIN
		v_index := head;

		WHILE nodes.EXISTS(v_index)
		LOOP
			DBMS_OUTPUT.PUT_LINE(nodes(v_index).value);
			v_index := nodes(v_index).next;
		END LOOP;
	END;
END;
/

DECLARE
	g_nodes linked_list.t_storage;
	g_head PLS_INTEGER := NULL;
	g_free PLS_INTEGER := 0;
	v_index PLS_INTEGER;
BEGIN
	FOR i IN 1..10
	LOOP
		g_free := g_free + 1;
		g_nodes(g_free).id := g_free;
		g_nodes(g_free).value := 100 + (i * 10);
		g_nodes(g_free).next := g_head;
		g_head := g_free;
		DBMS_OUTPUT.PUT_LINE('g_head: ' || g_head);
	END LOOP;

	DBMS_OUTPUT.PUT_LINE(g_nodes.COUNT);

	linked_list.print_list_values(g_nodes, g_head);
END;
/

