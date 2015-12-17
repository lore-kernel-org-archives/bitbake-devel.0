Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 79E3F73191
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:02 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="619664246"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by FMSMGA003.fm.intel.com with ESMTP; 17 Dec 2015 08:48:51 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:44 +0000
Message-Id: <cover.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 00/11] Toaster startup script improvements
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:06 -0000

This patchset includes a bunch of readability, usability and code style
fixes for toaster script. It was started as a fix for #8775 and then
I just couldn't stop and decided to make the script a bit better.

The following changes since commit d65cf4fe9d239169e2474b59bdce7fc59194de67
(poky-contrib, toaster-next):

  toaster-manual: describe the way to start Toaster (2015-12-15 14:03:20 +0200)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/ed/toaster/improve-toaster-script
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/ed/toaster/improve-toaster-script

Ed Bartosh (11):
  toaster: implement checksocket command
  toaster: check if address:port is in use
  toaster: split long lines, add/remove whitespace
  toaster: remove unused variable
  toaster: add MANAGE variable
  toaster: updated header of the toaster script
  toaster: remove addtoConfiguration function
  toaster: remove 2 unused functions
  toaster: move startup checks to a better place
  toaster: move setting of default values
  toaster: remove 2 confusing parameters

 bin/toaster                                        | 144 +++++++++------------
 .../toastermain/management/commands/checksocket.py |  69 ++++++++++
 2 files changed, 129 insertions(+), 84 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastermain/management/commands/checksocket.py

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


