Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id EFAC578577
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Nov 2017 09:03:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id vAU93FAK009515
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Nov 2017 01:03:15 -0800
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 30 Nov 2017 01:03:14 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 30 Nov 2017 00:55:27 -0800
Message-ID: <40d8de288429dacc7e78f4e2fbb1f6d36b5466ce.1512030424.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1512030424.git.David.Reyna@windriver.com>
References: <cover.1512030424.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH V2 5/6] toaster: landing page show cmdline capture
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
X-List-Received-Date: Thu, 30 Nov 2017 09:03:14 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The Toaster initial landing page needs to show that it still has
the command line build capture support in addition to the new
project support.

[YOCTO #12316]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/landing.html | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
index 4986632..cf7516d 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -14,10 +14,16 @@
 
               <p>A web interface to <a href="http://www.openembedded.org">OpenEmbedded</a> and <a href="http://www.yoctoproject.org/tools-resources/projects/bitbake">BitBake</a>, the <a href="http://www.yoctoproject.org">Yocto Project</a> build system.</p>
 
+		          <p class="top-air">
+		            <a class="btn btn-info btn-lg" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html#toaster-manual-setup-and-use">
+			            Toaster is ready to capture your command line builds
+		            </a>
+		          </p>
+
 		          {% if lvs_nos %}
 		            <p class="top-air">
 		              <a class="btn btn-primary btn-lg" href="{% url 'newproject' %}">
-			              To start building, create your first Toaster project
+			              Create your first Toaster project to run manage builds
 		              </a>
 		            </p>
 		          {% else %}
-- 
1.9.1


