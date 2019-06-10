Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 8284A7E464
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2019 13:39:15 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id x17so9203692wrl.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2019 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GUSvmT6WbvridRed7zPhS+pDYhcPbh/6A3ohgbrs+hs=;
	b=f2AS64ld4Ab5PfHn+KsGXIp+302C+aJhdsrqyHAcmoMqq/D/9b8IY2HgmSf9y1GT8h
	SXd0RdslpDRikyILAO7mcy8AJZjxBrvxEj0TNVaVVXkKIfoRqRtG94bLlfMxtfrdDWPi
	7RLDAhChUdz/aUPchpIiIByt09C1843enZNTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GUSvmT6WbvridRed7zPhS+pDYhcPbh/6A3ohgbrs+hs=;
	b=mIqwWXsX9pJbX50QEP/zH7rUeupo1KfPVG3NmURB7f4Awox1b8WMvlHRemVlkq/a7R
	UDjC3gshuvcddKmYW5rz1UWVe+m79kpvtP+dErNt3DbQRSJacAROkKY1imHmOvnNX2qn
	29pP3J+TPRZRM8+3hRSIzxRqNW6uJUWP6PdYUyxKZVn9/a3Ogz1eQSqnBtC8Z+xILL/i
	DesFhFo0gHcKVwC1KyX/ThIyuLM6o2Sspx8ei1rhJ4m1ou5UhEkC177DuFkaXWjTY7vr
	n1/pqVb7vIH7VAuNtEgpwDLYzCIiXBmKnJBmh8zJ8sq0iZPhYhd+DYY3PQMZK/06SjKD
	KAHg==
X-Gm-Message-State: APjAAAXxBUW584y37yp2WjWdSn9Uxf/3CZUn+fl+q3IR8neoV9eH3SeZ
	P5GGHb8bT1kiM9nQWfQX0KePTHt8kr8=
X-Google-Smtp-Source: APXvYqyoP3nn1C2EIf+YJ4Pck4V6188FvoDWQ3CF3w511PZjgMmM89qm1yHsZ6UxQxy7GVBvijhT8Q==
X-Received: by 2002:adf:9003:: with SMTP id h3mr22966732wrh.172.1560173955843; 
	Mon, 10 Jun 2019 06:39:15 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j8sm9685234wrr.64.2019.06.10.06.39.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 10 Jun 2019 06:39:15 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Jun 2019 14:39:14 +0100
Message-Id: <20190610133914.20291-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] cooker: Add compability handling for multiconfig: prefix migration
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
X-List-Received-Date: Mon, 10 Jun 2019 13:39:15 -0000
Content-Transfer-Encoding: 8bit

This allows "multiconfig:" targets to continue to work by internally
mapping them to the new "mc:" naming, allowing older builds to work
as before.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 855a180523..e0cbed5378 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1600,6 +1600,9 @@ class BBCooker:
         for pkg in pkgs_to_build:
             if pkg in ignore:
                 parselog.warning("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)
+            if pkg.startswith("multiconfig:"):
+                pkgs_to_build.remove(pkg)
+                pkgs_to_build.append(pkg.replace("multiconfig:", "mc:"))
 
         if 'world' in pkgs_to_build:
             pkgs_to_build.remove('world')
-- 
2.20.1


