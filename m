Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 116826011F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Nov 2015 16:44:25 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga101.fm.intel.com with ESMTP; 26 Nov 2015 08:44:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,347,1444719600"; 
   d="scan'208";a="2719211"
Received: from snwijaya-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.69])
	by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2015 08:44:25 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Nov 2015 16:44:18 +0000
Message-Id: <cover.1448556172.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/5] toaster: ToasterTable fixes
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
X-List-Received-Date: Thu, 26 Nov 2015 16:44:27 -0000

A number of fixes for toaster tables, identified while writing a generic
unit test for this widget.

The following changes since commit 0dc54dbc61d1a24f5cfcb07c3f288b1042ab091a
(poky-contrib, toaster-next branch):

  toaster: tablejs Make sure click handlers consume click event (2015-11-26 15:55:40 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/michaelw/toaster/tables-misc
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/michaelw/toaster/tables-misc

Michael Wood (5):
  toaster: machines table Fix missing layers information needed for
    filter
  toaster: CustomImageRecipe add search_allowed_fields to this model
  toaster: tables Add default_orderby field where it was missing or
    unset
  toaster: tables Fix invalid field name on NewCustomImagesTable
  toaster: toastergui tests Add generic test for ToasterTables widget

 lib/toaster/orm/models.py                         |   1 +
 lib/toaster/toastergui/tables.py                  |  18 +-
 lib/toaster/toastergui/templates/machine_btn.html |  12 +-
 lib/toaster/toastergui/tests.py                   | 223 ++++++++++++++++++++--
 4 files changed, 235 insertions(+), 19 deletions(-)

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


