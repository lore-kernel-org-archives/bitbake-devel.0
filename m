Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id AB93672CA5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:16 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id em10so16856062wid.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=hEodIOkypoYuFrHtlih/KurIrZrMQOge4NLJQO8OheQ=;
	b=jjSOFhp/qXBnNHBRAIVQDD3lpyafq7th48cTxUeCNuw92EusKhYD2D6afWf3gv+Yp1
	KrEB9+XMYh18rkZOmdi0urEk4K4X4x2OoOFZv5oMak0eTVEW4POPpwY4dj6tgkkkMONn
	he109cY7wHMPOCV2o86vrv2ydo9/oeluzespnUP/IG2dDrdVXBViVc2aMVKmGv1ZJJqE
	nNws0+CkEMGVx6C/5qundP6mWZF7qukkYqJQlfqZJYgZuksCjFoz/UIIX7ZTueLHAjWk
	DsLlfz8FbKXfx2uCp4Bv0t2Sa0Ovxns8PN2hzIB1ZNVDWgNjHjQOr81ePwTuRwK5Hrld
	47CA==
X-Gm-Message-State: ALoCoQn7/TW5bdanMCaPvQi4d93Qlvu7MkgSHqglZiYpQWg6Q0mU/LpX5pue506v6DvuogBpixIC
X-Received: by 10.180.7.198 with SMTP id l6mr59664688wia.26.1421864536823;
	Wed, 21 Jan 2015 10:22:16 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fi10sm8290688wib.13.2015.01.21.10.22.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:22:15 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E798556408F; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:35 +0000
Message-Id: <53388c23bef3544ccf3454eea770e0caed65a092.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 05/12] toaster: newproject default release selection fix
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:17 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the default project release selection to
obey the DEFAULT_RELEASE name set in ToasterSettings.

[YOCTO #7035]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/newproject.html | 32 ++++++++++++++----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index 512a8fa..0265564 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -22,18 +22,24 @@
                 <i class="icon-question-sign get-help" title="The version of the build system you want to use"></i>
               </label>
               <select name="projectversion" id="projectversion">
-  {% for release in releases %}
-    <option value="{{release.id}}"{%if projectversion == release.id %} selected{%endif%}>{{release.description}}</option>
-  {% endfor %}
+          {% for release in releases %}
+            <option value="{{release.id}}"
+                {%if defaultbranch == release.name %}
+                selected
+            {%endif%}
+
+             >{{release.description}}</option>
+          {% endfor %}
               </select>
-  {% for release in releases %}
-    <div class="row-fluid helptext" id="description-{{release.id}}" style="display: none">
-        <span class="help-block span5">{{release.helptext|safe}}</span>
-    </div>
-  {% endfor %}
+         {% for release in releases %}
+             <div class="row-fluid helptext" id="description-{{release.id}}" style="display: none">
+                <span class="help-block span5">{{release.helptext|safe}}</span>
+           </div>
+         {% endfor %}
        {% else %}
-    <input type="hidden" name="projectversion" value="{{releases.0.id}}"/>
+        <input type="hidden" name="projectversion" value="{{releases.0.id}}"/>
        {% endif %}
+
             </fieldset>
 
             <div class="form-actions">
@@ -82,11 +88,11 @@
             $("#description-" + selected_release).show();
 
 
-			$('select').change(function(){
-				var new_release = $('select').val();
+            $('select').change(function(){
+                var new_release = $('select').val();
                 $(".helptext").hide();
-				$('#description-' + new_release).fadeIn();
-			});
+                $('#description-' + new_release).fadeIn();
+            });
         })
     </script>
 </div>
-- 
1.9.1


