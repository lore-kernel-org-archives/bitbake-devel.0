Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 785417F31C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 12:33:51 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id y21so6015459wmi.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=/B6nVD9F3tpGQEN9D87lrHU8SPUTL0uR+LbPw7uXO5A=;
	b=hL2mnN0iaEO7WvN5RVHh14vpN0ZHaxIG6VS/sllDnohgmyTS/LuEMyvcYxOE91yish
	GX/nJasaMS/NrObKLGLj8eARfIwhDrkTmgQ/gsz3NNLnCgbhkINwIaWFS/Prc+Qkv99w
	yaq6Zx5Kk7ZRYs0cfZ3L4tRd+DQGaBtrvGN4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/B6nVD9F3tpGQEN9D87lrHU8SPUTL0uR+LbPw7uXO5A=;
	b=NfvI017ow2eSPXPZ0iICLRHG2TuhieKQ0S03aS9zjwFhxzrAo+CUfAP/xEI+UmMrWD
	5Iil1g8qvytkre16XpXP2WFSf1SGTsEw1MjN/Ti3GXoI8JG10lLMrUu5TfMDK+ivlAEm
	ILDX9hrtivFbNewIqjRZ7n6JaofiDHQKyClD/dFVk7tDP6PPSspEm1grTSp4G6PkFNEQ
	Ndj26QALbWmGuddVpgmSUY2Tu+jEkCPgF3Dr4x297TrD3SC4xEpkaJY6zz7rbLyevlp/
	Eu/5lz3EWhDRkuvNSf70AeVbmROqjxiXFH8EyQV8VtGAJ1CIvrihfY2O8MVC1D4sUKR7
	VYHA==
X-Gm-Message-State: APjAAAWaAt9olXyeMWFle5ounIsDtadtqShErXKpCn45Hrn0GtuxShHK
	D8eW/7ZHFR9fso8JoDmBDAzWveZCIKE=
X-Google-Smtp-Source: APXvYqxMBuh9+/Ua/WlInfZt4Mh07iFpWZwW6voRzxIqrRHHpYfXFWv4TlaSoFa0nxcwVUU/jI/cOQ==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr6883776wme.103.1569587631962;
	Fri, 27 Sep 2019 05:33:51 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g73sm6543031wme.10.2019.09.27.05.33.50
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 27 Sep 2019 05:33:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 27 Sep 2019 13:33:41 +0100
Message-Id: <20190927123347.19276-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/9] siggen: Ensure setscenetasks list is available to worker context
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
X-List-Received-Date: Fri, 27 Sep 2019 12:33:51 -0000
Content-Transfer-Encoding: 8bit

The setscenetasks list needs to be available in the worker contexts
else the signature behaviour there mismatches what the server does.

Add the data to get/set_taskdata to ensure this happens.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 2b51967c02..71fa018227 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -44,6 +44,7 @@ class SignatureGenerator(object):
         self.file_checksum_values = {}
         self.taints = {}
         self.unitaskhashes = {}
+        self.setscenetasks = {}
 
     def finalise(self, fn, d, varient):
         return
@@ -75,10 +76,10 @@ class SignatureGenerator(object):
         return
 
     def get_taskdata(self):
-        return (self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes)
+        return (self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.setscenetasks)
 
     def set_taskdata(self, data):
-        self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes = data
+        self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.setscenetasks = data
 
     def reset(self, data):
         self.__init__(data)
-- 
2.20.1


