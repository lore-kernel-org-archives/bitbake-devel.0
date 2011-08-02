Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>)
	id 1QoGO3-0003zq-Hs; Tue, 02 Aug 2011 16:56:03 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 02 Aug 2011 07:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,306,1309762800"; d="scan'208";a="34278617"
Received: from unknown (HELO helios.localnet) ([10.255.18.59])
	by azsmga001.ch.intel.com with ESMTP; 02 Aug 2011 07:51:39 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: openembedded-core@lists.openembedded.org
Date: Tue, 2 Aug 2011 15:51:38 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic-pae; KDE/4.6.2; i686; ; )
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<201108021521.38404.paul.eggleton@linux.intel.com>
	<CABcZANmfd=HbE-wLQ6y-6s_DNYOhDQ7uYPuJ=Yebb6cpVpnykA@mail.gmail.com>
In-Reply-To: <CABcZANmfd=HbE-wLQ6y-6s_DNYOhDQ7uYPuJ=Yebb6cpVpnykA@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201108021551.38368.paul.eggleton@linux.intel.com>
Cc: Chris Larson <clarson@kergoth.com>, bitbake-devel@lists.openembedded.org,
	Phil Blundell <philb@gnu.org>
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
X-List-Received-Date: Tue, 02 Aug 2011 14:56:03 -0000
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 02 August 2011 15:27:58 Chris Larson wrote:
> On Tue, Aug 2, 2011 at 7:21 AM, Paul Eggleton
> 
> <paul.eggleton@linux.intel.com> wrote:
> > On Tuesday 02 August 2011 15:14:41 Chris Larson wrote:
> >> as config/class priority is
> >> determined by order of entries in BBLAYERS, whereas recipe priority is
> >> determined by layer.conf.
> > 
> > Is that a good thing though? At the moment I'm not convinced that it is.
> 
> I probably could have worded my reply better. I was pointing out the
> fact that the order is determined in two places right now as being one
> reason why I agreed with his statement that ordering determined by the
> layer isn't ideal.

Well, all the same I'd like to have that question answered, maybe that's a 
different thread.

Back to Phil's original point though, I tend to think issues with meta-oe 
ought to be solved by fixing meta-oe - if some things in meta-oe are causing so 
much trouble that we have to down-grade the priority of the layer in order to 
squelch them, that's bad.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


