Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1200CCA473
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 17:43:45 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.46030.1655833419421484906
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 10:43:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=S0Iq9+Yl;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 0BA46C0007;
	Tue, 21 Jun 2022 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1655833417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wNctmLLbfSsrCadsepU5SZyxOSAWzIOfdX0SrWCpEPI=;
	b=S0Iq9+YlaeZRh/o5BlMKG6i9KHF723A5ZKqZml2MHsGZFxZZtvq9olc8S8t6pFwJsvw10a
	/W1DmIv0t/OvIdlfNHRkDXHJHbsHMZEnjLtG2eGUVuFwMGTF/9nUID+0J4rc0Wk5wDvMwR
	7kkQHFuCgBhcSd9vEkdAMO5GlX8nlOZvdigZBZrJGJKxqqfffftCLjKsZ3bxTrRa1ihWjJ
	WKIfMp9hnSJ4onUnSCj2k7h84OjUDxBYlls488ncLlUYtyPqqZzMA1qHaY54/Y1XznKb1C
	/6NGiJRkndS73uk8/Hb/WdW4lAmmUOO7Kk9DSYN81M/Ck/EEqFwnd/Z/4LOZQw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: add explicit target for crates
 fetcher
Date: Tue, 21 Jun 2022 19:43:23 +0200
Message-Id: <20220621174323.2654545-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jun 2022 17:43:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13776

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Like in other sections describing fetchers

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f9d9e617..ea8a8aa7 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -688,6 +688,8 @@ Here is an example URL::
 
 It can also be used when setting mirrors definitions using the :term:`PREMIRRORS` variable.
 
+.. _crate-fetcher:
+
 Crate Fetcher (``crate://``)
 ----------------------------
 
-- 
2.34.1


