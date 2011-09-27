Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R8hLQ-00016Y-75
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Sep 2011 01:45:48 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 27 Sep 2011 16:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,452,1312182000"; d="scan'208";a="56365089"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.9])
	by azsmga001.ch.intel.com with ESMTP; 27 Sep 2011 16:40:21 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2011 16:40:14 -0700
Message-Id: <cover.1317166668.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
Subject: [RFC PATCH 0/1] Fix texinfo build on Ubuntu Oneiric
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
X-List-Received-Date: Tue, 27 Sep 2011 23:45:48 -0000

Texinfo fails to build on Ubuntu 11.10, but not any of my other systesm,
the following patch resolves this in what feels like a harmless way.

Any comments?

Regards,
Joshua

The following changes since commit 684a4b517d13884c315688967fadd5e6a4845b71:

  libffi: really populate -dev package (2011-09-26 20:50:27 +0100)

are available in the git repository at:
  git://git.openembedded.org/openembedded-core-contrib josh/texinfo
  http://cgit.openembedded.org/cgit.cgi/openembedded-core-contrib/log/?h=josh/texinfo

Joshua Lock (1):
  texinfo: fix build on Ubuntu Oneiric

 meta/recipes-extended/texinfo/texinfo_4.13a.bb |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

-- 
1.7.6.2



