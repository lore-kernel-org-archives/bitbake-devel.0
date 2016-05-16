Return-Path: <paul.eggleton@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 657D177038
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 21:02:55 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 16 May 2016 14:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,627,1459839600"; d="scan'208";a="968201420"
Received: from ardiaz-mobl3.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.174.156])
	by fmsmga001.fm.intel.com with ESMTP; 16 May 2016 14:02:53 -0700
From: Paul Eggleton <paul.eggleton@intel.com>
To: Christopher Larson <chris_larson@mentor.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 17 May 2016 09:02:50 +1200
Message-ID: <3915127.LqeJ5PDHqX@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.4.9-300.fc23.x86_64; KDE/4.14.18; x86_64; ;
	)
In-Reply-To: <CABcZANkgjQRgahkKd+GoLw4h-8dXs=b9+sVTPHn0Ep3ZFTQw3A@mail.gmail.com>
References: <cover.1462041562.git.chris_larson@mentor.com>
	<1463095254.9746.61.camel@linuxfoundation.org>
	<CABcZANkgjQRgahkKd+GoLw4h-8dXs=b9+sVTPHn0Ep3ZFTQw3A@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC master][PATCH 4/4] bitbake-layers: convert to plugin-based
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
X-List-Received-Date: Mon, 16 May 2016 21:02:56 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thu, 12 May 2016 16:22:15 Christopher Larson wrote:
> On Thu, May 12, 2016 at 4:20 PM, Richard Purdie <
> 
> richard.purdie@linuxfoundation.org> wrote:
> > On Thu, 2016-05-12 at 16:12 -0700, Christopher Larson wrote:
> > > On Sat, Apr 30, 2016 at 12:41 PM, Christopher Larson <
> > > 
> > > kergoth@gmail.com> wrote:
> > > > From: Christopher Larson <chris_larson@mentor.com>
> > > > 
> > > > This uses bb.utils.load_plugins, based on the plugin handling in
> > > > recipetool
> > > > and devtool in oe-core.
> > > > 
> > > > Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> > > > ---
> > > > 
> > > >  bin/bitbake-layers                 | 1065 ++----------------------
> > > > 
> > > > ------------
> > > > 
> > > >  bitbake/lib/bblayers/__init__.py   |    2 +
> > > >  bitbake/lib/bblayers/action.py     |  233 ++++++++
> > > >  bitbake/lib/bblayers/common.py     |   33 ++
> > > >  bitbake/lib/bblayers/layerindex.py |  270 +++++++++
> > > >  bitbake/lib/bblayers/query.py      |  499 +++++++++++++++++
> > > >  6 files changed, 1097 insertions(+), 1005 deletions(-)
> > > >  create mode 100644 bitbake/lib/bblayers/__init__.py
> > > >  create mode 100644 bitbake/lib/bblayers/action.py
> > > >  create mode 100644 bitbake/lib/bblayers/common.py
> > > >  create mode 100644 bitbake/lib/bblayers/layerindex.py
> > > >  create mode 100644 bitbake/lib/bblayers/query.py
> > > 
> > > Was this patch not applied for a specific reason, or just needs more
> > > time for review, or waiting until after python3 is merged?
> > 
> > The other pieces were straightforward so I merged them. I meant to ask
> > Paul for an Acked-by on this piece as he'd done more work on the plugin
> > based tools than I have but then I got distracted, sorry. Paul is
> > cc'd...
> 
> Not a problem, just wanted to make sure it didn't slip through the cracks :)

This looks pretty good to me - I like how you've put in a proper object 
structure as well which is nicer than the flat functions used in 
devtool/recipetool plugins.

Acked-by: Paul Eggleton <paul.eggleton@linux.intel.com>

Cheers,
Paul

-- 
Paul Eggleton
Intel Open Source Technology Centre

