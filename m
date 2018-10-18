Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id 893F0600E3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 09:22:48 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so4942799wme.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=CUcdyJ+ob/ATyX647C+eN1wtEkDLP27RQicpTEZ+BUw=;
	b=ESsEVGEihmLu2tcmozi0WAxxXnWdO7BBZsw4wQLbtbOnq856xGZrUeuENF7gY0Pav6
	AkioYjI9FW5Fwg8d2gu60e4fDpNBd16tExacI+R54luQXy/Awo+f0p9LiryGQJU9hpmO
	/rpXOdwuqPveLUW0VWtgZFau/uwcRTTH9YFyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=CUcdyJ+ob/ATyX647C+eN1wtEkDLP27RQicpTEZ+BUw=;
	b=BSm3ukgeCZzWuToEciXRTbNhqpZWYkp6V+dMN873G/HykPr7oxwxUtcRi1fIDC4bcx
	qBVL7BkNARNqI0tJxhfCLjA0XdA8FEV5rGZ1YCUhGL2109R2cLm3Fm5olGcIPzhC80Rp
	0yKHgNIWYFObcpcat82meTIaO/EVMWYE2Dw9SCQSpAtGmv6HN1tzjDzzd/eV5DTPfXfF
	S4JkJqNJIwkI2RH3rvlPWaEiNsbvwXfp+Rabvu/FJ9fohgi58ee23muFcqnHCFUftovy
	bSH4Ov6mYj/Dc6rtsfqkehbMqMxPhLgw286Dp2rzPyhCifu24DNHDJoFdGnpJQORWT7M
	StCA==
X-Gm-Message-State: ABuFfoj+8DKXcxEXsVfiTSFuE9F0JKTaZi3YTXwkIBb6t3dxvFHgBpJR
	9vrgzHmuX3Bt7HoBgrHXXUPNL7EqndI=
X-Google-Smtp-Source: ACcGV62RXnA16sder5ZnlhCCIs6dIKLmqYHkiK9HbIPHjST3b3FOeTPxxAN9nQX8qm/a+0EAs8GHBQ==
X-Received: by 2002:a1c:2b03:: with SMTP id
	r3-v6mr4651827wmr.131.1539854568516; 
	Thu, 18 Oct 2018 02:22:48 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x17-v6sm17666494wrs.84.2018.10.18.02.22.47
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 02:22:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Oct 2018 10:22:40 +0100
Message-Id: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 1/7] fetch2: Avoid incorrect getVarFlag call
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
X-List-Received-Date: Thu, 18 Oct 2018 09:22:48 -0000

Calling getVarFlag with flag=None makes no sense, don't do it. Bitbake
used to silently ignore this, it now warns so avoid the warning.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9aea08b387..2b62b41618 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1097,7 +1097,9 @@ def trusted_network(d, url):
         return True
 
     pkgname = d.expand(d.getVar('PN', False))
-    trusted_hosts = d.getVarFlag('BB_ALLOWED_NETWORKS', pkgname, False)
+    trusted_hosts = None
+    if pkgname:
+        trusted_hosts = d.getVarFlag('BB_ALLOWED_NETWORKS', pkgname, False)
 
     if not trusted_hosts:
         trusted_hosts = d.getVar('BB_ALLOWED_NETWORKS')
-- 
2.17.1


