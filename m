Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 84B9376FDE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 12:45:21 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 15 Oct 2015 05:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,685,1437462000"; d="scan'208";a="827340401"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 15 Oct 2015 05:45:21 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 454C96A4083
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 05:44:22 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 15:45:12 +0300
Message-Id: <cover.1444910218.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/4] toaster: Improve display of errors and Toaster exceptions
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
X-List-Received-Date: Thu, 15 Oct 2015 12:45:21 -0000

Hi,

Fixes recording of error messages so that CRITICAL errors are
properly logged and presented to the user.

Modifies how Toaster exceptions are displayed, so they are treated the
same way as other classes of ERROR.

The following changes since commit a8e82d93bfa8feb722912d03ee26bbad7e6fe9f7:

  toaster: Modify "New build" button behaviour for cli builds project (2015-10-15 14:54:27 +0300)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/elliot/toaster/error_display-8320
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/elliot/toaster/error_display-8320

Elliot Smith (4):
  toaster: Record critical errors
  toaster: Remove Toaster exceptions section of build dashboard
  toaster: Guard against builds with no targets
  toaster: Add tests for error message display on the build dashboard

 lib/bb/ui/buildinfohelper.py                       |  5 +-
 lib/bb/ui/toasterui.py                             |  2 +
 lib/toaster/orm/models.py                          | 24 +++---
 .../toastergui/templates/builddashboard.html       | 47 ++---------
 lib/toaster/toastergui/tests.py                    | 91 +++++++++++++++++++++-
 5 files changed, 116 insertions(+), 53 deletions(-)

--
Regards,
Ed


