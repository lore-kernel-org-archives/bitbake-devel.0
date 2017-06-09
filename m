Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A719078293
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jun 2017 13:35:27 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jun 2017 06:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,317,1493708400"; d="scan'208";a="1180388527"
Received: from therfet-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.41.2])
	by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2017 06:35:23 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Jun 2017 15:34:42 +0200
Message-Id: <cover.1497014984.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH 0/4] BitBake memory-resident mode fixes
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
X-List-Received-Date: Fri, 09 Jun 2017 13:35:27 -0000

Three fixes for memres and one optimisation that I noticed while working
on these.

The following changes since commit 705ab252e631903e6d2e46202b419a9e8adcd861:

  bitbake-layers: check layer dependencies before adding (2017-06-05 13:33:14 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-memres-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-memres-fixes

Paul Eggleton (4):
  cookerdata: fix variable history not showing in bitbake -e with memres
  cooker: fix file changes not triggering task re-execution with memres
  cooker: set config valid flags in initConfigurationData()
  cooker: add BB_CMDLINE to enable access to UI command line with memres

 lib/bb/command.py    |  3 ++-
 lib/bb/cooker.py     | 29 +++++++++++++++++++++--------
 lib/bb/cookerdata.py |  4 ++--
 3 files changed, 25 insertions(+), 11 deletions(-)

-- 
2.9.4


