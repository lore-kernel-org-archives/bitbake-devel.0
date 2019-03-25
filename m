Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id DAB957D078
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Mar 2019 07:51:54 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2P7pZef029977
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Mar 2019 00:51:45 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Mon, 25 Mar 2019 00:51:24 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Mar 2019 16:10:56 +0800
Message-ID: <cover.1553501143.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/2 v2] fetch2: Unify BB_FETCH_PREMIRRORONLY
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
X-List-Received-Date: Mon, 25 Mar 2019 07:51:55 -0000
Content-Type: text/plain

* V2
  - Use bb.utils.to_boolean() for BB_FETCH_PREMIRRORONLY as RP suggested.
  - Use bb.utils.to_boolean() for BB_NO_NETWORK.
  - We also need use bb.utils.to_boolean() for oe-core's BB_NO_NETWORK, will
    fix it later.

* V1
  - Initial version

The following changes since commit acc242c7ec20a74e1afcc2420f5e2981e843b0df:

  bitbake: fetch2: Print SCMs list when SRCREV_FORMAT is not set (2019-03-24 17:01:34 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/premirror
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/premirror

Robert Yang (2):
  fetch2: Unify BB_FETCH_PREMIRRORONLY
  fetch2: Use bb.utils.to_boolean() for BB_NO_NETWORK

 bitbake/lib/bb/fetch2/__init__.py | 6 +++---
 bitbake/lib/bb/fetch2/git.py      | 2 +-
 bitbake/lib/bb/fetch2/hg.py       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4


