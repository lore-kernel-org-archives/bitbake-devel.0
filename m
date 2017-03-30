Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 7F607719BD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Mar 2017 02:24:03 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga105.fm.intel.com with ESMTP; 29 Mar 2017 19:24:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,244,1486454400"; d="scan'208";a="1128726344"
Received: from driley-mobl5.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.172.155])
	by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2017 19:24:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Mar 2017 15:23:58 +1300
Message-Id: <cover.1490840595.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/2] tinfoil: fixes for get_recipe_file()
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
X-List-Received-Date: Thu, 30 Mar 2017 02:24:04 -0000

The following changes since commit 968a77388dd1a24c1dadec6ce49bf53ebb5b643f:

  lib/bb/codeparser: ensure BufferedLogger respects target logging level (2017-03-28 23:07:15 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil-noprovider
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil-noprovider

Paul Eggleton (2):
  tinfoil: fix get_recipe_file() to return an error on invalid recipe
  tinfoil: improve get_recipe_file() exception text

 lib/bb/tinfoil.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.9.3


