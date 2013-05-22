Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id EE11660657
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2013 09:50:48 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga102.ch.intel.com with ESMTP; 22 May 2013 02:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,718,1363158000"; d="scan'208";a="338121955"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 22 May 2013 02:50:51 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2013 12:52:33 +0300
Message-Id: <1369216355-13788-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/2] hob:changes to recipes/packages table view
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 May 2013 09:50:49 -0000


Cristiana Voicu (2):
  hob: apply a fade out animation when deselecting from tables
  hob: Table sorting criteria should not change after deselecting
    recipes/packages

 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |   20 +++++++---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   32 ++++++++-------
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   46 ++++++++++++----------
 3 files changed, 57 insertions(+), 41 deletions(-)

-- 
1.7.9.5


