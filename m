Return-Path: <trevor.woerner@linaro.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
	[209.85.223.169])
	by mail.openembedded.org (Postfix) with ESMTP id 2D38A6D46B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Nov 2013 18:51:49 +0000 (UTC)
Received: by mail-ie0-f169.google.com with SMTP id tp5so1957557ieb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Nov 2013 10:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=AuGnuiHRANIydJYkNxqDDSQyViFBnTe+xhoYqiF6yYU=;
	b=DoipB6s8Gd4EWr0feKmmkdW+Bc8mh60DB08UimE6RBHh+DLyLOGUlAGvOXzvMFnHUx
	P5ChVXFwg2b+MaH0o0IAM0rKVmYxHpzQTdXz6WxqNXs0J43Fql6QMqid4m93WF7Vyjpm
	3Ltxprrhc+qZ0Tfm7d1hrb8aSHS5OAlbpo0cVmRWfNl1boO8i3KyAGDebc5IEvYpFzTt
	SmlqEboXdH2Xezm4KCWemEQx1ktxe1xqdw+/4sQc6CSWLRqhzbM6LXTXBvTF90hn8vEO
	m25Oh36FvsaPAmhNnn1KEWmBRzEAL2Ht9VTauPn/kMAVnm6V4ipXfGu3H7A25wk1Qlua
	HYFw==
X-Gm-Message-State: ALoCoQkg/Q8PXffqh6ZMSmhVhe0Jo9aFIBeMmSPhG8D+FrIjXHmW1yU9p3OKUuhhQjl3994x20XA
X-Received: by 10.50.111.110 with SMTP id ih14mr12476499igb.58.1384195910896; 
	Mon, 11 Nov 2013 10:51:50 -0800 (PST)
Received: from suse64-i7.site (dsl-67-55-9-50.acanac.net. [67.55.9.50])
	by mx.google.com with ESMTPSA id f5sm20104701igc.4.2013.11.11.10.51.49
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Nov 2013 10:51:50 -0800 (PST)
From: Trevor Woerner <trevor.woerner@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 Nov 2013 13:51:30 -0500
Message-Id: <1384195890-1465-1-git-send-email-trevor.woerner@linaro.org>
X-Mailer: git-send-email 1.8.4.474.g128a96c
Cc: patches@linaro.org
Subject: [PATCH] newbb.vim: fix spelling
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
X-List-Received-Date: Mon, 11 Nov 2013 18:51:50 -0000

Signed-off-by: Trevor Woerner <trevor.woerner@linaro.org>
---
 contrib/vim/plugin/newbb.vim | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vim/plugin/newbb.vim b/contrib/vim/plugin/newbb.vim
index 053ed71..3019c85 100755
--- a/contrib/vim/plugin/newbb.vim
+++ b/contrib/vim/plugin/newbb.vim
@@ -17,7 +17,7 @@ endif
 fun! <SID>GetUserName()
     let l:user_name = system("git config --get user.name")
     if v:shell_error
-        return "Unknow User"
+        return "Unknown User"
     else
         return substitute(l:user_name, "\n", "", "")
 endfun
-- 
1.8.4.474.g128a96c


