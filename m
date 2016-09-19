Return-Path: <brian.avery@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id D8AB0731CF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2016 02:31:53 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 18 Sep 2016 19:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,360,1470726000"; d="scan'208";a="1032847460"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga001.jf.intel.com with ESMTP; 18 Sep 2016 19:31:53 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 18 Sep 2016 19:33:15 -0700
Message-Id: <58fe1ad0b87766312f844fa35ad62902ab573166.1474252113.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b5b92903847dc0eb537848585ee338a1a8bcb15f.1474252113.git.brian.avery@intel.com>
References: <b5b92903847dc0eb537848585ee338a1a8bcb15f.1474252113.git.brian.avery@intel.com>
In-Reply-To: <cover.1474252113.git.brian.avery@intel.com>
References: <cover.1474252113.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 3/3] toaster: Remove duplicate layer information
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
X-List-Received-Date: Mon, 19 Sep 2016 02:31:54 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

In the custom recipe details page, the layer information is displayed
twice in the right hand column. Remove one of the layer entries, since
showing the layer information once should be enough.

[YOCTO #10037]

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/toastergui/templates/customrecipe.html | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/customrecipe.html b/lib/toaster/toastergui/templates/customrecipe.html
index f2a8fd2..8b61fb7 100644
--- a/lib/toaster/toastergui/templates/customrecipe.html
+++ b/lib/toaster/toastergui/templates/customrecipe.html
@@ -176,8 +176,6 @@
         <a href="{% url 'projectbuilds' project.id%}">{{last_build.completed_on|date:"d/m/y H:i"}}</a>
         </dd>
         {% endif %}
-        <dt>Layer</dt>
-        <dd><a href="{% url 'layerdetails' project.id recipe.layer_version.pk %}">{{recipe.layer_version.layer.name}}</a></dd>
         <dt>Based on</dt>
         <dd><a href="{% url 'recipedetails' project.id recipe.base_recipe.pk %}">{{recipe.base_recipe.name}}</a></dd>
         {% if recipe.get_last_successful_built_target %}
-- 
1.9.1


