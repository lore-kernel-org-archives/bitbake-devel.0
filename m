Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 1D42D60761
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 08:50:20 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u9R8oIgk004777
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 01:50:18 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Thu, 27 Oct 2016 01:50:18 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 27 Oct 2016 01:50:17 -0700
Message-ID: <cover.1477557932.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Subject: [PATCH 0/1] lib/bb/cooker.py: fix for BBFILE_PATTERN = ""
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
X-List-Received-Date: Thu, 27 Oct 2016 08:50:21 -0000
Content-Type: text/plain

The following changes since commit e5815d0b607ff262663864d51fe51fbb37172329:

  build-appliance-image: Update to master head revision (2016-10-26 09:33:57 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/bbfile
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/bbfile

Robert Yang (1):
  lib/bb/cooker.py: fix for BBFILE_PATTERN = ""

 bitbake/lib/bb/cooker.py | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.9.0


