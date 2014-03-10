Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 31A6D6F64C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:56:34 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2A0uURR027995 for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:56:30 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1VPY7bhkNeNT for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:56:30 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2A0uOnj027982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:56:28 GMT
Message-ID: <1394412978.7883.17.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 17:56:18 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Add missing continue statement for runQueueExitWait event
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
X-List-Received-Date: Mon, 10 Mar 2014 00:56:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The continue statement was missing for this event and the event was then
listed in the "known safe to ignore list". Clean this up.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 3dada8e..14bdb37 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -320,7 +320,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.runqueue.runQueueExitWait):
                 if not main.shutdown:
                     main.shutdown = 1
-
+                continue
             if isinstance(event, bb.event.LogExecTTY):
                 if log_exec_tty:
                     tries = event.retries
@@ -485,7 +485,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.event.RecipeParsed,
                                   bb.event.RecipePreFinalise,
                                   bb.runqueue.runQueueEvent,
-                                  bb.runqueue.runQueueExitWait,
                                   bb.event.OperationStarted,
                                   bb.event.OperationCompleted,
                                   bb.event.OperationProgress,



