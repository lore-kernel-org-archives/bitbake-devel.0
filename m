Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 21B48731DA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 08:53:16 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u0M8rHB0021251
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 00:53:17 -0800 (PST)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Fri, 22 Jan 2016 00:53:16 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jan 2016 00:53:15 -0800
Message-ID: <cover.1453452762.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] taskdata.py: add RuntimeProviders to close matches
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
X-List-Received-Date: Fri, 22 Jan 2016 08:53:18 -0000
Content-Type: text/plain

The following changes since commit b80219eac1695044554c18994124ae32c04642c6:

  udev: Add 2 patches to support 4.4 kernel (2016-01-20 17:07:16 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/rprovides
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/provides

Robert Yang (1):
  taskdata.py: add RuntimeProviders to close matches

 bitbake/lib/bb/taskdata.py |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
1.7.9.5


