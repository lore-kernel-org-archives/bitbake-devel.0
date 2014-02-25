Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id E06F06F159
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2014 13:22:43 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga102.ch.intel.com with ESMTP; 25 Feb 2014 05:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,540,1389772800"; d="scan'208";a="481450515"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.62])
	by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2014 05:22:15 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Feb 2014 15:30:09 +0200
Message-Id: <1393335012-26237-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <y>
References: <y>
Subject: [PATCH 0/3] Changes in hob code to allow meta-hob layer deletion
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
X-List-Received-Date: Tue, 25 Feb 2014 13:22:44 -0000


Cristiana Voicu (3):
  hob: create a base hob image used to create custom images
  hob: remove the code that adds hob layer to bblayers
  hob: append bbfiles to bblayers.conf instead of local.conf

 bitbake/lib/bb/ui/crumbs/builder.py                |    3 ++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |   16 +++++++++-------
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |    2 +-
 meta-hob/recipes-core/images/hob-image.bb          |    1 -
 5 files changed, 13 insertions(+), 11 deletions(-)
 delete mode 100644 meta-hob/recipes-core/images/hob-image.bb

-- 
1.7.9.5


