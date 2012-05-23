Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SXDqY-0007vP-BJ
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 17:51:34 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4NFfOr6004519
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 May 2012 08:41:24 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Wed, 23 May 2012 08:41:23 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 23 May 2012 10:45:10 -0500
Message-ID: <1337787916-591-2-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1337714416.git.mark.hatle@windriver.com>
References: <cover.1337714416.git.mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 2/4] build.py: Cleanup exec_func_shell
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
X-List-Received-Date: Wed, 23 May 2012 15:51:34 -0000
Content-Type: text/plain

exec_func_python and exec_func_shell are similar, but variable
usage has diverged sync the two up.  Since exec_func_python is first
use that as the guide for the later exec_func_shell variable naming.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/build.py |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 4f06b15..9f2c6a7 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -221,7 +221,7 @@ def exec_func_python(func, d, runfile, cwd=None):
             except OSError:
                 pass
 
-def exec_func_shell(function, d, runfile, cwd=None):
+def exec_func_shell(func, d, runfile, cwd=None):
     """Execute a shell function from the metadata
 
     Note on directory behavior.  The 'dirs' varflag should contain a list
@@ -234,18 +234,18 @@ def exec_func_shell(function, d, runfile, cwd=None):
 
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
@@ -259,7 +259,7 @@ def exec_func_shell(function, d, runfile, cwd=None):
         bb.process.run(cmd, shell=False, stdin=NULL, log=logfile)
     except bb.process.CmdError:
         logfn = d.getVar('BB_LOGFILE', True)
-        raise FuncFailed(function, logfn)
+        raise FuncFailed(func, logfn)
 
 def _task_data(fn, task, d):
     localdata = data.createCopy(d)
-- 
1.7.3.4



