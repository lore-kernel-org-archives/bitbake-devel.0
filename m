Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 87C6A731EE
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 11:17:19 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 08 Jan 2016 03:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,538,1444719600"; d="scan'208";a="722947260"
Received: from deryaeke-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.84])
	by orsmga003.jf.intel.com with ESMTP; 08 Jan 2016 03:17:18 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jan 2016 11:17:15 +0000
Message-Id: <cover.1452251694.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/8] Add support for PROVIDES to Toaster
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
X-List-Received-Date: Fri, 08 Jan 2016 11:17:22 -0000

Add support of PROVIDES to Toaster backend and frontend.

Please see https://bugzilla.yoctoproject.org/show_bug.cgi?id=6169 for
more details.

The following changes since commit 3e0c0fb8eaf9b764c19f2c25fe50c4eccbd4a9bd:

  toaster-manual: describe the way to start Toaster (2016-01-08 11:09:50 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/ed/toaster/provides-6169
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/ed/toaster/provides-6169

Ed Bartosh (8):
  taskdata: refactor get_providermap
  cooker: add providermap to dep_tree
  buildinfohelper: use providermap
  toaster: add Provider model
  buildinfohelper: add provides info to the db
  toaster: show list of provides for the recipe
  toaster: show 'satisfied via' text for build deps
  toaster: show 'satisfied via' text for reverse deps

 lib/bb/cooker.py                                   |  7 +++++
 lib/bb/runqueue.py                                 |  2 +-
 lib/bb/taskdata.py                                 | 17 +++++-------
 lib/bb/ui/buildinfohelper.py                       | 31 +++++++++++++++-------
 .../orm/migrations/0002_auto_20151223_1528.py      | 27 +++++++++++++++++++
 lib/toaster/orm/models.py                          |  5 ++++
 lib/toaster/toastergui/templates/recipe.html       | 28 +++++++++++++++++--
 7 files changed, 95 insertions(+), 22 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0002_auto_20151223_1528.py

--
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


