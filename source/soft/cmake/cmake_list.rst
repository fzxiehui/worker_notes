CMake List
==========

.. note::

  源码地址: ``https://github.com/fzxiehui/cmake_example/tree/master/7_list``

CMakeLists
----------

.. code-block:: cmake
  :emphasize-lines: 11-20

  cmake_minimum_required(VERSION 3.10)

  # 声明项目名
  project( example )

  # 声明输出的主文件
  set( exe_sources
    src/main.cpp
    )

  # 声明 list
  set( shared_libraray_list )

  list(APPEND shared_libraray_list src/Test1.cpp)
  list(APPEND shared_libraray_list src/Test2.cpp)
  list(APPEND shared_libraray_list src/Test3.cpp)

  message(STATUS "shared_libraray_list = ${shared_libraray_list}")

  add_library( example_shared_library SHARED ${shared_libraray_list})

  # 添加动态库头文件目录
  target_include_directories( example_shared_library
    PUBLIC
      ${PROJECT_SOURCE_DIR}/include
  )


  # 添加输出列表
  add_executable( example ${exe_sources} )


  # 添加主项目头文件
  target_include_directories( example 
    PRIVATE
      ${PROJECT_SOURCE_DIR}/include
  )

  # 链接
  target_link_libraries(example 
    PRIVATE
      example_shared_library
  )

