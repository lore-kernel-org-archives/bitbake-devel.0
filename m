Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SArc5-0001ys-80
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 00:40:13 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 16:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124076803"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 16:31:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 16:31:05 -0700
Message-Id: <cover.1332458487.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/9] Hob changes to match visual design
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
X-List-Received-Date: Thu, 22 Mar 2012 23:40:13 -0000

Here's another set of patches to move Hob closer to the proposed design.

* Replace HobXpmLabelButtonBox with a new HobImageButton, this is a gtk.Button
subclass which is modelled after the buttons in gnome-disk-utility, where Belen
informs me the buttons on the main page for Layers, Recipes and Packages are
modelled after.
Since the first submission of this patch I've also ensured the buttons use an
alternative icon for the hover state per Shane's suggestion.

* Various tweaks to the LayerSelectionDialog per feedback from design:
  - title is Layers
  - add hover state icon to add button
  - follow Gnome HIG and only use a close button

* Per feedback on my last pull request and the design document changes to the
HobAltButton
  - bold text which uses a pale blue colour per visual design
  - modified 'Back to image configuration' buttons to have << prefix

* Unify implementation of the primary action button as a shared widget HobButton
and make use of it where we currently set up an orange button (this class should
be used for all primary buttons in a future patch).

Cheers,
Joshua

The following changes since commit 96e235a151fa04f5a15cd8b46f50a5852e2ba739:

  Hob: Revert interfaces of callbacks for layer_button, view_recipes_button, and view_packages_button. (2012-03-22 14:36:04 +0000)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob
  git://git.yoctoproject.org/poky-contrib josh/hob
  http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=josh/hob

Joshua Lock (9):
  lib/bb/ui/icons: add new icons for use in Hob, autocrop some existing
    ones
  lib/bb/ui/crumbs: replace HobXpmLabelButtonBox with HobImageButton
  lib/bb/ui/crumbs/builder: only show a close button on the Layer
    Selector
  lib/bb/ui/crumbs/hig: tweak 'Add Layer' button per visual design
  lib/bb/ui/crumbs: add colour for HobAltButton per visual design
  lib/bb/ui/crumbs: fix 'Back to image configuration' alt button text
  lib/bb/ui/crumbs/hobwidget: add HobButton widget for the primary
    action
  lib/bb/ui/crumbs: make use of HobButton for existing primary action
    buttons
  lib/bb/ui/crumbs/builder: change dialogue title to Layers

 lib/bb/ui/crumbs/builder.py                 |    5 +-
 lib/bb/ui/crumbs/hig.py                     |   27 +++--
 lib/bb/ui/crumbs/hobcolor.py                |    1 +
 lib/bb/ui/crumbs/hobwidget.py               |  148 ++++++++++++++++-----------
 lib/bb/ui/crumbs/imageconfigurationpage.py  |   52 ++++------
 lib/bb/ui/crumbs/imagedetailspage.py        |   11 +--
 lib/bb/ui/crumbs/packageselectionpage.py    |   13 +--
 lib/bb/ui/crumbs/recipeselectionpage.py     |   13 +--
 lib/bb/ui/icons/indicators/add-hover.png    |  Bin 0 -> 1212 bytes
 lib/bb/ui/icons/indicators/remove-hover.png |  Bin 0 -> 2809 bytes
 lib/bb/ui/icons/layers/layers_hover.png     |  Bin 5390 -> 5257 bytes
 lib/bb/ui/icons/packages/packages_hover.png |  Bin 7308 -> 7121 bytes
 lib/bb/ui/icons/recipe/recipe_hover.png     |  Bin 5003 -> 4866 bytes
 13 files changed, 136 insertions(+), 134 deletions(-)
 create mode 100644 lib/bb/ui/icons/indicators/add-hover.png
 create mode 100644 lib/bb/ui/icons/indicators/remove-hover.png

-- 
1.7.7.6



