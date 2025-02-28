Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF472C19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 13:01:48 +0000 (UTC)
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
 by mx.groups.io with SMTP id smtpd.web11.14766.1740747700059853441
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Feb 2025 05:01:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YRxgPCqd;
 spf=pass (domain: gmail.com, ip: 209.85.219.68, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-6dd01781b56so23268696d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 05:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740747699; x=1741352499; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW4v4gGgqzbfkkRY2rB2M/5k8R7jb6PV5sInopddLlM=;
        b=YRxgPCqd1v4flhnt5XUoowmRXVF3Oo5yQL34yMNhyU9LdsSqNPYH/NKEddp0VrEKyB
         aNdhzz5zKO6CN8DOMsrHJfiaeBkf0R/H8LiPUnI+64DHiitrByorQe/dBW2Z5E3qrNUS
         McMrhUGTlxGAE2jTD+aqwTDKLtULl1wcelJv68j9R3hSehIqAT1Qs5uNbHRr5DcUvGzf
         jzzeC582C7oNK3iDsTz3ub3OxMRFUpCguPjtc56CzA1vBy+jptHySdB/OmCha7AXdWsy
         dhKO7mabn8Tjzgqa+kiUlohKlp9syXHFsq8KcV+OnNxBHk7NZNym9oNh9jaG3dP5emHY
         BucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747699; x=1741352499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW4v4gGgqzbfkkRY2rB2M/5k8R7jb6PV5sInopddLlM=;
        b=mfTE/337nfbxjocsR9xtWMsuYkoLsFDYueBWmyKMJhWtWhiULPGM21bjDUBU5FnP/e
         q/AN2vOWEcj8B1E2TJBvjM0sEoceScNxDmdovGai8VjRpKd9uvCTdih4Yc33Wh6mOjHz
         22oxVKrGYJpVLHyqdQXJvzZpRd91eSKa2s1niGqHZjZFNkObjaTQPC+qepkjdgt3VoJE
         qysxREicgn5G5lUcQQ4YyhiJrZqyur3E7Uqjvz3sZiYJaIfTkE7d40drQxBWyPCvJa4Z
         B+A92LWGImPBhuFFPa+kvOmgWNVmczxyc5Zo7hEv+dJjqalwdtZt5lQKUk6pXV/U7tz+
         U5dw==
X-Gm-Message-State: AOJu0Yy3XrjrYpXmAJc7jVZoHrsLBD6FYBhFwKecUPFGWW2Piqw/xtr9
	IMp8D2QZZJKsu1w61rER3mLHS2yGm/alyqrLVQGasqeI2A8CVUBs56c56G+b
X-Gm-Gg: ASbGncuZ8WL22VUYw1hQAxnmq5njoS+xuBtG5AOymppTeLnpJ/qXzbKozA0TZJs6/yW
	q2WC70aCTzxPIt8aZq+zrHz3OWP8vwXtOU8wwlUU9sxTfuSEbWgXkgzx9FPOPkYyLYbwse7dpy2
	ZMcoN25DhN19ClesYOi6HDtNFdeeKVmxQw8WBpaazQy7BwJGfIr4m7zulDbkDkOq6btQG5yNsxw
	tcaVPrx5gZAkitqCYSwkeQiHOAGvBWlSQWJWX1WomhujwJYZCXYeTu81KdECe7bd4M+1wc2JjzI
	4NwsOoBnPaa61gifCqnYvz+CDLgEEFYNaWn5cBxohZFrf7xcEpxgwfdDzALlPwVvlqwv6KGD8CF
	3mDIw/ytVz/0okq8Dt9a4
X-Google-Smtp-Source: AGHT+IFKx7+3Nu53MgEYNxcw0m2Xpzz1384wt6x3v0Q1uHTqCgpUiUsZ8M4nUf8n3hrGe4u0OzwBzw==
X-Received: by 2002:ad4:5ba3:0:b0:6e6:6a82:4989 with SMTP id 6a1803df08f44-6e8a0d90e92mr39416206d6.44.1740747698675;
        Fri, 28 Feb 2025 05:01:38 -0800 (PST)
Received: from ACT-L-SWD024.yourbase.domain.local (c-73-9-222-202.hsd1.il.comcast.net. [73.9.222.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da32esm21749406d6.110.2025.02.28.05.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:01:38 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>,
	Chuck Wolber <chuckwolber@gmail.com>
Subject: [PATCH v5 2/2] doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC
Date: Fri, 28 Feb 2025 07:01:37 -0600
Message-Id: <20250228130137.400-3-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228130137.400-1-eric.meyers@arthrex.com>
References: <20250228130137.400-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 13:01:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17360

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
Cc: Chuck Wolber <chuckwolber@gmail.com>
---
 .../bitbake-user-manual-ref-variables.rst                   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 858de6347..00300d0d8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -692,6 +692,12 @@ overview of their function and contents.
       Within an executing task, this variable holds the hash of the task as
       returned by the currently enabled signature generator.
 
+   :term:`BB_USE_HOME_NPMRC`
+      Controls whether or not BitBake uses the user's .npmrc file within their
+      home directory within the npm fetcher. This can be used for authentication
+      of private NPM registries, among other uses. This is turned off by default
+      and requires the user to explicitly set it to "1" to enable.
+
    :term:`BB_VERBOSE_LOGS`
       Controls how verbose BitBake is during builds. If set, shell scripts
       echo commands and shell script output appears on standard out

