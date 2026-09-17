Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BA8C982DC
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 22:17:21 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1872.1789683434225802872
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 15:17:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=rdnY/3Nz;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so674785e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789683432; x=1790288232; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yftN6kbef3aA7lDqgxCMXRlc5Pv1nKkwSvb4UFeV9I8=;
        b=rdnY/3Nz9GiJ63quLC20VbSukAPLlAY3Z1kmj1anPVIFAwIIOPE9siPgd9ZcUmmd2L
         DdWZ6AmfY81F3QNgyQdIdFXj9150DxUZUGtnSucvbNFcPLehmmMQ3ZgC49WMab3itJRb
         K1BRN0DC9/BgfopJYol8+OoAxvW2vGYEaoHcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683432; x=1790288232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yftN6kbef3aA7lDqgxCMXRlc5Pv1nKkwSvb4UFeV9I8=;
        b=K7RTstL/4cfiQ8EhX/YOY9kGP1GFJaDm4TeX0oiaCdupXmw4Cld8wihfFJ+IfmJUwV
         1Aj2xeW9oraTMKGjvLQdw9E9oAUDSRjBY6gUNAMvAecaLS6z9FC71LHUHJ0ECMPQuF62
         CrYv3+7+QfPMQm3KlFLx4X6fYKyIWnAp0p36LWlcvSWW6aFs5plIHFPlhECjE2AVJ2nW
         0/8WVf8iPfhH8JeIQJYw3osoVy6+kdbTrI9E5JxhGmAhaW1HLZXLu1PpxOmwO2t8wYcw
         SYk4zv7Dmb8Eet+xtLj1gS7tp0Hktm9eab3F0yDsDmoghu4a5tXzFbMVq1EMZW8rEcGo
         RXFw==
X-Gm-Message-State: AFuF++mDFAP6ZKr9HMWv4NqhC4OHH1lYyeyl20o0+U6xnmOVMImcC4Da
	6VrM7UZJYMS+N3TeZhf3vO3zjatQ4tmfvE7BcQRzdRW7RXdh71TkbDH6PHlQyqoZjS37DuYzMVR
	/TXXiroU=
X-Gm-Gg: AYBFou3PkWpA+wJbIy7KOT17sHht+LZ6W4vu1xGSmqd8MTssyeTI8/39abt3Gk0VZiC
	boxQFt6AXCFUrC1WB92DVtRmJyT9pk0WpR/gSr7Rkr2IELr1p++HcBYQiUu8E9ET50q765WHxcD
	RUp9H2zRytK7T9154lBxhmmSiEbO5T4tEmb9vzofifxyoZK8pv4dukKpPXQe2k+q3guwTaCEfPz
	btQ4akM5CARqLnYsl/4AHVWG9Kts63aW10rWNwKb8G5wD4/c/25xuSq5Y/VOu+O/OhVsE//g99+
	X4kgSrxOob9rkN0x6n6JAsOOv0IDfom1ejj7SIA2beWWVOt9RZ+X9/v60gEfEsicEi8gNp9sSig
	+E6ONm4tDtStm1w2vC2GpQ4HNuua+wiFGgzlByuTU675xjUiMeBLXW6BIGPtD5VQSRs7GOxVBFY
	94hFT2e2+6ZnKKTmYEEQz9JInyWLPAJRk7U3cbz5wYBmU3xdAAODzmSjK26XyJewEmMz2JZvHBV
	3CeU8T5hvmW0Ie/FpblGVetIt7oOJeE8uhNSxCb3pefA1Ao0QyUugvhVT0kdoVjbTN0lyRhtng=
X-Received: by 2002:a05:600c:6211:b0:49c:fa20:cbfb with SMTP id 5b1f17b1804b1-49fc5728f84mr3106865e9.18.1789683432450;
        Thu, 17 Sep 2026 15:17:12 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm185737725e9.11.2026.09.17.15.17.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:17:12 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 1/7] fetch2/git.py: add filter_regex parameter to latest_versionstring
Date: Fri, 18 Sep 2026 00:16:59 +0200
Message-ID: <5dc6a868e227e7e8034367ad204ad02e752a12c5.1789683244.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789683244.git.yoann.congal@smile.fr>
References: <cover.1789683244.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 22:17:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20224

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 51842f8bc83203ff19e202361d2bb66e0c9f6381)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/git.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5134ec04c..0649429e5 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -975,7 +975,7 @@ class Git(FetchMethod):
         raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
             (ud.unresolvedrev, ud.host+ud.path))
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
         by searching through the tags output of ls-remote, comparing
@@ -1015,6 +1015,10 @@ class Git(FetchMethod):
 
             pver = m.group('pver').replace("_", ".")
 
+            if filter_regex:
+                if not re.match(filter_regex, pver):
+                    continue
+
             if verstring and bb.utils.vercmp(("0", pver, ""), ("0", verstring, "")) < 0:
                 continue
 

