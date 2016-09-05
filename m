Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id 51E30760B0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:53 +0000 (UTC)
Received: by mail-pf0-f173.google.com with SMTP id w87so7236758pfk.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=2KimDUDmPG5ekYE0MvbakSg5W3dhtUn1wNQmTgNPXsI=;
	b=G6H5gYRtif/ekEbkFeY1WbK/RUwlQGx9PhC4TDJcCLTVuYQIPM9bfpiLfmKnuEMMkO
	mI/8HeGzaTyAPQhn8bRj5m1QGo/kADcp1iCruBPSuVfEZhvtcTaYjr36+XT+gI8f366r
	eNJHjVtcwlJcohqS6hAgjtu1XhqgIuVp8US2VBOvGgajjZreL0aKtEtja+MgK1WKbN+M
	mHR2ZS1NWwkkovw3b6gHxcRK1gLqiAfDtKWF5W7BKxMTr5thJTF13/qF6wvPGN2jduG0
	thHIyc/MIcLC4KJJw6SpEXHhiHcdoVtU9NUcx9CuHIwaaF7tUjdFqP+UbFjO//ZNF95i
	h6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=2KimDUDmPG5ekYE0MvbakSg5W3dhtUn1wNQmTgNPXsI=;
	b=k5tQfB/cnBls9HhDMVKx0HxlrNzOl5vi/6PbPiwdf8gkdYYulCoaLc6j5vZlDw9VXf
	HJOq6z3elHPFKEAobtCf+OMv0kDOB3+4GcSmNJi8OpuHL2Xkx1OhJBnWLsBkAmlZq6MT
	0y4Vm8+4JDlOB5rXDKVZXwiMfCCjGRhmZAOjDFRVGa3GIL9NXZ3RHVBgbTU7qmlez7xw
	RKRJiYFAb0R7q/veUZ6vyAHeTIb4/EdS5Xm3SOYsfCHeqamwwHclOrGJCMVKAzg5fo3Z
	FXAN41Ed3Q0WD/2ytUgz2guGD6kwGNqaPrY7n7TiGby1s+g9529fotBeCJNg27Dg3FRC
	nUKQ==
X-Gm-Message-State: AE9vXwM63ngJLjvC3tOAqkknjBm4Krsc13JAMxGUR2cOiGmKXgfT429nybdwAu6oQFfl+Zka
X-Received: by 10.98.11.65 with SMTP id t62mr31736103pfi.51.1473085793714;
	Mon, 05 Sep 2016 07:29:53 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:53 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:27 +0100
Message-Id: <1473085772-17878-7-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 06/11] toaster: Allow forward slash in variable names
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:54 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

Add forward slash to the list of special characters allowed in variable
names. Also update the list of allowed special characters in the error
messages.

[YOCTO #9611]

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css     | 1 +
 lib/toaster/toastergui/templates/projectconf.html | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 88fe864..ff24e8c 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -182,6 +182,7 @@ dd.variable-list form { margin-top: 10px; }
 .scrolling.has-error { border-color: #a94442; }
 .help-block.text-danger { color: #a94442; }
 .tooltip-inner code { color: #fff; }
+.text-danger > code { color: #a94442; }
 dd.variable-list .glyphicon-question-sign { font-size: 14px; }
 dd.variable-list .glyphicon-edit { font-size: 16px; }
 dt .glyphicon-trash { margin-left: 5px; font-size: 16px; }
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index c3ed216..fcf6df2 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -251,16 +251,16 @@ function validate_new_variable() {
     }
   }
 
-  var bad_chars  = /[^a-zA-Z0-9\-_]/.test(variable);
+  var bad_chars  = /[^a-zA-Z0-9\-_/]/.test(variable);
   var has_spaces = (0 <= variable.indexOf(" "));
   var only_spaces = (0 < variable.length) && (0 == variable.trim().length);
 
   if (only_spaces) {
     error_msg = "A valid variable name cannot include spaces";
   } else if (bad_chars && has_spaces) {
-    error_msg = "A valid variable name can only include letters, numbers, underscores, dashes, and cannot include spaces";
+    error_msg = "A valid variable name can only include letters, numbers and the special characters <code> _ - /</code>. Variable names cannot include spaces";
   } else if (bad_chars) {
-    error_msg = "A valid variable name can only include letters, numbers, underscores, and dashes";
+    error_msg = "A valid variable name can only include letters, numbers and the special characters <code>_ - /</code>";
   }
 
   if ("" != error_msg) {
-- 
2.7.4


