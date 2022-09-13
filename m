Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37577C6FA8D
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:20 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web08.5352.1663079218165494293
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=ySVUY3vi;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id c2so12008059plo.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=iVEo5Us/UvqE3fmPj9izE9wO1PybLxx93D7enT+A78Y=;
        b=ySVUY3viM4p9nqUTlCTBZdOtxfAPt9K0k+v/h6JIgBzYv7V+XZyztpdEN3zHZKhTNh
         hXgoCVRzFdvMgLZb9tY6pkzI7BvMZXo8nRYr+aiiSge8F413hs1y9LsKa3UxSRNx7qKz
         CYw7z7hqT/WEj1/axGPhFr/1k/2h3KBt3oDkaYvhkEplbSPGQrgfj+mkX/cjrLArgM8N
         7YlTatrVOq4UqrMSnACi6h4DKk4MLjkfqatMeLOybGtXYliuEYxyMtcdHchpcRojEOhW
         1rxhkRFRlIvZWPyGFk1bbCycORWHpyLLiZP9Tv439bJQZqwxemhxpV+0wbR+MWiOQBiq
         Vakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iVEo5Us/UvqE3fmPj9izE9wO1PybLxx93D7enT+A78Y=;
        b=WemygbxeO5LgQpvc1fcjZk/j2Q0TV7x3EyB8mLzfSl2PCFx23NQmNOaBgb9BjNTWpx
         qJvCsfW4/WhAhyYXSmXNd/rbLkbknK6IfADn4J2xAVjxtVEKUl49eWdQbS/5zjPRTucp
         llhZnGPILXoCoVVmqgR7ms0hoWG4FNjF143PmKdbq5iExmsKvuwv8MZvb2kwmBFAXzJ2
         ZMk1OhoZrgcdcatswyqxoYCVcXP4pIUrzaUpZ+Hzrl9T2cBwMai/+cJw5DvSeCmt8kPm
         /N5r9Ok9xbq9jMb4+B3SMofJryL8BrMhSf3swSsKdUedHdCjC31+RKXIviYGNbJpz4Tb
         K80g==
X-Gm-Message-State: ACgBeo1JgEQEL6KrjlxpIqmdFs7fAr//LJ2wSe0T+LZSrsjcN9g4ANpA
	/S3/mnMdv2WrZau4Fv/reJPoM/1L6OC9U/GV
X-Google-Smtp-Source: 
 AA6agR6KzBdOzDzUjMJeu8kBdy/IXNSSA+LUHcS83iW2y/Pg30NdAcBz07eF2LkEPPv+0W8+i4sG0w==
X-Received: by 2002:a17:90a:4fc2:b0:1fb:3486:7b3d with SMTP id
 q60-20020a17090a4fc200b001fb34867b3dmr4385131pjh.49.1663079234915;
        Tue, 13 Sep 2022 07:27:14 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:14 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 06/14] doc: bitbake-user-manual: add
 explicit target for crates fetcher
Date: Tue, 13 Sep 2022 04:26:36 -1000
Message-Id: 
 <17bcc3e3eb45bfa2ff88002f300fa0d2efd9cb80.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13967

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Like in other sections describing fetchers

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c9bab35f6aecbf85ee1a19a7b70e15a80b42471f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f9d9e617..ea8a8aa7 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -688,6 +688,8 @@ Here is an example URL::
 
 It can also be used when setting mirrors definitions using the :term:`PREMIRRORS` variable.
 
+.. _crate-fetcher:
+
 Crate Fetcher (``crate://``)
 ----------------------------
 
-- 
2.25.1


