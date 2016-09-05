Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 6ADB0760B0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:51 +0000 (UTC)
Received: by mail-pa0-f53.google.com with SMTP id id6so3973149pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Fj6dA1zBUNKj+zKCxe/zoIRH23mVm+OMBDvllKQKn6U=;
	b=LU+6q98CnrZ7Q0uUa7Qgcu0qfoaKoJRP+Bf6ZycJMbR9veQzPEwxSQia/kCZk/gTa+
	gX4MXL8kwIm1kjxW0kXTB1olvQKt/muqZ0BlDGaGgjIMGmvUhTO6LlafY5+RQayO/hZO
	PmakKaLiOQGE3ITNjgrzdAkIKzpIlWvuONOxVELkTGRTFzMNj6juYOMNsOTmqjhUrsx3
	aUsbX1eu5aQ57uTxCQRJfdYdAwFjh59H7gNwXU4srIPzyQOpmx+xxks7zpbUAiWyJLyB
	dZqoxDFIc3igCI7rPtOCLTjPS1z6Lf8dxQ62ldf5QQ+/eod0n8i72Nr1P4PhHfRpLx4K
	iiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Fj6dA1zBUNKj+zKCxe/zoIRH23mVm+OMBDvllKQKn6U=;
	b=ijQqLhsfTMuA7LK/nXtUrXEwFrYhYnrPm2RzUJG4jNTw8NmZDGojB5c5VoGeKej1l9
	2Gv4znM+soVdcOyS8rbocEMuxtGBCx7kz/uy3vPEylhK/pHBatBcHBNQBVaEH6WF9fOM
	cR1GI+Tcyil7dghv6roZMRw4UOAlg58xaLxZSabL8fsgxnTsmHKOnn2O47ElAUu4/MFF
	wBbftYt1Vp9Mr1zwieqoHHsfnGeNFM2GkSY/ADh8CW+kHfxHbFwK339Vb8r22r3krv62
	s87y4SXZS8yf2JqdZYG8qO3xbilxB9au+E00Uk42xxqkwK2iOMkXTgoRs0dKqMW6Bbkd
	tpDQ==
X-Gm-Message-State: AE9vXwPPPFNu9OL0FN4pgiuVeOS5o0bOwf4wME+I2NthKh5bk46bryfRGE1g0HRCZ6dvkrbn
X-Received: by 10.66.127.38 with SMTP id nd6mr64095791pab.74.1473085791637;
	Mon, 05 Sep 2016 07:29:51 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:49 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:26 +0100
Message-Id: <1473085772-17878-6-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 05/11] toaster: layer details Fix "edit" form interaction
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:51 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

Make sure the layer information disappears when the edit form shows, and
that the layer details come back when you click the 'cancel' button in
the edit form.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js   | 8 ++++----
 lib/toaster/toastergui/templates/layerdetails.html | 5 ++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 5fd7274..8165bad 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -423,7 +423,7 @@ function layerDetailsPageInit (ctx) {
     $(this).hide();
     saveSourceChangesBtn.attr("disabled", "disabled");
 
-    $("#git-repo-info", "#directory-info").hide();
+    $("#git-repo-info, #directory-info").hide();
     $("#edit-layer-source-form").fadeIn();
     if ($("#layer-dir-path-in-details").val() == "") {
       //Local dir path is empty...
@@ -473,9 +473,9 @@ function layerDetailsPageInit (ctx) {
   });
 
   $('#cancel-changes-for-switch').click(function() {
-    $("#edit-layer-source-form").add("#layer-git").add("#layer-dir").fadeOut().promise().done(function(){
-      editLayerSource.show();
-    });
+    $("#edit-layer-source-form").hide();
+    $("#directory-info, #git-repo-info").fadeIn();
+    editLayerSource.show();
   });
 
   saveSourceChangesBtn.click(function() {
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 7dd0c47..0594b55 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -130,8 +130,8 @@
 
           <!-- layer details pane -->
           <div id="information" class="tab-pane active">
-           {% if layerversion.layer.local_source_dir %}
            <h3>Layer source code location</h3>
+           {% if layerversion.layer.local_source_dir %}
            <dl class="dl-horizontal" id="directory-info">
              <dt>
                Path to the layer directory
@@ -200,8 +200,7 @@
                    <input type="radio" name="source-location" id="repo" value="repo">
                    In a <strong>Git repository</strong>
                  </label>
-                 <p class="help-block" style="margin-left:20px;width:70%;">To build the layer Toaster must be able to access the Git repository, otherwise builds will fail. Toaster will\
-                   fetch and checkout your chosen Git revision every time you start a build.</p>
+                 <p class="help-block" style="margin-left:20px;width:70%;">To build the layer Toaster must be able to access the Git repository, otherwise builds will fail. Toaster will fetch and checkout your chosen Git revision every time you start a build.</p>
                </div>
                <div class="radio" style="margin-top:15px;">
                  <label>
-- 
2.7.4


