Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RXbJb-0006NI-7v
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Dec 2011 17:22:51 +0100
Received: by opal (Postfix, from userid 111)
	id DC29B10331; Mon,  5 Dec 2011 16:19:47 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111205161947.DC29B10331@opal>
Date: Mon,  5 Dec 2011 16:19:47 +0000 (UTC)
From: git@git.openembedded.org
Subject: Robert Yang : Remove the async_cmds and sync_cmds from command.py
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
X-List-Received-Date: Mon, 05 Dec 2011 16:22:52 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 24e99460800856035bb54a84c7aa33b3517436e9
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=24e99460800856035bb54a84c7aa33b3517436e9

Author: Robert Yang <liezhi.yang@windriver.com>
Date:   Wed Nov 30 17:23:51 2011 +0800

Remove the async_cmds and sync_cmds from command.py

In bitbake/lib/bb/command.py::Command::__init__, we have the following
lines:

for attr in CommandsSync.__dict__:
    command = attr[:].lower()
    method = getattr(CommandsSync, attr)
    sync_cmds[command] = (method)

for attr in CommandsAsync.__dict__:
    command = attr[:].lower()
    method = getattr(CommandsAsync, attr)
    async_cmds[command] = (method)

The sync_cmds and async_cmds are defined as global dictionaries, but it
seems that we've never used them (I did a "grep -r async_cmds bitbake/",
, there is no result except the ones that I have removed), and I can't
find the history of it from "git log -p", I guess that they have been
replaced by the self.cmds_sync and self.cmds_async.

[YOCTO #1791]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/command.py |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1808f0c..83907f6 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -31,10 +31,6 @@ Commands are queued in a CommandQueue
 import bb.event
 import bb.cooker
 
-async_cmds = {}
-sync_cmds = {}
-
-
 class CommandCompleted(bb.event.Event):
     pass
 
@@ -60,16 +56,6 @@ class Command:
         # FIXME Add lock for this
         self.currentAsyncCommand = None
 
-        for attr in CommandsSync.__dict__:
-            command = attr[:].lower()
-            method = getattr(CommandsSync, attr)
-            sync_cmds[command] = (method)
-
-        for attr in CommandsAsync.__dict__:
-            command = attr[:].lower()
-            method = getattr(CommandsAsync, attr)
-            async_cmds[command] = (method)
-
     def runCommand(self, commandline):
         try:
             command = commandline.pop(0)



