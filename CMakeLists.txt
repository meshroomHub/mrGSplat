cmake_minimum_required(VERSION 3.15)


set(PROJECT_NAME "gsplatNodes")
set(PROJECT_VERSION "0.1.0")
project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES NONE)


install(DIRECTORY "nodes/optim/"
    DESTINATION "${CMAKE_INSTALL_PREFIX}/mrGSplat/optim/meshroom/gSplatNodesOptim"
    PATTERN "*.pyi" EXCLUDE
    PATTERN "__pycache__" EXCLUDE
)

install(DIRECTORY "nodes/utils/"
    DESTINATION "${CMAKE_INSTALL_PREFIX}/mrGSplat/utils/meshroom/gSplatNodesUtils"
    PATTERN "*.pyi" EXCLUDE
    PATTERN "__pycache__" EXCLUDE
)

install(DIRECTORY "pipelines"
    DESTINATION "${CMAKE_INSTALL_PREFIX}/mrGSplat"
    PATTERN "MeshroomCache/*" EXCLUDE
)
