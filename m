Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web12.32474.1620656220017093363
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 May 2021 07:17:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=D1pRl2t5;
 spf=softfail (domain: sakoman.com, ip: 209.85.167.169, mailfrom: steve@sakoman.com)
Received: by mail-oi1-f169.google.com with SMTP id w16so7744426oiv.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 May 2021 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U2ZMWJsNROuSpCbPX78QI5CdtqYlVQJV0e6SSA3zRuw=;
        b=D1pRl2t5zHnhl8cX4AcPBCrK7U4CMPEGS2O+8q3Ljgn9Oll/tlj9Lwt3Z14HccqnFz
         R3lGU6C5iS1oKLgGCTpQAJIm2m/PDyumlWr27qHEyCO9llZmzeTKdQfFB8zG9BHLwjdf
         USpSHMSM/tgACyQApIBYYDQrUSi/lf2fwISESRPirUXUKLbA/bt3gCpS5gE916Oe/wdK
         uPrgOe9gIwPEreFcxn6kWfO1QBsLbXrSF2pKOBG6MrB4UCV4gODLCyLpezBVc/WiSteC
         1DwXrtXxojX3+OHzfzMEl5x8Q/1mRuz9jTyv4gMm0qFASMtWO5WlI7btEvkwuwbDNR9O
         qcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2ZMWJsNROuSpCbPX78QI5CdtqYlVQJV0e6SSA3zRuw=;
        b=XS954xC8UjGebQ3UoLBNKBN3k5MxjssscWxivu+Nk6KF18loDbQ4yMEluq8EQZK4AG
         vwN6E93FKG/ANROcUVeTEnB+MfQ6J4VgyW/r0iljXkp2WnNDVUtm/SaTtSTBnv0TH9GP
         jno5UdpHtaiJF5GTXlWr8vmErcjyGjV27fr+GEd+FgPy3Y8/Q6JNaaRXk9Z/vkwxbIzX
         RkX2qG898IZYmnJIzs1ECdhqgGy3bFCCI5vkFsUTCGv5IkAaDeGqYngMJ0LfQw80HjMw
         ubgXU+aNdfztQK2tvnYxpSO3ec11M6waJIFkJU4xjsqyoFKAP+XHji+iraaM+zi2qhLJ
         XpDQ==
X-Gm-Message-State: AOAM533xd8ufPdR5lel3HpS/9//ZfWJBLtckS9ha3bAbdEFCFiaIErGB
	SQfY9FyoWJC79YsiGliBVxS09SIu6+qOZnKbtPA=
X-Google-Smtp-Source: ABdhPJx0/0CcEN/dwnzJsycpLeCm9qwMtMhYkPrgihUIqRib2aHmjzfmRCaMe2GTZkwk77enYA5aFA==
X-Received: by 2002:aca:dfc1:: with SMTP id w184mr18479448oig.79.1620656218912;
        Mon, 10 May 2021 07:16:58 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id g106sm2401303otg.77.2021.05.10.07.16.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:16:58 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 4/4] fetch/gitsm: Fix crash when using git LFS and submodules
Date: Mon, 10 May 2021 04:15:19 -1000
Message-Id: <631c0fa02c12cb48bcee4fa602c1ee4693ed689b.1620655927.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620655927.git.steve@sakoman.com>
References: <cover.1620655927.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niels Avonds <niels@codebits.be>

Gitsm fetcher crashes when cloning a repository that contains LFS files.
This happens because the unpack method is called during download, but the
submodules have not been downloaded yet at this point.

This issue was introduced in this
commit: 977b7268bf4fd425cb86d4a57500350c9b829162

[YOCTO #14283]

Signed-off-by: Niels Avonds <niels@codebits.be>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 26caedc4d2e9b5a0f1d57f9291754a7f6c5e437e)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e05d79a6ed92c9ce17b90fd5fb6186898a7b3bf8)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 8740e9c0..112b833f 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -388,7 +388,7 @@ class Git(FetchMethod):
             tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
             try:
                 # Do the checkout. This implicitly involves a Git LFS fetch.
-                self.unpack(ud, tmpdir, d)
+                Git.unpack(self, ud, tmpdir, d)
 
                 # Scoop up a copy of any stuff that Git LFS downloaded. Merge them into
                 # the bare clonedir.
-- 
2.25.1

