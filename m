Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RntI9-000693-FV
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jan 2012 15:48:41 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 19 Jan 2012 06:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="58007054"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.198])
	by AZSMGA002.ch.intel.com with ESMTP; 19 Jan 2012 06:36:05 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2012 14:36:02 +0000
Message-Id: <cover.1326982052.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] Restore tasks summary in the error case
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
X-List-Received-Date: Thu, 19 Jan 2012 14:48:41 -0000

A patch to make the "tasks summary" line always log rather than
only when everything succeeds.

Thanks to Martin Jansa for reminding me about this one.

The patch (against Poky, but applies cleanly with -p2 against bitbake
master) is available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/tasksummary
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tasksummary

Paul Eggleton (1):
  bitbake/runqueue: always log tasks summary

 bitbake/lib/bb/runqueue.py |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

-- 
1.7.5.4



