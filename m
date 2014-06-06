Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 678346FC2F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jun 2014 15:06:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s56F6pGk028465
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 6 Jun 2014 08:06:51 -0700 (PDT)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.169.1; Fri, 6 Jun 2014 08:06:50 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 6 Jun 2014 10:35:05 -0400
Message-ID: <cover.1402065176.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH 0/1] cache.py: print debug info when EXCLUDE_FROM_WORLD
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
X-List-Received-Date: Fri, 06 Jun 2014 15:06:55 -0000
Content-Type: text/plain

The following changes since commit 66d5be204fd339cc84a0ae92d3923a8c1e6f1389:

  bitbake: bitbake: show wildcard appends for bitbake-layers (2014-06-06 10:33:19 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/exworld
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/exworld

Robert Yang (1):
  cache.py: print debug info when EXCLUDE_FROM_WORLD

 bitbake/lib/bb/cache.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
1.7.10.4


