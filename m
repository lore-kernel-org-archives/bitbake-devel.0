Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.7481.1618831431091937477
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Apr 2021 04:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L3NKcHIn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so17844833wmg.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Apr 2021 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeoevKZqPy0ZT8QPqfzFXnG8Jc2RYQzgZH5g1U3rmRo=;
        b=L3NKcHInCHXQC3PY1jIQ3yvLoB789AtU2ZM651ywbPpm8018t9ksbGSOdMbjcwV9Me
         fFSnbdwGA7OzmaAK8sd9Md0U0r4iUWOYbJ62ZNyycov3+PLjba7GT/WNBSlv7w3ursVF
         h3FpBnjUy8c1QUFTws02u5pYT1JqXOx4S8bQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeoevKZqPy0ZT8QPqfzFXnG8Jc2RYQzgZH5g1U3rmRo=;
        b=Ahvmp2nmDj5yGjkosK8De0rtMQGmWN8SoUKxc69gIEE+UkXE1MGgxsZDKAUR3VYyM3
         yi3l3rl8oy9laOY/3xo6MjAx0D1TbMENgI3pvjhAROd8AKqEOPOvUDYCbPGvN1NPxUpu
         YGwIXzL6wAPfqdSXWQqHdKos+5jC/krR75KpbBj/YAyPO++LmOVJPH5/+Ti3nX996JKU
         f69BE1jJXXKJbuiytpjf+oJ0e45GIZqwKpTIcWdGt8EqB5o+ZhePf67Zs2Deyw2bZiRh
         VO8TqzLkTyJBs63c8WxGG3m/KVtqPcvssmtQqqeqoOsEhbnRSOiJV93zpX5LxpuB+1Fh
         HcWQ==
X-Gm-Message-State: AOAM531auut9M/SQzDrUZjDVyM7SlWp2MqzcN0TahrN3eCxKEUgMZATt
	3myH0cYhDlHwFSLTfYAnLPRj6FqSO3uApg==
X-Google-Smtp-Source: ABdhPJxq8QA+AHxgc3zp1kDVszWGAfcBPg9vTkzsvChzGwYUXPr55h5yuIAWZoxUg41o3kcW1oK5bQ==
X-Received: by 2002:a05:600c:2247:: with SMTP id a7mr21533501wmm.133.1618831429444;
        Mon, 19 Apr 2021 04:23:49 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3b9d:2a57:e60:cfc4])
        by smtp.gmail.com with ESMTPSA id b15sm14044767wmj.46.2021.04.19.04.23.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:23:49 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc/user-manual-fetching: Remove basepath unpack parameter docs
Date: Mon, 19 Apr 2021 12:23:48 +0100
Message-Id: <20210419112348.1465699-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code for this was removed in 2016 in commit
e659a3b0c2771679057ee3e13cd42e6c62383ff2. Nobody seems to have missed it
so remove the documentation so we match the code.

[YOCTO #13449]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index bd6cc0ef2c..626278e444 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -163,9 +163,6 @@ govern the behavior of the unpack stage:
 -  *dos:* Applies to ``.zip`` and ``.jar`` files and specifies whether
    to use DOS line ending conversion on text files.
 
--  *basepath:* Instructs the unpack stage to strip the specified
-   directories from the source path when unpacking.
-
 -  *subdir:* Unpacks the specific URL to the specified subdirectory
    within the root directory.
 
-- 
2.30.2

