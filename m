Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 90C0F71A50
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Nov 2017 02:17:51 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP; 07 Nov 2017 18:17:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,361,1505804400"; 
   d="scan'208";a="4848686"
Received: from tkdhir-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.68.14])
	by orsmga002.jf.intel.com with ESMTP; 07 Nov 2017 18:17:49 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Nov 2017 15:17:05 +1300
Message-Id: <cover.1510107342.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/3] bitbake-layers improvements
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
X-List-Received-Date: Wed, 08 Nov 2017 02:17:51 -0000

Some minor usability improvements for bitbake-layers.


The following changes since commit e1e8565b5e19dd3f7ef6e7e41932456adaa3df81:

  tests/fetch: Add ftp test url (2017-11-07 14:41:54 +0000)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/bblayers-fix2
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/bblayers-fix2

Paul Eggleton (3):
  bitbake-layers: add-layer: enable adding multiple layers at once
  bitbake-layers: remove-layer: support removing multiple layers at a time
  bitbake-layers: show-recipes: fix help to mention -i supports multiple classes

 lib/bblayers/action.py | 45 +++++++++++++++++++++++++--------------------
 lib/bblayers/query.py  |  2 +-
 2 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.9.5


