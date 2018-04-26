Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 31F7160102
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Apr 2018 06:09:32 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w3Q69X5d006336
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Apr 2018 23:09:33 -0700 (PDT)
Received: from ord-dlerner-d8.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Wed, 25 Apr 2018 23:09:32 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 26 Apr 2018 00:53:16 -0500
Message-ID: <cover.1524721541.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/1] toaster: add 'Sumo' to release selection
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
X-List-Received-Date: Thu, 26 Apr 2018 06:09:33 -0000
Content-Type: text/plain


NOTE: Update to "Sumo" for the Toaster release selection dialog. Keep "Rocko" available while "Sumo" stabilizes in the Layer Index and its contributed layers (append it as a release selection).


The following changes since commit da3625c52e1ab8985fba4fc3d133edf92142f182:

  build-appliance-image: Update to sumo head revision (2018-04-23 17:54:32 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/add_sumo_12713
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/add_sumo_12713

David Reyna (1):
  toaster: add 'Sumo' to release selection

 lib/toaster/orm/fixtures/oe-core.xml | 26 +++++++++---
 lib/toaster/orm/fixtures/poky.xml    | 76 +++++++++++++++++++++++++++++-------
 2 files changed, 82 insertions(+), 20 deletions(-)

-- 
2.11.0


