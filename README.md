# NagminVX
Shinken/Nagios Configuration Administration Tool 
This is a first test to put the sourcecode on github

It's all incomplete at the moment.
Installation instructions will follow.

Description:

Originally Fred Reimers wrote a Webmin module Nagmin which I extended a bit (NagminV).
Nagmin and NagminV are getting old as Webmin modules.
If many objects had to be added I almost always did this with SQL commands.
I found this not very elegant and was unacceptable for other colleagues. With a larger amount of data the search is also in need of improvement. In addition, the dependent configurations are not always changed cleanly when objects are changed. 
Last but not least, the new Webmin version has a few minor bugs.


One goal was to be able to do as much customization as possible without having to touch the program code.  First I experimented with a noSQL DB, but then I saw no advantage over MySQL or MariaDB. So I decided to stay with this DB and to keep the old (partly not so nice) DB model. So a parallel operation of NagminV and NagminVX is possible.

The system is very database driven and requires a reasonably recent MySQL or MariaDB version. 
For example, the links to web pages and documentation as well as various actions as well as the filling of selection fields are defined in tables.

Advantages:

- Clearer
- more modern design 
- faster search over all or in one field
- faster input by duplication of entries
- more stable due to the use of DB triggers
- many program adjustments can be made in the database (in the program itself)


Installation:

you need : "codeigniter4/framework"

more documentation will follow ...

