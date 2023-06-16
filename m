Return-Path: <wuzhenyu@ustc.edu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3649FEB64DB
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 06:44:21 +0000 (UTC)
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
 by mx.groups.io with SMTP id smtpd.web10.2935.1686897851783186927
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jun 2023 23:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: ustc.edu, ip: 115.236.121.145, mailfrom: wuzhenyu@ustc.edu)
Received: from desktop (unknown [211.86.144.129])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 89F838000C5
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 14:44:05 +0800 (CST)
Date: Fri, 16 Jun 2023 14:44:03 +0800
From: Wu Zhenyu <wuzhenyu@ustc.edu>
To: bitbake-devel@lists.openembedded.org
Subject: Support packaging
Message-ID: <gu3erz2kuwv6e4nijjwavi2pci2ohlfcoaornwyicfsufgii7p@wsazr62z42tf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUJKVkkeTk1MT09NGkMfGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVDTVVKT09VSklCWVdZFhoPEhUdFFlBWU9LSFVKSklISU5VSktLVUtZBg++
X-HM-Tid: 0a88c2f2656cb03akuuu89f838000c5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46Cxw6SD1RMhdDExosGSlO
	HCwaFD1VSlVKTUNNQ0JMQ09NSU1MVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSUpK
	VUNNVUpPT1VKSUJZV1kIAVlBTExOSjcG
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 06:44:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14836

use `python -m build` to package
---
 .gitignore               | 130 ++++++++++++++++++++++++++++++++++++++-
 lib/bb/server/process.py |   5 +-
 pyproject.toml           | 109 ++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+), 4 deletions(-)
 create mode 100644 pyproject.toml

diff --git a/.gitignore b/.gitignore
index fbf9eb2..c328bcd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,9 +1,6 @@
-*.pyc
-*.pyo
 *~
 pyshtables.py
 /doc/manual/html/
-/build/
 /bin/bitbakec
 *.swp
 tags
