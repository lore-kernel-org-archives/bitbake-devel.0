Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id D25946D684
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2013 10:53:19 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 14 Nov 2013 02:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,699,1378882800"; d="scan'208";a="427485128"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2013 02:53:03 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 16CAB560398; Thu, 14 Nov 2013 10:53:03 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Nov 2013 10:52:56 +0000
Message-Id: <1384426381-7869-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/5] bug fixes for Toaster
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
X-List-Received-Date: Thu, 14 Nov 2013 10:53:21 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This patchset contains a number of bugfixes for Toaster.
This should be merged on both origin/master and origin/dora-toaster of OE-Core.

Cheers,
Alex

Alexandru DAMIAN (5):
  cooker, toaster: variable definition tracking
  toaster: fix tasks showing as NoExec
  toaster: remove author field
  toaster: fix path to buildstats file
  toasterui: mark failed sceneQueue tasks as failed

 lib/bb/cooker.py                                   | 15 +++++++++++---
 lib/bb/cookerdata.py                               |  1 +
 lib/bb/ui/buildinfohelper.py                       | 23 +++++++++++++++-------
 lib/bb/ui/toasterui.py                             |  2 +-
 lib/toaster/bldviewer/templates/configuration.html |  6 ++++--
 lib/toaster/bldviewer/templates/recipe.html        |  1 -
 lib/toaster/orm/models.py                          | 17 ++++++++++------
 7 files changed, 45 insertions(+), 20 deletions(-)

-- 
1.8.3.2


