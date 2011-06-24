Received: from vms173001pub.verizon.net ([206.46.173.1])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>) id 1QaE9V-0004zH-GQ
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Jun 2011 23:43:01 +0200
Received: from gandalf.denix.org ([unknown] [108.18.140.4])
	by vms173001.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0LNB004YL54DYZJ1@vms173001.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Fri, 24 Jun 2011 13:38:38 -0500 (CDT)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id 2BB1F14AF5D; Fri,
	24 Jun 2011 14:38:37 -0400 (EDT)
Date: Fri, 24 Jun 2011 14:38:37 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: Chris Larson <clarson@kergoth.com>
Message-id: <20110624183837.GI29476@denix.org>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<f9c4e4502da0fbb1376f987ae8a81073567143f5.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<BANLkTinGUdo-ar4NHN6zgfvS7Gf4F3USYQ@mail.gmail.com>
MIME-version: 1.0
In-reply-to: <BANLkTinGUdo-ar4NHN6zgfvS7Gf4F3USYQ@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Martin Jansa <martin.jansa@gmail.com>
Subject: Re: [PATCH 1/1] die if a .bbappend file matches no	existing .bb recipe
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
X-List-Received-Date: Fri, 24 Jun 2011 21:43:01 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Fri, Jun 24, 2011 at 11:16:53AM -0700, Chris Larson wrote:
> On Mon, Jun 20, 2011 at 12:29 AM, Cui, Dexuan <dexuan.cui@intel.com> wrote:
> > Martin Jansa wrote:
> >> On Mon, Jun 20, 2011 at 6:34 AM, Dexuan Cui <dexuan.cui@intel.com>
> >> wrote:
> >>> This patch moves the logic of show_appends_with_no_recipes from
> >>> bitbake-layers into bitbake, and makes the script die with a fatal
> >>> error message printed.
> >>
> >> I agree that this is problem, but I'm not sure if it should be fatal.
> >>
> >> Imagine the case when you enable some layer managed by someone else
> >> (lets call it LS) and you're using different oe-core revision, maybe
> >> current HEAD and that LS wasn't updated for that or vice versa you're
> >> using some oe-core release version and you want to reuse some recipes
> >> from LS in current version.
> >>
> >> I think that big fat warning that some .bbappends does not match
> >> should be enough to decide if it's fatal for me (and I'll kill that
> >> build) or that's fine (when I'm not interested in those .bbappends
> >> from LS and I'm using only some other .bb files from LS).
> >>
> >> If we make it fatal then I would be forced to remove unmatched
> >> .bbappends from LS before build which can be difficult to share
> >> (unless I create own LS branch and use it in my distro).
> > Thanks a lot for the explanation!
> > So looks we may as well change the "bb.fatal" to "bb.error"(that is not 
> > fatal and wouldn't be ignored by bitbake-layers).
> > This is the new patch (on a new branch dcui/bb-v2):
> > http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=dcui/bb-v2&id=2a520959f71ec2cd80ed2088bfcf082631161a1a
> 
> Are you sure this shouldn't be a warning? Remember that any error
> displayed results in a non-zero exit code from bitbake.

So, speaking of which - what is the practical use for bb.error? It gives an 
error message, but doesn't stop the build. Although it returns a non-zero exit 
code, which for most autobuilders indicate a failed build anyway... What's the 
point?

-- 
Denys


