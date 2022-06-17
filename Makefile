.NOTPARALLEL:
.PHONY: default format format-fix format-check instantiate precompile

# This is the default target
default:
	$(error You must provide a target)

FORMATTER_COMMAND = JULIA_LOAD_PATH="@" julia --startup-file=no --project=.format .format/format.jl

format: format-fix

format-fix: precompile
	$(FORMATTER_COMMAND) fix

format-check: precompile
	$(FORMATTER_COMMAND) check

instantiate:
	julia --startup-file=no --project=.format -e 'import Pkg; Pkg.instantiate()'

precompile: instantiate
	julia --startup-file=no --project=.format -e 'import Pkg; Pkg.precompile()'
