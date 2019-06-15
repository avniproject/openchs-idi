
hello:; @echo world

su:=$(shell id -un)

#{taskDefinitionsPerENV}

create_org:; psql -U$(su) -d openchs < create_organisation.sql
create_views:; psql -U$(su) -d openchs < create_views.sql
