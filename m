Return-Path: <brian.avery@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 0521173186
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 01:42:54 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP; 19 Sep 2016 18:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,365,1470726000"; d="scan'208";a="11555882"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga004.jf.intel.com with ESMTP; 19 Sep 2016 18:42:55 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Sep 2016 18:44:16 -0700
Message-Id: <cover.1474335720.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 0/1] toaster: buildinfohelper stop constructiong local layer paths assuming git
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
X-List-Received-Date: Tue, 20 Sep 2016 01:42:55 -0000

Local layers may have come from tar.gz files or have been created locally
as part of the development process.

When the layer is local source don't try and work out the location of
the layer by using the git information (getGitCloneDirectory)

-bavery

The following changes since commit 0e5cc654ac1d0db68c4e00ddbea8ab5026311cb4:

  toaster: Add tests to detect if we have missing db migrations (2016-09-19 18:38:52 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/toaster/suj/sep-19-git
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/toaster/suj/sep-19-git

Michael Wood (1):
  toaster: buildinfohelper local layer don't construct path using git
    info

 lib/bb/ui/buildinfohelper.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--
1.9.1

