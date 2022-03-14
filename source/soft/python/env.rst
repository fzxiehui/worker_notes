Python 虚拟环境
===============

安装
------

.. code:: shell

   sudo pip3 install virtualenv

   # 验证安装
   virtualenv --version


使用虚拟环境
------------

.. code:: shell

   cd project
   virtualenv project_env
   source project_env/bin/virtualenv


查看pip安装库信息
-----------------

.. code:: shell

   pip freeze

取消激活
--------


.. code:: shell

   deactivate

