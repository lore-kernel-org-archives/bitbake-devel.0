Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 52AA2713CC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Sep 2014 16:07:28 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 03 Sep 2014 09:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,458,1406617200"; d="scan'208";a="597376794"
Received: from svgunawa-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.16])
	by orsmga002.jf.intel.com with ESMTP; 03 Sep 2014 09:06:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Sep 2014 17:06:41 +0100
Message-Id: <cover.1409760364.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/1] Tinfoil fix
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
X-List-Received-Date: Wed, 03 Sep 2014 16:07:32 -0000

The following change since commit 8f5c1cdae1ee6ce04ae0d04d0b95bd80efbf7534:

  process: Ensure abnormal exits set an error level (2014-09-02 18:10:17 +0100)

is available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-fixtracking
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-fixtracking

Paul Eggleton (1):
  tinfoil: add a means of enabling variable history tracking

 lib/bb/tinfoil.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
1.9.3


