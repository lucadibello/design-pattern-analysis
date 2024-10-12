# Path JDK 21 home directory
JAVA_HOME=/opt/homebrew/opt/openjdk@21
# Path to the project
PROJECT_PATH=./caffeine
# Executable to build the project
GRADLEW=./gradlew
# Skip tests and javadoc generation when building
BUILD_FLAGS=-x test -x javadoc
# Path to the pattern4.jar file
PATTERN4 = ./tools/pattern4.jar
# Target directory for analysis
PATTERN4_TARGET = caffeine/caffeine/build/classes/java
# Output directory (ensure trailing slash)
PATTERN4_OUTPUT_DIR = ./results/
# Output file name
PATTERN4_OUTPUT := ${PATTERN4_OUTPUT_DIR}out.xml
# JVM flags
PATTERN4_FLAGS = -Xms32m -Xmx512m

$(PATTERN4_OUTPUT_DIR):
	mkdir -p $(PATTERN4_OUTPUT_DIR)

# Build the project
build:
	cd ${PROJECT_PATH} && JAVA_HOME=${JAVA_HOME} ${GRADLEW} build ${BUILD_FLAGS}

# Remove build artifacts
clean:
	${GRADLEW} clean
	rm -rf ${PATTERN4_OUTPUT_DIR}

# Analyze the project (CLI)
analyze: build $(PATTERN4_OUTPUT_DIR)
	java ${PATTERN4_FLAGS} -jar ${PATTERN4} -target ${PATTERN4_TARGET} -output ${PATTERN4_OUTPUT}

# Analyze the project (GUI)
analyze-gui: build $(PATTERN4_OUTPUT_DIR)
	java ${PATTERN4_FLAGS} -jar ${PATTERN4}

.PHONY: clean analyze-gui
