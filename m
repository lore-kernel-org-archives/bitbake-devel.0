Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 532FF724BB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:23 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id y19so8912645wgg.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ImF3AKxeTeXXosKNdjrLKRCuqVH8wogzkSQD+0M1qhU=;
	b=cRAakrRGQuowXMMw408nnP5IFMwWC0XWBuN28X+Jfpes0Opc9Fzs3ofymkIj08AKn6
	5sFlr+tUXyTnWtIvpsHr/4nGuEQkOLbBWDhzeEYaMKGcyTGWEtZ3Vs5V3ZbCLeK4evgJ
	zJS6iJNYK1YGOSN4kFvL9U6JuYnIRjzVt2PO2JIomUjfToIIEw85Qn9/zFbMcxH8KQVI
	M51mTN8Y5Djm6Wv0e2q2NPjZ1L1544EtGU1oFIubNGFaZEYulx7dmhuSvIwYOq6BKR2t
	ZDLr/XB6UYWEJAPEuqwxkHPmRKINDNaLSIXX7Nqso18nVZcZn0+kw0Hw0Lk38m9A2XE9
	OH3Q==
X-Gm-Message-State: ALoCoQl8YIUzSOVzKe32wLQ1f52BeEs+kast/sPAaItra1JAeekwFuiW+u4+b4IfLyoSzHt16j34
X-Received: by 10.181.28.3 with SMTP id jk3mr7102036wid.16.1418384723194;
	Fri, 12 Dec 2014 03:45:23 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id bj3sm1647350wib.3.2014.12.12.03.45.20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:22 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 3E342566244; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:07 +0000
Message-Id: <9e3f2e2d985a575adb5520d8b517eac5ad6a15ed.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 08/18] toaster: libtoaster Add a error handler to GET in makeTypehead
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:23 -0000

From: Michael Wood <michael.g.wood@intel.com>

If the JSON data comes back from the request with an error set, have a
default handler which logs the error to the console.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 37fc80e..b691a3b 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -20,6 +20,11 @@ var libtoaster = (function (){
         source: function(query, process){
           xhrParams.value = query;
           $.getJSON(xhrUrl, this.options.xhrParams, function(data){
+            if (data.error != "ok") {
+              console.log("Error getting data from server "+data.error);
+              return;
+            }
+
             return process (data.list);
           });
         },
-- 
1.9.1


