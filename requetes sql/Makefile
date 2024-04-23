.PHONY: sql
sql:
	bison -d sql.y
	flex sql.lex
	gcc sql.tab.c -o sql
	./sql