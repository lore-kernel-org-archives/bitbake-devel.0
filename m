Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3756C433EF
	for <webhook@archiver.kernel.org>; Fri,  4 Mar 2022 20:12:09 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web09.1272.1646424728599474224
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Mar 2022 12:12:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CauNz0gY;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 5CEC1E0005;
	Fri,  4 Mar 2022 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646424726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J2S7FXTmP99bB2ajxfdtdIhw8n1ZdZLQSyV060IRD54=;
	b=CauNz0gYngGW+t3RZUpd5e+ElFZH+Li0gB/2JQLUIAtOucDjzH35RgWHJECwvOtJPImYn/
	XhMoDSxn2zGCPdD24PY5YLQhGOoR2lX20inFnJpl1Ornsz+qYZiJBANZ4X6/hP4l3njhss
	G97fUPJrIjpqAn7hOLDqMBzOpw91c88KjyhVUvhnqk9Ak5rDfRTRmoqugOvrnR/HPBo5gh
	yRq5+cb0+QKLVpTRlQza7lVvMRpqTAIB9YhortOQuYfDmfmt1ppI43MX56h4/cYOJJeTtt
	xwkFj8haYygzsqJaTq5Mswy57gsGzQDpB49py9jhQB24QRv9gmK0TGMk6FU8Zw==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: further override syntax updates
Date: Fri,  4 Mar 2022 21:11:50 +0100
Message-Id: <20220304201150.418001-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Mar 2022 20:12:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13415

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

---
I think I found some missing updates for the overrides syntax,
but I'm not sure, so please review carefully!
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 174cac78..b90e5cf0 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -511,7 +511,7 @@ variable.
 .. note::
 
    Overrides can only use lower-case characters. Additionally,
-   underscores are not permitted in override names as they are used to
+   colons are not permitted in override names as they are used to
    separate overrides from each other and from the variable name.
 
 -  *Selecting a Variable:* The :term:`OVERRIDES` variable is a
@@ -523,8 +523,8 @@ variable.
 
       OVERRIDES = "architecture:os:machine"
       TEST = "default"
-      TEST_os = "osspecific"
-      TEST_nooverride = "othercondvalue"
+      TEST:os = "osspecific"
+      TEST:nooverride = "othercondvalue"
 
    In this example, the :term:`OVERRIDES`
    variable lists three overrides: "architecture", "os", and "machine".
@@ -567,7 +567,7 @@ variable.
 -  *Setting a Variable for a Single Task:* BitBake supports setting a
    variable just for the duration of a single task. Here is an example::
 
-      FOO_task-configure = "val 1"
+      FOO:task-configure = "val 1"
       FOO:task-compile = "val 2"
 
    In the
-- 
2.25.1


