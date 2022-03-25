Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE77C433EF
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 14:35:50 +0000 (UTC)
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net
 [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web08.6103.1648218949406934645
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 07:35:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=EVnnv8BZ;
 spf=pass (domain: bootlin.com, ip: 217.70.178.232,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E8732200007;
	Fri, 25 Mar 2022 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648218948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qkjnutHRe1slsBtV7zu6TZ7we2uaiIqTzF9qLZCv00=;
	b=EVnnv8BZDTJU+nVUJGP9IWOK9walGlQd2apjTT6jTnCPt5/UXYeUOT9vJfaXaRBTJOpZlH
	XGFrfoJEfNEoYIpwqppSiqPTmX8B2kM5otdkN5hE/92edE9T7YHuWjie+Y89azN0BaIRpJ
	DLIDnQ3wPYuKhP1ztJ/59+L2LRKoW3wblBeXcE32f1xNmsxEOka/yEdsVh7QdOWpFxyokR
	cHCKc1XsftsCNb90ySlXs7oK60h5bTKVcvgropVDQlSq04eixJvrGakV7CadKKCFFIEQUf
	PpCQHLZQsmPbYVBkz4idb4AdQntVxi6jTMSZs6wh2pqFZ86+43PeCSBGsGk58A==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH RESEND 2/2] doc: bitbake-user-manual: branch parameter now
 mandatory in git SRC_URIs
Date: Fri, 25 Mar 2022 15:35:36 +0100
Message-Id: <20220325143536.139665-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325143536.139665-1-michael.opdenacker@bootlin.com>
References: <20220325143536.139665-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Mar 2022 14:35:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13508

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

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


