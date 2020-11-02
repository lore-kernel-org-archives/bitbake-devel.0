Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.29992.1604317113357983579
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Nov 2020 03:38:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S4jo3L/p;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id s9so14173596wro.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Nov 2020 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVIAv/uqcJKIf83d5W4aRzCbHKvLM33ElB6wyKXOQmY=;
        b=S4jo3L/pT2PNuxuyVz9565KRlQulmUOvcYFAn6D4lUvjSr8m3qvcdOAzKY+UvQPpI5
         /z3iyOsW6PlfNv0lueutqHmkM5bq8i8uCi6/Ck2gCuy8jr4yn0XHfzCR1vieuQHXlpQj
         69n3V5ggROI9AaASeJS2ykfYAKXm6dabEzHPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVIAv/uqcJKIf83d5W4aRzCbHKvLM33ElB6wyKXOQmY=;
        b=V/zdVQwU1fV0b88x+J8eXzXw2iMMx6YdS+fXyoHMcyCxV6el8W2ryK+7s5QPTWIAcp
         illZEOn4JyZfP2vUR+HI7lOPYawRzfOYekj/UUE/BxV2eqvdfUqqlRaIS55sgpKdVVWN
         FUfiqOVGgaDig//ZXISeyFFkb3zRzzjyWvozlHPawUng9DvBDZlLwDpYEr84biXFbfRe
         vlSYFmaeMo4uaOakiwO8CoPuUkxcevRPsaekht0RLoxDF2jwEURavWxgtDMBn1xSVV2E
         ONmjcVxYHjGg05d9pZ3Vhb7APcuhXpxFGOblZ1aar4rHtQEXeNIrt3EueF8L8Rx7PosF
         qz1w==
X-Gm-Message-State: AOAM533IWpl5nFakHZL6Z86MKu716sHDb9IuHs44pXCVmON8jI7/WMcq
	8mt80vxbFeB3o63l0dyUuXLjWRknCqAu9A==
X-Google-Smtp-Source: ABdhPJxVLMK7EcJUTX9sO7K+GasHp42Aw0HhrOIvsBFfzDDJM7iJu+oIhLKT42YjsoZ00KnH1XhlUA==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr18670091wro.291.1604317111909;
        Mon, 02 Nov 2020 03:38:31 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.3.f.c.c.4.3.5.e.4.0.8.b.a.1.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:11ab:804e:534c:cf3d])
        by smtp.gmail.com with ESMTPSA id u15sm22089785wrm.77.2020.11.02.03.38.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:38:31 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Remove broken optimisation
Date: Mon,  2 Nov 2020 11:38:31 +0000
Message-Id: <20201102113831.378322-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a single signature is locked, dependent task checksum calculations
fail. This in turn is because get_unihash cannot be cached correctly
by this function. Remove that has turned out to be a poor optimisation
to avoid that bug.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 86e0e16f39..0ac3952466 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -311,13 +311,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         data = self.basehash[tid]
         for dep in self.runtaskdeps[tid]:
-            if dep in self.unihash:
-                if self.unihash[dep] is None:
-                    data = data + self.taskhash[dep]
-                else:
-                    data = data + self.unihash[dep]
-            else:
-                data = data + self.get_unihash(dep)
+            data = data + self.get_unihash(dep)
 
         for (f, cs) in self.file_checksum_values[tid]:
             if cs:
-- 
2.25.1

