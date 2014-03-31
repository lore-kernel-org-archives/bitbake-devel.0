Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id A71AA6F92D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:20 +0000 (UTC)
Received: by mail-wi0-f176.google.com with SMTP id r20so3673295wiv.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=5YF8ar4WMCjluFk6vGzND2gTF9VkCy/0Fnudw1eoBLw=;
	b=cB7RnZpr4sKRxEfxdbKuUqZss7N/K6kBxHAEcEJNVXCf2o9cpa85SNVQkFKPTYnVY4
	a9kCQzsYUCx7gwyZ5YUAaiJd7xP8ZPZAj5gLNzspTSP/f8aNEfBH3rwybVpFC7wggSJS
	3Mi2GDYp8t0ffb6mdG+0OUtdUk4bKTuwWNVEGX5JpVUwckLVbLXkGk4pGGUcrKczzvXO
	Mre4Rkjjsl1Cippu9KIIW4rfRMjgHH1B/LYzsQxMIZZIVj9dkpHZw+6K80N7f5T1nPG0
	EMIJultP1S6I9JstwE7XmyG0EKv2Z+dGgE3bAvYn81JRJFwsAwOGhEVEGWn++NkV0COp
	klKw==
X-Gm-Message-State: ALoCoQkDMIKCuD9XSBXN7rOrAmNFRnix+Q8YMtEcpZZDV8Th2v5w9tvIJLyCo+o/iB+cGqDZt0YK
X-Received: by 10.180.149.143 with SMTP id ua15mr13443888wib.36.1396284440949; 
	Mon, 31 Mar 2014 09:47:20 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	pg2sm13284083wjb.36.2014.03.31.09.47.16 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:19 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 1C2F1560421; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:12 +0100
Message-Id: <bccc5463a8366bad9325fc9b5442cf59dee04007.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Subject: [PATCH 12/14] toaster: Update help text in format_vpackage_namehelp tag
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:21 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The text now says that the package has not been built.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templatetags/projecttags.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index aa0ba39..3dd0f3d 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -237,7 +237,7 @@ def format_vpackage_rowclass(size):
 def format_vpackage_namehelp(name):
     r =  name + '&nbsp;'
     r += '<i class="icon-question-sign get-help hover-help"'
-    r += ' title="' + name + ' only has dependency information available.">'
+    r += ' title = "' + name + ' has not been built">'
     r += '</i>'
     return mark_safe(r)
 
-- 
1.9.1


