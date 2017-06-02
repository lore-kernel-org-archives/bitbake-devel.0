Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4BBE077E82
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Jun 2017 13:26:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v52DQHm1028887
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 2 Jun 2017 06:26:17 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.235) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Fri, 2 Jun 2017 06:26:17 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Patrick Ohly
	<patrick.ohly@intel.com>, <bitbake-devel@lists.openembedded.org>
References: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
	<1496408295.6630.95.camel@linuxfoundation.org>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <3febe667-f723-9497-2797-8421a58997ae@windriver.com>
Date: Fri, 2 Jun 2017 08:26:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1496408295.6630.95.camel@linuxfoundation.org>
Subject: Re: [PATCH] cooker.py: allow dangling bbappends if explicitly whitelisted
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 02 Jun 2017 13:26:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 6/2/17 7:58 AM, Richard Purdie wrote:
> On Mon, 2017-05-22 at 12:50 +0200, Patrick Ohly wrote:
>> Having a .bbappend without corresponding .bb file triggers an error
>> or
>> at least warning, depending on the global
>> BB_DANGLINGAPPENDS_WARNONLY.
>>
>> Some layers (for example, meta-freescale) avoid that message by only
>> adding .bbappends to the BBFILES when the layers they apply to are
>> present. Others (like intel-iot-refkit) avoid such .bbappends by
>> falling back to global assignments with _pn-<recipe> as override.
>> Both
>> is complicated.
>>
>> Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and ignores
>> all bbappends which match a file pattern in that list. This is an
>> easier way to have bbappends which may or may not apply to an
>> existing recipe.
>>
>> Example usage:
>>
>>   # We have recipes-* directories, add to BBFILES
>>   BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
>> 	${LAYERDIR}/optional-bbappends/recipes-*/*/*.bbappend \
>> 	${LAYERDIR}/recipes-*/*/*.bbappend"
>>
>>   # Several of our *.bbappends might be for layers that are not
>>   # guaranteed to be present. Don't warn or even error out because
>>   # of those.
>>   BBAPPENDS_DANGLING_WHITELIST += "${LAYERDIR}/optional-
>> bbappends/recipes-*/*/*.bbappend"
> 
> I've been giving this some thought. The freescale layer approach does
> have ordering issues which I don't like. Equally, Chris' comment about
> this is also a valid concern. Experience suggests saying the layer
> maintainer needs to be careful doesn't work in practise.
> 
> I'm wondering if there is a hybrid solution if we extend this syntax a
> little, e.g.:
> 
> BBFILES_DYNAMIC += "\
>     XXXX:${LAYERDIR}/optional-bbappends-XXX/recipes-*/*/*.bbappend
>     YYYY:${LAYERDIR}/optional-bbappends-YYY/recipes-*/*/*.bbappend
> "
> 
> so that the code only applies these BBFILES entries if the layer named
> in the first parameter is present?
> 
> This would happen at the end of parsing so ordering becomes a moot
> point. The direction you stack BBFILES_DYANMIC in would determin
> bbappend application order.
> 
> How does that sound to people?

That sounds reasonable to me, and has a precedent in the package_dynamic as well.

--Mark

> Cheers,
> 
> Richard
> 


