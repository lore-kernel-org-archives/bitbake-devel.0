Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id 487F17325C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:01:59 +0000 (UTC)
Received: by pdjp10 with SMTP id p10so22762537pdj.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=X3Ea5/yAx5uIObnzJkVAdCVgh3m1xAUrSrHeQMa2ssY=;
	b=GKYStXVIXgWbAZ0O+gHVCUKmA/D9QlDV1lEBZitLSpD+/5IH7eaO49vKYKJvLjyVin
	zG1O/zNR1EFIEXXpMIdAT+UeWfKl5BpmVPiJN1BjVh2e3CfU+bDZtRaBtpUwd+sR9y4l
	g4WO0Am8cEEDoRvb2biDGPdREZC2Qse2sNT4AEu83NbrXlphWTeTKBNOaYZ9aQDGIwBJ
	xzsUToKlvnsZza5T9gbqf9qJa72vNX+z5HNux85q1ENclKQ+8qAkpYV7XrQwwEF18K9J
	FBq7wjfAvbhF1w0OFZDgh6FJfkpZ8CnpUTkc1m42K3ciPZ55TOGrhzPrunOW4B8OPIeg
	pmuQ==
X-Gm-Message-State: ALoCoQnpqxDk8cKMm19p5gEy42jtoBTgqiT7PmuXhXOTQBViRai2WvhfiIfXi3NVuQXp1oEeEgev
X-Received: by 10.70.34.65 with SMTP id x1mr30501718pdi.120.1423504920883;
	Mon, 09 Feb 2015 10:02:00 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ca4sm4084554pbb.24.2015.02.09.10.01.59
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:00 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4858B56618B; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:32 +0000
Message-Id: <b96457870b40ba60dd5c86d83c43093d09b70aea.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 02/27] toasterui: use text() instead of html()
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:04 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Use the text() jQuery function instead of the html()
one for security reasons.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 2793225..9339ae8 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -252,10 +252,10 @@ function layerDetailsPageInit (ctx) {
           break;
       }
 
-      alertMsg.append("You have deleted <strong>1</strong> layer from <a id=\"project-affected-name\"></a>: <span id=\"layer-affected-name\"></span>");
+      alertMsg.append("You have deleted <strong>1</strong> layer from <a id=\"project-affected-name\"></a>: <strong id=\"layer-affected-name\"></strong>");
     }
 
-    alertMsg.children("#layer-affected-name").html("<strong>" + ctx.layerVersion.name + "</strong>");
+    alertMsg.children("#layer-affected-name").text(ctx.layerVersion.name);
     alertMsg.children("#project-affected-name").text(ctx.projectName);
     alertMsg.children("#project-affected-name").attr("href", ctx.projectPageUrl);
     $("#alert-area").show();
-- 
1.9.1


