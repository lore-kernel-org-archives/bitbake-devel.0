Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id BB1CD794FA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Sep 2018 05:30:09 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w865UAZu025709
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 5 Sep 2018 22:30:11 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 5 Sep 2018 22:30:10 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Sep 2018 22:26:44 -0700
Message-ID: <2d01c26b16c733cc0125712291ced1ed597814e2.1536210899.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1536210899.git.David.Reyna@windriver.com>
References: <cover.1536210899.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 5/9] toastergui/newproject.html: fix release divs
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
X-List-Received-Date: Thu, 06 Sep 2018 05:30:09 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

The release drop down divs are not being closed
appropriately, which showed adverse reactions on
the UI that aligned the "Create project" button
with the left edge of the screen without any
margins. This fixes these divs which in turn
aligns the button appropriately.

[YOCTO #12891]

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/newproject.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index acb614e..bd03bb5 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -54,12 +54,12 @@
                     <span class="help-block">{{release.helptext|safe}}</span>
                   </div>
                 {% endfor %}
+                </div>
+              </div>
             {% else %}
               <input type="hidden" name="projectversion" value="{{releases.0.id}}"/>
             {% endif %}
                 </div>
-              </div>
-            </fieldset>
         {% endif %}
             <div class="top-air">
               <input type="submit" id="create-project-button" class="btn btn-primary btn-lg" value="Create project"/>
-- 
1.9.1


