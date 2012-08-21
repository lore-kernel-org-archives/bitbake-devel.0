Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T3pB7-0006Ig-BM for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 16:11:33 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7LDxUaC013960;
	Tue, 21 Aug 2012 14:59:30 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13561-02; Tue, 21 Aug 2012 14:59:26 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7LDxLbc013954
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 21 Aug 2012 14:59:22 +0100
Message-ID: <1345557562.3907.87.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Tue, 21 Aug 2012 14:59:22 +0100
In-Reply-To: <50338D64.901@windriver.com>
References: <cover.1344482807.git.liezhi.yang@windriver.com>
	<2caf68f6aa334948840a647d7c34a59f0405d11b.1344482807.git.liezhi.yang@windriver.com>
	<1345554532.3907.76.camel@ted> <50338D64.901@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
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
X-List-Received-Date: Tue, 21 Aug 2012 14:11:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-08-21 at 08:30 -0500, Jason Wessel wrote:
> I had asked Robert to follow up on this and intended this as a RFC,
> not a final implementation.  This basically looks like the original
> patch I sent him when I was using the code to illustrate a possible
> solution to the problem of missing values from the data cache.
>
> Let us turn this into a discussion about the problem and see if we can
> come up with a plausible answer.
>
> We use the contrib/dump_cache.py to generate the entire list of
> possible recipes -> version -> package split mapping.  As you can
> imagine this data is important and can be used for a number of
> purposes.  I noticed a few values were missing when ever I ran the
> dump_cache.py and narrowed it down to the fact that anything that was
> listed as AUTOREV did not show up in the cache.
>
> The desired outcome is to have the key value pairs that were used in
> the most recent parse show up in the cache, as opposed to completely
> dropping the cache values from being written at all.   For the version
> retrieval code, if the value in the cache is autorev, it should look
> up the value as one would expect.  In terms of the clean vs cache vs a
> 3rd state, I don't really care what key words get used.   You might
> not even need to add a 3rd state depending on the implementation of
> solution.
>
> I didn't see a reason not to write out the cache such that it could be
> parsed externally.   Just because you write it, doesn't mean it has to
> get re-used in the case of the AUTOREV.
>
> If I have not described the problem clearly enough, please ask further
> questions.  Is it a bit more clear what the nature of the problem is?

The problem is a lot clearer now, you basically want the data written to
the cache in the __BB_DONT_CACHE case. The trouble with the patch is we
tell bitbake to drop the data for good reason which is why the patch is
not acceptable.

I can imagine complaints about saving out data only to discard it at
load time and at this point I think your use of the cache is diverging
from what bitbake itself wants to use it for. I suspect what we might
need to do is extend cache.py to allow execution of custom cache
handlers and the you can write out the data you want. We already added
UI specific support to the cache so UIs could put extra data into the
cache although that perhaps doesn't cover this usecase :(.

Cheers,

Richard









