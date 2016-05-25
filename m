Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id DD09065CC2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 May 2016 04:47:11 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 24 May 2016 21:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,363,1459839600"; d="scan'208";a="973981972"
Received: from ismailm-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.147.14])
	by fmsmga001.fm.intel.com with ESMTP; 24 May 2016 21:47:09 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 May 2016 16:46:43 +1200
Message-Id: <cover.1464151580.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/1] Fix for unpacking deb files
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
X-List-Received-Date: Wed, 25 May 2016 04:47:12 -0000

The following changes since commit d830dccf948d188492cecfcf2ff053f31740dc21:

  classes/base.bbclass: Fix missing getVarFlag parameter (2016-05-24 15:55:01 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-deb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-deb

Paul Eggleton (1):
  fetch2: fix unpacking of deb packages

 lib/bb/fetch2/__init__.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.5.5


