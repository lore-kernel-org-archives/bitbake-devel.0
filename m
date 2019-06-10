Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9224C7E513
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2019 00:50:44 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x5A0oP2c007981
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 9 Jun 2019 17:50:35 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.225) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Sun, 9 Jun 2019 17:50:14 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 9 Jun 2019 17:48:17 -0700
Message-ID: <cover.1560127555.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.209.225]
Subject: [PATCH 0/1] [WARRIOR] toaster: Fix Thud Bitbake release for YP-2.7
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
X-List-Received-Date: Mon, 10 Jun 2019 00:50:44 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

For the Warrior release, this is to fix a broken bitbake vertion pointer for the thud branch. 
This is allow master Toaster to build Thud-based projects.

The following changes since commit 2fd4bf41a39f34075cfd42d46de1b0eea2ecc5eb:

  dbus-test: Improve ptest dependencies dependencies (2019-06-09 11:01:08 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/toaster/thud_bitbake_2_7_13356
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/toaster/thud_bitbake_2_7_13356

David Reyna (1):
  toaster: Fix Thud Bitbake release for YP-2.7

 lib/toaster/orm/fixtures/oe-core.xml | 2 +-
 lib/toaster/orm/fixtures/poky.xml    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1


