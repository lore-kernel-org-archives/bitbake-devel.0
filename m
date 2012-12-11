Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TiTms-0000pi-6n; Tue, 11 Dec 2012 18:38:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBBHNp5T013675;
	Tue, 11 Dec 2012 17:23:51 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13481-01; Tue, 11 Dec 2012 17:23:47 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBBHNgJH013669
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2012 17:23:44 GMT
Message-ID: <1355246622.6771.38.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Tue, 11 Dec 2012 17:23:42 +0000
In-Reply-To: <alpine.DEB.2.02.1211201253230.27867@oneiric>
References: <alpine.DEB.2.02.1211201114100.29485@oneiric>
	<20121120171630.GA19309@denix.org>
	<alpine.DEB.2.02.1211201227390.27315@oneiric>
	<20121120174811.GB19309@denix.org>
	<alpine.DEB.2.02.1211201253230.27867@oneiric>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: meta-ti mailing list <meta-ti@yoctoproject.org>,
	bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [meta-ti] building for pandaboard fails fetching u-boot *way* into the build phase
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
X-List-Received-Date: Tue, 11 Dec 2012 17:38:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-11-20 at 12:55 -0500, Robert P. J. Day wrote:
> On Tue, 20 Nov 2012, Denys Dmytriyenko wrote:
> 
> > On Tue, Nov 20, 2012 at 12:34:47PM -0500, Robert P. J. Day wrote:
> > > On Tue, 20 Nov 2012, Denys Dmytriyenko wrote:
> > >
> > > > On Tue, Nov 20, 2012 at 11:24:20AM -0500, Robert P. J. Day wrote:
> > > > >
> > > > >   i'm sure there's a trivial workaround/explanation for this, but i
> > > > > wanted to build the basic meta-ti based build for my panda ES, so i
> > > > > started with oe-core and added the meta-ti layer.  then, because of
> > > > > some license issues (and based on a quick google search), i added this
> > > > > to my local.conf:
> > > > >
> > > > >   BBMASK = "meta-ti/recipes-misc"
> > > > >
> > > > > at that point, after selecting "pandaboard" as the machine, i wanted
> > > > > to prefetch everything:
> > > > >
> > > > > $ bitbake -c fetchall core-image-minimal
> > > > >
> > > > > which used solely my pre-mirror directory so that didn't take long.
> > > > >
> > > > >   *then*, because i allegedly had fetched everything i needed for the
> > > > > build, i edited my site.conf file and added:
> > > > >
> > > > > BB_NO_NETWORK = "1"
> > > > >
> > > > > which, AIUI, should be perfectly safe since i had just done a
> > > > > fetchall.  not so:
> > > > >
> > > > > ERROR: Function failed: Network access disabled through BB_NO_NETWORK
> > > > > but access requested with command git clone --bare --mirror
> > > > > git://www.denx.de/git/u-boot.git
> > > > > /home/rpjday/y/builds/ti/panda/downloads/git2/www.denx.de.git.u-boot.git
> > > > > (for url None)
> > > > > ERROR: Logfile of failure stored in:
> > > > > /home/rpjday/y/builds/ti/panda/tmp-eglibc/work/pandaboard-oe-linux-gnueabi/u-boot-2011.12-r8/temp/log.do_fetch.29635
> > > > >
> > > > > hmmmmmm ...
> > > > >
> > > > > $ bitbake -s | grep u-boot
> > > > > nativesdk-u-boot-mkimage                          :2011.06-r0
> > > > > u-boot                                            :2011.12-r8
> > > > > u-boot-fw-utils                                   :2011.06-r1
> > > > > u-boot-mkimage                                    :2011.06-r0
> > > > > u-boot-mkimage-native                             :2011.06-r0
> > > > > $
> > > > >
> > > > >   ok, now i'm confused.  the above suggests that the version of u-boot
> > > > > to be used here is 2011.12-r8, but that was never fetched, and it's
> > > > > only now toward the end of the build that the fetch is attempted.
> > > > >
> > > > >   can someone clarify what's happening here?  why did my "fetchall"
> > > > > operation not fetch everything the build was going to need?
> > > >
> > > > Is that because u-boot is not in a standard DEPENDS/RDEPENDS
> > > > dependency tree, but rather in EXTRA_IMAGEDEPENDS list? I'm copying
> > > > bitbake and oe-core lists, as I don't think it's meta-ti specific
> > > > issue - u-boot recipe looks fine.
> > >
> > >   good question ... for which i don't know the answer.  to make sure
> > > this is reproducible, i blew everything away and started from scratch
> > > with a new panda build.  here's my bblayers.conf:
> > >
> > >   but when i do a "fetchall", i don't get u-boot_2011.12.  only when i
> > > try to build a core-image-minimal does the build fail toward the end
> > > trying to fetch u-boot_2011.12.  here's the layering info:
> > >
> > > i'm sure i'm just doing something silly, but i've never run into the
> > > situation where a "fetchall" doesn't actually fetch absolutely
> > > everything that's needed for the build.
> >
> > Try adding CORE_IMAGE_EXTRA_INSTALL="u-boot" somewhere, like local.conf and
> > if that fixes your usecase, it has to be a bug with bitbake forgetting to
> > pre-fetch machine's specific EXTRA_IMAGEDEPENDS - file a bug then.
> 
>   yup, that did it ... now bitbake is trying to fetch it.  so that's
> the problem.

FWIW, this is the same issue as
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3554

since EXTRA_IMAGEDEPENDS get injected as tdepends and these aren't
becoming part of recrdepends any more.

Cheers,

Richard



