Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 40E706DE03
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 15:09:44 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rBAF9hbf010908
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 07:09:44 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 10 Dec 2013 07:09:43 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Dec 2013 10:09:35 -0500
Message-ID: <094280522c177327751d9ddeb0eef96fd186fd0b.1386680149.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1386680149.git.liezhi.yang@windriver.com>
References: <cover.1386680149.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/5] [dora] bitbake: cooker/command: Add error state for the server and use for pre_serve errors
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
X-List-Received-Date: Tue, 10 Dec 2013 15:09:44 -0000
Content-Type: text/plain

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Currently if errors occur when starting the PR service, there is a race that
occurs since the UI runs various commands including starting builds before
processing the CookerExit(). By adding the error state and refusing to run
async commands in this mode, builds are prevented from starting and the
UI reaches the exit code with the system shutting down cleanly.

(Bitbake master rev: 42fa34142ea685f91115a551e74416ca28ef1c91)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/command.py |    2 ++
 bitbake/lib/bb/cooker.py  |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 3ca27a6..a2795ce 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -86,6 +86,8 @@ class Command:
 
     def runAsyncCommand(self):
         try:
+            if self.cooker.state == bb.cooker.state.error:
+                return False
             if self.currentAsyncCommand is not None:
                 (command, options) = self.currentAsyncCommand
                 commandmethod = getattr(CommandsAsync, command)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ad36b34..b504f45 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -61,7 +61,7 @@ class CollectionError(bb.BBHandledException):
     """
 
 class state:
-    initial, parsing, running, shutdown, forceshutdown, stopped = range(6)
+    initial, parsing, running, shutdown, forceshutdown, stopped, error = range(7)
 
 
 class SkippedPackage:
@@ -1321,6 +1321,7 @@ class BBCooker:
             self.prhost = prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError:
             bb.event.fire(CookerExit(), self.event_data)
+            self.state = state.error
         return
 
     def post_serve(self):
-- 
1.7.10.4


