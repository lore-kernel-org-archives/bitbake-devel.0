Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 660CD789A5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2018 20:37:55 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Jul 2018 13:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; d="scan'208";a="55753434"
Received: from bartoszb-mobl.ger.corp.intel.com (HELO localhost.localdomain)
	([10.249.32.52])
	by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2018 13:37:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Tue, 17 Jul 2018 22:37:50 +0200
Message-ID: <2844607.YnhVh9u1Q8@localhost.localdomain>
Organization: Intel Corporation
In-Reply-To: <cdb1b25d-9448-a43c-d345-7af3a5674a58@windriver.com>
References: <20180712203413.118578-1-mark.hatle@windriver.com>
	<cdb1b25d-9448-a43c-d345-7af3a5674a58@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Add a standard module for accessing the layerindex
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
X-List-Received-Date: Tue, 17 Jul 2018 20:37:55 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Mark

On Thursday, 12 July 2018 11:07:06 PM CEST Mark Hatle wrote:
> On 7/12/18 3:34 PM, Mark Hatle wrote:
> > In order to simply existing components, and add support to create some
> > new functionaly -- we need a common apporach for access the layerindex.
> > 
> > The class supports loading multilib layerindexes, but right now that
> > functionality is not being used by either bitbake-layers or the toaster.
> > 
> > There are a few 'TODO' items that remain in the code.  These are related
> > to either un-implemented, but planned functionality or to display stuff
> > in bitbake-layers.  I'm hoping that part of this review can discuss the
> > TODO items.

This looks good, thanks - great to start to have a client API that we can use 
in a bunch of different places. Some comments:

1) LAYERSERIES_CORENAMES is treated by bitbake as a list. At the moment it's 
just one item, but we should treat it the same here - for now we can probably 
take the easiest way out and just split it and take the first item.

2) I feel like the ;type= stuff is an unnecessary complication. Can we not 
just treat http URLs as being restapi and local:// (or something similarly 
simple) as being the local configuration? The plugins could simply have a 
function that returns True if it can handle the URL, as we do in bb.fetch2, 
and we take the first one that returns True or error out if none do.

3) "except Exception" is too broad, can we catch a specific exception class or 
classes instead?

4) From an API perspective, it seems to me that we should be taking lists 
everywhere rather than space-delimited strings e.g. in get_dependencies() for 
the names parameter, particularly given the other parameters are actual lists.

5) I'd like to see the data classes (e.g. Recipe) have actual python 
properties on top of the getter functions, and the rest of the code should 
then use the properties. recipe.pn is a bit neater than recipe.get_pn() 
particularly as the former mirrors usage within the layer index code itself as 
well as tinfoil's TinfoilRecipeInfo (although TinfoilRecipeInfo doesn't 
actually use properties - it probably should - but the usage syntax is the key 
bit).

6) There are a number of different instances of variables "lindex" and they 
are different types. There's even "for lindex in self.lindex". This is a bit 
confusing.

7) What's loadRecipes = 1 for above load_layerindex() ?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre



