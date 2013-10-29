Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 21B926D10F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Oct 2013 06:23:04 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r9T6N5Dd009078
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Oct 2013 23:23:05 -0700 (PDT)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.347.0;
	Mon, 28 Oct 2013 23:23:04 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 29 Oct 2013 22:24:30 +0800
Message-ID: <cover.1383056532.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Subject: [PATCH 0/1] bb/fetch2: fix the "filename too long" error
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
X-List-Received-Date: Tue, 29 Oct 2013 06:23:05 -0000
Content-Type: text/plain

The following changes since commit 78b91ab23d9856525fc7ac1bb8da2975382813bf:

  pigz: bump to 2.3.1 (2013-10-26 16:08:41 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/name_max
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/name_max

Robert Yang (1):
  bb/fetch2: fix the "filename too long" error

 bitbake/lib/bb/fetch2/__init__.py | 18 ++++++++++++++++++
 bitbake/lib/bb/fetch2/bzr.py      |  2 ++
 bitbake/lib/bb/fetch2/git.py      |  6 ++++++
 bitbake/lib/bb/fetch2/hg.py       |  3 +++
 bitbake/lib/bb/fetch2/osc.py      |  2 ++
 bitbake/lib/bb/fetch2/repo.py     |  4 ++++
 bitbake/lib/bb/fetch2/svk.py      |  2 ++
 bitbake/lib/bb/fetch2/svn.py      |  3 +++
 8 files changed, 40 insertions(+)

-- 
1.8.3.1


