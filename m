Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeB-0005Br-DY
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:19 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058918"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:37 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:14 -0700
Message-Id: <cover.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 00/11] hob enhancements and UI bug fixes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 19 Aug 2011 01:13:19 -0000

This series includes several bug fixes and improvements for UI's including:
* Hide the goggle progress bar after cache load
* Adapt to recent msg.py change and reduce messages in RunningBuildTreeView
* Change hob to track and list all packages which bring in the listed package
rather than just the first, it's expected that this will increase the
usability of the UI by making changes more obvious

Amongst increased usefulness of hob this series ensures goggle is reliably
usable once more.

Regards,
Joshua

The following changes since commit d5abdacaf9ac604ef8d8c1bafb9b30617827cb4f:

  Fixup remaining bb.msg.domain users (2011-08-15 17:31:18 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (11):
  bb/ui/crumbs/runningbuild: reduce number of messages after recent msg
    change
  bb/ui/crumbs/runningbuild: hide the progress bar on cache load
    complete
  bb/ui/crumbs/tasklistmodel: more robust checking for substrings
  bb/ui/crumbs/tasklistmodel: remove useless items from dependency list
  bb/ui/crumbs/tasklistmodel: store all binb, not just the first
  hob: don't try and build if user selects Bake with no selections made
  bb/ui/crumbs/tasklistmodel: track the PN for each entry in the model
  bb/ui/hob: fix package only build
  bb/ui/crumbs/hobeventhandler: fix return values of
    *_image_output_type
  bb/ui/crumbs/hobprefs: fix setting IMAGE_FSYTPES
  bb/ui/hob: warn and prevent image build if no IMAGE_FSTYPE is set

 lib/bb/ui/crumbs/hobeventhandler.py |    8 +-
 lib/bb/ui/crumbs/hobprefs.py        |    2 +-
 lib/bb/ui/crumbs/runningbuild.py    |    5 +-
 lib/bb/ui/crumbs/tasklistmodel.py   |  106 ++++++++++++++++++++---------------
 lib/bb/ui/hob.py                    |   34 ++++++++++-
 5 files changed, 100 insertions(+), 55 deletions(-)

-- 
1.7.6



