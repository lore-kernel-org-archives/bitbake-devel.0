Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 66C95774FC
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Sep 2017 04:58:54 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v884wtmm007546
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 7 Sep 2017 21:58:55 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 7 Sep 2017 21:58:54 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 7 Sep 2017 21:50:17 -0700
Message-ID: <cover.1504845976.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/2] toaster: cummulative 07092017 patch
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
X-List-Received-Date: Fri, 08 Sep 2017 04:58:55 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Fix a Medium+ and a High defect/required action. There are no new files.

The following changes since commit 8b4f16a9cbbaf521461f699b7264fac2ac872581:

  mesa-gl: Fix build after recent mesa PACKAGECONFIG changes (2017-09-05 15:01:02 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_070917_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_070917_patch

David Reyna (2):
  toaster: handle early exceptions
  toaster: update pyro to rocko as stable release

 .../bldcontrol/management/commands/runbuilds.py        |  8 ++++++++
 lib/toaster/orm/fixtures/oe-core.xml                   | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml                      | 18 +++++++++---------
 3 files changed, 23 insertions(+), 15 deletions(-)

-- 
1.9.1


