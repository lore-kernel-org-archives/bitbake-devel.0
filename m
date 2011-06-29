Received: from vms173003pub.verizon.net ([206.46.173.3])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>) id 1QbyzU-0007zO-8f
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 19:55:56 +0200
Received: from gandalf.denix.org ([unknown] [108.18.140.4])
	by vms173003.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0LNK000DM9I3RYU5@vms173003.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 11:51:52 -0500 (CDT)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id 5AED714AF5D; Wed,
	29 Jun 2011 12:51:39 -0400 (EDT)
Date: Wed, 29 Jun 2011 12:51:39 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-id: <20110629165139.GA8160@denix.org>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<201106271406.45596.paul.eggleton@linux.intel.com>
	<1309264777.20015.280.camel@rex>
	<1865303E0DED764181A9D882DEF65FB6A167F0C723@shsmsx502.ccr.corp.intel.com>
	<1309364097.20015.414.camel@rex>
MIME-version: 1.0
In-reply-to: <1309364097.20015.414.camel@rex>
User-Agent: Mutt/1.5.16 (2007-06-09)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	'Martin Jansa' <martin.jansa@gmail.com>
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
X-List-Received-Date: Wed, 29 Jun 2011 17:55:56 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Wed, Jun 29, 2011 at 05:14:57PM +0100, Richard Purdie wrote:
> On Thu, 2011-06-30 at 00:03 +0800, Cui, Dexuan wrote:
> > Sorry -- what's the conclusion?
> > Keeping the v2 patch
> > (http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=dcui/bb-v2&id=2a520959f71ec2cd80ed2088bfcf082631161a1a)
> > , or changing bb.error() to bb.warn()?
> 
> Where you have:
> 
>   bb.error('No recipes available for:\n%s' % '\n'.join(appendlines))
> 
> this would become something like:
> 
>   msg = 'No recipes available for:\n%s' % '\n'.join(appendlines)
>   if d.getVar("BB_DANGLINGAPPENDS_WARNONLY", False):
>      bb.warn(msg)
>   else:
>      bb.fatal(msg)
> 
> which means we can have a strong default but advanced
> users/distros/whoever can avoid this.

Thanks! That's a nice compromise.

-- 
Denys


