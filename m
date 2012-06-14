Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sf7Ay-0000um-6I
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 12:21:16 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5EAAbIQ008692
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jun 2012 03:10:37 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 14 Jun 2012 03:10:37 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Jun 2012 18:10:55 +0800
Message-ID: <cover.1339653356.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/3] Update for Yocto 2388
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
X-List-Received-Date: Thu, 14 Jun 2012 10:21:16 -0000
Content-Type: text/plain

Hi,

These are 3 updates of 
Yocto 2388: [Hob] Separate the hob image writer into a separate application
Two of them are strings update, and the other one is for simplify code.

Regards,
Kai

The following changes since commit 5ed855d12cddf2de535c3f6d05d3dfe85d69d99d:

  openjade-native: Ensure we reautoconf the package (2012-06-12 16:34:30 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib kangkai/distro
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/distro

Kang Kai (3):
  ui/crumbs/hig.py: tweak strings
  ui/crumbs/hig.py: simplify subprocess call
  image-writer: tweak some strings

 bitbake/bin/image-writer        |   10 +++++-----
 bitbake/lib/bb/ui/crumbs/hig.py |   17 +++++++++++------
 2 files changed, 16 insertions(+), 11 deletions(-)

-- 
1.7.5.4



