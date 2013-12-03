Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 3CD406D292
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Dec 2013 16:37:04 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 03 Dec 2013 08:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,818,1378882800"; d="scan'208";a="443910760"
Received: from timevans-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.121.200])
	by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2013 08:37:02 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Dec 2013 16:36:55 +0000
Message-Id: <cover.1386088140.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [1.18][PATCH 0/3] Backports for 1.18 branch (cover letter only)
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
X-List-Received-Date: Tue, 03 Dec 2013 16:37:04 -0000

The following changes since commit bbb4fa427739912ff3b87379bf629066f6662458:

  methodpool: Retire it, remove global method scope (2013-09-11 17:58:14 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bitbake-118-next
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-118-next

Nicolas Dechesne (1):
  bitbake: fetch2/svn.py: use log instead of info to retrieve revision

Richard Purdie (1):
  bitbake: perforce: Fix path subdirectory issues

Volker Vogelhuber (1):
  bitbake: fetch/hg: Improve user/password handling

 lib/bb/fetch2/hg.py       | 10 ++++++++--
 lib/bb/fetch2/perforce.py |  2 +-
 lib/bb/fetch2/svn.py      | 14 ++++++++------
 3 files changed, 17 insertions(+), 9 deletions(-)

-- 
1.8.1.2


