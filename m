Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0A7C48260
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 15:39:48 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web11.20605.1707406775324746420
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Feb 2024 07:39:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=Kncqvc0p;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-3.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTPS id 418FdV5L503377
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Thu, 8 Feb 2024 16:39:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1707406771;
	bh=cUH/d0fNdnL4ztsMezM+QArZUrS2kjrs+bcDqZGLLwQ=; l=335;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Kncqvc0pjB3J/juQoRmPDQMzVfYLuyOAXv0jabXIPw4+TjPMpzn0cYyLOz/O7OjdD
	 mE4UZhSbV/sm18Rq/rwfrV/fjpk5IulcsVJGNCHR+m240lJ8jbmmi8jtEyf5NkWqLJ
	 xqj76hRpVvQeK6RR+RV7Ia9xI6lPPxF72Qx/PB2vLqPx0aXB4NU25rAie+yAxqDQgE
	 OAPOuDskpixiiN1VGQWcXnBRpiX4eHVYxRC5gh5QxjGx1+5NIRUKt6iJR1Th+XKPvK
	 ESLVThqca7YBMfaq2f3ihioh8EekpDc+roDyDi9SKIdsfcBqBgEqjWhmZ/A+C0ucnB
	 vJcJtLA8/zLcw==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTP id 418FdTYs948654
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Thu, 8 Feb 2024 16:39:29 +0100
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id DPP60VD9S8; Thu, 08 Feb 2024 16:39:19 +0100
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTPS id 418FdJTo731320
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 8 Feb 2024 16:39:19 +0100
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.97.1)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1rY6Uh-0000000E7Js-2KyN;
	Thu, 08 Feb 2024 16:39:19 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: "Saul Wold" <sgw@bigsur.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org,
        randy.macleod@windriver.com
Subject: Re: [bitbake-devel] Underscore vs Dash in bbclass filenames
In-Reply-To: <f8f81126-3fec-4dbd-8088-64d615879167@bigsur.com> (Saul Wold's
	message of "Wed, 7 Feb 2024 14:21:57 -0800")
References: <f8f81126-3fec-4dbd-8088-64d615879167@bigsur.com>
Date: Thu, 08 Feb 2024 16:39:19 +0100
Message-ID: <lya5obge3c.fsf@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 65c4f5a7a867f08c5db42a49
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 15:39:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15843

"Saul Wold" <sgw@bigsur.com> writes:

> I was looking into Bug 14235 [0] and had initial patch based on
> Randy's original recommendation of using dash (-) which was a basic
> python/tinfoil script to check existing bbclasses in the BBPATH.

why not make it like rust and replace '-' by '_' when generating symbols?


Enrico

