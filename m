Return-Path: <anibal.limon@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id A4D95719AF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 16:18:45 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 31 Oct 2016 09:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,575,1473145200"; d="scan'208";a="896049276"
Received: from unknown (HELO alimonb-mobl1.zpn.intel.com) ([10.219.5.143])
	by orsmga003.jf.intel.com with ESMTP; 31 Oct 2016 09:18:45 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Oct 2016 10:20:15 -0600
Message-Id: <1477930815-4886-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Subject: [PATCH] toaster/tests/functional: Remove README file was wrong included into a commit
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 31 Oct 2016 16:18:45 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I included this README [1] file from my WIP toaster repository, i
apologize for the trouble that could be caused.

[1] http://git.openembedded.org/bitbake/commit/?id=a583dc0b296415ec904c081c4de96ceef46732a8

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/toaster/tests/functional/README | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 lib/toaster/tests/functional/README

diff --git a/lib/toaster/tests/functional/README b/lib/toaster/tests/functional/README
deleted file mode 100644
index e69de29..0000000
-- 
2.1.4


