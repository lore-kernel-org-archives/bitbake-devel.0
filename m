Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 6DC92606B2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Mar 2018 06:27:20 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Mar 2018 23:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000"; d="scan'208";a="24988773"
Received: from peggleto-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.png.intel.com) ([172.30.199.135])
	by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2018 23:27:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Mar 2018 14:27:16 +0800
Message-Id: <cover.1521181617.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.14.3
Subject: [PATCH 0/1] cooker: remove old bitbake shell reference
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
X-List-Received-Date: Fri, 16 Mar 2018 06:27:20 -0000

The following changes since commit 39d6a30a28f66c599e18beddbd847f40dcff623c:

  utils.py: Add option for explode_dep_versions2 to return unsorted (2018-03-15 03:39:18 -0700)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib paule/bb-shell-remove
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/bb-shell-remove

Paul Eggleton (1):
  cooker: remove old bitbake shell reference

 lib/bb/cooker.py | 11 -----------
 1 file changed, 11 deletions(-)

-- 
2.14.3


