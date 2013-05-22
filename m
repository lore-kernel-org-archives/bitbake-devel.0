Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 3AA266968C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2013 14:25:29 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 22 May 2013 07:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,721,1363158000"; d="scan'208";a="338233551"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.181])
	by fmsmga001.fm.intel.com with ESMTP; 22 May 2013 07:25:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2013 15:25:10 +0100
Message-Id: <cover.1369232029.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 0/3] Fixes for recent changes to cooker
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 May 2013 14:25:29 -0000

The recent changes to the cooker structure have affected bitbake-layers,
the OE layer index update script and other users of tinfoil. These
changes bring tinfoil up-to-date and fix a couple of other issues.

(We may want to clean up the cookerdata params handling in the near
future so that we don't need TinfoilConfigParameters, but for now this
at least keeps things working.)


The following changes (against poky, but apply cleanly to bitbake master
with -p2) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil-fixes

Paul Eggleton (3):
  bitbake-layers: fix for move of calc_bbfile_priority within cooker
  tinfoil: fix for changes to cooker config structure
  cookerdata: rename _parse to parse_config_file

 bitbake/bin/bitbake-layers   |  2 +-
 bitbake/lib/bb/cookerdata.py | 12 ++++++------
 bitbake/lib/bb/tinfoil.py    | 41 +++++++++++++++++++++--------------------
 3 files changed, 28 insertions(+), 27 deletions(-)

-- 
1.8.1.2


