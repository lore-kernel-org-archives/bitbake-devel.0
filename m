Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 407546FFA4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Sep 2016 09:14:57 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 23 Sep 2016 02:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,381,1470726000"; d="scan'208";a="1060907149"
Received: from yleow-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.155.25])
	by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2016 02:14:57 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2016 21:14:31 +1200
Message-Id: <cover.1474622057.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/1] knotty: ensure progress bar output is accounted for in display
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
X-List-Received-Date: Fri, 23 Sep 2016 09:15:01 -0000

The following changes since commit ca4f5e6d01b5c8cf315f59bc86194d63c0d3d042:

  cooker/providers: Only add target to world build if task exists (2016-09-21 22:33:47 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-progress-fix3
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-progress-fix3

Paul Eggleton (1):
  knotty: ensure progress bar output is accounted for in display

 lib/bb/ui/knotty.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.5.5


