Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A75D1D885
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 16:00:29 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.486.1729008025145587254
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Oct 2024 09:00:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GlIMNH7+;
 spf=pass (domain: gmail.com, ip: 209.85.167.175, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e3e590c31aso2270115b6e.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Oct 2024 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729008024; x=1729612824; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=42GoJzySLgIhUwPG52pdjvmtMzebovnkAhxb1TNTltU=;
        b=GlIMNH7+3BoRUYFw/yBGiZwd0LrAX2wPOM3eJ6yjmfwpCFFCcX66nw2tcBhSIqMHZl
         E9rB67uR8lXMIsFyTH4NyQUTfPvu44ZVJ4a8eYdPi2bsqk+RVMiAAHks3h4F0zZEAK6K
         rBxSpJe8l8YOm2Q/xlsLpqkEF9sI6KnKbJN0Oile+f7oabVKcyNp6hH5+Iapq7kT4vY8
         fbzaHtX5nr5XQQYGLGe91WgmLe1utbWMBLj/0wOGNCI6/qGYJHkQuLbp3u95ivmSfkEv
         O7enycWZ2w0k5d+1Les+RefPx0Dcm0ci+bwWjZ9sHIide5qxT8U7V/Kz9C0c5hXWPfu6
         EbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008024; x=1729612824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42GoJzySLgIhUwPG52pdjvmtMzebovnkAhxb1TNTltU=;
        b=jqPLo6WsJtzaK0apvnnOFw4/7Ncl8hqNT2Ne6VR2N7ppCd9iP8q5reN/NqGup3Km3a
         AeKFQYQwLhcowHknwhguLBQrqzhYPn7dqzqL0ZSaUWyWdhU/hKA8TvWPCQwLYukTval+
         D6wZIAfV2Tl6erWB8wQI0vHI56VabF94iTGwQc0rF59ROxMe5cJAMTAW2TJoKFzuRzkq
         U2942RULxIGMbP5iLmhbT6P63huUZqn52t8XUVJ8kPk/EeRSM/fV92k5H1K2Fiyvn72s
         czT5+gXYiO4K7DfaI9ihT1yYwQcpIt1Su8J/nBEjTl3u/zO0ocPU+rLpPWoWBUBI0PqY
         LhJg==
X-Gm-Message-State: AOJu0YwCn6i3vH6TZLgEWlUfvEr/bjdn49q0oGBpX+KI/A/MyGT6PXAk
	Q9KWol5pZXsxu+RRur+AUQ4GImPEpWmtseJXaiP+SYQGuHAlUVNZr9mTkA==
X-Google-Smtp-Source: AGHT+IEDlplF6dzK0IVr6et60SH0b10KKt+U6XfRa/Ad8/VWmYyjx1K/QuBEbaLGRTNoFDy30QpBDg==
X-Received: by 2002:a05:6808:22a5:b0:3e0:5137:fe59 with SMTP id 5614622812f47-3e5d218be51mr7307538b6e.5.1729008023619;
        Tue, 15 Oct 2024 09:00:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::a216])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e5e85621e3sm339923b6e.12.2024.10.15.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:00:21 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-hashclient: Add help for address
Date: Tue, 15 Oct 2024 10:00:18 -0600
Message-ID: <20241015160018.1471301-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Oct 2024 16:00:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16686

Adds an epilog to the help text that indicates the possible options for
the server address

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index 5d6f67046bd..a50701a88b4 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -17,6 +17,7 @@ import warnings
 import netrc
 import json
 import statistics
+import textwrap
 warnings.simplefilter("default")
 
 try:
@@ -265,7 +266,19 @@ def main():
         print(f"Max time is:             {max(times):.3f}s")
         return 0
 
-    parser = argparse.ArgumentParser(description='Hash Equivalence Client')
+    parser = argparse.ArgumentParser(
+        formatter_class=argparse.RawDescriptionHelpFormatter,
+        description='Hash Equivalence Client',
+        epilog=textwrap.dedent(
+            """
+            Possible ADDRESS options are:
+                unix://PATH         Connect to UNIX domain socket at PATH
+                ws://HOST[:PORT]    Connect to websocket at HOST:PORT (default port is 80)
+                wss://HOST[:PORT]   Connect to secure websocket at HOST:PORT (default port is 443)
+                HOST:PORT           Connect to TCP server at HOST:PORT
+            """
+        ),
+    )
     parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
     parser.add_argument('--login', '-l', metavar="USERNAME", help="Authenticate as USERNAME")
-- 
2.46.2


