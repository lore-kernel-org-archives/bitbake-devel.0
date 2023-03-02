Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23B7C7EE2F
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 16:58:20 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.21729.1677776297469939541
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Mar 2023 08:58:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=E1OnLOgW;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id EC2CD1C0009;
	Thu,  2 Mar 2023 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677776295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m427vq8t2zUXaUZozgP+6q6aNp2uQt2QaXydxhhug5s=;
	b=E1OnLOgWwPV91XJHKI2sVOsV/7DrvZXwN3esuvr5EZxfTPxWL7mAHiC8YP8Yn5yJxzp3Ov
	KQEVXeaZFlOJnpK8qFRBtCOCeRt+/YOQPy4tWCkbOON3KDxy378WPrfrWc1APFHXeJoDQN
	G7A7LI0QdzwAd0Zx4dVxiUnvUwkYYKls4YTkxolLl9kDMFk+9htp0IGAWD+zZCGY3KPQwr
	R4Zwxu1IyrqbBCqw4vQtx/GGiZRQs8i2x+9PMK4LisPTt/skuEWwBtBk1Ax0ztMz3DXGxb
	QOhMESlUrkKP2ha5U/9nMShXe+yB1RvlSaMju1XkjNpM96Jhh3Cdz+0lNRzyEw==
Message-ID: <adec4ead-c040-bc48-7b3f-cb7e5819128d@bootlin.com>
Date: Thu, 2 Mar 2023 17:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: docs@lists.yoctoproject.org, Ever ATILANO <ever.atilano@smile.fr>,
 Yoann CONGAL <yoann.congal@smile.fr>, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v4 2/2] bitbake-user-manual: update Hello
 World example
Content-Language: en-US
To: Fawzi KHABER <fawzi.khaber@smile.fr>
References: <20230302161431.8594-1-fawzi.khaber@smile.fr>
 <20230302161431.8594-2-fawzi.khaber@smile.fr>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230302161431.8594-2-fawzi.khaber@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Mar 2023 16:58:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14519

Hi again Fawzi

Thanks for the quick update.

On 02.03.23 at 17:14, Fawzi KHABER wrote:
> Fix broken link "Obtaining bitbake".
> Update documentation for the bitbake hello world example, the output was
> outdated.
> Fix LAYERSERIES_COMPAT warning by adding dunfell as default compatible release.
> Add proper formating for base.bbclass command.
>
> Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Reviewed-by: Ever ATILANO <ever.atilano@smile.fr>
> Reviewed-by: Yoann CONGAL <yoann.congal@smile.fr>
> Signed-off-by: Fawzi KHABER <fawzi.khaber@smile.fr>
> ---
>   .../bitbake-user-manual-hello.rst             | 127 +++++++++---------
>   1 file changed, 60 insertions(+), 67 deletions(-)

Everything looks good to me.
Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Thanks again for contributing to the Yocto Project!

Don't hesitate to send us more like this one.

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


