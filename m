Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 006A472387
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 15:12:20 +0000 (UTC)
Received: by mail-wg0-f53.google.com with SMTP id l18so3819176wgh.26
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 07:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ImF3AKxeTeXXosKNdjrLKRCuqVH8wogzkSQD+0M1qhU=;
	b=Z76hqaGxXRgNdKe4pkW3FmF1N79AGL8ONNlqdgJ4YdiZXRNFRYI0zuU3/HVbFg6jVu
	YG7nZoaJtqZps9tbl4qjg7dP9+uadN4mLT+HS/FYekclpNWDiJLlrcSJ+rwF549Cyi37
	SPhK5HHsbfmwc0X6Zl8jLaVWyCoNJXQb/8YPfIhjQF7u7ziWRnyzBxHn9bVMSZEzfBNN
	+hjVqrXWhc8/woBMUegcHZ75IOcGh6uA6rAJ76UQtSMBc3TpCicj1gwmSlg6fvJmYxau
	TUHv4ly/x/wcYV8DauaDf8pu4QsuKFyHe/ht1KZ1jf7UhM73d/mPr0RGykerkJGHzmel
	6FXw==
X-Gm-Message-State: ALoCoQlERyfFwHRbYDQP1zkKQQ00PCUrJ4LmKyTUhiDYbDF4zueqJcxdIH5Gs0c5rv3bRaCX7fZA
X-Received: by 10.180.76.211 with SMTP id m19mr14184579wiw.73.1418224341252;
	Wed, 10 Dec 2014 07:12:21 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id cz3sm6217917wjb.23.2014.12.10.07.12.19
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Dec 2014 07:12:20 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 6EEA25645F7; Wed, 10 Dec 2014 15:12:17 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Dec 2014 15:12:13 +0000
Message-Id: <d72a8b6d26cb470017bc983184b4fdd2dd257923.1418224064.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
References: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418224064.git.alexandru.damian@intel.com>
References: <cover.1418224064.git.alexandru.damian@intel.com>
Subject: [PATCH 08/11] toaster: libtoaster Add a error handler to GET in makeTypehead
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
X-List-Received-Date: Wed, 10 Dec 2014 15:12:23 -0000

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


