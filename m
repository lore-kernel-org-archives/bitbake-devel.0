Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QwK1E-00010b-Sp
	for bitbake-devel@lists.openembedded.org;
	Wed, 24 Aug 2011 22:25:49 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Aug 2011 13:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="41542775"
Received: from vorpal.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 24 Aug 2011 13:21:01 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 24 Aug 2011 13:25:57 -0700
Message-Id: <cover.1314217450.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/3] Fix some bugs and usability issues in hob
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
X-List-Received-Date: Wed, 24 Aug 2011 20:25:49 -0000

Jessica Zhang identified some issues in hob which are addressed by this
series.

The following changes since commit 692c2fcead5c82249359ad54d2c7941d087a2eb3:

  usermanual: The git fetcher defaults to the git protocol (or file) (2011-08-23 09:59:50 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (3):
  hob: don't set PARALLEL_MAKE and BB_NUMBER_THREADS based on cpu count
  bb/ui/crumbs/tasklistmodel: fix find_reverse_depends method
  hob: disable some menu entries whilst build is in progress

 lib/bb/ui/crumbs/hobprefs.py      |    4 +--
 lib/bb/ui/crumbs/tasklistmodel.py |    2 +-
 lib/bb/ui/hob.py                  |   41 ++++++++++++++++++++++++------------
 3 files changed, 29 insertions(+), 18 deletions(-)

-- 
1.7.6



