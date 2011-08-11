Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QrK0Y-0004cS-Vi
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Aug 2011 03:24:27 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 10 Aug 2011 18:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="37334307"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.222])
	by orsmga001.jf.intel.com with ESMTP; 10 Aug 2011 18:19:54 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2011 18:19:44 -0700
Message-Id: <cover.1313025215.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/4] Bug fixing and code clarity
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
X-List-Received-Date: Thu, 11 Aug 2011 01:24:27 -0000

The following series addresses some thinko/typo's I'd introduced to hob, by
using variable names which are too similar, as well as adding some changes
to increase clarity in various places.

Regards,

Joshua

The following changes since commit 705d14d1e1108e0544c7eab827f1242f0839add9:

  bb/cooker: only emit ConfigFilePathFound for files which were parsed (2011-08-10 13:38:11 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (4):
  bb/ui/crumbs/tasklistmodel: fix some typos and add comments to mark()
  bb/ui/crumbs/tasklistmodel: correctly uniquify dependency list
  bb/ui/crumbs/tasklistmodel: don't include an item in its own depends
  bb/cache: rename confusing variable

 lib/bb/cache.py                   |    6 +++---
 lib/bb/ui/crumbs/tasklistmodel.py |   28 ++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 11 deletions(-)

-- 
1.7.6



