Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2DA3A60110
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 15:48:55 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w6PFmtEJ020110
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 08:48:55 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.399.0;
	Wed, 25 Jul 2018 08:48:54 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jul 2018 11:48:53 -0400
Message-ID: <20180725154854.141556-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH 0/5 v3] Add a standard module for accessing the layerindex
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
X-List-Received-Date: Wed, 25 Jul 2018 15:48:55 -0000
Content-Type: text/plain

Changes available at:
git://git.openembedded.org/bitbake-contrib bitbake-layerindex

v3:
Now that I could verify lsupdate.py changes, I found/fixed a few issues.

No changes to patch 1-4.

v2:
Refactored the module to address Paul E's concerns:

* Treat LAYERSERIES_CORENAMES as a list of supported branches

* Remove type= stuff in plugins, now iterate through plugins until one
  of them accepts the data

* Fix incorrect exceptions, add additional exceptions as necessary

* Replace space separated lists with python lists.. (Few minor excptions,
  documented why where still necessary.)

* Refactor item and object classes:
  - Each LayerIndexItem now uses both decorators and properties to manage
    access to the private data
  - New LayerIndexObj class to handle a -single- layerindex, the main
    module now is a list of LayerIndexObjs

* Lots of variable name changes and cleanups

* Removed dummy API to implement a json query

* General refactoring to accomplish the above

* bitbake-layers layerindex-*
  - Now checks the cooker first, if the layer is already present skips
    going to the network

Selftest passes.
bitbake-layers layerindex-fetch and layerindex-show-depends pass

Note: as before the toaster change needs additional verication then
      what I'm current able to provide.  But it -should- work as patched.


V1:
In order to simply existing components, and add support to create some
new functionaly -- we need a common apporach for access the layerindex.

The class supports loading multilib layerindexes, but right now that
functionality is not being used by either bitbake-layers or the toaster.

There are a few 'TODO' items that remain in the code.  These are related
to either un-implemented, but planned functionality or to display stuff
in bitbake-layers.  I'm hoping that part of this review can discuss the
TODO items.


Mark Hatle (5):
  bblayers/layerindex.py: Fix addition of layers
  layerindexlib: Initial layer index processing module implementation
  bblayers/layerindex.py: Switch to use the new layerindexlib class
  bitbake-layers: disable parsing for layerindex commands
  toaster/orm/management/commands/lsupdates.py: Use new layerindexlib
    module

 bin/bitbake-selftest                               |    6 +-
 lib/bblayers/layerindex.py                         |  323 ++---
 lib/layerindexlib/README                           |   28 +
 lib/layerindexlib/__init__.py                      | 1364 ++++++++++++++++++++
 lib/layerindexlib/cooker.py                        |  341 +++++
 lib/layerindexlib/plugin.py                        |   60 +
 lib/layerindexlib/restapi.py                       |  398 ++++++
 lib/layerindexlib/tests/__init__.py                |    0
 lib/layerindexlib/tests/common.py                  |   43 +
 lib/layerindexlib/tests/cooker.py                  |  123 ++
 lib/layerindexlib/tests/layerindexobj.py           |  226 ++++
 lib/layerindexlib/tests/restapi.py                 |  174 +++
 lib/layerindexlib/tests/testdata/README            |   11 +
 .../tests/testdata/build/conf/bblayers.conf        |   15 +
 .../tests/testdata/layer1/conf/layer.conf          |   17 +
 .../tests/testdata/layer2/conf/layer.conf          |   20 +
 .../tests/testdata/layer3/conf/layer.conf          |   19 +
 .../tests/testdata/layer4/conf/layer.conf          |   22 +
 lib/toaster/orm/management/commands/lsupdates.py   |  228 ++--
 19 files changed, 3093 insertions(+), 325 deletions(-)
 create mode 100644 lib/layerindexlib/README
 create mode 100644 lib/layerindexlib/__init__.py
 create mode 100644 lib/layerindexlib/cooker.py
 create mode 100644 lib/layerindexlib/plugin.py
 create mode 100644 lib/layerindexlib/restapi.py
 create mode 100644 lib/layerindexlib/tests/__init__.py
 create mode 100644 lib/layerindexlib/tests/common.py
 create mode 100644 lib/layerindexlib/tests/cooker.py
 create mode 100644 lib/layerindexlib/tests/layerindexobj.py
 create mode 100644 lib/layerindexlib/tests/restapi.py
 create mode 100644 lib/layerindexlib/tests/testdata/README
 create mode 100644 lib/layerindexlib/tests/testdata/build/conf/bblayers.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer1/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer2/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer3/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer4/conf/layer.conf

-- 
1.8.3.1


