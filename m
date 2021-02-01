Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web08.32677.1612180421974846746
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:53:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VzDhsSpg;
 spf=pass (domain: konsulko.com, ip: 209.85.221.54, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f54.google.com with SMTP id q7so16218439wre.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 03:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VqSPtjbeqfF4JpYG8hgAAZO1GvEWZLUre6XlG336zc=;
        b=VzDhsSpgBl8uQOiBGr05rwzh07m0Qme1s0bJwLY/0nKvLKaqAHM455X8H/PFaevrHh
         OGtzlL6otMM6zkw8YmIrRSYevcMbmKlEJhtnzIdR1qWFZCzrv7L3oaQo6oH/M7ASRs2L
         4ia+6GJEGWGfe68HMBelJOZD1A4gPKlbX6ASE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VqSPtjbeqfF4JpYG8hgAAZO1GvEWZLUre6XlG336zc=;
        b=fwJr2INQDhNHGkc26LoG+JFD2852H+qNMst0XqA3WRKmgc5vvneSLWwlfd3//Y4jry
         SP1UYGODpobZiBJv2rX76zQ2mEKyjB8RtllBjoV7TFwgi0Hb4tsj4OrkYHxWX06rhZQg
         3QYXTFIR/KlOK3lLYkhxnc4QSYb0YqHC475Dt6I0bH6+NQt+qjEPd34tW1oQX6MitGJa
         pfTu0NFMkUYBCZAKrF5hvRHv0SRIfJoFDZGhigywdcly+h8GJmTCXjt4cqEvKZC10txM
         7rqFDi1C+ye1Go79LQaXLikZpRj6/LyViZwsTz4VbGtjbRheqVXTv2p8mMaSH9Lt2ea+
         m6MQ==
X-Gm-Message-State: AOAM533Vnku3WwRdIwFCAZkPMqneHRZW6tWK/LmNm7lIatcNMx/3xDvA
	lc+CIRQT6sghoQfHTLEmIfayHoOrFKzymWTi
X-Google-Smtp-Source: ABdhPJxD4DCRV/OHkyTPT5jJA8tdna/pM2cT2qG6pVVWXOppccocOpu2UFyAxQKr8/nvrTFeMrGWnw==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr17691822wrt.312.1612180420403;
        Mon, 01 Feb 2021 03:53:40 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id u6sm28120514wro.75.2021.02.01.03.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:53:39 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 6/8] hashserv: Add short forms of remaining command line arguments
Date: Mon,  1 Feb 2021 11:53:29 +0000
Message-Id: <20210201115331.13510-7-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201115331.13510-1-pbarker@konsulko.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Short form arguments are added for convenience.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 bin/bitbake-hashserv | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index ab71f4e6c..153f65a37 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -30,9 +30,9 @@ def main():
                                                "--bind [::1]:8686"'''
                                      )
 
-    parser.add_argument('--bind', default=DEFAULT_BIND, help='Bind address (default "%(default)s")')
-    parser.add_argument('--database', default='./hashserv.db', help='Database file (default "%(default)s")')
-    parser.add_argument('--log', default='WARNING', help='Set logging level')
+    parser.add_argument('-b', '--bind', default=DEFAULT_BIND, help='Bind address (default "%(default)s")')
+    parser.add_argument('-d', '--database', default='./hashserv.db', help='Database file (default "%(default)s")')
+    parser.add_argument('-l', '--log', default='WARNING', help='Set logging level')
     parser.add_argument('-u', '--upstream', help='Upstream hashserv to pull hashes from')
     parser.add_argument('-r', '--read-only', action='store_true', help='Disallow write operations from clients')
 
-- 
2.26.2

