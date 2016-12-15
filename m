Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id E6FEA600EB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Dec 2016 18:09:25 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 15 Dec 2016 10:09:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,353,1477983600"; d="scan'208";a="1072495161"
Received: from weipengl-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.182.212])
	by orsmga001.jf.intel.com with ESMTP; 15 Dec 2016 10:09:24 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Dec 2016 07:09:12 +1300
Message-Id: <cover.1481825296.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH v3 0/1] runqueue: dry-run real tasks when BB_SETSCENE_ENFORCE is set
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
X-List-Received-Date: Thu, 15 Dec 2016 18:09:26 -0000

Changes since v2:
* Rebased on top of master (there was a conflict with my tinfoil2 changes
  that have now been merged)


The following changes since commit f1cd6fab604f14d8686b1d783cbfe012d923ee42:

  lib/bb/build: enable access to logger within tasks (2016-12-14 12:20:35 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/setscene-enforce-dryrun
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/setscene-enforce-dryrun

Paul Eggleton (1):
  runqueue: dry-run real tasks when BB_SETSCENE_ENFORCE is set

 bin/bitbake-worker | 12 +++++++-----
 lib/bb/runqueue.py | 13 +++++++------
 2 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.5.5


