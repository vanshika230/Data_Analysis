1. A view is a database object that has no values. Its contents are based on the base table. It contains rows and columns
similar to the real table.
2. In MySQL, the View is a virtual table created by a query by joining one or more tables. It is operated similarly to the base
table but does not contain any data of its own.
3. e View and table have one main dierence that the views are denitions built on top of other tables (or views). If any
changes occur in the underlying table, the same changes reected in the View also.
4. CREATE VIEW view_name AS SELECT columns FROM tables [WHERE conditions];
5. ALTER VIEW view_name AS SELECT columns FROM table WHERE conditions;
6. DROP VIEW IF EXISTS view_name;
7. CREATE VIEW Trainer AS SELECT c.course_name, c.trainer, t.email FROM courses c, contact t WHERE c.id = t.id; (View
using Join clause).
NOTE: We can also import/export table schema from les (.csv or json).

![image](https://github.com/user-attachments/assets/17fe3cd0-77c8-4c3f-b0dd-4d4957bbce80)
