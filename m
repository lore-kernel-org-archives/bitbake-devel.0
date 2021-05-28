Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.5641.1622191337977013186
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 May 2021 01:42:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VAkS+1EN;
 spf=pass (domain: konsulko.com, ip: 209.85.221.49, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f49.google.com with SMTP id r10so2419740wrj.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 May 2021 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugO6f66lvlsJ9F6ypuMfClkfmJ28KToPtyp6TpzFxr4=;
        b=VAkS+1EN0/cQZc8JjITuBP56SkVRziCsj3DaFJ+KAbnR+X7dQwFXbWbXspNVju7Mek
         qTd0C+EQyQm5VfA13Ug10Bpj2KIS9d7+xucPI2uoB/WQlWpxuEMFzqlgx2yiFQB8xWDV
         5+qjJlF/23MSDnt84yL12qbGRhNo6eEC+ZMtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugO6f66lvlsJ9F6ypuMfClkfmJ28KToPtyp6TpzFxr4=;
        b=F0UCBKqAiRtrzGOoLlJsaZDLQoEnrfhzUFhACRiwAD3YMXjsHNKT/n2O3hEUIywyHH
         Z8d575/9cqN1H8XVZZwiB13tkylNR/jkSHXftNKVe8GSfpPjjC4LqQnvXe/fvgHQ8t2/
         OtwQHi08u4BZhBS/IE6oBh/n18ScG5c4dH05sTwI5N2v367LiPNKLFKE8jTgwKV/r/2V
         D3sEvTgPMLzOZPZw5dquvwvr50NCL8UH/Dgy1CNUXizOPn3wXm1fZBlRh00d+wUn/yx3
         psgbhqMQxIYkUle3QcgF16ft8D16ocKSC0lcUN1K78DspWNVyT1fof23TapwDBdXIGu1
         yfcQ==
X-Gm-Message-State: AOAM533FuG+VhB0f1mBSSGODxWFdzDGBDp5Z0TiXLnn3uoX1Q8giYAMR
	RMen7RRQLzJhuk0HQj3nMVdp0UTAjVpYPA==
X-Google-Smtp-Source: ABdhPJwNQRVt+c02jh9PZf5+CIkbmySO7Ff4qV21r1Imp8E7wKHBDMxqx00VMimqmQV/TqfMVICqdQ==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr7383486wrs.314.1622191336323;
        Fri, 28 May 2021 01:42:16 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id o17sm4596385wrp.47.2021.05.28.01.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:42:16 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 2/4] asyncrpc: Avoid duplicate sockets in TCP server
Date: Fri, 28 May 2021 09:42:07 +0100
Message-Id: <20210528084209.8408-3-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210528084209.8408-1-pbarker@konsulko.com>
References: <20210528084209.8408-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling asyncio.start_server with host='localhost' results in two
sockets being opened with different port numbers (one for IPv4 and one
for IPv6):

    NOTE: Listening on ('127.0.0.1', 38833)
    NOTE: Listening on ('::1', 42029, 0, 0)

This is unnecessary and can be avoided by passing host='127.0.0.1'.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/serv.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index fd91aa71a..003a118b7 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -142,6 +142,9 @@ class AsyncServer(object):
         self.logger = logger
 
     def start_tcp_server(self, host, port):
+        if host == 'localhost':
+            host = '127.0.0.1'
+
         self.server = self.loop.run_until_complete(
             asyncio.start_server(self.handle_client, host, port, loop=self.loop)
         )
-- 
2.26.2

