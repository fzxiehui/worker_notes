Sphinx 简介
===========

.. note::

  - 参考资料:

    - ``https://www.sphinx.org.cn/``
    - ``https://sphinx-themes.org/`` 主题
    - ``https://readthedocs.org/`` 文档托管
    - ``http://pandoc.org/try/`` markdown 转 reSrtuctuerdText
    - ``http://zhk.me/861.html`` sphinx plantuml

安装
----

.. code:: shell

  # 使用虚拟环境
  # ubuntu
  # sudo pip3 install virtualenv
  cd doc
  virtualenv venv
  pip install sphinx
  pip install sphinx_rtd_theme
  pip install sphinxcontrib-plantuml

  # 使用全局环境
  # Sphinx
  sudo pip install Sphinx

  # 主题
  sudo pip install sphinx-rtd-theme
  
  # uml
  sudo pip install sphinxcontrib-plantuml

创建文档
--------

.. code:: shell
  
  mkdir docs && cd docs
  sphinx-quickstart


修改主题
--------

.. code:: shell

  # 修改conf.py文件:
  # html_theme = 'alabaster'
  html_theme = 'sphinx_rtd_theme'

添加plantuml
-------------

#. 修改conf文件

   .. code:: python
    
     extensions = ['sphinxcontrib.plantuml']

     ## -jar 包必需是绝对路径
     plantuml = 'java -jar /home/hello/plantuml.jar'

#. 使用示例

   .. code:: shell
     
     # 直接使用
     .. uml::

       Alice -> Bob: Hi!
       Alice <- Bob: How are you?

     # 引入uml文件
     .. uml:: example.uml


预览与生成
----------

.. code:: shell

  # 开启预览
  python -m http.server 9000

  # 更新
  make html

  # ubuntu 编译并使用 firefox 查看
  make clean && make html && firefox build/html/index.html

