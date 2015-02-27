Return-Path: <Rob.Woolley@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 78D6473745
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 14:32:26 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t1REWRoj009971
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 06:32:27 -0800 (PST)
Received: from yow-rwoolley-lx.wrs.com (128.224.146.40) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.174.1; Fri, 27 Feb 2015 06:32:27 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Feb 2015 09:32:24 -0500
Message-ID: <1425047544-4820-4-git-send-email-rob.woolley@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
References: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/3] knotty: Add automatic paging for bitbake -s and -e
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
X-List-Received-Date: Fri, 27 Feb 2015 14:32:27 -0000
Content-Type: text/plain

The bitbake show environment and show versions commands provide a
large volume of output to the user.  The knotty user interface changes
the output it provides based on whether it detects a TTY.

By checking for the presense of a TTY, we can automatically pipe
the output to a child process that pages the output for the user.
The logic for the automatic paging is based on pager.c found in git.

Some users may have a preferred pager already set in the PAGER
environment variable.  If it is set, found in PATH, and executable
then we use the user's preferred pager.  If it is set to "cat", then
paging is disabled.  If no pager is set, then we set it to "less" as
the default.

The LESS and LV environment variables are also set with sane defaults
in the event that either of these pagers are used.

We cleanly close the pipe before the summary message is displayed.  This 
is done intentionally so that the user does not miss any of the summary 
information if they close the pipe early.

Tested with both bitbake -s and -e with and without an explicit pipe
to a pager.  This includes testing broken pipe conditions caused by 
quitting the pager before the full output has been sent through the pipe.

Pagers tested include: less, more, cat, more, lv, and vim less.sh

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/bb/ui/knotty.py | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

Index: b/lib/bb/ui/knotty.py
===================================================================
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -32,6 +32,7 @@ import fcntl
 import struct
 import copy
 import atexit
+import subprocess
 from bb.ui import uihelper
 
 featureSet = [bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
@@ -138,7 +139,7 @@ class TerminalFilter(object):
         self.helper = helper
         self.cuu = None
         self.stdinbackup = None
-        self.interactive = sys.stdout.isatty()
+        self.interactive = console.stream.isatty()
         self.footer_present = False
         self.lastpids = []
 
@@ -256,8 +257,42 @@ def main(server, eventHandler, params, t
 
     helper = uihelper.BBUIHelper()
 
-    console = logging.StreamHandler(sys.stdout)
-    errconsole = logging.StreamHandler(sys.stderr)
+    pager_bin = None
+    pager_process = None
+
+    if (os.getenv("PAGER")):
+        pager_bin = os.getenv("PAGER")
+    else:
+        pager_bin = "less"
+
+    if pager_bin == "cat":
+        pager_bin = None
+
+    if pager_bin and (not os.path.isfile(pager_bin) or not os.access(pager_bin, os.X_OK)):
+        found_pager = False
+        for path in os.environ["PATH"].split(os.pathsep):
+             pager_path = os.path.join(path,pager_bin)
+             if os.path.isfile(pager_path) and os.access(pager_path, os.X_OK):
+                 found_pager = True
+                 break
+
+        if not found_pager:
+            pager_bin = None
+
+    if (os.getenv("LESS") == None):
+        os.environ['LESS'] = 'FRX'
+
+    if (os.getenv("LV") == None):
+        os.environ['LV'] = '-c'
+
+    if interactive and pager_bin and (params.options.show_versions or params.options.show_environment):
+        pager_process = subprocess.Popen(pager_bin, stdin=subprocess.PIPE)
+        console = logging.StreamHandler(pager_process.stdin)
+        errconsole = logging.StreamHandler(pager_process.stdin)
+    else:
+        console = logging.StreamHandler(sys.stdout)
+        errconsole = logging.StreamHandler(sys.stderr)
+
     format_str = "%(levelname)s: %(message)s"
     format = bb.msg.BBLogFormatter(format_str)
     bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut)
@@ -536,6 +571,11 @@ def main(server, eventHandler, params, t
             if not params.observe_only:
                 _, error = server.runCommand(["stateForceShutdown"])
             main.shutdown = 2
+
+    if pager_process:
+        pager_process.stdin.close()
+        pager_process.wait()
+
     try:
          summary = ""
          if taskfailures:

