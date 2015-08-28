Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 7059F71633
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 16:27:50 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 28 Aug 2015 09:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,425,1437462000"; d="scan'208";a="757340209"
Received: from abityuts-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.11.19])
	by orsmga001.jf.intel.com with ESMTP; 28 Aug 2015 09:27:50 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Aug 2015 17:27:46 +0100
Message-Id: <cover.1440779114.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/2] Toaster UI tweaks
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
X-List-Received-Date: Fri, 28 Aug 2015 16:27:55 -0000

Fix global navigation and improve layout on builds page.

The following changes since commit 393bd7496d71eb101f21234c1233a2d18fd2c73e:

  oeqa/oetest.py: add better package search for hasPackage() (2015-08-26 08:28:06 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/bbarrosp/project-builds
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/bbarrosp/project-builds

Belen Barros Pena (2):
  toaster: adjust spacing in project pages
  toaster: fix global navigation

 lib/toaster/toastergui/templates/base.html         |  6 +++--
 .../templates/baseprojectbuildspage.html           |  2 +-
 .../toastergui/templates/projectbuilds.html        |  6 ++---
 .../toastergui/templates/projecttopbar.html        | 28 +++++++---------------
 4 files changed, 16 insertions(+), 26 deletions(-)

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


