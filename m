Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id D710E731EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 11:17:31 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 08 Jan 2016 03:17:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,538,1444719600"; d="scan'208";a="722947356"
Received: from deryaeke-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.84])
	by orsmga003.jf.intel.com with ESMTP; 08 Jan 2016 03:17:31 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jan 2016 11:17:20 +0000
Message-Id: <7c7bd6ba6b5091c618b25004585a96e38cffc440.1452251694.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
References: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
In-Reply-To: <cover.1452251694.git.elliot.smith@intel.com>
References: <cover.1452251694.git.elliot.smith@intel.com>
Subject: [PATCH 6/8] toaster: show list of provides for the recipe
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
X-List-Received-Date: Fri, 08 Jan 2016 11:17:32 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Showed list of names that recipe provides.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/templates/recipe.html | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index c6ae2f3..bbe7475 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -71,6 +71,16 @@
                     Layer commit
                 </dt>
                 <dd class="iscommit">{{layer_version.commit}}</dd>
+                {% if object.provides_set.all %}
+                <dt>
+                    <i class="icon-question-sign get-help"
+                     title="A list of aliases by which a particular recipe can be known. The additional aliases are
+                           synonyms for the recipe and can be useful satisfying dependencies of other recipes during
+                           the build"></i>
+                    PROVIDES
+                </dt>
+                 <dd><code>{% for provider in object.provides_set.all %}{{ provider.name }}&nbsp;{% endfor %}</code></dd>
+                {% endif %}
             </dl>
 
             <h2 class="details">Tasks</h2>
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


