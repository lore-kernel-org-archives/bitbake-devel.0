Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QbXYe-0004XH-4P for bitbake-devel@lists.openembedded.org;
	Tue, 28 Jun 2011 14:38:24 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5SCYVQr022754;
	Tue, 28 Jun 2011 13:34:31 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22538-04; Tue, 28 Jun 2011 13:34:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5SCYN2c022748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Jun 2011 13:34:23 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <BANLkTin4EJ8ekJpHqpLxnO9AxZJbAibP3g@mail.gmail.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<f9c4e4502da0fbb1376f987ae8a81073567143f5.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<BANLkTinGUdo-ar4NHN6zgfvS7Gf4F3USYQ@mail.gmail.com>
	<20110624183837.GI29476@denix.org> <1309182577.20015.233.camel@rex>
	<BANLkTin4EJ8ekJpHqpLxnO9AxZJbAibP3g@mail.gmail.com>
Date: Tue, 28 Jun 2011 13:34:09 +0100
Message-ID: <1309264449.20015.278.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Martin Jansa <martin.jansa@gmail.com>
Subject: Re: [PATCH 1/1] die if a .bbappend file matches no existing .bb recipe
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
X-List-Received-Date: Tue, 28 Jun 2011 12:38:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-06-27 at 07:05 -0700, Chris Larson wrote:
> On Mon, Jun 27, 2011 at 6:49 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > On Fri, 2011-06-24 at 14:38 -0400, Denys Dmytriyenko wrote:
> >> On Fri, Jun 24, 2011 at 11:16:53AM -0700, Chris Larson wrote:
> >> > On Mon, Jun 20, 2011 at 12:29 AM, Cui, Dexuan <dexuan.cui@intel.com> wrote:
> >> > > Martin Jansa wrote:
> >> > >> On Mon, Jun 20, 2011 at 6:34 AM, Dexuan Cui <dexuan.cui@intel.com>
> >> > >> wrote:
> >> > >>> This patch moves the logic of show_appends_with_no_recipes from
> >> > >>> bitbake-layers into bitbake, and makes the script die with a fatal
> >> > >>> error message printed.
> >> > >>
> >> > >> I agree that this is problem, but I'm not sure if it should be fatal.
> >> > >>
> >> > >> Imagine the case when you enable some layer managed by someone else
> >> > >> (lets call it LS) and you're using different oe-core revision, maybe
> >> > >> current HEAD and that LS wasn't updated for that or vice versa you're
> >> > >> using some oe-core release version and you want to reuse some recipes
> >> > >> from LS in current version.
> >> > >>
> >> > >> I think that big fat warning that some .bbappends does not match
> >> > >> should be enough to decide if it's fatal for me (and I'll kill that
> >> > >> build) or that's fine (when I'm not interested in those .bbappends
> >> > >> from LS and I'm using only some other .bb files from LS).
> >> > >>
> >> > >> If we make it fatal then I would be forced to remove unmatched
> >> > >> .bbappends from LS before build which can be difficult to share
> >> > >> (unless I create own LS branch and use it in my distro).
> >> > > Thanks a lot for the explanation!
> >> > > So looks we may as well change the "bb.fatal" to "bb.error"(that is not
> >> > > fatal and wouldn't be ignored by bitbake-layers).
> >> > > This is the new patch (on a new branch dcui/bb-v2):
> >> > > http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=dcui/bb-v2&id=2a520959f71ec2cd80ed2088bfcf082631161a1a
> >> >
> >> > Are you sure this shouldn't be a warning? Remember that any error
> >> > displayed results in a non-zero exit code from bitbake.
> >>
> >> So, speaking of which - what is the practical use for bb.error? It gives an
> >> error message, but doesn't stop the build. Although it returns a non-zero exit
> >> code, which for most autobuilders indicate a failed build anyway... What's the
> >> point?
> >
> > It denotes something which the user really needs to know about and fix.
> > The sanity tests are good example and I'd really like to see sanity
> > issues becoming bb.errors in most cases.
> >
> > You can also think about it as being a point on the error severity
> > scale:
> >
> > Note: Information only
> > Warning: Something happened which the user likely needs to fix
> > Error: Something happened the user is strongly recommended to fix - set
> >       exit code accordingly.
> > Fatal: Something bad happened and there is no hope so stop.
> >
> > I think in the scheme of different error priorities and actions, it
> > makes sense...
> 
> I really don't think they're very useful right now. If our UIs
> actually captured the errors and summarized them at the end of the
> build, as well as had them in a global log, then I could see them
> being of use, but having an error message that might have scrolled
> past an hour ago result in a non-zero exit code is far from ideal. As
> a user, I have no idea why it seems to have failed.

Well, patches to improve the UIs in the regard are welcome. At least at
this point we can do this kind of thing at the UI level which is way
better than the situation used to be.

I'd also argue its better to have any indication there was a problem
than none at all...

Cheers,

Richard




