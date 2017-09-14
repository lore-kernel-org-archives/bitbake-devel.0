Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A36E47808C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Sep 2017 04:09:37 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	13 Sep 2017 21:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,390,1500966000"; d="scan'208";a="151125213"
Received: from babarret-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.71.243])
	by fmsmga005.fm.intel.com with ESMTP; 13 Sep 2017 21:09:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Sep 2017 16:09:32 +1200
Message-ID: <3240010.hbT8r0A6eI@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <2875168.fmGed5MLc7@peggleto-mobl.ger.corp.intel.com>
References: <cover.1505210965.git.paul.eggleton@linux.intel.com>
	<1505212896.18640.17.camel@linuxfoundation.org>
	<2875168.fmGed5MLc7@peggleto-mobl.ger.corp.intel.com>
MIME-Version: 1.0
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
X-List-Received-Date: Thu, 14 Sep 2017 04:09:37 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 12 September 2017 11:05:50 PM NZST Paul Eggleton wrote:
> On Tuesday, 12 September 2017 10:41:36 PM NZST Richard Purdie wrote:
> > On Tue, 2017-09-12 at 22:10 +1200, Paul Eggleton wrote:
> > > If we make a change to the metadata within a tinfoil-using script
> > > and then attempt to run tasks using build_targets(), the change won't
> > > get noticed. Add an explicit command that will set the internal flag
> > > to
> > > force reloading the cache and thus pick up the changes. This will be
> > > used in OE by the devtool source extraction rework.
> > > 
> > > Part of the fix for [YOCTO #11198].
> > > 
> > > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> > > ---
> > >  lib/bb/command.py | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> > Just a quick sanity check. Why won't the change get noticed? Any file
> > writes should be seen by the inotify code which would invalidate the
> > cache? This could mean we're not watching some dependency we should be?
> > or is it that the commands aren't triggering a reparse due to ordering
> > somehow? I'd like to understand this more before we add this...
> 
> That's a good question, and you may well be right. I can look into it more 
> closely.

You were right - disregard this patch, I'm about to send a new series with a 
proper fix.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

