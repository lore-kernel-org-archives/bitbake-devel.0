Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19784EB28F7
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 08:40:51 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7405.1770367243753605366
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Feb 2026 00:40:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=nsn+1Rg0;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 46B9B1A2C48;
	Fri,  6 Feb 2026 08:40:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C84A60729;
	Fri,  6 Feb 2026 08:40:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51330119D1A2E;
	Fri,  6 Feb 2026 09:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770367241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JXY0JKq2MLa5YKvUVfXBatK+rNHEa1DVwYgbYtDemP8=;
	b=nsn+1Rg0qaKxvdHwc+0B9lB50sjhtAzM2wyrZWTQEdlLoibcGxzQQ3LC9gyErUEr1Mua05
	B/k3pByZhx3lQvTs58hwPeacLqY1HkoD/ybpb2WEaSewtIvk2YuaBshzmmZBtpAyplq0uf
	Mr6pzCEWUSOaLki852J38MGt+J86aty3Gr40m/miv2Wu7z6Y8zWUWyHvJPaaWg0zrwWCd5
	ooksCAVb4hmwiKYPu6w2h4RMhw7Y+PfnoMdml5ldRVGICO3dV8mNrOImGSR4VzaYMZHqC6
	BbxDObW+y0U3U17llRwdPslSomZXG4Li3ELrAPeAYR1/WYv+AwTwZ9JLt3ce7Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 06 Feb 2026 09:40:18 +0100
Subject: [PATCH v5 2/2] lib/bb/tests/setup.py: add tests for
 oe-fragments-one-of
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-bitbake-setup-choose-builtin-v5-2-3038da12dd2f@bootlin.com>
References: <20260206-bitbake-setup-choose-builtin-v5-0-3038da12dd2f@bootlin.com>
In-Reply-To: <20260206-bitbake-setup-choose-builtin-v5-0-3038da12dd2f@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3627;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=C4LjdwB0i63HRgeJ29VeFoSRK4l9M9dQCRV062kCTe8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBphakGFqMcoR8jTLjjgzczCEtvNIXFElj1uzpiA
 ztCkhTsSDqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYWpBgAKCRDRgEFAKaOo
 NldJD/43QKRTZ1xDQz2Y4bCGC1DDsJJctyJ3hb7fEKFJZ+1EfUsE4OXYx4u5O9b7hNMnMhkW4mi
 NYsmAY8za5Itt5JHKa9f2ACvMwlNHcfySjt484dKMe8Ymh3JojVRavP71AV0RYhzjel68asg3Qb
 R+sst2cfITVo5nWgb0/nRn7zrbm7MHL9gmeK95pUwN8uk1jlSYkkdwXvRhUdvg7YU2WtnG2seWW
 WlfHBTPj0p7zeiQBbq+xRYHkpwENZoKWdoJDORtddDUfZtZMy/8QEKV4R5gNi+Hixe8nKTvtVuS
 f3z0sOI2cup3eOyobKGfUR2P3jrbLWP7hJZI6TUPXYSoDLNHRIp7eCRWQzToJCQG77p2Xn0Wp+q
 6ZBQUy6zecsqpMBiRI/kCOC17MP93k01Hlv/v8nWZr4MYR8xhmBMl9NIQbtGcr1ajhqP1Pp5xxB
 16nQ7S0/c2YrSBuGVkeAG4jOlzmnnAUsAFadbK5njCCmKaFpEr4udP6TB0tBUqKwbZ/8QJGw5eG
 yhDzBIx3XSGA4SCsHc6+YdUqAhi3DaoC5AtGZgAOXLmzzRqxCL9VNvBBJk2S0Pdl1qsBzjGBYyx
 /JXemprirKX0dCygYxoB4t0X0f0xVFloWz8Rkvd22uEuvpYFLzt5zSavLjshEBkhDOuhD/DaUIw
 DWZBgEd+7vx0dww==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 08:40:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18979

There were no tests of oe-fragments-one-of so modify gizmo-notemplate to
gizmo-notemplate-fragments-one-of, and test both formats for the options
(with or without a description).

In get_setup_path(), if the configuration specified on the command-line
contains fragments, join everything with "-" as this is what will be the
final directory name of the setup. This does not affect other current
variants.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/tests/setup.py | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index ef407ee9e2a..e3557d8f3b9 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -136,10 +136,26 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "oe-fragments": ["test-fragment-1"]
             },
             {
-                "name": "gizmo-notemplate",
+                "name": "gizmo-notemplate-fragments-one-of",
                 "description": "Gizmo notemplate configuration",
                 "bb-layers": ["layerC","layerD/meta-layer"],
-                "oe-fragments": ["test-fragment-2"]
+                "oe-fragments": ["test-fragment-2"],
+                "oe-fragments-one-of": {
+                    "fragment-desc": {
+                        "description": "Test fragments (with description)",
+                        "options" : [
+                            { "name": "fragment-desc-1", "description": "fragment 1 desc" },
+                            { "name": "fragment-desc-2", "description": "fragment 2 desc" }
+                        ]
+                    },
+                    "fragment-nodesc": {
+                        "description": "Test fragments (no description)",
+                        "options" : [
+                            "fragment-nodesc-1",
+                            "fragment-nodesc-2"
+                        ]
+                    }
+                }
             },
             {
                 "name": "gizmo-notemplate-with-filerelative-layers",
@@ -259,7 +275,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
     def get_setup_path(self, cf, c):
         if c == 'gizmo':
             return os.path.join(self.tempdir, 'bitbake-builds', 'this-is-a-custom-gizmo-build')
-        return os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
+        return os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, "-".join(c.split())))
 
     def test_setup(self):
         # unset BBPATH to ensure tests run in isolation from the existing bitbake environment
@@ -327,7 +343,14 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # test-config-1 is tested as a registry config and over http, test-config-2 as a local file
         server = HTTPService(self.registrypath, host="127.0.0.1")
         server.start()
-        variants = ('gadget','gizmo','gizmo-env-passthrough','gizmo-no-fragment','gadget-notemplate','gizmo-notemplate')
+        variants = (
+            'gadget',
+            'gizmo',
+            'gizmo-env-passthrough',
+            'gizmo-no-fragment',
+            'gadget-notemplate',
+            'gizmo-notemplate-fragments-one-of fragment-desc-1 fragment-nodesc-1',
+        )
         variants_local = variants + ('gizmo-notemplate-with-filerelative-layers',)
         test_configurations = ({'name':'test-config-1','cmdline': 'test-config-1',
                                                  'buildconfigs': variants},

-- 
2.52.0


