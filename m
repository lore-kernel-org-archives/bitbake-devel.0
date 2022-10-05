Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE7C433F5
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 20:45:22 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web12.573.1665002719430625276
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Oct 2022 13:45:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=l6AYAIlY;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193,
 mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 9E9B6240011;
	Wed,  5 Oct 2022 20:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1665002717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxV/8mp7OMEvtBsQdqEmvk+HQzmoHa/PiXghAabkimE=;
	b=l6AYAIlYLTFBhnLNdeIej9lTFbZ5WDkYgCU9s1bwHYpw7KvNDDsyGAGfcjuUgEVBu7PrqL
	59ddilGXClxArUa8CaQ/ZhwHiHjeCZC9LjfJJ0AUw8vuZXqg0FtbJDOFYlm7CdygY4+uGF
	PB362AsHSEQ3sX4chmJTr8/BvsjqGv1rCbbWlPUUmOq2Ao2NNXn0KPXUkP10yX98tvZRfR
	u8T6uGWU2Q25jvGLPjbxO5a1HnmhcnWp6vnJKSR1sSl6tYA+tLRrl1gi8kO4llQnvIlUG6
	WmP4EG4cE/MehGkV7ZaT0SaYrHMagRQqN7dPvj3m1P1u0+ONPgX9U5pN4nR7BQ==
Date: Wed, 5 Oct 2022 22:45:13 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Richard Greer" <rg@braneaudio.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH v2] Change git lfs support to allow for
 destsuffix being set.
Message-ID: <20221005224513.43b868c5@booty>
In-Reply-To: <ad8a8eb0-48b7-3d06-f8d3-ddab5747c4f9@braneaudio.com>
References: <ad8a8eb0-48b7-3d06-f8d3-ddab5747c4f9@braneaudio.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Oct 2022 20:45:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14025

Hello Richard,

On Tue, 4 Oct 2022 17:19:47 -0500
"Richard Greer" <rg@braneaudio.com> wrote:

> From: Richard Greer<rg@braneaudio.com>
> 
> When getting large files with git lfs need to try and recreate the
> path where the repo is actually located after the unpack.
> 
> If destsuffix or subdir (where subdir is not an absolute path) is
> set then it will not be in tmpdir/git.
> 
> It looks like the more correct place would be in ud.destdir.
> 
> This does not address the issue where it will fail in the unpack
> if subdir is an absolute path since it cannot possibly be in the
> same path as the tmpdir.  I have no idea as to how to deal with
> that.
> 
> Signed-off-by: Richard Greer<rg@braneaudio.com>
> 
> ---
> v1->v2
>   * Try to get rid of improper line breaks.
>   * Tried git send-email but could not get it to work with our mail
>     server for any settings.
>   * Tried routing it through gmail using personal account as a login,
>     but it failed due to personal account not being subscribed to
>     mailing list.  Do not really want to have my personal email
>     subscribed either.
>   * I do not see line breaks in patch from previous email in what I
>     received from the mailing list, nor do I see it if I look at the
>     post in Chrome on lists.openembedded.org.  So, I hope attempt two
>     works since git send-email does not look like an option for me.

This time the lines appear correct, no line wrapping. Thanks for your
perseverance!

However I'm afraid there's still something incorrect.

> ---
>   bitbake/lib/bb/fetch2/git.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py

As you are modifying bitbake, you should do so a clone of the bitbake
git repository. From the path above, which have a "bitbake" directory
component, I suspect you did your work in a clone if the poky
repository, which is not meant for development. Have a look at the
README.md in the poky repository for more info, and should it still be
not clear we can help you here.

I also tried to apply your patch manually to circumvent this issue but
it didn't apply. I'm not sure about why this is happening, but it might
due to some other reason related to your mailer. I'd suggest to give
'git send-email' another try: it is meant exactly to send patches and
any other tool is likely to create problems. The README.md I mentioned
above has a link to info about setting up your workstation to send
patches in a proper way.

Finally, you might want to subscribe to the mailing list and disable
email delivery, so you won't get emails from the list but you would be
allowed to send emails.

I hope this helps.
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

