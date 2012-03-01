Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S37a7-0007re-CJ
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 16:06:11 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 01 Mar 2012 06:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123711547"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.90])
	by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2012 06:57:40 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Mar 2012 14:57:34 +0000
Message-Id: <cover.1330613733.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/3] Fixes for scenequeue task failure
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 01 Mar 2012 15:06:11 -0000

After some more extensive testing, fix some regressions in scenequeue
task failure handling caused by one of my earlier commits.

The following changes since commit 8f07bdc0a42dd7a7c3acf5d1b13220dbc98c8017:

  image_types_uboot: Update to work after recent image_types changes (2012-02-29 18:25:03 +0000)

are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/bb-sceneqtaskfail
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-sceneqtaskfail

Paul Eggleton (3):
  bitbake/runqueue: fix python error on scenequeue task failure
  bitbake/uihelper: restore line to record failed normal tasks
  bitbake/build: report TaskFailedSilent events as "Failed"

 bitbake/lib/bb/build.py       |    9 ++++++++-
 bitbake/lib/bb/runqueue.py    |    3 +--
 bitbake/lib/bb/ui/uihelper.py |    7 ++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

-- 
1.7.5.4



