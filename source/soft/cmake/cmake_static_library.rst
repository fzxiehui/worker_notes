CMake 静态库
============

.. note::

  - 构建目录: ``mkdir build && cd build``
  - 构建: ``cmake configure ..``
  - 编译: ``cmake --build . --config release``


目录结构
--------

.. code:: shell

  .
  ├── build
  ├── CMakeLists.txt
  ├── include
  │   └── ExampleStaticLibrary.h
  └── src
      ├── ExampleStaticLibrary.cpp
      └── main.cpp

CMakeLists
----------

.. note::

  在 ``Linux`` 环境中，静态库与动态库的 ``CMakeLists.txt`` 写法大至相同，
  不同点只有一处:  ``add_library`` 第二个参数
  ``SHARED``、``STATIC``


.. code-block:: cmake
  :emphasize-lines: 13,13
  
  cmake_minimum_required(VERSION 3.10)

  project( example )

  set( STATIC_LIB_SOURCES 
    src/ExampleStaticLibrary.cpp
  )

  set( EXE_SOURCES
    src/main.cpp
  )

  add_library( example_static_library STATIC
    ${STATIC_LIB_SOURCES}
  )

  target_include_directories( example_static_library
    PUBLIC
      ${PROJECT_SOURCE_DIR}/include
  )

  add_executable( example ${EXE_SOURCES} )

  target_include_directories( example 
    PRIVATE
      ${PROJECT_SOURCE_DIR}/include
  )

  target_link_libraries(example 
    PRIVATE
      example_static_library
  )

静态库头文件
------------

.. code:: cpp
  
  #ifndef EXAMPLE_STATIC_LIBRARY_H
  #define EXAMPLE_STATIC_LIBRARY_H

  class ExampleStaticLibrary
  {
    public:
      void print(void);
  };
  #endif


静态库源文件
------------

.. code:: cpp

  #include <iostream>
  #include "ExampleStaticLibrary.h"
  using namespace std;

  void ExampleStaticLibrary::print(void)
  {
    cout << "File:" <<__FILE__ << "\t"  \
        << "Func:" << __func__  << "\t" \
        << "Line:" << __LINE__ << endl;
  }

main
----

.. code:: cpp

  #include "ExampleStaticLibrary.h"

  int main(int argc, char *argv[])
  {
    ExampleStaticLibrary example;
    example.print();
    return 0;
  }

