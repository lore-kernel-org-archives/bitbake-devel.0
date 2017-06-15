Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6690C78245
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 05:03:10 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v5F53Cvc004678
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 22:03:12 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.200.76) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 14 Jun 2017 22:03:11 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Jun 2017 21:54:26 -0700
Message-ID: <cover.1497502344.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.200.76]
Subject: [PATCH 0/1] toaster: last build id call
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
X-List-Received-Date: Thu, 15 Jun 2017 05:03:11 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Many calls to "get_last_build_id" were missing the "()" in several calls, and 
were previously failing silently.

The following changes since commit 6964efddd31c479386d1643c1025bc102710392f:

  bitbake: cooker: ensure graceful exit after exception during BuildCompleted handler (2017-06-14 14:54:25 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/bdreyna/toaster/get_last_build_id_11570
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/bdreyna/toaster/get_last_build_id_11570

David Reyna (1):
  toaster: get_last_build_id not called correctly

 lib/toaster/orm/models.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1


