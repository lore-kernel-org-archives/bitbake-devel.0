Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 411EE71999
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Feb 2017 20:08:54 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 06 Feb 2017 12:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,342,1477983600"; d="scan'208";a="222023471"
Received: from mmurr6x-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.252.199.82])
	by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2017 12:08:54 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Feb 2017 09:08:48 +1300
Message-Id: <cover.1486411669.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/3] OE eSDK related fixes
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
X-List-Received-Date: Mon, 06 Feb 2017 20:08:55 -0000

One fix directly relating to the extensible SDK in OE and two for the
npm fetcher.


The following changes since commit 2a309cd20cddf3d2258bd00ad06b26452e6cc043:

  bitbake: Bump version to 1.33.0 (develoment version) (2017-01-27 10:40:53 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-esdk-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-esdk-fixes

Paul Eggleton (3):
  lib/bb/build: add tasksbetween() function
  fetch2/npm: handle items only in optionalDependencies
  fetch2/npm: fix handling of os field

 lib/bb/build.py      | 27 +++++++++++++++++++++++++++
 lib/bb/fetch2/npm.py |  8 +++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.9.3


