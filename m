Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RDft9-0004Ls-2a
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Oct 2011 19:13:11 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 11 Oct 2011 10:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,523,1312182000"; d="scan'208";a="61148713"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.64])
	by azsmga001.ch.intel.com with ESMTP; 11 Oct 2011 10:07:25 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Oct 2011 10:07:16 -0700
Message-Id: <cover.1318352470.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.4
Subject: [PATCH 0/2] Improve usability of checksums
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
X-List-Received-Date: Tue, 11 Oct 2011 17:13:11 -0000

I'd heard some complaints around the usability of checksums and, having done
some recipe work recently, must agree with them.
This series ams to make using checksums less intrusive by:

a) Removing the requirement that if one type of checksum is defined the other
must be too.
b) Reporting all sum mismatches at once
c) Enabling sums to be defined as a parameter of a SRC_URI

Regards,
Joshua

The following changes since commit dca46cc2e1c75b6add2c4801e2994a4812745f5b:

  fetch2: Export additional variables to the fetchers (2011-10-05 14:23:16 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake checksum
  https://github.com/incandescant/bitbake/tree/checksum

Joshua Lock (2):
  fetch2: improve usability of checksums
  fetch2: enable checksum definition as SRC_URI parameter

 lib/bb/fetch2/__init__.py |   82 +++++++++++++++++++++++++--------------------
 1 files changed, 46 insertions(+), 36 deletions(-)

-- 
1.7.6.4



