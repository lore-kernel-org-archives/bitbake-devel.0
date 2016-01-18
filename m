Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 7F66373183
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 15:41:43 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 18 Jan 2016 07:41:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,312,1449561600"; d="scan'208";a="729556529"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 18 Jan 2016 07:41:43 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 535182C8001
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 08:29:39 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jan 2016 15:45:07 +0200
Message-Id: <cover.1453124453.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/3] Fix SDK downloads forbuilds
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
X-List-Received-Date: Mon, 18 Jan 2016 15:41:45 -0000

Hi,

Artifacts could not be downloaded for a build as they were not being listed.
It was not possible to download them manually either, as the artifact download
code was broken for SDK artifacts produced by command line builds.

Fix how toaster.bbclass hooks onto bitbake's build tasks, so that the SDK
artifacts are picked up after do_populate_sdk runs.

Fix Toaster code for returning SDK artifacts in HTTP responses.

Changes since b53df3c (toaster-next) are in
git://git.yoctoproject.org/poky-contrib, elliot/toaster/sdk_artifacts-7603
http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/toaster/sdk_artifacts-7603

NB one of the commits on this branch (fbc2024) has been submitted to oe-core:
http://lists.openembedded.org/pipermail/openembedded-core/2016-January/115366.html
This patch set contains the other commits on the branch.

Related bug: https://bugzilla.yoctoproject.org/show_bug.cgi?id=7603

To test:

1. Ensure that your database has no build artifacts in it, either by
removing the database, clearing the relevant table with SQL via the command line
(delete from orm_buildartifact), or removing the objects via the Django shell
(orm.models.BuildArtifact.objects.all().delete()).

Note that the current behaviour, where we only associate SDK artifacts with the
first build which produces them, has not been modified. So if you have already
run a build and have files in tmp/deploy/sdk associated with it, subsequent
builds will not be associated with those files.

2. Start a new build from the command line or Toaster, invoking the populate_sdk
target:

# command line
bitbake -c populate_sdk core-image-minimal

# Toaster (NB you must use the "Local" release)
run a build like "core-image-minimal:populate_sdk"

3. View the build dashboard for the build when it completes and ensure it
contains an "Other artifacts" section, as shown in the bug report.

4. Click on one of the "Other artifact" links and ensure that the artifact
downloads correctly.

As this code slightly modifies all other artifact downloads, you could also
check downloads for the following, too:

* cooker logs
* task logs
* image files
* licence manifests


The following changes since commit d1cdf28a40489c9d730dfed3a48e67cb34e8890b:

  toaster: tests Remove symlinks from toasteruitest folder (2016-01-18 15:23:51 +0200)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/elliot/toaster/sdk_artifacts-7603
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/elliot/toaster/sdk_artifacts-7603

Elliot Smith (3):
  toaster: toasterui: listen for bb.event.MetadataEvent
  toaster: toasterui: log OSErrorException metadata events
  toaster: toastergui: make artifact download more robust

 lib/bb/ui/toasterui.py                             |  5 +-
 .../toastergui/templates/unavailable_artifact.html | 13 ++-
 lib/toaster/toastergui/views.py                    | 97 +++++++++-------------
 3 files changed, 51 insertions(+), 64 deletions(-)

--
Regards,
Ed


