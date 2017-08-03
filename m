Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 10C6D71ABC
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Aug 2017 18:05:50 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Aug 2017 11:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,317,1498546800"; d="scan'208";a="886100206"
Received: from valeriof-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.52.220])
	by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2017 11:05:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Thu, 03 Aug 2017 20:05:49 +0200
Message-ID: <187725705.SbhF8WDyxe@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <1501256242-37784-2-git-send-email-mark.hatle@windriver.com>
References: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
	<1501256242-37784-2-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, toaster@yoctoproject.org
Subject: Re: [PATCH 1/5] lib/layers: Initial layer and layer index implementeation
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
X-List-Received-Date: Thu, 03 Aug 2017 18:05:51 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 28 July 2017 5:37:18 PM CEST Mark Hatle wrote:
> This module provides two components, layerindex, which is used to talk a
> layerindex, such as layers.openembedded.org.
> 
> The other module is the 'manager'.  This module will handle downloading,
> re-writing the bblayers to match the downloads and other related layer
> management tasks.

It's great to have a solid internal API for interacting with the layer index 
to replace the less than optimal earlier implementation in bitbake-layers - 
thanks for sorting this out. The only comments I'd make:

1) Can you rename the fetch2 plugin to something like bbfetch or bitbakefetch 
or something like that. I'd rather we didn't proliferate the fetch2 name any 
further - IIRC Richard has talked about renaming the module back to fetch at 
some point.

2) cooker.py has a "## TODO NOT IMPLEMENTED" comment that if still valid needs 
to be expanded upon - what's actually missing? There's also a moderate size 
block of commented-out code just below that, since this is new can we drop 
that if it's genuinely not needed?

3) Can we have a default type for layerindex URLs of "restapi" so we don't 
need to specify this everywhere in the common case? This would also mean we 
wouldn't have to change DEFAULT_LAYERINDEX_SERVER in the toaster code.

4) The "layers" naming of the module under lib is a little confusing given 
that we already have a bblayers module under lib/, and one might incorrectly 
assume that this was used for all layer handling. I don't actually yet have a 
naming scheme / structure I like better though :(

5) "OR" to split the branches is a very awkward. Can we use , (comma) instead?

6) I'm not massively thrilled at duplicating the layer index data structures 
in bitbake. It does make things easier on the bitbake side, and the 
alternative of making use of the original django models in bitbake isn't 
practical, but it's just a bit unfortunate in terms of future maintenance. 
Having said that we made the same choice in Toaster, and the layer index 
models don't change that often. (I guess I'm just highlighting this so we know 
what we're getting into.)

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

