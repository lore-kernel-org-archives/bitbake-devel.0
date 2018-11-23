Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 47EC66C68A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 10:56:58 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wANAucS0029016
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 02:56:49 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Fri, 23 Nov 2018 02:56:28 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 23 Nov 2018 19:13:44 +0800
Message-ID: <0d508b2904f8d2d1419ca34caac67d1f58cd720c.1542971536.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542971536.git.liezhi.yang@windriver.com>
References: <cover.1542971536.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: BBHandler: Check tab indentation for python code
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 23 Nov 2018 10:56:58 -0000
Content-Type: text/plain

The previous check was in data.py which only can check code like "python
funcname()" in the dependency chain, but there are 3 kinds of python functions:
  - python()
  - def py_funcname()
  - python funcname()

Add the checking to BBHandler to check and warn for all of them.

The warning looks like:
WARNING: /path/to/recipes-core/busybox/busybox_1.29.2.bb: python should use 4 spaces indentation, but found tabs in busybox.inc, line 75

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/data.py                     |  2 --
 bitbake/lib/bb/parse/parse_py/BBHandler.py | 11 +++++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index d66d98c..6bcfcf4 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -322,8 +322,6 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             if varflags.get("python"):
                 value = d.getVarFlag(key, "_content", False)
                 parser = bb.codeparser.PythonParser(key, logger)
-                if value and "\t" in value:
-                    logger.warning("Variable %s contains tabs, please remove these (%s)" % (key, d.getVar("FILE")))
                 parser.parse_python(value, filename=varflags.get("filename"), lineno=varflags.get("lineno"))
                 deps = deps | parser.references
                 deps = deps | (keys & parser.execs)
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 01fc47e..f3bf4aa 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -46,6 +46,7 @@ __deltask_regexp__       = re.compile("deltask\s+(?P<func>\w+)")
 __addhandler_regexp__    = re.compile( r"addhandler\s+(.+)" )
 __def_regexp__           = re.compile( r"def\s+(\w+).*:" )
 __python_func_regexp__   = re.compile( r"(\s+.*)|(^$)|(^#)" )
+__python_tab_regexp__    = re.compile(" *\t")
 
 __infunc__ = []
 __inpython__ = False
@@ -160,6 +161,16 @@ def handle(fn, d, include):
 
 def feeder(lineno, s, fn, root, statements, eof=False):
     global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __def_regexp__, __python_func_regexp__, __inpython__, __infunc__, __body__, bb, __residue__, __classname__
+
+    # Check tabs in python functions:
+    # - def py_funcname(): covered by __inpython__
+    # - python(): covered by '__anonymous' == __infunc__[0]
+    # - python funcname(): covered by __infunc__[3]
+    if __inpython__ or (__infunc__ and ('__anonymous' == __infunc__[0] or __infunc__[3])):
+        tab = __python_tab_regexp__.match(s)
+        if tab:
+            bb.warn('python should use 4 spaces indentation, but found tabs in %s, line %s' % (root, lineno))
+
     if __infunc__:
         if s == '}':
             __body__.append('')
-- 
2.7.4


