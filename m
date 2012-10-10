Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TM4iA-0000cy-0m
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Oct 2012 00:25:06 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q9AMBthh002728
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Oct 2012 15:11:55 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 10 Oct 2012 15:11:55 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 10 Oct 2012 17:11:54 -0500
Message-ID: <686b0589fc837fda588809544d71d9a4b9d041e8.1349907036.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1349907036.git.peter.seebach@windriver.com>
References: <cover.1349907036.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] build.py: Provide useful diagnostics when exiting.
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
X-List-Received-Date: Wed, 10 Oct 2012 22:25:06 -0000
Content-Type: text/plain

Running scripts with 'set -e' produces silent failures with no
diagnostic. Add an exit handler which produces diagnostics, including
details of what was running if the shell seems to be bash.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/build.py |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 85af42c..f65c415 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -249,7 +249,23 @@ def exec_func_shell(func, d, runfile, cwd=None):
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
+        *)    echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from
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
@@ -257,6 +273,12 @@ def exec_func_shell(func, d, runfile, cwd=None):
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
1.7.0.4



