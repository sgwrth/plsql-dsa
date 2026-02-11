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

	v_index := g_head;

	WHILE g_nodes.EXISTS(v_index)
	LOOP
		DBMS_OUTPUT.PUT_LINE(g_nodes(v_index).value);
		v_index := g_nodes(v_index).next;
	END LOOP;

END;
/

