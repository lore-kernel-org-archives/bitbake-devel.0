Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 2962665C97
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 10:59:36 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga102.fm.intel.com with ESMTP; 09 Feb 2015 02:59:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,543,1418112000"; d="scan'208";a="683029567"
Received: from jjloney-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.17.98])
	by orsmga002.jf.intel.com with ESMTP; 09 Feb 2015 02:59:37 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Chong Lu <Chong.Lu@windriver.com>
Date: Mon, 09 Feb 2015 10:59:36 +0000
Message-ID: <6415898.9ppt7FNBcc@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.4 (Linux/3.17.8-200.fc20.x86_64; KDE/4.14.4; x86_64; ; )
In-Reply-To: <1728669.U1IcW4V3Z6@peggleto-mobl5.ger.corp.intel.com>
References: <cover.1421990461.git.Chong.Lu@windriver.com>
	<1584081.qrVQXzTzW7@peggleto-mobl5.ger.corp.intel.com>
	<1728669.U1IcW4V3Z6@peggleto-mobl5.ger.corp.intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH V3 0/2] bitbake-layers: add a ability to query layer dependencies from layer index
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
X-List-Received-Date: Mon, 09 Feb 2015 10:59:40 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 03 February 2015 10:12:19 Paul Eggleton wrote:
> On Monday 02 February 2015 16:05:52 Paul Eggleton wrote:
> > Hi Chong,
> > 
> > On Friday 23 January 2015 13:28:32 Chong Lu wrote:
> > > Change since V2:
> > > re-split for IPv6 URL parsing
> > > 
> > > The following changes since commit
> 
> 35c9fa0588ed8e88b541a6c80cc1517324616cea:
> > >   maintainers: Update for non-maintained recipes (2015-01-20 21:39:41
> > >   +0000)
> > > 
> > > are available in the git repository at:
> > >   git://git.pokylinux.org/poky-contrib chonglu/layerindex
> > >   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=chonglu/layerind
> > >   ex
> > > 
> > > Chong Lu (2):
> > >   bitbake.conf: Add two variables for layer index
> > >   bitbake-layers: add a ability to query layer dependencies from layer
> > >   index
> > 
> > Apologies for the delay in getting back to you. This is definitely
> > improving, some feedback though:
> > 
> > * I think the new subcommand would make more sense if it were switched
> > around so that it was fetching by default (and renamed as appropriate).
> > Perhaps "layerindex-fetch" (with -n to avoid fetching and just report what
> > it would fetch).
> > 
> > * I think the layer index URL specified in the OE variable should be to
> > the
> > root rather than to /api - instead have that suffix added by the code that
> > does the API calls. This makes it usable as a URL for the index for
> > presenting to the user if needed.
> > 
> > * Can you rename the two variables to BBLAYERS_LAYERINDEX_URL and
> > BBLAYERS_FETCH_DIR (sorry I didn't think of this earlier).
> > 
> > * Please mention bitbake-layers in the comment above the settings in
> > bitbake.conf so it's clear where these variables are used.
> > 
> > * By using -q with git you lose the status output which can be very useful
> > given how long it can take to fetch some layers e.g. meta-oe, so can you
> > drop this?
> > 
> > * Can you add a check to see if the layer has already been fetched before
> > fetching it and skip the fetch if it does (but not skip the add)?
> > 
> > * If I run "bitbake-layers show-layer-deps meta-security" I get an error:
> > ERROR: Can NOT get meta-security git repo and subdir
> > (The code currently expects there to be a subdir, but this is an optional
> > field, not all layers have a subdirectory, meta-security is one example.)
> > 
> > * I think you may be able to get away with skipping the initial parse by
> > passing config_only=True to init_bbhandler(). If you can, this will save a
> > bit of time each time you run the command.
> 
> I just noticed another issue - dependencies-of-dependencies aren't handled
> here either; e.g. meta-security's dependencies have just been updated so
> that it now depends on meta-networking, and meta-networking depends on
> meta-python but that's not listed when I run bitbake-layers show-layer-deps
> meta-security. I think maybe this is a deficiency in the layer index API -
> it would be faster if there was one call we could make to get the entire
> list of dependencies, URLs and subdirectories for the entire dependency
> chain.
> 
> I know this is probably further than you expected to go with this bug, but
> is that API enhancement something you could look into adding?

Yet another concern - we need to deal with layer branches properly, i.e. we 
can't just assume master or otherwise people using stable branches will have 
compatibility issues. In many cases we won't be able to rely upon the OE-
Core/poky branch being the matching name either, so it might have to be 
something we require the user to specify on the command line.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

