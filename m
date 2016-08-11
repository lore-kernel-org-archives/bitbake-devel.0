Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id A4D33771C2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Aug 2016 03:37:30 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 10 Aug 2016 20:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,503,1464678000"; d="scan'208";a="863452236"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.171.53])
	by orsmga003.jf.intel.com with ESMTP; 10 Aug 2016 20:37:29 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2016 15:36:56 +1200
Message-Id: <cover.1470886482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/4] Progress fixes
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
X-List-Received-Date: Thu, 11 Aug 2016 03:37:36 -0000

Fixes for minor issues in the progress bar display, plus a patch for
some unclosed files that I noticed at the same time as working on these.


The following changes since commit 0a9b5d7d9655dbb09d458fc6e330e932f0f9dab6:

  toaster: buildinfohelper Add handling local layers (i.e. non-git) layers (2016-08-11 00:08:18 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-progress-fixes2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-progress-fixes2

Paul Eggleton (4):
  runqueue: fix two minor issues with the initialising tasks progress
  knotty: fix task progress bar not starting at 0%
  knotty: don't show number of running tasks in quiet mode
  siggen: properly close files rather than opening them inline

 lib/bb/runqueue.py  |  5 +++--
 lib/bb/siggen.py    | 15 +++++++++------
 lib/bb/ui/knotty.py | 11 ++++++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.5.5


