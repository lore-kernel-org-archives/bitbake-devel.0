Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 0116473BB8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Sep 2015 10:31:26 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 24 Sep 2015 03:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,580,1437462000"; d="scan'208";a="776002768"
Received: from rdouetx-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.2.3])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2015 03:31:24 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Sep 2015 11:31:17 +0100
Message-Id: <cover.1443090607.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/2] small improvements to startup, upgrade to latest Django 1.6
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
X-List-Received-Date: Thu, 24 Sep 2015 10:31:29 -0000

This eliminates the question about making a superuser on startup in managed mode.
It also uses the value of WEB_PORT if defined in analysis mode.
It upgrades requirements.txt to the latest Django 1.6 (which I've been running for a while).

The following changes since commit 9f66aa1a11b5b45280aa41bf4517ec56ee5f2ab2:

  bitbake: toaster: start script warning text formatting small improvement (2015-09-23 22:44:56 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/bavery/toaster/small-script-improvement
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/bavery/toaster/small-script-improvement

brian avery (2):
  toaster: small improvements to the startup script
  toaster: change requirements.txt to get the latest 1.6 django version

 bin/toaster              | 12 ++++++------
 toaster-requirements.txt |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

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


