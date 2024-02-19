Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BF6C48BF8
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 18:44:56 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.2090.1708368287856828591
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Feb 2024 10:44:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bXWRDOQ+;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17F6840004;
	Mon, 19 Feb 2024 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708368285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtbmV7e6KznixlxXlKgaxCZCpvJWhOS1gc/GL+uaHnk=;
	b=bXWRDOQ+XsDt55/pw/y5Tyy2zR3O0cYz1TW4Ld8sxRw6V5F30VdXLw0dGohYMlos/+DYNS
	eHlb4ID5pyOjA0SUv/6QAKyRN1KN9W1aGIMaRxhnOU++N23o0kQotbaW0HiMnp+DCQ0QBm
	yGXfQtcObz9zdR07FoFmSo/kpnl1qnIUsB0baZq4N+RUVWNLAHxFHRUUzg77YNfrFdUQdM
	We2ESxoXBOht5LcJpFZdYjKL7xzhKp0wNgW01iP+CpWBQLC2oCBdkaL4LUNVjC4jNYq1yK
	DgxeZcePZp2SKc4liW2avsu4yuOAkcSMZwpy1txMsv4iYi1APkSgPiGT2Ca8GA==
Message-ID: <192680d9-bb72-44ab-84cd-40972ba78417@bootlin.com>
Date: Mon, 19 Feb 2024 19:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [docs] [PATCH v2] bitbake: doc: Add section for variable context
Content-Language: en-US
To: =?UTF-8?Q?Simone_Wei=C3=9F?= <simone.p.weiss@posteo.com>
References: <20240217110704.49901-1-simone.p.weiss@posteo.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20240217110704.49901-1-simone.p.weiss@posteo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 18:44:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15943

Hi Simone,

Many thanks for the updates!

On 2/17/24 at 12:07, Simone Weiß wrote:
> From: Simone Weiß <simone.p.weiss@posteo.com>
>
> This is inspired by the same section in the yocto-docs. It aims to provide
> information in what contexts(recipes, .conf, bbclass,...) a variable is usually
> used. For that I tried to group similar variables, so that a short overview is
> given. This was inspired by [YOCTO #14072], but of course does not implement a
> warning if a variable is used in an unintended context.
>
> Signed-off-by: Simone Weiß <simone.p.weiss@posteo.com>
> ---
>   ...bake-user-manual-ref-variables-context.rst | 89 +++++++++++++++++++
>   doc/index.rst                                 |  1 +
>   2 files changed, 90 insertions(+)
>   create mode 100644 doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst
> new file mode 100644
> index 00000000..8252889e
> --- /dev/null
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst
> @@ -0,0 +1,89 @@
> +.. SPDX-License-Identifier: CC-BY-SA-2.0-UK


Oops, I overlooked this. The license doesn't match the one in the other 
documents. I'm not sure this matters though...

> +
> +****************
> +Variable Context
> +****************


Oops, another issue: your section doesn't appear in the top left menu, 
and when I look at it, it doesn't have any numbering.
I guess this happens because you didn't start your section with the same 
headers as the other documents.

Using the same headers as in the previous document fixes the trouble:

================
Variable Context
================

....

BitBake's own configuration
===========================

> +
> +Variables might only have an impact or can be used in certain contexts. Some
> +should only be used in global files like ``.conf``, while others are intended only
> +for local files like ``.bb``. This chapter aims to describe some important variable
> +contexts.
> +
> +.. _ref-varcontext-configuration:

Why this anchor? Do you plan to make references to it elsewhere? Just to 
double check...
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


