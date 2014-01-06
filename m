Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 45ADD60D2D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2014 09:52:38 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s069qcqJ020440
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 6 Jan 2014 01:52:38 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Mon, 6 Jan 2014 01:52:38 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 6 Jan 2014 04:52:34 -0500
Message-ID: <cover.1389001793.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH 0/2] bitbake: fix the task flags cleandirs
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
X-List-Received-Date: Mon, 06 Jan 2014 09:52:40 -0000
Content-Type: text/plain

The following changes since commit c062a4971023c246c15af622d3c251e7adeb0d99:

  fetch2/__init__.py: let try_mirror_url return correct value (2014-01-06 01:04:23 -0500)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/fetch
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/fetch

Robert Yang (2):
  bitbake/lib/bb/build.py: fix the task flags cleandirs
  bitbake: usermanual.xml: fix a typo

 bitbake/doc/manual/usermanual.xml |    2 +-
 bitbake/lib/bb/build.py           |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.7.10.4


