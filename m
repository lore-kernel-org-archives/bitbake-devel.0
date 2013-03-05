Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuBQ-0003eG-FK
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:53:42 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2013 07:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343522"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:03 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:20 +0200
Message-Id: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 00/11] replace tooltips with property windows in HOB
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
X-List-Received-Date: Tue, 05 Mar 2013 15:53:43 -0000
X-List-Received-Date: Tue, 05 Mar 2013 15:53:43 -0000
X-List-Received-Date: Tue, 05 Mar 2013 15:53:43 -0000

[Enhancement 2248] - https://bugzilla.yoctoproject.org/show_bug.cgi?id=2248

Added property windows for recipe selection page, package selection page
and also replaced the tooltips information pages with dialogs.

Andrei Dinu (11):
  added extra variables to cache_extra.py
  extended cooker.py variables
  replaced the function that displayed tooltips
  added information for the information dialogs
  new class added for the property windows.
  added entries for information dialogs
  added information columns needed for prop dialogs
  added functionality for the information dialogs.
  added information so that it displays correctly
  added event for the "All packages" tab
  added events for the "Package Groups" "All recipes

 bitbake/lib/bb/cache_extra.py                      |    9 +
 bitbake/lib/bb/cooker.py                           |    9 +
 bitbake/lib/bb/ui/crumbs/builder.py                |   35 +-
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |   12 +-
 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py     |  347 ++++++++++++++++++++
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   14 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   23 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py              |   22 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    3 +-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   13 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   22 +-
 11 files changed, 472 insertions(+), 37 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py

-- 
1.7.9.5



