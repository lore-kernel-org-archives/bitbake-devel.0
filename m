Return-Path: <Rob.Woolley@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id CAE3777F70
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jun 2017 02:24:20 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v5T2ODoR021717
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 28 Jun 2017 19:24:13 -0700 (PDT)
Received: from ala-lpggp2.wrs.com (147.11.105.123) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 28 Jun 2017 19:24:13 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 28 Jun 2017 19:24:11 -0700
Message-ID: <20170629022411.57685-2-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170629022411.57685-1-rob.woolley@windriver.com>
References: <20170629022411.57685-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com
Subject: [PATCH] knotty: Add automatic paging for bitbake -s and -e
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
X-List-Received-Date: Thu, 29 Jun 2017 02:24:21 -0000
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

A custom logging handler was added for Python 3 to ensure that the data
going into the subprocess pipe was utf-8 encoded.  Without this encoding
no data is displayed by the subprocess.

Pagers tested include: less, more, cat, more, lv, and vim less.sh

[ YOCTO #9203 ]

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/bb/ui/knotty.py | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index a19c3b3b..d3587435 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -32,6 +32,7 @@ import fcntl
 import struct
 import copy
 import atexit
+import subprocess
 
 from bb.ui import uihelper
 
@@ -40,6 +41,22 @@ featureSet = [bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
 logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
 
+class UnicodeStreamHandler(logging.StreamHandler):
+    terminator = '\n'
+
+    def __init__(self, stream=None):
+        super().__init__(stream)
+
+    def emit(self, record):
+        try:
+            msg = self.format(record).encode('utf-8')
+            stream = self.stream
+            stream.write(msg)
+            stream.write(self.terminator.encode('utf-8'))
+            self.flush()
+        except Exception:
+            self.handleError(record)
+
 class BBProgress(progressbar.ProgressBar):
     def __init__(self, msg, maxval, widgets=None, extrapos=-1, resize_handler=None):
         self.msg = msg
@@ -166,7 +183,7 @@ class TerminalFilter(object):
         self.helper = helper
         self.cuu = None
         self.stdinbackup = None
-        self.interactive = sys.stdout.isatty()
+        self.interactive = console.stream.isatty()
         self.footer_present = False
         self.lastpids = []
         self.lasttime = None
@@ -351,8 +368,43 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
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
+        pager_process = subprocess.Popen(pager_bin, stdin=subprocess.PIPE, stdout=sys.stdout)
+        console = UnicodeStreamHandler(pager_process.stdin)
+        errconsole = UnicodeStreamHandler(pager_process.stdin)
+        console.setLevel(logging.DEBUG)
+    else:
+        console = logging.StreamHandler(sys.stdout)
+        errconsole = logging.StreamHandler(sys.stderr)
+
     format_str = "%(levelname)s: %(message)s"
     format = bb.msg.BBLogFormatter(format_str)
     if params.options.quiet == 0:
@@ -711,6 +763,14 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 _, error = server.runCommand(["stateForceShutdown"])
             main.shutdown = 2
             return_value = 1
+
+    if pager_process:
+        try:
+            pager_process.stdin.close()
+            pager_process.wait()
+        except(BrokenPipeError, IOError):
+            pass
+
     try:
         termfilter.clearFooter()
         summary = ""
-- 
2.11.0


