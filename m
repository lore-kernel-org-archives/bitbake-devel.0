Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3F97F770EF
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Apr 2016 10:35:51 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u35AZpFW014892
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 5 Apr 2016 03:35:52 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Tue, 5 Apr 2016 03:35:51 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 5 Apr 2016 03:35:50 -0700
Message-ID: <cover.1459852436.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Subject: [PATCH 0/1] fetch2/git.py: remove .indirectiondir workaround
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
X-List-Received-Date: Tue, 05 Apr 2016 10:35:53 -0000
Content-Type: text/plain

The following changes since commit af5f423887d1c41cf7279f6e537077726ae13082:

  bitbake: siggen: Ensure tainted stamps are accounted for with writing custom stamps (2016-04-03 22:50:17 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/git
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/git

Robert Yang (1):
  fetch2/git.py: remove .indirectiondir workaround

 bitbake/lib/bb/fetch2/git.py | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

-- 
2.8.0


