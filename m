Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 21BFE71503
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Nov 2014 13:07:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id sAHD7IXj015765
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Nov 2014 05:07:18 -0800 (PST)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.174.1;
	Mon, 17 Nov 2014 05:07:17 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Nov 2014 05:07:16 -0800
Message-ID: <17a28ca2002b7c8f4be1c4822d6662a18ffefb3c.1416229526.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1416229526.git.liezhi.yang@windriver.com>
References: <cover.1416229526.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake-worker: exit normally when SIGHUP
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
X-List-Received-Date: Mon, 17 Nov 2014 13:07:21 -0000
Content-Type: text/plain

Fixed:
1) Run "bitbake recipe" in the terminal
2) Close the terminal while building
3) $ ps aux | grep bitbake-worker
There will be many processes, and they will keep the resources (e.g.,
memory), and won't exit unless kill or kill -9.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-worker |    9 ++++++++-
 bitbake/lib/bb/cooker.py   |    7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index dde2c9c..371c99a 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -147,6 +147,8 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
             pipein.close()
 
             signal.signal(signal.SIGTERM, sigterm_handler)
+            # Let SIGHUP exit as SIGTERM
+            signal.signal(signal.SIGHUP, sigterm_handler)
 
             # Save out the PID so that the event can include it the
             # events
@@ -266,9 +268,14 @@ class BitbakeWorker(object):
         self.build_pipes = {}
     
         signal.signal(signal.SIGTERM, self.sigterm_exception)
+        # Let SIGHUP exit as SIGTERM
+        signal.signal(signal.SIGHUP, self.sigterm_exception)
 
     def sigterm_exception(self, signum, stackframe):
-        bb.warn("Worker recieved SIGTERM, shutting down...")
+        if signum == signal.SIGTERM:
+            bb.warn("Worker recieved SIGTERM, shutting down...")
+        elif signum == signal.SIGHUP:
+            bb.warn("Worker recieved SIGHUP, shutting down...")
         self.handle_finishnow(None)
         signal.signal(signal.SIGTERM, signal.SIG_DFL)
         os.kill(os.getpid(), signal.SIGTERM)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 087f72f..a08c14b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -153,9 +153,14 @@ class BBCooker:
         self.parser = None
 
         signal.signal(signal.SIGTERM, self.sigterm_exception)
+        # Let SIGHUP exit as SIGTERM
+        signal.signal(signal.SIGHUP, self.sigterm_exception)
 
     def sigterm_exception(self, signum, stackframe):
-        bb.warn("Cooker recieved SIGTERM, shutting down...")
+        if signum == signal.SIGTERM:
+            bb.warn("Cooker recieved SIGTERM, shutting down...")
+        elif signum == signal.SIGHUP:
+            bb.warn("Cooker recieved SIGHUP, shutting down...")
         self.state = state.forceshutdown
 
     def setFeatures(self, features):
-- 
1.7.9.5


