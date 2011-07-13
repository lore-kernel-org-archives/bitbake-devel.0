Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qh21P-00024Z-QL
	for bitbake-devel@lists.openembedded.org;
	Wed, 13 Jul 2011 18:10:48 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jul 2011 09:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,526,1304319600"; d="scan'208";a="25434298"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.33])
	by orsmga002.jf.intel.com with ESMTP; 13 Jul 2011 09:06:48 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 13 Jul 2011 09:06:40 -0700
Message-Id: <cover.1310573108.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Bug fixes for the hob v2
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
X-List-Received-Date: Wed, 13 Jul 2011 16:10:48 -0000

Updated version of the final patch in the series to address Richard's code
review.

The following changes since commit 4803c6d3d1db31105d98a7f71596875333db0dc5:

  ui/crumbs/tasklistmodel: fix automatic removal of orphaned items (2011-07-13 12:28:15 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (1):
  cooker: only return *Found events if something was actually found

 lib/bb/cooker.py |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

-- 
1.7.6



