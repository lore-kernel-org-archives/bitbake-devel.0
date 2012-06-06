Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1ScD4h-0002lx-9R
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 12:02:47 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q569qICJ002830
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 6 Jun 2012 02:52:18 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Wed, 6 Jun 2012 02:52:17 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <dvhart@linux.intel.com>
Date: Wed, 6 Jun 2012 17:52:22 +0800
Message-ID: <cover.1338976258.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: [PATCH 0/6] V2 hob2: some tweak and add a standalone deploy image tool
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
X-List-Received-Date: Wed, 06 Jun 2012 10:02:47 -0000
Content-Type: text/plain

Hi Darren,

Thanks for your detailed reivew.

V2 update:
1. break up the commit about hig.py 
2. some text tweak 
3. remove the gtk version check
4. rename the standalone tool

V1:
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

Kang Kai (6):
  ui/crumbs/utils.py: import module bb
  ui/crumbs/hig.py: fix run time error
  ui/crumbs/hig.py: remove extra spaces
  ui/crumbs/hig.py: check deploy process return value
  hob2: update DeployImageDialog for seperated tool
  hob2: create a standalone deploy image tool

 bitbake/bin/image-writer          |  120 +++++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/hig.py   |   88 ++++++++++++++++++++++-----
 bitbake/lib/bb/ui/crumbs/utils.py |    1 +
 3 files changed, 194 insertions(+), 15 deletions(-)
 create mode 100755 bitbake/bin/image-writer

-- 
1.7.5.4



