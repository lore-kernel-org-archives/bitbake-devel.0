Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8e-0003R5-Su
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:01 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbLBW009858
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:21 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:21 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:35 -0500
Message-ID: <1347921818-60562-6-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
References: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 5/8] knotty.py: update footer on dynamic log level change
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
X-List-Received-Date: Mon, 17 Sep 2012 22:50:01 -0000
Content-Type: text/plain

This patch adds a call to update the task list after changing log
modes dynamically such that you can immediately see the remaining
tasks.

(LOCAL REV: NOT UPSTREAM)

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index f7a770b..5882c24 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -179,6 +179,10 @@ class TerminalFilter(object):
             sys.stdout.write(self.curses.tparm(self.ed))
         self.footer_present = False
 
+    def updateFooterForce(self):
+        self.footer_present = False
+        self.updateFooter()
+
     def updateFooter(self):
         if not self.cuu:
             return
@@ -347,6 +351,8 @@ def main(server, eventHandler, tf = TerminalFilter):
             if stdin_mgr.poll():
                 keyinput = sys.stdin.read(1)
                 rtloglevel.setLevel(keyinput, True)
+                termfilter.updateFooterForce()
+
             # Always try printing any accumulated log files first
             rtloglevel.displayLogs()
             if event is None:
-- 
1.7.1



