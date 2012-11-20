Received: from vms173001pub.verizon.net ([206.46.173.1])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>) id 1Tasb3-0000b9-ED
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Nov 2012 19:31:20 +0100
Received: from gandalf.denix.org ([unknown] [71.191.205.12])
	by vms173001.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009))
	with ESMTPA id <0MDS00A3GQNIGJR0@vms173001.mailsrvcs.net>; Tue,
	20 Nov 2012 11:16:31 -0600 (CST)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id A4664201CF; Tue,
	20 Nov 2012 12:16:30 -0500 (EST)
Date: Tue, 20 Nov 2012 12:16:30 -0500
From: Denys Dmytriyenko <denis@denix.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Message-id: <20121120171630.GA19309@denix.org>
References: <alpine.DEB.2.02.1211201114100.29485@oneiric>
MIME-version: 1.0
In-reply-to: <alpine.DEB.2.02.1211201114100.29485@oneiric>
User-Agent: Mutt/1.5.20 (2009-06-14)
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
X-List-Received-Date: Tue, 20 Nov 2012 18:31:23 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Tue, Nov 20, 2012 at 11:24:20AM -0500, Robert P. J. Day wrote:
> 
>   i'm sure there's a trivial workaround/explanation for this, but i
> wanted to build the basic meta-ti based build for my panda ES, so i
> started with oe-core and added the meta-ti layer.  then, because of
> some license issues (and based on a quick google search), i added this
> to my local.conf:
> 
>   BBMASK = "meta-ti/recipes-misc"
> 
> at that point, after selecting "pandaboard" as the machine, i wanted
> to prefetch everything:
> 
> $ bitbake -c fetchall core-image-minimal
> 
> which used solely my pre-mirror directory so that didn't take long.
> 
>   *then*, because i allegedly had fetched everything i needed for the
> build, i edited my site.conf file and added:
> 
> BB_NO_NETWORK = "1"
> 
> which, AIUI, should be perfectly safe since i had just done a
> fetchall.  not so:
> 
> ERROR: Function failed: Network access disabled through BB_NO_NETWORK
> but access requested with command git clone --bare --mirror
> git://www.denx.de/git/u-boot.git
> /home/rpjday/y/builds/ti/panda/downloads/git2/www.denx.de.git.u-boot.git
> (for url None)
> ERROR: Logfile of failure stored in:
> /home/rpjday/y/builds/ti/panda/tmp-eglibc/work/pandaboard-oe-linux-gnueabi/u-boot-2011.12-r8/temp/log.do_fetch.29635
> 
> hmmmmmm ...
> 
> $ bitbake -s | grep u-boot
> nativesdk-u-boot-mkimage                          :2011.06-r0
> u-boot                                            :2011.12-r8
> u-boot-fw-utils                                   :2011.06-r1
> u-boot-mkimage                                    :2011.06-r0
> u-boot-mkimage-native                             :2011.06-r0
> $
> 
>   ok, now i'm confused.  the above suggests that the version of u-boot
> to be used here is 2011.12-r8, but that was never fetched, and it's
> only now toward the end of the build that the fetch is attempted.
> 
>   can someone clarify what's happening here?  why did my "fetchall"
> operation not fetch everything the build was going to need?

Is that because u-boot is not in a standard DEPENDS/RDEPENDS dependency tree, 
but rather in EXTRA_IMAGEDEPENDS list? I'm copying bitbake and oe-core lists, 
as I don't think it's meta-ti specific issue - u-boot recipe looks fine.

-- 
Denys


