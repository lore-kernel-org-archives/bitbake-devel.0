Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EDDA477DCC
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jul 2017 15:03:05 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v67F34s2007900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 7 Jul 2017 16:03:05 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dTUme-0007gr-EU; Fri, 07 Jul 2017 16:03:04 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Jul 2017 16:03:03 +0100
Message-Id: <1499439783-29523-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 07 Jul 2017 16:03:05 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] knotty: Drop task prefix of PLAIN log messages
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
X-List-Received-Date: Fri, 07 Jul 2017 15:03:06 -0000

To quote Paul:

Not that long ago we added a prefix to logged messages to allow us to see
where the message has been generated (recipe / task). This is undoubtedly
useful for errors and warnings, however, I'm not sure it's really appropriate
for bb.plain(). As an example, see the output for -c listtasks now:

...
NOTE: Executing RunQueue Tasks
nodejs-native-4.5.0-r0 do_listtasks: do_addto_recipe_sysroot
nodejs-native-4.5.0-r0 do_listtasks: do_build                      Default task for a recipe - depends on all other normal tasks required to 'build' a recipe
nodejs-native-4.5.0-r0 do_listtasks: do_checklicense
nodejs-native-4.5.0-r0 do_listtasks: do_checklicenseall
nodejs-native-4.5.0-r0 do_listtasks: do_checkpkg
...

This patch excludes PLAIN messages from this prefixing making the log output
neater.

[YOCTO #11457]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 936d5a4..11afb3e 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -472,7 +472,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         continue
 
                     # Prefix task messages with recipe/task
-                    if event.taskpid in helper.running_tasks:
+                    if event.taskpid in helper.running_tasks and event.levelno != format.PLAIN:
                         taskinfo = helper.running_tasks[event.taskpid]
                         event.msg = taskinfo['title'] + ': ' + event.msg
                 if hasattr(event, 'fn'):
-- 
2.7.4


