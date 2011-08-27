Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qx85s-0005Lx-8P
	for bitbake-devel@lists.openembedded.org;
	Sat, 27 Aug 2011 03:53:56 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Aug 2011 18:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,288,1312182000"; d="scan'208";a="45524221"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.247])
	by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2011 18:49:05 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Aug 2011 18:48:57 -0700
Message-Id: <cover.1314409608.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/2] Small UI patches
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
X-List-Received-Date: Sat, 27 Aug 2011 01:53:56 -0000

Most interesting is the second patch to add a Copy item to the right-click
menu for logs in RunningBuildTreeView.

This means users of hob and goggle can copy/paste the log contents right from
the GUI as well as submitting the log contents to pastebin.

The following changes since commit 0423587db09f6f28cf9d801f5657a84157f42dbe:

  hob: disable some menu entries whilst build is in progress (2011-08-24 19:32:42 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (2):
  ui/crumbs/tasklistmodel: don't add same item to binb column more than
    once
  ui/crumbs/runningbuild: add a 'Copy' item to the messages right-click
    menu

 lib/bb/ui/crumbs/runningbuild.py  |   36 +++++++++++++++++++++++++++---------
 lib/bb/ui/crumbs/tasklistmodel.py |    5 +++--
 2 files changed, 30 insertions(+), 11 deletions(-)

-- 
1.7.6



