Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4552C77B71
	for <webhook@archiver.kernel.org>; Tue, 18 Apr 2023 10:25:02 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.5129.1681813495084775789
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Apr 2023 03:24:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=U3BA9T8V;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id AA6DB1C0003;
	Tue, 18 Apr 2023 10:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1681813493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FbbZn48aEDucpNPIgm4TKsf/OC4fPyM6VzOA+ZoP9w=;
	b=U3BA9T8VGch4J8duMzlRVr9uvFdhX5aGp2AYhg3/d7o2yb0eD/BH50lOfVwGEBLKFmYALj
	878Qt9QH7uP9y/NEsGCTD9jMAFwg4NfWiW5GzOp6BOLvMEhyZXn/XJsMd/veKppA/7VZ5s
	+O8yJn7ADSoVM+zDV8yj2S0ANqpyuxWY00wW5/QSx32x6WZh5DUnL6MUzrL+ScW28K3YH+
	yA6JdXVpMFT1J39C7N6v9Re6mXl1vUNuFgcN7gR+wN9CXdkhJtR8ILHPf0Mz2zUCAbvEJJ
	m0GhoXTDWuM0S/2eS0QNUJIXAtZpCksR6ZgY0xB3JcZqQAy2mFOjtj8MrWlHaA==
Date: Tue, 18 Apr 2023 12:24:51 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Svend Meyland Nicolaisen" <public@smn.dk>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] npmsw fetcher: Avoid instantiating
 Fetch class if url list is empty
Message-ID: <20230418122451.2e24ce87@booty>
In-Reply-To: <20230417211228.1838-1-public@smn.dk>
References: <20230417211228.1838-1-public@smn.dk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Apr 2023 10:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14714

Hello Svend,

On Mon, 17 Apr 2023 23:12:28 +0200
"Svend Meyland Nicolaisen" <public@smn.dk> wrote:

> Recipes containing both git and npmsw sources in the SRC_URI fail
> during fetch from the shrinkwrap. It seems that when the fetcher is
> fetching from the shrinkwrap, the SRCREV variable has been deleted but it
> till ends up fetching from the git source resulting in an error because
> SRCREV is undefined. The root cause of this is that the Fetch class defaults
> to urls from the SRC_URI when the urls parameter contains an empty list. This
> patch will ensure that Fetch is not instantiated if the urls list is empty.

Thank you, looks much better now! I have sent the e-mail in appropriate
ASCII so it can be applied with 'git am' here as Michael told you, and
you fixed the commit title.

There are still a couple things you should improve (good news: those
are easier).

From
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded:

 * All commit messages must include Signed-off-by (git commit -s)
 * Please substitute "PATCH" with "PATCH v2" if you are submitting a
   revised version after addressing feedback (or v3, v4 etc.) 
   (git commit -v<NUMBER>)

Can you resend with those fixed please?

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

