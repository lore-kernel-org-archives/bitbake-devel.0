Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1Szeeg-00031a-BT
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Aug 2012 04:08:50 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7A1v191023176
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Aug 2012 18:57:01 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.124) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Thu, 9 Aug 2012 18:56:59 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 Aug 2012 10:02:29 +0800
Message-ID: <cover.1344564039.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] bitbake.conf: add BB_STAMPS_DIR for constructing STAMP
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
X-List-Received-Date: Fri, 10 Aug 2012 02:08:50 -0000
Content-Type: text/plain

The following changes since commit 5290e82ecef08b5e573d7442627276d7b42c6b93:

  foomatic: fix perl path for target (2012-08-08 10:05:52 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/stampsdir
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/stampsdir

Robert Yang (1):
  bitbake.conf: add BB_STAMPS_DIR for constructing STAMP

 meta/conf/bitbake.conf       | 3 ++-
 scripts/oe-buildenv-internal | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.7.11.2



