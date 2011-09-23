Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R7CXS-0007fl-CV
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Sep 2011 22:40:02 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 23 Sep 2011 13:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,432,1312182000"; d="scan'208";a="66944248"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.15])
	by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2011 13:34:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2011 13:34:30 -0700
Message-Id: <cover.1316809959.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
Subject: [PATCH 0/3] Hob bug fixes
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
X-List-Received-Date: Fri, 23 Sep 2011 20:40:02 -0000

This series includes a few fixes found whilst debugging and fixing
Yocto bug #1521
http://bugzilla.yoctoproject.org/show_bug.cgi?id=1521

Richard, please consider these for Yocto 1.1

Regards,
Joshua

The following changes since commit 623e9c7f7a9cf12b8c81c26cc608990682a601dd:

  Fix mercurial fetcher in fetch2 (2011-09-21 14:07:14 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (3):
  ui/crumbs/hobeventhandler: move remaining getVariable calls to init
  ui/crumbs/hobeventhandler: fix variable name typo
  hob: fix building with current selections after reparse

 lib/bb/ui/crumbs/hobeventhandler.py |   11 ++++++-----
 lib/bb/ui/hob.py                    |    2 --
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
1.7.6.2



