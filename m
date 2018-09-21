Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5F7717988E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Sep 2018 00:19:09 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8L0IXEV028758
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 20 Sep 2018 17:18:43 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Thu, 20 Sep 2018 17:18:15 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 20 Sep 2018 20:18:14 -0400
Message-ID: <20180921001815.18248-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH] Fix gitsm networking and mirroring
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
X-List-Received-Date: Fri, 21 Sep 2018 00:19:09 -0000
Content-Type: text/plain

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

 lib/bb/fetch2/gitsm.py | 271 +++++++++++++++++++++++++++----------------------
 lib/bb/tests/fetch.py  |   3 +
 2 files changed, 151 insertions(+), 123 deletions(-)

-- 
1.8.3.1


