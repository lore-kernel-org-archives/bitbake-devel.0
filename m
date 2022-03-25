Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83261C433EF
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 14:57:55 +0000 (UTC)
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net
 [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web08.6395.1648220273747698136
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 07:57:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=OIy5wd5w;
 spf=pass (domain: bootlin.com, ip: 217.70.178.232,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 83D15200012;
	Fri, 25 Mar 2022 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648220272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/LREZ4KpYSKluBm5Xd9xM/k5DkolipTXr9D94MtxHGM=;
	b=OIy5wd5wyqubGutv/rL+FdOXGBEwuZHWNkoJj6KJf+IHsWLQZt7Zvs3OHRYO05Y1q6mLYH
	bLelCfo7M5GBr11E3jp4N6/dOCD1pk1MW/cRNPUKzCoBtCojHqd2cA7x71g8wO/DhtfeY7
	n3AMaOgK3K4LYW25jiyldNnhi70uJe5v5z5oAJnHMgr3wkwO8YRPQswJCiped89Kofcvo4
	kKBD95DSCY2Gt/sylXCAGmbt91inTEtTMd6mCr64AX7mO1eQBgEwlJp4xADXdiWJFrQpA6
	XtFBnfzdteythENICZK6D0ZLmm1j8CxbnX4iLgSGJrnUT/4piLCrtCrWKpML3Q==
Message-ID: <bb55d51b-1563-07b3-b21c-ba982e811615@bootlin.com>
Date: Fri, 25 Mar 2022 15:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] bitbake: doc: bitbake-user-manual: Improve
 OVERRIDES docs
Content-Language: en-US
To: "Simon A. Eugster" <simon.eu@gmail.com>,
 bitbake-devel@lists.openembedded.org
References: <ca5a3aed-e04c-b2b5-65eb-6bb424d0c379@bootlin.com>
 <20220323121605.144257-1-simon.eu@gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20220323121605.144257-1-simon.eu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Mar 2022 14:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13509

Hi Simon

On 3/23/22 13:16, Simon A. Eugster wrote:
> Improve the explanation about OVERRIDES to clarify how variable
> overrides are chosen based on OVERRIDES.
>
> Signed-off-by: Simon A. Eugster <simon.eu@gmail.com>
> ---
>  .../bitbake-user-manual-metadata.rst          | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index ea42d77c..a78f9048 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -517,20 +517,22 @@ variable.
>  -  *Selecting a Variable:* The :term:`OVERRIDES` variable is a
>     colon-character-separated list that contains items for which you want
>     to satisfy conditions. Thus, if you have a variable that is
> -   conditional on "arm", and "arm" is in :term:`OVERRIDES`, then the
> +   conditional on "arm", and "arm" is listed in :term:`OVERRIDES`, then the
>     "arm"-specific version of the variable is used rather than the
>     non-conditional version. Here is an example::
>  
> -      OVERRIDES = "architecture:os:machine"
> +      # Typically, OVERRIDES contains something like architecture:os:machine
> +      OVERRIDES = "arm:linux:beaglebone"
>        TEST = "default"
> -      TEST:os = "osspecific"
> +      TEST:arm = "armspecific"
>        TEST:nooverride = "othercondvalue"
>  
> -   In this example, the :term:`OVERRIDES`
> -   variable lists three overrides: "architecture", "os", and "machine".
> -   The variable ``TEST`` by itself has a default value of "default". You
> -   select the os-specific version of the ``TEST`` variable by appending
> -   the "os" override to the variable (i.e. ``TEST:os``).
> +   In this example, the :term:`OVERRIDES` variable lists three
> +   overrides: "foo", "linux", and "arm". The variable ``TEST`` by itself


Shouldn't the three overrides be "beaglebone", "linux" and "arm" from
the code above?
Thanks
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


