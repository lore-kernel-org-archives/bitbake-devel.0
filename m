Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 4464D65DFC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Apr 2014 16:32:41 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 11 Apr 2014 09:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,842,1389772800"; d="scan'208";a="511562429"
Received: from pmeel-ivm.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.171])
	by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2014 09:32:41 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Apr 2014 17:32:29 +0100
Message-Id: <cover.1397233921.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH 0/2] Toaster web fixes
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
X-List-Received-Date: Fri, 11 Apr 2014 16:32:44 -0000

The following changes since commit bb4980c63db386ce7d30d9a6b86e9f3861b3bc3a:

  bitbake: Update to version 1.23.0 for master (2014-04-10 17:55:41 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/toasterfixes4
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/toasterfixes4

Belen Barros Pena (2):
  bitbake: toaster: Fix total number of tasks in build dashboard
  bitbake: toaster: Fix Empty tasks filter

 lib/toaster/toastergui/templates/builddashboard.html | 2 +-
 lib/toaster/toastergui/views.py                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.0


