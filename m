Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96CC433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 18:38:32 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web08.1765.1646678310427633775
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 10:38:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=UijyZIhr;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 05C2DE0003;
	Mon,  7 Mar 2022 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646678308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0pyhnCSh+Ky1TlplVFsBj1/aB+Cl9i+JsJ20J3Ye+Y=;
	b=UijyZIhrGt3ZAHdpiGYvx60vU8B8vPaXPjzhclaqzTR/KucSwi5mpeTRn0epp35VysD+E7
	DPEfi+J8Gs+nfoahHBiUqIh3DCujOPYH4qL7QxbCNX2XRUk+3L2QlhCDynqX68AN+ImsIr
	wlcLQI2AVJdLQbJJZE78m9w42Rmgmb2LDebWvCVjIc9X9vaxvJ2VqD9+62BLFrBCyEB478
	k1pz/UTsWp3DOUl/RlXxh9o93sGHrAaXA2u8PtIA9W1lBuzreGpW6XgXbq+mLRhlVdURJO
	Dpgj5RQpt3vo+tiJG6qvcmgV0C21trORiZexmP6Zi5IsUvfge7Jld/fW05jFPA==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH] bitbake-user-manual: add note about the old syntax for
 OVERRIDES
Date: Mon,  7 Mar 2022 19:38:03 +0100
Message-Id: <20220307183803.534661-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: 
 <6035008ce96fb9055547cf0cc2ffa51d2262c9ea.camel@linuxfoundation.org>
References: 
 <6035008ce96fb9055547cf0cc2ffa51d2262c9ea.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 18:38:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13437

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reported-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-metadata.rst                   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b90e5cf0..97114ed6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -585,6 +585,16 @@ variable.
 
       EXTRA_OEMAKE:prepend:task-compile = "${PARALLEL_MAKE} "
 
+.. note::
+
+   Before BitBake 1.52 (Honister 3.4), the syntax for :term:`OVERRIDES`
+   used ``_`` instead of ``:``, so you will still find a lot of documentation
+   using ``_append``, ``_prepend``, and ``_remove``, for example.
+
+   For details, see the
+   :yocto_docs:`Overrides Syntax Changes </migration-guides/migration-3.4.html#override-syntax-changes>`
+   section in the Yocto Project manual migration notes.
+
 Key Expansion
 -------------
 
-- 
2.25.1


