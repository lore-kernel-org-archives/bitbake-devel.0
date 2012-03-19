Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1S9bdZ-0001Xo-Qu
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 13:24:34 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1S9bV1-0003Rx-9L; Mon, 19 Mar 2012 08:15:43 -0400
Date: Mon, 19 Mar 2012 08:15:32 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <1927112.bGsHOkriYo@helios>
Message-ID: <alpine.DEB.2.02.1203190809400.23861@oneiric>
References: <alpine.DEB.2.02.1203190741220.22293@oneiric>
	<1927112.bGsHOkriYo@helios>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: some preliminary questions about bitbake manual
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
X-List-Received-Date: Mon, 19 Mar 2012 12:24:34 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 19 Mar 2012, Paul Eggleton wrote:

> On Monday 19 March 2012 07:49:59 Robert P. J. Day wrote:
> >   i'm about to write some tutorials on OE/bitbake/poky/yocto (from a
> > position of moderate ignorance, hoping that will change), so a couple
> > questions/observations before i get started.
> >
> >   at risk of repetition, i already noted that if you google on
> > "bitbake user manual", you end up here:
> >
> >   http://bitbake.berlios.de/manual/
> >
> > which is *way* out of date, so perhaps a link to something newer would
> > be useful.
>
> Yes, we acknowledge it is quite out of date. The problem with the
> BitBake manual is it must cover only BitBake generically, and not
> OE. Of course there's a lot that could be added to it, but having
> complete documentation there is less important than documenting OE.
> That's not to say we won't welcome patches though ;)

  yes, i can see the problem.  but rather than try to be a purist, why
not just accept that the best way to document bitbake is to do it
within the context of oe-core?  that's the approach i'm going to take
with what i'm writing.

> >   finally (for now), over at yocto, here's a quick tutorial on getting
> > started with oe-core:
> >
> >   https://wiki.yoctoproject.org/wiki/OpenEmbedded-Core
> >
> > it all looks reasonable but what you end up with in the oe-core
> > directory is two "bitbake.conf" files:
> >
> > $ find . -name bitbake.conf
> > ./meta/conf/bitbake.conf
> > ./bitbake/conf/bitbake.conf
> > $
> >
> >   i'm assuming that's by design and there are no weird conflicts
> > between the two files, right?
>
> Sort of - the last one is actually an example config and since it
> never ends up in BBPATH it will never be used. Now that you mention
> it, Richard mentioned to me recently that it should probably be
> renamed to bitbake.conf.sample to avoid confusion.

  ah, i should have noticed that.  yes, it would be helpful if it were
renamed to ".sample" to make that more obvious.  what would also be
useful is to point out that the "OVERRIDES =" directive doesn't occur
all that frequently.

  personally, when i'm reading docs, i like to have the source tree at
hand so i can search for examples of whatever i'm reading about, and
what i notice is that "OVERRIDES =" appears only in a .conf file.  a
reader might want to know that sort of thing to know that he/she needs
to examine only a single .conf file to see all of the current
OVERRIDES settings.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


