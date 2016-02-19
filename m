Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 549057722D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Feb 2016 14:36:30 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 19 Feb 2016 06:36:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,470,1449561600"; d="scan'208";a="919363994"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2016 06:36:29 -0800
Message-ID: <1455892588.2298.12.camel@linux.intel.com>
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: Richard Purdie <richard.purdie@intel.com>
Date: Fri, 19 Feb 2016 16:36:28 +0200
In-Reply-To: <1455892476.2298.11.camel@linux.intel.com>
References: <1455892476.2298.11.camel@linux.intel.com>
X-Mailer: Evolution 3.16.5 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC] file checksum cache refactoring
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
X-List-Received-Date: Fri, 19 Feb 2016 14:36:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2016-02-19 at 16:34 +0200, Markus Lehtonen wrote:
> Hi,
> 
> I pushed a patchset for inspection here:
> http://git.openembedded.org/openembedded-core-contrib/log/?h=marquiz/
> bi
> tbake/checksum-refactor
> 
> The first three patches are refactoring that could be merged without
> breaking anything, the last patch extending the SignatureGenerator
> API.
> 
> The two last patches are something that could be merged at some later
> point as they make the new API mandatory.
> 
> Any comments and suggestions are welcome.
> 
> 
> Cheers,
>   Markus
> 
> ----------------------------------------------------------------
> Markus Lehtonen (5):
>       bb/siggen: drop commented-out code
>       Move file checksum cache out of SignatureGenerator
>       SignatureGenerator: add checksum_cache argument to
> get_taskhash()
>       SignatureGenerator: make checksum_cache arg of get_taskhash()
> mandatory
>       bb/fetch2: drop checksum cache
> 
>  lib/bb/cooker.py          |  2 --
>  lib/bb/fetch2/__init__.py | 18 ------------------
>  lib/bb/runqueue.py        | 13 +++++++++++--
>  lib/bb/siggen.py          | 29 +++--------------------------
>  4 files changed, 14 insertions(+), 48 deletions(-)


Oh, and a corresponding change to oe-core to conform the new api is
here:
http://git.openembedded.org/openembedded-core-contrib/commit/?h=marquiz
/siggen&id=bfd119c829dac952ced358701d8b2fea7c292617


Cheers,
  Markus

