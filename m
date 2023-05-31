Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9693AC77B73
	for <webhook@archiver.kernel.org>; Wed, 31 May 2023 18:47:08 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.2538.1685558827770852104
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 May 2023 11:47:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Kj3Uy4PW;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: alexandre.belloni@bootlin.com)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1685558825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPEvLEELRKdyCwZRjggTW1AJXp3jqOwF5Q7OKuibt4Y=;
	b=Kj3Uy4PW1AXPYB6lJeo/E7SWsarxQIhGvWUbR13WvB8YuM9eU5dEJ2BIK5+DfusBWte2b/
	Vsg1WhbGBrZPtkYHQ6J+K3C1vFJdoaY73/ChsqcO9N9MyBRyya9RYnuuRU8y4Zfd54MH68
	EmXwI4M2QSaaRVPtNYgKJrCW9zPutaz2aj63HRDyNI7R4zuUFsqyXZJpaq9pain/EpyjBu
	S/F8CUVVc+sTRfoE3OtZlm8ifvotoE4ydbY/tF3IrXwSQ/ER9hOXaRlOCkUKskTZCVXhtS
	pv5S3xQnwUhPm1FCLvvYFusDg72pvbC4kl6iZ0Joq8TZmgx2UAOO8xrSs9Gdkw==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5132F1BF204;
	Wed, 31 May 2023 18:47:05 +0000 (UTC)
Date: Wed, 31 May 2023 20:47:05 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: belouargamohamed@gmail.com
Cc: bitbake-devel@lists.openembedded.org,
	f.lahoudere@technologyandstrategy.com,
	e.aubineau@technologyandstrategy.com,
	j.guignard@technologyandstrategy.com,
	BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: Re: [bitbake-devel] [master][PATCH] fetch2: npmsw: Don't fetch dev
 dependencies when they are not demanded
Message-ID: <202305311847057862e591@mail.local>
References: <20230530224254.43797-1-m.belouarga@technologyandstrategy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530224254.43797-1-m.belouarga@technologyandstrategy.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 May 2023 18:47:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14821

Hello,

This doesn't apply on master at all, can you rebase?

Thanks!

On 31/05/2023 00:42:54+0200, belouargamohamed@gmail.com wrote:
> From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
> 
> Dev dependencies should not be fetched only if it is specified in the
> recipe.
> 
> Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
> ---
>  lib/bb/fetch2/npmsw.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
> index 359192a2..d89be10c 100644
> --- a/lib/bb/fetch2/npmsw.py
> +++ b/lib/bb/fetch2/npmsw.py
> @@ -49,6 +49,8 @@ def foreach_dependencies(shrinkwrap, callback=None, dev=False):
>          if package != "":
>              name = package.split('node_modules/')[-1]
>              package_infos = packages.get(package, {})
> +            if dev == False and package_infos.get("dev", False):
> +                continue
>              callback(name, package_infos, package)
>  
>  class NpmShrinkWrap(FetchMethod):
> -- 
> 2.25.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14819): https://lists.openembedded.org/g/bitbake-devel/message/14819
> Mute This Topic: https://lists.openembedded.org/mt/99230772/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

