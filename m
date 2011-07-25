Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlQJq-0005y1-KV
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 20:55:58 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,264,1309762800"; d="scan'208";a="29903196"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 11:56:08 -0700
Message-Id: <cover.1311620081.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/4] Add reparseFile command and adopt the saved environment
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
X-List-Received-Date: Mon, 25 Jul 2011 18:55:58 -0000

This series adapts the cooker to use the saved OS environment instead of the
current os.environ and adds the reparseFiles command which triggered the
changes.

The following changes since commit f0b5d16426b983a67c51c47f3542162108bd4156:

  Update version to 1.13.3 (2011-07-25 13:50:38 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (4):
  data|cooker: use saved environment variables when calling
    inheritFromOS
  bitbake-layers: adapt to cooker change for saved environment
  command|cooker: Add reparseFiles command
  cooker: only append files once

 bin/bitbake-layers |    7 ++++---
 lib/bb/command.py  |    8 ++++++++
 lib/bb/cooker.py   |   51 +++++++++++++++++++++++++++++++--------------------
 lib/bb/data.py     |    8 ++++----
 4 files changed, 47 insertions(+), 27 deletions(-)

-- 
1.7.6



