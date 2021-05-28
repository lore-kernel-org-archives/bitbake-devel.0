Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web08.5694.1622191337332212030
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 May 2021 01:42:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WFZgt34e;
 spf=pass (domain: konsulko.com, ip: 209.85.128.41, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f41.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so1933558wmf.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 May 2021 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gsd1cpRAy5NhhHclv68PDX0ZiSOF+vA48aV9vJs5MuQ=;
        b=WFZgt34evRlfEEBy6BX6Jonvub20mXnsEmoiEx18lr7ygn7V0st71UTVdPM5a4Po1D
         ERjLJ8S/SX0UcRettYxSbXrgyc8EIdBYFDeYT4dfm/NiDEdW3oBZbbnLyr5oSA72zLnN
         Dw8NrmgK1vPRI4YKPxjpVNDAGaxnpzwQsnLVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gsd1cpRAy5NhhHclv68PDX0ZiSOF+vA48aV9vJs5MuQ=;
        b=NIeJ9kv7xF/BR8y/zVR4/P3lk8gxgcDbd78CSwI8JqdBKneGf5G3c31Dj9rHCeS/Yy
         WKeD6VbEG4ClzLfOidkuqIKP3tH63pjPuYkjNpVw/9NWoS4DyzA6VZDDWgY2/WA3KHEK
         H8D6MXEdb81wTl3g/6lAr2a0QzRr4qxVOl0knAbTgd9Vb67baSTjOI7OmDuXmdnOTauL
         iZGKVYk5xqLDFKZH4LiaH51yWSRASN7pueb6g6ZY065ZjEmMDQCbX/KvAY91atdQ7P//
         g4fS11ea6GFFwByRdaF7bi1kJHTzexp2D3j5Q6SgJz5q1rWCc9pp56mimcQ988guFLbf
         ridw==
X-Gm-Message-State: AOAM5327opMwrP4wgRoEquTTj0H02iKPbuKz5MDBb5sUOegSa8UNh4BW
	zoP1rfFcY2WMkBZoAIhDTW6A1Ut/VI9IfQ==
X-Google-Smtp-Source: ABdhPJw8S0AElnEzJmL5rNloanWB7Fr9OejdmF13WX/tIASup6ROMHtZmKdwNqX0EvRbaZMASHpp2A==
X-Received: by 2002:a1c:638b:: with SMTP id x133mr12425748wmb.182.1622191334909;
        Fri, 28 May 2021 01:42:14 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id o17sm4596385wrp.47.2021.05.28.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:42:14 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 0/4] Re-implement prserv on top of asyncrpc
Date: Fri, 28 May 2021 09:42:05 +0100
Message-Id: <20210528084209.8408-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes replace the old XML-based RPC system in prserv with the
new asyncrpc implementation originally used by hashserv. A couple of
improvments are required in asyncrpc to support this.

I finally stumbled across the issue which led to the hanging builds
seen on the autobuilder when testing the initial RFC series.
It was a fairly dumb mistake on my behalf and I'm not sure how it
didn't trigger in my initial testing! The
`PRServerClient.handle_export()` function was missing a call to
`self.write_message()` so the client just ended up stuck waiting for a
response that was never to come. This issue is fixed here.

I've ran these changes through both `bitbake-selftest` and
`oe-selftest -a` and all looks good on my end. A couple of failures
were seen in oe-selftest but these are related to my host system
configuration (socat not installed, firewall blocking ports, etc) so
I'm fairly confident they aren't caused by this patch series.

Paul Barker (4):
  asyncrpc: Add ping method
  asyncrpc: Avoid duplicate sockets in TCP server
  asyncrpc: Reduce verbosity
  prserv: Replace XML RPC with modern asyncrpc implementation

 lib/bb/asyncrpc/client.py |   7 +-
 lib/bb/asyncrpc/serv.py   |  16 ++-
 lib/prserv/serv.py        | 271 ++++++++++++++++++++------------------
 3 files changed, 163 insertions(+), 131 deletions(-)

-- 
2.26.2

