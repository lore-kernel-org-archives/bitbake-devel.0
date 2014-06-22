Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 55D356FC0D
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Jun 2014 12:55:54 +0000 (UTC)
Received: from [99.240.204.5] (port=60400 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WyhJK-0004Gx-Bi for bitbake-devel@lists.openembedded.org;
	Sun, 22 Jun 2014 08:55:54 -0400
Date: Sun, 22 Jun 2014 08:52:08 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406220832520.1583@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: can someone explain "git" versus "gitr" wrt PREFERRED_VERSION?
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
X-List-Received-Date: Sun, 22 Jun 2014 12:55:57 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  possibly a stupid question but i've never let that stop me before.
still rummaging around in the bitbake user manual and looking through
the oe and poky codebase, and i notice examples like this (from poky).

  first, there's the recipe and PREFERRED_VERSION for drm:

meta/recipes-graphics/drm/libdrm_git.bb:
  SRCREV = "e01d68f9f3acfc35fe164283904b5d058c2ab378"
  PV = "2.4.40+git${SRCPV}"

meta-yocto/conf/distro/include/poky-floating-revisions.inc:
  #PREFERRED_VERSION_libdrm ?= "2.4.0+git${SRCREV}"

  also, the recipe and PFEFERRED_VERSION for libxcb:

meta/recipes-graphics/xorg-lib/libxcb_git.bb:
  SRCREV = "625ed596cae6dd8175aeb6cb6f26784928042f22"
  PV = "1.1.90.1+gitr${SRCPV}"

meta-yocto/conf/distro/include/poky-floating-revisions.inc:
  #PREFERRED_VERSION_libxcb ?= "1.1.90.1+gitr${SRCREV}"


  admittedly, the PREFERRED_VERSION settings for both of those are
commented out, but why does the first use:

  git${SRCREV}

while the second uses:

  gitr${SRCREV}

so what's with "git" versus "gitr"? i see no mention of this in the
bitbake user manual (would that be the right place to explain that?).
or is that covered in one of the higher-level yocto manuals?

  also (and i realize this is outside the scope of the bitbake
manual), i noticed the meta-oe layer adds another git-based version
selector in the gitpkgv.bbclass. is *that* documented anywhere? i
don't see a single mention of the phrase "gitpkgv" in any of the
current yocto docs.

  thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

