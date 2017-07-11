Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5B35B7807C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 22:04:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6BM4aCO024558
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 15:04:37 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 11 Jul 2017 15:04:36 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Jul 2017 14:55:49 -0700
Message-ID: <cover.1499809423.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/3] toaster: cummulative 11072017 patch
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
X-List-Received-Date: Tue, 11 Jul 2017 22:04:36 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

This cumulative patch has the following fixes:
	9971  Toaster does not report progress while setscene tasks are running
	11727 trim build target input 
	11744 set clone progress default to off	


The following changes since commit 1501ab0c6ea7ed7a2565b8fdf95a6ade81c3b2f7:

  libiconv: remove 0001-Fix-link-error-when-compiling-with-gcc-O0.patch (2017-07-11 15:57:08 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_110717_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_110717_patch

David Reyna (3):
  toaster: include setscene in task progress
  toaster: set clone progress default to off
  toaster: trim build target input

 lib/toaster/orm/migrations/0016_clone_progress.py |  4 ++--
 lib/toaster/orm/models.py                         | 11 ++++++-----
 lib/toaster/toastergui/static/js/projecttopbar.js |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

-- 
1.9.1


