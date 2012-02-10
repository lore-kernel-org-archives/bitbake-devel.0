Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RvvC5-0003OV-OE
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Feb 2012 19:27:37 +0100
Received: by ggeq1 with SMTP id q1so1620896gge.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Feb 2012 10:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references;
	bh=n3NGkRPxxRNS62oAEThG9NjgwyO2oIDCQlsa2Xa1Ibk=;
	b=xHGXeS5D6zx/bzGDORExBJry0uG7swWl2Zf7wxF0clMSphonC5mMfGiy0RHdb0biaw
	le3Zu5+HbbLZ1dxEzN16jXW47ezJvQRYEPD4bpycRztXCq8jXSL92ajxgBSbiPVDL5MG
	qhBA3bDYPeuPkrYShwh6h8wzCRRMbXi5YM3vU=
Received: by 10.236.9.33 with SMTP id 21mr10314625yhs.39.1328897971408;
	Fri, 10 Feb 2012 10:19:31 -0800 (PST)
Received: from localhost.localdomain (hsvwanfw1-nat.mentorg.com.
	[139.181.24.34])
	by mx.google.com with ESMTPS id 34sm15352384anp.13.2012.02.10.10.19.30
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 10 Feb 2012 10:19:30 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Feb 2012 12:19:23 -0600
Message-Id: <ce9e0946b8a412616074809c76fba54f8bff36c4.1328897859.git.chris_larson@mentor.com>
X-Mailer: git-send-email 1.7.7
In-Reply-To: <cover.1328897859.git.chris_larson@mentor.com>
References: <cover.1328897859.git.chris_larson@mentor.com>
In-Reply-To: <cover.1328897859.git.chris_larson@mentor.com>
References: <cover.1328897859.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/2] knotty: shut down more cleanly
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
X-List-Received-Date: Fri, 10 Feb 2012 18:27:37 -0000

From: Christopher Larson <chris_larson@mentor.com>

This ensures that when we are shutting down, we drain the queue of events from
the server. This ensures that the server never gets hung up on the join of the
feeder thread associated with the event queue, thereby avoiding a bitbake hang
issue.

Also, since the third keyboard interrupt now behaves the same as the second,
removed that message.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/ui/knotty.py |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index e1d42f7..22370ef 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -118,6 +118,8 @@ def main(server, eventHandler):
         try:
             event = eventHandler.waitEvent(0.25)
             if event is None:
+                if shutdown > 1:
+                    break
                 continue
             helper.eventHandler(event)
             if isinstance(event, bb.runqueue.runQueueExitWait):
@@ -199,18 +201,18 @@ def main(server, eventHandler):
                 print("Loaded %d entries from dependency cache." % event.num_entries)
                 continue
 
-            if isinstance(event, bb.command.CommandCompleted):
-                break
             if isinstance(event, bb.command.CommandFailed):
                 return_value = event.exitcode
                 logger.error("Command execution failed: %s", event.error)
-                break
+                shutdown = 2
+                continue
             if isinstance(event, bb.command.CommandExit):
                 if not return_value:
                     return_value = event.exitcode
                 continue
-            if isinstance(event, bb.cooker.CookerExit):
-                break
+            if isinstance(event, (bb.command.CommandCompleted, bb.cooker.CookerExit)):
+                shutdown = 2
+                continue
             if isinstance(event, bb.event.MultipleProviders):
                 logger.info("multiple providers are available for %s%s (%s)", event._is_runtime and "runtime " or "",
                             event._item,
@@ -269,9 +271,6 @@ def main(server, eventHandler):
             if ioerror.args[0] == 4:
                 pass
         except KeyboardInterrupt:
-            if shutdown == 2:
-                print("\nThird Keyboard Interrupt, exit.\n")
-                break
             if shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
                 server.runCommand(["stateStop"])
-- 
1.7.7



