Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TGnvp-0000mE-QJ
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 11:29:26 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8Q9GYR3017567
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Sep 2012 02:16:34 -0700 (PDT)
Received: from usp-ub10.wrs.com (128.224.163.69) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 26 Sep 2012 02:16:34 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 26 Sep 2012 17:07:56 +0800
Message-ID: <cover.1348646054.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] fetch2: add "-d" option to cpio
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
X-List-Received-Date: Wed, 26 Sep 2012 09:29:26 -0000
Content-Type: text/plain

The following changes since commit a8edf79fce381d0433f18bd38df6cd74008e5179:

  bitbake: fetch2/git: Don't use deprecated API (2012-09-25 15:55:57 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/cpio
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/cpio

Robert Yang (1):
  fetch2: add "-d" option to cpio

 bitbake/lib/bb/fetch2/__init__.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)



