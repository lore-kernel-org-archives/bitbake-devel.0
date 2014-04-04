Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 902BC6B72B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:51 +0000 (UTC)
Received: by mail-wg0-f44.google.com with SMTP id m15so3557971wgh.27
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=9VXb0feXCHOBDVSLstJKl7b45FNz2PnBI1URZWV4gRA=;
	b=jHGIzgJctMfSq9f5+Lj/H+XxvNIpuFzLAtpvFQVVJtDVS4ms+xIptNqe5hWLRWUMcW
	ctUmMrE67z0y8Ntfsa6vnHeTCJR/dmWzThIOPIG24c2jyGJNbP5VdDKZokh3R1OlqYkO
	pXTrQgEIKm2p+lAqPDQT1hlLMpMzt/fPs2wmmNOzTqbG+gWy6LuDasmZIxDbpD2LaySu
	nCtf/B3AOBPyJcYoCVa8lm8ucpBLJ/gMe34H1i3KuAMAnDwoUWNFNoxnHJcbCIwk5SOW
	Im035+RA9M+ObbPIfgNQuevrOlqS3L8UroRZTy+I2ia0JsCMNNDJzKNZ8vdw+sH2A0j0
	p7gg==
X-Gm-Message-State: ALoCoQngTmBARgqWiFcvGgM5dawtyKDT3zP8eSz2xEBYjDCYdRrWUKCNRfCDIqmpO30Bmwc6oE18
X-Received: by 10.180.90.140 with SMTP id bw12mr4996955wib.18.1396620652141;
	Fri, 04 Apr 2014 07:10:52 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id jd2sm4916326wic.9.2014.04.04.07.10.50
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:51 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 87734560327; Fri,  4 Apr 2014 15:10:50 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:49 +0100
Message-Id: <cover.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Farrell Wymore <farrell.wymore@windriver.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 00/14] toaster patchset w/ UI fixes
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
X-List-Received-Date: Fri, 04 Apr 2014 14:10:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

Can you please merge this toaster patchest ?
The patches focus on UI fixes, and they have been reviewed on the toaster mailing list.

Thank you,
Alex

The following changes since commit b05e741cb5fe44b37538f2b727782f80dc9bb8fa:

  toaster: fix mis-detection of targets as images (2014-04-03 11:33:20 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140404-bb-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140404-bb-submission

Alexandru DAMIAN (3):
  toaster: do not load all available timezones
  toasterui: avoid variable name conflict
  toasterui: save warnings from non-build context

Belen Barros Pena (7):
  toaster: Update API
  toaster: Remove html validation errors in tasks.html
  toaster: Changes to help text
  toaster: Fix "Recent builds" links
  toaster: Fix the empty packages alert
  toaster: Make tables happy in Chrome
  toaster: Fixes to the build dashboard

David Reyna (2):
  toaster: link task order to right tasks page
  toaster: catch IndexError error in dictionary lookups

Farrell Wymore (2):
  toaster: correct package count
  toaster: added covered task list

 lib/bb/ui/buildinfohelper.py                       |  34 +--
 lib/bb/ui/toasterui.py                             |   3 +-
 lib/toaster/bldviewer/api.py                       |   3 +-
 lib/toaster/bldviewer/views.py                     |   3 +-
 lib/toaster/orm/models.py                          |   2 +-
 lib/toaster/toastergui/static/css/default.css      |   6 +-
 lib/toaster/toastergui/static/js/main.js           |   2 +-
 .../toastergui/templates/basebuildpage.html        |   2 +-
 lib/toaster/toastergui/templates/bpackage.html     |  12 +-
 lib/toaster/toastergui/templates/build.html        |   6 +-
 .../toastergui/templates/builddashboard.html       |  57 +++--
 .../templates/package_built_dependencies.html      |   4 +-
 .../toastergui/templates/package_built_detail.html |   6 +-
 .../toastergui/templates/package_detail_base.html  |   4 +-
 .../templates/package_included_dependencies.html   |   2 +-
 .../templates/package_included_tabs.html           |   2 +-
 lib/toaster/toastergui/templates/recipe.html       |  16 +-
 lib/toaster/toastergui/templates/task.html         |  47 +++--
 lib/toaster/toastergui/templates/tasks.html        |  15 +-
 lib/toaster/toastergui/templatetags/projecttags.py |   2 +-
 lib/toaster/toastergui/urls.py                     |   1 +
 lib/toaster/toastergui/views.py                    | 229 +++++++++++++--------
 lib/toaster/toastermain/settings.py                |   8 +-
 23 files changed, 295 insertions(+), 171 deletions(-)

-- 
1.9.1


