Return-Path: <namhyung@gmail.com>
X-Greylist: delayed 898 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 30 Jul 2014 02:16:44 UTC
Received: from lgeamrelo04.lge.com (lgeamrelo04.lge.com [156.147.1.127])
	by mail.openembedded.org (Postfix) with ESMTP id EE1F3701BF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Jul 2014 02:16:44 +0000 (UTC)
Received: from unknown (HELO sejong.aot.lge.com) (10.177.220.181)
	by 156.147.1.127 with ESMTP; 30 Jul 2014 11:01:45 +0900
X-Original-SENDERIP: 10.177.220.181
X-Original-MAILFROM: namhyung@gmail.com
From: Namhyung Kim <namhyung@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 Jul 2014 11:01:45 +0900
Message-Id: <1406685705-8517-1-git-send-email-namhyung@gmail.com>
X-Mailer: git-send-email 2.0.0
Subject: [PATCH] knotty: Move second event check into a proper block
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
X-List-Received-Date: Wed, 30 Jul 2014 02:16:54 -0000

so that it doesn't check it twice for non-empty events

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 lib/bb/ui/knotty.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 77a7082..746dcf4 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -321,8 +321,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     break
                 termfilter.updateFooter()
                 event = eventHandler.waitEvent(0.25)
-            if event is None:
-                continue
+                if event is None:
+                    continue
             helper.eventHandler(event)
             if isinstance(event, bb.runqueue.runQueueExitWait):
                 if not main.shutdown:
-- 
2.0.0


