Return-Path: <amanda.r.brindle@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 27C0A60602
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Feb 2018 18:30:31 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Feb 2018 10:30:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000"; d="scan'208";a="25528354"
Received: from arbrindl-dev.jf.intel.com ([10.7.199.57])
	by orsmga003.jf.intel.com with ESMTP; 07 Feb 2018 10:30:33 -0800
From: Amanda Brindle <amanda.r.brindle@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Feb 2018 10:26:53 -0800
Message-Id: <cover.1517873329.git.amanda.r.brindle@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: stephano.cetola@intel.com
Subject: [PATCH v2 0/1] tinfoil.py: Check if BUILDDIR or .devtoolbase exists
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
X-List-Received-Date: Wed, 07 Feb 2018 18:30:32 -0000

In v2, if the build environment is not initialised, raise an exception instead of printing out a message.

Also, check if .devtoolbase exists. This will determine if an sdk environment has been sourced. If .devtoolbase exists,
an exception should not be raised.

The following changes since commit 902b77bf91d96517b935bce00a11003604dc3d54:

  lib/oe/package_manager/sdk: Ensure do_populate_sdk_ext and do_populate_sdk repos don't conflict (2018-01-22 10:39:10 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib abrindle/tinfoil
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=abrindle/tinfoil

Amanda Brindle (1):
  tinfoil.py: Check if BUILDDIR  or .devtoolbase exists

 bitbake/lib/bb/tinfoil.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.7.4


