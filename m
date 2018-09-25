Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 23E7378D34
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 15:07:10 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8PF7Alk021813
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 08:07:11 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 25 Sep 2018 08:07:09 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Sep 2018 11:07:05 -0400
Message-ID: <20180925150708.2983-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH 0/3] Fix bitbake-selftest failures
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
X-List-Received-Date: Tue, 25 Sep 2018 15:07:10 -0000
Content-Type: text/plain

The original purpose of this work is to fix the Yocto Project bug 12928.

https://bugzilla.yoctoproject.org/show_bug.cgi?id=12928

During that work it was noticed that parse.py was running chdir without
restoring the original path.  Also the layerindexlib cooker test was
using __file__ without fully sanitizing it, so due to the prior issue
it could fail to load the test-case data.

The patch set is availabe on bitbake-contrib on the mgh/12928 branch.

Mark Hatle (3):
  lib/bb/tests/parse.py: Test case was changing chdir
  lib/layerindexlib/tests/cooker.py: Fix topdir to use an absolute
    (real) path
  lib/layerindexlib/tests/restapi.py: Fix test cases when
    BB_SKIP_NETTETS=yes

 lib/bb/tests/parse.py              |   4 +
 lib/layerindexlib/tests/cooker.py  |   2 +-
 lib/layerindexlib/tests/restapi.py | 164 ++++++++++++++++++++-----------------
 3 files changed, 92 insertions(+), 78 deletions(-)

-- 
1.8.3.1


