Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1C9E76BBDA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Sep 2013 13:47:25 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r82DlOR4005680
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Sep 2013 06:47:26 -0700 (PDT)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.2.342.3; Mon, 2 Sep 2013 06:47:24 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 2 Sep 2013 09:47:20 -0400
Message-ID: <cover.1378129369.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH 0/1] check whether multiple versions of the same PN are due
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
X-List-Received-Date: Mon, 02 Sep 2013 13:47:25 -0000
Content-Type: text/plain

This is used for fixing such a race issue:

$ bitbake make-3.81 make-3.82

There would be unexpected errors in the past, now, it will print the error
message and exit:

ERROR: Multiple .bb files are due to be built which each provide make (xxx)
 This usually means one provides something the other doesn't and should.
ERROR: Multiple versions of make are due to be built.

Summary: There were 2 ERROR messages shown, returning a non-zero exit code.

// Robert

The following changes since commit c7994f83baa678a4670472e1f037bfc16cb1e3be:

  bitbake: runqueue: Fix scenequeue to pass file descriptors, not a float (2013-09-02 09:16:24 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/same_pn
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/same_pn

Robert Yang (1):
  runqueue.py: check whether multiple versions of the same PN are due to be built

 bitbake/lib/bb/runqueue.py |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
1.7.10.4


