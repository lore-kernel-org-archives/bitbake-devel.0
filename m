Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id A0C2F75692
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:15:15 +0000 (UTC)
Received: by wicmx19 with SMTP id mx19so148271323wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=dNrPyCZvgIK6aAkN63k3K3zirV99JzLn1TATJfpmwY4=;
	b=Sx3U9G+XdC7qSgY9/15HuKrHiG9g/G+vkqrF3Sec71jpJ86yTYs4c7HMNs6AX21o/d
	wMAGOPodIv4pollXrTAUGezkIAR4WeXHl3ZUAP5J1e5RTsgKc2mT1gtjzn/ZIv2ujz4K
	XzT6dcg1+vJlTT45+qtmxShi9OJSIlDfli1Gy/d02TKvPQV1BsWT1FiZ9qOVio6IodQ/
	Y9ganfTgetKqD+jMdfaSiEXKEUetgm9O76uuIhMS7R8b2FH6e3+U9FRH4UOJviQ+JCUW
	y6eYc45lM+RCFt8x2hc22z7/FL4v2a4CHMVRktvH9NrQAb4kp8KE4Av7Z+jKd5ssFT4z
	L4LQ==
X-Gm-Message-State: ALoCoQnu+LQ2P4ZOzpP7R792mXBWVkRxurtFUp66AgAcBLvHd/C7kf3hmAKl+nXb/khV/Srb7IBH
X-Received: by 10.180.14.193 with SMTP id r1mr60811601wic.47.1432822516196;
	Thu, 28 May 2015 07:15:16 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fh6sm8770400wic.5.2015.05.28.07.15.14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:15:15 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BD4E256122E; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:13:59 +0100
Message-Id: <1f62be2fc978545bb201d20452fb65fcf3fd2a65.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 05/22] toastergui: table header bring back
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
X-List-Received-Date: Thu, 28 May 2015 14:15:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings back the table header, which I mistakenly
took out when fixing HTML5 compliance.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/table.js          | 2 +-
 lib/toaster/toastergui/templates/toastertable.html | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 8f5bb2e..97370fd 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -163,7 +163,7 @@ function tableInit(ctx){
     if (tableChromeDone === true)
       return;
 
-    var tableHeadRow = table.find("thead tr");
+    var tableHeadRow = table.find("thead#tableheader");
     var editColMenu = $("#table-chrome-"+ctx.tableName).find(".editcol");
 
     tableHeadRow.html("");
diff --git a/lib/toaster/toastergui/templates/toastertable.html b/lib/toaster/toastergui/templates/toastertable.html
index 598d295..21392bb 100644
--- a/lib/toaster/toastergui/templates/toastertable.html
+++ b/lib/toaster/toastergui/templates/toastertable.html
@@ -92,7 +92,7 @@
 
   <!-- The actual table -->
   <table class="table table-bordered table-hover tablesorter" id="{{table_name}}">
-    <thead>
+    <thead id="tableheader">
     </thead>
     <tbody></tbody>
   </table>
-- 
1.9.1


