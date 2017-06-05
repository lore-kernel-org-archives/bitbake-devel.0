Return-Path: <rebecca.swee.fun.chang@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 2131B776F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Jun 2017 08:43:32 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Jun 2017 01:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,300,1493708400"; d="scan'208";a="110947196"
Received: from rebeccas.png.intel.com ([172.30.199.118])
	by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2017 01:43:32 -0700
From: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Jun 2017 16:43:54 +0800
Message-Id: <1496652235-125329-1-git-send-email-rebecca.swee.fun.chang@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCHv3] bitbake-layers: check layer dependencies before adding
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
X-List-Received-Date: Mon, 05 Jun 2017 08:43:35 -0000

Change log on v3 patch:
- Use "-F" for force add argument flags.
- This is because "-f" was already been use by oe-selftest
  causing argument flags overridden and failed oe-selftest.

Tested on the failed test cases, now they are passing.
2017-06-05 16:01:20 - test_bitbakelayers_flatten (oeqa.selftest.bblayers.BitbakeLayers) ... ok
2017-06-05 16:01:35 - test_bitbakelayers_showappends (oeqa.selftest.bblayers.BitbakeLayers) ... ok

Failed logs on v2 patch:
https://autobuilder.yocto.io/builders/nightly-oe-selftest/builds/320/steps/Running%20oe-selftest/logs/stdio

Change log on v2 patch:
- Remove line "return 1", because bb.fatal raises an exception, hence
  return 1 is not needed.

Regards,
Rebecca

Chang Rebecca Swee Fun (1):
  bitbake-layers: check layer dependencies before adding

 bitbake/bin/bitbake-layers     |  1 +
 bitbake/lib/bblayers/action.py | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.7.4


