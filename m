Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SX0l3-0000qb-Sj
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 03:53:02 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4N1gqlQ009052
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 May 2012 18:42:52 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 22 May 2012 18:42:51 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 22 May 2012 20:46:31 -0500
Message-ID: <1337737597-5964-2-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1337714416.git.mark.hatle@windriver.com>
References: <cover.1337714416.git.mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 2/3] build.py: Add additional debug messages
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 23 May 2012 01:53:02 -0000
Content-Type: text/plain

We now add a debug message when entering and exiting a python or
shell function.  This makes it easier to inspect a log and figure
out the run order from the logs.

Also minor cleanup in th exec_func_shell to match the exec_func_python
variables.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/build.py |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 4f06b15..2fbe120 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -206,6 +206,8 @@ def exec_func_python(func, d, runfile, cwd=None):
             olddir = None
         os.chdir(cwd)
 
+    bb.debug(2, "Executing python function %s" % func)
+
     try:
         comp = utils.better_compile(code, func, bbfile)
         utils.better_exec(comp, {"d": d}, code, bbfile)
@@ -215,13 +217,15 @@ def exec_func_python(func, d, runfile, cwd=None):
 
         raise FuncFailed(func, None)
     finally:
+        bb.debug(2, "Python function %s finished" % func)
+
         if cwd and olddir:
             try:
                 os.chdir(olddir)
             except OSError:
                 pass
 
-def exec_func_shell(function, d, runfile, cwd=None):
+def exec_func_shell(func, d, runfile, cwd=None):
     """Execute a shell function from the metadata
 
     Note on directory behavior.  The 'dirs' varflag should contain a list
@@ -234,18 +238,18 @@ def exec_func_shell(function, d, runfile, cwd=None):
 
     with open(runfile, 'w') as script:
         script.write('#!/bin/sh -e\n')
-        data.emit_func(function, script, d)
+        data.emit_func(func, script, d)
 
         if bb.msg.loggerVerboseLogs:
             script.write("set -x\n")
         if cwd:
             script.write("cd %s\n" % cwd)
-        script.write("%s\n" % function)
+        script.write("%s\n" % func)
 
     os.chmod(runfile, 0775)
 
     cmd = runfile
-    if d.getVarFlag(function, 'fakeroot'):
+    if d.getVarFlag(func, 'fakeroot'):
         fakerootcmd = d.getVar('FAKEROOT', True)
         if fakerootcmd:
             cmd = [fakerootcmd, runfile]
@@ -255,11 +259,17 @@ def exec_func_shell(function, d, runfile, cwd=None):
     else:
         logfile = sys.stdout
 
+    bb.debug(2, "Executing shell function %s" % func)
+
     try:
         bb.process.run(cmd, shell=False, stdin=NULL, log=logfile)
+
     except bb.process.CmdError:
         logfn = d.getVar('BB_LOGFILE', True)
-        raise FuncFailed(function, logfn)
+        raise FuncFailed(func, logfn)
+
+    bb.debug(2, "Shell function %s finished" % func)
+
 
 def _task_data(fn, task, d):
     localdata = data.createCopy(d)
-- 
1.7.3.4



