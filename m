Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f178.google.com (mail-wj0-f178.google.com
	[209.85.210.178])
	by mail.openembedded.org (Postfix) with ESMTP id 0E84471B3F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:23 +0000 (UTC)
Received: by mail-wj0-f178.google.com with SMTP id v7so30972126wjy.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BUA2T8z9CRGIFlL824Mk8S5KjsHEbXIVg0ZLSKdqCpk=;
	b=xDBsU2uf1ie5U0D79RuzoJq9yxjdLGCJCBp9ilpY5xNzu/tuiNY2dtGWLahTcQiMmX
	aNjW9sx/oK8fZ1siWMsJBSz8M/IugypB51QTtlCprP+Z5/BM0PMj7ytvsr5nfG5Lr+0V
	0dxKSPV14Rl0A2acTV1Rr96OdPVNDejtcEEbiQRpgLPgT1qkm9VBo//MiDzjg5A4gcvQ
	VJ4WdDkOQSZxFscfkoRl7W8MeYZLvi38kmKM1rXWACfEySjDJJWquCcGx4p8Rly7vbAr
	fI7Et/G+s1iNaCgl+r7xi4pxNb+B9K4XEJIajwv16ckyph5TA7llx8rK/nItkMvlXXZG
	ve8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BUA2T8z9CRGIFlL824Mk8S5KjsHEbXIVg0ZLSKdqCpk=;
	b=iw4hVpOwKmW2EsoDffGT6MxGyFg7+gziEEC2VMp3iW1h3tqiMtcBXmzNJT+OBr4dUF
	Tg1vfYtkoDrpk6ljdSdEcbOUnKpK2lckQ53UJ4PNWOuJ6auV5v0olVaWJTpDRHVvS7Jb
	+bIY4WBBMKg/YfTgsczw3OnBjvOKTxOEi0egmGxLGt3ZKHX9KJASDMZcn9wbMZEuj2jD
	KSFEZe2pkb95NCxXkMNLmqaZAznc5Bl+Yg3jeB1JUi431aB6j/vcQSSJ2GCuFfvo5rfO
	w/RJkE7tt7379uj4xa0x33RiuTDUiXmpKK2a6k8F/LKRX5+ZrLL5tMDSlU7PjiNnVzAy
	rZ3g==
X-Gm-Message-State: AKaTC02qE/WuIwIloeHnU+Y5YoqLLe84miJus7VF3tZykm16N7HogjG1Tu/gDc47gGbaW07m
X-Received: by 10.194.246.131 with SMTP id xw3mr1733415wjc.217.1479986424552; 
	Thu, 24 Nov 2016 03:20:24 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:24 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:19:55 +0000
Message-Id: <1479986406-4657-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 04/15] toaster: customrecipejs Consume click event on 'a' link if disabled
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:25 -0000

Consume the click event on the download recipe link if it's disabled. To
prevent the link from sending user to an error page.
See http://getbootstrap.com/css/#forms-disabled-fieldsets and a link
caveat.

[YOCTO #10151]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/customrecipe.js | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/customrecipe.js b/lib/toaster/toastergui/static/js/customrecipe.js
index 9ea9602..8b1c190 100644
--- a/lib/toaster/toastergui/static/js/customrecipe.js
+++ b/lib/toaster/toastergui/static/js/customrecipe.js
@@ -312,5 +312,11 @@ function customRecipePageInit(ctx) {
     });
   });
 
+ /* Stop the download link from working if it is in disabled state
+  * http://getbootstrap.com/css/#forms-disabled-fieldsets
+  */
+ $("a[disabled=disabled]").click(function(e){
+   e.preventDefault();
+ });
 
 }
-- 
2.7.4


