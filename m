Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8A40272CFD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 09:04:06 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.9) with ESMTP id t4I947Kf009978
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 02:04:07 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.224.2;
	Mon, 18 May 2015 02:04:07 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 May 2015 02:04:06 -0700
Message-ID: <cover.1431939814.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] fetch2/hg.py: add clean function
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
X-List-Received-Date: Mon, 18 May 2015 09:04:12 -0000
Content-Type: text/plain

The following changes since commit bc162d21dd148252efcf3ed771e04c791ef4d869:

  bitbake: tests/parse: Add file missing from previous commit (2015-05-16 22:40:44 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/hg
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/hg

Robert Yang (1):
  fetch2/hg.py: add clean function

 bitbake/lib/bb/fetch2/hg.py |    5 +++++
 1 file changed, 5 insertions(+)

-- 
1.7.9.5


