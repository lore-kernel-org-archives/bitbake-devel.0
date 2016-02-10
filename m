Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 05C47601D4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 21:10:44 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 10 Feb 2016 13:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,427,1449561600"; d="scan'208";a="650285527"
Received: from jlock-mobl1.gar.corp.intel.com ([10.252.28.47])
	by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2016 13:10:41 -0800
Message-ID: <1455138641.3442.8.camel@linux.intel.com>
From: Joshua G Lock <joshua.g.lock@linux.intel.com>
To: Mirela Rabulea <mirela.rabulea@nxp.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 10 Feb 2016 21:10:41 +0000
In-Reply-To: <VI1PR0401MB1789EE35802D99452B8F12638FD10@VI1PR0401MB1789.eurprd04.prod.outlook.com>
References: <AM4PR0401MB1778CA63CBE3FE654CB9EDC78FC30@AM4PR0401MB1778.eurprd04.prod.outlook.com>
	<1453903391.3557.42.camel@linux.intel.com>
	<VI1PR0401MB1789EE35802D99452B8F12638FD10@VI1PR0401MB1789.eurprd04.prod.outlook.com>
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
X-List-Received-Date: Wed, 10 Feb 2016 21:10:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Mirela,

On Thu, 2016-02-04 at 15:22 +0000, Mirela Rabulea wrote:
> Hi Joshua,
> Please see my comments below, prefixed with [M.R.].
> Thanks a lot for the review, v2 of the patch is attached (squashed
> version, sorry, but my git send-email is still not working).
> 
> Only the latest changes, for easier review:

These changes look good, thanks.

I've tested this patch a couple of ways. If I launch Hob and press
"Images" to load an existing image from somewhere in my filesystem
things seem to work as expected.

However if I build an image (core-image-minimal) for a non-qemu machine
(genericx86-64), once the build is done I can see 'Run custom image'
button (between 'Build new image' and 'Deploy image').

The 'Run script' box indicates that the script is pointing to 'runqemu'
but when I click 'Run custom image' I get a dialogue asking to 'Select
the image file you want to run:' with 'Cancel' and 'Run image' buttons
but nothing listing selectable images (I even tried resizing the
dialogue, to no avail). If I proceed to click 'Run image' button the
'Usb image maker' dialogue is presented.

Regards,

Joshua

