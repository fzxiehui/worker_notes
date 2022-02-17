CMake 动态库
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
  │   └── ExampleSharedLibrary.h
  └── src
      ├── ExampleSharedLibrary.cpp
      └── main.cpp 



CMakeLists
----------

.. attention::

  - 本篇方法只适用于学习，其中涉及到 ``WIN32``、``CLASSLIB_EXPORTS``、``_WINDOWS`` 宏。
  - VC编译器对DLL动态库的处理:

    - ``#define DLL_API __declspec(dllexport)``
    - ``#define DLL_API __declspec(dllimport)``
  - ``CMake`` 提供更便捷的方式，请查看: :ref:`Linux与Windows动态库<cmake_so_dll>` 

.. note::
  
  为兼容 ``Windows`` 平台，在 ``CMakeLists`` 中添加两条预处理
  ``USE_DLL`` 、 ``BUILD_DLL``。 

.. code-block:: cmake
  :emphasize-lines: 13-18
  
  cmake_minimum_required(VERSION 3.10)

  project( example )

  set( SHARED_LIB_SOURCES 
    src/ExampleSharedLibrary.cpp
  )

  set( EXE_SOURCES
    src/main.cpp
  )

  add_library( example_shared_library SHARED
    ${SHARED_LIB_SOURCES}
  )

  target_compile_definitions( example_shared_library PRIVATE BUILD_DLL )
  target_compile_definitions( example_shared_library PRIVATE USE_DLL )

  target_include_directories( example_shared_library
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
      example_shared_library
  )


动态库头文件
------------


.. note::
  
  为兼容 ``Windows`` 平台，需要在头文件中添加 ``_WIN32`` 处理宏。

.. code-block:: cpp
  :emphasize-lines: 4-18

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

