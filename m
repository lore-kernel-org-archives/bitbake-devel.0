Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs2pO-0000bu-ND
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 03:15:54 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 12 Aug 2011 18:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,365,1309762800"; d="scan'208";a="38018962"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.3])
	by azsmga001.ch.intel.com with ESMTP; 12 Aug 2011 18:11:01 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 18:10:50 -0700
Message-Id: <cover.1313197700.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/5] Switch from recipe-level to package-level data in hob
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
X-List-Received-Date: Sat, 13 Aug 2011 01:15:55 -0000

We currently store recipe-level data in the tasklistmodel (include the
contents of foo recipe) whereas in reality we're likely want to do
package-level operations, as required by EXTRA_IMAGE_INSTALL.

This series enables package-level data in the model and optimises a few
methods to cope with the increased model size.

Regards,
Joshua

The following changes since commit b3ad7acebfad3063c3364f4492f53b25bf53cf81:

  lib/bb/ui/crumbs/hobprefs: fix erroneous save/reparse (2011-08-12 17:48:13 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (5):
  bb/crumbs/tasklistmodel: filter nativesdk packages out of views
  bb/ui/crumbs/tasklistmodel: include package level information
  bb/ui/crumbs/tasklistmodel: optimise find_path_for_item
  bb/ui/crumbs/tasklistmodel: make package_model_filter a little safer
  bb/ui/crumbs/tasklistmodel: simplify conditional in include_item

 lib/bb/ui/crumbs/tasklistmodel.py |   56 ++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

-- 
1.7.6



