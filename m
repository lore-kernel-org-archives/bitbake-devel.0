Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id BDAF37C37F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2019 10:01:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x3PA1aAY006699
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2019 03:01:36 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 25 Apr 2019 03:01:35 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 25 Apr 2019 18:00:58 +0800
Message-ID: <cover.1556186399.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/2] Fixes for addtask and deltask
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
X-List-Received-Date: Thu, 25 Apr 2019 10:01:35 -0000
Content-Type: text/plain

The following changes since commit 7f7a7cba4dcd99d7b36a0d747bfd1bba3f9c2288:

  bitbake: bb: siggen: Print more info when basehash are mis-matched (2019-04-23 23:30:45 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/addtask
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/addtask

Robert Yang (2):
  bitbake: BBHandler: Fix addtask and deltask
  bitbake: build.py: check dependendent task for addtask

 bitbake/lib/bb/build.py                    |  3 +++
 bitbake/lib/bb/parse/parse_py/BBHandler.py | 25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.7.4


