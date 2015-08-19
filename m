Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A587273E11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 13:20:24 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 19 Aug 2015 06:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,709,1432623600"; d="scan'208";a="751523622"
Received: from mclawlor-mobl5.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.12.193])
	by orsmga001.jf.intel.com with ESMTP; 19 Aug 2015 06:20:23 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Aug 2015 14:20:07 +0100
Message-Id: <cover.1439990327.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/4] bitbake-layers improvements
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
X-List-Received-Date: Wed, 19 Aug 2015 13:20:25 -0000

Some fixes for issues in bitbake-layers plus one additional feature.
These patches apply on master or on top of my earlier patchset.


The following changes since commit 8e9bd559c8ef0ebc9e8babbada06e710908bae08:

  toaster: move code from setup_lv_tests to setUp (2015-08-17 14:37:59 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bblayers-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bblayers-fixes

Paul Eggleton (4):
  bitbake-layers: ensure we exit if BBLAYERS_LAYERINDEX_URL is not set
  bitbake-layers: remove-layer: accept just layer directory
  bitbake-layers: fix mapping files to layers
  bitbake-layers: show-recipes: allow filtering by class inheritance

 bin/bitbake-layers   | 88 ++++++++++++++++++++++++++++++++++++----------------
 lib/bb/data_smart.py | 25 +++++++++++++++
 lib/bb/utils.py      | 32 ++++++++++++++-----
 3 files changed, 111 insertions(+), 34 deletions(-)

-- 
2.1.0


