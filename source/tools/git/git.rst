Git
===========
  
常用分支
-----------

  =========== ============================
  master      默认发行分支
  Head        默认开发分支
  origin      默认远程版本库  
  Head^       Head 的父提交
  upstream    核心远程分支,需要手动添加
  =========== ============================

高频命令
-----------

 * 初始化

  ================== ==========================
  $ git clone <url>	 克隆远程仓库
  $ git init		     创建本地仓库
  $ git --bare init	 创建远程仓库(用于服务端)
  ================== ==========================

 
 * 修改和提交
  
  ========================= =====================
  $ git status              查看状态
  $ git diff                查看变更内容
  $ git add .               跟踪所有改动的文件
  $ git mv <old> <new>	    文件改名
  $ git rm <file>           删除文件
  $ git rm --cached <file>  停止跟踪文件但不删除
  $ git commit -m <msg>	    提交所有更新过的文件
  $ git commit --amend	    修改最后一次提交
  ========================= =====================

 * 日志

  ===================== ==============================
  $ git log		          查看提交历史
  $ git log --oneline   简要日志
  $ git log -p <file>	  查看指定文件提交历史
  $ git blame <file>	  以列表方式查看指定文件提交历史
  ===================== ==============================

 * 撤销

  =========================== =======================================
  $ git reset --hard HEAD	    撤消工作目录中所有未提交文件的修改内容
  $ git checkout HEAD <file>  撤消指定未提交文件的修改内容
  $ git revert <commit>       撤消指定的提交
  =========================== =======================================

 * 分支与标签

  ============================= =======================
  $ git branch -v               显示所有本地分支
  $ git checkout <branch/tag>   切换到指定分支或标签
  $ git branch <new-branch>     创建新分支
  $ git branch -d <branch>      删除本地分支

  $ git tag		                  列出所有本地标签
  $ git tag <tagname>	          基于最新提交创建标签
  $ git tag -d <tagname>        删除标签
  ============================= =======================

 * 合并与衍合

  ========================= =======================
  $ git merge <branch>	    合并指定分支到当前分支
  $ git rebase <branch>	    衍合指定分支到当前分支
  ========================= =======================

 * 远程操作

  ========================================= =========================
  $ git remote -v		                        查看远程版本库信息
  $ git remote show <remote>                查看指定远程版本库信息
  $ git remote add <remote> <url>           添加远程版本库
  $ git push                                提交到远程
  $ git pull                                更新到本地
  $ git push/pull --all                     提交或下载全部分支、标签
  $ git push --set-upstream origin master   设置提交分支并提交
  ========================================= =========================
