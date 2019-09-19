Return-Path: <ee.peng.yeoh@intel.com>
X-Greylist: delayed 426 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 19 Sep 2019 10:18:20 UTC
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by mail.openembedded.org (Postfix) with ESMTP id 9663C7FFD6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 10:18:20 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Sep 2019 03:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,523,1559545200"; d="scan'208";a="194337417"
Received: from andromeda02.png.intel.com ([10.221.183.11])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2019 03:11:14 -0700
From: Yeoh Ee Peng <ee.peng.yeoh@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Sep 2019 18:11:07 +0800
Message-Id: <1568887870-22217-1-git-send-email-ee.peng.yeoh@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/3 v01] bitbake-layers show-recipes minor enhancement
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
X-List-Received-Date: Thu, 19 Sep 2019 10:18:20 -0000

v00:
Minor enhancement to facilitate user to
 - view unique packagenames
 - view recipe or packagenames from user provided layer
 - view recipe or packagenames that removed the "(skipped)" tag

v01:
Minor variable rename to improve readability and simplify codes. 
 - rename -p/--packagenames to -r/--recipes-only
 - rename -r/--remove-skip-tag to -b/--bare
 - rename show_provided_layer_only to selected_layer

Yeoh Ee Peng (3):
  bitbake: bitbake-layers: show-recipes: Show recipes only
  bitbake: bitbake-layers: show-recipes: Select recipes from selected
    layer
  bitbake: bitbake-layers: show-recipes: Enable bare output

 lib/bblayers/query.py | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

-- 
2.7.4


