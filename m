Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C295272F94
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Apr 2017 07:22:13 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v357MDER009181
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 5 Apr 2017 00:22:14 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.216.91) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 5 Apr 2017 00:22:12 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Apr 2017 00:12:38 -0700
Message-ID: <cover.1491374730.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.216.91]
Subject: [PATCH 0/1] toaster: toastergui: implement machine name validation
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
X-List-Received-Date: Wed, 05 Apr 2017 07:22:14 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

This prevents improperly entered machine names in Toaster UI.

The following changes since commit eff56e4f0d59b1d965a68e4f009b7f07717b7edd:

  bitbake: bitbake-user-manual: Fixed special character in -D output (2017-04-03 22:32:02 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/abelal/toaster/implement-machine-name-8721
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/abelal/toaster/implement-machine-name-8721

Belal, Awais (1):
  toaster: toastergui: implement machine name validation

 lib/toaster/toastergui/static/js/projectpage.js | 17 +++++++++++++++++
 lib/toaster/toastergui/templates/project.html   |  3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
1.9.1


