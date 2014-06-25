Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 20A9B60E24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jun 2014 13:56:57 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 25 Jun 2014 06:51:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,546,1400050800"; d="scan'208";a="563225337"
Received: from unknown (HELO peggleto-mobl5.ger.corp.intel.com)
	([10.252.121.119])
	by orsmga002.jf.intel.com with ESMTP; 25 Jun 2014 06:56:08 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 25 Jun 2014 14:56:07 +0100
Message-ID: <1917643.yKPVX7CVPo@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.5 (Linux/3.14.8-200.fc20.x86_64; KDE/4.12.5; x86_64; ; )
In-Reply-To: <alpine.LFD.2.11.1406220832520.1583@localhost>
References: <alpine.LFD.2.11.1406220832520.1583@localhost>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: can someone explain "git" versus "gitr" wrt PREFERRED_VERSION?
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
X-List-Received-Date: Wed, 25 Jun 2014 13:57:01 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Robert,

On Sunday 22 June 2014 08:52:08 Robert P. J. Day wrote:
>   possibly a stupid question but i've never let that stop me before.
> still rummaging around in the bitbake user manual and looking through
> the oe and poky codebase, and i notice examples like this (from poky).
> 
>   first, there's the recipe and PREFERRED_VERSION for drm:
> 
> meta/recipes-graphics/drm/libdrm_git.bb:
>   SRCREV = "e01d68f9f3acfc35fe164283904b5d058c2ab378"
>   PV = "2.4.40+git${SRCPV}"
> 
> meta-yocto/conf/distro/include/poky-floating-revisions.inc:
>   #PREFERRED_VERSION_libdrm ?= "2.4.0+git${SRCREV}"
> 
>   also, the recipe and PFEFERRED_VERSION for libxcb:
> 
> meta/recipes-graphics/xorg-lib/libxcb_git.bb:
>   SRCREV = "625ed596cae6dd8175aeb6cb6f26784928042f22"
>   PV = "1.1.90.1+gitr${SRCPV}"
> 
> meta-yocto/conf/distro/include/poky-floating-revisions.inc:
>   #PREFERRED_VERSION_libxcb ?= "1.1.90.1+gitr${SRCREV}"
> 
> 
>   admittedly, the PREFERRED_VERSION settings for both of those are
> commented out

It's a good job that they are by the way, because a ${SRCREV} reference in 
PREFERRED_VERSION absolutely will not work. (We have % wildcard support in 
PREFERRED_VERSION to handle this situation.) 


> , but why does the first use:
> 
>   git${SRCREV}
> 
> while the second uses:
> 
>   gitr${SRCREV}
> 
> so what's with "git" versus "gitr"? i see no mention of this in the
> bitbake user manual (would that be the right place to explain that?).
> or is that covered in one of the higher-level yocto manuals?

gitr in PV is an old convention. I don't think it really warrants explanation, 
just use the current convention.

>   also (and i realize this is outside the scope of the bitbake
> manual), i noticed the meta-oe layer adds another git-based version
> selector in the gitpkgv.bbclass. is *that* documented anywhere? i
> don't see a single mention of the phrase "gitpkgv" in any of the
> current yocto docs.

Generally the Yocto Project manuals confine themselves to the things that the 
Yocto Project contributes to, and meta-oe isn't one of those things (at least, 
not directly or on a regular basis). So we wouldn't document gitpkgv.bbclass 
there. FWIW, people have asked for that class to be moved to OE-Core but 
Richard would prefer to implement it properly as an extension to the fetcher; 
we still have an enhancement bug open for that if anyone wants to dig into it:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=2872

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

