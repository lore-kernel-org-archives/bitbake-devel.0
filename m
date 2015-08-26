Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id AEC67734B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 08:48:36 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 26 Aug 2015 01:48:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,415,1437462000"; d="scan'208";a="791147830"
Received: from ssandhu2-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.4.150])
	by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2015 01:48:34 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:48:17 +0100
Message-Id: <cover.1440578613.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/3] Improve the image shown on the Toaster landing page
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
X-List-Received-Date: Wed, 26 Aug 2015 08:48:37 -0000

Make the Toaster landing page more obviously a screenshot, so users
don't try to press the buttons on it.

The following changes since commit 393bd7496d71eb101f21234c1233a2d18fd2c73e:

  oeqa/oetest.py: add better package search for hasPackage() (2015-08-26 08:28:06 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/bbarrosp/7743
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/bbarrosp/7743

Belen Barros Pena (3):
  toastergui: remove old screenshots
  toaster: new Toaster image
  toastergui: change image in landing page

 lib/toaster/toastergui/static/img/toaster.png     | Bin 51986 -> 0 bytes
 lib/toaster/toastergui/static/img/toaster_1.7.png | Bin 125151 -> 0 bytes
 lib/toaster/toastergui/static/img/toaster_bw.png  | Bin 0 -> 140514 bytes
 lib/toaster/toastergui/templates/landing.html     |   6 +-----
 4 files changed, 1 insertion(+), 5 deletions(-)
 delete mode 100755 bitbake/lib/toaster/toastergui/static/img/toaster.png
 delete mode 100644 bitbake/lib/toaster/toastergui/static/img/toaster_1.7.png
 create mode 100644 bitbake/lib/toaster/toastergui/static/img/toaster_bw.png

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


