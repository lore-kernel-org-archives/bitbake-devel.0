Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id D9C157D284
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 09:12:50 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x3H9CpU8017074
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 02:12:51 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.92) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 17 Apr 2019 02:12:51 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Apr 2019 02:10:38 -0700
Message-ID: <cover.1555492152.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.209.92]
Subject: [PATCH 0/1] toaster: warrior_branch_13287
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
X-List-Received-Date: Wed, 17 Apr 2019 09:12:51 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

This patch prepares Toaster for the official Warrior release, removing the older Sumo.

The following changes since commit c23c8ebc7f66a92110bfc9e3c4d633a432d1353b:

  core-image-sato-sdk-ptest: Try and keep image below 4GB limit (2019-04-16 11:10:02 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/warrior_branch_13287
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/warrior_branch_13287

David Reyna (1):
  toaster: update to Warrior

 lib/toaster/orm/fixtures/oe-core.xml | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml    | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
1.9.1


