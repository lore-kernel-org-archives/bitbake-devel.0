Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 8005777002
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 14:43:44 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 03 Sep 2015 07:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,462,1437462000"; d="scan'208";a="554583257"
Received: from tmistat-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.10.21])
	by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2015 07:43:43 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Sep 2015 15:43:38 +0100
Message-Id: <cover.1441291289.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/2] [toaster] Correctly disable build button
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
X-List-Received-Date: Thu, 03 Sep 2015 14:43:45 -0000

The 'build' button is enabled after project selection, and whenever a
valid project is selected. This means you could start a build
without specifying a target.

These patches ensure that the build button is correctly disabled
and fixes how the incomplete configuration warning is shown.

The following changes since commit c80b582212336044c55052ad0d39f9da06d71438:

  debianutils: create package for run-parts (2015-09-03 12:43:33 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/bbarrosp/build-button
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/bbarrosp/build-button

Belen Barros Pena (2):
  toaster: disable build button as needed
  toaster: show incomplete configuration warning

 lib/toaster/toastergui/static/css/default.css | 1 +
 lib/toaster/toastergui/static/js/base.js      | 2 --
 lib/toaster/toastergui/templates/base.html    | 8 +++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

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


