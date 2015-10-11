Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 64AAA757AC
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 15:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9BF2n2o024602; Sun, 11 Oct 2015 16:02:49 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id U6EqfJn2v5T5; Sun, 11 Oct 2015 16:02:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9BF2Ugx024522
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 11 Oct 2015 16:02:44 +0100
Message-ID: <1444554762.14364.15.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Smith, Elliot" <elliot.smith@intel.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Sun, 11 Oct 2015 10:12:42 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.12.11-0ubuntu3 
Subject: [PATCH] bb/ui: Use getSetVariable command for BB_CONSOLELOG
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
X-List-Received-Date: Sun, 11 Oct 2015 15:02:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Metadata can define BB_CONSOLELOG as containing ${DATETIME} and
this can get expanded to a different value each time the variable
is read. In the case of BB_CONSOLELOG, this behaviour is not
desireable.

The values of DATE/TIME are locked down at build time but this is too
late for the purposes of ensuring the system can figure out the real
value of BB_CONSOLELOG.

The best way to do this is to set the variable into the datastore, thereby
preserving its value.

[YOCTO #8411]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/ui/knotty.py    | 2 +-
 bitbake/lib/bb/ui/toasterui.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index b96249a..1ecf1aa 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -246,7 +246,7 @@ def _log_settings_from_server(server):
     if error:
         logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
         raise BaseException(error)
-    consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
+    consolelogfile, error = server.runCommand(["getSetVariable", "BB_CONSOLELOG"])
     if error:
         logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
         raise BaseException(error)
diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index f30f89e..8d4cad6 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -58,7 +58,7 @@ def _log_settings_from_server(server):
     if error:
         logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
         raise BaseException(error)
-    consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
+    consolelogfile, error = server.runCommand(["getSetVariable", "BB_CONSOLELOG"])
     if error:
         logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
         raise BaseException(error)



