Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA7EC7EE2F
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 10:18:05 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.19927.1677838682767548529
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Mar 2023 02:18:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CB/ViLJi;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 503666000D;
	Fri,  3 Mar 2023 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677838680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vaCSzUnWMcjVYWH0ZnXKAf/dhopJOHReZ+1Wmu/8XLM=;
	b=CB/ViLJi3Byb53vksaAWppAIcLd4kRhzQFT9H6b60b7pcWKX71ie0J7zHc1x75KWv64LBC
	VtAsDVzfdslehAw++suW3ujx15oqfc1JWjI2nJcXT/+igOo5LxYwnnl1n26hw8sy9VH8co
	kpi3zdVb8nZXgejrzEcHrj19esfWJ8IIilGY5GQ9dTk2OidEHaUO3JhvwpaeDiKIqOpT4G
	N8Of01zsaqPwWTrw9EYVeUwTcqRx9p9GZVFC0wjb2EtjXEtHSGZeR61oqEfVtZyk6K6QHA
	N8l4VZ7qcxpt8lJSbLM9P7DvQj2VQUeUQhTvLsRqtOeBOeE+FebaO8YxcxX1dw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: fix links to supported release manuals
Date: Fri,  3 Mar 2023 11:17:50 +0100
Message-Id: <20230303101750.533185-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Mar 2023 10:18:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14520

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Links to manuals for supported releases were all broken.
Only the pre-sphinx ones are still valid.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/releases.rst | 76 +++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/doc/releases.rst b/doc/releases.rst
index 6635032c..6a9774d4 100644
--- a/doc/releases.rst
+++ b/doc/releases.rst
@@ -1,61 +1,57 @@
 .. SPDX-License-Identifier: CC-BY-2.5
 
-===========================
- Supported Release Manuals
-===========================
+=================================
+BitBake Supported Release Manuals
+=================================
+
+*****************************
+Release Series 4.1 (langdale)
+*****************************
+
+- :yocto_docs:`BitBake 2.2 User Manual </bitbake/2.2/>`
+
+*****************************
+Release Series 4.0 (kirstone)
+*****************************
+
+- :yocto_docs:`BitBake 2.0 User Manual </bitbake/2.0/>`
+
+****************************
+Release Series 3.1 (dunfell)
+****************************
+
+- :yocto_docs:`BitBake 1.46 User Manual </bitbake/1.46/>`
+
+================================
+BitBake Outdated Release Manuals
+================================
 
 ******************************
 Release Series 3.4 (honister)
 ******************************
 
-- :yocto_docs:`3.4 BitBake User Manual </3.4/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.4.1 BitBake User Manual </3.4.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.4.2 BitBake User Manual </3.4.2/bitbake-user-manual/bitbake-user-manual.html>`
+- :yocto_docs:`BitBake 1.52 User Manual </bitbake/1.52/>`
 
 ******************************
 Release Series 3.3 (hardknott)
 ******************************
 
-- :yocto_docs:`3.3 BitBake User Manual </3.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.1 BitBake User Manual </3.3.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.2 BitBake User Manual </3.3.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.3 BitBake User Manual </3.3.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.4 BitBake User Manual </3.3.4/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.5 BitBake User Manual </3.3.5/bitbake-user-manual/bitbake-user-manual.html>`
+- :yocto_docs:`BitBake 1.50 User Manual </bitbake/1.50/>`
 
-****************************
-Release Series 3.1 (dunfell)
-****************************
+*******************************
+Release Series 3.2 (gatesgarth)
+*******************************
+
+- :yocto_docs:`BitBake 1.48 User Manual </bitbake/1.48/>`
+
+*******************************************
+Release Series 3.1 (dunfell first versions)
+*******************************************
 
 - :yocto_docs:`3.1 BitBake User Manual </3.1/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.1 BitBake User Manual </3.1.1/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.2 BitBake User Manual </3.1.2/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.3 BitBake User Manual </3.1.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.4 BitBake User Manual </3.1.4/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.5 BitBake User Manual </3.1.5/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.6 BitBake User Manual </3.1.6/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.7 BitBake User Manual </3.1.7/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.8 BitBake User Manual </3.1.8/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.9 BitBake User Manual </3.1.9/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.10 BitBake User Manual </3.1.10/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.11 BitBake User Manual </3.1.11/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.12 BitBake User Manual </3.1.12/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.13 BitBake User Manual </3.1.13/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.14 BitBake User Manual </3.1.14/bitbake-user-manual/bitbake-user-manual.html>`
-
-==========================
- Outdated Release Manuals
-==========================
-
-*******************************
-Release Series 3.2 (gatesgarth)
-*******************************
-
-- :yocto_docs:`3.2 BitBake User Manual </3.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.2.1 BitBake User Manual </3.2.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.2.2 BitBake User Manual </3.2.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.2.3 BitBake User Manual </3.2.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.2.4 BitBake User Manual </3.2.4/bitbake-user-manual/bitbake-user-manual.html>`
 
 *************************
 Release Series 3.0 (zeus)
-- 
2.37.2


