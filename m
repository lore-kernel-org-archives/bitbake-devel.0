Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 1D9B56067D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 12:19:04 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 22 Jul 2016 05:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,404,1464678000"; d="scan'208";a="1000482111"
Received: from lwong9-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.13])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2016 05:19:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Jul 2016 00:18:36 +1200
Message-Id: <cover.1469189882.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/3] Minor fixes for progress reporting
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
X-List-Received-Date: Fri, 22 Jul 2016 12:19:06 -0000

Fix/tweak a few things in the progress reporting code.


The following changes since commit 5fa0b3a19e7d0f40790f737abeddf499d53f1f6a:

  bitbake: implement idle timeout for xmlrpc server (2016-07-21 07:48:35 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-progress-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-progress-fixes

Paul Eggleton (3):
  knotty: fix some minor bugs in BBProgress
  knotty: don't display ETA for tasks with progress
  lib/bb/progress: avoid possibility of start event being reported twice

 lib/bb/progress.py  |  5 ++++-
 lib/bb/ui/knotty.py | 27 ++++++++++++++-------------
 2 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.5.5


