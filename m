Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74B4C678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 13:44:59 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.15678.1677764696739731470
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Mar 2023 05:44:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=af+r5lg+;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A8114E0006;
	Thu,  2 Mar 2023 13:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677764694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELDe2cK5bJp6gcUB21H+JOhaIzx17fWsmhIVE6AgR0c=;
	b=af+r5lg+0pzJWK/og2Nr4T4QLTEi186U5V0SYRWcHJqjA+80oKOlpYdWmEpT/wTzInNXK1
	8wY9zYdda6gwAMpj3RHAT9Cmie0J2fydCKKiLolwOIr0zGhK1RW7vkTULQowvNIfxO3KqY
	1SmLTmz/EgfKBo51OFU+28kmDn2b9WX29aCebb/sg+91dt2UbAygSYACx2nS/GpZhM8NkS
	9i3JCsBvw04oeU8zUlS4NMeppE72nrSd0GxIEov99UqBfdYsVOMyP1GUcee2t7v9mNhm1/
	3eulyk1BH9efmBb4yxWZ9WRg7AfznFUAkYxByMBRgtJDxCGIDVWdcu4946ixfQ==
Message-ID: <c267cd11-1bac-b4be-7a0d-1116675746aa@bootlin.com>
Date: Thu, 2 Mar 2023 14:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: docs@lists.yoctoproject.org, Ever ATILANO <ever.atilano@smile.fr>,
 Yoann CONGAL <yoann.congal@smile.fr>, bitbake-devel@lists.openembedded.org
Subject: Re: [docs] [PATCH v3 1/2] doc: ref-variables: add LAYERSERIES_COMPAT
 to term glossary
Content-Language: en-US
To: Fawzi KHABER <fawzi.khaber@smile.fr>
References: <20230301131611.16265-1-fawzi.khaber@smile.fr>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230301131611.16265-1-fawzi.khaber@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Mar 2023 13:44:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14512

Hi Fawzi,

Thanks for the update!

On 01.03.23 at 14:16, Fawzi KHABER wrote:
> Bitbake throws a warning if the layer compatibility is not defined since
> cca81e33b58c390dcf5cc3a31555a43b79177166. This variable did not figure in
> the documentation.

I'd replace the second sentence by:
"The description of this variable comes from the Yocto Project manual".

This way, we will know where the text comes from in the unlikely case
there is a copyright dispute. That will help too as I plan to update the
YP manual with just a reference to this description in the BitBake manual.

For all the rest:
Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
(note that I'm not the maintainer of BitBake's manual, Richard is).

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


