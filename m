Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD1D4923C
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 15:36:59 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.43946.1731944212497863495
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Nov 2024 07:36:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=MfBZVGUC;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F95860009;
	Mon, 18 Nov 2024 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731944210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a2hM+cc1NagBOr70TAgQLtXs4RosSJAe7JxxSzLbu+0=;
	b=MfBZVGUCKsMMSCp6OumkCw9tgucFq/p51wH/+du+OjzaLTbCK/himKrJ1gB1uLMSqOvNIJ
	VWXsorxo3JVVLUgwTbvUPDn85vfZ4TdOlDS4W4FADWoJyMEMkGQEYuOJCZg5tewogdTi4S
	vuvQj5AOMIlkAa2cR45iZENKgKhuSAlNIQbXFMysUKyPEx75KGNOzQlsnA+6brbpHWXomo
	06m9NepZlLGVroiaoYaWk75gyCizZgSZRFsYeMzU9GmnFNkBSSp+RMo/tl1ENqTaACPzf9
	C8ZD7Bhoc1OwdQYYbBh/IMLY51qXN+36K0XwXjLEnHwWeOBvdfWOTGe9WFcMag==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 18 Nov 2024 16:36:18 +0100
Subject: [bitbake-devel PATCH] doc: bitbake-user-manual: document
 inherit_defer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-inherit-defer-v1-1-26866a60ab1b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPFeO2cC/x3MQQqAIBBA0avErBMcExq6SrQIHXM2FhoRiHdPW
 v7F+xUKZ+ECy1Ah8yNFztQDxwFc3NPBSnxvMNpYRCQlKXZxK8+Bs7LkJ0esnaYZurkyB3n/37q
 19gG890ZqXwAAAA==
X-Change-ID: 20241118-inherit-defer-48d3c8e0c087
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Yoann Congal <yoann.congal@smile.fr>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=olHR7XxUVgL1zAY8XBkUlpErGeI4hrkzQ9ePYbBchog=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnO18SjwRAT8yIekAm1dDgLZpHJsiGUESb0p8wL
 EVuEQwOlO+JAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZztfEgAKCRDRgEFAKaOo
 NgPvEADBQFNe/OphA/pmy4zNcahACczFVAlc0jNeK3k3X6aUc95rVjzZirxCXCLJHSRANc8cV/l
 GaXoFtzKj3oT8DvIVtiRFPsrJ03hWOmSlKsTUXYazbwDJjMJRTHFopGgj9hsLNfFINE917/qFM9
 7RYczV4uH0ubmPAea18la+0yUxpSo0S3le4X/v/5f8Qh/zUbh+L8QCjCX/cGo1I3GVPI909cHZ8
 NCBYEera1IXbreoNexDD8VCtqPgEiRlDccqWc8N83UawjlWs3jYrKYOF/r3gWXtY7eli/QpfAWX
 tpWJnBts8nhhFX8IQqXw4tFah4T9+LWKTe+C5lpT3xGmSLzGPU0xUcjA8v7KHDQyeZ360WPpH68
 9DUrSpBJeeMhJV3RVCQ9u10ByPK3HAOWbRaBzcpOrsU2x6UOmKG9ApXbN2AznqrhD/acl5IuJ0m
 2oWaUFOqLoaPPs/NLt0d/tk6NFkUXPg/d2asrFr0SW363clXnsKnV8/Su7grmgSCp4q3BqimcIH
 xH6Wr0JY4qA1uWVyzP4TTbRl/iOQwMscpoURCrdYekw5CENrSUWqu/J2vVvawrYfOPmux6OGAQ3
 HAUHyMrZMOM0E0yKXkquG5QBvL6CFkm+cI1lKRMyFgjMn1UTGs3XRH3by7k/7Zen4pvXdjDhppb
 8JpCCj2U4wK+tVA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 15:36:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16804

This was added in 2.7.2. Add it as a subsection of the inherit
directive.

Fixes [YOCTO #15640].

Reported-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 58975f4c88ce549a2fd27136c0cb37b636bafcdb..ab16ddde3cf837092d4c43e467b4becceae23b27 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -840,6 +840,19 @@ In all cases, if the expression evaluates to an
 empty string, the statement does not trigger a syntax error because it
 becomes a no-op.
 
+``inherit_defer`` Directive
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``inherit_defer`` directive works like the ``inherit`` directive, except
+that it is only evaluated at the end of parsing. Its usage is recommended when a
+conditional expression is used. For example::
+
+   inherit_defer ${@bb.utils.contains('PACKAGECONFIG', 'python', 'python3targetconfig', '', d)}
+
+This allows conditional expressions to be evaluated "late", meaning changes
+to the variable after the line is parsed will take effect. With the ``inherit``
+directive this is not the case.
+
 ``include`` Directive
 ---------------------
 

---
base-commit: 40ca2b66df610ac74918edf54369781f52b03728
change-id: 20241118-inherit-defer-48d3c8e0c087

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


