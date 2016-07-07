Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5060E6013D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jul 2016 13:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u67DQZJb000323; Thu, 7 Jul 2016 14:26:35 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eQpeigtiyBI6; Thu,  7 Jul 2016 14:26:35 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u67DQY72000320
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Jul 2016 14:26:35 +0100
Message-ID: <1467897994.8590.223.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 07 Jul 2016 14:26:34 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "Eggleton, Paul" <paul.eggleton@intel.com>
Subject: [PATCH] knotty: Handle process indicators more gracefully
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
X-List-Received-Date: Thu, 07 Jul 2016 13:26:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Mistakes can happen with the generation of the progress events, change
knotty to be more tolerant of this rather than crashing, reporting to the
user when something unexpected happens. I haven't debugged why multiple
finish events appear to be triggered.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index dbcb9c4..e8e169f 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -496,13 +496,16 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 parseprogress = new_progress("Parsing recipes", event.total).start()
                 continue
             if isinstance(event, bb.event.ParseProgress):
-                parseprogress.update(event.current)
+                if parseprogress:
+                    parseprogress.update(event.current)
+                else:
+                    bb.warn("Got ParseProgress event for parsing that never started?")
                 continue
             if isinstance(event, bb.event.ParseCompleted):
                 if not parseprogress:
                     continue
-
                 parseprogress.finish()
+                pasreprogress = None
                 if not params.options.quiet:
                     print(("Parsing of %d .bb files complete (%d cached, %d parsed). %d targets, %d skipped, %d masked, %d errors."
                         % ( event.total, event.cached, event.parsed, event.virtuals, event.skipped, event.masked, event.errors)))
@@ -606,10 +609,15 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 parseprogress.start(False)
                 continue
             if isinstance(event, bb.event.ProcessProgress):
-                parseprogress.update(event.progress)
+                if parseprogress:
+                    parseprogress.update(event.progress)
+                else:
+                    bb.warn("Got ProcessProgress event for someting that never started?")
                 continue
             if isinstance(event, bb.event.ProcessFinished):
-                parseprogress.finish()
+                if parseprogress:
+                    parseprogress.finish()
+                parseprogress = None
                 continue
 
             # ignore



