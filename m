Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 1B4C27C1AB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Jan 2019 06:12:22 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0G6CO3A000645
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 22:12:24 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Tue, 15 Jan 2019 22:12:24 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Jan 2019 14:30:40 +0800
Message-ID: <cover.1547620210.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/2] bb: siggen: 2 fixes
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
X-List-Received-Date: Wed, 16 Jan 2019 06:12:23 -0000
Content-Type: text/plain

The following changes since commit 1ee53881eea3a7ca4d4f6a5ca9c4c6e6488d2348:

  perl: fix yet another race failure (2019-01-14 17:38:24 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/siggen
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/siggen

Robert Yang (2):
  bb: siggen: Add a prefix for uuid4
  bb: siggen: Print more info when basehash are mis-matched

 bitbake/lib/bb/build.py  | 2 +-
 bitbake/lib/bb/siggen.py | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.7.4


