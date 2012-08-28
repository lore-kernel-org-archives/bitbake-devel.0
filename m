Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1T6C1Y-0004Uj-DM
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Aug 2012 04:59:28 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7S2lDYn028624
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 27 Aug 2012 19:47:13 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.309.2; Mon, 27 Aug 2012 19:47:12 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Tue, 28 Aug 2012 10:47:18 +0800
Message-ID: <cover.1346121294.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/3 V2] hob2: remove hard-coded image types map
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
X-List-Received-Date: Tue, 28 Aug 2012 02:59:29 -0000
Content-Type: text/plain

Hi Richard,

This is V2 for Yocto 2795.

Just add variable IMAGE_EXTENSION_live as you suggest, other image types are the same with the real image name extension names.

Add update the hob code accordingly.

Regards,
Kai

The following changes since commit b4c5725af4cd85d5644f0373e2674e903c4eab2b:

  yocto-bsp: add missing xserver-xf86-config .bbappend for qemu (2012-08-25 14:47:07 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib kangkai/hob2
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/hob2

Kang Kai (3):
  hob2: remove the hard-coded images map
  hob2: remove class hcc
  image_types.bbclass: add variable for Hob

 bitbake/lib/bb/ui/crumbs/builder.py         |   24 ++++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/hig.py             |   11 +++++++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    1 -
 bitbake/lib/bb/ui/crumbs/hobwidget.py       |   29 ---------------------------
 meta/classes/image_types.bbclass            |    3 ++
 5 files changed, 31 insertions(+), 37 deletions(-)

-- 
1.7.5.4



