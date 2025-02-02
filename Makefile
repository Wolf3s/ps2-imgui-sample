DEBUG=1

EE_BIN = ps2_imgui_sample.elf
EE_OBJS = src/main.o src/gfx.o src/pad.o \
		  src/drawing/drawing.o src/drawing/drawing_controller.o \
		  src/widgets/widget_cursor.o src/widgets/widget_gamepad.o src/widgets/widget_icon.o src/widgets/widget_misc.o
EE_LIBS += -lpad

# Add imgui references
EE_OBJS += lib/imgui/imgui.o lib/imgui/imgui_demo.o lib/imgui/imgui_draw.o lib/imgui/imgui_tables.o lib/imgui/imgui_widgets.o
EE_OBJS += lib/imgui/backends/imgui_impl_ps2sdk.o lib/imgui/backends/imgui_impl_ps2gskit.o
EE_INCS += -Ilib/imgui -Ilib/imgui/backends
EE_CXXFLAGS += -std=gnu++11

# Add gsKit references
EE_INCS += -I$(GSKIT)/include
EE_LIBS += -lgskit_toolkit -lgskit -ldmakit
EE_LDFLAGS += -L$(GSKIT)/lib

ifeq ($(DEBUG),1)
EE_CXXFLAGS += -DDEBUG -g
EE_LDFLAGS += -g
else
EE_LDFLAGS += -s
endif

all: $(EE_BIN)

clean:
	rm -f $(EE_BIN) $(EE_OBJS)

run: $(EE_BIN)
	ps2client -h 192.168.0.85 execee host:$(EE_BIN)

reset:
	ps2client reset

include $(PS2SDK)/Defs.make
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal_cpp
