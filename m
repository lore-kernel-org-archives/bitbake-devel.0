Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C69A8784FE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 20:34:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w6CKYETI029449
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 13:34:14 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.399.0;
	Thu, 12 Jul 2018 13:34:14 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Jul 2018 16:34:08 -0400
Message-ID: <20180712203413.118578-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH 0/5] Add a standard module for accessing the layerindex
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
X-List-Received-Date: Thu, 12 Jul 2018 20:34:13 -0000
Content-Type: text/plain

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

 bin/bitbake-selftest                               |   6 +-
 lib/bblayers/layerindex.py                         | 302 +++----
 lib/layerindexlib/README                           |  28 +
 lib/layerindexlib/__init__.py                      | 974 +++++++++++++++++++++
 lib/layerindexlib/common.py                        | 161 ++++
 lib/layerindexlib/cooker.py                        | 338 +++++++
 lib/layerindexlib/restapi.py                       | 375 ++++++++
 lib/layerindexlib/tests/__init__.py                |   0
 lib/layerindexlib/tests/common.py                  |  37 +
 lib/layerindexlib/tests/cooker.py                  | 125 +++
 lib/layerindexlib/tests/layerindex.py              | 233 +++++
 lib/layerindexlib/tests/restapi.py                 | 170 ++++
 lib/layerindexlib/tests/testdata/README            |  11 +
 .../tests/testdata/build/conf/bblayers.conf        |  15 +
 .../tests/testdata/layer1/conf/layer.conf          |  17 +
 .../tests/testdata/layer2/conf/layer.conf          |  20 +
 .../tests/testdata/layer3/conf/layer.conf          |  19 +
 .../tests/testdata/layer4/conf/layer.conf          |  22 +
 lib/toaster/orm/management/commands/lsupdates.py   | 215 ++---
 19 files changed, 2751 insertions(+), 317 deletions(-)
 create mode 100644 lib/layerindexlib/README
 create mode 100644 lib/layerindexlib/__init__.py
 create mode 100644 lib/layerindexlib/common.py
 create mode 100644 lib/layerindexlib/cooker.py
 create mode 100644 lib/layerindexlib/restapi.py
 create mode 100644 lib/layerindexlib/tests/__init__.py
 create mode 100644 lib/layerindexlib/tests/common.py
 create mode 100644 lib/layerindexlib/tests/cooker.py
 create mode 100644 lib/layerindexlib/tests/layerindex.py
 create mode 100644 lib/layerindexlib/tests/restapi.py
 create mode 100644 lib/layerindexlib/tests/testdata/README
 create mode 100644 lib/layerindexlib/tests/testdata/build/conf/bblayers.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer1/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer2/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer3/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer4/conf/layer.conf

-- 
1.8.3.1


