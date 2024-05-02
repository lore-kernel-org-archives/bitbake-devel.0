Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E88C4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 18:35:10 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.2294.1714674910070580318
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 May 2024 11:35:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Trndbal1;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d5e4097a9aso345343939f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714674909; x=1715279709; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlUVCWHsebdrxo2z2tTB/iHDiRKn/iHCZXYnOEU0cH8=;
        b=Trndbal1cZrri1qSiOnLgKDdxj84AQIoB6o5SmaP8xCzIxH8l3/0MsgEmDtlO0svAC
         QQxT4J6kiO/EXXJoLB+09h7MP8MpIBVFET9TbzRRk0sFYiIJpsMDVEnppKJC4Al+sFnR
         63I9iHkRuFC++Q9Jzw+IIFZDKL/OpjteT6Bjcz/m/LVygBj+4snEdeDWohJc3sGJLtp4
         U+uugnSOclbTNWNI/HZhwAbRjbD+NcHA3rAPAEVUTqNf4VtfTF2R5GvqP+HuiQJT0gDL
         RiPqgdsXSXgW3FnaqsjvcXw5TkoADX5N8J0U1/20d9paNmDCqqcSzX+lxwAaHqplQ+M4
         feow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674909; x=1715279709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlUVCWHsebdrxo2z2tTB/iHDiRKn/iHCZXYnOEU0cH8=;
        b=WLKNP48c8LRCGt60nFa6r5eAPVLTsM9KwZfJ5Q6KhjOCHe6nWhp3JYVit9QNG11ehm
         2JQPkHFotcP1Zrej3aQe3nNPRVncnMpC/zPsVTT403v32J9xAhXlj/oYmzWVwoust+KV
         n9PvjOvI7Xct80CZMh3Mo7Pzj3Rb9wO0YYzooqMS+2HVWeYO7qbFLDy2yPYKfQz6Gsxh
         vAT8aBTiXsKDJdrtQYD3/RS308FTKQGvCLAO6fjDjtCYgjbKJVT4MJ52qCzoIaskeK6D
         k+y8KvVj6vZu4jcxe9/VLshDE6M65Bz5DNeNZt9b9eIy0uK/1Qs4JFMBTEXCA9AN+n3z
         BcKA==
X-Gm-Message-State: AOJu0YyL1Uaz/eoHJ6c/Vz71Fpdj4yYXyERT/uBCBNJ6TqDCJYh498vT
	fv4WCZZIAqyB+Dd+XPJ3AAFdEi/BouIeF4ugvOVs3JQNB0k1dB5CzyxQTQ==
X-Google-Smtp-Source: AGHT+IHHbD/0ce7GjraOkDWk3KZ220i9Ap41Wjh/Vp9XoOzLyPu2WDBJzKo5iWP+YxDFMzrPa2D9zA==
X-Received: by 2002:a6b:311a:0:b0:7df:a482:c93a with SMTP id j26-20020a6b311a000000b007dfa482c93amr614749ioa.12.1714674908736;
        Thu, 02 May 2024 11:35:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::d802])
        by smtp.gmail.com with ESMTPSA id o16-20020a056638269000b00485128ef27csm339993jat.168.2024.05.02.11.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 11:35:08 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
Date: Thu,  2 May 2024 12:35:01 -0600
Message-ID: <20240502183501.1216856-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 18:35:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16183

Handles ImportError when creating a hash equivalence to ping the server.
This notifies user earlier with a more precise error if websockets can't
be used, and also prevents passing a known bad upstream value to the
local server

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 25b614f1e44..939a9999746 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
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
2.43.2


