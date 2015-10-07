Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 3252C60125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:55:01 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 07 Oct 2015 06:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="575860831"
Received: from cdoyle2-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.38])
	by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2015 06:55:00 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 14:54:52 +0100
Message-Id: <cover.1444225939.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/2] toaster: buildinfohelper fixes
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
X-List-Received-Date: Wed, 07 Oct 2015 13:55:03 -0000

Two patches which fix regressions in the build -> toaster.

1. The first is where the recipe in the build history is linking to the
recipe that is Toaster's data rather than the build's data.

This fixes an issue identified by Belen:

"The recipes table in the build history is linking to the wrong recipe
id. The recipe details page appears empty but if you access the same
recipe from the package details page, you get to a recipe with the same
name and version, but different recipe id, that has all the information
from the build. To reproduce, build core-image-minimal. When the build
completes, go to the recipes page and search for busybox: click through to
the recipe details page. It's empty. Now click the image name on the left
nav to see the list of packages installed. Search for 'busybox'. Click
through to the package details page. Then, on the right hand side
information about the package, click the busybox recipe name. The page is
no longer empty: in fact, it's a different recipe id."

2. The second patch avoids the buildinfo helper bailing out when there are more packages reported by the ImagePkgs event data than have currently been provided by the all packages list. We get the meta data for a package - including its dependencies from this "all packages". Also improved the error logging to make it clearer what is actually happening.

The following changes since commit 18decad837a86b220bc549eec432f94f55510fcb:

  toaster: Modify "New build" button behaviour for cli builds project (2015-10-07 16:14:03 +0300)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/michaelw/toaster/buildinfo-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/michaelw/toaster/buildinfo-fixes

Michael Wood (2):
  toaster: buildinfohelper associate build data with built_recipe
  toaster: buildinfohelper Skip packages we have no build info about

 lib/bb/ui/buildinfohelper.py | 45 ++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

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


