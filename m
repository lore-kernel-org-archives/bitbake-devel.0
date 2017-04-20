Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 6E55B719B0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Apr 2017 02:20:32 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Apr 2017 19:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,223,1488873600"; d="scan'208";a="958979153"
Received: from sitinura-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.137.15])
	by orsmga003.jf.intel.com with ESMTP; 19 Apr 2017 19:20:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Apr 2017 14:20:28 +1200
Message-Id: <cover.1492654797.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/1] tinfoil overrides fix
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
X-List-Received-Date: Thu, 20 Apr 2017 02:20:33 -0000

The following changes since commit b4da94a368c6c44c6e5b6e6e9a1e041ed84b4554:

  bitbake: Update version to 1.34.0 for stable release (2017-04-19 10:42:07 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil-overrides2-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil-overrides2-bb

Paul Eggleton (1):
  lib/bb/command: fix overrides in remote datastores where there is no default

 lib/bb/command.py | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.9.3


