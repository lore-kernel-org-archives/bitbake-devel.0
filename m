Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1S3OQs-00032p-Vb
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 10:05:47 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 02 Mar 2012 00:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132207911"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.62])
	by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2012 00:57:16 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Mar 2012 16:54:24 +0800
Message-Id: <29a54217de335d06c3c596ab7add22e218590006.1330678346.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1330678346.git.lianhao.lu@intel.com>
References: <cover.1330678346.git.lianhao.lu@intel.com>
Subject: [PATCH 1/1] bitbake/bitbake-prserv: Set file mode bits "x".
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
X-List-Received-Date: Fri, 02 Mar 2012 09:05:47 -0000

[YOCTO #2051] Set 'x' bit to make bitbake-prserv executable.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 bitbake/bin/bitbake-prserv

diff --git a/bitbake/bin/bitbake-prserv b/bitbake/bin/bitbake-prserv
old mode 100644
new mode 100755
-- 
1.7.0.4



