Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4C12E6A5A2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 03:53:03 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r4T3r4gU019826
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 20:53:04 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 28 May 2013 20:53:04 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 May 2013 22:59:12 -0500
Message-ID: <1369799955-1488-4-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
In-Reply-To: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
References: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 4/7] knotty.py: update footer on dynamic log level change
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
X-List-Received-Date: Wed, 29 May 2013 03:53:04 -0000
Content-Type: text/plain

From: Jason Wessel <jason.wessel@windriver.com>

This patch adds a call to update the task list after changing log
modes dynamically such that you can immediately see the remaining
tasks.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 4f59e96..5020815 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -181,6 +181,10 @@ class TerminalFilter(object):
             sys.stdout.write(self.curses.tparm(self.ed))
         self.footer_present = False
 
+    def updateFooterForce(self):
+        self.footer_present = False
+        self.updateFooter()
+
     def updateFooter(self):
         if not self.cuu:
             return
@@ -370,6 +374,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if stdin_mgr.poll():
                 keyinput = sys.stdin.read(1)
                 rtloglevel.setLevel(keyinput, True)
+                termfilter.updateFooterForce()
+
             # Always try printing any accumulated log files first
             rtloglevel.displayLogs()
             if event is None:
-- 
1.8.1.2.545.g2f19ada


