Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 43C287036E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Aug 2014 09:07:41 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id s7J97gln016777
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Aug 2014 02:07:42 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.174.1;
	Tue, 19 Aug 2014 02:07:41 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Aug 2014 02:07:40 -0700
Message-ID: <cover.1408439224.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] fetch2/__init__.py: remove broken sysmlink
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
X-List-Received-Date: Tue, 19 Aug 2014 09:07:43 -0000
Content-Type: text/plain

The following changes since commit 201af937a0a45dd0203b1a4a00cffa7a24a31c20:

  newbb.vim: remove PR (2014-08-18 17:30:25 -0700)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/dl
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/dl

Robert Yang (1):
  fetch2/__init__.py: remove broken sysmlink

 bitbake/lib/bb/fetch2/__init__.py |    5 +++++
 1 file changed, 5 insertions(+)

-- 
1.7.9.5


