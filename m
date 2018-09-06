Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A1E3471C54
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Sep 2018 05:29:59 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w865TvfX025680
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 5 Sep 2018 22:29:58 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 5 Sep 2018 22:29:51 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Sep 2018 22:26:33 -0700
Message-ID: <cover.1536210899.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Cc: Awais Belal <awais.belal@mentor.com>
Subject: [SUMO][PATCH 0/9] toaster: SUMO cummulative patch Aug 28 2018
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
X-List-Received-Date: Thu, 06 Sep 2018 05:29:59 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>


This cumulative enhancement patch includes the following, to support
flexibility and usability for Toaster.

* 12891 - "Allow flexible value for TOASTERDIR plus custom fixture support"

  This supports the flexibility of having the Toaster base directory (used
  got the database and project build directories) to be specified by the user.
  It also allows for flexibility in the location of bitbake to be within one
  the specified local layers instead of being in the default fixed location.

* bitbake: toaster: Fix comparison in recipe template

  This helps prevent a page failure for certain circumstances, and is well
  worth porting back to Sumo.

- David


The following changes since commit 45ef387cc54a0584807e05a952e1e4681ec4c664:

  bitbake: checksum: sanity check path when recursively checksumming (2018-08-29 15:23:51 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/sumo_cummulative_082618
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/sumo_cummulative_082618

Awais Belal (8):
  toaster: allow pokydirname to be evaluated when all layers are local
  toaster: use a more flexible way to find bitbake
  bitbake: toaster: allow TOASTER_DIR to be overridden from cmdline
  toaster/widgets.py: avoid divide by zero issues
  toastergui/newproject.html: fix release divs
  toaster/checksettings: allow CUSTOM_XML_ONLY setting through env
  toaster/models.py: allow local paths for custom recipe's base
  toaster/layerdetails.js: don't hide local layer info

Karsten Strand (1):
  bitbake: toaster: Fix comparison in recipe template

 bin/toaster                                        |  9 +++++--
 lib/toaster/bldcontrol/localhostbecontroller.py    | 31 +++++++++++++++++++---
 .../management/commands/checksettings.py           |  3 ++-
 lib/toaster/orm/models.py                          |  7 +++++
 lib/toaster/toastergui/static/js/layerdetails.js   |  3 ++-
 lib/toaster/toastergui/templates/newproject.html   |  4 +--
 lib/toaster/toastergui/templates/recipe.html       |  2 +-
 lib/toaster/toastergui/widgets.py                  | 19 ++++++++-----
 8 files changed, 61 insertions(+), 17 deletions(-)

-- 
1.9.1


