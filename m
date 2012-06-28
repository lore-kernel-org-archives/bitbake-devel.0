Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SkDHW-0003Zg-EV; Thu, 28 Jun 2012 13:53:07 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5SBgCbi024550;
	Thu, 28 Jun 2012 12:42:12 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22133-08; Thu, 28 Jun 2012 12:42:08 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5SBg2U4024544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Jun 2012 12:42:03 +0100
Message-ID: <1340883725.23146.101.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Thu, 28 Jun 2012 12:42:05 +0100
In-Reply-To: <lymx3oe0w5.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <1340793253.23146.19.camel@ted>
	<1340808774-24884-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
	<1340829332.23146.86.camel@ted>
	<lyr4t0e1bx.fsf@ensc-virt.intern.sigma-chemnitz.de>
	<lymx3oe0w5.fsf@ensc-virt.intern.sigma-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [PATCH 20/20] fetch: allow regexps in mirror protocol
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
X-List-Received-Date: Thu, 28 Jun 2012 11:53:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-06-28 at 02:27 +0200, Enrico Scholz wrote:
> Enrico Scholz <enrico.scholz@sigma-chemnitz.de> writes:
> 
> >>> -            if i != uri_decoded[loc]:
> >>> +            if not re.match(i, uri_decoded[loc]):
> >
> > | FAIL: test_urilist2 (bb.tests.fetch.FetcherTest)
> > | AssertionError: Lists differ: ['file:///somepath/downloads/b... != ['file:///someotherpath/downlo...
> > | - ['file:///somepath/downloads/bitbake-1.0.tar.gz',
> > | -  'file:///someotherpath/downloads/bitbake-1.0.tar.gz']
> > | ? ^
> > | 
> > | + ['file:///someotherpath/downloads/bitbake-1.0.tar.gz']
> > | ? ^
> >
> > Nothing which seems to be related to the patch.
> 
> I have to correct me... the new line should be
> 
> | +            if not re.match(i + '$', uri_decoded[loc]):
> 
> to match the complete protocol.

Agreed, this is going to make most sense. I've merged a patch which
reverts my original change and adds something like this (but checks the
pattern doesn't end with this already).

Hopefully this resolves the issues everyone was having.

Cheers,

Richard



