Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1UD7Hf-0003rL-Ik
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Mar 2013 06:53:01 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r265aSVm004941
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 5 Mar 2013 21:36:28 -0800 (PST)
Received: from pek-usp-13.wrs.com (128.224.163.69) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.342.3;
	Tue, 5 Mar 2013 21:36:28 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Mar 2013 13:36:22 +0800
Message-ID: <cover.1362545842.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Cc: qingtao.cao@windriver.com
Subject: [PATCH 0/1] bitbake-layers: fix duplicated help info
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
X-List-Received-Date: Wed, 06 Mar 2013 05:53:02 -0000
Content-Type: text/plain

The following changes since commit 6663b79452bcdd95fc69e1ec853baae6c5297ab2:

  libpcap: fix description variable (2013-03-05 18:00:34 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/bbl_help
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/bbl_help

Robert Yang (1):
  bitbake-layers: fix duplicated help info

 bitbake/bin/bitbake-layers |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)



