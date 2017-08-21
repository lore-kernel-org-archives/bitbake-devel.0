Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 80E0C7822A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 01:10:01 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v7L1A2tC031546
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Aug 2017 18:10:02 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sun, 20 Aug 2017 18:10:01 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 20 Aug 2017 18:01:36 -0700
Message-ID: <cover.1503276918.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/2] toaster: cummulative 20082017 patch
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
X-List-Received-Date: Mon, 21 Aug 2017 01:10:01 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>


This is a summulative patch for Toaster for M3

WARNING: there is a new file added with this patch:
  .../orm/fixtures/custom_toaster_append.sh_sample

1) 0001-toaster-custom-image-updates-and-original-creation.patch

This fixes an issue modifying custom images, specifically around
the dependent packages.

2) 0002-Toaster-custom-start-and-stop-actions.patch

This enables customers and commercial partners to add custom 
actions when Toaster is started and stopped. A specific usage
is to enable 'anspass" servers for git repositories that are
behind name/password protection.


The following changes since commit 04dc76713b57f28457742dd863caa663591d4866:

  devtool/copy_buildsystem: adds meta-skeleton layer in the eSDK installation. (2017-08-19 22:15:39 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_200817_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_200817_patch

David Reyna (2):
  toaster: custom image updates and original creation
  Toaster: custom start and stop actions

 bin/toaster                                        | 22 ++++-
 .../orm/fixtures/custom_toaster_append.sh_sample   | 49 +++++++++++
 lib/toaster/orm/models.py                          |  2 +-
 lib/toaster/toastergui/api.py                      | 98 ++++++++++++++--------
 4 files changed, 131 insertions(+), 40 deletions(-)
 create mode 100755 bitbake/lib/toaster/orm/fixtures/custom_toaster_append.sh_sample

-- 
1.9.1


