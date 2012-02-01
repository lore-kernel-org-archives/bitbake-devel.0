Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>)
	id 1RscN8-0004le-Ep; Wed, 01 Feb 2012 16:45:22 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 01 Feb 2012 07:37:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="101992480"
Received: from unknown (HELO helios.localnet) ([10.252.122.196])
	by azsmga001.ch.intel.com with ESMTP; 01 Feb 2012 07:37:09 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 01 Feb 2012 15:37:08 +0000
Message-ID: <2370505.PRl1Ey1z8e@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-15-generic-pae; KDE/4.8.0; i686; ; )
In-Reply-To: <4F26B9D3.9010709@gmail.com>
References: <4F26B9D3.9010709@gmail.com>
MIME-Version: 1.0
Cc: openembedded-devel@lists.openembedded.org, Aleh Arol <aleh.arol@gmail.com>
Subject: Re: source folder package dependency
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
X-List-Received-Date: Wed, 01 Feb 2012 15:45:22 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 30 January 2012 18:40:03 Aleh Arol wrote:
> I have a question I don't know how to solve:
> I have a library, for example, boost, and a part of that
> library(packaged together I mean), like bjam is required to build it.
> 
> So I have boost-X.Y.Z.bb recipe and src/boost-X.Y.Z folder(I have
> sources locally) and I need to create bjam recipe. I can make
> bjam-X.Y.Z.bb where I will refer to folder src/boost-${PV} as ${SRC_URI}
> and ${S} to find jam sources under. Then if I'll need to have 5
> different versions of boost I'll need to create 5 different versions of
> bjam recipe.... although I can use bjam.inc it will still be 5 bjam recipes.
> 
> How can I avoid that? Any way to have a version agnostic bjam recipe? Or the
> right way of doing this.

(I presume this is in the context of OpenEmbedded.) What you describe is the 
accepted way of doing things - you have a recipe for each version of the piece 
of software you're building and share the common things with a .inc file, using 
${PV} to abstract away the version. Each individual recipe ends up quite small 
with the bulk of the definitions in the inc file.

You could have a recipe which did not specify a version in the recipe filename, 
and set PV manually instead (possibly with a default); then you could set 
PV_pn-bjam = "1.1" in your distro or local configuration to pick the version. 
However I would describe that as unorthodox, and it will not work if you have 
to handle other differences between versions (e.g. renamed/moved files, 
additional configuration options, etc.) I will say however that this is more or 
less how we handle recipes built from a version control system (e.g. git); 
except in that case we set PV to something including SRCREV e.g. 
"1.0+gitr${SRCPV}" and then set SRCREV externally.

The question is will you really need 5 different versions? Or just 2-3?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


