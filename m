Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0FC786A5FC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 03:53:05 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r4T3r6Cv019829
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 20:53:06 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 28 May 2013 20:53:05 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 May 2013 22:59:14 -0500
Message-ID: <1369799955-1488-6-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
In-Reply-To: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
References: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 6/7] knotty.py: Add ability to dynamically toggle log location
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
X-List-Received-Date: Wed, 29 May 2013 03:53:05 -0000
Content-Type: text/plain

From: Jason Wessel <jason.wessel@windriver.com>

Add the ability to see where all the per task logs
were written to disk.

The resulting output looks like where [...] is the full path:

NOTE: LOG: [...]/python-2.7.2-r2.20/temp/log.do_package_setscene.8719
NOTE: LOG: [...]/perl-5.14.2-r7/temp/log.do_package_setscene.8760

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index d1ee534..b2fb141 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -278,6 +278,7 @@ class StdinMgr:
 class RtLogLevel:
     def __init__(self, handler, logfilter, mlt, tf):
         self.displaytail = False
+        self.displayLogLocations = False
         self.handler = handler
         self.logfilter = logfilter
         self.defaultLevel = logfilter.getFiltLevel()
@@ -324,6 +325,14 @@ class RtLogLevel:
                 print "NOTE: Turning on task notes"
             if isinstance(self.tf, TerminalFilter):
                 self.tf.setFilterOff()
+        elif input == "l":
+            if verbose:
+                print "NOTE: Activating log locations display"
+            self.displayLogLocations = True
+        elif input == "L":
+            if verbose:
+                print "NOTE: Disable log locations display"
+            self.displayLogLocations = False
         elif input == "h" or input == "?":
             print "============================================="
             print "Interaction help commands:"
@@ -332,6 +341,7 @@ class RtLogLevel:
             print " 2 - turn on real time log tail"
             print " 3 - turn on debug logging"
             print " 4 - turn on debug logging and real time log tail"
+            print " l - emit log locations (L to turn off)"
             print " t - Display tasks in \"top\" mode"
             print " N - Display all runtime NOTE's that are normally filtered (0 or 1 toggles off)"
             print " h - display commands"
@@ -442,6 +452,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
             helper.eventHandler(event)
             if isinstance(event, bb.build.TaskStarted):
+                if (rtloglevel.displayLogLocations):
+                    termfilter.clearFooter()
+                    print "NOTE: LOG: %s" % event.logfile
                 mlt.openLog(event.logfile, event.pid)
                 rtloglevel.displayLogs()
 
-- 
1.8.1.2.545.g2f19ada


