Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 20B8D78375
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 04:49:42 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v5F4nhUs003958
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 21:49:44 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.200.76) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 14 Jun 2017 21:49:43 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Jun 2017 21:40:56 -0700
Message-ID: <85d081ada9e3d605a1d285219fb513821ff64bb6.1497501449.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1497501449.git.David.Reyna@windriver.com>
References: <cover.1497501449.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.200.76]
Subject: [PATCH 1/1] toaster: add ID's to navigation links
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
X-List-Received-Date: Thu, 15 Jun 2017 04:49:43 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Add IDs to the navigation bar links "All builds", "All projects",
and "Documentation. This will support test automation.

[YOCTO #11335]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/base.html | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 496dd6e..11c6f91 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -100,7 +100,8 @@
         <div class="collapse navbar-collapse" id="global-nav">
             <ul class="nav navbar-nav">
             {% if request.resolver_match.url_name != 'landing' and request.resolver_match.url_name != 'newproject' %}
-              <li {% if request.resolver_match.url_name == 'all-builds' %}
+              <li id="navbar-all-builds"
+              {% if request.resolver_match.url_name == 'all-builds' %}
               class="active"
               {% endif %}>
               <a href="{% url 'all-builds' %}">
@@ -108,7 +109,8 @@
                 All builds
               </a>
               </li>
-              <li {% if request.resolver_match.url_name == 'all-projects'  %}
+              <li id="navbar-all-projects"
+              {% if request.resolver_match.url_name == 'all-projects'  %}
               class="active"
               {% endif %}>
               <a href="{% url 'all-projects' %}">
@@ -117,7 +119,7 @@
               </a>
               </li>
             {% endif %}
-              <li>
+              <li id="navbar-docs">
               <a target="_blank" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
                 <i class="glyphicon glyphicon-book"></i>
                 Documentation
-- 
1.9.1


