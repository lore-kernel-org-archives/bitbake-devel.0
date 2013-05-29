Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 45CC76A57A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 03:53:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r4T3rvWC019879
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 20:53:57 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 28 May 2013 20:53:57 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 May 2013 23:00:10 -0500
Message-ID: <1369800010-1541-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH] build.py: Provide useful diagnostics when exiting.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 May 2013 03:53:56 -0000
Content-Type: text/plain

From: Peter Seebach <peter.seebach@windriver.com>

Running scripts with 'set -e' produces silent failures with no
diagnostic. Add an exit handler which produces diagnostics, including
details of what was running if the shell seems to be bash.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
Signed-off-by: Randy MacLeod <Randy.MacLeod@windriver.com>
---
 lib/bb/build.py | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 725eb02..dae6d92 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -254,7 +254,23 @@ def exec_func_shell(func, d, runfile, cwd=None):
     d.delVarFlag('PWD', 'export')
 
     with open(runfile, 'w') as script:
-        script.write('#!/bin/sh -e\n')
+        script.write('''#!/bin/sh\n
+# Emit a useful diagnostic if something fails:
+bb_exit_handler() {
+    ret=$?
+    case $ret in
+    0)  ;;
+    *)  case $BASH_VERSION in
+        "")   echo "WARNING: exit code $ret from a shell command.";;
+        *)    echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[1]} exit $ret from
+  \"$BASH_COMMAND\"";;
+        esac
+        exit $ret
+    esac
+}
+trap 'bb_exit_handler' 0
+set -e
+''')
         data.emit_func(func, script, d)
 
         if bb.msg.loggerVerboseLogs:
@@ -262,6 +278,12 @@ def exec_func_shell(func, d, runfile, cwd=None):
         if cwd:
             script.write("cd %s\n" % cwd)
         script.write("%s\n" % func)
+        script.write('''
+# cleanup
+ret=$?
+trap '' 0
+exit $?
+''')
 
     os.chmod(runfile, 0775)
 
-- 
1.8.1.2.545.g2f19ada


