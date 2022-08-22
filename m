Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FB0C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 08:29:43 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web12.15713.1661156979107113981
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 01:29:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=C4Qzit3C;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 15B8383FA2;
	Mon, 22 Aug 2022 10:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1661156976;
	bh=6Ky9M6ucEIWpyM10ZdHyXCAn8gLsIaRT60mMiyp2Cqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C4Qzit3C6HVcmeux0ZhBAaSjx/2b2BHSQAtTbRyz7q+ppB8YYHSW2/5JHZ8kLr+SC
	 LvxFlpDCF+zkG497hNUQ4kgDAkiZS9jVuAjbaHuAaHjIZ6ho34xiplZsHTxGbkMN3/
	 qaJWNq5fT9SMZQz0bzjwek92pNnfsuDeJnF9ud1QFvIoa1vx8oKlyMd0crgzGQx7D/
	 /8bHYbXUBpxOAZQ8R2hHW0xXNWhYDPef2cKQcmkK7G9EPDPU7MLxSYDiTrK2b6l1u/
	 GRVRGdUEuToOH5IKQ+rZiEmeHCZRbAYiDYjecr35muzMHDpELmuDxNsIqtLzjTwh06
	 b1VCyKdq0HyyA==
Message-ID: <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
Date: Mon, 22 Aug 2022 10:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
To: Mikko.Rapeli@bmw.de, alex.kanavin@gmail.com
Cc: Martin.Jansa@gmail.com, bitbake-devel@lists.openembedded.org,
 peter.kjellerstedt@axis.com, richard.purdie@linuxfoundation.org
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
 <YwMyXi/vfRh3S6bx@korppu>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <YwMyXi/vfRh3S6bx@korppu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 08:29:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13913

On 8/22/22 09:38, Mikko.Rapeli@bmw.de wrote:
> On Mon, Aug 22, 2022 at 08:57:11AM +0200, Alexander Kanavin wrote:
>> Can be solved with a parameter to a fetcher perhaps?
> 
> Frequently developers know to change the git URL in recipes from
> "branch=master" to "nobranch=1" for their test commits.
> 
> This could be used for fetching the changes too, to limit the scope.

So maybe the easy way out is, if nobranch=1 then fetch everything, else 
just heads and tags ?

