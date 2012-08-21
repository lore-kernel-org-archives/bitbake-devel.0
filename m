Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1T3qFK-0007PD-06
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 17:19:58 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7LDUD5i025943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 21 Aug 2012 06:30:13 -0700 (PDT)
Received: from [172.25.32.41] (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Tue, 21 Aug 2012 06:30:13 -0700
Message-ID: <50338D64.901@windriver.com>
Date: Tue, 21 Aug 2012 08:30:12 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:13.0) Gecko/20120615 Thunderbird/13.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1344482807.git.liezhi.yang@windriver.com>
	<2caf68f6aa334948840a647d7c34a59f0405d11b.1344482807.git.liezhi.yang@windriver.com>
	<1345554532.3907.76.camel@ted>
In-Reply-To: <1345554532.3907.76.camel@ted>
X-Enigmail-Version: 1.4.3
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] fetch2/__init__.py: add an "auto" policy for BB_SRCREV_POLICY
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 21 Aug 2012 15:19:58 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 08/21/2012 08:08 AM, Richard Purdie wrote:
> On Thu, 2012-08-09 at 16:56 +0800, Robert Yang wrote:
>> The newly added "auto" policy is used for the SRCREV="${AUTOREV}" recipe,
>> the current BB_SRCREV_POLICY are: "clear" (default) and "cache":
>>
>> * When "clear", the "AUTOREV" recipe will not be cached in bb_cache.dat
>>
>> * When "cache", the "AUTOREV" would be cached in bb_cache.dat, but it
>>   doesn't try to get the latest revision.
>>
>> The "auto" policy is much like the "cache" except that it will try to
>> get the latest revision.
>>
>> [YOCTO #2920]
>>
>> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>  bitbake/lib/bb/fetch2/__init__.py |   12 +++++++++---
>>  1 files changed, 9 insertions(+), 3 deletions(-)
> I've been asked why I've not taken this. The simple answer is that I
> can't figure out why we need to do this. The commit message above says
> what was done but not why.
>
> I also strongly dislike "auto" as a name for this mode. "clear" and
> "cache" are at least descriptions of the behaviour, "auto" is not.
>
> So can you please explain why we need this change? What use case does it
> fix or improve or how is it useful? At the very least the commit message
> needs rewriting and the option renaming.


I had asked Robert to follow up on this and intended this as a RFC, not a final implementation.  This basically looks like the original patch I sent him when I was using the code to illustrate a possible solution to the problem of missing values from the data cache.

Let us turn this into a discussion about the problem and see if we can come up with a plausible answer.

We use the contrib/dump_cache.py to generate the entire list of possible recipes -> version -> package split mapping.  As you can imagine this data is important and can be used for a number of purposes.  I noticed a few values were missing when ever I ran the dump_cache.py and narrowed it down to the fact that anything that was listed as AUTOREV did not show up in the cache.

The desired outcome is to have the key value pairs that were used in the most recent parse show up in the cache, as opposed to completely dropping the cache values from being written at all.   For the version retrieval code, if the value in the cache is autorev, it should look up the value as one would expect.  In terms of the clean vs cache vs a 3rd state, I don't really care what key words get used.   You might not even need to add a 3rd state depending on the implementation of solution.

I didn't see a reason not to write out the cache such that it could be parsed externally.   Just because you write it, doesn't mean it has to get re-used in the case of the AUTOREV.

If I have not described the problem clearly enough, please ask further questions.  Is it a bit more clear what the nature of the problem is?

Cheers,
Jason.


