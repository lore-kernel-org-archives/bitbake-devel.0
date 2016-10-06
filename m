Return-Path: <brian.avery@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E426A71A25
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Oct 2016 00:07:24 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 05 Oct 2016 17:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,451,1473145200"; d="scan'208";a="887159584"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga003.jf.intel.com with ESMTP; 05 Oct 2016 17:07:25 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Oct 2016 17:08:52 -0700
Message-Id: <cover.1475712223.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 0/6] toaster: Delete project fixes and clean ups
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
X-List-Received-Date: Thu, 06 Oct 2016 00:07:26 -0000

This addresses several toaster bugs:

9936 - import layer dependencies button toggle
9097 - startup message cleanup
10289 - stop in progress build before deleting project

Also has some buildinfohelper cleanup as well as some test fixes for the ui changes.

-bavery

The following changes since commit 4189a1977e65f71ddb8fc0498bcef91754c673d8:

  bitbake: toaster: add Font Awesome license (2016-10-05 10:28:53 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/michaelw/toaster/pending_for_upstream_5_10_16
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/michaelw/toaster/pending_for_upstream_5_10_16

Michael Wood (6):
  toaster: api / project Cancel any in progress builds before project
    delete
  toaster: buildinfohelper: Use correct way to get message from
    LogMessage
  toaster: checksettings Remove confusing startup messages
  toaster: importlayer Fix layer dependencies button state toggle
  toaster: Delete notification update front end implementation to design
  toaster: Update tests to reflect front end changes

 lib/bb/ui/buildinfohelper.py                       |  9 ++--
 .../management/commands/checksettings.py           |  2 -
 .../tests/browser/test_layerdetails_page.py        |  4 ++
 lib/toaster/tests/browser/test_project_page.py     |  2 +-
 lib/toaster/toastergui/api.py                      | 57 +++++++++++++---------
 lib/toaster/toastergui/static/js/importlayer.js    | 30 ++----------
 lib/toaster/toastergui/static/js/layerdetails.js   |  2 +
 lib/toaster/toastergui/static/js/libtoaster.js     |  2 +-
 lib/toaster/toastergui/templates/base.html         |  2 +-
 .../toastergui/templates/basebuildpage.html        |  6 ++-
 lib/toaster/toastergui/templates/project.html      | 12 +++--
 lib/toaster/toastergui/tests.py                    |  8 ++-
 12 files changed, 71 insertions(+), 65 deletions(-)

--
1.9.1

