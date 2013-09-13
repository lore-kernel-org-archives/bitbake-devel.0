Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 0CA4360FDF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 16:34:15 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DGm7Pe005191 for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:48:07 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7y1YzLzUwVKP for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:48:07 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DGm53x005165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:48:06 +0100
Message-ID: <1379090046.3484.276.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 13 Sep 2013 17:34:06 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Cleanup error/interruption handling
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
X-List-Received-Date: Fri, 13 Sep 2013 16:34:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Only display a CommandFailed ERROR: message if there is an error to display.

Only display an errors summary if we actually displayed errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index f706b97..35590a2 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -405,8 +405,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             if isinstance(event, bb.command.CommandFailed):
                 return_value = event.exitcode
-                errors = errors + 1
-                logger.error("Command execution failed: %s", event.error)
+                if event.error:
+                    errors = errors + 1
+                    logger.error("Command execution failed: %s", event.error)
                 main.shutdown = 2
                 continue
             if isinstance(event, bb.command.CommandExit):
@@ -520,7 +521,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     if warnings:
         summary += pluralise("\nSummary: There was %s WARNING message shown.",
                              "\nSummary: There were %s WARNING messages shown.", warnings)
-    if return_value:
+    if return_value and errors:
         summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
                              "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
     if summary:



