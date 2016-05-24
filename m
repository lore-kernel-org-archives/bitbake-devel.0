Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 03ACC6018C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 May 2016 22:21:07 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 24 May 2016 15:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,360,1459839600"; d="scan'208";a="961593721"
Received: from ismailm-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.147.14])
	by orsmga001.jf.intel.com with ESMTP; 24 May 2016 15:21:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 May 2016 10:20:36 +1200
Message-Id: <cover.1464128340.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [1.30][PATCH 0/1] Backport fetch environment fix to 1.30
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
X-List-Received-Date: Tue, 24 May 2016 22:21:08 -0000

This will allow variables such as GIT_SSL_CAINFO through from the
external environment to the fetch environment, which in OE will allow
buildtools-tarball's included git version to find the included
ca-certificates data.


The following changes since commit 9ea7d3ec59c2b09ae60cf0c7f18472355bfb98d7:

  toaster: fix progress bar in MySQL environment (2016-05-13 17:45:31 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-git-ssl-cainfo-1.30
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-git-ssl-cainfo-1.30

Ross Burton (1):
  fetch2: export DBUS_SESSION_BUS_ADDRESS to support authentication
    agents

 lib/bb/fetch2/__init__.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.5.5


