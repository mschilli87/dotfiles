INSTALL_TARGET:=install
PRETEND_TARGET:=pretend
UNINSTALL_TARGET:=uninstall
INSTALL_PREFIX:=$(INSTALL_TARGET)-
PRETEND_PREFIX:=$(PRETEND_TARGET)-
UNINSTALL_PREFIX:=$(UNINSTALL_TARGET)-

STOW:=stow
INSTALL:=$(STOW)
PRETEND:=$(INSTALL) --no --verbose=2
UNINSTALL:=$(STOW) --delete

DIRS:=$(wildcard */)
TARGETS:=$(DIRS:/=)

all : $(INSTALL_TARGET)
dry-run : $(PRETEND_TARGET)
clean : $(UNINSTALL_TARGET)

$(INSTALL_TARGET) : $(addprefix $(INSTALL_PREFIX),$(TARGETS))
$(PRETEND_TARGET) : $(addprefix $(PRETEND_PREFIX),$(TARGETS))
$(UNINSTALL_TARGET) : $(addprefix $(UNINSTALL_PREFIX),$(TARGETS))

$(INSTALL_PREFIX)% : %
	$(INSTALL) '$<'

$(PRETEND_PREFIX)% : %
	$(PRETEND) '$<'

$(UNINSTALL_PREFIX)% : %
	$(UNINSTALL) '$<'
