Sphinx 简介
===========

.. note::

  - 参考资料:

    - ``https://www.sphinx.org.cn/``
    - ``https://sphinx-themes.org/`` 主题
    - ``https://readthedocs.org/`` 文档托管
    - ``http://pandoc.org/try/`` markdown 转 reSrtuctuerdText

安装
----

.. code:: shell

  # Sphinx
  pip install Sphinx

  # 主题
  pip install sphinx-rtd-theme

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



预览与生成
----------

.. code:: shell

  # 开启预览
  python -m http.server 9000

  # 更新
  make html

  # ubuntu 编译并使用 firefox 查看
  make clean && make html && firefox build/html/index.html

