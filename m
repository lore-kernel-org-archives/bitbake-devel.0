Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QbXeX-0004eb-74 for bitbake-devel@lists.openembedded.org;
	Tue, 28 Jun 2011 14:44:29 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5SCeivF023012;
	Tue, 28 Jun 2011 13:40:44 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22990-01; Tue, 28 Jun 2011 13:40:36 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5SCdp2k022848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Jun 2011 13:39:52 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <201106271406.45596.paul.eggleton@linux.intel.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<201106271406.45596.paul.eggleton@linux.intel.com>
Date: Tue, 28 Jun 2011 13:39:37 +0100
Message-ID: <1309264777.20015.280.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org,
	'Martin Jansa' <martin.jansa@gmail.com>
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
X-List-Received-Date: Tue, 28 Jun 2011 12:44:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-06-27 at 14:06 +0100, Paul Eggleton wrote:
> Martin Jansa wrote:
> > Imagine the case when you enable some layer managed by someone else
> > (lets call it LS) and you're using different oe-core revision, maybe
> > current HEAD and that LS wasn't updated for that or vice versa you're
> > using some oe-core release version and you want to reuse some recipes
> > from LS in current version.
> > 
> > I think that big fat warning that some .bbappends does not match
> > should be enough to decide if it's fatal for me (and I'll kill that
> > build) or that's fine (when I'm not interested in those .bbappends
> > from LS and I'm using only some other .bb files from LS).
> > 
> > If we make it fatal then I would be forced to remove unmatched
> > .bbappends from LS before build which can be difficult to share
> > (unless I create own LS branch and use it in my distro).
> 
> I see what you're saying, but I'm worried about the visiblity (or lack 
> thereof) of these warnings.  If you start a build, go off somewhere and come 
> back when the build is part way through or finished, you may be oblivious to 
> the fact that there might be a serious problem - i.e. the customisations you 
> expected to be applied haven't been.
> 
> It all depends on whether the bbappends are supposed to apply to recipes that 
> are to be used in the build you're doing - if they are, then IMHO the error 
> should be fatal. I wonder if it's practical to make it work that way...?

I think it should be fatal by default but have some kind of variable we
can set to disable it...

Cheers,

Richard



