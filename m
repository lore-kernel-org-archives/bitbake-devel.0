Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C3BC41513
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 12:24:15 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web11.54899.1718627050989387824
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jun 2024 05:24:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=E90N2MZn;
 spf=softfail (domain: sakoman.com, ip: 209.85.166.42, mailfrom: steve@sakoman.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eeea388a8eso38542439f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 05:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1718627050; x=1719231850; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvvYw9OP/t8K4TS6ZNiKvWNipFzBfh3QobbHP6kwhT8=;
        b=E90N2MZnV/Hx+kxKVapa5Qidnrxi7sZ1jAvQmZMFXguwckqZSojH3jgFy24t2ECzch
         pygqENSkv0zBLvkJV6Z4Sx2BRKtihTNkqSOAGr1032OwpzRKqDU1Soo1ARHowD3xkhHj
         Z59cdTc8PwYFSf45bqTt0Zzkay6fjmfioMyan/BEafELfMTHkBwP9QKT2bbt6+8ha3wH
         47oY0qNyvaNj0xGvzRf+JiiAwLRRZg2dromXkfSBVA1fIfJbqCHsRUUznrUZnYHnUthm
         5sRnJbqPi223MSmdm6P8UW0AGCiHbO7C8vK7JyfY7rlszEGKgnK6KtU9z1cFGkg8x3sy
         lSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627050; x=1719231850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvvYw9OP/t8K4TS6ZNiKvWNipFzBfh3QobbHP6kwhT8=;
        b=dmCVR87wD+O2KuAxFn+xuCZ+5UPKdWoGyIzN+TUH8UPC+vjJCv4ceY22mP/hsTy6gk
         2n4zo60wBi9SSfNhmWcz/duSxhaoDiXULVGAnLLzoTRtZUPQZG3RUPBnUYHdxchvPz69
         /xp3vc8ukcgGitpJNlGtmojiigl5hJzFe+drUOfGZB6ez0ge81p8s9CWwNcDg3LgorpO
         YLohkPwNO6bvZfjrgjZhGQtNzOl07crsazAeb9ECExXFmce5uZnv5w5Aj9BpWnrO0fWN
         wC5DJMdueZm1EZcOMrXcPZy9S6TksRhFACrNYANZejaeqibspK/Ey/EHKR93ddn6jrNX
         EomQ==
X-Gm-Message-State: AOJu0YwBddIO5Hnoayj139VhoH1tZU5CgIDlfzq9Wp4jdKjRVsVTUjWK
	hL42u7GwiKLsI2hqi3LerpEDgvQKZ9nm568SgZV8YftKKonDKfaa9Qye5Qb7sn1pLLghp3IIisO
	tbbI=
X-Google-Smtp-Source: AGHT+IH2L5QVWgBWidYytthVjhPfhBgjc71LJsgG8ZXhNmdMSyvdPR6UXunDEIdtG+gmxt1OVQcurg==
X-Received: by 2002:a05:6602:2b92:b0:7e1:af90:44ee with SMTP id ca18e2360f4ac-7ebeb4c7167mr1124955339f.8.1718627049913;
        Mon, 17 Jun 2024 05:24:09 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf39b75csm6608259a12.45.2024.06.17.05.24.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:24:09 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/3] tests/fetch: Tweak to work on Fedora40
Date: Mon, 17 Jun 2024 05:24:00 -0700
Message-Id: <5fa596b3f2e49fbd144347b9800c76de72a29e28.1718626914.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718626914.git.steve@sakoman.com>
References: <cover.1718626914.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 12:24:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16362

From: Richard Purdie <richard.purdie@linuxfoundation.org>

On Fedora40, "localhost" sometimes resolves to ::1 and sometimes to 127.0.0.1
and python only binds to one of the addresses, leading to test failures.

Use 127.0.0.1 explicitly to avoid problems of the name resolution, we're trying
to test things other than the host networking.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9adc6da42618f41bf0d6b558d62b2f3c13bedd61)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 8a91f51d3..33cc9bcac 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1511,7 +1511,7 @@ class FetchLatestVersionTest(FetcherTest):
 
     def test_wget_latest_versionstring(self):
         testdata = os.path.dirname(os.path.abspath(__file__)) + "/fetch-testdata"
-        server = HTTPService(testdata)
+        server = HTTPService(testdata, host="127.0.0.1")
         server.start()
         port = server.port
         try:
@@ -1519,10 +1519,10 @@ class FetchLatestVersionTest(FetcherTest):
                 self.d.setVar("PN", k[0])
                 checkuri = ""
                 if k[2]:
-                    checkuri = "http://localhost:%s/" % port + k[2]
+                    checkuri = "http://127.0.0.1:%s/" % port + k[2]
                 self.d.setVar("UPSTREAM_CHECK_URI", checkuri)
                 self.d.setVar("UPSTREAM_CHECK_REGEX", k[3])
-                url = "http://localhost:%s/" % port + k[1]
+                url = "http://127.0.0.1:%s/" % port + k[1]
                 ud = bb.fetch2.FetchData(url, self.d)
                 pupver = ud.method.latest_versionstring(ud, self.d)
                 verstring = pupver[0]
-- 
2.34.1


