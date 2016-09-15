Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id D37AE7719E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 11:20:51 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 15 Sep 2016 04:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,339,1470726000"; d="scan'208";a="1040295491"
Received: from lvernat-mobl7.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.23.81])
	by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2016 04:20:51 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Sep 2016 14:20:48 +0300
Message-Id: <1473938450-12696-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH 0/2] Config re-parse improvements
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
X-List-Received-Date: Thu, 15 Sep 2016 11:20:53 -0000

These two patches improve config (re-)parsing by allowing multiple passes of
re-parse.


The following changes since commit 57912de63fa83550c0ae658eb99b76e9cc91a8d1:

  cooker: record events on cooker exit (2016-09-06 10:36:34 +0100)

are available in the git repository at:

  git://git.openembedded.org/openembedded-core-contrib marquiz/bitbake/fixes-10188
  http://git.openembedded.org/openembedded-core-contrib/log/?h=marquiz/bitbake/fixes-10188

Markus Lehtonen (2):
  cookerdata: fire ConfigParsed event after re-parse
  cookerdata: allow multiple passes of config re-parsing

 lib/bb/cookerdata.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.6.6


