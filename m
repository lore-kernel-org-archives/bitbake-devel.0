Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id DB23560797
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Feb 2016 17:00:04 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 15 Feb 2016 09:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,451,1449561600"; d="scan'208";a="48198989"
Received: from jlock-mobl1.gar.corp.intel.com ([10.252.12.36])
	by fmsmga004.fm.intel.com with ESMTP; 15 Feb 2016 09:00:02 -0800
Message-ID: <1455555597.4309.29.camel@linux.intel.com>
From: Joshua G Lock <joshua.g.lock@linux.intel.com>
To: Mirela Rabulea <mirela.rabulea@nxp.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Feb 2016 16:59:57 +0000
In-Reply-To: <1455555256.4309.27.camel@linux.intel.com>
References: <AM4PR0401MB1778CA63CBE3FE654CB9EDC78FC30@AM4PR0401MB1778.eurprd04.prod.outlook.com>
	<1453903391.3557.42.camel@linux.intel.com>
	<VI1PR0401MB1789EE35802D99452B8F12638FD10@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<1455138641.3442.8.camel@linux.intel.com>
	<VI1PR0401MB178927E4A92EFB4DC3E706978FA80@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<VI1PR0401MB17898F62326CD302A05CD3F38FA90@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<VI1PR0401MB1789BE8BA7AD90A09B2C23E18FAB0@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<1455555256.4309.27.camel@linux.intel.com>
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Mime-Version: 1.0
Cc: Nicolae Manescu <nicu.manescu@nxp.com>,
	Alexandru Purice <alexandru.purice@nxp.com>, "Roman,
	Alexandru CostinX" <alexandru.costinx.roman@intel.com>,
	"Voiculescu, BogdanX A" <bogdanx.a.voiculescu@intel.com>
Subject: Re: [PATCH] Fix bug 8940 - Alow Hob to run images on a custom simulator, other than qemu
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 15 Feb 2016 17:00:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2016-02-15 at 16:54 +0000, Joshua G Lock wrote:
> On Sun, 2016-02-14 at 22:09 +0000, Mirela Rabulea wrote:
> > Hi Joshua,
> > I found one more issue with a corner case when commuting from "Run
> > custom image" to "Deploy image". From the comments I found in the
> > code, the case when there are both "runnable" and "deployable"
> > present in the same build is not expected.
> > However, with the introduction of the "Run custom", I think this
> > requires a fix, so here is the v4 of the patch (squashed version
> > attached).
> > If you did not get to check the v3 patch, you may skip it and check
> > the v4.
> 
> With this patch applied I'm still seeing the same behaviour — after
> building core-image-minimal for genericx86-64 runqemu is displayed as
> the run script but clicking on "Run custom image" launches the "Usb
> image maker".

Whoops, no I'm not — I was still running an older version of the patch.

I'll take a proper look at v4 tomorrow.

Apologies for the noise,

Joshua

