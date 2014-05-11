Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (unknown [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8523F66004
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 May 2014 12:06:32 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4BC6RGM017740 for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 May 2014 13:06:27 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lM38DzMWa60E for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 May 2014 13:06:27 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4BC6Lwc017736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 May 2014 13:06:22 +0100
Message-ID: <1399809974.31891.107.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 11 May 2014 13:06:14 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Fix output printed to the user at debug log levels
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
X-List-Received-Date: Sun, 11 May 2014 12:06:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If a user runs with the -v or -D options, its understandable they'd
expect to see log output from the workers yet right now a bug in the
log handling does not show this.

Fix the conditional to ensure such log output is shown on the terminal
when it has been requested. Ideally this data should always flow to
the logfiles but that is for another patch.

This also fixes the code to do what was always intended in the comments,
i.e. if the user specifies -D or -v, output is shown from the tasks,
otherwise notes are suppressed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 41f1ba8..77a7082 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -351,7 +351,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to
                 # include verbose/debug messages
-                if event.taskpid != 0 and event.levelno <= format.NOTE:
+                if event.taskpid != 0 and event.levelno <= format.NOTE and (event.levelno < llevel or (event.levelno == format.NOTE and llevel != format.VERBOSE)):
                     continue
                 logger.handle(event)
                 continue



