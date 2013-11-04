Return-Path: <valentin.popa@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 981FD6D290
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Nov 2013 10:52:14 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 04 Nov 2013 02:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="316669551"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by AZSMGA002.ch.intel.com with ESMTP; 04 Nov 2013 02:52:12 -0800
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Nov 2013 12:53:11 +0200
Message-Id: <1383562393-22087-1-git-send-email-valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.3.2
Subject: [PATCH 0/2] Rebased "HIG compliant message dialogs"
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
X-List-Received-Date: Mon, 04 Nov 2013 10:52:14 -0000

Two patches that weren't merged in 1.5.
Rebased, in case they are needed for 1.6.

Valentin Popa (2):
  HOB: HIG compliant message dialogs
  GUI error dialog for bitbake

 bitbake/lib/bb/ui/crumbs/builder.py                | 92 ++++++++++++----------
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |  5 +-
 .../lib/bb/ui/crumbs/hig/crumbsmessagedialog.py    | 55 ++++---------
 bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py  | 12 ++-
 .../lib/bb/ui/crumbs/hig/layerselectiondialog.py   | 11 +--
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py    |  5 +-
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |  9 +--
 scripts/hob                                        |  9 ++-
 scripts/show_error_dialog                          | 63 +++++++++++++++
 9 files changed, 158 insertions(+), 103 deletions(-)
 create mode 100755 scripts/show_error_dialog

-- 
1.8.3.2


