Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TwApm-0002lH-Sa for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 13:14:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IBwlh8008608;
	Fri, 18 Jan 2013 11:58:47 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05510-02; Fri, 18 Jan 2013 11:58:42 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IBweRn008602
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2013 11:58:41 GMT
Message-ID: <1358510320.27799.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Seebach <peter.seebach@windriver.com>
Date: Fri, 18 Jan 2013 11:58:40 +0000
In-Reply-To: <1358422179.24249.24.camel@ted>
References: <cover.1357954043.git.peter.seebach@windriver.com>
	<1358358898.24249.8.camel@ted> <20130116120104.1d40cced@e6410-2>
	<1358420667.24249.18.camel@ted> <1358422179.24249.24.camel@ted>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Variable tracking: Cleaned up and rebased.
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
X-List-Received-Date: Fri, 18 Jan 2013 12:14:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

To round this discussion out, I played with the code quite a bit and
whilst I love the idea of the code, I found a few bugs and there were
some structural issues in the way the code worked I didn't like. It was
extremely easy to unintentionally break the history tracking.

This was due to many operations doing "fall though" with the set
operation doing the final record, maybe with modified parameters.

Whatever we do, we need it to be robust enough to withstand other
improvements in the codebase so this would have been enough to block it.

I decided to see if I could improve things so I've taken the patches and
made quite some number of changes, I think the output with the revised
version is either equal to or in some cases improved to the original.
I've hopefully addresses the "robustness" issues with those changes as
it feels less fragile to me and I removed some sources of confusion like
the "value" verses "detail" business, standardising on "detail" in the
end for a practicality reasons.

I still don't think the result is perfect however I do propose to merge
it in the revised form I've just posted. I think any further
optimisations or improvements can be done in tree.

Performance wise, with the code disabled, we're now down to 3m5 for
overall parsing compared with 3m3 before which is in the region of
statistical noise. The -e output is in around 10s which I think is
reasonable for the functionality.

I appreciate its taken a while to get here with this. I'm hopeful the
time waiting for review will be worth the revised patches.

Cheers,

Richard







