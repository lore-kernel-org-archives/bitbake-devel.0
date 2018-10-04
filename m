Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 67E5874FB9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 06:13:54 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w946DstS021478
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 3 Oct 2018 23:13:54 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 3 Oct 2018 23:13:53 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 3 Oct 2018 23:10:41 -0700
Message-ID: <cover.1538633120.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 0/1] toaster: custom image enable layer add, protect pre-cloned layers
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
X-List-Received-Date: Thu, 04 Oct 2018 06:13:54 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Fix for Bug 12887:
* When attempting create a custom image in Toaster for a layer not yet added not cloned, two errors were found.
  1) The "Add layer" button did not do anything, due to a missing data structure, easily fixed
  2) If the layer was newly added but not yet cloned, the custom image create just hung. 
     This was because the problems were reported internally but not to the user. This patch adds
     the error return chain plus the helpful error recovery message to the user.

The following changes since commit bdb49647874e18e7d60374b8973a307551b36a14:

  go.bbclass: Add -buildmode=pie for non mips arch (2018-10-01 13:04:50 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/toaster/custom_image_protection_12887
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/toaster/custom_image_protection_12887

David Reyna (1):
  toaster: custom image enable layer add, protect pre-cloned layers

 lib/toaster/orm/models.py                                | 4 ++--
 lib/toaster/toastergui/api.py                            | 8 +++++++-
 lib/toaster/toastergui/static/js/libtoaster.js           | 3 ++-
 lib/toaster/toastergui/static/js/newcustomimage_modal.js | 7 +++++++
 lib/toaster/toastergui/templates/customise_btn.html      | 6 +++++-
 5 files changed, 23 insertions(+), 5 deletions(-)

-- 
1.9.1


