Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3d8h-00064Q-Q3
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Mar 2012 01:48:00 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 16:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113997894"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.107])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 16:39:26 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Mar 2012 16:39:18 -0800
Message-Id: <8e63205a2a6f5d211698431d821c5ab50d86b9b4.1330734444.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
Subject: [PATCH 2/6] ui/icons: crop the info icons
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
X-List-Received-Date: Sat, 03 Mar 2012 00:48:00 -0000

The info icons include large, transparent borders. Crop this out so that
we can use the icon without using too much space in the GUI.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/icons/info/info_display.png |  Bin 4760 -> 4558 bytes
 lib/bb/ui/icons/info/info_hover.png   |  Bin 4847 -> 4650 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/icons/info/info_display.png b/lib/bb/ui/icons/info/info_display.png
index 439587bc8cff24a545737d86ff23c1d631ef7544..6e2c44b2c9c794e7fe43859469d88605525ab3e2 100644
GIT binary patch
delta 1909
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

delta 2115
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

diff --git a/lib/bb/ui/icons/info/info_hover.png b/lib/bb/ui/icons/info/info_hover.png
index a1dd89d374c727e9bdd25cb2b0629bca51d61b75..a05da56ae7c11143b1bf24da010e2d789dcf6d44 100644
GIT binary patch
delta 2002
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

delta 2202
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

-- 
1.7.7.6



