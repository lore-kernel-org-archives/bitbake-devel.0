Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5CA4760034;
	Thu, 29 Jan 2015 13:50:14 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Jan 2015 05:46:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,486,1418112000"; d="scan'208";a="644478595"
Received: from jamiewei-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.23.125])
	by orsmga001.jf.intel.com with ESMTP; 29 Jan 2015 05:50:14 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Jan 2015 13:49:51 +0000
Message-Id: <cover.1422539142.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Cc: openembedded-core@lists.openembedded.org
Subject: [bitbake][RFC PATCH 0/1] Proposed fix for layer branch mismatch issue
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
X-List-Received-Date: Thu, 29 Jan 2015 13:50:23 -0000

RFC - ccing the OE-Core list for review. If we apply this, do people
think we can commit to updating the LAYERVERSION in OE-Core at least on
every release and setting versioned LAYERDEPENDS in other layers so that
users get a sensible error if they use incompatible branches? (This also
provides us with a mechanism to handle these types of issues across
changes in master, as well.)

Thoughts?


Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit 9b5b1bd7d77e3f5886f6c557d3b750de1f6d6025:

  siggen: Ensure taskdata default functions exist in base class (2015-01-23 14:39:40 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/layerdepends
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/layerdepends

Paul Eggleton (1):
  cooker: rework LAYERDEPENDS versioning so that it is actually useful

 lib/bb/cooker.py | 36 +++++++++---------------------------
 lib/bb/utils.py  | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 27 deletions(-)

-- 
1.9.3


