Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SXDqY-0007vU-Tq
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 17:51:35 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4NFfOMk004522
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 May 2012 08:41:24 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Wed, 23 May 2012 08:41:24 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 23 May 2012 10:45:11 -0500
Message-ID: <1337787916-591-3-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1337714416.git.mark.hatle@windriver.com>
References: <cover.1337714416.git.mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 3/4] build.py: Add additional debug messages
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
X-List-Received-Date: Wed, 23 May 2012 15:51:36 -0000
Content-Type: text/plain

We now add a debug message when entering and exiting a python or
shell function.  This makes it easier to inspect a log and figure
out the run order from the logs.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/build.py |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 9f2c6a7..363aced 100644
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
@@ -215,6 +217,8 @@ def exec_func_python(func, d, runfile, cwd=None):
 
         raise FuncFailed(func, None)
     finally:
+        bb.debug(2, "Python function %s finished" % func)
+
         if cwd and olddir:
             try:
                 os.chdir(olddir)
@@ -255,12 +259,16 @@ def exec_func_shell(func, d, runfile, cwd=None):
     else:
         logfile = sys.stdout
 
+    bb.debug(2, "Executing shell function %s" % func)
+
     try:
         bb.process.run(cmd, shell=False, stdin=NULL, log=logfile)
     except bb.process.CmdError:
         logfn = d.getVar('BB_LOGFILE', True)
         raise FuncFailed(func, logfn)
 
+    bb.debug(2, "Shell function %s finished" % func)
+
 def _task_data(fn, task, d):
     localdata = data.createCopy(d)
     localdata.setVar('BB_FILENAME', fn)
-- 
1.7.3.4



