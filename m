Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1S2DpK-0002wB-GL
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 04:34:10 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 27 Feb 2012 19:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="71143533"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.62])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Feb 2012 19:24:37 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Feb 2012 11:22:37 +0800
Message-Id: <cover.1330399220.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH V2 0/1] Added new variable BBINCLUDED
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
X-List-Received-Date: Tue, 28 Feb 2012 03:34:10 -0000

Added a new variable BBINCLUDES to show the file dependency information. This 
kind of information could be used by others, i.e. recipe editor to decide when 
to reparse the recipes to reflect the user changes.

The following changes since commit 927bec5f72230be4f2452d9ef5a747b2c00cb781:
  Dongxiao Xu (1):
        bitbake.conf: Create a new filter variable BB_HASHCONFIG_WHITELIST

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib llu/bbincluded
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/bbincluded

Lianhao Lu (1):
  bitbake: Added BBINCLUDED variable.

 bitbake/lib/bb/cooker.py         |    1 +
 bitbake/lib/bb/parse/__init__.py |    9 +++++++++
 bitbake/lib/bb/parse/ast.py      |    2 ++
 3 files changed, 12 insertions(+), 0 deletions(-)



