Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1T4qAa-00065w-BF
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Aug 2012 11:27:12 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7O9F2ma028538
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 24 Aug 2012 02:15:02 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.309.2; Fri, 24 Aug 2012 02:15:01 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Fri, 24 Aug 2012 17:15:08 +0800
Message-ID: <cover.1345799414.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/3] hob2: remove hard-coded image types map
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
X-List-Received-Date: Fri, 24 Aug 2012 09:27:12 -0000
Content-Type: text/plain

Hi Richard,

This is for Yocto 2795.
Read from a new variable IMAGE_TYPES_MAP to get the map. Add the IMAGE_TYPES_MAP to bitbake.conf.
The format of IMAGE_TYPES_MAP is:
"image_type1:realname_extend1 image_type2:realname_extend2,extend3 ..."


Regards,
Kai

The following changes since commit 054d95edad8d79ef1c6b30681395d50f3c6335b4:

  poky.conf: restore Ubuntu 12.04 LTS to tested distro list (2012-08-23 17:23:40 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib kangkai/hob2
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/hob2

Kang Kai (3):
  hob2: remove the hard-coded images map
  hob2: remove class hcc
  bitbake.conf: add variable IMAGE_TYPES_MAP

 bitbake/lib/bb/ui/crumbs/builder.py         |   35 +++++++++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/hig.py             |    9 ++++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    4 ++-
 bitbake/lib/bb/ui/crumbs/hobwidget.py       |   29 ----------------------
 meta/conf/bitbake.conf                      |    3 ++
 5 files changed, 43 insertions(+), 37 deletions(-)

-- 
1.7.5.4



