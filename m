Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web12.28619.1605020399761893302
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2020 06:59:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=XCVycvcs;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 30so7012765otx.9
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2020 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMxeHPJZfJn7DEXRLEnJbEy6kz5MOtnZWRjlQe7UlBw=;
        b=XCVycvcs/bobmUJdRgI49jGBk+uZEXg+JqTbxx7hYmj5jBfIL6STDnmd0KvLP5k7xm
         VouGyViM34X0HW+5jFHhw90F72UhdNJ8aR25TfdYdmS0qfE+s3fNOcTyAga+6wA8fuxm
         4bGika64xZeJ0CpDJNbyY8XhNAlsnalimChOeqUrL1Lv94twyoHW9yKcqCmWvrQL5gNz
         7tZSNMTEHtvbJyYLBdY3QscowON8XuavSU2LyOps7kwdsE/gpWbBzjdu+l7QvAyffEsH
         /5o9hftAgeXwo1VZ+UDEtxIBsgZ9J8DnQWEpBtM1fnf3zCQdTiJ7Vwq4pNW019gmZ1TB
         i6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMxeHPJZfJn7DEXRLEnJbEy6kz5MOtnZWRjlQe7UlBw=;
        b=ZcTgvXGgTlrprukX7t3jniKAg3MnODTzrCjE3KlnwdNo8zWIJxQf99DJNi1rNWft6S
         /TqtbLqSj8CC0X8CIuke5HL1b4B+TGDw2xeINvSWWpw6IsDFFgIVsEuLBoeLn8sg8zSs
         jAH9gP/KqyItzPnyTaEitKUNfx5E35PfGX3SZyDRp88OznE+JYt0pEzeQchnQpluVWo1
         SAgr/yqgQ3ztlF3vEugGsf/Hzt9dpFjb+4cuPyGudo8kOE1HWAElnez1ijdnkf6B7Zyn
         SWobJnRUihs7oGLnvPnk9WIRo1yskVhwIWBKrefU8L6hlJFAVOqyxAVAtHfM+k/Iii0r
         iIgw==
X-Gm-Message-State: AOAM530xJKpdjqaHMIpxJcTiSGPXmE7LiygKw87IShz+X3q9btlIpcRw
	2ExTGg/S6Y9GYxlv+rkOSoabX2QbfM9Ytw==
X-Google-Smtp-Source: ABdhPJy7zaRvT+kbA0oLh3uCCve9WlQrFUGw49H79uWS3+zj8avZDPj14zd6V/ogxXcrEAvHBxYv7w==
X-Received: by 2002:a9d:4b0a:: with SMTP id q10mr14223679otf.271.1605020398785;
        Tue, 10 Nov 2020 06:59:58 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id a21sm1191038otr.36.2020.11.10.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:59:58 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 0/2] Add support for readonly upstream hash equivalence server
Date: Tue, 10 Nov 2020 08:59:54 -0600
Message-Id: <20201110145956.1518964-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for a hash equivalence server to specify an "upstream"
server where it will look for hash if they are not found in the local
database. This upstream is "read-only" from the downstream servers
perspective (e.g. it will only read hashes from the upstream server, not
report equivalencies back to it), but this is not currently enforced by
the upstream server.

The intended use case is to have a local hash equivalent server that
uses an upstream server, such as the one used by some CI jobs generating
a sstate cache.

There is some additional optimization that could be done; currently the
downstream server will ask the upstream server for a hash on any local
miss, which incurs a lot of latency because it must make a roundtrip
query. Ideally, there could be multiple requests interleaved to reduce
the overall latency, but bitbake currently only requests one hash at a
time so this isn't possible.

Joshua Watt (2):
  bitbake: hashserve: Add async client
  bitbake: hashserve: Add support for readonly upstream

 bitbake/lib/hashserv/__init__.py |  52 ++++---
 bitbake/lib/hashserv/client.py   | 243 +++++++++++++++++--------------
 bitbake/lib/hashserv/server.py   | 149 +++++++++++++++----
 bitbake/lib/hashserv/tests.py    | 147 +++++++++++++++----
 4 files changed, 404 insertions(+), 187 deletions(-)

-- 
2.29.2

