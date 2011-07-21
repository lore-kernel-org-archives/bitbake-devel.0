Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qjybu-00061F-Ql
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 21:08:39 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Jul 2011 12:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,242,1309762800"; d="scan'208";a="28664011"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 21 Jul 2011 12:04:30 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 12:08:57 -0700
Message-Id: <cover.1311275221.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Remove unused target tree data for Hob
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
X-List-Received-Date: Thu, 21 Jul 2011 19:08:39 -0000

Here's a copy of Liping's "Remove unused target tree data for Hob" with my
changes made per my review and my SoB added.

The following changes since commit 09a9146262d58dfe4a2ea4270026b90ae33f6c91:

  parse/ConfHandler: Fix multiline variable corruption (2011-07-21 11:08:19 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake lke-speed
  https://github.com/incandescant/bitbake/tree/lke-speed

Liping Ke (1):
  Remove unused target tree data for Hob

 lib/bb/cooker.py |   89 +++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 68 insertions(+), 21 deletions(-)

-- 
1.7.6