@@ -16,3 +13,130 @@ lib/toaster/contrib/tts/backlog.txt
 lib/toaster/contrib/tts/log/*
 lib/toaster/contrib/tts/.cache/*
 lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
+
+# create by https://github.com/iamcco/coc-gitignore (Thu Jun 15 2023 22:34:35 GMT+0800 (China Standard Time))
+# Python.gitignore:
+# Byte-compiled / optimized / DLL files
+__pycache__/
+*.py[cod]
+*$py.class
+
+# C extensions
+*.so
+
+# Distribution / packaging
+.Python
+build/
+develop-eggs/
+dist/
+downloads/
+eggs/
+.eggs/
+lib/
+lib64/
+parts/
+sdist/
+var/
+wheels/
+pip-wheel-metadata/
+share/python-wheels/
+*.egg-info/
+.installed.cfg
+*.egg
+MANIFEST
+
+# PyInstaller
+#  Usually these files are written by a python script from a template
+#  before PyInstaller builds the exe, so as to inject date/other infos into it.
+*.manifest
+*.spec
+
+# Installer logs
+pip-log.txt
+pip-delete-this-directory.txt
+
+# Unit test / coverage reports
+htmlcov/
+.tox/
+.nox/
+.coverage
+.coverage.*
+.cache
+nosetests.xml
+coverage.xml
+*.cover
+.hypothesis/
+.pytest_cache/
+
+# Translations
+*.mo
+*.pot
+
+# Django stuff:
+*.log
+local_settings.py
+db.sqlite3
+db.sqlite3-journal
+
+# Flask stuff:
+instance/
+.webassets-cache
+
+# Scrapy stuff:
+.scrapy
+
+# Sphinx documentation
+docs/_build/
+
+# PyBuilder
+target/
+
+# Jupyter Notebook
+.ipynb_checkpoints
+
+# IPython
+profile_default/
+ipython_config.py
+
+# pyenv
+.python-version
+
+# pipenv
+#   According to pypa/pipenv#598, it is recommended to include Pipfile.lock in version control.
+#   However, in case of collaboration, if having platform-specific dependencies or dependencies
+#   having no cross-platform support, pipenv may install dependencies that don't work, or not
+#   install all needed dependencies.
+#Pipfile.lock
+
+# celery beat schedule file
+celerybeat-schedule
+
+# SageMath parsed files
+*.sage.py
+
+# Environments
+.env
+.venv
+env/
+venv/
+ENV/
+env.bak/
+venv.bak/
+
+# Spyder project settings
+.spyderproject
+.spyproject
+
+# Rope project settings
+.ropeproject
+
+# mkdocs documentation
+/site
+
+# mypy
+.mypy_cache/
+.dmypy.json
+dmypy.json
+
+# Pyre type checker
+.pyre/
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 7616ef5..e5d1cbd 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -32,6 +32,7 @@ import stat
 import bb.server.xmlrpcserver
 from bb import daemonize
 from multiprocessing import queues
+from shutil import which
 
 logger = logging.getLogger('BitBake')
 
@@ -619,7 +620,9 @@ class BitBakeServer(object):
         os.close(self.readypipe)
         os.set_inheritable(self.bitbake_lock.fileno(), True)
         os.set_inheritable(self.readypipein, True)
-        serverscript = os.path.realpath(os.path.dirname(__file__) + "/../../../bin/bitbake-server")
+        serverscript = which("bitbake-server")
+        if serverscript is None:
+            serverscript = os.path.realpath(os.path.dirname(__file__) + "/../../../bin/bitbake-server")
         os.execl(sys.executable, "bitbake-server", serverscript, "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, self.bitbake_lock.name, self.sockname,  str(self.server_timeout or 0), str(int(self.profile)), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
 
 def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpcinterface, profile):
diff --git a/pyproject.toml b/pyproject.toml
new file mode 100644
index 0000000..988cbb4
--- /dev/null
+++ b/pyproject.toml
@@ -0,0 +1,109 @@
+[build-system]
+requires = ["setuptools_scm[toml] >= 6.2"]
+build-backend = "setuptools.build_meta"
+
+# https://setuptools.pypa.io/en/latest/userguide/pyproject_config.html
+[project]
+name = "bitbake"
+description = ""
+readme = "README.md"
+requires-python = ">= 3.7"
+keywords = ["yocto"]
+version = "2.4.1"
+classifiers = [
+  "Development Status :: 3 - Alpha",
+  "Intended Audience :: Developers",
+  "Topic :: Software Development :: Build Tools",
+  "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
+  "Operating System :: Microsoft :: Windows",
+  "Operating System :: POSIX",
+  "Operating System :: Unix",
+  "Operating System :: MacOS",
+  "Programming Language :: Python :: 3 :: Only",
+  "Programming Language :: Python :: 3",
+  "Programming Language :: Python :: 3.7",
+  "Programming Language :: Python :: 3.8",
+  "Programming Language :: Python :: 3.9",
+  "Programming Language :: Python :: 3.10",
+  "Programming Language :: Python :: 3.11",
+  "Programming Language :: Python :: Implementation :: CPython",
+  "Programming Language :: Python :: Implementation :: PyPy",
+]
+dynamic = ["optional-dependencies"]
+
+[[project.authors]]
+name = "Tim Ansell"
+email = "mithro@mithis.net"
+
+[[project.authors]]
+name = "Phil Blundell"
+email = "pb@handhelds.org"
+
+[[project.authors]]
+name = "Seb Frankengul"
+email = "seb@frankengul.org"
+
+[[project.authors]]
+name = "Holger Freyther"
+email = "holger@moiji-mobile.com"
+
+[[project.authors]]
+name = "Marcin Juszkiewicz"
+email = "marcin@juszkiewicz.com.pl"
+
+[[project.authors]]
+name = "Chris Larson"
+email = "kergoth@handhelds.org"
+
+[[project.authors]]
+name = "Ulrich Luckas"
+email = "luckas@musoft.de"
+
+[[project.authors]]
+name = "Mickey Lauer"
+email = "mickey@Vanille.de"
+
+[[project.authors]]
+name = "Richard Purdie"
+email = "rpurdie@rpsys.net"
+
+[[project.authors]]
+name = "Holger Schurig"
+email = "holgerschurig@gmx.de"
+
+[project.license]
+text = "GPL v2"
+
+[project.urls]
+Homepage = "https://docs.yoctoproject.org/bitbake"
+Download = "https://git.openembedded.org/bitbake"
+"Bug Report" = "https://bugzilla.yoctoproject.org"
+Source = "https://git.openembedded.org/bitbake"
+
+[tool.setuptools]
+script-files = [
+  "bin/bitbake",
+  "bin/bitbake-diffsigs",
+  "bin/bitbake-dumpsig",
+  "bin/bitbake-getvar",
+  "bin/bitbake-hashclient",
+  "bin/bitbake-hashserv",
+  "bin/bitbake-layers",
+  "bin/bitbake-prserv",
+  "bin/bitbake-selftest",
+  "bin/bitbake-server",
+  "bin/bitbake-worker",
+  "bin/git-make-shallow",
+  "bin/toaster",
+  "bin/toaster-eventreplay",
+]
+py-modules = ["codegen", "pyinotify"]
+
+[tool.setuptools.packages.find]
+where = ["lib"]
+
+[tool.setuptools.data-files]
+"share/man/man1" = ["doc/bitbake.1"]
+
+[tool.setuptools.dynamic.optional-dependencies.toaster]
+file = "toaster-requirements.txt"
-- 
2.40.1

-- 
Best Regards
Wu Zhenyu

