Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 65EE371999
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Oct 2017 03:39:31 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v9A3dWaf012289
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 9 Oct 2017 20:39:32 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 9 Oct 2017 20:39:31 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 9 Oct 2017 20:31:22 -0700
Message-ID: <cover.1507605334.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Cc: Brian Avery <brian.avery@intel.com>
Subject: [PATCH 0/1] toaster: remove_prettify_12206
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
X-List-Received-Date: Tue, 10 Oct 2017 03:39:32 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Patch from Jason Wessel to remove "prettify". This is to address license issue
and remove the need for the license YP-2.4 exception.

The following changes since commit da05a01423a60a23cd1073eb0ad3776e5bf4f2a8:

  poky: add debian-9 to SANITY_TESTED_DISTROS (2017-10-09 10:09:09 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/remove_prettify_12206
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/remove_prettify_12206

David Reyna (1):
  toaster: remove prettify

 lib/toaster/toastergui/static/css/prettify.css     |  1 -
 lib/toaster/toastergui/static/js/highlight.pack.js |  2 ++
 lib/toaster/toastergui/static/js/libtoaster.js     |  6 ++---
 lib/toaster/toastergui/static/js/prettify.js       | 28 ----------------------
 lib/toaster/toastergui/templates/base.html         |  2 +-
 .../toastergui/templates/js-unit-tests.html        |  2 +-
 6 files changed, 6 insertions(+), 35 deletions(-)
 delete mode 100755 bitbake/lib/toaster/toastergui/static/css/prettify.css
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/highlight.pack.js
 delete mode 100755 bitbake/lib/toaster/toastergui/static/js/prettify.js

-- 
1.9.1


