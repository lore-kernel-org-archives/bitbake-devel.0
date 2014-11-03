Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8689465D3C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 18:12:43 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 03 Nov 2014 10:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,691,1406617200"; d="scan'208";a="484151867"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.154])
	by orsmga003.jf.intel.com with ESMTP; 03 Nov 2014 10:11:07 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Nov 2014 12:12:51 -0600
Message-Id: <1415038373-12763-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH 0/2] fetcher: Add support for search latest version of
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
X-List-Received-Date: Mon, 03 Nov 2014 18:12:46 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Aníbal Limón (2):
  tests/fetch: improve unittest for git method latest_versionstring
  fetch/wget: change print sentences to bb.debug

 lib/bb/fetch2/git.py  |  38 ++++++++
 lib/bb/fetch2/wget.py | 239 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py |  77 ++++++++++++++++
 3 files changed, 354 insertions(+)

-- 
1.9.1

