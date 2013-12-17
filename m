Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id ABF4C6E4C1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Dec 2013 12:57:45 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 17 Dec 2013 04:53:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,501,1384329600"; d="scan'208";a="445629199"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2013 04:57:44 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Dec 2013 15:04:02 +0200
Message-Id: <1387285447-18057-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/5] hob: remove meta-hob layer
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
X-List-Received-Date: Tue, 17 Dec 2013 12:57:47 -0000

Meta-hob layer contains only a hob-toolchain (a basic toolchain)
and a hob-image.bb (an image with a single line: inherit image). 
Instead of hob-toolchain I've used meta-toolchain, and for hob-image.bb, 
I have created one in build dir. The custom images saved in this layer
will now be placed into build dir.

Cristiana Voicu (5):
  hob: replace hob-toolchain with meta-toolchain
  hob: create a base hob image used to create custom images
  hob: remove the rest of meta-hob
  hob: remove the code that adds hob layer to bblayers
  hob: append bbfiles to bblayers.conf instead of local.conf

 bitbake/lib/bb/ui/crumbs/builder.py                |    5 +++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |   16 +++++++++-------
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |    2 +-
 meta-hob/COPYING.MIT                               |   17 -----------------
 meta-hob/conf/layer.conf                           |   15 ---------------
 meta-hob/recipes-core/images/hob-image.bb          |    1 -
 meta-hob/recipes-core/meta/hob-toolchain.bb        |    9 ---------
 8 files changed, 14 insertions(+), 53 deletions(-)
 delete mode 100644 meta-hob/COPYING.MIT
 delete mode 100644 meta-hob/conf/layer.conf
 delete mode 100644 meta-hob/recipes-core/images/hob-image.bb
 delete mode 100644 meta-hob/recipes-core/meta/hob-toolchain.bb

-- 
1.7.9.5


