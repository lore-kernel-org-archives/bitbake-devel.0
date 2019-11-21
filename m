Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 3F22D7FA3E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 20:54:21 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id u18so5261326wmc.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 12:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=kmnLb0+fxN8PR4cm7HLvKCTLXeRX6WLybKO91HsPoBU=;
	b=Vu4mUqCs20fe6yx92i+UKtWjxDwGeJiHFnUsPMwmK4+idZJYefYtRoafq7F4RNITsm
	k1GIUIrzz8aPdTq/WcBjIyQqN0HKlHsx++M5vWrbv3gYhwyv0pF9K7cXQUZhfNBixijc
	+0hBSeBK8EivFEPDOCNN3qnkSUouts57fIbs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kmnLb0+fxN8PR4cm7HLvKCTLXeRX6WLybKO91HsPoBU=;
	b=B1bAXf4v1PNjo+heSqvUF0tPHBZ3C29EfwyaSaKXoXamceICVy/d8gdtofFAc1hLiI
	CaYUBFqEk1S42WqXUPpBftgbIyn3W+uL/s2/CSdFB4rQ3gOGp/dubJVSCF1g+XqOHIzS
	ZIFeNmTeytMFjX7tpClgNh4XAsQXuEYR7W+kiJA4i0U+rczC7ezSO/Jp5sGMrXt23UQG
	jJDLDf60yBGEjhDylU89sMymq+gLU0eTBuje3CvlKS+zfIWzEx5iK4JLnkkqGRkdd+Z1
	Xp6o9m4nFAfhDJsBNlGOf/xOCOcklTIgfU8OixmFNC4VwY9G9Ni+ELb1KVgrgvJQqC3k
	bDFw==
X-Gm-Message-State: APjAAAX2imrHmWC83338ycXMcddbP4tI/o3el4HBDxE15h3sMc8fsukA
	EEdNihOxvgB4nmM+SqUP3FExX92+34w=
X-Google-Smtp-Source: APXvYqxJzFySX+bJMHUluS8z3y4OpzDcKJbak+hU2d2GgjmhfcJPPOWrTnRehNHIt7soFzIscuR3+A==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr692972wmc.81.1574369661750;
	Thu, 21 Nov 2019 12:54:21 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	w12sm925982wmi.17.2019.11.21.12.54.20
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 21 Nov 2019 12:54:21 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Nov 2019 20:54:14 +0000
Message-Id: <20191121205415.25946-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
References: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/5] core-image-full-cmdline: Add less
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
X-List-Received-Date: Thu, 21 Nov 2019 20:54:21 -0000
Content-Transfer-Encoding: 8bit

Less was coming from busybox in these images, add the full version.

[YOCTO #13630]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../packagegroups/packagegroup-core-full-cmdline.bb              | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta/recipes-extended/packagegroups/packagegroup-core-full-cmdline.bb b/meta/recipes-extended/packagegroups/packagegroup-core-full-cmdline.bb
index 2d96d1ba385..15a8e6dedc3 100644
--- a/meta/recipes-extended/packagegroups/packagegroup-core-full-cmdline.bb
+++ b/meta/recipes-extended/packagegroups/packagegroup-core-full-cmdline.bb
@@ -81,6 +81,7 @@ RDEPENDS_packagegroup-core-full-cmdline-utils = "\
     gawk \
     gmp \
     grep \
+    less \
     makedevs \
     mc \
     mc-fish \
-- 
2.20.1


