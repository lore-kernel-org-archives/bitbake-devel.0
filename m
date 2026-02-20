Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35716C56203
	for <webhook@archiver.kernel.org>; Fri, 20 Feb 2026 14:30:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39933.1771597814409432613
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Feb 2026 06:30:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fcmI5B6y;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1FBE51A0A79
	for <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 14:30:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EA0CA5FA8F
	for <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 14:30:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B89C210368D20;
	Fri, 20 Feb 2026 15:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771597811; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=bj3R+FN05BST1DxUZj2kjIJ5JfUQuw0ZcE/f54WIJHU=;
	b=fcmI5B6yirtxDPN81wKh7zPFtVl4Rs/CzSOLvUvm3GHraKwrCtPY7ShHJVqqQ2OZ0J5Q+Y
	T9ER05q5S1gQmx9U+pb7RCqWgtxRLFv3l6pYvF9kq6DQD3jYnpXVoY1vY/2G9eHdJ1G1i1
	7OJ5dqWWZEemtNynfpsoWjwUcg8hgQ3pgOPATlh5ECEcLYf8S2eQKC+PQFD7P3LVLNG8/F
	JTlYMuGte04PQncDFQ+0ADDaRIDp1XeGHGhgR8fUqL4eppRtKFSrk0TGb5bqEPhGOuwRr7
	Q/xcAsBjg5UXbWh8MKd9LHXYWhTsldsM7GC8+Lw128XSOF9rDPoGw10CmqThMA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 20 Feb 2026 15:30:07 +0100
Subject: [PATCH] tinfoil: show close matches when no providers are found
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-bitbake-getvar-close-matches-v1-1-c69d9496915b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBAG0KuQWTtJbQATr2JctMMHjD9gOpWYE
 O5O1eXbvJUMSWF0rlZKWNR0ngqOh4pkDNMA1q6YvPOt895x1BzDHTwgLyGxPGYDP0OWEcbSiY9
 NfWrqFlSKV0Kvn19/uf5t73iD5O9J27YDh61BY4AAAAA=
X-Change-ID: 20260220-bitbake-getvar-close-matches-cdc2b547546e
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=B3XTai0DFlqk86zSZ+JzbRv1Hu/jJZVWfUxSeNEMndQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpmG/yhVEXmc66+vmE2qsvVOj1spepPxP4XuUAR
 gbtmKkfQgOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZhv8gAKCRDRgEFAKaOo
 NhsAD/wMX+C0mEOg4sMi7yopPfkWvrFfl5KoCHcvbq0aournZDgogzYq+w4tU3fMAVXB6+pgKEP
 rBXB9SwGTDiLKY4xrOyJhlQLq7eu/lz6ET1TE3CYU2cs4WTva0RC278r1QPvOorbCY5v+ve1uB6
 Nb4+avs9x0N02hO2vgupYip9JvmbaZU2Bg3V69mQzwa9EKnPdEOZ2Sm6ppvBb0/V3rRX3fj3lvT
 UfU8056BxBZ6RRpCWMBYWTeLYCmlTvvIwRhAQ+Gw/RNQp+Ws9d3P1ueaiBrf7dTwH69CXPppso8
 wOSFEEGPdeGM/Jgn2z+kKPh051dWJD0Dd12i/4FnG4m/OZ6qsZF0es6fkMdb0OV7cWjTnin/c3O
 kPo4wWbMEmb1mQuKL/3MqWbj5A2LJ2NPZ6QUyYrtwewhAiM5kZzxHQlzO0KmPWLP/HIaK9/fRbK
 QTUWIOyvrR98shhzq3UEeUR9XaD8nJxGI3GnuZbUJ9PFVH3AgB+MPPID1iT0cQgSsyERl68Qo3r
 JiGFuNzMNdmQbjo+t1a/4o4HUKsKKtsCCSFKFsnPjDueh9z7A2INpiKzVt9TeT1rHG47LKZ0jBG
 UtOZUQ/oRDPKnPjO1OAr6oCS1X8eP9ZyPVUWyM9z/TjnCynoW21+6RjrYPk2WaR3reoBKLJDpwl
 9UlvxAWjMdZHTew==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 14:30:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19076

When calling 'bitbake-getvar -r somerecipe FOO', show close matches when
'somerecipe' doesn't exist but close matches are found. This replicates
the behavior of 'bitbake -e'.

Example output:

$ bitbake-getvar -r binutils-cross FOO
Unable to find any recipe file matching "binutils-cross". Close matches:
  binutils-cross-aarch64
  binutils
  util-macros

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/tinfoil.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index d9e985c612c..9c1768942ab 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -685,7 +685,14 @@ class Tinfoil:
             if skipreasons:
                 raise bb.providers.NoProvider('%s is unavailable:\n  %s' % (pn, '  \n'.join(skipreasons)))
             else:
-                raise bb.providers.NoProvider('Unable to find any recipe file matching "%s"' % pn)
+                msg = f'Unable to find any recipe file matching "{pn}"'
+                import difflib
+                providers = self.get_all_providers()
+                close_matches = difflib.get_close_matches(pn, providers, cutoff=0.7)
+                if close_matches:
+                    close_matches = "\n  ".join(close_matches)
+                    msg += f'. Close matches:\n  {close_matches}'
+                raise bb.providers.NoProvider(msg)
         return best[3]
 
     def get_file_appends(self, fn, mc=''):

---
base-commit: d9700632bd6b627d1124fdc83ddf7bfb4199228d
change-id: 20260220-bitbake-getvar-close-matches-cdc2b547546e


