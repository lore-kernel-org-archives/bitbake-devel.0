Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 2499B6010D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Nov 2015 03:02:32 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 19 Nov 2015 19:02:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,320,1444719600"; d="scan'208";a="824669689"
Received: from ywong15-mobl2.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.131.114])
	by orsmga001.jf.intel.com with ESMTP; 19 Nov 2015 19:02:31 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Nov 2015 16:02:29 +1300
Message-ID: <3038095.nrVbffWaep@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.1.12-101.fc21.x86_64; KDE/4.14.11; x86_64; ;
	)
In-Reply-To: <43f5af1bb1f482e3e6492002b227fe063b5952f7.1447984320.git.paul.eggleton@linux.intel.com>
References: <cover.1447984320.git.paul.eggleton@linux.intel.com>
	<43f5af1bb1f482e3e6492002b227fe063b5952f7.1447984320.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] lib/bb/utils: improve edit_bblayers_conf() handling of bblayers.conf formatting
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
X-List-Received-Date: Fri, 20 Nov 2015 03:02:33 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 20 November 2015 14:52:30 Paul Eggleton wrote:
> Make the following improvements to edit_bblayers_conf():
> 
> * Support ~ in BBLAYERS entries
> * Handle where BBLAYERS items are added over multiple lines with +=
>   instead of one single long item
> 
> Also add some comments documenting the function arguments and return
> values as well as a set of bitbake-selftest tests.
> 
> (This function is used by the bitbake-layers add, remove and
> layerindex-fetch subcommands, as well as devtool when adding the
> workspace layer).

Turns out this broke devtool; hold off for v2.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

