Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5FCCA78432
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 11:53:36 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w11BrbJB019214
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 1 Feb 2018 03:53:37 -0800 (PST)
Received: from localhost.localdomain (128.224.163.240) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.361.1; Thu, 1 Feb 2018 03:53:36 -0800
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1516265726.git.liezhi.yang@windriver.com>
	<9a21e82b35b935826dd28413684f0918c00f9eb0.1516265726.git.liezhi.yang@windriver.com>
	<1516360609.24502.18.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <16625df3-2491-66ac-985f-00edff18a7d7@windriver.com>
Date: Thu, 1 Feb 2018 19:53:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516360609.24502.18.camel@linuxfoundation.org>
Subject: Re: [PATCH 2/2] parse: don't add attempted files to dependencies
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
X-List-Received-Date: Thu, 01 Feb 2018 11:53:37 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi RP,

On 01/19/2018 07:16 PM, Richard Purdie wrote:
> On Thu, 2018-01-18 at 16:57 +0800, Robert Yang wrote:
>> The attempts are the files that it tries to search but don't exist,
>> it searches the file in BBPATH until find it, so the attempts might
>> be very long when there are many layers, which causes bb_cache.dat
>> very big (I have 54 layers, the bb_cache.dat can be 119M, and even
>> much bigger depends on the order of BBLAYERS).
>>
>> Here is the testing data of 54 layers before and after the patch.
>>
>>                      Before          After
>> Parsing time        33s             9s
>> Loading time        30s             5s
>> Cache size          119M            20M
>>
>> The time and size can be more or less depends on the order of
>> BBLAYERS before the patch.
>>
>> I checked the code, but didn't find why we need the attempts as
>> dependencies, the one that I can think of is the file doesn't exist
>> when parsing, and added to the attempts location after parsing, but
>> the parseBaseConfiguration() can detect and handle this well (and
>> will cause reparse in such a case), so I think that we can safely
>> remove them from dependencies since they have side effects.
> 
> If you have a memory resident bitbake you need to know which files to
> watch for with inotify. If a file is created somewhere which would have
> been parsed had it existed when we originally parsed, we need to
> invalidate the cache and reparse. This needs to happen for the metadata
> itself, not just the base configuration.
> 
> I therefore strongly suspect we do need these unfortunately. There may
> be some ways we can condense the dependency information though to
> reduce the cache load times.

Yes, you're right, after a lot of investigations, I found that the bottle
neck is add_info() calls add_filewatch(), and add_filewatch runs too many
loops inside, but most of them are not needed, I've reduced the size
passed to add_filewatch(), which makes us save a lot of parse time,
but the size of bb_cache.dat can't be reduced since it needs save
all the attempted files. It seems that we can't get rid of
that for memory resident bitbake, but I think that it's fine since parsing
time is reduced. I will send the patches after more testing.

// Robert

> 
> Cheers,
> 
> Richard
> 

