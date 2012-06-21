Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1ShXID-0004rf-UK
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 04:38:46 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5L2RxTM003870
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 19:27:59 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Wed, 20 Jun 2012 19:27:59 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Jun 2012 10:28:53 +0800
Message-ID: <cover.1340179047.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] print which pkgs would be built
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
X-List-Received-Date: Thu, 21 Jun 2012 02:38:46 -0000
Content-Type: text/plain

Hi Paul,

This is for:

* The ability to know what pkgs will be *compiled* for a given image. 

For the "installed" part, use the core-image-sato as an example, which
will install 395 rpm binary pkgs:

Note:
The following ones has filtered out the "-dev/-dbg/-staticdev/-natives":

1) If we only grab the RDEPENDS, there are only 342 pkgs, which is less
than 395

2) If we grab both the RDEPENDS and RRECOMMENDS, there are 476 pkgs,
which is more than 395

The problem is that there is a RCONFLICTS, the RRECOMMENDS and
RCONFLICTS will be used by the package manager to determine which pkg
would be installed, this makes it hard to predict the pkg that will be
installed.

// Robert

The following changes since commit e0a70547069fe7e8a2d6bdaffc985fb172d46c31:

  perl: Allow perl to cross build and native build in a directory named "t" (2012-06-18 17:33:04 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/buildlist
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/buildlist

Robert Yang (1):
  print which pkgs would be built

 bitbake/bin/bitbake      |    2 +-
 bitbake/lib/bb/cooker.py |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)



