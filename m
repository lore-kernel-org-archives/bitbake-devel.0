Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 5D79E72EA5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jul 2018 07:03:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	18 Jul 2018 00:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,369,1526367600"; d="scan'208";a="73297872"
Received: from yanbeibe-mobl2.ger.corp.intel.com (HELO localhost.localdomain)
	([10.249.33.35])
	by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2018 00:03:11 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Wed, 18 Jul 2018 09:03:10 +0200
Message-ID: <9175757.rJd2U26s3Q@localhost.localdomain>
Organization: Intel Corporation
In-Reply-To: <0caa3638-b5fa-d18a-1776-2ca510f18173@windriver.com>
References: <20180712203413.118578-1-mark.hatle@windriver.com>
	<2844607.YnhVh9u1Q8@localhost.localdomain>
	<0caa3638-b5fa-d18a-1776-2ca510f18173@windriver.com>
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
X-List-Received-Date: Wed, 18 Jul 2018 07:03:11 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 17 July 2018 10:56:14 PM CEST Mark Hatle wrote:
> > 2) I feel like the ;type= stuff is an unnecessary complication. Can we not 
> > just treat http URLs as being restapi and local:// (or something similarly 
> > simple) as being the local configuration? The plugins could simply have a 
> > function that returns True if it can handle the URL, as we do in bb.fetch2, 
> > and we take the first one that returns True or error out if none do.
> 
> Behind the scenes the issue is that I expect there to be different plugins that
> allow data manipulation in similar ways, but with different processing.  I was
> afraid of overriding the URI part, thus added the type field instead.
> 
> If we can come up with a proper format for this, then I think we could drop the
> typing..  but what I've come up with so far is that we need:
> 
> Cooker - data from the local cooker instance

local:// ?

> restapi-web - knowledge of how to load and parse layerindex-web data

http:// or https:// surely?

> restapi-file - a json formatted file with all of the data.. (Note: in this case,
> it can be one or more files, but everything has to be loaded together)

file:// ?

If the desire was to also allow downloading json files over http/https you could make
the decision after a quick query or simply check if the URL ends in .json.

> (the web and file stuff are co-mingled right now, maybe that is a mistake...
> they were put together since for 'offline' work, the web should be able to use a
> cached file...)
> 
> Looking at toaster, I could see the need for a 'database' way to store and load
> it... but I'm not sure that is a good longer term idea.

Toaster uses the Django ORM to access the database, so you wouldn't be
connecting to the database directly; you could make it accessible via a simple
scheme such as toaster://.

> > 5) I'd like to see the data classes (e.g. Recipe) have actual python 
> > properties on top of the getter functions, and the rest of the code should 
> > then use the properties. recipe.pn is a bit neater than recipe.get_pn() 
> > particularly as the former mirrors usage within the layer index code itself as 
> > well as tinfoil's TinfoilRecipeInfo (although TinfoilRecipeInfo doesn't 
> > actually use properties - it probably should - but the usage syntax is the key 
> > bit).
> 
> I'm not sure I understand.
> 
> You mean something like:
> 
> class Recipe(LayerIndexItem_LayerBranch):
>     ...
> 
>     self.pn = value
> 
> so you can do recipe.pn vs recipe.pn() or get_pn()?
> 
> The reason it's setup the way it is, is to preserve the data in the same format
> as the layerindex itself.  This allows someone to just dump the recipe.data
> directly, and everything stays in format.   Does python have a way to return
> processed data without it looking like a function call, i.e. with the ()?
> 
> Is this what __getattr()__ is for?

It's one way of implementing it, but the much cleaner way is to use python's 
built-in support for properties:

  https://www.programiz.com/python-programming/property

The underlying data storage doesn't have to change, your getter function can
still read the values in whatever way it wants to.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre



