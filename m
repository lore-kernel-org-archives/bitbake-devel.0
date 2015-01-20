Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 958227229E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jan 2015 07:29:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t0K7THEN011377
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Jan 2015 23:29:17 -0800 (PST)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.174.1;
	Mon, 19 Jan 2015 23:29:16 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 19 Jan 2015 23:29:15 -0800
Message-ID: <cover.1421738928.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] cooker.py: trap the ENOSPC error and translate it
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
X-List-Received-Date: Tue, 20 Jan 2015 07:29:17 -0000
Content-Type: text/plain

The following changes since commit d9d5b8b499af3ae01a1e33d0d3969c54c2d4ab1b:

  depmodwrapper-cross: Update to use STAGING_KERNEL_BUILDDIR (2015-01-17 17:05:45 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/enospc
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/enospc

Robert Yang (1):
  cooker.py: trap the ENOSPC error and translate it

 bitbake/lib/bb/cooker.py |    5 +++++
 1 file changed, 5 insertions(+)

-- 
1.7.9.5


