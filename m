Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id D920D65DB0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 14:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id C016C2E383
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ZJX3eD8ODqIH for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 8474D2E38A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 64852CE0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 599F3AC6
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 575D83E048
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id s38E9dYa003265
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Apr 2014 16:09:39 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id s38E9dAd003264
	for bitbake-devel@lists.openembedded.org; Tue, 8 Apr 2014 16:09:39 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Apr 2014 16:09:34 +0200
Message-Id: <ab27b6a57259d7b4d3a55d1b6e662b3a2679ceb5.1396966113.git.pkj@axis.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396966113.git.pkj@axis.com>
References: <cover.1396966113.git.pkj@axis.com>
In-Reply-To: <cover.1396966113.git.pkj@axis.com>
References: <cover.1396966113.git.pkj@axis.com>
Subject: [PATCH 1/1] bitbake: knotty: Clear footer before outputting to stderr
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
X-List-Received-Date: Tue, 08 Apr 2014 14:09:45 -0000

With the recent change to split the log output to stdout and stderr,
error messages that appeared while the footer was printed got all
messed up. This was because the messages to stderr was output _after_
the footer, then clearFooter() tried to remove the footer but removed
the error message and parts of the footer.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 80a4b32..41f1ba8 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -133,7 +133,7 @@ class TerminalFilter(object):
                 cr = (25, 80)
         return cr[1]
 
-    def __init__(self, main, helper, console, format):
+    def __init__(self, main, helper, console, errconsole, format):
         self.main = main
         self.helper = helper
         self.cuu = None
@@ -174,6 +174,7 @@ class TerminalFilter(object):
         except:
             self.cuu = None
         console.addFilter(InteractConsoleLogFilter(self, format))
+        errconsole.addFilter(InteractConsoleLogFilter(self, format))
 
     def clearFooter(self):
         if self.footer_present:
@@ -309,7 +310,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     warnings = 0
     taskfailures = []
 
-    termfilter = tf(main, helper, console, format)
+    termfilter = tf(main, helper, console, errconsole, format)
     atexit.register(termfilter.finish)
 
     while True:
-- 
1.9.0


