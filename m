Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 5763F7F874
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Oct 2019 20:16:35 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id x9NKGVOA021561
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Wed, 23 Oct 2019 15:16:32 -0500
To: Paul Eggleton <paul.eggleton@linux.intel.com>,
	Jean-marie Lemetayer <jean-marie.lemetayer@savoirfairelinux.com>
References: <20191022090408.1368-1-jean-marie.lemetayer@savoirfairelinux.com>
	<1859460807.248980.1571836088029.JavaMail.zimbra@savoirfairelinux.com>
	<ead7c39d-6ac4-a469-b190-90f259433595@kernel.crashing.org>
	<2251883.mhDZDQ7Q5s@shodan>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <9f83b492-f68f-33ad-4816-aa33f6c9751c@kernel.crashing.org>
Date: Wed, 23 Oct 2019 15:16:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2251883.mhDZDQ7Q5s@shodan>
Cc: Savoir-faire Linux Rennes <rennes@savoirfairelinux.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Wed, 23 Oct 2019 20:16:35 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 10/23/19 3:12 PM, Paul Eggleton wrote:
> On Thursday, 24 October 2019 3:27:11 AM NZDT Mark Hatle wrote:
>> On 10/23/19 8:08 AM, Jean-marie Lemetayer wrote:
>>> Thank you again. The former npm support does not have any tests so I did not
>>> think about it. I will add some basic tests in the v2.
>>
>> If you need some pointers on where and how to write the tests, please let me
>> know.  I've had to write a number of them for the gitsm fetcher.
>>
>> Hint: https://git.openembedded.org/bitbake/tree/lib/bb/tests/fetch.py
>>
>> Stuff I added is mostly found by looking for 'test_git_submodule...'
>>
>> I'd expect we need a new test_npm_.... series.
> 
> Right, but if the functionality now relies on code in OE, then to fully test it you'd need to add oe-selftest tests in OE as well.

Yes of course.. A fetch test for the core fetcher functionality, and an
oe-selftest for the overall OE functionality.

--Mark

> Cheers,
> Paul
> 
> 

