Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 6AA146013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:03 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id f82so32575804wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=YUZeJ9cOjhJVxlV/1Se5JATRAKpsJFo1iUmRQ86Dy+4=;
	b=nZ/OZgDu6RxiusaQ/+mkxDMgeRtkTlGY7StZ7oY0a+CBCtS5EOHRXXuWoc92ULyFyd
	U8vYGWCNhQbYLDWzJYDhFxP+LJ2Gp8djS1uTY7X+bqP9ms5M4WwyC/FQFy7kpm/VGQCB
	rs346hv5Wq+qLWDgWllqck4e79Te4dqZr5fQFV2eOJwLSKTp42af4q8lBagIm6dYusSZ
	r4hxrCU62JABOxw6vqyF50iNIxoeTpYPZPb6Jg4cUpzw1X4qJAeq7J89FB+OAGqhlH1O
	UFdGH9xzmvYKZVF7pSBkAwQxlOpJ2EwJ5e6wGd/ZEKCbE5jOTX7Wa9scT4taypmDbG51
	gfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=YUZeJ9cOjhJVxlV/1Se5JATRAKpsJFo1iUmRQ86Dy+4=;
	b=CDlyYJXECp7Qbj9u4w2xTFgnqE5+MLWuTouQ/ZjgNTKUIW9x3AWMaY2BX3Dgqdwlnd
	bgL2NVcXwBS+x2cVBp9HkdTHB49Q/osgNcmNjLNPlbcKNcTG4kmh+AFb70Q/nplFpcDd
	kfwDpU1+eu1B2pUJ/inoFmwY5H9rGzDS/+pNeDDxKNSSqGs5kx3BXEnZ+HUhi6d5x06P
	e9+NdPn65f7Jb4SIOckJRIg6BRdiIyCl9O1k2ImzWhuk0qahN8Kin2nxfSwxLHe+0EJI
	hHRgVm9aUG39XpTay+N1ClCWpuv1PW5weaI/GQKjwMAw2q+Jx/sUfR95butcYg23uQXF
	bFSA==
X-Gm-Message-State: AKaTC02vORj2eiRWkMf9jlVpEITwQTE9jnZz7iEJv7hvvT2lbbdK7I3+oRPJS3M2bJlJZB9P
X-Received: by 10.28.67.69 with SMTP id q66mr7517159wma.22.1481302384098;
	Fri, 09 Dec 2016 08:53:04 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:03 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:42 +0000
Message-Id: <1481302375-7985-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 01/14] toaster: tablejs Add visual indicator for table data loading
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:03 -0000

Add a visual indicator when the data is changing in the table, for instance if
it's being re-ordered, searched or paginated.

[YOCTO #10104]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index aaa3e1f..9db3902 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -39,6 +39,8 @@ function tableInit(ctx){
                               ', .show-all-'+ctx.tableName);
 
   function loadData(tableParams){
+    table.trigger("table-loading");
+
     $.ajax({
         type: "GET",
         url: ctx.url,
@@ -835,4 +837,12 @@ function tableInit(ctx){
 
     $('#filter-modal-'+ctx.tableName).modal('hide');
   });
+
+  table.on("table-loading", function(){
+    table.css("opacity", 0.5);
+  });
+
+  table.on("table-done", function(){
+    table.css("opacity", 1);
+  })
 }
-- 
2.7.4


