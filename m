Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SrUDC-0003tl-As; Wed, 18 Jul 2012 15:22:42 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6IDBIkg025030;
	Wed, 18 Jul 2012 14:11:18 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23940-06; Wed, 18 Jul 2012 14:11:14 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6IDBAVv025023
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2012 14:11:12 +0100
Message-ID: <1342617074.30680.26.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 18 Jul 2012 14:11:14 +0100
In-Reply-To: <20120718104012.GJ22569@jama.jama.net>
References: <1342606005.30680.17.camel@ted>
	<20120718104012.GJ22569@jama.jama.net>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: PLEASE READ: Major change landing shortly (python whitespace)
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
X-List-Received-Date: Wed, 18 Jul 2012 13:22:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-07-18 at 12:40 +0200, Martin Jansa wrote:
> On Wed, Jul 18, 2012 at 11:06:45AM +0100, Richard Purdie wrote:
> > It's become clear we have a horrible mixture of whitespace (tabs and
> > space) in python functions. At first glance this sounds trivial but
> > there is a serious problem if pieces of code get mixed together with
> > different whitespace since they may or may not work as intended.
> > 
> > The documented standard for python functions is four space indentation
> > although we have a mixture. Fixing this sounds simple at first, we just
> > go through and change tabs to spaces. The problem comes with _append and
> > _prepend to python functions since both need their whitespace changed at
> > the same time. populate_packages() is the real problem child in that
> > regard but its the less common examples I worry about.
> > 
> > I did some research and we have inconsistencies, even in existing
> > functions since people are editing files and getting confused
> > (understandably).
> > 
> > So the question becomes, how do we get ourselves out of this mess?
> > 
> > I put a proposal to the TSC, that we have bitbake warn/error whenever it
> > finds tab characters in any python function. The advantage of this is
> > that we give the user a clear definitive error. The downside is that
> > we'll have to go through all the metadata and scrub it for the problem.
> > 
> > The TSC agrees we should do something about this rather than perpetuate
> > the problem and that this is as good a solution as any of us can come up
> > with. We also agreed that we should do it sooner than later before it
> > gets any later in this release cycle. Putting it off until the next
> > release cycle didn't seem to offer any advantage, we might as well get
> > on with it.
> > 
> > So I am going to:
> > 
> > a) Try and flush through as many pending patches as I can.
> > b) Check in a warning into bitbake master and increase its version
> > c) Require that version in OE-Core
> 
> Great.. this is usefull also for latest change from proto to protocol
> param in fetcher, but please make sure that the svn.py patch I've sent
> yesterday is also in before release..

I was aware of this issue too which was at the back of my mind when I
proposed this. The svn patch is in now.

Cheers,

Richard



