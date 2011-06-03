Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <liping.ke@intel.com>) id 1QSJ5j-0000pW-It
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Jun 2011 03:22:23 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 02 Jun 2011 18:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,312,1304319600"; 
   d="scan'208";a="6283941"
Received: from lke-nhm.sh.intel.com (HELO localhost) ([10.239.36.48])
	by azsmga001.ch.intel.com with ESMTP; 02 Jun 2011 18:18:04 -0700
From: Ke Liping <liping.ke@intel.com>
To: poky@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jun 2011 09:06:00 +0800
Message-Id: <cover.1307062861.git.liping.ke@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/4][Image Creator]Add mulitple extra cache fields request support
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
X-List-Received-Date: Fri, 03 Jun 2011 01:22:23 -0000

From: Liping Ke <liping.ke@intel.com>

Those patches are for poky tree. Since bitbake code base is syncing,
I cc those changes to bitbake mail list too. Thanks!

The series of patch are for mplementing multiple extra cache fields
request support.If user needs to request extra cache fields besides
CoreRecipeInfo fields, just add a new XXXRecipeInfo class definition
as Image Creator UI Hob Does.
For implementing this new feature, we refactory current cache code,
remove namedtuple and define corresponding class for dynamical cache
fields support per different cache usage request.


The following changes since commit 6b5d323b6c8960a0999dbafa0422fe127fd0fa97:
  Chris Larson (1):
        event: don't catch systemexit from handler execution

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib lke/cache
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=lke/cache

Liping Ke (4):
  Refactory Current Cache implementation
  Introduce extra cache class for image creator
  Introduce new param caches_array into Cache impl.
  Implement multiple extra cache fields request support

 bitbake/lib/bb/cache.py       |  536 ++++++++++++++++++++++-------------------
 bitbake/lib/bb/cache_extra.py |   54 ++++
 bitbake/lib/bb/cooker.py      |   68 ++++--
 bitbake/lib/bb/shell.py       |    2 +-
 bitbake/lib/bb/ui/hob.py      |    2 +
 5 files changed, 396 insertions(+), 266 deletions(-)
 create mode 100644 bitbake/lib/bb/cache_extra.py



