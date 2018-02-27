Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0825E77629
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Feb 2018 07:23:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w1R7Nv6H001058
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Feb 2018 23:23:57 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Mon, 26 Feb 2018 23:23:31 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Feb 2018 15:28:08 +0800
Message-ID: <cover.1519716375.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [resend][PATCH 0/3 V2] cooker: fixes event notifications
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
X-List-Received-Date: Tue, 27 Feb 2018 07:23:57 -0000
Content-Type: text/plain

Hi RP,

I think that I've answered your questions' in V1, do you have any comments on
these patches, please ?

// Robert

The following changes since commit 1b7a9d4f63d07d61d53daac12da275e8ef2feb24:

  buildhistory-diff: honour report_all flag (2018-02-24 10:35:59 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/cooker
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/cooker

Robert Yang (3):
  bitbake: cooker: don't preserve BB_CONSOLELOG
  bitbake: cooker: fix event notifications
  bitbake: cooker: improve inotify handling

 bitbake/lib/bb/cache.py  |  9 ++++---
 bitbake/lib/bb/cooker.py | 66 ++++++++++++++++++++++++------------------------
 2 files changed, 39 insertions(+), 36 deletions(-)

-- 
2.7.4


