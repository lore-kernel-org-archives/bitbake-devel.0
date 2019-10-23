Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id BCA087F817
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Oct 2019 14:27:16 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id x9NERBaH020016
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Wed, 23 Oct 2019 09:27:14 -0500
To: Jean-marie Lemetayer <jean-marie.lemetayer@savoirfairelinux.com>
References: <20191022090408.1368-1-jean-marie.lemetayer@savoirfairelinux.com>
	<20191022090408.1368-3-jean-marie.lemetayer@savoirfairelinux.com>
	<4409c36d-23b9-4ddb-d681-5328f75330dc@kernel.crashing.org>
	<1859460807.248980.1571836088029.JavaMail.zimbra@savoirfairelinux.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <ead7c39d-6ac4-a469-b190-90f259433595@kernel.crashing.org>
Date: Wed, 23 Oct 2019 09:27:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1859460807.248980.1571836088029.JavaMail.zimbra@savoirfairelinux.com>
Cc: paul eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Savoir-faire Linux Rennes <rennes@savoirfairelinux.com>
Subject: Re: [RFC][PATCH 2/2] fetch2/npm.py: refactor the npm fetcher
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
X-List-Received-Date: Wed, 23 Oct 2019 14:27:17 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 10/23/19 8:08 AM, Jean-marie Lemetayer wrote:
> On Oct 22, 2019, at 7:10 PM, Mark Hatle mark.hatle@kernel.crashing.org wrote:
>> On 10/22/19 4:04 AM, Jean-Marie LEMETAYER wrote:
>>> This commit refactors the npm fetcher to improve some points and fix
>>> others:
>>>
>>>  - The big change is that the fetcher is only fetching the package
>>>    source and no more the dependencies. Thus the npm fetcher act as the
>>>    other fetchers e.g git, wget. The dependencies will now be fetched
>>>    by the npm class.
>>
>> I don't completely understand this and the associated class, but does it work
>> with the existing MIRROR and BB_NO_NETWORK/BB_ALLOWED_NETWORKS settings?
>>
>> My concern is for people in environments that are not allowed to download except
>> from trusted machines, or on disconnected networks so they have everything on a
>> local mirror of some sort.
>>
>> Additionally with the mirroring, it's not unusual for the name of what is
>> downloaded (as well as where it's downloaded from) to change protocol and
>> format.  I.e. I'd hope something like:
>>
>> .*:.*/.* file://my_local/on/disk/mirror
> 
> Thank you for pointing this out. As I was inspired by the wget fetcher, I
> think this should be good but i still need to check.
> 
> However the npm.bbclass fetches the npm dependencies (currently in the
> do_compile task) and this settings are not respected. I am working on a v2
> to fix this point.
> 
>> I'm also not seeing any test cases for this fetcher.  Since this work isn't well
>> understood by most of the regular maintainers, I think it's extremely important
>> that test cases are added during any new changes to ensure that the fetcher is
>> working properly.
> 
> Thank you again. The former npm support does not have any tests so I did not
> think about it. I will add some basic tests in the v2.

If you need some pointers on where and how to write the tests, please let me
know.  I've had to write a number of them for the gitsm fetcher.

Hint: https://git.openembedded.org/bitbake/tree/lib/bb/tests/fetch.py

Stuff I added is mostly found by looking for 'test_git_submodule...'

I'd expect we need a new test_npm_.... series.

--Mark

> Regards,
> Jean-Marie
> 

