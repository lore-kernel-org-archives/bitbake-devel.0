Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TvXVk-0001XU-DZ for bitbake-devel@lists.openembedded.org;
	Wed, 16 Jan 2013 19:15:02 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0GHxUHX026199;
	Wed, 16 Jan 2013 17:59:30 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20832-06; Wed, 16 Jan 2013 17:59:26 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0GHxMbx026192
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2013 17:59:23 GMT
Message-ID: <1358359162.24249.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Seebach <peter.seebach@windriver.com>
Date: Wed, 16 Jan 2013 17:59:22 +0000
In-Reply-To: <1358358898.24249.8.camel@ted>
References: <cover.1357954043.git.peter.seebach@windriver.com>
	<1358358898.24249.8.camel@ted>
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
X-List-Received-Date: Wed, 16 Jan 2013 18:15:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-01-16 at 17:54 +0000, Richard Purdie wrote:
> I *really* want to take these, however I did want to check performance:
> 
> Before:
> 
> $ time bitbake core-image-sato -e
> real	0m8.034s
> $ time bitbake -p
> real	0m12.220s
> user	3m3.887s
> 
> After:
> 
> $ time bitbake core-image-sato -e
> real	0m50.267s
> $ time bitbake -p
> real	0m14.607s
> user	3m55.179s
> 
> 
> The 50s seems a touch excessive and it looks like a 20% parsing hit even
> when unused :(. Note the overall parsing times on this machine are fast
> as its running 24 in parallel. I'm going to try and figure out what is
> going on tomorrow as I've fixed a lot of this kind of thing in the past
> but wanted to mention it...

For those wanting to play:

bitbake core-image-sato -e -P

and looking at profile.log.processed shows 48 *million* calls to
deepcopy. That is a big clue to the problem.

Cheers,

Richard







