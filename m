Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by mail.openembedded.org (Postfix) with ESMTP id B47797F880
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Oct 2019 20:12:06 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Oct 2019 13:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; d="scan'208";a="209989688"
Received: from zhou1-mobl1.amr.corp.intel.com (HELO shodan.localnet)
	([10.249.66.86])
	by fmsmga001.fm.intel.com with ESMTP; 23 Oct 2019 13:12:04 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>,
	Jean-marie Lemetayer <jean-marie.lemetayer@savoirfairelinux.com>
Date: Thu, 24 Oct 2019 09:12:02 +1300
Message-ID: <2251883.mhDZDQ7Q5s@shodan>
Organization: Intel Corporation
In-Reply-To: <ead7c39d-6ac4-a469-b190-90f259433595@kernel.crashing.org>
References: <20191022090408.1368-1-jean-marie.lemetayer@savoirfairelinux.com>
	<1859460807.248980.1571836088029.JavaMail.zimbra@savoirfairelinux.com>
	<ead7c39d-6ac4-a469-b190-90f259433595@kernel.crashing.org>
MIME-Version: 1.0
Cc: Savoir-faire Linux Rennes <rennes@savoirfairelinux.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [RFC][PATCH 2/2] fetch2/npm.py: refactor the npm fetcher
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
X-List-Received-Date: Wed, 23 Oct 2019 20:12:06 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 24 October 2019 3:27:11 AM NZDT Mark Hatle wrote:
> On 10/23/19 8:08 AM, Jean-marie Lemetayer wrote:
> > Thank you again. The former npm support does not have any tests so I did not
> > think about it. I will add some basic tests in the v2.
> 
> If you need some pointers on where and how to write the tests, please let me
> know.  I've had to write a number of them for the gitsm fetcher.
> 
> Hint: https://git.openembedded.org/bitbake/tree/lib/bb/tests/fetch.py
> 
> Stuff I added is mostly found by looking for 'test_git_submodule...'
> 
> I'd expect we need a new test_npm_.... series.

Right, but if the functionality now relies on code in OE, then to fully test it you'd need to add oe-selftest tests in OE as well.

Cheers,
Paul


-- 

Paul Eggleton
Intel System Software Products



