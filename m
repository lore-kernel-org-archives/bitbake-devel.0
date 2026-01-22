Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C4D3EE75
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 15:02:29 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39175.1769094145510361766
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 07:02:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=PU3017xX;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 07DE51A2AB7;
	Thu, 22 Jan 2026 15:02:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2202606B6;
	Thu, 22 Jan 2026 15:02:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FB19119B82CA;
	Thu, 22 Jan 2026 16:02:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094143; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w6YpKyhVEVkY2m3oUrvIRe72GLcX/x2doVwwHuBXJAM=;
	b=PU3017xXy4QUPTlImuv/nK/3ALxhsgwfaimgZ4EEYySJcETb28+MJKqUdoJdYC0JfRIwiF
	P9pfGA5GCCuiQ0J6cgtAAcHTklyP6gMea7RCCexAXz37BDLeQfCrOb31aDch+iHTH/VRA/
	mN4ArNXqAMXxVvmR3AVH+AjlNR2t5anZI3UyfJe/G/6lhi/HwgSQMIYQLzFXVK2aKsAxeL
	pkn0szjA0Bh5oe86nTiF3pEDXQAL75UdbTi8KONlMqQqZzQGnX8z7X8V+ue6vQ1oNJmKp5
	GcHiXV8UXHUtjcB0LHFnYzFLQ01OTcckc6ZRKvJOmdWfLO24yJmcktCXbbFq6g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 22 Jan 2026 16:02:00 +0100
Subject: [PATCH v3 3/3] lib/bb/tests/setup.py: add tests for
 oe-fragments-one-of
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-bitbake-setup-choose-builtin-v3-3-c55291acc1a7@bootlin.com>
References: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
In-Reply-To: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3282;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ufSG9isX7KWwE+vhuAsJ6JUlLpPim390Gv0zZ9uNxpI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcjv7aHx+k3Tq2ys5NdgwGfhdb/6L+WSx9x0Bw
 UzxwwT/DsqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXI7+wAKCRDRgEFAKaOo
 NrxlD/9Ye0tTP4tQU8R22a+Ogu8bzajDEnC6u9IGhAgfPHG3CJ8TV5/D7kcsLVkj7g3damfnmX+
 bHDjgc9/0ZgyGT6Hyb5uGhHH9kVnvHeNKXiEs+y7BCpnfyJMJxsX4uPhl1znnNw9H4KTyrOeGdG
 3hXflKjcOwNNXOWMT2QChmce7Dv0oHslSl1M84HtrOi/dbf82doqWhpDHeuzPY2+23vvnGcHEgm
 DJTlKIVFLTsiC+OGaC6e+2hPe66bEriKQ+VkI7sqzHIk/fqDYkSYcZdbOCjv5jC6Zc/Fr0MFqfy
 bXPntS1uVxYipBYk31JJKL5jY/WdEz5uBZj++B6BHQCjvi9UPR2Opoo8e+Ao8j296jDR4ilSTjW
 MTv5Zk9BanCikqrknn9JOV14opgT/5+L+Gd4K/j6J6ycRArCZDInUsnRU39U71v/D4/dD7IX6/9
 IsrkC++78wz4MHuwB041LVSkXkOgU/va5sj4dAPHYioPE0x91lhnyvqlrBYpEZjMN51j3fv6WAf
 +EY+NewbLaTW5473Zijmj3a/5SyITH0H0qpktcChx+hdbTGX6TQkEA+RzSgx0OQXn3n5stSjDyS
 nUOa1nN2hlvFHxJmXN78Hirnd239sHtdN3qhO67XshVQIILHFjQ25u8pCoIdj8tdYNql1mvfKb/
 MtvcEzkV6tq9Wdw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 15:02:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18851

There were no tests of oe-fragments-one-of so add a new configuration
for it, and test both formats for the options (with or without a
description).

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/tests/setup.py | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 834d098547c..eaada3ce1e7 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -146,6 +146,25 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "bb-layers": ["layerC","layerD/meta-layer"],
                 "bb-layers-file-relative": ["layerE/meta-layer"],
                 "oe-fragments": ["test-fragment-2"]
+            },
+            {
+                "name": "gizmo-fragments-one-of",
+                "description": "Gizmo configuration using oe-fragments-one-of, both formats",
+                "oe-template": "test-configuration-gizmo",
+                "oe-fragments-one-of": {
+                    "fragment-desc": {
+                        "description": "Test fragments (with description)",
+                        "options" : [
+                            { "name": "fragment-desc-1", "description": "fragment 1 desc" }
+                        ]
+                    },
+                    "fragment-nodesc": {
+                        "description": "Test fragments (no description)",
+                        "options" : [
+                            "fragment-nodesc-1"
+                        ]
+                    }
+                }
             }
         ]
     },
@@ -258,7 +277,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
     def get_setup_path(self, cf, c):
         if c == 'gizmo':
             return os.path.join(self.tempdir, 'bitbake-builds', 'this-is-a-custom-gizmo-build')
-        return os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
+        return os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, "-".join(c.split())))
 
     def test_setup(self):
         # unset BBPATH to ensure tests run in isolation from the existing bitbake environment
@@ -328,7 +347,9 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                                                  'buildconfigs':('gadget','gizmo',
                                                                  'gizmo-env-passthrough',
                                                                  'gizmo-no-fragment',
-                                                                 'gadget-notemplate','gizmo-notemplate')},
+                                                                 'gadget-notemplate',
+                                                                 'gizmo-notemplate',
+                                                                 'gizmo-fragments-one-of fragment-desc-1 fragment-nodesc-1')},
                                'test-config-2': {'cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'),
                                                  'buildconfigs': ('gadget','gizmo',
                                                                   'gizmo-env-passthrough',

-- 
2.52.0


