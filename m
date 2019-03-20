Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id C47947CD7D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Mar 2019 06:21:53 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2K6LXr0013270
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 23:21:43 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Tue, 19 Mar 2019 23:21:22 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Mar 2019 14:40:49 +0800
Message-ID: <cover.1553063929.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/2] fetch2: Unify BB_FETCH_PREMIRRORONLY
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
X-List-Received-Date: Wed, 20 Mar 2019 06:21:53 -0000
Content-Type: text/plain

The following changes since commit 753e2a0ede4449917c75353b57f13bbafe70fac8:

  build-appliance-image: Update to master head revision (2019-03-19 23:56:29 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/premirror
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/premirror

Robert Yang (2):
  fetch2: runfetchcmd(): Print workdir in debug message
  fetch2: Unify BB_FETCH_PREMIRRORONLY

 bitbake/lib/bb/fetch2/__init__.py | 5 ++++-
 bitbake/lib/bb/fetch2/git.py      | 2 +-
 bitbake/lib/bb/fetch2/hg.py       | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.7.4


