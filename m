Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B635EC4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Mar 2022 17:53:40 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.557.1646848419723550062
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Mar 2022 09:53:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=j8qLHgoP;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 561C940009;
	Wed,  9 Mar 2022 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646848417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdXW+Pb6fe6vtTAnjJ7tjrKAwVAww/nvR+RqoSFrNF0=;
	b=j8qLHgoP617u5ij4hGcxmvbDjgej9INb9DjFWJAWZc7XzA/RSLu9GowkRrRpXuuG7Gwcyu
	FjmmP3Bvim7vHCGCzlekL7HZUeJ/75asXoFEllqAYef6+zNsfuih+Cfcye99YKanzR07iR
	wiq8APC8SfXYKr9Ri2NFOSFpEEB7pOrRNfycQTmk+U7OiYwyYHbkwOlt6JTEtuUgMtOiej
	DYI8TzwcnsSRpPiSYBTDDb8B0NfmwDPU6/iKF5Ob1mPtX4B3sr/5TD+4R7XLGk35OL50Rt
	yQa2uSclHMtSnJTPZkWohqP9iRVBbSX8ZyLxx1DuX2HRFwhfA8VgUOs+Z+IA/A==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH 2/2] doc: bitbake-user-manual: branch parameter now mandatory
 in git SRC_URIs
Date: Wed,  9 Mar 2022 18:53:19 +0100
Message-Id: <20220309175319.620707-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309175319.620707-1-michael.opdenacker@bootlin.com>
References: <20220309175319.620707-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Mar 2022 17:53:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13456

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index ae2d3a17..d0c78062 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -432,8 +432,8 @@ This fetcher supports the following parameters:
    raw Git metadata is provided. This parameter implies the "nocheckout"
    parameter as well.
 
--  *"branch":* The branch(es) of the Git tree to clone. If unset, this
-   is assumed to be "master". The number of branch parameters much match
+-  *"branch":* The branch(es) of the Git tree to clone. This is a
+   mandatory parameter. The number of branch parameters must match
    the number of name parameters.
 
 -  *"rev":* The revision to use for the checkout. The default is
-- 
2.25.1


