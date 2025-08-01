Indent:
	@echo *********************************************** RODANDO TRANSFORM ***********************************************
	robotidy --configure AlignSettingsSection:argument_indent=0 '$(src)'

Execute: 
	@echo *********************************************** RODANDO ROBOTIDY ***********************************************
	robotidy '$(src)'
	@echo *********************************************** RODANDO TRANSFORM ***********************************************
	robotidy --transform NormalizeSectionHeaderName '$(src)'
	robotidy --configure AlignSettingsSection:argument_indent=0 '$(src)'
	@echo *********************************************** RODANDO TESTE ***********************************************
	robot -d '.\Logs\' '$(src)'	
	@echo *********************************************** RELATORIO FINAL DO ROBOCOP ***********************************************
	robocop '$(src)' --reports all

GitAdd:
	@echo *********************************************** RODANDO ROBOTIDY ***********************************************
	robotidy '$(src)'
	@echo *********************************************** RODANDO TRANSFORM ***********************************************
	robotidy --transform NormalizeSectionHeaderName '$(src)'
	robotidy --configure AlignSettingsSection:argument_indent=0 '$(src)'
	@echo *********************************************** RODANDO TESTE ***********************************************
	robot -d './Logs/' '$(src)'	
	@echo *********************************************** ADCIONANDO ARQUIVOS NO STAGE ***********************************************
	git add *

Update Libs:
	pip install --upgrade robotframework
	python -m pip install --upgrade pip