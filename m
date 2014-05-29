Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 108146FCE4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 May 2014 17:18:34 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 May 2014 10:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,935,1392192000"; d="scan'208";a="548480119"
Received: from acdivito-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.240])
	by orsmga002.jf.intel.com with ESMTP; 29 May 2014 10:18:02 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 May 2014 18:17:14 +0100
Message-Id: <cover.1401383609.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/2] Error handling fixes
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
X-List-Received-Date: Thu, 29 May 2014 17:18:39 -0000

The following changes since commit 0e7b594ccbceb3149f38776cea204807031ef69f:

  fetch2/hg: Fix missing proto param for hg checkout with user and pw (2014-05-28 08:28:17 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-errors
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-errors

Paul Eggleton (2):
  fetch2: improve handling of two classes of URL parameter mistakes
  utils: avoid printing traceback on ExpansionError during parsing

 lib/bb/fetch2/__init__.py | 14 ++++++++++----
 lib/bb/utils.py           |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
1.9.3


