Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644EAC25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 20:17:29 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.81425.1698351444434207017
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 13:17:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=dXE0DyYp;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: luca.ceresoli@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 33F18C0002;
	Thu, 26 Oct 2023 20:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698351442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2nnNsmFvWuxq9+3I6allS3mzFjJQEa5VM8G5JwmnpE=;
	b=dXE0DyYpoD9+dx9skTdkNs7geKvUd2xBm/iK9Q2UNisvFRCYchIcLD10rx65lVL1LxIB1y
	aYQL/Y5DAuWe0SY2+xvY9fBX1zlEahco8gBvIiVbMgumo1twFi2FJ95dvzzyvph+52H1pi
	/Kbj/ReJOM0rD98HEAep4gRjEttaGW38qUEU6QV5sz0dnnPB4VTgT9+Q5ItC8ku5ya0bj3
	mVyYpRXin1pDxIi0NI/L0hmnBH4R8TE7jQprd7XjqJRms0FDU5o4aX6Ros4Ow/WNoaqpKb
	Ai2lcMnz2CzGkImOpiNZpSJl3uCkRZzb2fWUncWgtar199u19cfE15r6VcpfFw==
Date: Thu, 26 Oct 2023 22:17:21 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Desone Burns" <dburns@seegrid.com>
Cc: bitbake-devel@lists.openembedded.org, Joseph Chafin
 <jchafin@seegrid.com>
Subject: Re: [bitbake-devel] [PATCH v2] bitbake: fetch2: git: Add git-lfs
 install step
Message-ID: <20231026221721.156aad1f@booty>
In-Reply-To: <CAJZje+twx_dTXN-fwJA604NR6ELcensg63VOk1QJVELAGBpgPQ@mail.gmail.com>
References: <CAJZje+twx_dTXN-fwJA604NR6ELcensg63VOk1QJVELAGBpgPQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 20:17:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15299

Hello Desone,

On Thu, 26 Oct 2023 15:08:20 -0400
"Desone Burns" <dburns@seegrid.com> wrote:

> When downloading a Git repository containing an LFS, the Git hooks
> are not always initialized correctly to perform the download. This
> change updates the Git downloader to run the "git lfs install" command
> in order to "smudge" the LFS files. The tests have also been updated
> to do checks for situations in which git lfs is not installed, as
> the application was required to be installed for any of the tests
> to run previously.
> 
> The Git LFS functionality was working to some degree previously,
> but this change also updates the fetcher to allow LFS downloads for
> nobranch SRC_URIs.
> 
> Signed-off-by: Desone Burns II <dburns@seegrid.com>
> ---
>  bitbake/lib/bb/fetch2/git.py  | 14 ++++++--
>  bitbake/lib/bb/tests/fetch.py | 61 ++++++++++++++++++++---------------
>  2 files changed, 47 insertions(+), 28 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 27a0d05144..5fb573a381 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -52,6 +52,11 @@ Supported SRC_URI options are:
>     For local git:// urls to use the current branch HEAD as the
> revision for use with
>     AUTOREV. Implies nobranch.
> 
> +- lfs
> +    Enable the checkout to use LFS for large files. This will
> download all LFS files

This patch does not apply. The wrapped line here is the reason, or one
of the reasons.

Can you use 'git send-email'? That would simplify life to everybody.

Also check the Contributor guide:
https://docs.yoctoproject.org/contributor-guide/submit-changes.html#sending-the-patches-via-email

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

