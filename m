Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail.openembedded.org (Postfix) with ESMTP id 4950D7CA47
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Feb 2019 10:41:08 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id q1so4956540wrp.7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Feb 2019 02:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=2SxKCmFE3VPk4V4JjlQuvkE8c9sYCJf97AlLecRPqV8=;
	b=bnvdrpB2cjQ+/kGMCLT+9zqdUfNke5jO8VH2kciyLyV6eDInaCk7PTI+kmOa+naLbC
	zuB32CC/3grlp44jTo5SF6KDC3GBqxeRIGZLCSrgyH2BdpmFZgpK40XVNjF1HODo50k9
	zP3VUN+KXBpkEjGXoGzYILXEMpDyA1hxHbWis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2SxKCmFE3VPk4V4JjlQuvkE8c9sYCJf97AlLecRPqV8=;
	b=IopXQOWC9C3gqIycFKIqu3EcajVXpMMdkmzeCcMf4ZpWJesG1gyoyK3K6ie8yFCbwF
	Kd00OsDfzhFIE41m+6M3K3Ua4bJQfPcoBjQ8sNmWVkSmY78kdJkccV+cjFSB5A+A4/ii
	CXQ2Q6G6kicnzj2Ss4+UhGoDMOdxXRknO62FlcRA2L3wdJvpyWW5q76m57VqQBrn26Vf
	FhzROFb8RJrm7aTvA45kUpe9tHjAgv3tZntdIJbkHN4E8K1soPzHqtZ5bkmc6lAFHxXL
	vXOmsIRcYQwxlz+uth+y+3oa36LVqzMpK4Rfbkd8D2WWo73dJj8j4Fk9UA1F7Ew0olos
	za4w==
X-Gm-Message-State: AHQUAuaD8xrgLxSkGvn/SYkv7WuD7VtFtiZ6JTaEVaHbODwlSvH2jS/3
	9VMeYlOtjlalkKEaeqCfN5BQ9lVHr1Q=
X-Google-Smtp-Source: AHgI3IZ/7i0tcMjSSXbg03fB4Hk2O2R95vmI0Wrlls8XVqwPvyz57nAnBPfVZg0LMUiFX+t05LVpEg==
X-Received: by 2002:adf:cd02:: with SMTP id w2mr1908494wrm.30.1550918468557;
	Sat, 23 Feb 2019 02:41:08 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p1sm4989664wmi.9.2019.02.23.02.41.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 23 Feb 2019 02:41:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Feb 2019 10:41:03 +0000
Message-Id: <20190223104104.11201-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190223104104.11201-1-richard.purdie@linuxfoundation.org>
References: <20190223104104.11201-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/3] siggen: Fix multiconfig corner case
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
X-List-Received-Date: Sat, 23 Feb 2019 10:41:08 -0000
Content-Transfer-Encoding: 8bit

There was already a fix to ignore some multiconfig dependencies but its
'opposite' case wasn't covered. Cover that combination to so as to avoid
tracebacks in multiconfig builds.

[YOCTO #13090]
[YOCTO #13130]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 03aa08bb94..09c9c8a25f 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -184,6 +184,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 depmc = pkgname.split(':')[1]
                 if mc != depmc:
                     continue
+            if dep.startswith("multiconfig:") and not mc:
+                continue
             depname = dataCache.pkg_fn[pkgname]
             if not self.rundep_check(fn, recipename, task, dep, depname, dataCache):
                 continue
-- 
2.20.1


