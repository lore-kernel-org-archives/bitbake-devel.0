Return-Path: <raj.khem@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id C7CFE61622
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Sep 2013 21:10:40 +0000 (UTC)
Received: by mail-pa0-f43.google.com with SMTP id hz10so2424854pad.30
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Sep 2013 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=8X7RzZgWxIjL8lnEUknhzO7OmopYA1o/QI/8iNSKIgk=;
	b=Mxxl4F4bR1mSS3XGPC5Ewmkvzg6HWcgZxKhvBGwGgO2PHcawjwSpJ4DZGKUdQSRl5v
	kJN1EZ0rls0K9uceVsA72DWKmYsO3tNMVBZMVF4lbfENBvJIisW/AoJ1ao2XCt8IZCC4
	w45aG/BdLInpyDvLI7y9D7j8pwBbOZKPobY4UhUyI5rDXXFbFncRdoG5iEkI4nlsq0NJ
	aBAP0O/dKld01kQ+5ePCvVAqkCcroeBLeHaDgB+W6YfABFKCRE0f/jajH1tyOIC8LNhy
	ig/hRIqP0nJpdloNhS5czzAGrIVL10UM7wi2xAam9Xyw/rZr+4Hi66twWHNu+EJBLEs4
	HgpQ==
X-Received: by 10.68.232.74 with SMTP id tm10mr11521361pbc.64.1378415442995;
	Thu, 05 Sep 2013 14:10:42 -0700 (PDT)
Received: from isis.gateway.2wire.net
	(99-57-140-209.lightspeed.sntcca.sbcglobal.net. [99.57.140.209])
	by mx.google.com with ESMTPSA id
	om2sm37707355pbc.30.1969.12.31.16.00.00
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 05 Sep 2013 14:10:42 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Sep 2013 14:09:20 -0700
Message-Id: <1378415360-13657-1-git-send-email-raj.khem@gmail.com>
X-Mailer: git-send-email 1.8.4
Subject: [PATCH] newbb.vim: Use 'git config' instead of git-config
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
X-List-Received-Date: Thu, 05 Sep 2013 21:10:40 -0000

Newer versions of git do not have the '-' concatenated command

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 bitbake/contrib/vim/plugin/newbb.vim | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/contrib/vim/plugin/newbb.vim b/bitbake/contrib/vim/plugin/newbb.vim
index afba1d9..053ed71 100755
--- a/bitbake/contrib/vim/plugin/newbb.vim
+++ b/bitbake/contrib/vim/plugin/newbb.vim
@@ -15,7 +15,7 @@ if &compatible || v:version < 600
 endif
 
 fun! <SID>GetUserName()
-    let l:user_name = system("git-config --get user.name")
+    let l:user_name = system("git config --get user.name")
     if v:shell_error
         return "Unknow User"
     else
@@ -23,7 +23,7 @@ fun! <SID>GetUserName()
 endfun
 
 fun! <SID>GetUserEmail()
-    let l:user_email = system("git-config --get user.email")
+    let l:user_email = system("git config --get user.email")
     if v:shell_error
         return "unknow@user.org"
     else
-- 
1.8.4


