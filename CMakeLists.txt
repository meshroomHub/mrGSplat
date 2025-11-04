cmake_minimum_required(VERSION 3.15)


set(PROJECT_NAME "gsplatNodes")
set(PROJECT_VERSION "0.1.0")
project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES NONE)


install(DIRECTORY "gsplatInterface/"
    DESTINATION "${CMAKE_INSTALL_PREFIX}/gsplatInterface"
    PATTERN "*.pyi" EXCLUDE
    PATTERN "__pycache__" EXCLUDE
)

install(DIRECTORY "nodes/commandLineNodes/"
    DESTINATION "${CMAKE_INSTALL_PREFIX}/mrGSplat/commandLineNodes/meshroom/gSplatCommandLineNodes"
    PATTERN "*.pyi" EXCLUDE
    PATTERN "__pycache__" EXCLUDE
)

install(DIRECTORY "nodes/nodes/"
    DESTINATION "${CMAKE_INSTALL_PREFIX}/mrGSplat/nodes/meshroom/gSplatNodes"
    PATTERN "*.pyi" EXCLUDE
    PATTERN "__pycache__" EXCLUDE
)

install(DIRECTORY "pipelines"
    DESTINATION "${CMAKE_INSTALL_PREFIX}/mrGSplat"
    PATTERN "MeshroomCache/*" EXCLUDE
)
