Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3C0D4767FB
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 09:40:17 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 08 Sep 2015 02:40:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,489,1437462000"; d="scan'208";a="784894345"
Received: from almacarr-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.11.248])
	by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2015 02:40:15 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Sep 2015 10:40:12 +0100
Message-Id: <cover.1441705002.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/3] Fix presentation issues on "all builds" page
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
X-List-Received-Date: Tue, 08 Sep 2015 09:40:18 -0000

Fixes for some small presentation issues in the all builds page.

The following changes since commit c1df471feacaf2590216aa476ce242908dac38cf:

  pseudo_1.7.3.bb: New version of pseudo (2015-09-06 15:26:27 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/bbarrosp/all-builds
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/bbarrosp/all-builds

Belen Barros Pena (3):
  toaster: remove unnecessary white space
  toaster: fix project names in latest builds
  toaster: replace ETA with % of tasks done

 lib/toaster/toastergui/templates/mrb_section.html | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


