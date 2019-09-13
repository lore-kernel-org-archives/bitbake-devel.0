Return-Path: <ee.peng.yeoh@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C43817D391
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2019 03:58:43 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Sep 2019 20:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; d="scan'208";a="197430578"
Received: from andromeda02.png.intel.com ([10.221.183.11])
	by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 20:58:43 -0700
From: Yeoh Ee Peng <ee.peng.yeoh@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Sep 2019 11:58:38 +0800
Message-Id: <1568347121-43357-1-git-send-email-ee.peng.yeoh@intel.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Sat, 14 Sep 2019 11:25:37 +0000
Subject: [PATCH 0/3] bitbake-layers show-recipes minor enhancement
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
X-List-Received-Date: Fri, 13 Sep 2019 03:58:43 -0000

Minor enhancement to facilitate user to
 - view unique packagenames
 - view recipe or packagenames from user provided layer
 - view recipe or packagenames that removed the "(skipped)" tag

Yeoh Ee Peng (3):
  bitbake: bitbake-layers: show-recipes: Show unique packagenames
  bitbake: bitbake-layers: show-recipes: Select recipes from provided
    layer
  bitbake: bitbake-layers: show-recipes: Enable remove the (skipped) tag

 lib/bblayers/query.py | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

-- 
2.7.4


