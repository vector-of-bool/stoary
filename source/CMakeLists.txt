# Generate qmldir files
#file(GLOB_RECURSE qml_files RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/qml" qml/*/*.qml)
#foreach(file IN LISTS qml_files)
#    message(STATUS "QML file: ${file}")
#    get_filename_component(dir "${file}" DIRECTORY)
#    get_filename_component(acc_file "qml/${dir}/qmldir.acc" ABSOLUTE)
#    if(NOT EXISTS "${acc_file}")
#        string(REPLACE "/" "." mod "${dir}")
#        file(WRITE "${acc_file}" "# THIS FILE IS GENERATED\nmodule ${mod}\n")
#        message(STATUS "Generating qmldir file: ${acc_file}")
#    endif()
#    get_filename_component(component "${file}" NAME_WE)
#    get_filename_component(fname "${file}" NAME)
#    file(APPEND "${acc_file}" "${component} 1.0 ${fname}\n")
#endforeach()

#file(GLOB_RECURSE acc_files qmldir.acc)
#foreach(acc IN LISTS acc_files)
#    get_filename_component(qmldir_dir "${acc}" DIRECTORY)
#    get_filename_component(qmldir_file "${acc}" NAME_WE)
#    execute_process(
#        COMMAND "${CMAKE_COMMAND}" -E copy_if_different "${acc}" "${qmldir_dir}/${qmldir_file}"
#        )
#    file(REMOVE "${acc}")
#endforeach()

file(GLOB_RECURSE qml_contents qml/*)
add_custom_target(qml-dummy SOURCES ${qml_contents})
set(QML_QRC_ENTRIES)
foreach(file IN LISTS qml_contents)
    file(RELATIVE_PATH relpath "${CMAKE_CURRENT_SOURCE_DIR}" "${file}")
    get_filename_component(dir "${relpath}" DIRECTORY)
    get_filename_component(fname "${relpath}" NAME)
    string(CONFIGURE [[
        <qresource prefix="${dir}">
            <file alias="${fname}">${file}</file>
        </qresource>
    ]] line)
    set(QML_QRC_ENTRIES "${QML_QRC_ENTRIES}${line}")
endforeach()
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/qml.qrc "<RCC>${QML_QRC_ENTRIES}</RCC>")
#configure_file(qml.in.qrc qml.qrc @ONLY)

qt5_add_resources(QML_QRC ${CMAKE_CURRENT_BINARY_DIR}/qml.qrc)
add_executable(stoary main.cpp ${QML_QRC})

target_link_libraries(stoary PRIVATE Qt5::QuickControls2 Qt5::Widgets)
get_target_property(libpath Qt5::QuickControls2 IMPORTED_LOCATION)
if(WIN32)
    get_filename_component(qml_dir "${Qt5_DIR}/../../../qml" ABSOLUTE)
    target_compile_definitions(stoary PRIVATE "QML_IMPORT_ROOT=\"${qml_dir}\"")
endif()

if(WIN32)
    target_link_libraries(stoary PRIVATE Qt5::WinMain)
endif()

get_dlls(${CMAKE_RUNTIME_OUTPUT_DIRECTORY} stoary)

get_target_property(libraries stoary LINK_LIBRARIES)

foreach(lib IN LISTS libraries)
    if(WIN32 AND TARGET ${lib})
        add_custom_command(
            TARGET stoary
            POST_BUILD
            COMMAND "${CMAKE_COMMAND}" -E copy $<TARGET_FILE:${lib}> $<TARGET_FILE_DIR:stoary>
            )
    endif()
endforeach()
