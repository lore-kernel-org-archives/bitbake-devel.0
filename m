Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id F114C724D3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 12:46:58 +0000 (UTC)
Received: by mail-pa0-f43.google.com with SMTP id kx10so10379887pab.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 04:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=RF1NFMJYD7c75FBTyb02q0+C6mejEi6fB/FoMqsg1nM=;
	b=Fs7aqxAh3MFm4RjIS6PfgtS0dE+GDNsrlhPXK1iHTAWiYbEBRvU8G/61IP0Zypx+rb
	szX2JAkXrHuj7aNzlWhVKjXL7vrNTAgy+51YB2byU0QEQ1rl47ynEPsO3JRFDtBRua0m
	NfsBj3s6x796es2T133obfNsM8ArmBe49bx999ZdhWyEwCGbD9Skp3yZrDgQSm02Visu
	nNztnbiXk7n9tzzp/OPxsotIFuWz9VX5RmDgeQ5tJwG848FoN00IdWAx2C6hoCd/Det0
	vP/aVvZiUBwyuUP7XSiPSZ9heDwcYguNC/upfGzxRnPl37NJMEXbmEGKti/VSsF9Yml1
	Y1cA==
X-Gm-Message-State: ALoCoQl0fBJr4kPZzCVQXViff6qJK95S8SmoAjoELbVvs+uJnwo05VtTs2O6nfzfnCIiyxFHe/CD
X-Received: by 10.66.102.41 with SMTP id fl9mr5414899pab.7.1421239618795;
	Wed, 14 Jan 2015 04:46:58 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ta9sm19649806pbc.50.2015.01.14.04.46.57
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 14 Jan 2015 04:46:57 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EC8005607FA; Wed, 14 Jan 2015 12:46:56 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Jan 2015 12:46:53 +0000
Message-Id: <ee31ca40cd4cf3832fac3ea4e500aaf931eadce9.1421239131.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <37d047c01cabee67a55e0750bfe51ec407be6b09.1421239131.git.alexandru.damian@intel.com>
References: <37d047c01cabee67a55e0750bfe51ec407be6b09.1421239131.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421239131.git.alexandru.damian@intel.com>
References: <cover.1421239131.git.alexandru.damian@intel.com>
Subject: [PATCH 2/4] toaster: layerdetails Remove compatibility setting
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
X-List-Received-Date: Wed, 14 Jan 2015 12:47:01 -0000

From: Michael Wood <michael.g.wood@intel.com>

Remove the layer compatibility configuration option from the layer
details as this is not in the design.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js   | 10 ++--------
 lib/toaster/toastergui/templates/layerdetails.html | 21 +--------------------
 lib/toaster/toastergui/views.py                    |  1 -
 3 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index a5a6330..41cbf4b 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -309,8 +309,6 @@ function layerDetailsPageInit (ctx) {
     var entryElement = mParent.find("input");
     if (entryElement.length == 0)
       entryElement = mParent.find("textarea");
-    if (entryElement.length == 0)
-      entryElement = mParent.find("select");
     if (entryElement.length == 0) {
       console.warn("Could not find element to get data from for this change");
       return;
@@ -331,12 +329,8 @@ function layerDetailsPageInit (ctx) {
             /* success layer property changed */
             var inputArea = mParent.parents("dd");
             var text;
-            /* We don't actually want the value from the select option we want
-             * the text that represents the value to display
-             */
-            text = entryElement.children("option:selected").text();
-            if (!text)
-              text = entryElement.val();
+
+            text = entryElement.val();
 
             /* Hide the "Not set" text if it's visible */
             inputArea.find(".muted").hide();
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index c69f9e9..5bed0f8 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -160,26 +160,7 @@
                     </form>
                     <i class="icon-pencil"></i>
                   </dd>
-                  <dt>
-                    <i class="icon-question-sign get-help" title="The Yocto Project versions with which this layer is compatible. Currently Toaster supports Yocto Project 1.6 and 1.7"></i>
-                    Yocto Project compatibility
-                  </dt>
-                  <dd>
-                    <span class="current-value">{{layerversion.up_branch.name}}</span>
-                    <form style="display:none">
-                      <div class="input-append">
-                        <select name="projectversion" id="projectversion">
-                          {% for compat in yocto_compat %}
-                          <option value="{{compat.id}}" {%if layerversion.up_branch.id == compat.id %} selected{%endif%}>{{compat.name}}</option>
-                          {% endfor %}
-                        </select>
-                        <button  data-layer-prop="up_branch" class="btn change-btn" type="button">Save</button>
-                        <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
-                      </div>
-                    </form>
-                    <i class="icon-pencil"></i>
-                  </dd>
-                  <dt>
+                 <dt>
                     <i class="icon-question-sign get-help" title="Other layers this layer depends upon"></i>
                     Layer dependencies
                   </dt>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 7a9d662..e414b66 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2524,7 +2524,6 @@ if toastermain.settings.MANAGED:
         context = {
             'layerversion': layer_version,
             'layer_in_project' : ProjectLayer.objects.filter(project_id=request.session['project_id'],layercommit=layerid).count(),
-            'yocto_compat': Branch.objects.filter(layer_source=layer_version.layer_source),
             'machines': machines,
             'targets': targets,
             'total_targets': Recipe.objects.filter(layer_version=layer_version).count(),
-- 
1.9.1


