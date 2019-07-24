Return-Path: <mac@mcrowe.com>
Received: from avasout06.plus.net (avasout06.plus.net [212.159.14.18])
	by mail.openembedded.org (Postfix) with ESMTP id DA5FA7F10E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Jul 2019 09:11:37 +0000 (UTC)
Received: from deneb ([80.229.24.9]) by smtp with ESMTP
	id qDJ8hhCra7xQfqDJ9hskDL; Wed, 24 Jul 2019 10:11:38 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=OswxNB3t c=1 sm=1 tr=0
	a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
	a=ag1SF4gXAAAA:8 a=7zyUyiLiuM8Hiq0UQ0wA:9 a=CjuIK1q_8ugA:10
	a=Yupwre4RP9_Eg_Bd0iYG:22
Received: from mac by deneb with local (Exim 4.89)
	(envelope-from <mac@mcrowe.com>)
	id 1hqDJ8-0005wd-Cr; Wed, 24 Jul 2019 10:11:34 +0100
Date: Wed, 24 Jul 2019 10:11:34 +0100
From: Mike Crowe <mac@mcrowe.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20190724091134.kqctx32x3daxiwjq@mcrowe.com>
References: <20181217171645.8145-1-richard.purdie@linuxfoundation.org>
	<20190723160909.wdj7fwboiy65kfet@mcrowe.com>
	<00066477-9727-3081-a300-e030ef733333@windriver.com>
	<1e930c00f2f1ef60bda5c7d25d2850d438f3345a.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1e930c00f2f1ef60bda5c7d25d2850d438f3345a.camel@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfNC4XvGTJ2IF5m2OsP2fjBLVHMpr1uv3y1WAJWLZbi/HgFgy/OqtjBqpjTDgTeFJ95AQB4FL6O9N/lqkUAdvfjetUxiEAEmhIjXpEpoPlWsVVotvG+hG
	hULN0s6quFrcRx1HjqbP+hOKGSMs4QS8QK4DSSavuz15FdIADfEeAjbk
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] data/siggen: Switch md5 -> sha256
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
X-List-Received-Date: Wed, 24 Jul 2019 09:11:38 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wednesday 24 July 2019 at 09:11:09 +0100, Richard Purdie wrote:
> On Tue, 2019-07-23 at 11:59 -0500, Mark Hatle wrote:
> > On 7/23/19 11:09 AM, Mike Crowe wrote:
> > > On Monday 17 December 2018 at 17:16:45 +0000, Richard Purdie wrote:
> > > > Similarly to the codeparser change, change to sha256 hashes due
> > > > to worries
> > > > over collisions. The main impact of this change is slightly
> > > > slower parsing
> > > > time as well as longer sstate file names.
> > > > 
> > > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org
> > > > >
> > > 
> > > This change has given us several sstate cache filenames that exceed
> > > the 255
> > > character limit of ext4. :(
> > 
> > I wonder if another approach might be easier.  Instead use change the
> > filename
> > to be:
> > 
> > sstate:<sstate_version>:<hash>:recipe:version:...:task.<type>
> > 
> > (<type> such as .tgz.signifo)
> > 
> > If the filename becomes too long, simply truncate the middle section)
> > preserving:
> > 
> > sstate:<state_version>:<hash> and <type>

We make use of the recipe name in our sstate cache pruning script, since
some recipes have more churn and we expire them more quickly. That
shouldn't be a problem as long as the recipe name is kept in preference to
the version.

> > So the same truncation when matching, and it should be safe.  The
> > recipe,
> > version ... task bit is nice to have for a human reader, but I don't
> > think it's
> > actually needed by the system itself.
> > 
> > This should avoid any collisions and keep the maximum information
> > that will fit
> > in the filename(s).
> 
> In some ways regardless of what we do, we need to abstract it so that
> we have one function generating the filenames.
>
> So yes, think we need a patch which abstracts the filename generation.
> It needs to be able to truncate elements of the constructed name other
> than the hash. I do prefer truncating the other elements than changing
> the hash.

If we're going to keep the 64-character SHA-256 hash and instead elide
parts of the sstate filenames, then I think only sstate.bbclass needs to
change, so this isn't a Bitbake issue and we should probably move this
thread it openembedded-core.

Or perhaps I'm misunderstanding your suggestion.

Thanks.

Mike.

