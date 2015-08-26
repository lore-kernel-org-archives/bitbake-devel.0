Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id F1F42734B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 08:48:49 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 26 Aug 2015 01:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,415,1437462000"; d="scan'208";a="791147949"
Received: from ssandhu2-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.4.150])
	by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2015 01:48:49 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:48:38 +0100
Message-Id: <49096e8ecd68668a5a4d8326f9acea38ab0fe8b2.1440578613.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <fff163e41b155bc781eb2e199b4c8bc5acb374b2.1440578613.git.elliot.smith@intel.com>
References: <fff163e41b155bc781eb2e199b4c8bc5acb374b2.1440578613.git.elliot.smith@intel.com>
In-Reply-To: <cover.1440578613.git.elliot.smith@intel.com>
References: <cover.1440578613.git.elliot.smith@intel.com>
Subject: [PATCH 3/3] toastergui: change image in landing page
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
X-List-Received-Date: Wed, 26 Aug 2015 08:48:50 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Change the Toaster screenshot we use in the landing page
to make sure it cannot be confused with the real interface.

Also, remove the MANAGE conditional we were using to set the
screenshot. We no longer have different applications for the
two modes, so it should no longer be needed.

[YOCTO #7743]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/templates/landing.html | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
index 15cac47..45e9532 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -49,11 +49,7 @@
 
       </div>
       <div class="span6">
-        {% if MANAGED %}
-            <img alt="Yocto Project" class="thumbnail" src="{% static 'img/toaster_1.7.png' %}"/>
-	    {% else %}
-            <img alt="Yocto Project" class="thumbnail" src="{% static 'img/toaster.png' %}"/>
-	    {% endif %}
+          <img alt="Yocto Project" class="thumbnail" src="{% static 'img/toaster_bw.png' %}"/>
       </div>
      </div>
     </div>
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


