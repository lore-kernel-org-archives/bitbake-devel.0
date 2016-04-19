Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 96C236FF73
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:28:56 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id n3so39235970wmn.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rEcschHP8XwvHzQ8i+7nkoK+3/i6cUYHV4of8LWLUS4=;
	b=LcfC4x86myeUrip9h0EK6o9ttBK14px60IyqebiZeHfJVlxfLegqHIsXglzl3cy7T/
	a75XVgbHoc2oGaGvB0cJVO+0EPfaUo1t590fMrazzpOfDXuKK+QlQCo3XH0v5YwAxwJY
	CHL2xg4FmRodGShX9i53KA3q/eURyvPLaXAfZ+nC2Rwj6DUYqrNeiOoFASVJ3qcyNysv
	egpx+m55P5UP81kVzyBS9/hi5tjnMyZzC2aNiwMAx8ep2CRN30onaoZDE3sNjQ5OUjNU
	O2ElPRa3xXKefLemnnlEhfjgYU56F78ICztkmu29usLsdI5wXxjbmXAIbINm3f40Ki23
	F6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=rEcschHP8XwvHzQ8i+7nkoK+3/i6cUYHV4of8LWLUS4=;
	b=g6GM+XpEisRYl/MoAcvOL9Y3ruZu4XABTQZbHjKqstO3iP3j+2+EZ4BYveZCJGOmLi
	YTNCbX7y7BJgrmbPxg1rFqBOIcW1XRUmQueyuOF8Jjt07hfa5t2cI1CFbze1wWVB2dZw
	jH8kMF7ic1lph8NOKX/xKgHGuUVcg3UuzIE+BdUXVjE0m+UlZNigQ6v/PAPnIIpw/Eep
	eB4uZz0gCB8UacpZBWA0CGEytNf/QQEsJc2sbpt+LwfdWE5LHdUzu51Xw3hsSkbGTUxq
	FksxMxmbvf72r4V9NUI3+l06PSgT1yvz8Ex8E/0Ql8mFI6lU8VTtAO5Z8X0Leod3YygY
	KAeQ==
X-Gm-Message-State: AOPr4FWHZUOHdnc7qBhZPgrgNf1rmgIQkY3vsHH6mvKVTwQirciV6tQGpSsV31Uilkeo9Fz7
X-Received: by 10.28.58.77 with SMTP id h74mr25857310wma.82.1461083336526;
	Tue, 19 Apr 2016 09:28:56 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.28.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:28:55 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:38 +0100
Message-Id: <1461083327-11668-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
References: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 01/10] toaster: ensure ToasterTable headings are reset when order by changes
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
X-List-Received-Date: Tue, 19 Apr 2016 16:28:58 -0000

If a ToasterTable is ordered by an optional column and that
column is subsequently hidden, the table ordering switches back
to the default ordering for the table. However, the table headings
don't update to reflect the new ordering. This is because the
code which sets the heading weight and hides/shows the caret symbols
only runs when the table is first loaded.

Store the default order by and re-apply it when the data is updated.

[YOCTO #9011]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 2ae7695..f738144 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -239,6 +239,10 @@ function tableInit(ctx){
           }
         }
 
+       if (col.field_name === tableData.default_orderby){
+         title.addClass("default-orderby");
+       }
+
       } else {
         /* Not orderable */
         header.css("font-weight", "normal");
@@ -384,7 +388,7 @@ function tableInit(ctx){
       if (col === tableParams.orderby ||
           '-' + col === tableParams.orderby){
         tableParams.orderby = null;
-        loadData(tableParams);
+        $("#"+ctx.tableName +" .default-orderby").click();
       }
     }
 
-- 
2.5.0


