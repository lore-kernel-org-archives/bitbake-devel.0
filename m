Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 6E238732CE
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:10 +0000 (UTC)
Received: by mail-pa0-f44.google.com with SMTP id kq14so6545304pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Nut4LsgyDCbXTUrjrqQfdU3bRa3L0G1mSX7FQZc5ofA=;
	b=AaMh0bu322d+xgKWgpICOpKXZs3RzvWusbLWa/szkJxV3qWKwbs6VM7A5EglABdyEK
	06XkEkVoSOIz3gQYpzUnKjrEK1vwe8gb+p4PzF0HQKmC6nLnlipBUK3W8kRNqwqNCjUc
	rSV2b3ZgDYliKARk7odg5Q6nn/rsmIqI1B6WyflhevB9NiT+0/5jDaRwmRwarQSWtuPs
	kCaAGOfnNuPrOTZT/OGrSyRekYxV6XeF4V/xG5ZuxtQExkD8PBw9mnS7RgR+BE8ABIdI
	WIoriBQRODj/ixg0wWFSwQxi4SmPyDP6+hroW5HtXcZANe32esXENpPRtA5BdP6N2pTq
	1IWQ==
X-Gm-Message-State: ALoCoQnC5hi88hxvY1J6Qy6kYm6/9BmrTZYGudh2DZajTkq55ke/5M4Wl8ZCKEQpIflpYwfrvgCK
X-Received: by 10.70.131.68 with SMTP id ok4mr7614679pdb.109.1423504931658;
	Mon, 09 Feb 2015 10:02:11 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	mb6sm17018325pdb.33.2015.02.09.10.02.09
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 61AE25661B4; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:48 +0000
Message-Id: <b3af4f01856c1983f2e77293444e2c3c1b08f879.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 18/27] toaster: layerdetails Don't remove alert from dom on dismissal
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:10 -0000

From: Michael Wood <michael.g.wood@intel.com>

When dismissing the alert we actually want to keep the alert area still
in the dom for the use of future alerts. The default behaviour is to
remove it from the dom. Hide it again instead.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js   | 2 ++
 lib/toaster/toastergui/templates/layerdetails.html | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 9339ae8..99552de 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -261,6 +261,8 @@ function layerDetailsPageInit (ctx) {
     $("#alert-area").show();
   }
 
+  $("#dismiss-alert").click(function(){ $(this).parent().hide() });
+
   /* Add or remove this layer from the project */
   addRmLayerBtn.click(function() {
     var directive = $(this).data('directive');
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 7a1a22d..0321a0b 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -72,7 +72,7 @@
 
     <div class="row-fluid span7 tabbable">
         <div class="alert alert-info lead" id="alert-area" style="display:none">
-          <button type="button" class="close" id="dismiss-alert" data-dismiss="alert">&times;</button>
+          <button type="button" class="close" id="dismiss-alert">&times;</button>
           <span id="alert-msg"></span>
         </div>
         <ul class="nav nav-pills">
-- 
1.9.1


