CXX      := g++
TARGET   := messager_ui

SRC_DIR  := src
QML_DIR  := qml
BUILD_DIR:= build

SOURCES  := $(SRC_DIR)/main.cpp
QRC      := $(QML_DIR)/qml.qrc
QRC_CPP  := $(BUILD_DIR)/qrc_qml.cpp

# Qt6 via pkg-config
PKG      := Qt6Core Qt6Gui Qt6Qml Qt6Quick
CXXFLAGS := -std=c++17 -O2 -Wall -Wextra -MMD -MP $(shell pkg-config --cflags $(PKG))
LDFLAGS  := $(shell pkg-config --libs $(PKG))

OBJECTS  := $(BUILD_DIR)/main.o $(BUILD_DIR)/qrc_qml.o
DEPS     := $(OBJECTS:.o=.d)

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) -o $@ $(LDFLAGS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/main.o: $(SOURCES) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Génère le .cpp depuis le .qrc (rcc Qt6)
$(QRC_CPP): $(QRC) | $(BUILD_DIR)
	rcc -name qml $< -o $@

$(BUILD_DIR)/qrc_qml.o: $(QRC_CPP) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: all
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR) $(TARGET)

-include $(DEPS)
