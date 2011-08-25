Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>)
	id 1QwXaI-0006Vy-Rm; Thu, 25 Aug 2011 12:54:55 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 25 Aug 2011 03:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,280,1312182000"; d="scan'208";a="44938090"
Received: from unknown (HELO helios.localnet) ([10.255.18.129])
	by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2011 03:50:04 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org,
	"Patches and discussions about the oe-core layer"
	<openembedded-core@lists.openembedded.org>
Date: Thu, 25 Aug 2011 11:50:01 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic-pae; KDE/4.6.2; i686; ; )
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<CABcZAN=rG0acoqcV6s-gNvvziM0ON97BzNwtZkESu+wz7vQO-g@mail.gmail.com>
	<A3E3935F-5D98-4208-A45F-DC409F1C97CF@gmail.com>
In-Reply-To: <A3E3935F-5D98-4208-A45F-DC409F1C97CF@gmail.com>
MIME-Version: 1.0
Message-Id: <201108251150.01236.paul.eggleton@linux.intel.com>
Subject: Re: [OE-core] Layer priorities influencing default version selection
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
X-List-Received-Date: Thu, 25 Aug 2011 10:54:55 -0000
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 02 August 2011 16:35:12 Khem Raj wrote:
> On Aug 2, 2011, at 7:14 AM, Chris Larson <clarson@kergoth.com> wrote:
> > On Tue, Aug 2, 2011 at 6:52 AM, Phil Blundell <philb@gnu.org> wrote:
> >> Actually, to some extent I consider it a bit of a misfeature that the
> >> layer priority is specified by the layer rather than by the user in
> >> bblayers.conf, since this makes it harder to vary the stack-up order
> >> without local hackery to the layer files.  For example, meta-oe
> >> currently sets itself to a higher priority than oe-core, but I've found
> >> that it generally seems to suit me better if meta-oe is actually the
> >> lower-priority layer.
> > 
> > Agreed. It also means that the priority knowledge is split between
> > layer.conf and bblayers.conf today, as config/class priority is
> > determined by order of entries in BBLAYERS, whereas recipe priority is
> > determined by layer.conf.
> 
> In my opinion the layer priority for all kind of meta data should be
> consistent and selected using bblayers.conf

So I've thought about this more, and I don't think it is a good idea, for two 
reasons:

1) It increases the complexity by a huge amount. New users will have to 
understand how to set the priorities, and if someone reports a problem, we now 
not only need to know what layers they are using, we also need to know what 
mangling of the priorities they might have done. We'd just be introducing more 
potentially untested configurations (as if we don't have enough already.)

2) It just papers over real problems in meta-oe or any other layer you might 
choose to use on top. As I said, if meta-oe has stuff in it that is not 
working, it should be fixed or removed. Let's fix problems instead of finding 
ways of ignoring them.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


