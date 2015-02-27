Return-Path: <Rob.Woolley@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 431AF73745
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 14:32:28 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t1REWQlH009968
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 06:32:26 -0800 (PST)
Received: from yow-rwoolley-lx.wrs.com (128.224.146.40) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.174.1; Fri, 27 Feb 2015 06:32:26 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Feb 2015 09:32:22 -0500
Message-ID: <1425047544-4820-2-git-send-email-rob.woolley@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
References: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/3] knotty: Catch exceptions on broken pipes
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
X-List-Received-Date: Fri, 27 Feb 2015 14:32:28 -0000
Content-Type: text/plain

Any exceptions that occur in calls to logging methods are automatically 
suppressed, including exceptions due to broken pipes.

However, the knotty summary messages are printed directly to stdout, which
means that any broken pipes will cause an exception traceback in python.

By wrapping the summary section in a try / catch block we can check for
IOError exceptions caused by broken pipes and let them pass.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/bb/ui/knotty.py | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index ea20ddc..09a4e0c 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -536,24 +536,29 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if not params.observe_only:
                 _, error = server.runCommand(["stateForceShutdown"])
             main.shutdown = 2
-    summary = ""
-    if taskfailures:
-        summary += pluralise("\nSummary: %s task failed:",
-                             "\nSummary: %s tasks failed:", len(taskfailures))
-        for failure in taskfailures:
-            summary += "\n  %s" % failure
-    if warnings:
-        summary += pluralise("\nSummary: There was %s WARNING message shown.",
-                             "\nSummary: There were %s WARNING messages shown.", warnings)
-    if return_value and errors:
-        summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
-                             "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
-    if summary:
-        print(summary)
-
-    if interrupted:
-        print("Execution was interrupted, returning a non-zero exit code.")
-        if return_value == 0:
-            return_value = 1
+    try:
+         summary = ""
+         if taskfailures:
+             summary += pluralise("\nSummary: %s task failed:",
+                                  "\nSummary: %s tasks failed:", len(taskfailures))
+             for failure in taskfailures:
+                 summary += "\n  %s" % failure
+         if warnings:
+             summary += pluralise("\nSummary: There was %s WARNING message shown.",
+                                  "\nSummary: There were %s WARNING messages shown.", warnings)
+         if return_value and errors:
+             summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
+                                  "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
+         if summary:
+             print(summary)
+
+         if interrupted:
+             print("Execution was interrupted, returning a non-zero exit code.")
+             if return_value == 0:
+                 return_value = 1
+    except IOError as e:
+        import errno
+        if e.errno == errno.EPIPE:
+            pass
 
     return return_value
-- 
1.8.3.1


