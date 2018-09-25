Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 28E30601D4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 17:15:25 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8PHFR9J004232
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 10:15:27 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 25 Sep 2018 10:15:26 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Sep 2018 13:15:24 -0400
Message-ID: <20180925171525.30692-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH v2] Fix gitsm networking and mirroring
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
X-List-Received-Date: Tue, 25 Sep 2018 17:15:26 -0000
Content-Type: text/plain

v2:
Further testing found two missing try/except blocks when checking if a git
repository contained the .gitmodules file.  This has been corrected and the
bitbake-selftest is now working again.

v1:
gitsm would honor the BB_NO_NETWORK and mirroring for the primary repository,
but submodules would always attempt to hit the network.

This code reworks the git submodule fetcher by avoiding the
"git submodule init".

The code has been tested using my local use-case, as well as the built-in
test suite.  (You'll notice I had to adjust the test suite slightly in the
patch.)

The change is available at:

   git://git.openembedded.org/bitbake-contrib mgh/gitsm


Mark Hatle (1):
  fetch2/gitsm.py: Rework the git submodule fetcher

 lib/bb/fetch2/gitsm.py | 279 +++++++++++++++++++++++++++----------------------
 lib/bb/tests/fetch.py  |   3 +
 2 files changed, 159 insertions(+), 123 deletions(-)

-- 
1.8.3.1


