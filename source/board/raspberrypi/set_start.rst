设置开机启动
============

说明
-------------
  
.. note::

  - 添加文件: ``/usr/lib/systemd/system/xxx.service``
  - 设置权限: ``sudo chmod +x /usr/lib/systemd/system/xxx.service``
  - 重新加载: ``sudo systemctl daemon-reload``
  - 测试启动: ``sudo systemctl start xxx``
  - 设置启动: ``sudo systemctl enable xxx.service``
  - 取消启动: ``sudo systemctl disable xxx.service``
  - 查看日志: ``journalctl -xe``

文件内容
-------------

.. note::

  测试过程中使用 ``forking`` 程序在运行几分钟会自动退出。原因侍查@TODO

.. code:: shell
  
   [Unit]                                                                                                                         
   Description=community
   After=network.target remote-fs.target nss-lookup.target
    
   [Service]
   Type=oneshot
   ExecStart=/usr/bin/python3 /home/pi/community/main.py
   WorkingDirectory=/home/pi/community
   User=pi
    
   [Install]
   WantedBy=multi-user.target
   

参数说明
-------------

.. code:: shell

  # 使用绝对路径
  [Unit]
  Description:  描述
  After:        依赖服务
   
  [Service]
  Type=forking  运行形式: forking、oneshot
  ExecStart     运行命令
  ExecReload    重启命令
  ExecStop      停止命令
  PrivateTmp=True     表示给服务分配独立的临时空间
  WorkingDirectory=   工作目录
  User=pi
   
  [Install]
  WantedBy=multi-user.target 
