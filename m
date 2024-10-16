Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5F7D2A523
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 14:32:47 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by mx.groups.io with SMTP id smtpd.web10.24379.1729089165381744898
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Oct 2024 07:32:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=PMAXq1WV;
 spf=pass (domain: ti.com, ip: 198.47.23.249, mailfrom: reatmon@ti.com)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49GEWg58089740;
	Wed, 16 Oct 2024 09:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729089162;
	bh=WDE6v6APt9YRnWCpBa1lerHmMJhkyjCwm9/4c5TFKoU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PMAXq1WVh92PRBW6Kml6S3LvCcFi86YA8d0TvYjd/0b4pEjrwjBtBu7+JMOeT+Sey
	 69I3fq6YbbZRdITM4EUatTHQFnYVjjJ30W0Mv+rNHl6L3HRcCa70bs+8kJuYcwsYQi
	 Kmo+rqmyybyn0to2B/3EUcsNcYaZcMUFCTihm3E4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49GEWg6I087184
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Oct 2024 09:32:42 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Oct 2024 09:32:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Oct 2024 09:32:41 -0500
Received: from [10.249.35.83] ([10.249.35.83])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GEWfJw092710;
	Wed, 16 Oct 2024 09:32:41 -0500
Message-ID: <9816e9b8-3a96-4017-801a-37c159c00337@ti.com>
Date: Wed, 16 Oct 2024 09:32:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH] fetch2/wget: set User-Agent to
 'bitbake/version' in checkstatus()
To: Alexander Kanavin <alex.kanavin@gmail.com>,
        <bitbake-devel@lists.openembedded.org>, <christophe.priouzeau@st.com>,
        <paul@pbarker.dev>
CC: Alexander Kanavin <alex@linutronix.de>
References: <20241014133504.2390211-1-alex.kanavin@gmail.com>
Content-Language: en-US
From: Ryan Eatmon <reatmon@ti.com>
In-Reply-To: <20241014133504.2390211-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Oct 2024 14:32:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16689


Initial testing behind the TI firewall showed no issues with these two 
changes.  It *should* be ok to move ahead with it.


On 10/14/2024 8:35 AM, Alexander Kanavin wrote:
> From: Alexander Kanavin <alex@linutronix.de>
> 
> This eliminates the last usage of 'fake mozilla' in bitbake, and
> it's then truthful everywhere about presenting itself, or wget
> (when that is used).
> 
> I understand this will make people nervous so I want to provide
> an extended decription.
> 
> 1. How was this tested?
> 
> - bitbake-selftest -k FetchCheckStatusTest
> (tests a few hardcoded URIs, all passed)
> 
> - bitbake -k -c checkuri world
> (runs checkstatus() over all recipes in oe-core, and all passed again -
> this hopefully goes a long way to reassure everyone that hosts around
> the world and various CDNs typically do not have a problem with user-agent
> strings they haven't seen before or bitbake user-agent specifically)
> 
> 2. What about that removed cloudflare comment?
> 
> I digged into git history, and I think it is not fully accurate. First, 'fake
> mozilla' agent is used only for checkstatus() - in actual fetching with wget
> it is not. And that has not been a problem for anyone.
> 
> Second, here's how the comment occured. Usage of 'fake mozilla' was introduced here:
> https://git.yoctoproject.org/poky/commit/?h=master&id=ab26fdae9e5ae56bb84196698d3fa4fd568fe903
> 
> At that point it did not have to be specifically 'mozilla', the commit message
> indicates that any User-Agent would have been ok. Mozilla was simply copied
> from upstream version check for convenience.
> 
> Later on, the string was updated to a more recent Mozilla:
> https://git.yoctoproject.org/poky/commit/?h=master&id=9f123238261a68e37cec634782e9320633cac5d4
> 
> The claim in the added comment become something else: that User-Agent *must* a browser,
> without evidence or tests. Even though it demonstrably doesn't have to be - wget is ok.
> 
> 3. What if someone has a server that is ok with wget agent, but not ok with bitbake agent?
> 
> Please see point one. It's not impossible but I think it's highly unlikely. I do think
> we should rather tell servers the truth, and learn where the actual issues are. Then
> we can consider options - whether that would be pretending to be wget, or allowing user-agent
> to be configured. We should also add such servers to bitbake-selftest so we know what they
> are.
> 
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>   bitbake/lib/bb/fetch2/wget.py | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
> index 493a5b62ee2..7856d10fa4b 100644
> --- a/bitbake/lib/bb/fetch2/wget.py
> +++ b/bitbake/lib/bb/fetch2/wget.py
> @@ -53,11 +53,6 @@ class WgetProgressHandler(bb.progress.LineFilterProgressHandler):
>   class Wget(FetchMethod):
>       """Class to fetch urls via 'wget'"""
>   
> -    # CDNs like CloudFlare may do a 'browser integrity test' which can fail
> -    # with the standard wget/urllib User-Agent, so pretend to be a modern
> -    # browser.
> -    user_agent = "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gecko/20100101 Firefox/84.0"
> -
>       def check_certs(self, d):
>           """
>           Should certificates be checked?
> @@ -356,7 +351,7 @@ class Wget(FetchMethod):
>                   # Some servers (FusionForge, as used on Alioth) require that the
>                   # optional Accept header is set.
>                   r.add_header("Accept", "*/*")
> -                r.add_header("User-Agent", self.user_agent)
> +                r.add_header("User-Agent", "bitbake/{}".format(bb.__version__))
>                   def add_basic_auth(login_str, request):
>                       '''Adds Basic auth to http request, pass in login:password as string'''
>                       import base64
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16680): https://lists.openembedded.org/g/bitbake-devel/message/16680
> Mute This Topic: https://lists.openembedded.org/mt/109001174/6551054
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [reatmon@ti.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

-- 
Ryan Eatmon                reatmon@ti.com
-----------------------------------------
Texas Instruments, Inc.  -  LCPD  -  MGTS

