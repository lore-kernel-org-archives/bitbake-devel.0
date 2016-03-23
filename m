Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id BB68062136
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Mar 2016 08:28:35 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 23 Mar 2016 01:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,381,1455004800"; d="scan'208";a="930013053"
Received: from rmoran-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.1.250])
	by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2016 01:28:34 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Mar 2016 08:28:30 +0000
Message-Id: <cover.1458721297.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/5] localhostbecontroller improvements
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
X-List-Received-Date: Wed, 23 Mar 2016 08:28:39 -0000

Support file:/// URIs for git repos and make various small improvements
to handling of custom image recipes and layers.

The following changes since commit 5bcf5bd6b498d17aa42738ee8af5542f5c9a2248:

  toasterui: remove ParseStarted from the event list (2016-03-17 11:58:35 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib toaster-next
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=toaster-next

Michael Wood (5):
  toaster: localhostbecontroller Don't clear out toaster custom layer
    dir
  toaster: orm Add a constant for the CustomImageRecipe's layer name
  toaster: localhostbecontroller Allow file:/// uri type for git repo
  toaster: localhostbecontroller put generated layer in the builddir
  toaster: orm generate CustomImageRecipe contents try secondary path

 lib/bb/ui/buildinfohelper.py                    |  4 ++--
 lib/toaster/bldcontrol/localhostbecontroller.py | 10 +++++-----
 lib/toaster/orm/models.py                       | 15 +++++++++++----
 lib/toaster/toastergui/views.py                 |  2 +-
 4 files changed, 19 insertions(+), 12 deletions(-)

--
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


