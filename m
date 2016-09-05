Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id 034B0760B0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:47 +0000 (UTC)
Received: by mail-pf0-f175.google.com with SMTP id w87so7236245pfk.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=1/wuQw65iPE4K/ClMb8uFwVtWeF+HOLJL+uqvzmeYiM=;
	b=GgwREgj1nVcLuwRzHtmwc8PFsFtOqfSio4ZQpZuE2CDg7PuucjunIlHut+sGw5xYJ1
	sf633tKOZbPGC0Y/Usp6rAjH38uiK9+Ieebth9Qtax2TwuNo8dFEsmCfDAdvYaYIAYIU
	wuRket2UkVwKos7WpvR31fy1esO5hqy3HGeRQvSJEO4RHhair6xGNVl7JI7p1xZzJ1zU
	MavPG2T5wcvq9TlwO2SCXetPcTfYkeI99Oyx9yhOWEg5JDJeSTn1IiL5tuKgadeyiq+P
	m+4hukZnvFVFL/Zl3aLshJ7p34I+NmPSA60loHHVmSFmHHAHCxB+W7YZ1ZO4CBrE+4q3
	m/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=1/wuQw65iPE4K/ClMb8uFwVtWeF+HOLJL+uqvzmeYiM=;
	b=eMGqc1POaagkklyyMv+QhMpIbQNXKnL7n97IvRHdHKp0ib06WtaMUcY7FGCfH9/Gsc
	xd/qXu6n0xisYneYEYPslL+m5YSlYbfEOC0v8h6TYAucxAtJWngqnWScLKRitVyyNGeR
	JqYrtTgXqSJAS9FNVOjrNwRY7SYZ8R8s9n3HWO3Gzga2J5agxbpA/eEnCKpdmU4ghOqy
	9h5DZo0LY+4y1wWwsXOT6wVAkZs5j5DM8u4qrZrAFxLKHWwE+2DCYYoZPfDGa8iYvyPv
	gOoGTlzEqCmvy7JyudgHAyvlKhZj3zEd+f5V0geOlEZZl4/9Ks2ro1VBrxDRtN2TpULC
	VyTA==
X-Gm-Message-State: AE9vXwOFsLW+ARfFAXIKmu4ApSxmZlcWpPOVQDReto/NptFF2/VH6zeYy17VIH5QrNAzFG+G
X-Received: by 10.98.6.68 with SMTP id 65mr47800658pfg.116.1473085788011;
	Mon, 05 Sep 2016 07:29:48 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:47 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:25 +0100
Message-Id: <1473085772-17878-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 04/11] toaster: import layer Layout fixes
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:47 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

The layout of the import layer form was looking a bit awkward. This
commit tidies things up a bit.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css     |  1 +
 lib/toaster/toastergui/templates/importlayer.html | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 22510e8..88fe864 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -203,6 +203,7 @@ h2 { margin-bottom: 25px; }
 
 /* Style the import layer form controls*/
 legend { border: none; }
+fieldset.fields-apart-from-layer-name { margin-top: 20px; }
 .radioLegend { margin-bottom: 0; }
 #layer-name-ctrl { margin-top: 20px; }
 #import-layer-name,
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index eb02440..1f42696 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -113,16 +113,18 @@
           <span class="glyphicon glyphicon-question-sign get-help" title="You can provide a Git branch, a tag or a commit SHA as the revision"></span>
         </label>
         <input type="text" class="form-control" id="layer-git-ref" required>
-        <span class="help-inline" style="diaply:none;" id="invalid-layer-revision-hint"></span>
+        <span class="help-inline" style="display:none;" id="invalid-layer-revision-hint"></span>
       </div>
     </fieldset>
 
     <fieldset class="fields-apart-from-layer-name" id="local-dir" style="display:none;">
       <legend>Layer directory information</legend>
-	<label for="local-dir-path" class="control-label">Enter the absolute path to the layer directory</label>
-	<input type="text" class="form-control" id="local-dir-path" required/>
-	<p class="help-block" id="hintError-dir-path-starts-with-slash" style="display:none;">The absolute path must start with "/".</p>
-	<p class="help-block" id="hintError-dir-path" style="display:none;">The directory path cannot include spaces or any of these characters: . \ ? % * : | " " &lt; &gt;</p>
+      <div class="form-group">
+        <label for="local-dir-path" class="control-label">Enter the absolute path to the layer directory</label>
+        <input type="text" class="form-control" id="local-dir-path" required/>
+        <p class="help-block" id="hintError-dir-path-starts-with-slash" style="display:none;">The absolute path must start with "/".</p>
+        <p class="help-block" id="hintError-dir-path" style="display:none;">The directory path cannot include spaces or any of these characters: . \ ? % * : | " " &lt; &gt;</p>
+      </div>
     </fieldset>
 
     <fieldset class="fields-apart-from-layer-name">
-- 
2.7.4


