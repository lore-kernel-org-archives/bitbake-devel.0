Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>)
	id 1QoFv0-0003EM-HM; Tue, 02 Aug 2011 16:26:02 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Aug 2011 07:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,306,1309762800"; d="scan'208";a="37078345"
Received: from unknown (HELO helios.localnet) ([10.255.18.59])
	by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2011 07:21:39 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 2 Aug 2011 15:21:38 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic-pae; KDE/4.6.2; i686; ; )
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<1312293167.4325.38.camel@phil-desktop>
	<CABcZAN=rG0acoqcV6s-gNvvziM0ON97BzNwtZkESu+wz7vQO-g@mail.gmail.com>
In-Reply-To: <CABcZAN=rG0acoqcV6s-gNvvziM0ON97BzNwtZkESu+wz7vQO-g@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201108021521.38404.paul.eggleton@linux.intel.com>
Cc: Chris Larson <clarson@kergoth.com>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
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
X-List-Received-Date: Tue, 02 Aug 2011 14:26:02 -0000
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tuesday 02 August 2011 15:14:41 Chris Larson wrote:
> as config/class priority is
> determined by order of entries in BBLAYERS, whereas recipe priority is
> determined by layer.conf.

Is that a good thing though? At the moment I'm not convinced that it is.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


