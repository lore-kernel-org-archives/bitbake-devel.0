Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TastP-0000pu-1S
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Nov 2012 19:49:56 +0100
Received: from cpebcc8100fb8db-cmbcc8100fb8d8.cpe.net.cable.rogers.com
	([174.116.196.46]:35131 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1Tarik-0000qP-VH; Tue, 20 Nov 2012 12:34:51 -0500
Date: Tue, 20 Nov 2012 12:34:47 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Denys Dmytriyenko <denis@denix.org>
In-Reply-To: <20121120171630.GA19309@denix.org>
Message-ID: <alpine.DEB.2.02.1211201227390.27315@oneiric>
References: <alpine.DEB.2.02.1211201114100.29485@oneiric>
	<20121120171630.GA19309@denix.org>
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
X-List-Received-Date: Tue, 20 Nov 2012 18:49:56 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 20 Nov 2012, Denys Dmytriyenko wrote:

> On Tue, Nov 20, 2012 at 11:24:20AM -0500, Robert P. J. Day wrote:
> >
> >   i'm sure there's a trivial workaround/explanation for this, but i
> > wanted to build the basic meta-ti based build for my panda ES, so i
> > started with oe-core and added the meta-ti layer.  then, because of
> > some license issues (and based on a quick google search), i added this
> > to my local.conf:
> >
> >   BBMASK = "meta-ti/recipes-misc"
> >
> > at that point, after selecting "pandaboard" as the machine, i wanted
> > to prefetch everything:
> >
> > $ bitbake -c fetchall core-image-minimal
> >
> > which used solely my pre-mirror directory so that didn't take long.
> >
> >   *then*, because i allegedly had fetched everything i needed for the
> > build, i edited my site.conf file and added:
> >
> > BB_NO_NETWORK = "1"
> >
> > which, AIUI, should be perfectly safe since i had just done a
> > fetchall.  not so:
> >
> > ERROR: Function failed: Network access disabled through BB_NO_NETWORK
> > but access requested with command git clone --bare --mirror
> > git://www.denx.de/git/u-boot.git
> > /home/rpjday/y/builds/ti/panda/downloads/git2/www.denx.de.git.u-boot.git
> > (for url None)
> > ERROR: Logfile of failure stored in:
> > /home/rpjday/y/builds/ti/panda/tmp-eglibc/work/pandaboard-oe-linux-gnueabi/u-boot-2011.12-r8/temp/log.do_fetch.29635
> >
> > hmmmmmm ...
> >
> > $ bitbake -s | grep u-boot
> > nativesdk-u-boot-mkimage                          :2011.06-r0
> > u-boot                                            :2011.12-r8
> > u-boot-fw-utils                                   :2011.06-r1
> > u-boot-mkimage                                    :2011.06-r0
> > u-boot-mkimage-native                             :2011.06-r0
> > $
> >
> >   ok, now i'm confused.  the above suggests that the version of u-boot
> > to be used here is 2011.12-r8, but that was never fetched, and it's
> > only now toward the end of the build that the fetch is attempted.
> >
> >   can someone clarify what's happening here?  why did my "fetchall"
> > operation not fetch everything the build was going to need?
>
> Is that because u-boot is not in a standard DEPENDS/RDEPENDS
> dependency tree, but rather in EXTRA_IMAGEDEPENDS list? I'm copying
> bitbake and oe-core lists, as I don't think it's meta-ti specific
> issue - u-boot recipe looks fine.

  good question ... for which i don't know the answer.  to make sure
this is reproducible, i blew everything away and started from scratch
with a new panda build.  here's my bblayers.conf:


# LAYER_CONF_VERSION is increased each time build/conf/bblayers.conf
# changes incompatibly
LCONF_VERSION = "5"

BBPATH = "${TOPDIR}"
BBFILES ?= ""

BBLAYERS ?= " \
  /home/rpjday/y/src/oe-core/meta \
  /home/rpjday/y/src/git/meta-ti \
  "

  and here's my site.conf:


SCONF_VERSION = "1"
SOURCE_MIRROR_URL ?= "file:///home/rpjday/y/src/dl/"
INHERIT += "own-mirrors"
BB_GENERATE_MIRROR_TARBALLS = "1"
# BB_NO_NETWORK = "1"


  once again, here's the allegedly preferred versions:

$ bitbake -s | grep u-boot
nativesdk-u-boot-mkimage                          :2011.06-r0
u-boot                                            :2011.12-r8
u-boot-fw-utils                                   :2011.06-r1
u-boot-mkimage                                    :2011.06-r0
u-boot-mkimage-native                             :2011.06-r0
$

  but when i do a "fetchall", i don't get u-boot_2011.12.  only when i
try to build a core-image-minimal does the build fail toward the end
trying to fetch u-boot_2011.12.  here's the layering info:

$ bitbake-layers show-recipes
... snip ...
u-boot:
  meta-ti              2011.12
  meta-ti              git
  meta                 v2011.06+git3+b1af6f532e0d348b153d5c148369229d24af361a
  meta                 v2012.04.01+git4+415d386877df49eb051b85ef74fa59a16dc17c7d
  meta                 v2011.03+git1+19b54a701811220221fc4d5089a2bb18892018ca
  meta-ti              2011.09 (skipped)
  meta-ti              2011.10rc (skipped)
  meta-ti              2012.07 (skipped)
  meta-ti              2011.06 (skipped)
  meta-ti              2011.09-psp04.06.00.08 (skipped)
  meta-ti              2010.06-psp (skipped)u-boot-fw-utils:
  meta                 2011.06
  meta                 v2012.04.01+git1+415d386877df49eb051b85ef74fa59a16dc17c7d


i'm sure i'm just doing something silly, but i've never run into the
situation where a "fetchall" doesn't actually fetch absolutely
everything that's needed for the build.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


