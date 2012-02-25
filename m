Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S1AhB-0007bw-KY
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 07:01:25 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Feb 2012 21:53:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110641959"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.27])
	by azsmga001.ch.intel.com with ESMTP; 24 Feb 2012 21:53:00 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 21:52:57 -0800
Message-Id: <cover.1330149082.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/1] Fix depexp
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
X-List-Received-Date: Sat, 25 Feb 2012 06:01:25 -0000

Per the patch and Yocto bug #2027 the recent BitBake patch
to implement the new Hob UI deleted the file which implements
thge progress bar used by depexp. The following patch adds
back that file.

Cheers,
Joshua

https://bugzilla.yoctoproject.org/show_bug.cgi?id=2027

The following changes since commit c7486a09310fe63b1aa1b7b0bb9450f306b6093b:

  bitbake/cooker: terminate when errors found in layer configuration (2012-02-24 23:30:16 +0000)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/depexp
  https://github.com/incandescant/bitbake/tree/josh/depexp

Joshua Lock (1):
  crumbs: add back progress implementation for depexp

 lib/bb/ui/crumbs/progress.py |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/progress.py

-- 
1.7.7.6



