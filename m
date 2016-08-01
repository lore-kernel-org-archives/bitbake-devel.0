Return-Path: <uol@pengutronix.de>
X-Greylist: delayed 1086 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 01 Aug 2016 09:01:15 UTC
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
	[92.198.50.35])
	by mail.openembedded.org (Postfix) with ESMTP id 7A13865CBB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Aug 2016 09:01:15 +0000 (UTC)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
	by metis.ext.pengutronix.de with esmtps
	(TLS1.2:RSA_AES_256_CBC_SHA1:256) (Exim 4.80)
	(envelope-from <uol@pengutronix.de>)
	id 1bU8oW-0005OW-Tf; Mon, 01 Aug 2016 10:43:08 +0200
Received: from uol by dude.hi.pengutronix.de with local (Exim 4.87)
	(envelope-from <uol@pengutronix.de>)
	id 1bU8oW-00023D-Ml; Mon, 01 Aug 2016 10:43:08 +0200
From: =?UTF-8?q?Ulrich=20=C3=96lmann?= <u.oelmann@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2016 10:43:00 +0200
Message-Id: <1470040980-3577-1-git-send-email-u.oelmann@pengutronix.de>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: uol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
	SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Fix typo
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
X-List-Received-Date: Mon, 01 Aug 2016 09:01:16 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Ulrich Ölmann <u.oelmann@pengutronix.de>
---
 lib/bb/siggen.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index db3daeffb56d..5d8a253a1feb 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -293,11 +293,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         computed_basehash = calc_basehash(data)
         if computed_basehash != self.basehash[k]:
-            bb.error("Basehash mismatch %s verses %s for %s" % (computed_basehash, self.basehash[k], k))
+            bb.error("Basehash mismatch %s versus %s for %s" % (computed_basehash, self.basehash[k], k))
         if runtime and k in self.taskhash:
             computed_taskhash = calc_taskhash(data)
             if computed_taskhash != self.taskhash[k]:
-                bb.error("Taskhash mismatch %s verses %s for %s" % (computed_taskhash, self.taskhash[k], k))
+                bb.error("Taskhash mismatch %s versus %s for %s" % (computed_taskhash, self.taskhash[k], k))
 
 
     def dump_sigs(self, dataCache, options):
-- 
2.8.1


