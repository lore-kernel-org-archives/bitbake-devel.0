Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5D31D7DEA7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 May 2019 08:03:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x4983O8j007536
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 May 2019 01:03:25 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 9 May 2019 01:03:24 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 9 May 2019 16:03:02 +0800
Message-ID: <cover.1557388944.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: cookerdata: Avoid double exceptions for bb.fatal()
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 09 May 2019 08:03:24 -0000
Content-Type: text/plain

The following changes since commit c0dc72bad92e2e4dc0aedb48b969709f821baf73:

  coreutils: Fix patch upstream status field (2019-05-08 23:36:21 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/python
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/python

Robert Yang (1):
  bitbake: cookerdata: Avoid double exceptions for bb.fatal()

 bitbake/lib/bb/cookerdata.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.7.4


