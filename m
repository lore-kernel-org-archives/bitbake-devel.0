Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id BB796757B5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 08:29:34 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 03 Jun 2015 01:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,546,1427785200"; d="scan'208";a="502000606"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com) ([10.252.4.158])
	by FMSMGA003.fm.intel.com with ESMTP; 03 Jun 2015 01:29:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Trevor Woerner <twoerner@gmail.com>
Date: Wed, 03 Jun 2015 09:29:33 +0100
Message-ID: <1864202.kORZmOejQd@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.7 (Linux/3.19.7-200.fc21.x86_64; KDE/4.14.7; x86_64; ; )
In-Reply-To: <5568C7FD.8070903@gmail.com>
References: <555FA65A.1020505@gmail.com>
	<7025804.ZvuMXxFa1D@peggleto-mobl.ger.corp.intel.com>
	<5568C7FD.8070903@gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake-layers layerindex-fetch
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
X-List-Received-Date: Wed, 03 Jun 2015 08:29:34 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 May 2015 16:11:41 Trevor Woerner wrote:
> On 05/26/15 09:51, Paul Eggleton wrote:
> > This is controlled by BBLAYERS_FETCH_DIR; by default this is set to
> > "${COREBASE}" with ??= so you can set it to your preferred value in
> > local.conf as desired. (We should definitely document this, I acknowledge
> > at the moment it isn't documented anywhere.)
> 
> It'd be nice if "bitbake-layers remove-layer" had the same mechanism.
> Some way (preferably using the same BBLAYERS_FETCH_DIR variable,
> possibly renamed so it made sense in both cases) to specify the base of
> where my layers are stored:
> 
>     $ bitbake-layers remove-layer meta-realtime
>     No layers matching /z/master/rpi-poky-linaro-rt/meta-realtime found
> in BBLAYERS
> 
> But my layers are stored in /z/master/layers.
> 
> 
> 
> 
> Of course I can get around this by using:
> 
>     $ bitbake-layers remove-layer *meta-realtime

Right, it expects a layer path and not just a layer name. I've entered the 
following enhancement:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=7839

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

