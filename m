Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web08.9178.1621946241934336373
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 May 2021 05:37:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Anl2VevE;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: weaverjs@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id j189so9357094qkf.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 May 2021 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJjUyDIKnYb6Z9DqnxSjUBbyEUBgibeNY+iqKmd573w=;
        b=Anl2VevEet4GIibYkJ6WScR/VPhaqsWohjmKbn/KDFtDyJEOuQIBYEdp8E71uLIAZd
         9u//Aj5y+8TOMNGb6Z2MUCflgFTRnqt1r+gYBFaApkUzaB+aWEBt9d8AMqmVbzNfqWdn
         +ezSQHkRA+QYeNSqgzBfm8Gh7OzW9EvFKfvZ5kaRrGmpR+UUGt5jCZJrcJH/ntPHOfu3
         Pc9DHBr2hwaJgD+fuM2He2EoYonSJFxhtPWR8RWRuzX3kHxGb4Ji/MMU5LKn5nivf5Wq
         NWHboR9uXba67CXg65GpIQyPTur5f/6oUEbScJ7pyCjaktTi/Kh4t4NxSJ3dVyQhx0J8
         YjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJjUyDIKnYb6Z9DqnxSjUBbyEUBgibeNY+iqKmd573w=;
        b=tqYOb+mJvjkmSoS0LZu/wXHoRSN02g3v1+mXM+JIOxsVZ7P4FF8e9RdKz5x/c/Mfch
         0QOMwu1WCC65tlGxkAxJMEZ9DSc2IRctcZpTaSPhQEPCmbBsKf4QaAHUlO+SIxjIQsQ7
         TZrZA0OZwIwk7wbef89Hb3ySnHT0fV10naa2C/vsMZ6t123SmcVTKGmwybcMGili/+1y
         gHnjY7sanHuvA9ZWQBxTFRNKt5yYjT5EAp/sGeGhMdPQZymxNUMaZG559OXeO8+bHnB3
         fqR65V7NNAvSVryYZiQd3TFHBnrEU4ejirnmVpXUsgmrnhuHB5v3b1yxESdAoghbcb95
         Tw0w==
X-Gm-Message-State: AOAM533QI5woMFtGwn0KcU1Mf5d55bgUNuH2T5ewriDc2i3coxFHBqWt
	9Zd/IcKIUp2d2H6sF8EMVIDDtiU5Hup3XuATWw==
X-Google-Smtp-Source: ABdhPJx+IE33Czgx5YM5SBO4CUuxS8M443KmPCHzQEw8FBP46FLBp9YRH0ou9VjshywYesemnWOxLw==
X-Received: by 2002:ae9:eb93:: with SMTP id b141mr35604320qkg.151.1621946241003;
        Tue, 25 May 2021 05:37:21 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from p-impout009.msg.pkvw.co.charter.net (cpe-69-133-48-66.cinci.res.rr.com. [69.133.48.66])
        by smtp.gmail.com with ESMTPSA id i10sm13138194qko.68.2021.05.25.05.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 05:37:20 -0700 (PDT)
From: weaverjs@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Scott Weaver <weaverjs@gmail.com>
Subject: [bitbake][PATCH] fetch2: add check for empty SRC_URI hash string
Date: Tue, 25 May 2021 08:37:02 -0400
Message-Id: <20210525123702.3061487-1-weaverjs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No error was being reported when the hash string was set to empty.
For example: SRC_URI[md5sum] = ""

On a related note (not a bug):
Because whitespace in the string will result in a checksum mismatch, the error
message was updated to make it a little clearer why the error was thrown.
For example: SRC_URI[md5sum] = " " or
SRC_URI[md5sum] = " 209f8326f5137d8817a6276d9577a2f1"

Now creates a message like this:
File: '/home/scott/yocto-cache/downloads/rsync-3.2.3.tar.gz' has md5
checksum '209f8326f5137d8817a6276d9577a2f1' when ' 209f8326f5137d8817a6276d9577a2f1' was expected

[YOCTO #14232]

Signed-off-by: Scott Weaver <weaverjs@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index cf0201c490..c8e91262a9 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -562,6 +562,9 @@ def verify_checksum(ud, d, precomputed={}):
 
         checksum_expected = getattr(ud, "%s_expected" % checksum_id)
 
+        if checksum_expected == '':
+            checksum_expected = None
+
         return {
             "id": checksum_id,
             "name": checksum_name,
@@ -612,7 +615,7 @@ def verify_checksum(ud, d, precomputed={}):
 
     for ci in checksum_infos:
         if ci["expected"] and ci["expected"] != ci["data"]:
-            messages.append("File: '%s' has %s checksum %s when %s was " \
+            messages.append("File: '%s' has %s checksum '%s' when '%s' was " \
                             "expected" % (ud.localpath, ci["id"], ci["data"], ci["expected"]))
             bad_checksum = ci["data"]
 
-- 
2.25.1

