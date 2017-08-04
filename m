Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 04D1D71A84
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Aug 2017 03:17:21 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v743HMtL019553
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 3 Aug 2017 20:17:22 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.361.1;
	Thu, 3 Aug 2017 20:17:21 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Aug 2017 22:15:27 -0500
Message-ID: <1501816532-89236-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Cc: toaster@yoctoproject.org
Subject: [PATCH 0/5 v3] Implement a new remote layer module
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
X-List-Received-Date: Fri, 04 Aug 2017 03:17:22 -0000
Content-Type: text/plain

v3:

Response to Paul E's comments:

Renamed the manager's 'fetch2' module to 'fetcher'.

Better commented the 'recipe loading' TODO block in the cooker.py file.

'restapi' type is now the default type, unless specified.  Adjusted the
lsupdates.py to remove the restapi addition as it's no longer needed.

did -NOT- rename the 'layers' module, as I don't have a good alternative

When specifing branches, changed from 'OR' to ','.

Fixed a few minor typo/grammatical errors found in comments.


v2:

Fixed two mismerged commits

v1:

The code for this work is available at:

git://git.openembedde.org/poky-contrib  mgh/bitbake-setup


A new module 'layers' is being added to bitbake.  This module contains
two parts that work together.  A 'layerindex' piece and a 'manager' piece.

The layerindex piece is designed to connect to layerindex content, such as
layers.openembedded.org, pull down layerindex information and provide basic
functionality for using the index.  It is capable of managing information
from multiple layerindex sources and resolving dependencies across indexes.

The connection to the external items is handled through plugins.  This permits
us to implement both a restapi format (connect to the web), but also an
internal 'cooker' implementation.  The cooker implementation will allow us to
create a mini-layerindex from the currently parsed system contents.

The internal data representation always uses the web style restapi, but is
wrapped with a number of layerindex provided object classes.

The layerindex provides object classes for each exported layerindex item, such
as Branch, LayerItem, LayerBranches, LayerDependency, etc...  Each of these
objects contain various accessor functions that simply return the data or
further process the data to make it easier to access related objects.  For
example a LayerBranch object refers to both a Branch-Id and a LayerItem-Id.
There are accessor functions designed to return back the Branch or LayerItem
without the user needing to know how to process the data structures.


The manager provides connection information to get to cooker instances for
some plugins, such as the layerindex's cooker plugin.  It also can interpret
the basic BBLAYERS and COLLECTIONS information to determine what the user
already has.  (The layerindex cooker plugin relies on this behavior.)

However, it's primary purpose is to manage downloads of layers, based on
layerindex generated dependency information.  This download mechanism also
uses a plugin architecture.  Currently only a 'fetch2' plugin has been
implemented. (I expect in the future additional plugins for 'git-repo', and
others to be implemented as needed.)

The download portion of the manager takes a 4 step approach:
  * setup(dependencies) - takes a dependency list of what to download/install
  * fetch() - fetch the layers
  * unpack() - unpack the fetched layers
  * update_bblayers() - update bblayers based on the previous activities


The code includes a set of bitbake-selftests for the described functionality.
Some items are not testable, such as the cooker integration, as cooker is not
available and the test data may be too limited to be useful.

The bitbake-layers has been updated to use these new modules for the
layerindex-fetch and layerindex-show-depends information.

The 'lsupdate.py' for the toaster has also been updated to use this item.
However, the longer term expectation is Toaster will be modified to no longer
handle an internal 'snapshot' of the layer index, but will use this new
functionality instead of process layer information.  That work will begin once
these items have been reviewed and agreed upon by the community.

Once toaster has been updated, the intention is to create a new
'bitbake-setup' program, that will have similar functionality to the
'wr-lx-setup' project on github (https://github.com/Wind-River/wr-lx-setup).

Mark Hatle (5):
  lib/layers: Initial layer and layer index implementeation
  bitbake-selftest: Add layers module tests
  lib/bblayers: Add support for the new layer modules
  toaster/orm/management/commands/lsupdates.py: Use new layerindex
    module
  bitbake-layers: disable parsing for layerindex commands

 bin/bitbake-selftest                             |   5 +-
 lib/bblayers/layerindex.py                       | 317 +++-----
 lib/layers/__init__.py                           |   0
 lib/layers/layerindex/__init__.py                | 974 +++++++++++++++++++++++
 lib/layers/layerindex/common.py                  | 146 ++++
 lib/layers/layerindex/cooker.py                  | 226 ++++++
 lib/layers/layerindex/restapi.py                 | 375 +++++++++
 lib/layers/manager/__init__.py                   | 253 ++++++
 lib/layers/manager/common.py                     |  60 ++
 lib/layers/manager/fetcher.py                    | 210 +++++
 lib/layers/tests/__init__.py                     |   0
 lib/layers/tests/layerindex.py                   | 372 +++++++++
 lib/layers/tests/manager.py                      | 155 ++++
 lib/toaster/orm/management/commands/lsupdates.py | 213 ++---
 14 files changed, 2956 insertions(+), 350 deletions(-)
 create mode 100644 lib/layers/__init__.py
 create mode 100644 lib/layers/layerindex/__init__.py
 create mode 100644 lib/layers/layerindex/common.py
 create mode 100644 lib/layers/layerindex/cooker.py
 create mode 100644 lib/layers/layerindex/restapi.py
 create mode 100644 lib/layers/manager/__init__.py
 create mode 100644 lib/layers/manager/common.py
 create mode 100644 lib/layers/manager/fetcher.py
 create mode 100644 lib/layers/tests/__init__.py
 create mode 100644 lib/layers/tests/layerindex.py
 create mode 100644 lib/layers/tests/manager.py

-- 
1.8.3.1


