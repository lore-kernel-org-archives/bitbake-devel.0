Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id D49777DA5D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Apr 2019 08:12:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3T8BqY0011249
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Apr 2019 01:12:41 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Mon, 29 Apr 2019 01:12:31 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 Apr 2019 16:11:57 +0800
Message-ID: <cover.1556525357.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH V2 0/3] Fixes for addtask and deltask
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
X-List-Received-Date: Mon, 29 Apr 2019 08:12:51 -0000
Content-Type: text/plain

* V2:
  - Fix RP's comments on V1
  - Add testcase for addtask and deltask

* V1:
  - Initial version

The following changes since commit 244cbcce0ecc4691a9ddfb0a44dc487ff7af0670:

  utils/multiprocess_launch: Improve failing subprocess output (2019-04-26 10:09:08 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/addtask
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/addtask

Robert Yang (3):
  bitbake: BBHandler: Fix addtask and deltask
  bitbake: build.py: check dependendent task for addtask
  bitbake: tests/parse.py: Add testcase for addtask and deltask

 bitbake/lib/bb/build.py                    |  3 +++
 bitbake/lib/bb/parse/parse_py/BBHandler.py | 18 +++++++++++++++++-
 bitbake/lib/bb/tests/parse.py              | 18 ++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.7.4


