Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
 by mx.groups.io with SMTP id smtpd.web12.36575.1629188836060306186
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Aug 2021 01:27:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: pengutronix.de, ip: 85.220.165.71, mailfrom: mfe@pengutronix.de)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1mFuRF-0004y5-4S; Tue, 17 Aug 2021 10:27:13 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1mFuRD-0001wv-Ij; Tue, 17 Aug 2021 10:27:11 +0200
From: "Marco Felsch" <m.felsch@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: kernel@pengutronix.de
Subject: [PATCH] bitbake: bitbake-layers: add skip reason to output
Date: Tue, 17 Aug 2021 10:25:33 +0200
Message-Id: <20210817082532.6512-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
Content-Transfer-Encoding: 8bit

Currently we inform the user that some package/layer is skipped but we
don't print the reason albeit bitbake knows the reason. So currently it
looks like:

gtk+:
  meta-oe              2.24.32 (skipped)

With this change the output prints the skip reason which is very helpful
for debugging:

gtk+:
  meta-oe              2.24.32 (skipped: one of 'x11 directfb' needs to be in DISTRO_FEATURES)

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 bitbake/lib/bblayers/query.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index 947422a72f..6e94c83076 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -154,7 +154,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         def print_item(f, pn, ver, layer, ispref):
             if not selected_layer or layer == selected_layer:
                 if not bare and f in skiplist:
-                    skipped = ' (skipped)'
+                    skipped = ' (skipped: %s)' % self.tinfoil.cooker.skiplist[f].skipreason
                 else:
                     skipped = ''
                 if show_filenames:
-- 
2.30.2

