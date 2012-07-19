Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <heinold@mi.fu-berlin.de>) id 1SrmZ5-0007OI-VN
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jul 2012 10:58:32 +0200
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
	by outpost1.zedat.fu-berlin.de (Exim 4.69) with esmtp
	(envelope-from <heinold@mi.fu-berlin.de>)
	id <1Srm3s-0007iX-IA>; Thu, 19 Jul 2012 10:26:16 +0200
Received: from andorra.imp.fu-berlin.de ([160.45.42.84])
	by relay1.zedat.fu-berlin.de (Exim 4.69) with esmtp
	(envelope-from <heinold@mi.fu-berlin.de>)
	id <1Srm3s-00016d-8r>; Thu, 19 Jul 2012 10:26:16 +0200
Received: from heinold by internal andorra.imp.fu-berlin.de with local (Exim
	4.72) id 1Srm3p-0001ig-61; Thu, 19 Jul 2012 10:26:13 +0200
Date: Thu, 19 Jul 2012 10:26:13 +0200
From: Henning Heinold <heinold@inf.fu-berlin.de>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Message-ID: <20120719082613.GA5979@mi.fu-berlin.de>
References: <1342606005.30680.17.camel@ted>
	<CAJTo0LbkkXkJH-mbxwqKK7KM1PWDdF4mD+K8omTF4SQ9_WDogQ@mail.gmail.com>
	<1342611618.30680.24.camel@ted>
	<20120718214358.GT22569@jama.jama.net>
MIME-Version: 1.0
In-Reply-To: <20120718214358.GT22569@jama.jama.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: Henning Heinold <heinold@mi.fu-berlin.de>
X-Originating-IP: 160.45.42.84
X-Mailman-Approved-At: Fri, 20 Jul 2012 11:07:59 +0200
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Thu, 19 Jul 2012 08:58:32 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2012 at 11:43:58PM +0200, Martin Jansa wrote:
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
> Would be great if someone updates
> 
> bitbake/contrib/vim to highlight tabs, so that every tab would be easily
> spotted in recipe/bbclass.
> 
> And maybe also meta-openembedded/contrib/oe-stylize.py, but that seems
> to expand tabs to spaces already.
> 
> Cheers,
> 
> -- 
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

Hi,

should we enable the vim unwanted spaces/tabs higlighting too?

Bye Henning


