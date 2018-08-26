Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B0541746D3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 22:36:44 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w7QMaioI029549
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 26 Aug 2018 15:36:44 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 26 Aug 2018 15:36:43 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Aug 2018 15:33:22 -0700
Message-ID: <cover.1535322629.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Cc: Awais Belal <awais.belal@mentor.com>
Subject: [PATCH 0/9] toaster: cummulative patch Aug 28 2018
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
X-List-Received-Date: Sun, 26 Aug 2018 22:36:44 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

---
This cumulative enhancement patch includes the following, to support
flexibility and usability for Toaster.

* 12891 - "Allow flexible value for TOASTERDIR plus custom fixture support"

  This supports the flexibility of having the Toaster base directory (used
  got the database and project build directories) to be specified by the user.
  It also allows for flexibility in the location of bitbake to be within one
  the specified local layers instead of being in the default fixed location.

* 12902 - "Enable project import and merged Toaster settings"

  This optionally enables Toaster and command line compatibility, where
  the Toaster settings are saved in the normal "local.conf" and
  "bblayers.conf" in a well defined and contained append structure.
  It also supports importing and detaching existing command line build
  projects, where importing a project inherits the existing project
  settings.
---


The following changes since commit 87d3a9685dd9613e4f6718031d4ebd9344b01c47:

  bitbake: parse/ast: ensure saved event handlers really do get restored (2018-08-24 07:53:14 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/toaster/import_builds_12902
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_082618

Awais Belal (8):
  toaster: allow pokydirname to be evaluated when all layers are local
  toaster: use a more flexible way to find bitbake
  toaster: allow TOASTER_DIR to be overridden from cmdline
  toaster/widgets.py: avoid divide by zero issues
  toastergui/newproject.html: fix release divs
  toaster/checksettings: allow CUSTOM_XML_ONLY setting through env
  toaster/models.py: allow local paths for custom recipe's base
  toaster/layerdetails.js: don't hide local layer info

David Reyna (1):
  toaster: enable project import and merged Toaster settings

 bin/toaster                                        |  9 +++-
 lib/toaster/bldcontrol/localhostbecontroller.py    | 39 ++++++++++++---
 .../management/commands/checksettings.py           |  3 +-
 lib/toaster/orm/models.py                          |  7 +++
 lib/toaster/toastergui/static/js/layerdetails.js   |  3 +-
 lib/toaster/toastergui/templates/newproject.html   | 57 +++++++++++-----------
 lib/toaster/toastergui/views.py                    | 22 ++++++---
 lib/toaster/toastergui/widgets.py                  | 19 +++++---
 .../toastermain/management/commands/buildimport.py |  7 +--
 9 files changed, 107 insertions(+), 59 deletions(-)

-- 
1.9.1


