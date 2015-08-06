Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 60F5375BC9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 16:01:39 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 06 Aug 2015 09:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,623,1432623600"; d="scan'208";a="743525603"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 06 Aug 2015 09:01:36 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 2F6496A4083;
	Thu,  6 Aug 2015 09:00:49 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Aug 2015 19:01:26 +0300
Message-Id: <cover.1438876763.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/3] Toaster fixes
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
X-List-Received-Date: Thu, 06 Aug 2015 16:01:41 -0000

Hi,

This patchset contains 3 Toaster fixes reviewed by me.

The following changes since commit a8b723498c9a7106210db140452886894494b4d6:

  bitbake: cooker: Resolve file monitoring race issues when using memres bitbake (2015-08-03 07:36:25 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/michaelw/toaster/misc_fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/michaelw/toaster/misc_fixes

Michael Wood (3):
  bitbake: toastergui: Fix toastertable table header reference
  bitbake: toastergui: Move layerdetails view definition to the views.py
  bitbake: toastermain: Add a longer default database timeout

 bitbake/lib/toaster/toastergui/static/js/table.js  |  2 +-
 bitbake/lib/toaster/toastergui/tables.py           | 24 +-------------------
 .../toaster/toastergui/templates/toastertable.html |  2 +-
 bitbake/lib/toaster/toastergui/urls.py             |  3 +--
 bitbake/lib/toaster/toastergui/views.py            | 15 +++++++++++++
 bitbake/lib/toaster/toastergui/widgets.py          | 26 ----------------------
 bitbake/lib/toaster/toastermain/settings.py        |  6 +++++
 7 files changed, 25 insertions(+), 53 deletions(-)

--
Ed


