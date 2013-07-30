Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id CEBFE6B478
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jul 2013 20:42:51 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 30 Jul 2013 13:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,781,1367996400"; d="scan'208";a="373645040"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.205])
	by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2013 13:42:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jul 2013 21:42:44 +0100
Message-Id: <cover.1375216758.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Subject: [PATCH 0/2] CONSOLIDATED PULL: BitBake fixes for master (cover letter only)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 30 Jul 2013 20:42:52 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes (against Poky, but apply cleanly against bitbake
master with -p2) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bitbake
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake

André Draszik (1):
  fetch2: fix unpack of .xz files

Valentin Popa (1):
  bitbake-worker: import needed signal module

 bitbake/bin/bitbake-worker        | 1 +
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.1.2


