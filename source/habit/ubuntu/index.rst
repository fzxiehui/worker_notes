ubuntu 个性设置
==================

改键
------------------

.. attention::

   - 配置文件在 ``/usr/share/X11/xkb/keycodes/evdev``
   - 重启后生效

#. 以下命令将 ``Caps_Lock`` 键映射为 ``ESC`` 键

.. code-block:: bash

   #<CAPS> = 66;
   <CAPS> = 9;
   #<ESC> = 9;
   <ESC> = 66;

添加快捷指令
------------------

#. 将 ``vi``, ``vim`` 都指向 ``nvim``, 打开 ``~/.bashrc``, 添加以下内容

   .. code-block:: bash

      alias vi='nvim'
      alias vim='nvim'

#. 添加代理快捷指令

   .. code-block:: bash

      alias proxy='export http://127.0.0.1:7890; export https://127.0.0.1:7890'

#. 取消代理快捷指令

   .. code-block:: bash

      alias unproxy='unset http_proxy; unset https_proxy'
