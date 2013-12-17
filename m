Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 24E2260CF6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Dec 2013 20:31:36 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 17 Dec 2013 12:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,503,1384329600"; d="scan'208";a="445886407"
Received: from unknown (HELO helios.localnet) ([10.252.122.29])
	by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2013 12:31:34 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Brad Litterell <brad@evidence.com>
Date: Tue, 17 Dec 2013 20:31:33 +0000
Message-ID: <1688455.phEaOq5Cul@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-34-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <E51394554A503C4E852F9BEE46B03E8D019AC817@TI-THOR.tasernet.com>
References: <E51394554A503C4E852F9BEE46B03E8D019AC817@TI-THOR.tasernet.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Developing in Python for Bitbake
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
X-List-Received-Date: Tue, 17 Dec 2013 20:31:37 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Brad,

On Tuesday 17 December 2013 20:11:18 Brad Litterell wrote:
> I want to create a new bbclass for some internal build tooling and am fairly
> new to Python, so I have a couple of (hopefully quick) questions:
> 
> 1. Can you recommend an Python IDE for developing for bitbake on Linux? 
> There seem to be several, and if there is a consensus among the bitbake
> developers, I thought I'd start there.

I expect most people who work on BitBake don't use an IDE - just a text 
editor, and we probably all use different ones. I myself mostly use Kate (from 
KDE) which does provide syntax highlighting and completion though; at the 
command line I also use vi.

> 2. Is there a list of pre-defined variables?  For example, gitpkgv.bbclass
> starts with def get_git_pkgv(d, use_tags):

There's no reference for this level of things other than the code, I'm afraid, 
but we're more than happy to answer questions if you have any.

> "d" appears to be frequently assumed.  I'm guessing it is the same as the
> "D" variable in the recipes, but I am not sure whether there is a document
> that verifies this - and what else is available, or whether it is just
> tribal knowledge?

d is the data dictionary, as defined in bitbake/lib/bb/data_smart.py. d is not 
related to the "D" variable in OpenEmbedded (although just as with any other 
variable you can of course use d.getVar('D', True) to access it).

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

