Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id B3DA47D2F2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 11:02:57 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3HB2CoT015326
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 04:02:48 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Wed, 17 Apr 2019 04:02:34 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Apr 2019 19:01:48 +0800
Message-ID: <cover.1555498609.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/3 V2] bb: siggen: Make dump_sigfile and compare_sigfiles print uuid4
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
X-List-Received-Date: Wed, 17 Apr 2019 11:02:57 -0000
Content-Type: text/plain

* V2
  - Tweak the output of diffsigs/dumpsigs to print uuid4 which makes it easier
    for debugging.
  - Add another commit "bitbake-diffsigs: Use 4 spaces as indent for recursecb"

* V1
  - Initial version

The following changes since commit c23c8ebc7f66a92110bfc9e3c4d633a432d1353b:

  core-image-sato-sdk-ptest: Try and keep image below 4GB limit (2019-04-16 11:10:02 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/sigs
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/sigs

Robert Yang (3):
  bitbake-diffsigs: Use 4 spaces as indent for recursecb
  bb: siggen: Make dump_sigfile and compare_sigfiles print uuid4
  bb: siggen: Print more info when basehash are mis-matched

 bitbake/bin/bitbake-diffsigs |  2 +-
 bitbake/lib/bb/runqueue.py   |  2 +-
 bitbake/lib/bb/siggen.py     | 16 +++++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.7.4


