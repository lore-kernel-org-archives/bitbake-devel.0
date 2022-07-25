Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35247C433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 20:23:59 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.839.1658780637543387229
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 13:23:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=PErcxQFh;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 293268420E;
	Mon, 25 Jul 2022 22:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1658780635;
	bh=dCX8WK4XNXNODVyjAYWfo2NhTRADLsPnEmhRjxRftTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PErcxQFhzYg38Zeo4DifIocoDD/J6Omd68DftHNFwfDq1EZLNq1qLjW6nKMC3MCDK
	 hW4bELBP46vk03hlh45lnGcvClm0gk6NEXlDfkx2ynRSsoLAO5Vcew/6eVhO9Wn3OY
	 UDdppLUezMSyBrNdlUwT+RVjAO8j4M4SdFGej/uk3b339EUdln+8RtJpYX8Y1rRlGn
	 sg8ZvCPorYKV+46iTITyO5I6pg+9WG/ZIh/87gy37R6iHC1GAR8fS/zz60w28SSwRQ
	 u6KuNUnAaiJM51nQhVssEJBXp+9MzpTXeXvBefs0uw74uRGXvRsXsby3Er3z5kUNbu
	 i2eR454YGBplw==
Message-ID: <ae4090e1-27f4-4ff7-d74c-3a125d9d4a0d@denx.de>
Date: Mon, 25 Jul 2022 22:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-user-manual: Document override
 :append, :prepend, :remove order
Content-Language: en-US
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
References: <20220725155625.381756-1-marex@denx.de>
 <lyr12983fh.fsf@ensc-pc.intern.sigma-chemnitz.de>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <lyr12983fh.fsf@ensc-pc.intern.sigma-chemnitz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 20:23:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13847

On 7/25/22 20:14, Enrico Scholz wrote:
> "Marek Vasut" <marex@denx.de> writes:
> 
>>   
>> +.. note::
>> +
>> +   The overrides are applied in this order, ":append", ":prepend", ":remove".
>> +   This implies it is not possible to re-append previously removed
>>      strings.
> 
> fwiw, this is possible by anonymous python functions which are evaluated
> after ":remove"
> 
> | FOO = "123 abc XYZ"
> |
> | python () {
> |     v = d.getVar('FOO')
> |     d.setVar('FOO', v + ' abc 789')
> | }
> |
> | FOO:remove = "abc XYZ"
> 
> results in
> 
> | FOO="123   abc 789"
> 

IIRC anonymous python functions are frowned upon, aren't they ?

