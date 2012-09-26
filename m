Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TGmUQ-0007Q6-KX
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 09:57:03 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 26 Sep 2012 00:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,489,1344236400"; d="scan'208";a="197235829"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by azsmga001.ch.intel.com with ESMTP; 26 Sep 2012 00:44:10 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Sep 2012 09:49:37 +0300
Message-Id: <1348642178-27405-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] *** bblayers.conf should be updated automatically
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
X-List-Received-Date: Wed, 26 Sep 2012 07:57:03 -0000

To keep things simple for this release, Paul proposed to put the bblayers.conf
merging code in sanity.bbclass. After upgrading bblayers.conf we tell the
user to re-run. It would be better if we could re-read the configuration but that
is something we can address in 1.4. Every layer should make its specific bblayers.conf
updates by appending to the check_bblayers_conf bitbake function. We decided that this
is the right thing to do because we don't want to be invasive. This represents the meta
merging functionality and does only the bblayers.conf v4 -> v5 update. The v5 -> v6
bblayers.conf update is done in another patch sent to poky@yoctoproject.org.

Constantin Musca (1):
  sanity.bbclass: bblayers.conf should be updated automatically

 meta/classes/sanity.bbclass |   56 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

-- 
1.7.9.5



