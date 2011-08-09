Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QqpA5-0000i2-Kz
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 18:28:13 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 09 Aug 2011 09:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,344,1309762800"; 
   d="scan'208";a="5483984"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.204])
	by AZSMGA002.ch.intel.com with ESMTP; 09 Aug 2011 09:23:42 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  9 Aug 2011 09:23:35 -0700
Message-Id: <cover.1312906927.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Only return parsed configuration files
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
X-List-Received-Date: Tue, 09 Aug 2011 16:28:13 -0000

This is an updated change to findConfigFilePath which includes review
feedback.

The following changes since commit c3827690b9ba3625d1df32d9517efbe13d7d9a1e:

  bb/ui/hob: Restore toolchain relevant preference settings for build (2011-08-09 15:19:51 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (1):
  bb/cooker: only emit ConfigFilePathFound for files which were parsed

 lib/bb/cooker.py |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

-- 
1.7.6



