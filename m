Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F9CEF164
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 12:36:31 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.8046.1728390990708555304
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 05:36:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LE/sLVmK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so50080295e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 05:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728390989; x=1728995789; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xkkPCPfKEMmjFLM8D1jGEC3Z/sB1AWbZTK+36QpNdFs=;
        b=LE/sLVmKYohWGvJaAd3QSsYHdn0T62oZ839pN4Npi1aH22qG2ZTRfHpPqZ+C5ei6ZK
         9+/chh4jaoQmdAt/deg4HbUNuNkCoXcIE0MaBs7rFbcXtrWo4GP5nFG3vTfNPLcCccSt
         cuLqzvEK+szyDN6EeI4/7GFmlW2HCSaSuRD5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390989; x=1728995789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkkPCPfKEMmjFLM8D1jGEC3Z/sB1AWbZTK+36QpNdFs=;
        b=rKRGOPFzcOl0APiIt9iYE3BP1KUBsBMe9Lb+dAxg6v3YcMf7evxynFUOSAYV807aZu
         pruiKfiiSg7g3g0Z7n/dOPooCQaDV2ARE2e+bxvRirtauR+xyhw4tK/Dvi82nhd5IAwa
         Kdknp5uYw5g2bfwkkUF+U2eFsfZnGnM+SlXXpmLxV09ocXolHhF138iZ7rB6hgvI1tl7
         ljbOi3h2T5Pgs+w40NhkOUWALak7BPHjwjyQWlPm4kKQFvLStCv3OrO9iMj03BXAgzNN
         h5mbVgbQJM9b+SGIGH8kRx1Ro6qbXzk8q+/GrBxJrUsjd3N9xIwWB6EBbrOLl4gyuIww
         KPzQ==
X-Gm-Message-State: AOJu0Yx+BP0ZzkpB1V1a/ifNUW1Oaxy7h6ixed9gpdYkEU8GCa3vLCxM
	aTLYSR8zI7HI9wrvmrxTkz6InvRSp05WGtsXBDiPNM/GMYupXgLdR+SJ3czurJ0JIPHQuuxIJNe
	q
X-Google-Smtp-Source: AGHT+IGczexDuxpqAabtRiVaFp3Y6htlvk59RQLlxfAyvzIst9CAKvGwml7vCTjf7GGO/CCG2q8E/A==
X-Received: by 2002:a5d:5582:0:b0:37c:cc01:f7e with SMTP id ffacd0b85a97d-37d0e8d98e0mr7814938f8f.58.1728390988754;
        Tue, 08 Oct 2024 05:36:28 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f9a:5ae5:8636:3d57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a47esm8019492f8f.28.2024.10.08.05.36.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:36:28 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/8] COW: Fix hardcoded magic numbers and work with python 3.13
Date: Tue,  8 Oct 2024 13:36:20 +0100
Message-ID: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 12:36:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16654

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
 

