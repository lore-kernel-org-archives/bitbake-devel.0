Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8f-0003RD-Tk
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:02 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbMOm009861
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:22 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:22 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:37 -0500
Message-ID: <1347921818-60562-8-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
References: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 7/8] knotty.py: Add ability to dynamically toggle log location
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
X-List-Received-Date: Mon, 17 Sep 2012 22:50:02 -0000
Content-Type: text/plain

Add the ability to see where all the per task logs
were written to disk.

The resulting output looks like where [...] is the full path:

NOTE: LOG: [...]/python-2.7.2-r2.20/temp/log.do_package_setscene.8719
NOTE: LOG: [...]/perl-5.14.2-r7/temp/log.do_package_setscene.8760

(LOCAL REV: NOT UPSTREAM)

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index df8de0f..2d58ebe 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -273,6 +273,7 @@ class StdinMgr:
 class RtLogLevel:
     def __init__(self, handler, logfilter, mlt, tf):
         self.displaytail = False
+        self.displayLogLocations = False
         self.handler = handler
         self.logfilter = logfilter
         self.defaultLevel = logfilter.getFiltLevel()
@@ -319,6 +320,14 @@ class RtLogLevel:
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
@@ -327,6 +336,7 @@ class RtLogLevel:
             print " 2 - turn on real time log tail"
             print " 3 - turn on debug logging"
             print " 4 - turn on debug logging and real time log tail"
+            print " l - emit log locations (L to turn off)"
             print " t - Display tasks in \"top\" mode"
             print " N - Display all runtime NOTE's that are normally filtered (0 or 1 toggles off)"
             print " h - display commands"
@@ -416,6 +426,9 @@ def main(server, eventHandler, tf = TerminalFilter):
                 continue
             helper.eventHandler(event)
             if isinstance(event, bb.build.TaskStarted):
+                if (rtloglevel.displayLogLocations):
+                    termfilter.clearFooter()
+                    print "NOTE: LOG: %s" % event.logfile
                 mlt.openLog(event.logfile, event.pid)
                 rtloglevel.displayLogs()
 
-- 
1.7.1



