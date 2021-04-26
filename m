Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web08.4094.1619425011681530720
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 01:16:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=B6KrHRcR;
 spf=pass (domain: konsulko.com, ip: 209.85.128.51, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f51.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so452987wmb.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Apr 2021 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VIEpnMdSIVCReugVZnvS4P5gLTz5C21EOFyJ4cbB/0=;
        b=B6KrHRcRM5n4Mk2GOrlNmhxZS5hG9Y/Pp/+H2dn2HAXOwhI9G/dZJ0Zuvw6Dw4dAyB
         +XZpDIktBTmjl8Z6YJNbkci4YPyQM5sNDUBInahCj/4uPnJQU5SjT5BgwFBo9pqEl5uq
         4Y6e6mQkd1mUhqNh3tes9TfOT2A882BnTmTLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VIEpnMdSIVCReugVZnvS4P5gLTz5C21EOFyJ4cbB/0=;
        b=h2QS09EZ2UX2bT0iCM0cqiwiz31/cwnoyovbdsV7oHVerpuPNBSqkmmdPtiifgOU9+
         ssqL4Tgd7nIUASyNJK+89Ea1Zo3+Mub1Zi09207qz36h6I3OAGRrYUpxgUp+DfayEPDI
         SdaK1EjUT6cLWXL7g0XxFVKDcKHOJQNq/4Va83aafvO/IT+MU1qL2AM7xONw/TY0a5mI
         FZg2Qq37L1G2GYTq8j+hMi7Guhkdsp4RbVzRVJt3B0zSVsPbM+TP69xl/lXP1+B3xWVi
         PRuuDU1IJ+Br+QobNzSf9VT8DI9yyZqt7yh+UOKHhKqfu3hw7nVlencmD3jghe0nkAhv
         r/vw==
X-Gm-Message-State: AOAM5322PoVRIk/IjKRIoz2OHHVAHIE8tzaDi1A5Gk6L+lf6GmBhYUmT
	CAVKK7Mb8IICnUs45bTCxR8QIhTieynJrw==
X-Google-Smtp-Source: ABdhPJwun5/kYVP2PW00B6+KM7K9+dr0Ua1TSd/5HxPh9OQl3Pf0dCblzgPPPvFqnqp9TQ85B4xLRA==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr19799756wmh.78.1619425009803;
        Mon, 26 Apr 2021 01:16:49 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id a9sm4631320wrw.26.2021.04.26.01.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:16:49 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 6/6] prserv: Add connect function
Date: Mon, 26 Apr 2021 09:16:33 +0100
Message-Id: <20210426081633.5020-7-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210426081633.5020-1-pbarker@konsulko.com>
References: <20210426081633.5020-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function abstracts the setup of a PR service client connection so
that openembedded-core doesn't need to be updated any time the details
are changed.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 6ccc7ee9e..4375d3e59 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -482,3 +482,6 @@ def auto_shutdown():
 def ping(host, port):
     conn=PRServerConnection(host, port)
     return conn.ping()
+
+def connect(host, port):
+    return PRServerConnection(host, port)
-- 
2.26.2

