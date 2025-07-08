Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9C6C8303C
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 12:47:23 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.17712.1751978836712435468
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 05:47:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i7BMZk2Y;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so30688575e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751978835; x=1752583635; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nyglfpx/a/Dhf/Jq+izYiLslOHehsR9IU1/inbLAOe8=;
        b=i7BMZk2YZllvW+2fTmhqwWB84EfEu96u16T59oJRLYjkh2z0lokNGpXts5sGVmeYbz
         paYk9lzSe0JlBJT5sh2xDsQpbmpbnzsNww1blKTj1p2KfbEXLvJ5zcNv0YIohkv5HtFW
         zORpvbDGKKad3Q8j18PF6Q26SwsjR+zBjSFzdjxH9/6TK4hdhZuzA5L1iOStsqnMqBPQ
         /loXdZr+bM8SzuhuFTnYUmA+3EIn4a82hkNyBpd1KHBVoospPnRGiLkxHS8E7JYiEA1t
         XFscjEJWLD3flSG58ceylwFaucegJHqGRyHL6pEKx/x9iERGKErmg3kXinyYD6/FDHhg
         TCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978835; x=1752583635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nyglfpx/a/Dhf/Jq+izYiLslOHehsR9IU1/inbLAOe8=;
        b=Mx0gXxIk2K5XggmdqnKVQpKCfzm9jbMUzRJtlJXDhZ3wRbZijH4Mm6cSSEc6YtjxYB
         cKyTbaD/hTcJOIptYQlIzxZ9RtmDgbIy6WOF8Jdwoglnt7a9qaiq3tMKs2Ruc8iZVI16
         1Wi8B8e0QhjXF0VuqEM2eDNelaqfEAxkPZ38a+y6BUZv+yzMUm9KMHJ/y8aMiB1OhxL4
         MbwiBreASamexAvOj+Ec5XOgGt8m294tZKdy2rXfhSwGoCvmmsv2nrCxyFDzrgf9Z8Bj
         D3ySdIXlTIaje3s3TkVFgQhkOjNXxq9J3PiFqWoOnYZ5QhsWYqC6AK8HwW05L+jqm3P2
         pwXg==
X-Gm-Message-State: AOJu0Yy/VlY+agKKJvOGUqizWeFyROwCx55fJYjA8rMAIhiBRYbjPQ6G
	Kh5y/K/IAorwKjJI7aoqlWycac9ztRCRn4sBNC1EPJ/zkpElf6a95HPVugysRg==
X-Gm-Gg: ASbGncsvp4EB+novFwWbYoZF0hiHj8TCULRr01cJB2K24Lgp0B4l3bKDolSocvE97nV
	D3pe22fJtyJ/x1qDLSo7mtaWq9MYZSagHzsLObWs1rQz8j5Og+nGlMtpdIzDtM1PEhMO/Ik1WOU
	sWcFzNjfUHupTiHNx/fSOh79AU/xhLo/JPc6BrdNXVJvtOWeK+rZ34KDSrbSNqx5gQxBVE4Sfuu
	qOVsxs1fXMUCL93NflkIMSnc05efMnoguEZvJidT783b3aZfWDfz5kBZkZjm+RGOQhVeIxm7RDZ
	Pvwe7KhztuCqtcbdp6wgJCy1dpJRApdPaq540IJLIbcE/WTStUvbXGECp5vAXJhA
X-Google-Smtp-Source: AGHT+IF7WjwUmXNNVitVKmcEvxKeaKEJjIvUs+6caJRXKJOl4FPj90ml2fUj68V07rW2AKhRa42YJg==
X-Received: by 2002:a05:600c:3489:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-454cd4cb9c6mr34456705e9.10.1751978834758;
        Tue, 08 Jul 2025 05:47:14 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47285c9f9sm13114728f8f.93.2025.07.08.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:47:14 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH] fetch2: zstd: use --force to allow decompressing symlinks
Date: Tue,  8 Jul 2025 14:47:11 +0200
Message-ID: <20250708124711.3541367-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 12:47:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17759

From: Martin Jansa <martin.jansa@gmail.com>

* when some zstd compressed file was fetched from PREMIRROR using file://
  the DL_DIR will contain symlink to the file in PREMIRROR and zstd will
  refuse to decompress it

It shows an warning and creates empty file which then fails to extract with tar:

log.do_unpack then shows:
Warning : /OE/downloads/some-ver.tar.zst is a symbolic link, ignoring
tar: This does not look like a tar archive
tar: Exiting with failure status due to previous errors

$ zstd --decompress --stdout /OE/downloads/some-ver.tar.zst > some-ver.tar
Warning : /OE/downloads/some-ver.tar.zst is a symbolic link, ignoring
$ file some-ver.tar
some-ver.tar: empty

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0ad987c59..b3bf4d0b0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1547,9 +1547,9 @@ class FetchMethod(object):
             elif file.endswith('.7z'):
                 cmd = '7za x -y %s 1>/dev/null' % file
             elif file.endswith('.tzst') or file.endswith('.tar.zst'):
-                cmd = 'zstd --decompress --stdout %s | %s -f -' % (file, tar_cmd)
+                cmd = 'zstd --force --decompress --stdout %s | %s -f -' % (file, tar_cmd)
             elif file.endswith('.zst'):
-                cmd = 'zstd --decompress --stdout %s > %s' % (file, efile)
+                cmd = 'zstd --force --decompress --stdout %s > %s' % (file, efile)
             elif file.endswith('.zip') or file.endswith('.jar'):
                 try:
                     dos = bb.utils.to_boolean(urldata.parm.get('dos'), False)

