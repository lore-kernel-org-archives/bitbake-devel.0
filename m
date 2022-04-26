Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AEBC433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Apr 2022 21:49:28 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web09.960.1651009763534116338
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Apr 2022 14:49:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=F0cwil9R;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 4EF3E100002;
	Tue, 26 Apr 2022 21:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1651009761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IxiF7bBUzU6V3cfl9RJjyARwketN9MjwfNmFaPsD7YM=;
	b=F0cwil9R1JjPY2WYz090LMmhsldaO231ufKilr/KOpS573U3kkuxJVfCpcsGsA0wux8HPF
	qduJ9SJRt6gI6w51ok1s4KaLxbgUxY6IshYEWLnIxi//97nnW4/puvxXalqYi8vEA74spv
	x5Bh/JGEOEUWfhhKew4yN9MFxhdWgePUwv1mV1vDzXhERKc9wwpUuBIj2ozR16h/GSLVpG
	RKHpHa/4y2ISET93iHuffcoGsadTrJompS8lYpLwoNG9fUn1MxYTF422b3yCHg0Hfbm38z
	eCrTeobV+uHTrzmosKhltxeyN+8fpr+XID4gtoGYnHk/u7fA0P8ZuotXytxPUg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: document TEMPLATECONF environment
 variable
Date: Tue, 26 Apr 2022 23:49:01 +0200
Message-Id: <20220426214901.201802-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Apr 2022 21:49:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13658

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index af4ff980..80005580 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1483,6 +1483,22 @@ overview of their function and contents.
       consist mostly of task logs and scripts, when building a particular
       recipe.
 
+   :term:`TEMPLATECONF`
+      Specifies the directory used by the build system to find templates
+      from which to build the ``bblayers.conf`` and ``local.conf`` files.
+      Use this variable if you wish to customize such files, and the default
+      BitBake targets shown when sourcing the ``oe-init-build-env`` script.
+
+      For details, see the
+      :yocto_docs:`Creating a Custom Template Configuration Directory
+      </dev-manual/common-tasks.html#creating-a-custom-template-configuration-directory>`
+      section in the Yocto Project Development Tasks manual.
+
+      .. note::
+
+         You must set this variable in the external environment in order
+         for it to work.
+
    :term:`TOPDIR`
       Points to the build directory. BitBake automatically sets this
       variable.
-- 
2.25.1


