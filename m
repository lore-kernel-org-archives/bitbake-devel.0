Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2B9F27A286
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 07:49:41 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w917nGMH013748
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 1 Oct 2018 00:49:32 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 1 Oct 2018 00:49:08 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 1 Oct 2018 00:45:55 -0700
Message-ID: <5ddf5de38bf0115a35f1d70ab7ce449d0dfc52d8.1538379577.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1538379577.git.David.Reyna@windriver.com>
References: <cover.1538379577.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 1/3] toaster: error logs missing for cli builds
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
X-List-Received-Date: Mon, 01 Oct 2018 07:49:41 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The method 'store_log_event' in 'buildinfohelper.py' always puts log
messages from CLI builds into the backlog but never takes them out.
The "close" method now forces all backlogged CLI events to be registered.

[YOCTO #12813]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/bb/ui/buildinfohelper.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 524a5b0..31323d2 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1603,14 +1603,14 @@ class BuildInfoHelper(object):
         mockevent.lineno = -1
         self.store_log_event(mockevent)
 
-    def store_log_event(self, event):
+    def store_log_event(self, event,cli_backlog=True):
         self._ensure_build()
 
         if event.levelno < formatter.WARNING:
             return
 
         # early return for CLI builds
-        if self.brbe is None:
+        if cli_backlog and self.brbe is None:
             if not 'backlog' in self.internal_state:
                 self.internal_state['backlog'] = []
             self.internal_state['backlog'].append(event)
@@ -1622,7 +1622,7 @@ class BuildInfoHelper(object):
                 tempevent = self.internal_state['backlog'].pop()
                 logger.debug(1, "buildinfohelper: Saving stored event %s "
                              % tempevent)
-                self.store_log_event(tempevent)
+                self.store_log_event(tempevent,cli_backlog)
             else:
                 logger.info("buildinfohelper: All events saved")
                 del self.internal_state['backlog']
@@ -1987,7 +1987,8 @@ class BuildInfoHelper(object):
         if 'backlog' in self.internal_state:
             # we save missed events in the database for the current build
             tempevent = self.internal_state['backlog'].pop()
-            self.store_log_event(tempevent)
+            # Do not skip command line build events
+            self.store_log_event(tempevent,False)
 
         if not connection.features.autocommits_when_autocommit_is_off:
             transaction.set_autocommit(True)
-- 
1.9.1


