Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 406057418A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 May 2015 15:42:36 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 May 2015 08:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,476,1427785200"; d="scan'208";a="575490649"
Received: from cestaunt-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.15.40])
	by orsmga003.jf.intel.com with ESMTP; 22 May 2015 08:42:36 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 May 2015 16:42:20 +0100
Message-Id: <cover.1432309249.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [1.26][PATCH 0/2] A couple of backports from master
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
X-List-Received-Date: Fri, 22 May 2015 15:42:37 -0000

Two patches backported from master: a fix for edit_metadata_file() (only
used by bitbake-layers in 1.26) and an additional utility function.


The following changes since commit 8e0211d121e4cb1124dfe879db751ad00f5c978b:

  bitbake-layers: ensure non-extended recipe name is preferred (2015-05-15 18:10:49 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bbfixes-1.26
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bbfixes-1.26

Paul Eggleton (2):
  lib/bb/utils: add function to get layer containing a file
  lib/bb/utils: fix several bugs in edit_metadata_file()

 lib/bb/utils.py | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

-- 
2.1.0


