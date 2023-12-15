Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1264C4167B
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 20:25:56 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web10.76218.1702671950393359759
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Dec 2023 12:25:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cI0tApaF;
 spf=pass (domain: gmail.com, ip: 209.85.161.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5913e3a9e05so765024eaf.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702671948; x=1703276748; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEupIvT25NZUh48/AwHC25aaJdlqeoMZaXHyDX1JOFA=;
        b=cI0tApaF+O81NFtrqnTNg8Jvw5uNkZZBogkaV5jxQCSdLrsGjKVIjMy35KN0u8bsdT
         LCnuVmByOaUCL1yHMkyFHZF42iul8cDspWlt+Iab/nlsdsIW26PjJYJ+wp0Y+Xoih9h7
         h2Xl7NhRGmbHBtgm2S9M8/N7CpJBK3L/IYGr1/NF3+QPSAEkeIMUAqwxmBSEvOuHkCvK
         j+YtFwoAdZ2bw2Z/fugJJf4FJMhqJmtOehbu39zxUAgdYtupATETFd+i+HIV/LH3bXBR
         A0XZLuU8arye7tnvVxfA4rPqwJoUeXPsuJK0LoJBkeL9hmli0z8t6AkXdIcHNv3lfdcg
         eQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702671948; x=1703276748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEupIvT25NZUh48/AwHC25aaJdlqeoMZaXHyDX1JOFA=;
        b=VBRcsR1h2LL512hSrnbHfISEVefpW7gea6T0ND2l8YegUoHy9U+fU2iG7qbR/bPgIS
         N9GRFtnBI+riM80xmpsIMUmndn/Ed71veuAFoRNow0UdQz+yaQqE1XDizDlIu7S2MvGI
         U6KjsrUsYFdpdUNOtEOQwOnU/N1BJw2y2OmWrtY8jJFMNLcrEGqeCVuTs0oy0UqrKdAb
         HeejXA6JnPxw+1OkKJG5ZHy5/6s2nLN9Vx3JZk67ILFp1frjPSjB5Acz9wPstFg9iihL
         Zw5jPynM5tAu889OkRA64XyfrLl0Cx9t3g50SM73pdd2tXtyM5Iu6rWXLI0tyjtwXcRY
         PiAA==
X-Gm-Message-State: AOJu0YzncKIH6C1MAy0iA910uIj5J5oSCnEOAedsDE6Ctl4PA51TELIs
	2z5wqwPA8mSQKCXKPU3dwBBD8g5yfrA=
X-Google-Smtp-Source: AGHT+IH93ij+nkFsR6e5hIIsGQ5LOvGgQKGwUa2dcWwpqAFDL/4ffLOZdWoDYWpnY1+DvymPjxRojQ==
X-Received: by 2002:a05:6820:1627:b0:590:2b6d:a862 with SMTP id bb39-20020a056820162700b005902b6da862mr10399630oob.15.1702671948502;
        Fri, 15 Dec 2023 12:25:48 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::35cb])
        by smtp.gmail.com with ESMTPSA id 186-20020a4a06c3000000b00586c4324f5dsm3542672ooj.35.2023.12.15.12.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:25:47 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: ross.burton@arm.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-hashserv: Add description of permissions
Date: Fri, 15 Dec 2023 13:25:42 -0700
Message-Id: <20231215202542.2910797-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 20:25:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15692

Adds a text description of the possible permissions in the hash server
help text

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashserv | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/bitbake/bin/bitbake-hashserv b/bitbake/bin/bitbake-hashserv
index c560b3e58ac..c913c4e3c8e 100755
--- a/bitbake/bin/bitbake-hashserv
+++ b/bitbake/bin/bitbake-hashserv
@@ -53,6 +53,19 @@ mode with an SSL terminating load balancer in front of it (as this server does
 not implement SSL). Otherwise all usernames and passwords will be transmitted
 in the clear. When configured this way, clients can connect using a secure
 websocket, as in "wss://SERVER:PORT"
+
+The following permissions are supported by the server:
+
+    @none       - No permissions
+    @read       - The ability to read equivalent hashes from the server
+    @report     - The ability to report equivalent hashes to the server
+    @db-admin   - Manage the hash database(s). This includes cleaning the
+                  database, removing hashes, etc.
+    @user-admin - The ability to manage user accounts. This includes, creating
+                  users, deleting users, resetting login tokens, and assigning
+                  permissions.
+    @all        - All possible permissions, including any that may be added
+                  in the future
         """,
     )
 
-- 
2.34.1


