Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RVgVe-0005Dr-0N
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 Nov 2011 10:31:22 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pAU9OfI2004844
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Nov 2011 01:24:41 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Wed, 30 Nov 2011 01:24:41 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Nov 2011 17:23:51 +0800
Message-ID: <f448aa3aefe207b4b250c56b1244bbb1c8019a5f.1322644797.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1322644797.git.liezhi.yang@windriver.com>
References: <cover.1322644797.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] Remove the async_cmds and sync_cmds from command.py
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
X-List-Received-Date: Wed, 30 Nov 2011 09:31:22 -0000
Content-Type: text/plain

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
---
 bitbake/lib/bb/command.py |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 1808f0c..83907f6 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
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
-- 
1.7.4.1



