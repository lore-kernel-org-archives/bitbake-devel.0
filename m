Return-Path: <stephano.cetola@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id DD66471AB5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 18:23:19 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Feb 2018 10:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,536,1511856000"; d="scan'208";a="31232674"
Received: from aalzate-mobl1.amr.corp.intel.com ([10.255.229.185])
	by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2018 10:23:20 -0800
From: Stephano Cetola <stephano.cetola@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Feb 2018 10:15:50 -0800
Message-Id: <20180219181551.87750-1-stephano.cetola@linux.intel.com>
X-Mailer: git-send-email 2.16.0
Subject: [PATCH V2 0/1] utils.py: Add option for explode_dep_versions2
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
X-List-Received-Date: Mon, 19 Feb 2018 18:23:20 -0000

Changes since V1:
applied to bitbake tree rather than poky-contrib
updated subject to reference utils.py rather than bitbake

This patch is required for a fix to buildhistory.

See [YOCTO #12334] for details.

Amanda Brindle (1):
  utils.py: Add option for explode_dep_versions2 to return unsorted

 lib/bb/utils.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.16.0


