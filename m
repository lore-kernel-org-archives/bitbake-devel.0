Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sbkk8-0003tk-5w
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 05:47:40 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q553bAIX021738
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 4 Jun 2012 20:37:12 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Mon, 4 Jun 2012 20:37:09 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <dvhart@linux.intel.com>
Date: Tue, 5 Jun 2012 11:37:10 +0800
Message-ID: <cover.1338866958.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: [PATCH 0/2] hob2: add a standalone deploy image tool
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
X-List-Received-Date: Tue, 05 Jun 2012 03:47:40 -0000
Content-Type: text/plain

Hi,

These 2 patches try to add a standalone deploy image tool using current codes. 
It should be launched by run the absolute path to bitbake/bin/bitbake-deployimage,
I'll add a shell script to wrap it under script directory.

Regards,
Kai

The following changes since commit de4cdfd6bc1280ac7ac0559b87734d26294ef773:

  documentation/kernel-manual/kernel-how-to.xml: Updated to kernel 3.4 (2012-05-31 21:16:55 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib kangkai/distro
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/distro

Kang Kai (2):
  hob2: update DeployImageDialog for seperated tool
  hob2: create a standalone deploy image tool

 bitbake/bin/bitbake-deployimage   |  135 +++++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/hig.py   |   82 +++++++++++++++++++----
 bitbake/lib/bb/ui/crumbs/utils.py |    1 +
 3 files changed, 204 insertions(+), 14 deletions(-)
 create mode 100755 bitbake/bin/bitbake-deployimage

-- 
1.7.5.4



