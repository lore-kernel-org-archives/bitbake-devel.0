Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1F2C4167B
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 13:27:09 +0000 (UTC)
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net
 [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web11.26021.1646659627907452840
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 05:27:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=J1BonxF6;
 spf=pass (domain: bootlin.com, ip: 217.70.178.232,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E8139200013;
	Mon,  7 Mar 2022 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646659626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+ECjKzoRr0fejksra66VmrVNg6zMSk23qzuRGfGakw=;
	b=J1BonxF6Pb7L6gGOMFPKV7ea4tdWNHS7bnvoF4PtjFVffcjkeIX2XMRVr3evmLVqX75s+v
	L2w9+aoklieckDQbth9aSHSbqz2gQQ98sALb2kZPRB9+TjcOrC2AWrONpGR9XEsGZI9gjs
	mZ4NHmJJJnoZIuXuC2pmvDqXAomKHgQ1zuHRVCe1TrSmvI+BaYUHLzxr+XZLQe2ukz4160
	b9hOA0tzWFeMuqV1ive1XltFX7sly+z1/ntVpv39xZ0NPplDM6Hw6kdWb56t9KfaXbuXvl
	x8gCY9d/xbV0yixKqPMhPNlj8Zs55SdoScyMw14l7fxQcMH07GF4XhAb0nnSVQ==
Message-ID: <d913d301-f079-f9be-ce63-74254e99e532@bootlin.com>
Date: Mon, 7 Mar 2022 14:27:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH v2] bitbake-user-manual: add recent release manuals
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <16DA1BD8AFADA604.6605@lists.yoctoproject.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <16DA1BD8AFADA604.6605@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 13:27:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13427


On 3/7/22 14:20, Michael Opdenacker via lists.yoctoproject.org wrote:
> Add links corresponding to recent releases
> Align the title of sections with yocto-docs' releases.rst
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  doc/releases.rst | 63 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 21 deletions(-)
>
> diff --git a/doc/releases.rst b/doc/releases.rst
> index d68d7159..9a644873 100644
> --- a/doc/releases.rst
> +++ b/doc/releases.rst
> @@ -1,32 +1,53 @@
>  .. SPDX-License-Identifier: CC-BY-2.5
>  
> -=========================
> - Current Release Manuals
> -=========================
> +===========================
> + Supported Release Manuals
> +===========================
> +
> +******************************
> +Release Series 3.4 (honister)
> +******************************
> +
> +- :yocto_docs:`3.4.x BitBake 1.52 User Manual </bitbake/1.52/>`


In case you are wondering, we now only keep only one version of
Bitbake's manual for each release series. See the script compiling
manuals on
https://git.yoctoproject.org/yocto-autobuilder-helper/tree/scripts/run-docs-build

In case you would prefer the previous way and have one version per
release update, we could modify the above script. Don't hesitate to
share your opinion on this!

Thank you in advance for the reviews.

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


