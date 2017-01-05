Return-Path: <jianxun.zhang@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 9812B719DD
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Jan 2017 00:08:08 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 04 Jan 2017 16:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,318,1477983600"; d="scan'208";a="805221403"
Received: from jzhang80-mac02.jf.intel.com ([10.24.9.27])
	by FMSMGA003.fm.intel.com with ESMTP; 04 Jan 2017 16:08:09 -0800
From: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Message-Id: <66F32A08-7152-4857-9F08-D031AEB9DFD7@linux.intel.com>
Date: Wed, 4 Jan 2017 16:08:08 -0800
To: bitbake-devel@lists.openembedded.org
X-Mailer: Apple Mail (2.3259)
Subject: Error message: "The metadata is not deterministic and this needs to be fixed"
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
X-List-Received-Date: Thu, 05 Jan 2017 00:08:09 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi RP and others,

I eventually triggered this issue when debugging another bug. I =
replace/override/append a single variable many times in the same =
local.conf, and do the incremental build every time. I also changed =
recipes and bbclasses for my need but no any hack in sstate or BB cache. =
It happened only once and disappeared with more tests.

https://patchwork.openembedded.org/patch/133517/ should be the original =
patch to add this check.

Does this error indicate BB user did something wrong and should fix it, =
or it is an internal error of BB? Will the build and caches be still =
stable and work correctly after it?

Thanks lot!



