Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A60907814B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Feb 2018 04:44:45 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w1G4ikwb017901
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 20:44:47 -0800
Received: from dreyna-Precision-T5600.corp.ad.wrs.com (147.11.200.210) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 15 Feb 2018 20:44:32 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 15 Feb 2018 20:25:53 -0800
Message-ID: <cover.1518754951.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [147.11.200.210]
Subject: [PATCH 0/2] toaster: cummulative 021518 patch
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
X-List-Received-Date: Fri, 16 Feb 2018 04:44:46 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>


This patchset addresses two blocking issues for Toaster.


The following changes since commit f51f28b7b927fde9489e244cb812b562f28bbafa:

  icecc-create-env: Allow multiple tool aliases (2018-02-15 13:28:54 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_021518_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_021518_patch

David Reyna (2):
  toaster: do not fail on optional 'custom.xml' file
  Toaster: fix shutdown and extra threads

 bin/toaster                                                 | 4 ++--
 lib/toaster/bldcontrol/management/commands/checksettings.py | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.7.4


