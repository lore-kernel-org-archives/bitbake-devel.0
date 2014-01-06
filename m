Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 22CF76BCAA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2014 02:51:09 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s062pAvC015100
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 5 Jan 2014 18:51:10 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Sun, 5 Jan 2014 18:51:09 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 6 Jan 2014 18:53:55 +0800
Message-ID: <cover.1389005562.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Subject: [RFC PATCH 0/1] set the PREFERRED_VERSION from command line
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
X-List-Received-Date: Mon, 06 Jan 2014 02:51:10 -0000
Content-Type: text/plain

The following changes since commit 2f792445bfc671081152f06e1cd507c049eb21ee:

  logrotate: two minor fixes (2014-01-06 18:25:45 +0800)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/PV
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/PV

Robert Yang (1):
  bitbake/cooker.py: set the PREFERRED_VERSION from command line

 bitbake/lib/bb/cooker.py     | 5 +++++
 bitbake/lib/bb/cookerdata.py | 1 +
 scripts/oe-buildenv-internal | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
1.8.3.1


