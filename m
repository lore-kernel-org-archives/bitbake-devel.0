Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QUiOg-0005Bu-L7
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Jun 2011 18:47:54 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Jun 2011 09:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,342,1304319600"; d="scan'208";a="11417998"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.13.6])
	by orsmga002.jf.intel.com with ESMTP; 09 Jun 2011 09:44:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Jun 2011 17:42:36 +0100
Message-Id: <cover.1307636663.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/2] skipped recipe handling v2
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
X-List-Received-Date: Thu, 09 Jun 2011 16:47:54 -0000

For the description of this changeset please see the original mail:
http://lists.linuxtogo.org/pipermail/bitbake-devel/2011-June/000911.html

Changes since v1: rebased against recent bitbake changes, added a cache
version bump.

These patches are against Poky but they apply cleanly with -p2 against 
bitbake master. They are also available in the git repository at:
  git://git.pokylinux.org/poky-contrib paule/skippackage
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/skippackage

Paul Eggleton (2):
  bitbake: track skipped packages
  bitbake-layers: handle skipped recipes

 bitbake/bin/bitbake-layers  |   24 +++++++++++++++++++-----
 bitbake/lib/bb/cache.py     |    9 ++++++---
 bitbake/lib/bb/cooker.py    |   16 ++++++++++++++++
 bitbake/lib/bb/parse/ast.py |   12 ++++++------
 4 files changed, 47 insertions(+), 14 deletions(-)

-- 
1.7.4.1



