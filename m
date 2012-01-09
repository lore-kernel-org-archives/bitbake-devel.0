Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RkIhy-0006aW-BG for bitbake-devel@lists.openembedded.org;
	Mon, 09 Jan 2012 18:08:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q09H10Kt030927
	for <bitbake-devel@lists.openembedded.org>; Mon, 9 Jan 2012 17:01:00 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30593-02 for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Jan 2012 17:00:54 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q09H0oMQ030920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Mon, 9 Jan 2012 17:00:51 GMT
Message-ID: <1326128453.9278.23.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 09 Jan 2012 17:00:53 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/knotty: Show summary of warning/error messages shown
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
X-List-Received-Date: Mon, 09 Jan 2012 17:08:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Show a summary count of warning/errors messages shown to the user during the
build and make it clear when an error exit code is being set.

[YOCTO #1540]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 38acb47..0340619 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -105,6 +105,8 @@ def main(server, eventHandler):
     cacheprogress = None
     shutdown = 0
     return_value = 0
+    errors = 0
+    warnings = 0
     while True:
         try:
             event = eventHandler.waitEvent(0.25)
@@ -123,13 +125,15 @@ def main(server, eventHandler):
 
             if isinstance(event, logging.LogRecord):
                 if event.levelno >= format.ERROR:
+                    errors = errors + 1
                     return_value = 1
+                if event.levelno >= format.WARNING:
+                    warnings = warnings + 1
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to 
                 # include verbose/debug messages
-                #if logger.getEffectiveLevel() > format.VERBOSE:
                 if event.taskpid != 0 and event.levelno <= format.NOTE:
-                        continue
+                    continue
                 logger.handle(event)
                 continue
 
@@ -208,6 +212,7 @@ def main(server, eventHandler):
                 continue
             if isinstance(event, bb.event.NoProvider):
                 return_value = 1
+                errors = errors + 1
                 if event._runtime:
                     r = "R"
                 else:
@@ -267,4 +272,8 @@ def main(server, eventHandler):
                 server.runCommand(["stateShutdown"])
             shutdown = shutdown + 1
             pass
+    if warnings:
+        print("Summary: There were %s WARNING messages shown.\n" % warnings)
+    if return_value:
+        print("Summary: There were %s ERROR messages shown, returning a non-zero exit code.\n" % errors)
     return return_value




