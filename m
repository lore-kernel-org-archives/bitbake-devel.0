Return-Path: <adrian.ambrozewicz@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 210F96C216
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2019 13:45:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Nov 2019 05:45:43 -0800
X-IronPort-AV: E=Sophos;i="5.68,296,1569308400"; d="scan'208";a="198081968"
Received: from aambroze-mobl1.ger.corp.intel.com (HELO [10.102.85.150])
	([10.102.85.150])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
	12 Nov 2019 05:45:42 -0800
To: Khem Raj <raj.khem@gmail.com>, Mikko.Rapeli@bmw.de, martin.jansa@gmail.com
References: <6f692d96-9b78-b317-d033-09d1f140da62@linux.intel.com>
	<CA+chaQcOse_xmbyi0q=WXB1JQxV6AgGJtvrFZ_Wtmi-N2z0g6A@mail.gmail.com>
	<20191111075820.GX2398@hiutale>
	<5018021771633c0e30b5789f31948fcfac633a15.camel@gmail.com>
From: =?UTF-8?Q?Adrian_Ambro=c5=bcewicz?= <adrian.ambrozewicz@linux.intel.com>
Message-ID: <32b4e32e-9b6e-0c47-3225-b15c550faed1@linux.intel.com>
Date: Tue, 12 Nov 2019 14:45:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5018021771633c0e30b5789f31948fcfac633a15.camel@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Patch idea - fetcher for gerrit patches
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
X-List-Received-Date: Tue, 12 Nov 2019 13:45:43 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



W dniu 11/11/2019 o 16:24, Khem Raj pisze:
> On Mon, 2019-11-11 at 07:58 +0000, Mikko.Rapeli@bmw.de wrote:
>> Hi,
>>
>> Interesting idea.
>>
>> We use gerrit but don't neeed to expose gerrit details to bitbake
>> fetcher.
>>
>> Instead, we use gerrit changes to fetch meta layer changes using a
>> separate checkout
>> script. It handles gerrit topics, e.g. same topic name is used to
>> bundle changes
>> from multiple meta layer git trees. This enables large transitions
>> and updates as single
>> topic.
We've tried approach with separate script. It's just ankward to use 
separate checkout script for fetching and patching sources, when in fact 
bitbake provides those utilities, just isn't compatible directly with 
that SCM yet.

Idea is to have separate layer combining WIP/reviewed commits submitted 
to different repositories as our 'baseline'. Gerrit fetcher would take 
care of that.

> 
> There is a similar setup we have for CI using gerrit, but once you
> start playing with fetchers, bitbake is not happy and the build
> consistency is jeopardized as well, e.g. new QA checks etc, come in way
> in other words you have to maintain this additional CI fetch method and
> it grows cruft. So I would think if we were to do some additional work
> in fetchers to achieve this, that would be long term sustainable, and
> perhaps useful for other gerrit users or other SCMs
> 
>>
>> In our case it's a grave bug to use SRC_URIs in bitbake recipes
>> without referring
>> to proper branch and commit id. There have been cases where a commit-
>> id from an open
>> gerrit review got integrated which is bad, bad. I can only imagine
>> that testing
>> could be easier if bitbake recipes were to support gerrit directly,
>> e.g. to trigger
>> a bitbake test build for an open gerrit review change. But there are
>> other ways
>> to script that without exposing gerrit details to bitbake.
I agree, it would be easier and much more logical to integrate patches 
in my layers just by specifying ongoing reviews. Why forcing user to 
write his own external scripts to do that when proper patches might be 
fetched and applied natively. We've tried that and failed miserably.

>>
>> So I'm not sure if this gerrit fetcher is easier. At least I would
>> like to disable it,
>> or add a custom QA check which forbids its use in release build
>> recipes.
In 'my' use case gerrit fetcher is aimed directly to ease development 
for large features scattered among many repos. Opt-in for enabling that 
and big warning in build log could be reasonable solution.

>>
>> Cheers,
>>
>> -Mikko
> 

