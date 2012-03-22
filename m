Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAXci-0000Mz-Q9
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 03:19:32 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 19:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131778605"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.222])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 19:10:36 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 19:10:25 -0700
Message-Id: <cover.1332381654.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 00/10] Hob GUI tweaks v2
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
X-List-Received-Date: Thu, 22 Mar 2012 02:19:33 -0000

Here are some tweaks to the Hob GUI. This series iterates on (and therefore makes
redundant) an earlier series with the same subject.

Changes include

* adding a clear icon to search entries, per Gtk+ norm
* changes to PersistentTooltip's so that the colours work better on darker themes
(though there's still a problem with the link colour, which is technically a theme
bug but makes our app look bad), some spacing tweaks and a change to reindent the
file to match the rest of BitBake indentation style.
* add a new widget, HobAltButton, for use as a secondary button instead of
gtk.LinkButton - Belen, our interaction designer, informed me that the design
intends them to be buttons (and therefore have prelight and active states
matching standard buttons) but that they are supposed to be implemented without
relief so that the user is guided towards primary actions. I need to develop a
follow on that changes the colour of the secondary button text per visual design.
* Replace HobXpmLabelButtonBox with a new HobImageButton, this is a HobAltButton
subclass which is modelled after the buttons in gnome-disk-utility, where Belen
informs me the buttons on the main page for Layers, Recipes and Packages are
modelled after.
* Finally I include a further iterated implementation of the Layer Selection
dialogue which uses some new assets provided by the design team and the
HobAltButton to match the visual and interation designs more closely.

Cheers,
Joshua

The following changes since commit c5fdc6c02fe4712d3114caccfd759a626bd9677b:

  Add bitbake-dumpsig to make it more obvious how to dump a signatures file (2012-03-21 17:08:08 +0000)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (10):
  ui/crumbs/hobwidget: add clear icon to search entries in HobNotebook
  ui/crumbs/persistenttooltip: tweak borders
  ui/crumbs/persistenttooltip: fix colours on darker themes
  ui/crumbs/persistenttooltip: fix whitespace
  lib/bb/ui/crumbs: Add HobAltButton and use it
  lib/ui/icons: autocrop images
  lib/bb/ui/crumbs: replace HobXpmLabelButtonBox with HobImageButton
  lib/bb/ui/crumbs: add icons for use in the layer dialogue
  ui/crumbs/hig: make the layer selection dialogue more closely match
    design
  lib/bb/ui/crumbs/hig: disable removal of meta-hob layer

 lib/bb/ui/crumbs/builddetailspage.py          |    6 +-
 lib/bb/ui/crumbs/hig.py                       |  129 ++++++++++----
 lib/bb/ui/crumbs/hobwidget.py                 |  131 +++++++-------
 lib/bb/ui/crumbs/imageconfigurationpage.py    |   52 +++---
 lib/bb/ui/crumbs/imagedetailspage.py          |   12 +-
 lib/bb/ui/crumbs/packageselectionpage.py      |    4 +-
 lib/bb/ui/crumbs/persistenttooltip.py         |  244 +++++++++++++-----------
 lib/bb/ui/crumbs/recipeselectionpage.py       |    4 +-
 lib/bb/ui/icons/indicators/add.png            |  Bin 0 -> 1176 bytes
 lib/bb/ui/icons/indicators/remove.png         |  Bin 0 -> 1971 bytes
 lib/bb/ui/icons/layers/layers_display.png     |  Bin 5326 -> 4840 bytes
 lib/bb/ui/icons/packages/packages_display.png |  Bin 7188 -> 7011 bytes
 lib/bb/ui/icons/recipe/recipe_display.png     |  Bin 4873 -> 4723 bytes
 13 files changed, 334 insertions(+), 248 deletions(-)
 create mode 100644 lib/bb/ui/icons/indicators/add.png
 create mode 100644 lib/bb/ui/icons/indicators/remove.png

-- 
1.7.7.6



