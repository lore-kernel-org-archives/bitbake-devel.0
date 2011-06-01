Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QRpFv-0003oi-OU
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Jun 2011 19:30:55 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 01 Jun 2011 10:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,304,1304319600"; d="scan'208";a="10449759"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.13.133])
	by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2011 10:26:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2011 18:26:28 +0100
Message-Id: <cover.1306947210.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [RFC PATCH 0/2] skipped recipe handling
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
X-List-Received-Date: Wed, 01 Jun 2011 17:30:56 -0000

I noticed bitbake-layers did not handle bbappends for skipped recipes
properly (e.g. in Poky it complained that uclibc_git.bbappend did not
match any recipe). Thus I added a mechanism to bitbake within cooker that
lists skipped recipes and extended bitbake-layers to use it.

This (or something similar) will also be needed for improving the
NoProvider error handling - ideally we should be reporting if the target
being requested has been skipped and why. To this end the SkippedPackage
class includes the reason and DEPENDS/RDEPENDS info (although at the
moment RDEPENDS does not get populated). Some may prefer I remove the 
DEPENDS/RDEPENDS bits until the future patch where they are used, if
so I wouldn't object to removing them.

I also considered adding to skiplist for BBMASKed-out recipes but on
reflection I elected not to do so since I assumed we ought to be
completely ignoring recipes that are masked out in this way.

Patch summary (these are against Poky but they apply cleanly with -p2
against bitbake master):

Paul Eggleton (2):
  bitbake: track skipped packages
  bitbake-layers: handle skipped recipes

 bitbake/bin/bitbake-layers  |   24 +++++++++++++++++++-----
 bitbake/lib/bb/cache.py     |   12 +++++++++---
 bitbake/lib/bb/cooker.py    |   16 ++++++++++++++++
 bitbake/lib/bb/parse/ast.py |   12 ++++++------
 4 files changed, 50 insertions(+), 14 deletions(-)

-- 
1.7.4.1


