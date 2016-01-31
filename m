Return-Path: <pb@pbcl.net>
Received: from hetzner.pbcl.net (mail.pbcl.net [88.198.119.4])
	by mail.openembedded.org (Postfix) with ESMTP id BDFBE77228
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jan 2016 13:51:51 +0000 (UTC)
Received: from localhost ([127.0.0.1]
	helo=[IPv6:2001:67c:1810:f051:fa2f:a8ff:feb0:ae33])
	by hetzner.pbcl.net with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80) (envelope-from <pb@pbcl.net>) id 1aPsPs-0000u4-Pm
	for bitbake-devel@lists.openembedded.org;
	Sun, 31 Jan 2016 14:51:51 +0100
Message-ID: <1454248288.7421.17.camel@pbcl.net>
From: Phil Blundell <pb@pbcl.net>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 31 Jan 2016 13:51:28 +0000
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Subject: [PATCH] cooker, bitbake-worker: Fix spelling of "received"
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
X-List-Received-Date: Sun, 31 Jan 2016 13:51:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I before E, except after C...

Signed-off-by: Phil Blundell <pb@pbcl.net>
---
 bin/bitbake-worker | 4 ++--
 lib/bb/cooker.py   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index f053382..767a1c0 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -305,9 +305,9 @@ class BitbakeWorker(object):
 
     def sigterm_exception(self, signum, stackframe):
         if signum == signal.SIGTERM:
-            bb.warn("Worker recieved SIGTERM, shutting down...")
+            bb.warn("Worker received SIGTERM, shutting down...")
         elif signum == signal.SIGHUP:
-            bb.warn("Worker recieved SIGHUP, shutting down...")
+            bb.warn("Worker received SIGHUP, shutting down...")
         self.handle_finishnow(None)
         signal.signal(signal.SIGTERM, signal.SIG_DFL)
         os.kill(os.getpid(), signal.SIGTERM)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a1182ef..93600f4 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -242,9 +242,9 @@ class BBCooker:
 
     def sigterm_exception(self, signum, stackframe):
         if signum == signal.SIGTERM:
-            bb.warn("Cooker recieved SIGTERM, shutting down...")
+            bb.warn("Cooker received SIGTERM, shutting down...")
         elif signum == signal.SIGHUP:
-            bb.warn("Cooker recieved SIGHUP, shutting down...")
+            bb.warn("Cooker received SIGHUP, shutting down...")
         self.state = state.forceshutdown
 
     def setFeatures(self, features):
-- 
2.1.4




