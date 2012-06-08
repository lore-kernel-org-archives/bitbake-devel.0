Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdJ-0004e4-95
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:45 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q58DhFi6023978
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:15 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:14 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:47 -0500
Message-ID: <1339162913-23759-13-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 12/18] knotty: Add ability to dynamically toggle log location
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:45 -0000
Content-Type: text/plain

Add the ability to see where all the per task logs
were written to disk.

The resulting output looks like where [...] is the full path:

NOTE: LOG: [...]/python-2.7.2-r2.20/temp/log.do_package_setscene.8719
NOTE: LOG: [...]/perl-5.14.2-r7/temp/log.do_package_setscene.8760

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 765ad27..e485c7e 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -253,6 +253,7 @@ class StdinMgr:
 class RtLogLevel:
     def __init__(self, handler, logfilter, mlt, tf):
         self.displaytail = False
+        self.displayLogLocations = False
         self.handler = handler
         self.logfilter = logfilter
         self.defaultLevel = logfilter.getFiltLevel()
@@ -291,6 +292,14 @@ class RtLogLevel:
                 print "NOTE: Activing task \"top\" mode"
             if isinstance(self.tf, TerminalFilter):
                 self.tf.setTopMode()
+        elif input == "l":
+            if verbose:
+                print "NOTE: Activating log locations display"
+            self.displayLogLocations = True
+        elif input == "L":
+            if verbose:
+                print "NOTE: Disable log locations display"
+            self.displayLogLocations = False
         elif input == "h":
             print "============================================="
             print "Interaction help commands:"
@@ -300,6 +309,7 @@ class RtLogLevel:
             print " 3 - turn on debug logging"
             print " 4 - turn on debug logging and real time log tail"
             print " t - Display tasks in \"top\" mode (formerly knotty2 mode)"
+            print " l - emit log locations (L to turn off)"
             print " h - display commands"
             return False
         return True
@@ -387,6 +397,9 @@ def main(server, eventHandler, tf = TerminalFilter):
                 continue
             helper.eventHandler(event)
             if isinstance(event, bb.build.TaskStarted):
+                if (rtloglevel.displayLogLocations):
+                    termfilter.clearFooter()
+                    print "NOTE: LOG: %s" % event.logfile
                 mlt.openLog(event.logfile, event.pid)
                 rtloglevel.displayLogs()
 
-- 
1.7.10



