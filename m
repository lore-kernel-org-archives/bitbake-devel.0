Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A504C70016
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2016 02:31:50 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 18 Sep 2016 19:31:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,360,1470726000"; d="scan'208";a="1053031749"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 18 Sep 2016 19:31:50 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 18 Sep 2016 19:33:12 -0700
Message-Id: <cover.1474252113.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: bavery <brian.avery@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 0/3] toaster: UI fixes
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
X-List-Received-Date: Mon, 19 Sep 2016 02:31:50 -0000

This contains a set of UI fixes for bugs:
9832 - fix task links
9862 - fix left navigationactive item in build history pages
10037- remove duplicate layer info in cutsom recipes detail page

-b

The following changes since commit ead7c4bc8024fb4325b124dc0b663c86c4363122:

  toaster: unlock BuildEnvirnoment when build is done (2016-09-16 17:24:09 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/toaster/belen/sep-18-ui
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/toaster/belen/sep-18-ui

Belen Barros Pena (3):
  toaster: Fix links to tasks with specific outcome
  toaster: Indicate active navigation element
  toaster: Remove duplicate layer information

 lib/toaster/toastergui/templates/basebuildpage.html  | 7 +++++--
 lib/toaster/toastergui/templates/builddashboard.html | 6 +++---
 lib/toaster/toastergui/templates/customrecipe.html   | 2 --
 3 files changed, 8 insertions(+), 7 deletions(-)

--
1.9.1

