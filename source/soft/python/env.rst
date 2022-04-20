Python 虚拟环境
===============

.. warning::
  
  以下示例系统环境为 Ubuntu 1840

安装
------

.. code:: shell

   sudo pip3 install virtualenv

   # 验证安装
   virtualenv --version


使用虚拟环境
------------

.. code:: shell

   # 进入项目目录
   cd project

   # 创建虚拟环境
   virtualenv env

   # 激活虚拟环境
   source env/bin/activate


查看pip安装库信息
-----------------

.. code:: shell

   pip freeze


取消激活
--------

.. code:: shell

   deactivate

