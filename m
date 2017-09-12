Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id B3BAC77811
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Sep 2017 11:05:55 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga105.jf.intel.com with ESMTP; 12 Sep 2017 04:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,382,1500966000"; d="scan'208";a="1194179531"
Received: from nrahulx-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.73.25])
	by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2017 04:05:53 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 12 Sep 2017 23:05:50 +1200
Message-ID: <2875168.fmGed5MLc7@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <1505212896.18640.17.camel@linuxfoundation.org>
References: <cover.1505210965.git.paul.eggleton@linux.intel.com>
	<2d7f1ec85c8242b1348597e7963b962efe562070.1505210965.git.paul.eggleton@linux.intel.com>
	<1505212896.18640.17.camel@linuxfoundation.org>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] command: Add command to invalidate parse cache
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
X-List-Received-Date: Tue, 12 Sep 2017 11:05:55 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 12 September 2017 10:41:36 PM NZST Richard Purdie wrote:
> On Tue, 2017-09-12 at 22:10 +1200, Paul Eggleton wrote:
> > If we make a change to the metadata within a tinfoil-using script
> > and then attempt to run tasks using build_targets(), the change won't
> > get noticed. Add an explicit command that will set the internal flag
> > to
> > force reloading the cache and thus pick up the changes. This will be
> > used in OE by the devtool source extraction rework.
> > 
> > Part of the fix for [YOCTO #11198].
> > 
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> > ---
> >  lib/bb/command.py | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Just a quick sanity check. Why won't the change get noticed? Any file
> writes should be seen by the inotify code which would invalidate the
> cache? This could mean we're not watching some dependency we should be?
> or is it that the commands aren't triggering a reparse due to ordering
> somehow? I'd like to understand this more before we add this...

That's a good question, and you may well be right. I can look into it more 
closely.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

