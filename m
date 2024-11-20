Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA00CD60D17
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 09:30:12 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.9661.1732095010037828648
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Nov 2024 01:30:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=a4kgNOfe;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A55471C000B;
	Wed, 20 Nov 2024 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732095008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gg2N3YTQ57E/oKv4xuN+GKIcixb++bUxgChh+5uKHig=;
	b=a4kgNOfei/wQRcP8FuTUwnQfBhshrAT+maODzUOeq2j04iWqCJqqtRidnukvopDCMG5d0G
	QtBQf0B2v4+lcY9sD1PglFT8zLqyqRSl0yxUtlOSV7RhXD45A3x6JkM7CqKsg+1gW1VTiB
	xFUH9GQwRNb8nvJ3EHmcDU4G4b++Uj+BhCNwUHiSgXGRiG4fAXFHWM2BPcF9U74UJgw9Qo
	HIKv/nUaA9CW/T9z6CCu+bHcqD9zoU1OMyP0RMli1NV84aW5P2EHpbIHFS67i96yhtLxH5
	b65w34jeQsWYSrydCIQ+r4Z7EvQf6JOtR7keR1/AsxvEet7Jks33xN7LGVVm1A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 20 Nov 2024 10:30:02 +0100
Subject: [bitbake-devel PATCH v2] doc: bitbake-user-manual: document
 inherit_defer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-inherit-defer-v2-1-e9291b7cf59b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABmsPWcC/3WMQQrCMBAAv1L27Eo2lhg8+Q/poUm2ZkETSUpRS
 v9u7N3jDMysULkIV7h0KxRepEpODfShAx/HdGeU0Bi00j0RWZQUWzFj4IkL9jacvGXllT1Da16
 FJ3nvv9vQOEqdc/ns+4V+9t9pISTUxhozGjU6cleX8/yQdPT5CcO2bV+xo9rprAAAAA==
X-Change-ID: 20241118-inherit-defer-48d3c8e0c087
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Yoann Congal <yoann.congal@smile.fr>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4209;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=5cMxa9xG71+NMrgwj9gtATB/j3ad7mgaNasbOx5pW6Q=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnPawfaY2c/lpNh/0bvMUTWNk51EhVPz/THEa2f
 Ctvl2yibUOJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZz2sHwAKCRDRgEFAKaOo
 NtgfD/9Un3L89jLIN3Ydb1oLQzDeM+cufSG2oVrsckapt+Ltvvw4u1dtkyDqfRPdh/x6lMmwg5v
 qR2vAeG3Ny1QcMc2VXmKEeG3FvhiNit7qtDhDRHcdlrepWf48xJMhyrf9ypkr6rsIcxEwmigkT/
 so67qnm1xTO64n64jvnFfBBv8qqTtqR2/IPFHbxHOvCDe86MtSdyQPoWOqJS+2mMQ64VGHupsnC
 3UzfFzSzmRC3mlCkoLYm3C/Ybb4U+OPMrIKZiWcEkUTM9zEQUcnkAMDH2hA2bRtxjzVAo3/mbCe
 B8XjW4cKcytplOjlo0OAJoRT4pETXzlEVBgfW3IVskee4DQeNaZoMMVsTgDl0t5+IOL2xZW/Zms
 w4irEdbHaz3jh2t2wrMqRnGCOSTWqjeFY/5ktC81GO2rkl/ugsyZLy6H02laJCn44Uyix2KuoUv
 eRYeMYtq60vSoQ1WQzieKl4NjBg1XrwaBLkyiROM6kgQ0JdglE8SkvPCM1kiE1Z/9G1MbDk1htX
 RrttF6tPK72AegIVPU3xXowMlMV0D7QhgbMVq0/vZl2ZmI5HlkC/6iAp+Sa7hZ18TkVvgb2YTMf
 7RouNi98sVuumNswS/nInrBUTKyIQizOQo9+4HpWCHDaV0TmNZXUBMMKJ9vnvKP4hvXxM6S9UBn
 Te2drfMyMcSo1GQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 09:30:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16815

This was added in 2.7.2. Since using inherit_defer is safer that inherit
when inheriting conditionally, move the instructions about that in
inherit_defer.

Fixes [YOCTO #15640].

Reported-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Move the instructions on conditional inherits in the inherit_defer
  section, since it is a safer call
- Link to v1: https://lore.kernel.org/r/20241118-inherit-defer-v1-1-26866a60ab1b@bootlin.com
---
 .../bitbake-user-manual-metadata.rst               | 43 ++++++++++++++++++----
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 58975f4c88ce549a2fd27136c0cb37b636bafcdb..40a0c6f02d9c35297dbb51da465efda83d832917 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -771,6 +771,8 @@ In order for include and class files to be found by BitBake, they need
 to be located in a "classes" subdirectory that can be found in
 :term:`BBPATH`.
 
+.. _ref-bitbake-user-manual-metadata-inherit:
+
 ``inherit`` Directive
 ---------------------
 
@@ -809,19 +811,43 @@ An advantage with the inherit directive as compared to both the
 :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>` and :ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
 directives is that you can inherit class files conditionally. You can
 accomplish this by using a variable expression after the ``inherit``
-statement. Here is an example::
+statement.
+
+For inheriting classes conditionally, using the :ref:`inherit_defer
+<ref-bitbake-user-manual-metadata-inherit-defer>` directive is advised as
+:ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>` is
+evaluated at the end of parsing.
+
+.. _ref-bitbake-user-manual-metadata-inherit-defer:
+
+``inherit_defer`` Directive
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
+directive works like the :ref:`inherit
+<ref-bitbake-user-manual-metadata-inherit>` directive, except that it is only
+evaluated at the end of parsing. Its usage is recommended when a conditional
+expression is used.
 
-   inherit ${VARNAME}
+This allows conditional expressions to be evaluated "late", meaning changes to
+the variable after the line is parsed will take effect. With the :ref:`inherit
+<ref-bitbake-user-manual-metadata-inherit>` directive this is not the case.
+
+Here is an example::
+
+   inherit_defer ${VARNAME}
 
 If ``VARNAME`` is
-going to be set, it needs to be set before the ``inherit`` statement is
+going to be set, it needs to be set before the ``inherit_defer`` statement is
 parsed. One way to achieve a conditional inherit in this case is to use
 overrides::
 
    VARIABLE = ""
    VARIABLE:someoverride = "myclass"
 
-Another method is by using anonymous Python. Here is an example::
+Another method is by using :ref:`anonymous Python
+<bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python Functions>`.
+Here is an example::
 
    python () {
        if condition == value:
@@ -830,11 +856,14 @@ Another method is by using anonymous Python. Here is an example::
            d.setVar('VARIABLE', '')
    }
 
-Alternatively, you could use an in-line Python expression in the
+Alternatively, you could use an inline Python expression in the
 following form::
 
-   inherit ${@'classname' if condition else ''}
-   inherit ${@functionname(params)}
+   inherit_defer ${@'classname' if condition else ''}
+
+Or::
+
+   inherit_defer ${@bb.utils.contains('VARIABLE', 'something', 'classname', '', d)}
 
 In all cases, if the expression evaluates to an
 empty string, the statement does not trigger a syntax error because it

---
base-commit: e41c70372ee83320a224d04f46768dc21e6ddd3e
change-id: 20241118-inherit-defer-48d3c8e0c087

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


