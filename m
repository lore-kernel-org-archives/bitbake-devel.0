Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 3767E601F5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Feb 2015 18:13:35 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 10 Feb 2015 10:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,551,1418112000"; d="scan'208";a="664422209"
Received: from mjbowe-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.18.120])
	by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2015 10:13:35 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Feb 2015 18:13:22 +0000
Message-Id: <cover.1423591698.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/3] Add mechanism to catch layer branch mismatches
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
X-List-Received-Date: Tue, 10 Feb 2015 18:13:43 -0000

Changes since the earlier RFC patch:
* Removed unused regex line
* Improved validation / error handling
* Added some regression tests

Note: patch 3/3 depends on patch 1/3, so they need to go in together.


The following changes since commit 207013b6dde82f9654f9be996695c8335b95a288:

  data_smart: split expanded removal values when handling _remove (2015-02-02 16:20:42 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/layerdepends
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/layerdepends

Paul Eggleton (3):
  utils: ensure explode_dep_versions2 raises an exception on
    invalid/missing operator
  tests: add tests for OE pre-release version formatting
  cooker: rework LAYERDEPENDS versioning so that it is actually useful

 lib/bb/cooker.py      | 40 ++++++++++++++--------------------------
 lib/bb/tests/utils.py | 37 +++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       | 26 ++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 26 deletions(-)

-- 
1.9.3


