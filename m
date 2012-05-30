Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SZg9G-0005wy-U8
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 12:29:03 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4UAIgRP006054
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 May 2012 03:18:43 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Wed, 30 May 2012 03:18:42 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 May 2012 18:19:07 +0800
Message-ID: <cover.1338367258.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] HOB: 'str' object has no attribute 'close'
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
X-List-Received-Date: Wed, 30 May 2012 10:29:03 -0000
Content-Type: text/plain

Hi Shane,
  The "run qemu" and "deploy image" works correctly now, and doesn't hang.

// Robert

The following changes since commit f28209d9d3c67203a2c7a2b25cacfe31643d1bfa:

  cooker.py: terminate the Parser processes (2012-05-25 11:39:33 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/hob
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/hob

Robert Yang (1):
  HOB: 'str' object has no attribute 'close'

 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    7 +++----
 bitbake/lib/bb/ui/crumbs/hig.py              |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)



