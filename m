Return-Path: <mac@mcrowe.com>
X-Greylist: delayed 452 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 23 Jul 2019 16:16:42 UTC
Received: from avasout02.plus.net (avasout02.plus.net [212.159.14.17])
	by mail.openembedded.org (Postfix) with ESMTP id 219367E3B6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Jul 2019 16:16:41 +0000 (UTC)
Received: from deneb ([80.229.24.9]) by smtp with ESMTP
	id pxLhh1D3u6ogspxLih0sf4; Tue, 23 Jul 2019 17:09:11 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Y62GTSWN c=1 sm=1 tr=0
	a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
	a=ag1SF4gXAAAA:8 a=lM-wK-mRKnXLi4ZkNkYA:9 a=CjuIK1q_8ugA:10
	a=Yupwre4RP9_Eg_Bd0iYG:22
Received: from mac by deneb with local (Exim 4.89)
	(envelope-from <mac@mcrowe.com>) id 1hpxLh-0007EF-J8
	for bitbake-devel@lists.openembedded.org;
	Tue, 23 Jul 2019 17:09:09 +0100
Date: Tue, 23 Jul 2019 17:09:09 +0100
From: Mike Crowe <mac@mcrowe.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20190723160909.wdj7fwboiy65kfet@mcrowe.com>
References: <20181217171645.8145-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <20181217171645.8145-1-richard.purdie@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfCBBxbHB6lKrOS5n/ApG++lwpJWmY56NiEpTZE45X/3T2GRRTizfyp7Op/nNbidywOOaK4KDu9WMiiqJM/DObc8KNP+gN+BCsVPn4kjVfQzdCAPQEq2M
	Es0ADrD07EHqv+v5YNzFoI6bZyj2P7OojqJ4hSc2xrw/MBVH3RHe7Fp9
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
X-List-Received-Date: Tue, 23 Jul 2019 16:16:42 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Monday 17 December 2018 at 17:16:45 +0000, Richard Purdie wrote:
> Similarly to the codeparser change, change to sha256 hashes due to worries
> over collisions. The main impact of this change is slightly slower parsing
> time as well as longer sstate file names.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

This change has given us several sstate cache filenames that exceed the 255
character limit of ext4. :(

We have a recipe that constructs a source tree from three separate Git
repositories, so we end up with a PV that is 93 characters long, which
doesn't help.

I've found that using urlsafe_b64encode to shorten the SHA-256 hashes
reduces the filename lengths by 21 characters, which is more than the 14
characters we need to save. However, there's a risk of collisions if the
cache is stored on a case-insensitive filesystem.

Would you be amenable to a patch to use urlsafe_b64encode?

If not, would you be amenable to a patch that consolidated the algorithm
into a single function called from the places you changed so that we can
patch it locally more easily? Or perhaps there's another way to make it
configurable?

Thanks.

Mike.

