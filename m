Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1Tisjs-0007sl-0R
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Dec 2012 21:17:11 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([174.115.5.73]:45512 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1TisVn-0003Y3-EF; Wed, 12 Dec 2012 15:02:35 -0500
Date: Wed, 12 Dec 2012 15:02:31 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: =?ISO-8859-15?Q?Eren_T=FCrkay?= <eren@hambedded.org>
In-Reply-To: <20121212195335.GB743@gmail.com>
Message-ID: <alpine.DEB.2.02.1212121459210.13746@oneiric>
References: <20121212184156.GA743@gmail.com>
	<alpine.DEB.2.02.1212121356150.13192@oneiric>
	<20121212195335.GB743@gmail.com>
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
Subject: Re: [PATCH] bitbake.vim: detect *.bbappend files in ftdetect automatically
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
X-List-Received-Date: Wed, 12 Dec 2012 20:17:11 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-865278102-1355342554=:13746"

--8323329-865278102-1355342554=:13746
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 12 Dec 2012, Eren Türkay wrote:

> On Wed, Dec 12, 2012 at 01:57:53PM -0500, Robert P. J. Day wrote:
> >   gack.  there's no compelling reason to be that, um, pedantic with
> > the wildcard pattern.  just use
> >
> >   *.{bb,bbappend,bbclass}
> >
> > trying to save a couple characters while introducing that kind of
> > visual ugliness just isn't worth it.
>
> It can be used but I was not the one who introduced "that kind of
> visual ugliness" :) I just sticked with the old one, adding
> bbappend.
>
> Visual ugliness/goodness depends on person to person. To me, it
> doesn't look ugly at all. I've seen things uglier than just an
> innocent wildcard pattern.

  sorry, i didn't mean to pick on you. :-)  i would avoid that kind of
extreme optimization for a couple reasons.

  first, it just *looks* like a typo at first glance.  when i saw it,
my immediate reaction was, oops, spelling mistake and i had to look
again to see it wasn't.

  also, it's sort of just a fluke that you can do that kind of
optimization.  the instant you add another suffix that starts with
something other than a "b", it messes things up and you lose the
advantage.

  anyway, i will leave this in the hands of folks higher up the food
chain.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323329-865278102-1355342554=:13746--
