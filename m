Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323FC54E4A
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 14:16:10 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.21061.1708956965119002268
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Feb 2024 06:16:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=akZU3YiG;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C90D20009;
	Mon, 26 Feb 2024 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708956963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0++Ut+9JHSkrKeCqXAAKLdqrE12HR7gJVUapcUtnQo=;
	b=akZU3YiGTRfKOCsWwMtsBwFA2Hd6ZpzIO5Q/drwSYXQdDmbKWVDfh3WAyhL5DgO+tzgNmd
	2j2fESFgX9pHSoam7RKwucsucctYn3m+0cRamU6LK1L5NvXiabEjx7uHv7u15YBjvkZlSr
	KgnyRIO2vO63viBmMuGvOVNa1zO0ZL+U9ggLc2ACma6L1gqIXivC98oaClX6QtyKd5aNcW
	2e7d/9Y5PEYix2GXPNLGc+uJFQl12XANzZ0m46hpCZaPPisi2eoU/7ZP26fr5XxFwszDlz
	jOekPahyXVvnkPljTjXK8t2ALlk/iM2InYLE9vHM5Mm0+OZegiDalvU+0kTNzg==
Message-ID: <0a3f67b7-06ea-4dc0-bdf6-506098cf46b2@bootlin.com>
Date: Mon, 26 Feb 2024 15:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v3] bitbake: doc: Add section for variable
 context
Content-Language: en-US
To: =?UTF-8?Q?Simone_Wei=C3=9F?= <simone.p.weiss@posteo.com>
References: <20240223192047.7431-1-simone.p.weiss@posteo.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20240223192047.7431-1-simone.p.weiss@posteo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Feb 2024 14:16:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15958

Hi Simone,

On 2/23/24 at 20:20, Simone Weiß wrote:
> From: Simone Weiß <simone.p.weiss@posteo.com>
>
> This is inspired by the same section in the yocto-docs. It aims to provide
> information in what contexts(recipes, .conf, bbclass,...) a variable is usually
> used. For that I tried to group similar variables, so that a short overview is
> given. This was inspired by [YOCTO #14072], but of course does not implement a
> warning if a variable is used in an unintended context.
>
> Signed-off-by: Simone Weiß <simone.p.weiss@posteo.com>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>
> Notes to v3:
> - Applied the fixes suggested in review (thanks for the patch! I hope adding the
>    Signed-off like this during squashing is fine)
> - For the ref label, I plan to come up with an svg that illustrates tasks,
>    recipes, classes, conf (thanks Quentin for the suggestion), but in a generic
>    way and add it to the Concepts section, I want to add a ref from there.
>   
>   ...bake-user-manual-ref-variables-context.rst | 91 +++++++++++++++++++
>   doc/index.rst                                 |  1 +
>   2 files changed, 92 insertions(+)
>   create mode 100644 doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst


Thanks for this new update of this worthy addition to the BitBake 
documentation! Everything looks good now.
Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


