Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAXcl-0000N0-Cb
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 03:19:35 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 19:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131778619"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.222])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 19:10:38 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 19:10:31 -0700
Message-Id: <77e5a17cf5b15e50633e3a87f80a585af87b380c.1332381654.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
Subject: [PATCH 06/10] lib/ui/icons: autocrop images
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
X-List-Received-Date: Thu, 22 Mar 2012 02:19:36 -0000

Remove transparent border from the edge of the layers_display,
packages_display and recipe_display images.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/icons/layers/layers_display.png     |  Bin 5326 -> 4840 bytes
 lib/bb/ui/icons/packages/packages_display.png |  Bin 7188 -> 7011 bytes
 lib/bb/ui/icons/recipe/recipe_display.png     |  Bin 4873 -> 4723 bytes
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/icons/layers/layers_display.png b/lib/bb/ui/icons/layers/layers_display.png
index 94f90098fcf3bbd0d12e2b6631b0fa3cc5f65249..b7f9053a9e04f972800f57f7fb194a2e46cead23 100644
GIT binary patch
delta 2193
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
TLgv5F00000NkvXXu0mjfh{rF%

delta 2685
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

diff --git a/lib/bb/ui/icons/packages/packages_display.png b/lib/bb/ui/icons/packages/packages_display.png
index bd20c422d818a042bf82c6a3be1da8fdb242e1c6..f5d0a5064d358cf1b03460d0372fc802a464c291 100644
GIT binary patch
delta 4381
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
X6hIiK_RKyr00000NkvXXu0mjf^;LLO

delta 4562
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

diff --git a/lib/bb/ui/icons/recipe/recipe_display.png b/lib/bb/ui/icons/recipe/recipe_display.png
index 838ef00c8d06d1dc7af7e960ba8d23ecb6aaeb73..e9809bc7d9fdb58e0f17372eb23b879087d2c4d0 100644
GIT binary patch
delta 2075
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
FV1j@2@<{*y

delta 2229
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
Dr7S4z

-- 
1.7.7.6



