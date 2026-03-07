Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3619EF55124
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 22:56:07 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19078.1772924161276937038
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 07 Mar 2026 14:56:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=0cQYxO+B;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-480706554beso114570325e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 07 Mar 2026 14:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772924159; x=1773528959; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BD2V4//3fgtgTFv1GtB4Hrs7fhn48BC+0Iv5CVmJjQ8=;
        b=0cQYxO+Bn4rrBu0U8Y3fJPEUZXX5cSKWBPPPSlmbYj50BFQmB8mprfQBKP5gMoZ0a9
         P/k4DAY+Cqkek9IzuHsEdYkt+Vlm/6QSYktH10fN434sP/CTgFHCTIF3BkFfKzeJqbDZ
         2gtMl+t1A+7Stt0bF1ErniNM2GAioFz67j/J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772924159; x=1773528959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BD2V4//3fgtgTFv1GtB4Hrs7fhn48BC+0Iv5CVmJjQ8=;
        b=dO6eFZPv6f4NAFw9kNZb6OLVrI2LHhe7mw7i0hwAzqQ+BVHKr3uduRFK/y9Ti1UH8N
         P/bp2qRu92JrZ6hlvd5FWDL+AlA+4/mimqfgiJXTicVFeYwz+6u7m7zuhgyjvRP4bwWs
         jdHyzrvV/TaBI3A4xvr0XArONKq/J16LrmkvB2kpT4JfZB4VcZZB3cEqflW0YNLrfGJv
         I+2WaIytCqSJ4gfgAt0z7Ikp64mMz5/sDxIAVgp6Q+0omYwrF/+dKmZ7u/aRHIzvcURT
         t2N2EW2YQaVL6ID2JE8qXXSasA1X2Z3qQAYWKsrnT7bZ9a2Y62YqEBolipskN2Jh7W/V
         aHHg==
X-Gm-Message-State: AOJu0Yw3mGldi0twdoYZGIxpI/ZZpt3b65cO6AIsk5vCpn6Y7T5qGwy3
	/iIfKylWANtKNngG1HALpp+34/UmnbGoinr1DztgUaVIapU8Ciwpjb/xdR4RdWX4gBXlklN+9Lj
	ADHoI
X-Gm-Gg: ATEYQzzHVvKHcb4H6kI5XAPsJTxbDEELcF3o8ZpUl8VxaFUz9RJK4/iik9qWy02uRsh
	BBNiyIaUAhfWCzMnt5czIdfg11oDLAORbk+k46nfGb+NZ062amreszb0brUfKyWD430A8iKNJQT
	L45N0bOjOtzf3hykpNu1L34zfLtiO2cnWJtdThp5qzi8DP78XWp7X5OCz20o7qI/boV8FZdAXBc
	ODlYPU+tV7OGQkixzIjuGUIAOtXSE8q1f3Caz7C8t3bbkOoh8dOxTzD9F+KyXqsrPLeTu8+A3y5
	zi7YhCC0VGWgTyAuP3G6+PJHHbcRkooArr+RNA5TLocj3+cLGAMKO6PhHIgDVjeTMxRNK6ITHic
	rAzEYttVQGw3fheH0FNMqVQaeUmL7u0Cysc++Efv7OVepF9hGNrbeZRufGigkT8f9mhnbQ6umQ4
	NfChntksF6CUGIA7ZT/9G+EezmAtLqRHlOOIGdO6Xow1fur2TMVfREWtUicRjbMZsAaxZF2WHus
	b3LrFnG/ss+jOwL/ntM4LvkDws=
X-Received: by 2002:a05:600c:34d2:b0:480:4a4f:c363 with SMTP id 5b1f17b1804b1-48526922ba2mr107037795e9.9.1772924159235;
        Sat, 07 Mar 2026 14:55:59 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b09casm243831915e9.11.2026.03.07.14.55.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 14:55:58 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/1] COW: Fix hardcoded magic numbers and work with python 3.13
Date: Sat,  7 Mar 2026 23:55:47 +0100
Message-ID: <bebecffef63a3ac60420b5347d549f71b00dc151.1772924048.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772924048.git.yoann.congal@smile.fr>
References: <cover.1772924048.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 07 Mar 2026 22:56:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19121

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The COW tests started failing on python 3.13. Looks like it is time
to fix the FIXME and drop the magic numbers!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2e6608cec508b3b9bab3530f83e70665ff638182)
[YC: This fixes the bb.tests.cow.COWTestCase.testOriginalTestSuite
bitbake-selftest on the newly added fedora-41 workers]
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/COW.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index 76bc08a3e..4af03c54a 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -36,8 +36,9 @@ class COWDictMeta(COWMeta):
     __marker__ = tuple()
 
     def __str__(cls):
-        # FIXME: I have magic numbers!
-        return "<COWDict Level: %i Current Keys: %i>" % (cls.__count__, len(cls.__dict__) - 3)
+        ignored_keys = set(["__count__", "__doc__", "__module__", "__firstlineno__", "__static_attributes__"])
+        keys = set(cls.__dict__.keys()) - ignored_keys
+        return "<COWDict Level: %i Current Keys: %i>" % (cls.__count__, len(keys))
 
     __repr__ = __str__
 
@@ -161,8 +162,9 @@ class COWDictMeta(COWMeta):
 
 class COWSetMeta(COWDictMeta):
     def __str__(cls):
-        # FIXME: I have magic numbers!
-        return "<COWSet Level: %i Current Keys: %i>" % (cls.__count__, len(cls.__dict__) - 3)
+        ignored_keys = set(["__count__", "__doc__", "__module__", "__firstlineno__", "__static_attributes__"])
+        keys = set(cls.__dict__.keys()) - ignored_keys
+        return "<COWSet Level: %i Current Keys: %i>" % (cls.__count__, len(keys))
 
     __repr__ = __str__
 

