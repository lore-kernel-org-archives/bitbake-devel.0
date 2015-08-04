Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 626F876541
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 15:07:40 +0000 (UTC)
Received: by wicgj17 with SMTP id gj17so154763333wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Aug 2015 08:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AKz2qMW+noiU9br46hU2NR61FvFvkzJdj3akf5VFgFc=;
	b=iJeLsf5idH9zd/DazZAH5WZ0E2FuunzkXJ8xSfS4LLFHch470l28/O/gN3+7HWcHWR
	X+0YZaEFltTo1VAxQgEWUcNOOZjie71gx9O3G62Vmf2P/SC90scJWc5h57exNEdDVXkV
	yAJY7LsrJLOPYooThhDglO+qg/s6uHAgYhw5ftQrG3mRzeSJauOW8ezCjo7/JNLybuTU
	mbO1Cy9ovesYxEVkNVVqxCOt7Q7IqIRKnul5aBtlWKD44ooaVJzLpivyrKyiz3VNpk8d
	IMqk+xI/eM+vMpPEFSSVpXHD4J6fuU/6zlru1ElhpSUXez3teJ3d/xJ9p+sARWiqjthM
	kmYw==
X-Gm-Message-State: ALoCoQm8lMDeUtTmGHOrdP7HWwAJzeXakmnk7Cne6IOOH7k08x/SfzOihN9x27ZticzmSalFscZM
X-Received: by 10.180.85.231 with SMTP id k7mr458896wiz.73.1438700860932;
	Tue, 04 Aug 2015 08:07:40 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	gm20sm2314260wjc.17.2015.08.04.08.07.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 04 Aug 2015 08:07:40 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 16:07:09 +0100
Message-Id: <1438700831-26829-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
References: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 4/6] bitbake: toastergui: remove project name from layer change notification
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
X-List-Received-Date: Tue, 04 Aug 2015 15:07:41 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The project name is always a link to the basic
configuration page, which looks quite silly when
you change layers from that page.

Since I guess the idea is reusing those notifications
everywhere, I've replaced the project name with a
generic 'to your project' / 'from your project', so
that they read right no matter where you see them.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 22377f0..7edd019 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -280,7 +280,7 @@ var libtoaster = (function (){
     var alertMsg;
 
     if (layerDepsList.length > 0 && add === true) {
-      alertMsg = $("<span>You have added <strong>"+(layerDepsList.length+1)+"</strong> layers to <a id=\"project-affected-name\"></a>: <a id=\"layer-affected-name\"></a> and its dependencies </span>");
+      alertMsg = $("<span>You have added <strong>"+(layerDepsList.length+1)+"</strong> layers to your project: <a id=\"layer-affected-name\"></a> and its dependencies </span>");
 
       /* Build the layer deps list */
       layerDepsList.map(function(layer, i){
@@ -296,15 +296,13 @@ var libtoaster = (function (){
         alertMsg.append(link);
       });
     } else if (layerDepsList.length === 0 && add === true) {
-      alertMsg = $("<span>You have added <strong>1</strong> layer to <a id=\"project-affected-name\"></a>: <a id=\"layer-affected-name\"></a></span></span>");
+      alertMsg = $("<span>You have added <strong>1</strong> layer to your project: <a id=\"layer-affected-name\"></a></span></span>");
     } else if (add === false) {
-      alertMsg = $("<span>You have deleted <strong>1</strong> layer from <a id=\"project-affected-name\"></a>: <a id=\"layer-affected-name\"></a></span>");
+      alertMsg = $("<span>You have deleted <strong>1</strong> layer from your project: <a id=\"layer-affected-name\"></a></span>");
     }
 
     alertMsg.children("#layer-affected-name").text(layer.name);
     alertMsg.children("#layer-affected-name").attr("href", layer.layerdetailurl);
-    alertMsg.children("#project-affected-name").text(libtoaster.ctx.projectName);
-    alertMsg.children("#project-affected-name").attr("href", libtoaster.ctx.projectPageUrl);
 
     return alertMsg.html();
   }
-- 
2.1.4


