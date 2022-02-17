CMake同时生成静态库、动态库
===========================

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

CMakeLists
----------

.. code:: cmake

  cmake_minimum_required(VERSION 3.10)
  project( example )

  # 设置动态库文件路径
  set( SHARED_LIB_SOURCES 
    src/ExampleSharedLibrary.cpp
  )

  # 设置静态库文件路径
  set( STATIC_LIB_SOURCES 
    src/ExampleSharedLibrary.cpp
  )

  set( EXE_SOURCES
    src/main.cpp
  )

  # 添加动态库
  add_library( example_shared_library SHARED
    ${SHARED_LIB_SOURCES}
  )

  # 添加静态库
  add_library( example_static_library STATIC
    ${STATIC_LIB_SOURCES}
  )

  # 兼容 Windows 预处理
  target_compile_definitions( example_shared_library PRIVATE BUILD_DLL )
  target_compile_definitions( example_shared_library PRIVATE USE_DLL )

  # 添加动态库头文件目录
  target_include_directories( example_shared_library
    PUBLIC
      ${PROJECT_SOURCE_DIR}/include
  )

  # 添加静态库头文件目录
  target_include_directories( example_static_library
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

库头文件
--------

.. code:: cpp

  #ifndef EXAMPLE_SHARED_LIBRARY_H
  #define EXAMPLE_SHARED_LIBRARY_H

  #ifndef EXAMPLE_DLL
  # ifdef _WIN32
  #  if defined( BUILD_DLL )
  #    define EXAMPLE_DLL __declspec(dllexport)
  #  elif defined( USE_DLL )
  #    define EXAMPLE_DLL __declspec(dllimport)
  #  else
  #    define EXAMPLE_DLL
  #  endif
  # else
  #  define EXAMPLE_DLL
  # endif
  #endif

  class EXAMPLE_DLL ExampleSharedLibrary
  {
    public:
      void print(void);
  };
  #endif

库源文件
--------

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

