Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id D0F756B25A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Aug 2013 14:18:43 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 13 Aug 2013 07:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,869,1367996400"; d="scan'208";a="281373211"
Received: from timevans-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.122.187])
	by AZSMGA002.ch.intel.com with ESMTP; 13 Aug 2013 07:18:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Aug 2013 15:18:37 +0100
Message-Id: <cover.1376403450.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 0/2] Show close matches for invalid task/target
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
X-List-Received-Date: Tue, 13 Aug 2013 14:18:45 -0000

The following changes (against poky, but apply cleanly with -p2 against
bitbake master) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/closematch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/closematch

Paul Eggleton (2):
  runqueue: report close matches for an invalid task name
  taskdata: report close matches with NoProvider errors

 bitbake/lib/bb/event.py                  |  3 ++-
 bitbake/lib/bb/runqueue.py               |  6 +++++-
 bitbake/lib/bb/taskdata.py               | 13 ++++++++++++-
 bitbake/lib/bb/ui/crumbs/runningbuild.py | 10 ++++++++--
 bitbake/lib/bb/ui/knotty.py              |  9 +++++++--
 5 files changed, 34 insertions(+), 7 deletions(-)

-- 
1.8.1.2


