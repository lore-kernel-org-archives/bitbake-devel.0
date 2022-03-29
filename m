Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E9C433FE
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 09:23:12 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.4652.1648545791386007073
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 02:23:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=VnD5KpNM;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A5F271BF20E;
	Tue, 29 Mar 2022 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648545788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVCnFLEcAqwso0Pnuwn6sZRTwonWBusHkWDquNoIEtw=;
	b=VnD5KpNMVKS8msHUn97KVz8k+Fqsj+jLXa5XdWOYuXUTPjd9dqgWKo8+/Sg3NHfd7G1xqF
	Zuum3jQ3Kv2JA/IDBllQNjNEE0jwCVRldRVRQnRECIlGA9uWR2wFuccHAXYuPdFYitAZMg
	H5W4sQ3aQqe2v+ZEfl/bl6/Ur/YcwLiNO4g4jOKyf2RueHpVN92qoUL8qErwWRY7EG8q3w
	NWjK5ZFqzXwoiZ/3npxgITmgs+Hqvabm5H+c/TPjX1KAXz7MDWTKwWB+o/QUssK7JuYPE8
	eFLzS8b1TV7+VmKzhq8VEmaFBRcLWHTqeJ3Yjq3itx8hQh5luTo3xIS92Tglxg==
Message-ID: <46a88c96-2efb-0043-e62a-c0bb2b4f71a4@bootlin.com>
Date: Tue, 29 Mar 2022 11:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] bitbake-user-manual: fix broken links to manual
 releases
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <16E0CF5A54A31339.3733@lists.yoctoproject.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <16E0CF5A54A31339.3733@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 09:23:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13531


On 3/29/22 11:17, Michael Opdenacker via lists.yoctoproject.org wrote:
>  ****************************
>  Release Series 3.1 (dunfell)
>  ****************************
>  
> +- :yocto_docs:`BitBake 1.46 User Manual </bitbake/1.46/>`
>  - :yocto_docs:`3.1 BitBake User Manual </3.1/bitbake-user-manual/bitbake-user-manual.html>`
>  - :yocto_docs:`3.1.1 BitBake User Manual </3.1.1/bitbake-user-manual/bitbake-user-manual.html>`
>  - :yocto_docs:`3.1.2 BitBake User Manual </3.1.2/bitbake-user-manual/bitbake-user-manual.html>`
>  - :yocto_docs:`3.1.3 BitBake User Manual </3.1.3/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.4 BitBake User Manual </3.1.4/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.5 BitBake User Manual </3.1.5/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.6 BitBake User Manual </3.1.6/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.7 BitBake User Manual </3.1.7/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.8 BitBake User Manual </3.1.8/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.9 BitBake User Manual </3.1.9/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.10 BitBake User Manual </3.1.10/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.11 BitBake User Manual </3.1.11/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.12 BitBake User Manual </3.1.12/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.13 BitBake User Manual </3.1.13/bitbake-user-manual/bitbake-user-manual.html>`
> -- :yocto_docs:`3.1.14 BitBake User Manual </3.1.14/bitbake-user-manual/bitbake-user-manual.html>`


This one looks a bit odd. We could keep only the link to BitBake's 1.46
manual. We cannot really move the manuals for Yocto 3.1, 3.1.1, 3.1.2
and 3.1.3 (before the switch to Sphinx) to the "Outdated Release
Manuals" section, because 3.1.x is not an outdated release.

Unless we call the section "Older Release Manuals"...

The order also feels odd: latest manual for 3.1, then for 3.0, 3.1.1,
3.1.2 and 3.1.3. But wouldn't it be odd to have to latest and relevent
version last? Until we revert the order everywhere.=

Any thoughts?
Thanks in advance
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


