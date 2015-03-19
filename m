Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 731D565CD0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Mar 2015 05:27:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t2J5Rbp4025191
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Mar 2015 22:27:37 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.224.2;
	Wed, 18 Mar 2015 22:27:37 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Mar 2015 22:27:36 -0700
Message-ID: <14179a7ea551daae0fe184c707918e7d9c3d93c3.1426742824.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1426742824.git.liezhi.yang@windriver.com>
References: <cover.1426742824.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] knotty.py: fix indent
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
X-List-Received-Date: Thu, 19 Mar 2015 05:27:36 -0000
Content-Type: text/plain

It used 5 spaces as the indent.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/ui/knotty.py |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index df0b854..2bee242 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -537,25 +537,25 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 _, error = server.runCommand(["stateForceShutdown"])
             main.shutdown = 2
     try:
-         summary = ""
-         if taskfailures:
-             summary += pluralise("\nSummary: %s task failed:",
-                                  "\nSummary: %s tasks failed:", len(taskfailures))
-             for failure in taskfailures:
-                 summary += "\n  %s" % failure
-         if warnings:
-             summary += pluralise("\nSummary: There was %s WARNING message shown.",
-                                  "\nSummary: There were %s WARNING messages shown.", warnings)
-         if return_value and errors:
-             summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
-                                  "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
-         if summary:
-             print(summary)
-
-         if interrupted:
-             print("Execution was interrupted, returning a non-zero exit code.")
-             if return_value == 0:
-                 return_value = 1
+        summary = ""
+        if taskfailures:
+            summary += pluralise("\nSummary: %s task failed:",
+                                 "\nSummary: %s tasks failed:", len(taskfailures))
+            for failure in taskfailures:
+                summary += "\n  %s" % failure
+        if warnings:
+            summary += pluralise("\nSummary: There was %s WARNING message shown.",
+                                 "\nSummary: There were %s WARNING messages shown.", warnings)
+        if return_value and errors:
+            summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
+                                 "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
+        if summary:
+            print(summary)
+
+        if interrupted:
+            print("Execution was interrupted, returning a non-zero exit code.")
+            if return_value == 0:
+                return_value = 1
     except IOError as e:
         import errno
         if e.errno == errno.EPIPE:
-- 
1.7.9.5


