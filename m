Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id A6F9975C1B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Jul 2015 16:58:27 +0000 (UTC)
Received: by wibdq8 with SMTP id dq8so79397407wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Jul 2015 09:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Eqc/S9Y59Mi80hYs60VXMEhfHzXc28z7X2PYkdSwpWA=;
	b=gqqozGOitIpLa/SFBkJVBxOyo4ZTdSccQk+p89UuhGZ+Bqq6/jkT69LLfbZkYQuCR2
	BQMG7dIFq5cwbfwCLfmO1k3GY91sjVtFNDuM+3j2zAT76wTXhyBg5eUUHa4Y5QH76Jz0
	Cb9ZUzmxyD34G5BZGah3pE0R0ZgzphrsZWDeP1G+jTIWhywDYbA+ME0fTkuyIHh8icp5
	m8Z+zhXjdjxmI3/s2ZKqtKQlcilf4ePhTDcAvCPG45YiKZMmU/+nr/GcQmx5D6tu3XOv
	8844eH8G6TG3FZTP6iDca3LwrU00pJT7u3wk1UFuvXmwga7+ryzP8LF57IIuHkZsau78
	BRkg==
X-Gm-Message-State: ALoCoQnHZB5uqiV/SUe7IAtfWfoudR30lr/I4/igy3JiLsEPc6fiwX2EFs9WLJwxqHjH+KyNIK8+
X-Received: by 10.180.94.168 with SMTP id dd8mr56313185wib.76.1435856307417;
	Thu, 02 Jul 2015 09:58:27 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ka7sm9007084wjc.36.2015.07.02.09.58.26
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 02 Jul 2015 09:58:26 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Jul 2015 17:58:13 +0100
Message-Id: <1435856296-12531-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
References: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/5] bitbake: toaster: Revert the addition of analysis project mode selection
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
X-List-Received-Date: Thu, 02 Jul 2015 16:58:28 -0000

Partial revert of bb commit 2efc338cefd6e6e097af83d7dff63e9ba177d021

This feature was not ready to go live as the surrounding implementation
work to make this usable has not yet been done.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/newproject.html | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/newproject.html b/bitbake/lib/toaster/toastergui/templates/newproject.html
index 1159d71..745b79b 100644
--- a/bitbake/lib/toaster/toastergui/templates/newproject.html
+++ b/bitbake/lib/toaster/toastergui/templates/newproject.html
@@ -20,7 +20,7 @@
               <label>Project name <span class="muted">(required)</span></label>
               <input type="text" class="input-xlarge" required id="new-project-name" name="projectname">
             </fieldset>
-
+<!--
             <fieldset>
                 <label class="project-form">Project type</label>
                     <label class="project-form radio"><input type="radio" name="ptype" value="analysis" checked/> Analysis Project</label>
@@ -28,7 +28,8 @@
                 {% if releases.count > 0 %}
                     <label class="project-form radio"><input type="radio" name="ptype" value="build" checked /> Build Project</label>
                 {% endif %}
-            </fieldset>
+              </fieldset> -->
+        <input type="hidden" name="ptype" value="build" />
 
         {% if releases.count > 0 %}
             <fieldset class="release">
@@ -63,7 +64,7 @@
             </div>
         </form>
         </div>
-
+        <!--
         <div class="span5 well">
                 <span class="help-block">
                  <h4>Toaster project types</h4>
@@ -76,7 +77,7 @@
                  <h4>Release</h4>
                  <p>If you create a <strong>build project</strong>, you will need to select a <strong>release</strong>,
                  which is the version of the build system you want to use to run your builds.</p>
-               </div>
+             </div> -->
         </div>
     </div>
 
@@ -109,7 +110,7 @@
                 $('#description-' + new_release).fadeIn();
             });
 
-			// Hide the project release when you select an analysis project
+/*			// Hide the project release when you select an analysis project
 			function projectType() {
 				if ($("input[type='radio']:checked").val() == 'build') {
 					$('.release').fadeIn();
@@ -122,8 +123,8 @@
 
 			$('input:radio').change(function(){
 				projectType();
-			});
-        })
+			}); */
+        });
     </script>
 
 {% endblock %}
-- 
2.1.4


