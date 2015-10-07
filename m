Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E3C9160125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 10:20:22 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 07 Oct 2015 03:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,648,1437462000"; d="scan'208";a="821294149"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2015 03:20:22 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id DC8346A4087
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 03:19:24 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 13:20:13 +0300
Message-Id: <cover.1444213003.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/2] Fix cooker log download button
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
X-List-Received-Date: Wed, 07 Oct 2015 10:20:23 -0000


* Retrieve a build's log file location directly from the file system,
as the one which is available at the time of the BuildStarted event
is incorrect.

* Hide the "Download build log" button for builds which fail early
(e.g. due to recipe parsing) and consequently have no cooker_log_path.


The following changes since commit 34399e5950509ffe978d9e6a31e91193d1bdcf0a:

  toaster: orm Machines filter don't pass self in as parameter (2015-10-06 20:08:50 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/elliot/toaster/wrong_log-8373
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/elliot/toaster/wrong_log-8373

Elliot Smith (2):
  toaster: Manually retrieve log file location from filesystem
  toaster: Hide "Download build log" button if log doesn't exist

 bitbake/lib/bb/ui/toasterui.py                     | 31 +++++++++++++++++++++-
 .../toastergui/templates/builddashboard.html       |  4 ++-
 2 files changed, 33 insertions(+), 2 deletions(-)

--
Ed


