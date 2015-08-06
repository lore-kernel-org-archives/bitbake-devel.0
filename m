Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id B6F9376497
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 16:23:50 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 06 Aug 2015 09:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,623,1432623600"; d="scan'208";a="763376482"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2015 09:23:49 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id E004C6A4083;
	Thu,  6 Aug 2015 09:23:02 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Aug 2015 19:23:39 +0300
Message-Id: <cover.1438877744.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/4] Toaster UI fixes
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
X-List-Received-Date: Thu, 06 Aug 2015 16:23:55 -0000

Hi,

Please review 4 more fixes for Toaster UI.

The following changes since commit a8b723498c9a7106210db140452886894494b4d6:

  bitbake: cooker: Resolve file monitoring race issues when using memres bitbake (2015-08-03 07:36:25 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/michaelw/toaster/layerdetails-btns-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/michaelw/toaster/layerdetails-btns-fix

Michael Wood (4):
  bitbake: toastergui: Machine select button url parameters change
  bitbake: toastergui: Move click disabled check after table ready event
  bitbake: toastergui: Fix typo on layers in project filter condition
  bitbake: toastergui: layerBtn Fix build trigger mechanism

 bitbake/lib/toaster/toastergui/static/js/layerBtn.js   | 13 +++++++++++++
 .../lib/toaster/toastergui/static/js/layerdetails.js   | 18 ++++++------------
 bitbake/lib/toaster/toastergui/tables.py               |  8 ++++----
 .../lib/toaster/toastergui/templates/recipe_btn.html   |  4 ++--
 4 files changed, 25 insertions(+), 18 deletions(-)

--
Regards,
Ed


