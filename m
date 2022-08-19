Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0014CC32773
	for <webhook@archiver.kernel.org>; Fri, 19 Aug 2022 14:30:00 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.3759.1660919389833634915
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Aug 2022 07:29:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=FyT1k6m7;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0719284B16;
	Fri, 19 Aug 2022 16:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1660919387;
	bh=Sfr7iKBzZ9dux5ERRel6miIvNpGwNZwGd3G7LEpc4n0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FyT1k6m7Z8gRvpIQ7QEryG8l4XwMs80VaYBbs+HA/LBkKzRRrQ80RGp56cneLKSRO
	 27k4lZeSB6ehh4sc8zTkDUMG9xcwP3A75ay6F5yGnJ5RVYm3Mmml/uSNedw182r1sY
	 gU+da9iSbIVxGCGOLp7YCPl2OWW0HsPPAXOlmhypMS9jM3Rg1NdBBZQYUkFkWsLejw
	 mHtN2TfeYUz7g8YkqqcPMBTKJkICei8P0mgn0H15qza7iKjUidnRKaxeh/GMwmV71L
	 Sxjp939FxFXnzVV5yQ8yU707szYgOjMerzEIpxXIaVwm0EuDP5UkVpYZ4vWE7Ehgql
	 AXpBbMzu/6cUA==
Message-ID: <0397a47e-5636-50ae-de37-d411dafbe4e5@denx.de>
Date: Fri, 19 Aug 2022 16:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] bitbake-user-manual: Document override :append,
 :prepend, :remove order
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss+yocto@0leil.net>,
 Martin Jansa <martin.jansa@gmail.com>,
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20220725155625.381756-1-marex@denx.de>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20220725155625.381756-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Aug 2022 14:30:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13903

On 7/25/22 17:56, Marek Vasut wrote:
> The application order of override syntax :append, :prepend, :remove is
> inobvious and undocumented. The order does not match variable parse
> history, i.e. output of "bitbake -e", either.
> 
> Add note documenting the exact order in which :append, :prepend, :remove
> are applied to variable in lib/bb/data_smart.py getVarFlag(). Add note
> that this order does not match the variable parse history order. This
> is mostly to prevent others from running into this and scratching their
> heads, trying to find out what is going on.

Can this be applied now or is there something more to change ?

