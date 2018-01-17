Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 1A03C605BF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jan 2018 08:52:30 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w0H8qV0J003413
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jan 2018 00:52:32 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Wed, 17 Jan 2018 00:52:30 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Jan 2018 16:52:49 +0800
Message-ID: <cover.1516179099.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/2] cooker.py: 2 fixes for BBFILE_PATTERN
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
X-List-Received-Date: Wed, 17 Jan 2018 08:52:31 -0000
Content-Type: text/plain

The following changes since commit ceaca281cafa662aa2385b95641bce309dce843d:

  fetch2/__init__: Disable pseudo in runfetchcmd() (2018-01-07 12:21:41 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/cooker
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/cooker

Robert Yang (2):
  cooker.py: the var cre maybe undefined
  cooker.py: fix for BBFILE_PATTERN matches bbappend

 lib/bb/cooker.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.7.4


