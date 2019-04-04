
hello:
	@echo world

_env:=
file:=

_dev:; $(eval _env:=dev)
_uat:; $(eval _env:=uat)
_staging:; $(eval _env:=staging)
_prod:; $(eval _env:=prod)

_grunt = grunt deploy:$(1) --target=$(_env) $(if $(file),--only-file=$(file))

_all:; $(call _grunt,all)
_adminUsers:; $(call _grunt,adminUsers)
_locations:; $(call _grunt,locations)
_catchments:; $(call _grunt,catchments)
_users:; $(call _grunt,users)
_concepts:; $(call _grunt,concepts)
_encounterTypes:; $(call _grunt,encounterTypes)
_programs:; $(call _grunt,programs)
_operationalEncounterTypes:; $(call _grunt,operationalEncounterTypes)
_operationalPrograms:; $(call _grunt,operationalPrograms)
_operationalSubjectTypes:; $(call _grunt,operationalSubjectTypes)
_forms:; $(call _grunt,forms)
_formDeletions:; $(call _grunt,formDeletions)
_formAdditions:; $(call _grunt,formAdditions)
_formMappings:; $(call _grunt,formMappings)
_checklistDetails:; $(call _grunt,checklistDetails)
_rules:; $(call _grunt,rules)

deploy-dev-all: create_org _dev _all
deploy-dev-adminUsers: _dev _adminUsers
deploy-dev-locations: _dev _locations
deploy-dev-catchments: _dev _catchments
deploy-dev-users: _dev _users
deploy-dev-concepts: _dev _concepts
deploy-dev-encounterTypes: _dev _encounterTypes
deploy-dev-programs: _dev _programs
deploy-dev-operationalEncounterTypes: _dev _operationalEncounterTypes
deploy-dev-operationalPrograms: _dev _operationalPrograms
deploy-dev-operationalSubjectTypes: _dev _operationalSubjectTypes
deploy-dev-forms: _dev _forms
deploy-dev-formDeletions: _dev _formDeletions
deploy-dev-formAdditions: _dev _formAdditions
deploy-dev-formMappings: _dev _formMappings
deploy-dev-checklistDetails: _dev _checklistDetails
deploy-dev-rules: _dev _rules

deploy-staging-all: _staging _all
deploy-staging-adminUsers: _staging _adminUsers
deploy-staging-locations: _staging _locations
deploy-staging-catchments: _staging _catchments
deploy-staging-users: _staging _users
deploy-staging-concepts: _staging _concepts
deploy-staging-encounterTypes: _staging _encounterTypes
deploy-staging-programs: _staging _programs
deploy-staging-operationalEncounterTypes: _staging _operationalEncounterTypes
deploy-staging-operationalPrograms: _staging _operationalPrograms
deploy-staging-operationalSubjectTypes: _staging _operationalSubjectTypes
deploy-staging-forms: _staging _forms
deploy-staging-formDeletions: _staging _formDeletions
deploy-staging-formAdditions: _staging _formAdditions
deploy-staging-formMappings: _staging _formMappings
deploy-staging-checklistDetails: _staging _checklistDetails
deploy-staging-rules: _staging _rules

deploy-uat-all: _uat _all
deploy-uat-adminUsers: _uat _adminUsers
deploy-uat-locations: _uat _locations
deploy-uat-catchments: _uat _catchments
deploy-uat-users: _uat _users
deploy-uat-concepts: _uat _concepts
deploy-uat-encounterTypes: _uat _encounterTypes
deploy-uat-programs: _uat _programs
deploy-uat-operationalEncounterTypes: _uat _operationalEncounterTypes
deploy-uat-operationalPrograms: _uat _operationalPrograms
deploy-uat-operationalSubjectTypes: _uat _operationalSubjectTypes
deploy-uat-forms: _uat _forms
deploy-uat-formDeletions: _uat _formDeletions
deploy-uat-formAdditions: _uat _formAdditions
deploy-uat-formMappings: _uat _formMappings
deploy-uat-checklistDetails: _uat _checklistDetails
deploy-uat-rules: _uat _rules

deploy-prod-all: _prod _all
deploy-prod-adminUsers: _prod _adminUsers
deploy-prod-locations: _prod _locations
deploy-prod-catchments: _prod _catchments
deploy-prod-users: _prod _users
deploy-prod-concepts: _prod _concepts
deploy-prod-encounterTypes: _prod _encounterTypes
deploy-prod-programs: _prod _programs
deploy-prod-operationalEncounterTypes: _prod _operationalEncounterTypes
deploy-prod-operationalPrograms: _prod _operationalPrograms
deploy-prod-operationalSubjectTypes: _prod _operationalSubjectTypes
deploy-prod-forms: _prod _forms
deploy-prod-formDeletions: _prod _formDeletions
deploy-prod-formAdditions: _prod _formAdditions
deploy-prod-formMappings: _prod _formMappings
deploy-prod-checklistDetails: _prod _checklistDetails
deploy-prod-rules: _prod _rules

create_org:; psql -U$(su) openchs < create_organisation.sql
create_views:; psql -U$(su) openchs < create_views.sql
