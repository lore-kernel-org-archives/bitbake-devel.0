Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 05A1060745
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jun 2016 02:42:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u5F2gBnX021847
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 19:42:11 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Tue, 14 Jun 2016 19:42:10 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 14 Jun 2016 19:42:09 -0700
Message-ID: <cover.1465958474.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Subject: [PATCH 0/1] lib/bb/build.py: remove task flag in deltask()
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
X-List-Received-Date: Wed, 15 Jun 2016 02:42:13 -0000
Content-Type: text/plain

The following changes since commit 71765a90d1ff455608a006ed32cf42110e779217:

  bitbake: cooker.py: fix warn() -> warning() (2016-06-13 12:16:10 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/deltask
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/deltask

Robert Yang (1):
  lib/bb/build.py: remove task flag in deltask()

 bitbake/lib/bb/build.py | 1 +
 1 file changed, 1 insertion(+)

-- 
2.8.0


