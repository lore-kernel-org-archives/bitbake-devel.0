Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id D3A5B6AC00
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Nov 2017 02:20:55 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga105.fm.intel.com with ESMTP; 07 Nov 2017 18:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,361,1505804400"; d="scan'208";a="1241188808"
Received: from tkdhir-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.68.14])
	by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2017 18:20:33 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Nov 2017 15:20:26 +1300
Message-Id: <cover.1510107572.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/2] A couple of misc fixes
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
X-List-Received-Date: Wed, 08 Nov 2017 02:20:56 -0000

A fix for a tinfoil issue as well as a typo.


The following changes since commit e1e8565b5e19dd3f7ef6e7e41932456adaa3df81:

  tests/fetch: Add ftp test url (2017-11-07 14:41:54 +0000)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/bb-fixes2
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/bb-fixes2

Paul Eggleton (2):
  tinfoil: ensure get_recipe_info() returns Null if recipe not found
  cooker: fix typo in bitbake -g message

 lib/bb/cooker.py  |  2 +-
 lib/bb/tinfoil.py | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.9.5


