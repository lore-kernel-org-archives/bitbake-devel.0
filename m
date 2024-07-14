Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFD2C3DA49
	for <webhook@archiver.kernel.org>; Sun, 14 Jul 2024 11:13:28 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.14300.1720955606063340871
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Jul 2024 04:13:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=AVagxkp6;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEFC260004;
	Sun, 14 Jul 2024 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720955604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ErPBO6D8I5dPFLpTkUuI2wtTQ794vyCmS1MEVn4y9kM=;
	b=AVagxkp6JK/naMOavifKkUQ8Q/gdeGtkf/6ok6MJNdotksaDF0M/Z8qcbAW08vc4vBGHyK
	5NEyb3CQlQ8nv4hML4HvHl+heIotGnFDUMq8w6c9WH0eebfpAtbn+Vb9L/BkIwHbe0yFPD
	s4E4bfeGFu79V1JRAP7EdcLiv32Cz3zUfGRLg385jnqmi9iJsaYy0t4bfo3lnpryLrP2CE
	K9MeyPRKNzpwS4Vw37rszywreq9Te6skq9UW4VSOkZ0kZluwq/Dyiu6a+4A2sjmPY2Iup6
	pK/kjEc9p5IhYBw4uQJJNpfSfBhcX7EnxMA/CLzjqVuTZQhnTcEy6/x5tnhMtA==
Date: Sun, 14 Jul 2024 13:13:23 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org,
	tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org
Subject: Re: [bitbake-devel] [PATCH v2 2/4] npm: accept unspecified versions
 in package.json
Message-ID: <2024071411132327e82ea7@mail.local>
References: <20240708133357.306422-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240708133357.306422-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708133357.306422-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 11:13:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16418

Hello,

It is not possible t apply this patch as it touches two different
repositories: bitbake and oe-core, can you separate it?

On 08/07/2024 15:33:55+0200, Enguerrand de Ribaucourt wrote:
> Our current emulation mandates that the package.json contains a version
> field. Some packages may not provide it when they are not published to
> the registry. The actual `npm pack` would allow such packages, so
> should we.
> 
> This patch adds default values to allow building such packages.
> For the shrinkwrap, we can actually use the resolved field which
> contains the exact source, including the revision, to pass integrity
> tests.
> 
> This applies for instance to this package which doesn't declare a
> version:
>  - https://github.com/cockpit-project/cockpit/blob/23701a555a5af13f998ee4c7526d27fdb5669d63/package.json#L2
> 
> Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
> Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
> ---
>  bitbake/lib/bb/fetch2/npmsw.py  | 2 +-
>  meta/classes-recipe/npm.bbclass | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw.py
> index 018e0ad546..044f5b96f8 100644
> --- a/bitbake/lib/bb/fetch2/npmsw.py
> +++ b/bitbake/lib/bb/fetch2/npmsw.py
> @@ -97,7 +97,7 @@ class NpmShrinkWrap(FetchMethod):
>  
>              integrity = params.get("integrity", None)
>              resolved = params.get("resolved", None)
> -            version = params.get("version", None)
> +            version = params.get("version", params.get("resolved", None))
>  
>              # Handle registry sources
>              if is_semver(version) and integrity:
> diff --git a/meta/classes-recipe/npm.bbclass b/meta/classes-recipe/npm.bbclass
> index 91da3295f2..a73ff29be8 100644
> --- a/meta/classes-recipe/npm.bbclass
> +++ b/meta/classes-recipe/npm.bbclass
> @@ -72,8 +72,10 @@ def npm_pack(env, srcdir, workdir):
>          j = json.load(f)
>  
>      # base does not really matter and is for documentation purposes
> -    # only.  But the 'version' part must exist because other parts of
> +    # only. But the 'version' part must exist because other parts of

This is an unrelated change and two spaces after a period is correct.
I'd say don't do this unless you go and change the other 154 occurrences
(You also probably don't want to enter this debate)

>      # the bbclass rely on it.
> +    if 'version' not in j:
> +        j['version'] = '0.0.0-unknown'
>      base = j['name'].split('/')[-1]
>      tarball = os.path.join(workdir, "%s-%s.tgz" % (base, j['version']));
>  
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16403): https://lists.openembedded.org/g/bitbake-devel/message/16403
> Mute This Topic: https://lists.openembedded.org/mt/107102416/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

