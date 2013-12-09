Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 2FB906D840
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:33 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449359940"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:32 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:13 +0000
Message-Id: <5839e5b0af45d4c9e05145b16c4ed5817e152606.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 07/11] toasterui: do not link non-image targets
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:33 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In the Simple UI, builds table, targets that are images
have link to the list of installed packages.

There is no point in having links enabled for the non-image
targets, so we don't link in this case.

    [YOCTO #5366]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldviewer/templates/build.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldviewer/templates/build.html b/lib/toaster/bldviewer/templates/build.html
index ab6e196..5f62350 100644
--- a/lib/toaster/bldviewer/templates/build.html
+++ b/lib/toaster/bldviewer/templates/build.html
@@ -26,7 +26,7 @@
             <td><a href="{% url configuration build.id %}">{{build.get_outcome_display}}</a></td>
             <td>{{build.started_on}}</td>
             <td>{{build.completed_on}}</td>
-            <td>{% for t in build.target_set.all %}<a href="{% url tpackage build.id t.id %}">{{t.target}}</a>{% if t.is_image %} (Img){% endif %}<br/>{% endfor %}</td>
+            <td>{% for t in build.target_set.all %}{%if t.is_image %}<a href="{% url tpackage build.id t.id %}">{% endif %}{{t.target}}{% if t.is_image %}</a>{% endif %}<br/>{% endfor %}</td>
             <td>{{build.machine}}</td>
             <td>{% time_difference build.started_on build.completed_on %}</td>
             <td>{{build.errors_no}}:{% if  build.errors_no %}{% for error in logs %}{% if error.build == build %}{% if error.level == 2 %}<p>{{error.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
-- 
1.8.1.2


