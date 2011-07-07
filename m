Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QexHm-00015h-8e
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jul 2011 00:43:06 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 07 Jul 2011 15:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,496,1304319600"; d="scan'208";a="24664403"
Received: from vorpal.jf.intel.com ([10.7.199.170])
	by orsmga001.jf.intel.com with ESMTP; 07 Jul 2011 15:39:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Jul 2011 15:43:24 -0700
Message-Id: <cover.1310078501.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/3] Behavioural bug fixes for Hob
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
X-List-Received-Date: Thu, 07 Jul 2011 22:43:06 -0000

This is the first of no doubt many patch series to fix bugs in the hob ui now
that people have started trying to use it.

The following changes since commit c7a9ef70ba91d47d53074e8d78cbc52f396144a7:

  bitbake/process.py: Ensure queued UI events are queued right before we add our own handler (2011-07-07 10:57:05 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (3):
  ui/crumbs/tasklistmodel: fix reset method
  lib/bb/hob: fix changing base image
  lib/bb/ui/hob: don't error when dismissing save as dialog

 lib/bb/ui/crumbs/tasklistmodel.py |   20 ++++++++++++++++----
 lib/bb/ui/hob.py                  |   30 +++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 15 deletions(-)

-- 
1.7.6



