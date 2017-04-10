Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A1A4D77C6F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 13:39:17 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v3ADdIW0015836
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 06:39:19 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.216.91) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Mon, 10 Apr 2017 06:39:17 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 10 Apr 2017 06:29:43 -0700
Message-ID: <cover.1491830925.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.216.91]
Subject: [PATCH 0/1] toaster: restore Toaster filter feature
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
X-List-Received-Date: Mon, 10 Apr 2017 13:39:19 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Testing revealed that a syntax fix broke the Toaster filter feature. 
This commit reverts that and restores the functionality.

The following changes since commit 633ad6c9f436f5d2b6ee1a005b697661a054a394:

  oeqa/runtime/utils/targetbuildproject: use parent classes defaults tmpdir (2017-04-06 10:13:39 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/toaster/filters_broken_11317
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/filters_broken_11317

David Reyna (1):
  toaster: Toaster filters are broken

 lib/toaster/toastergui/static/js/table.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.9.1


