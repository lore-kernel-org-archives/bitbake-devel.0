Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 65B4172513
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:27 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id n3so2188149wiv.17
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=hwzXwUgGtVZWqN5GyO6oFCaInLw8jxQ26BV2icIPwMM=;
	b=efTbS1anfHuBTYhCg5E7JHdmjm06/LF39QRTeSkt8m3jr5vsDFc36GAtwCjTpJqGow
	eg5oT2C5ho4pUM5BaJMQpbDWOK1G2syYu5yOx7NyuincBLoWV0n+uVfxXchxHMKRHUkV
	d0USGHt3w5oNH2I12KIe3SlH4/ftSlNPizx+4aDTQxUTBOHATN8GZZRy0mTNtO9j/7Ip
	2jUMcYdWEQr08TWaSe4Oka2cYnhDPTVkVnGIuczlY3TsBI3kD12tgmtiw9SI58lLDriK
	IlnMVFDeq/GxaUvIfnyL1yM5GTdABx3/IVHgHIhz6PA7VlK/ImhdCUpMnArWNBQGXk9J
	gIOA==
X-Gm-Message-State: ALoCoQmLtHIIhSAu5vKbovzVR9h2v6Ak31NlQuw9eABRXPPxhbiDye6LJ3AWuX8XTuVPSYTU7B6k
X-Received: by 10.194.24.103 with SMTP id t7mr26391314wjf.15.1418384727842;
	Fri, 12 Dec 2014 03:45:27 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id h2sm1750801wix.5.2014.12.12.03.45.22
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:25 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4C46A56626C; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:13 +0000
Message-Id: <54165dd929ef304357806411cd70caf85b6132f0.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 14/18] toaster: importlayer Avoid namespace clash with layer name
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:29 -0000

From: Michael Wood <michael.g.wood@intel.com>

This was causing validation issues as the layer name was being picked up
from a different location in the dom.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js   | 2 +-
 lib/toaster/toastergui/templates/importlayer.html | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 15830dd..34dbcd9 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -4,7 +4,7 @@ function importLayerPageInit (ctx) {
 
   var layerDepBtn = $("#add-layer-dependency-btn");
   var importAndAddBtn = $("#import-and-add-btn");
-  var layerNameInput = $("#layer-name");
+  var layerNameInput = $("#import-layer-name");
   var vcsURLInput = $("#layer-git-repo-url");
   var gitRefInput = $("#layer-git-ref");
   var layerDepInput = $("#layer-dependency");
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 00fd694..c59247f 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -48,12 +48,12 @@
                       </div>
 
                       <div class="control-group" id="layer-name-ctrl">
-                        <label class="control-label" for="layer-name">
+                        <label class="control-label" for="import-layer-name">
                             Layer name
                             <span class="icon-question-sign get-help" title="Something like 'meta-mylayer'. Your layer name must be unique and can only include letters, numbers and dashes" />
                         </label>
                         <div class="controls">
-                          <input id="layer-name" type="text" required autofocus>
+                          <input id="import-layer-name" type="text" required autofocus>
                           <span class="help-inline" style="display: none;" id="invalid-layer-name-hint">A valid layer name can only include letters, numbers and dashes</span>
                           <span class="help-inline" style="display: none;" id="duplicated-layer-name-hint"></span>
                         </div>
-- 
1.9.1


