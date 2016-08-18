Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A8956731A5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 08:26:15 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u7I8QFNB004521
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 01:26:15 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Thu, 18 Aug 2016 01:26:13 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 18 Aug 2016 01:26:12 -0700
Message-ID: <cover.1471508749.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Subject: [PATCH 0/1] dump_cache.py: use python3 as interpreter
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
X-List-Received-Date: Thu, 18 Aug 2016 08:26:17 -0000
Content-Type: text/plain

The following changes since commit 9800b4d9ffda22466066ab1d301e4730e61726e0:

  oeqa.buildperf: use oe.path.remove() (2016-08-17 10:35:44 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/dump
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/dump

Robert Yang (1):
  dump_cache.py: use python3 as interpreter

 bitbake/contrib/dump_cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.0


