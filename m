Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7755B62134
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jan 2016 13:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0VDNJtH015821; Sun, 31 Jan 2016 13:23:19 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OqtvEzXiZcoD; Sun, 31 Jan 2016 13:23:19 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0VDNCBB015818
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 31 Jan 2016 13:23:13 GMT
Message-ID: <1454246592.27087.14.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 31 Jan 2016 13:23:12 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH] knotty: Don't show errors for universe provider issues
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
X-List-Received-Date: Sun, 31 Jan 2016 13:23:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When running universe builds, we don't expect an error exit code for
provider warnings. Change the error messages to warnings in this case.

This deals with errors causing problems on our autobuilders amongst 
other issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 3f2b77b..9e71b1c 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -289,6 +289,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     llevel, debug_domains = bb.msg.constructLogOptions()
     server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
 
+    universe = False
     if not params.observe_only:
         params.updateFromServer(server)
         params.updateToServer(server, os.environ.copy())
@@ -299,6 +300,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if 'msg' in cmdline and cmdline['msg']:
             logger.error(cmdline['msg'])
             return 1
+        if cmdline['action'][0] == "buildTargets" and "universe" in cmdline['action'][1]:
+            universe = True
 
         ret, error = server.runCommand(cmdline['action'])
         if error:
@@ -456,13 +459,18 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     if event._close_matches:
                         extra = ". Close matches:\n  %s" % '\n  '.join(event._close_matches)
 
+                # For universe builds, only show these as warnings, not errors
+                h = logger.error
+                if universe:
+                    h = logger.warning
+
                 if event._dependees:
-                    logger.error("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s", r, event._item, ", ".join(event._dependees), r, extra)
+                    h("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s", r, event._item, ", ".join(event._dependees), r, extra)
                 else:
-                    logger.error("Nothing %sPROVIDES '%s'%s", r, event._item, extra)
+                    h("Nothing %sPROVIDES '%s'%s", r, event._item, extra)
                 if event._reasons:
                     for reason in event._reasons:
-                        logger.error("%s", reason)
+                        h("%s", reason)
                 continue
 
             if isinstance(event, bb.runqueue.sceneQueueTaskStarted):



