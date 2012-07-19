Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Srnwz-00017z-TT; Thu, 19 Jul 2012 12:27:18 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6JAFsZ1001261;
	Thu, 19 Jul 2012 11:15:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00340-03; Thu, 19 Jul 2012 11:15:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6JAFisI001255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2012 11:15:45 +0100
Message-ID: <1342692948.7940.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 19 Jul 2012 11:15:48 +0100
In-Reply-To: <20120719094954.GF3331@jama.jama.net>
References: <1342606005.30680.17.camel@ted>
	<CAJTo0LbkkXkJH-mbxwqKK7KM1PWDdF4mD+K8omTF4SQ9_WDogQ@mail.gmail.com>
	<1342611618.30680.24.camel@ted> <20120719094954.GF3331@jama.jama.net>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] PLEASE READ: Major change landing shortly (python whitespace)
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
X-List-Received-Date: Thu, 19 Jul 2012 10:27:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-07-19 at 11:49 +0200, Martin Jansa wrote:
> On Wed, Jul 18, 2012 at 12:40:18PM +0100, Richard Purdie wrote:
> > On Wed, 2012-07-18 at 11:17 +0100, Burton, Ross wrote:
> > > On 18 July 2012 11:06, Richard Purdie
> > > <richard.purdie@linuxfoundation.org> wrote:
> > > > I put a proposal to the TSC, that we have bitbake warn/error whenever it
> > > > finds tab characters in any python function. The advantage of this is
> > > > that we give the user a clear definitive error. The downside is that
> > > > we'll have to go through all the metadata and scrub it for the problem.
> > > 
> > > Have you ran that warning over oe-core to check that there are not any
> > > legitimate uses of \t, not for indentation but inside strings?  I
> > > can't think of any realistic use but you never know (construct a
> > > Makefile in a python function?).
> > 
> > The check is for actual tab characters, not "\t". There are some
> > legitimate users of tab characters which I've replaced with \t in
> > strings.
> > 
> > My current patch work in progress for the conversion is:
> > 
> > http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/t14&id=49d3d01f3d61a0eb19b6852229fa8fc26712f653
> 
> from those 2 patches which were just merged I see that you're converting
> strictly python functions, can we extend this tabs->spaces rule also to
> bash tasks like do_install etc?

Shell tasks should be tabs according to the style guide. Its harder to
check the indentation in those and if the indentation is wrong, it
doesn't matter since they're not whitespace sensitive.

So whilst I'd welcome fixing them up, I don't think they need bitbake
enforcing policy in the same way as python functions.

Cheers,

Richard



