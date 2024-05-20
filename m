Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E3EC04FFE
	for <webhook@archiver.kernel.org>; Mon, 20 May 2024 13:38:36 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.61168.1716212308001129727
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 May 2024 06:38:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=gZVlKJxZ;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.176, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ed904c2280so63734005ad.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 May 2024 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1716212307; x=1716817107; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8Z0RbxiPupkRdeaiP+mAaxjj3OaaB6HjYrIiwieTms=;
        b=gZVlKJxZvLNaqWfQs0wVPyDSG55tBjyBHR3bgxknMD4OSqUTQ/8w+tfyxC1A3cZbuv
         8q3cCqxTLLyl4jTmy+Qwlz/uA0oLlYlU5tO1zN3r5eWu0N5ftqw1Akp2967JON7fvqXI
         sR93RZsCBPBx5xmE6QoN9uTrVmjR6XiCyVLpDgBvMx5w8c6AtHjyibXT3PSG8FMkaoIs
         9VJ3+ICiNmFpM+E74M7NBhLT0MUv1PTepXcDQ0GoxQtQALNiQYOwNhnzsGhNHpSHU2/+
         bDdaeZvDVwnHRpMV34+zWZzcCGJ8Ss/yLOwbAfrL8MK8PGcu9uJIJQZChxvhlp6Lv/kc
         AZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716212307; x=1716817107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8Z0RbxiPupkRdeaiP+mAaxjj3OaaB6HjYrIiwieTms=;
        b=v5BlhdNDyEVZunJ81gHaLipkGZGZmRjgUbir2ELBep3YX7fszgsaHEM9Tp31HXom6x
         HsntBKNXFAIj/JX1bvjm8lZAkXuZxNobuKydvJkPDngaPw0yqS4I/2bPljyyDYEMyWQi
         i2+TClESibqMwtXyqTknPxpvQz1xK5rcSZPk3X+f1LbWERvEbkZ2d7Re2D5QKG1avi+F
         mHiJ9YnMUuexG8rtKIhP3eE3tdKXaCiLdY9tjjSd+zRbRMDNYcux8hwhMHCR8FNFtlgu
         y/8xX9OUlIzDQeMWZ6aM2RjbbrI6Ae6989uzXARR54qyddIzDoMNka8aZoM1tkSn7OrX
         ZQKQ==
X-Gm-Message-State: AOJu0YwTaTAOn/RnfZsOsxDVfpwNXGdajAV3jgJAjS5TaOCa+KbDPr08
	7he54aneZo7ru15U4zq50UfQNqnI3qBYM00PBUSBn2oibblxuV4bFeG7towUFqrdl3Hy/rA5CSF
	n
X-Google-Smtp-Source: AGHT+IEJsUuYDDYJpYV0Y5LkD8Kx0vnmALpI8QsesS/ekc/1NdOP/Gz1bdWZKKG6M1DtEC8cuVNibw==
X-Received: by 2002:a05:6a20:96cd:b0:1a9:b2ee:5f72 with SMTP id adf61e73a8af0-1afde10f9a4mr25781725637.36.1716212307181;
        Mon, 20 May 2024 06:38:27 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad62bfsm203943405ad.74.2024.05.20.06.38.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 06:38:26 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/1] cooker: Handle ImportError for websockets
Date: Mon, 20 May 2024 06:38:02 -0700
Message-Id: <93190565fd1251e8f47d9a6291739f8b8ed5ec87.1716212099.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716212099.git.steve@sakoman.com>
References: <cover.1716212099.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 May 2024 13:38:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16234

From: joshua Watt <JPEWhacker@gmail.com>

Handles ImportError when creating a hash equivalence to ping the server.
This notifies user earlier with a more precise error if websockets can't
be used, and also prevents passing a known bad upstream value to the
local server

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit aa80b3cfc5d16dfba13ca7fb9b78bae179ce3b74)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 25b614f1e..939a99997 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -318,9 +318,10 @@ class BBCooker:
                     try:
                         with hashserv.create_client(upstream) as client:
                             client.ping()
-                    except ConnectionError as e:
+                    except (ConnectionError, ImportError) as e:
                         bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equivalence server at '%s': %s"
                                  % (upstream, repr(e)))
+                        upstream = None
 
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
                 self.hashserv = hashserv.create_server(
-- 
2.34.1


