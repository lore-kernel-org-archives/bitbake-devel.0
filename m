Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A64C25B7C
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 11:49:45 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.9587.1717156177739459796
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 May 2024 04:49:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ooru7mZI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63957so797387a12.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 31 May 2024 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717156176; x=1717760976; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rx9MUwPhPMxopcbNtODvc4bD+og7E1DT28B6OP3Y/M=;
        b=Ooru7mZI66wX4nhqvScql+59gjp5RAIhMYoJOL+Khwo6mUa0OThQnxcmWWQwakH6JJ
         IOxS5VdHmaoC0+QOqbLSfLNOCLOVx788qVdyLQD6sU6lTAn77UBQchysGKhs8fpDhUpm
         3OoXx6uXiON31dAycfa940G47KC/iXBuYirMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717156176; x=1717760976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rx9MUwPhPMxopcbNtODvc4bD+og7E1DT28B6OP3Y/M=;
        b=tgxJ+odrGQxouzkX5c7PQCLPcaR2GQ91npGC7ECrS8TiRx521q4Y6M7c43lR4tDbC7
         xf/5hlmwJOt+6MhE0NTw1LvW2ZtGH797pRPNoKMk2Igy4uF2O2sG2f8m0ZbO57mAgI8B
         4tgggW2RsLeajGH6WIKaLvjyqPnfOo91cRE9jd+AIDu/wD0pSbhaVuEFC3MqZe2F0Dh9
         vtDMvcmdtoMYa+PmLlA7/zrzdMDAZETMzK3VLt0JvRrmocEHedy3mdThgT/wl69P/Zcg
         YvM7Y/t36E0q6kZJx/0vI7kD5sApM2n9ZqIwhdgjaUJBcVC0iPqx2BWQnRgHx1wQELA7
         Gg2Q==
X-Gm-Message-State: AOJu0YwjLWd83aiaoJ0B7OspMNI0snKjXAzEbBFnMlqiHifWKyqEv+wf
	RwNHB6h7T4MGYSTVRg0CMhccQxPJpIlmP6oIX3T1g/RPCgWmfYwyl/fuW5zm2JbgXPpVdpqCQIR
	Y
X-Google-Smtp-Source: AGHT+IESq4saoMlIzx0qJCMbriZuerp0rT1xNacjCK4Jzqp+hl8szZ10r4Cra00HJ5LoLQS1RS4hvA==
X-Received: by 2002:a05:600c:3106:b0:420:28c7:7260 with SMTP id 5b1f17b1804b1-4212e075761mr15597205e9.21.1717155696326;
        Fri, 31 May 2024 04:41:36 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9173:4fa2:d1b3:c8be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270ad1a7sm51799405e9.40.2024.05.31.04.41.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:41:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Tweak to work on Fedora40
Date: Fri, 31 May 2024 12:41:35 +0100
Message-Id: <20240531114135.3255085-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 May 2024 11:49:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16298

On Fedora40, "localhost" sometimes resolves to ::1 and sometimes to 127.0.0.1
and python only binds to one of the addresses, leading to test failures.

Use 127.0.0.1 explicitly to avoid problems of the name resolution, we're trying
to test things other that the host networking.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ed7a39a723..1e55cdd299 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1525,7 +1525,7 @@ class FetchLatestVersionTest(FetcherTest):
 
     def test_wget_latest_versionstring(self):
         testdata = os.path.dirname(os.path.abspath(__file__)) + "/fetch-testdata"
-        server = HTTPService(testdata)
+        server = HTTPService(testdata, host="127.0.0.1")
         server.start()
         port = server.port
         try:
@@ -1533,10 +1533,10 @@ class FetchLatestVersionTest(FetcherTest):
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

