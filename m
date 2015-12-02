Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 2E5826FFD3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 18:00:02 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47014256pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 10:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=CGetxUv5pmf7if21urkHtgUU+mjDsCbVe7MpuhKBeVo=;
	b=G0FzEN3Wu2MtBtQcGqpn2Lzk7np5Wqymj/A00ajCmIQKVsZ+thgC3V7RsPTQlgm3Rg
	U0Dl+qR3T+jyqisBZyRoyi0VO0rlY/H+SwgrvHm6cG94lj7iWvfBhQK866t39cD73w7m
	qjaKP51OiPk172k7ReAWqhQcgZ0LO4/0n8gFseGUJw8svVw+ZymqR5pX06NSPz5PG4HB
	CXWbxqrxXXVBhsMqXnswSgYOwnj3N3g4bmQ+11KoEuGMcuAUgyEsARLFMzp6K/PMrL9y
	h0fVkKqL+iPV3VPzZSZDsB8oX1Bj7WtZJ3HM3/V4+a7xPGgIgQKhlO1P4y7SeDATO8vJ
	92xA==
X-Received: by 10.67.14.201 with SMTP id fi9mr6545404pad.41.1449079203255;
	Wed, 02 Dec 2015 10:00:03 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.10.00.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 10:00:02 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:03:00 -0800
Message-Id: <3bf6fe429855eb5b4d44e28c7bf832423d2f72cb.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 28/30] command: add CommandStarted event
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
X-List-Received-Date: Wed, 02 Dec 2015 18:00:02 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This event will be used by toasterui to set BRBE build parameter
as soon as it's provided to bitbake server by Toaster.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/command.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 74106d1..78ce03a 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -31,6 +31,11 @@ Commands are queued in a CommandQueue
 import bb.event
 import bb.cooker
 
+class CommandStarted(bb.event.Event):
+    def  __init__(self, commandline):
+        bb.event.Event.__init__(self)
+        self.commandline = commandline
+
 class CommandCompleted(bb.event.Event):
     pass
 
@@ -60,6 +65,7 @@ class Command:
         self.currentAsyncCommand = None
 
     def runCommand(self, commandline, ro_only = False):
+        bb.event.fire(CommandStarted(commandline), self.cooker.expanded_data)
         command = commandline.pop(0)
         if hasattr(CommandsSync, command):
             # Can run synchronous commands straight away
-- 
1.9.1


