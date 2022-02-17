.. _cmake_so_dll:

Linux与Windows动态库
====================

目录结构
--------

.. code:: shell

  .
  ├── build
  ├── CMakeLists.txt
  ├── include
  │   └── ExampleSharedLibrary.h
  └── src
      ├── ExampleSharedLibrary.cpp
      └── main.cpp 

构建
----

.. code:: shell

  mkdir build
  cd build
  # Windows 
  cmake .. -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE -DBUILD_SHARED_LIBS=TRUE

  # Linux
  cmake ..


CMakeLists
----------

.. code:: cmake

  cmake_minimum_required(VERSION 3.10)

  project( example )

  # 设置动态库文件路径
  set( SHARED_LIB_SOURCES 
    src/ExampleSharedLibrary.cpp
  )

  set( EXE_SOURCES
    src/main.cpp
  )

  # 添加动态库
  add_library( example_shared_library SHARED
    ${SHARED_LIB_SOURCES}
  )

  # 添加动态库头文件目录
  target_include_directories( example_shared_library
    PUBLIC
      ${PROJECT_SOURCE_DIR}/include
  )

  # 添加输出列表
  add_executable( example ${EXE_SOURCES} )

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


动态库头文件
------------

.. code:: cpp

  #pragma once

  class ExampleSharedLibrary
  {
    public:
      void print(void);
  };


动态库源文件
------------

.. code:: cpp
  
  #include <iostream>
  #include "ExampleSharedLibrary.h"
  using namespace std;

  void ExampleSharedLibrary::print(void)
  {
    cout << "File:" <<__FILE__ << "\t"  \
        << "Func:" << __func__  << "\t" \
        << "Line:" << __LINE__ << endl;
  }

main
----

.. code:: cpp

  #include "ExampleSharedLibrary.h"

  int main(int argc, char *argv[])
  {
    ExampleSharedLibrary example;
    example.print();
    return 0;
  }

