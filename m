Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id F1E1460053
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 05:22:20 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v3A5MKgJ018635
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 9 Apr 2017 22:22:21 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.216.91) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Sun, 9 Apr 2017 22:22:20 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 9 Apr 2017 22:12:46 -0700
Message-ID: <cover.1491801105.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.216.91]
Subject: [PATCH 0/1] toaster: fix SDK artifact capture
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
X-List-Received-Date: Mon, 10 Apr 2017 05:22:21 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

"toaster: fix add layer button for Machines". Tested on Firefox and Chrome.


The following changes since commit 633ad6c9f436f5d2b6ee1a005b697661a054a394:

  oeqa/runtime/utils/targetbuildproject: use parent classes defaults tmpdir (2017-04-06 10:13:39 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/add_layers_machine_11213
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/add_layers_machine_11213

David Reyna (1):
  toaster: fix add layer button for Machines

 lib/toaster/toastergui/templates/machine_btn.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1


