Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D893BC433EF
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 16:40:33 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web12.11774.1646930433228770168
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 08:40:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=f3uvbqfN;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id AB484240009;
	Thu, 10 Mar 2022 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646930431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMU9PckYLO9BCnu51KBRrGieDv+7/pLUt2C0R9JL13o=;
	b=f3uvbqfNu69qMXt30NYNbZx8YWjvwJaOnn8/VjA0ORTzw2/AzS0sl/Cz/+GCO6fEqXd6M0
	pIgN0Us3y2+ZeemejrFagImBswwPdEWDD2Xg5ZMM3VmNIQgUfAcR0gbX8y2Y7POgm8xHLr
	HO7KUEeWMSOkmkei7VtH+FBRoPU0pRHpoUORkaYuSLq8dsNvb2eejPq4+gRYlU1ai9h36b
	O4gpSD1p9JM9cS+/OsggpYP8wFbquAABYYshQWsHjrsYCjIz289/sErP32uMyagmDAHTxK
	r29OwgqmIzPZbjYMYtPQvA1tkQ0KDWc2H3gDydLA9x5QTPuXkHo3bSCrQMpYrQ==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH v2 2/2] doc: bitbake-user-manual: branch parameter now
 mandatory in git SRC_URIs
Date: Thu, 10 Mar 2022 17:40:19 +0100
Message-Id: <20220310164019.24515-3-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310164019.24515-1-michael.opdenacker@bootlin.com>
References: <16DB126739A33B35.20222@lists.yoctoproject.org>
 <20220310164019.24515-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 16:40:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13471

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 07885392..f9d9e617 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -432,9 +432,9 @@ This fetcher supports the following parameters:
    raw Git metadata is provided. This parameter implies the "nocheckout"
    parameter as well.
 
--  *"branch":* The branch(es) of the Git tree to clone. If unset, this
-   is assumed to be "master". The number of branch parameters much match
-   the number of name parameters.
+-  *"branch":* The branch(es) of the Git tree to clone. Unless
+   "nobranch" is set to "1", this is a mandatory parameter. The number of
+   branch parameters must match the number of name parameters.
 
 -  *"rev":* The revision to use for the checkout. The default is
    "master".
-- 
2.25.1


