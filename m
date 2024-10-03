Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1735CF34A3
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 12:31:23 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.10190.1727958682546057105
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 05:31:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JR6fypfA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae102702so7310985e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 05:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727958681; x=1728563481; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xkkPCPfKEMmjFLM8D1jGEC3Z/sB1AWbZTK+36QpNdFs=;
        b=JR6fypfArJ8gVBWbGtq5NO8FOOetUw2XSLKVmjtcW3/VFnrMvRY02OPRVwi0j8yRNu
         APNjWzzSTcJwFAdoA6HFUyejhUFFk6u6CZtM1iC/JxmpSlmnm0+tcJabvR9y6oTBzmNt
         f29YLasfopVK8pqNCWk9F50MiycxxPbmNgdfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727958681; x=1728563481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkkPCPfKEMmjFLM8D1jGEC3Z/sB1AWbZTK+36QpNdFs=;
        b=SpUcA9ftVmqXe982gIioE7lzq+5UcMLrT9SkVyjlEDTiLhLr5Y6xGLuR9HE7ajvOJy
         hlNOHqIskcWvoV9nzB/BBVO3OKBRUDOF8Z51nGjFRYAj2VDCsW/eFFPSGAPadBT+X1Jl
         oWhpHWfP4sUySiA6XJalcxHDTlv5R8AVFf77r4iaKsG9j5TwNLVIAbRAs7c9rhYY4O8Q
         TACGgupn9T7cQ/wdKMht7MxwjLiJWSdZ08ku6oJ/XHcxIIXwHwQ0MP241ijdfkT9S+f/
         MtKncGuivBDOID4BCPcqkb4xFB22YUNWI58NhFTm4JOtsiMbUxkg0X2a7umAJ7hdVHCI
         d9ng==
X-Gm-Message-State: AOJu0YwH7Onl6gmZa6bGIzXuDyQQvJ4Jopaa6BwQoxKSQ758mYW5fke+
	HNJcfJjkPkh49S8LOuj9d5BHI+wtnlBT4GiKRvXNEO6Da9mko5yd/yPLsJjNuP4uEXZY0bUx+uR
	7
X-Google-Smtp-Source: AGHT+IG4S0Fpwqswl7haUBabYZF9G1eNR6rggr2MnEBwLyGbiDSGNTl21b80zc1ADVDPZ0/C2eL1Sg==
X-Received: by 2002:a05:600c:4714:b0:425:5ec3:570b with SMTP id 5b1f17b1804b1-42f778ffa8cmr40173705e9.35.1727958680446;
        Thu, 03 Oct 2024 05:31:20 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:cae3:f165:6194:3295])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6a71sm1179153f8f.73.2024.10.03.05.31.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 05:31:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] COW: Fix hardcoded magic numbers and work with python 3.13
Date: Thu,  3 Oct 2024 13:31:19 +0100
Message-ID: <20241003123119.3544028-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 12:31:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16634

The COW tests started failing on python 3.13. Looks like it is time
to fix the FIXME and drop the magic numbers!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/COW.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index 76bc08a3ea..4af03c54ad 100644
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
 

