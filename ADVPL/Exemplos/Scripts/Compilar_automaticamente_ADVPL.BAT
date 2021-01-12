
@echo navegar ate pasta do appServer
cd C:\Totvs\Brasil\Ambiente\Protheus_12_27\Protheus\AppServer

@echo executar a compilaçao automatica
appserver.exe -compile -files=C:\Totvs\Brasil\Workspace\Sem-Preju_Local\ADVPL_BLOG -includes=C:\Totvs\Brasil\Ambiente\Protheus_12_27\Protheus\INCLUDES -src=C:\Totvs\Brasil\Workspace\Sem-Preju_Local\ADVPL_BLOG -env=LOBO_12_27

@echo Executar a desfragmentacao
appserver.exe -console -compile -defragrpo -env=LOBO_12_27
