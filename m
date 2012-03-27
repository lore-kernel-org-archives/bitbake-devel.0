Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCRrB-0001Be-5e
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 10:34:21 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 27 Mar 2012 01:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="125522606"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 27 Mar 2012 01:25:18 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Mar 2012 16:51:34 +0800
Message-Id: <cover.1332838207.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Hob: add proxy support into Hob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 27 Mar 2012 08:34:21 -0000

This patch is to add proxy support into Hob.
So, with that, users can set up http_proxy, ftp_proxy, https_proxy, all_proxy, git proxy and cvs proxy for build.

The following changes since commit d3e0beed9eef53018158c9f999cd20b44629aa61:

  guile: Deal with hardcoded path issues (2012-03-27 00:29:00 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/proxy
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/proxy

Shane Wang (1):
  Hob: allow users to setup the proxies

 bitbake/lib/bb/ui/crumbs/builder.py         |   39 +++++++++
 bitbake/lib/bb/ui/crumbs/hig.py             |  111 ++++++++++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   32 ++++++++
 3 files changed, 171 insertions(+), 11 deletions(-)

-- 
1.7.6



