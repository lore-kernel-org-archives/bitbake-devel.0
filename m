Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4908C2BA15
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 12:24:15 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web11.54900.1718627052719725230
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jun 2024 05:24:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=yOfB/Lie;
 spf=softfail (domain: sakoman.com, ip: 209.85.161.54, mailfrom: steve@sakoman.com)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bad217c51aso2366409eaf.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 05:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1718627052; x=1719231852; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdqWBKmQVmS4eSqIPSRd8J5EdFOYnlxgVZ8vKFehHII=;
        b=yOfB/LiejIjVQHhP94jQEEfNYpSUs9y4z+rIWPS8WYGLF+mBU3JuI67wQogQPdq8LH
         6IhEwmkLDmhrDKWlRW4NtDqW8oZOkaE/AstJNDso80q5u99a/OfzIcRDvHguipwx4UP5
         +FBfF1+uZm+g6WL4q3SE7R+E9qcGbOeShBOA73V5D2AM+ohVUka6pUeau25iA3qpoY2S
         eJuB7I1rmkWfav7NMyve6CrUMOkIiijwPXzIcEL8jqcQ7psawhzfzMeEKas1iQjQmArH
         zVrEl3YKMtMYAQ2C7orLEL1eeSjaqav/q4j1AHgmvS/Rtsk1TGKt8hApgzmWqJCGidgV
         w/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627052; x=1719231852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdqWBKmQVmS4eSqIPSRd8J5EdFOYnlxgVZ8vKFehHII=;
        b=iLK18b7D7k460cVULTKrzJEV32wnwNGkLoc1cB6p6twOQ56P8+QcZIigVIeY30FgFZ
         CNhCFZDpmXvHlLa7UrADRfSLbu0HvPXlqTKEYZ+a0cwBeKgoanZqb4KmWiEmuzc6Prhy
         u/JGwHckHa5CYW2uVeNCanggQRGKCQp3I9D0yJj4jhgAwtptTJbGryovdIvfnEkhahxX
         Xq//6SEOMYzKVYrL0AFsALQIVFiIj0Robmk243JVIM4shWGJGqg5K//Dj+/5xzUlEfV9
         4be0K98DOhskYJeNOIAFX2LaHq/ZCVD5e59vDf7jei1zsblKrWZlBEEVjsFR6hRLYoWu
         +hSw==
X-Gm-Message-State: AOJu0YzxK0nJ8G6T4twZp6O7s4whiTUqo+TLNMpxfeFsSVw8RFJf65WO
	LoZTnX/wOdLB15HPG/Mnf+AcKTJtbG4y1IPZl0+8cb9TAza3IakHASOlRqlDR59crOjck/Yv4yY
	jy+M=
X-Google-Smtp-Source: AGHT+IGVnBGXNS/Sxs95eg7dFrcaCiPx0y79YA4zuXX7lJxdkDBWUveWDvcPrZhbmyKadaL+Sf8ydQ==
X-Received: by 2002:a05:6358:704:b0:1a1:d24b:9a9f with SMTP id e5c5f4694b2df-1a1d24b9c36mr684599655d.1.1718627051579;
        Mon, 17 Jun 2024 05:24:11 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf39b75csm6608259a12.45.2024.06.17.05.24.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:24:11 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/3] fetch2/wget: Fix failure path for files that are empty or don't exist
Date: Mon, 17 Jun 2024 05:24:01 -0700
Message-Id: <8714a02e13477a9d97858b3642e05f28247454b5.1718626914.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718626914.git.steve@sakoman.com>
References: <cover.1718626914.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 12:24:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16363

From: Richard Purdie <richard.purdie@linuxfoundation.org>

When we intercepted the file download to a temp file, we broke the
exist/size checks which need to happen before the rename. Correct
the ordering.

For some reason, python 3.12 exposes this problem in the selftests
differently to previous versions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c56bd9a9280378bc64c6a7fe6d7b70847e0b9e6d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/wget.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index b41f53a9e..2e9211763 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -135,6 +135,15 @@ class Wget(FetchMethod):
 
         self._runwget(ud, d, fetchcmd, False)
 
+        # Sanity check since wget can pretend it succeed when it didn't
+        # Also, this used to happen if sourceforge sent us to the mirror page
+        if not os.path.exists(localpath):
+            raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, localpath), uri)
+
+        if os.path.getsize(localpath) == 0:
+            os.remove(localpath)
+            raise FetchError("The fetch of %s resulted in a zero size file?! Deleting and failing since this isn't right." % (uri), uri)
+
         # Try and verify any checksum now, meaning if it isn't correct, we don't remove the
         # original file, which might be a race (imagine two recipes referencing the same
         # source, one with an incorrect checksum)
@@ -144,15 +153,6 @@ class Wget(FetchMethod):
         # Our lock prevents multiple writers but mirroring code may grab incomplete files
         os.rename(localpath, localpath[:-4])
 
-        # Sanity check since wget can pretend it succeed when it didn't
-        # Also, this used to happen if sourceforge sent us to the mirror page
-        if not os.path.exists(ud.localpath):
-            raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, ud.localpath), uri)
-
-        if os.path.getsize(ud.localpath) == 0:
-            os.remove(ud.localpath)
-            raise FetchError("The fetch of %s resulted in a zero size file?! Deleting and failing since this isn't right." % (uri), uri)
-
         return True
 
     def checkstatus(self, fetch, ud, d, try_again=True):
-- 
2.34.1


