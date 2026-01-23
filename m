Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66B2D74ED0
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 13:24:28 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.67346.1769174660951257844
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 05:24:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=pHy0MzRC;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 62B344E42219;
	Fri, 23 Jan 2026 13:24:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 390396070A;
	Fri, 23 Jan 2026 13:24:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2838D119A879C;
	Fri, 23 Jan 2026 14:24:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769174658; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g2koIJSmJjswh6P8PjjE4ZEWlWyNrD5iZxRgYd1r9ZY=;
	b=pHy0MzRCzw+Nigi3TSb4hC8K2XYOBn4gfE8C2Tos9MnAByP13jj6/bvpBi/Z3laRFW/RjZ
	kPhMyPb5zSdO+et0B1sZYBMmED8Bp+C5UOqL1Kal201es+S9/QeITStE9qiXBgEEyfTz98
	mu0DOBUcV38E9Xwx01Dn2dw3YOpZhgb4n4vACS4I/fr/lbWM8A/I/T8cNp5AcoXnMaHFNK
	+QD0WSYAeLMAPQiN79nwJ3V3bPEqAz3KLMvo5op65hMzp1p0zWKOVKkiB2aGsjjs6cqWEM
	KqOqGUS2UmGRF55wI6gDV2F8C6SPxOkqKwVbd0XEaUJol1F/KVl5I7JTMBsuKA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 14:24:08 +0100
Subject: [PATCH v4 3/3] lib/bb/tests/setup.py: add tests for
 oe-fragments-one-of
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-bitbake-setup-choose-builtin-v4-3-99361f2128f6@bootlin.com>
References: <20260123-bitbake-setup-choose-builtin-v4-0-99361f2128f6@bootlin.com>
In-Reply-To: <20260123-bitbake-setup-choose-builtin-v4-0-99361f2128f6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3627;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=UCnMFPZz7Di0N5U7Oen8QNvdvN3re6ulXQivsjIYkmE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpc3Z+Pk7NmjiHrtQcz6XHzeCLdPRext/iZc7qF
 7ujF8yQ4QOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXN2fgAKCRDRgEFAKaOo
 NlW2EACfPAoE/DKMh+hQB4q1II8gF2BnWwu5PFVGI1TkjFWLiD5qHgZ+fO6P0ltB7irZh9JW59p
 WQN+H0EHrTDdCEbj2sJN1fQ8Viy0pyIpD9KmkXXTSo9SemSEadkUUEX+tecgOOxLBCubFaPzBMT
 qjDW5kYnEW9DjnXYvUJGBicMhRJHpHuP+QcIohFys2YxiR+nF4YyKlKJFbSOZLpwbvuAYqHz1CY
 oW3A/SrYDn0nE2+EmXZ1RIB5CpstDk9rVXp7+/+MmSe2f0LflrqmowFCld+Nd1JiBcFlCZ164Qb
 78UllCsa74C9lABiaVVi33BpwvzOFHjIDH+bYh/GQzkTiPCHcQNBEsQ/lsEtfvM1a+iGQKriJWm
 pBuwfr6ZZhR26BrL/iKT6qVXmUqNkd225CTto9OepaFrm3XnhNJQ3ncD7+f1ezegNClsS2oK9YF
 8lX1nc10zL0/4f64PJinh/do8QQCFZgLYada3qj1mvDQHiBn91Wb2eNs8GbDu0o4rBPjcssnaCF
 0JPxA9fW/qcEUXg+OWmz9UuLlODmztGe92F4DPQ8hiBvudI7j7NveuSfs2CUMoTcP/3jvAFnFY+
 VG/fkCBcls2Eh6Zu9ZjGY6kwrYYKP33PdVEbV1dhOeENG9NOFKXFVNm6JDK8vZlrnsALFYGdgeh
 YyWPe2DdFLdP+Uw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 13:24:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18861

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
index 8b6046c049a..744dfe903ed 100644
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


