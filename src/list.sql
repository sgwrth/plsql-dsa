DECLARE
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


	g_nodes t_storage;
	g_head PLS_INTEGER := NULL;
	g_free PLS_INTEGER := 0;
BEGIN
	DBMS_OUTPUT.PUT_LINE('hello world');

	FOR i IN 1..10
	LOOP
		g_free := g_free + i;
		g_nodes(g_free).id := g_free;
		g_nodes(g_free).value := 100 + (i * 10);
		g_nodes(g_free).next := g_free;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE(g_nodes.COUNT);

END;
/

