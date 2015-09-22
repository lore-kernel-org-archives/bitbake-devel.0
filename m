Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id D96C173CF2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 09:34:34 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 22 Sep 2015 02:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,572,1437462000"; d="scan'208";a="566120050"
Received: from martinbu-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.21.229])
	by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2015 02:34:34 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Sep 2015 10:34:30 +0100
Message-Id: <cover.1442914166.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/4] Fix for YOCTO #7442
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
X-List-Received-Date: Tue, 22 Sep 2015 09:34:35 -0000

This set of changes brings back functionality to specify a task for a
build and properly restart builds with non-default tasks.

This functionality has been broken in toaster since June (builds
specifying a non-default task could not be run correctly).

The patchset includes fixes for backend and frontend. It also adds 2 test cases
for frontend to prevent this functionality from being broken again.

The following changes since commit 7b86c771c80d0759c2ca0e57c46c4c966f89c49e:

  bitbake: bitbake: bb.fetch2.git: Import errno module (2015-09-19 22:38:44 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/ed/toaster/7442
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/ed/toaster/7442

Ed Bartosh (4):
  toaster: store task name in Target objects
  toaster: don't re-create Target objects
  toaster: change UI to show tasks
  toaster: add 2 UI tests

 lib/bb/ui/buildinfohelper.py                       | 17 +--------------
 .../bldcontrol/management/commands/runbuilds.py    |  2 +-
 lib/toaster/orm/models.py                          |  2 +-
 lib/toaster/toastergui/templates/builds.html       | 12 ++++++++++-
 lib/toaster/toastergui/templates/mrb_section.html  | 23 ++++++++++++++++-----
 .../toastergui/templates/projectbuilds.html        | 12 ++++++++++-
 lib/toaster/toastergui/tests.py                    | 24 ++++++++++++++++++++--
 7 files changed, 65 insertions(+), 27 deletions(-)

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


