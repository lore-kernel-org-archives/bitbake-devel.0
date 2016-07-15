Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3A247606D0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jul 2016 08:55:16 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 15 Jul 2016 01:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,367,1464678000"; d="scan'208";a="995777752"
Received: from apbalanx-mobl.ccr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.177.79])
	by orsmga001.jf.intel.com with ESMTP; 15 Jul 2016 01:55:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jul 2016 20:54:29 +1200
Message-Id: <cover.1468572805.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/1] Fix for progress handling
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
X-List-Received-Date: Fri, 15 Jul 2016 08:55:17 -0000

Fix an issue that shows up on the YP autobuilder during the uninative
fetch process.


The following changes since commit cabe7e2459fcd561bced2d39ba5bd173576153e5:

  toaster: tests Add selenium test for layerdetails page (2016-07-08 09:57:06 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-progressfix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-progressfix

Paul Eggleton (1):
  knotty: avoid errors when fetching outside of a task

 lib/bb/ui/uihelper.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.5.5


