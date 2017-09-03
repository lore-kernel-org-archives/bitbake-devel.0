Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 709D960602
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  3 Sep 2017 05:32:14 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v835WDeZ012117
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Sat, 2 Sep 2017 22:32:13 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sat, 2 Sep 2017 22:32:12 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 2 Sep 2017 22:23:55 -0700
Message-ID: <cover.1504416112.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Cc: Olaf Mandel <o.mandel@menlosystems.com>
Subject: [PATCH 0/4] toaster: cummulative 30082017 patch
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
X-List-Received-Date: Sun, 03 Sep 2017 05:32:15 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Cummulative Toaster patches. No new files.

The following changes since commit ee5bce2d11e783c0921df47b629025a6b67c44bf:

  kernel-dev: Removed bad reference for creating patches. (2017-09-02 00:52:49 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_300817_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_300817_patch

Awais Belal (1):
  toaster: Order column in Tasks selectable

David Reyna (1):
  toaster: display error when the fstype select is empty

Olaf Mandel (2):
  toaster: debug message for lists layers missing separators
  toaster: set default pokydirname if no external layers

 lib/toaster/bldcontrol/localhostbecontroller.py   | 6 +++++-
 lib/toaster/toastergui/buildtables.py             | 3 +++
 lib/toaster/toastergui/templates/projectconf.html | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
1.9.1


