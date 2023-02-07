Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C79C636CD
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 11:01:00 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.80705.1675767658501460271
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Feb 2023 03:00:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=cv93hV/t;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C80A5C000A;
	Tue,  7 Feb 2023 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1675767656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWEM2eoGoaZZ2OOyhbcdpp0fQ7Rjf1xvetQZbBN/q34=;
	b=cv93hV/tvAhmIDUXfLLs+OulWY+Zwaf2s++Q0Q7dqUFXXZ9LZ7kSNLmPjf7auqpwqy6XG0
	t+f6ifTNI12hzUQyI8yaXbXaoV5iqimC4rF3qH3zkbWilE1T4QEC+BuclspTPeNlxmW+JX
	tBoH8dGZckEFvV7UuQS4tDk1hSWLKU4/Juv52uurZfKBsOv2g4qPlNTusGOM9eejvYOle6
	7+A6EFVsmI1q4NLNlMtC1IAYepUCrbu+3Q0HILtrn58sHe3Na2yMarVrtuWuchMzIbMG1q
	VGCXbHkAwQ8w2dAsParLNNPtmkrnyS+teraAppyd8J3nCW7Ef4e1i42H5k7uLg==
Date: Tue, 7 Feb 2023 12:00:54 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "George Kelly" <george.kelly1097@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [[bitbake][PATCH]] If you are behind a
 corporate proxy, the npm fetcher uses the proxy IP address already passed
 in the list of exports. However, it will error if the proxy injects its own
 root CA certificate. Thus, the NODE_EXTRA_CA_CERTS environment variable
 must be passed so the user can include their company's root CA as a trusted
 CA inside node's certificate store.
Message-ID: <20230207120054.754519dc@booty>
In-Reply-To: <20230206191142.17353-1-george.kelly1097@gmail.com>
References: <20230206191142.17353-1-george.kelly1097@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 11:01:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14375

Hello George,

thank you for your patch.



On Mon,  6 Feb 2023 14:11:42 -0500
"George Kelly" <george.kelly1097@gmail.com> wrote:

> Signed-off-by: George Kelly <george.kelly1097@gmail.com>

I'm not qualified to review the content of your changes, but
definitely your patch needs to have a better formatting. Don't
put a long description in the first line of the got commit
message (which also ends up in the e-mail subject).

The "[[bitbake][PATCH]]" also looks weird.

I recommend you to read the guidelines at
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
in order to prepare a good commit message and to send your patch
in a way that makes it more easily reviewed, applied and tested.

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

