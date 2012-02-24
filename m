Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0k9q-0001QR-N7
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 02:41:14 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 23 Feb 2012 17:32:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="114255467"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 23 Feb 2012 17:32:51 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 09:31:29 +0800
Message-Id: <cover.1330046167.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1 v2][PULL] Hob2: bitbake related changes
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
X-List-Received-Date: Fri, 24 Feb 2012 01:41:14 -0000

Hi Richard,

This pull request revise the sceneQueueTaskStarted event change,
please help to review and pull.

Changes from last pull request:
 - sceneQueueTaskStarted inherits runQueueEvent instead of runQueueTaskStarted.
 - Also change sceneQueueTaskFailed to inherit runQueueEvent.

Thanks,
Dongxiao

The following changes since commit 9ede881620c501574f014e600cea6947ea908ac2:

  bitbake: change for adding progress bar in Hob2. (2012-02-23 22:51:50 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob2-bitbake-changes-v2
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob2-bitbake-changes-v2

Dongxiao Xu (1):
  runqueue: fire sceneQueueTaskStarted event when a setscene queue
    starts

 lib/bb/runqueue.py |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.7.4.1



