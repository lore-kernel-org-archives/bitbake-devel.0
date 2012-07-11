Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Wenzong.Fan@windriver.com>) id 1Sor4q-0008Kn-Jl
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jul 2012 09:11:12 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6B3SDQ1026930
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 20:28:13 -0700 (PDT)
Received: from wenzong-desktop.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Tue, 10 Jul 2012 20:28:12 -0700
From: <wenzong.fan@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 11 Jul 2012 11:28:10 +0800
Message-ID: <cover.1341977062.git.wenzong.fan@windriver.com>
X-Mailer: git-send-email 1.7.3
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: Abort build if runtime dependency conflict
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 11 Jul 2012 07:11:13 -0000
Content-Type: text/plain

From: Wenzong Fan <wenzong.fan@windriver.com>

If found any runtime dependency conflict from PREFERRED_PROVIDER entries,
bitbake will print an ERROR and let the build go on.
 
This is a little confusion for a long time build, it should be abort
immediately while an ERROR occured.

The following changes since commit 5142a1e95ed7db7e09ef31f645d45bb7e380d1d6:

  subversion: do_install failed (parallel issue) (2012-07-10 20:35:11 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib wenzong/2734
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=wenzong/2734

Wenzong Fan (1):
  bitbake: Abort build if runtime dependency conflict

 bitbake/lib/bb/providers.py |    2 ++
 bitbake/lib/bb/taskdata.py  |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

-- 
1.7.3



