Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACAC55175
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:06 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18452.1785436377026396502
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:32:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=C9yPF3i8;
 spf=pass (domain: gmail.com, ip: 209.85.160.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44cf70de986so94886fac.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436376; x=1786041176; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zQpiRcz/uvL+PCEv6TePtRQZeaakphtp0ZDlVgn7Vwc=;
        b=C9yPF3i8bovoLK2hKSpOz97MeAkZWay0X+VsHQ1wVCQghpNqvEmBbBKOt0TxfNrOjH
         mpVaaYrbMBhbFP6AhLsTkDx2GCgo7KZZnDXoHnbSCaB6GK/2CM2nPr3BRV58gVcCk4Ao
         +GgK/CW3V0eRywnii+/jb2YH4ssj72HSkhbzuUjnsRUUYDIULu3Ae50T+AWe7xGnbdvO
         7qsw7JpMEqqwOz2+Qxu9nK2+FZZpEVKKkyMzT9D/lQRJ1vld66QeZz8B0nGUhz57RJQL
         m1aw33GxtauyhkvOOfAqI85ZbnHkjH9gnpY9d8Jvm7ISPrHladmqp+WX/QAh22eFYsO4
         keKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436376; x=1786041176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zQpiRcz/uvL+PCEv6TePtRQZeaakphtp0ZDlVgn7Vwc=;
        b=LzbMq8yVIKsKp36DNW7ARehPoTlHfCArS7ZWaeVSsZNWtyJ1VSovBqNZ+Tm8mYOM0t
         kNELFpfZRqQ1kXWp6iNe8wpV3W7PUAPwRSJdgy5RT4cqt8ABsqvspRKEm/b2Fvnw5DsI
         T73pJEY126tf+MCYm0v0V/d2gNacMLwT0Ve13eoUEvIXoTrefkA74DLnZbadCLb5cbTj
         m8dFgiIKY5gjoBTLJr3cTC9UpdpL5ilDJ71l402CuHnYq/cAWpxlka2yMIJ5q63wPrTO
         R7AXW6YpM0xQWZewXUBcurC/VkJMf1zSw/LlXyiBNAWggazG4LiU5Gf8fU2SzJRh2d/L
         VB8g==
X-Gm-Message-State: AOJu0YxuePS4nYFXRq93VaHe7xiqlYsGlomNtgcN6ZJ9VFHHJv24cPsZ
	Uk4x7M1KjsLg3P8HNKtMhnN1pQ9mA65UzI6i5ACKqpBJT3OHJnWtt9cQrO9UlA==
X-Gm-Gg: AR+sD13NDHbZAo+eTKaR1I1uHYZffTQMn3wFbNrSctiATSIymXU5hrOBrQJYr/NEaB2
	g2xQdz2O2Aonm6YNAST2axfyevBEa723IEFhGRmn1tgOBusTg8HBm7aFEyBRKt9NMoxHxSAWJRt
	TemtK1pZd9PLvPU8X/uw76ZExWGnIKMEtO/bSbwbBvaRUiIWjfWCj/Np14kfJ/W5XKCo764F9p0
	UXp5zCpz4JvXqgyEumP4CjlBoCQxJaUWiW7OWoysozm6bGHW+0ZTSJd41CRAZTB/TuIYst8l1MC
	nKMwtOk0WvBCYiFtVZ7QI/ClcS+nz2QrwuMqKH81KbjltDTM0ZrzItYjEcQAZoFfzKkaTTfuMAp
	aYGr7QPiI4lR7bcsgCBn1sXXXrpCos91zXzLEEhZtg/uxylu8bfRQL/pFnbSD+Xulb1vm/DLZed
	8csKzozlB3n9ebFdWrYKJV7BeLuf7mRvSfYnvPuI0Fzi4So0TM5Q0LfgJA+A==
X-Received: by 2002:a05:6808:23d3:b0:495:e16d:5d03 with SMTP id 5614622812f47-4ad87952e6emr2516277b6e.21.1785436376147;
        Thu, 30 Jul 2026 11:32:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:32:55 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 00/10] hashserv: Pipeline Upstream Queries
Date: Thu, 30 Jul 2026 12:30:53 -0600
Message-ID: <20260730183254.793698-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724212822.1165552-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 18:33:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19880

Adds a true asynchronous streaming API to the hash equivalence clients,
then uses that streaming API to pipeline requests to an upstream server.
This means that when a server wants to defer a request to an upstream,
it no longer has to wait for a complete round-trip API call. Instead, it
can use the faster streaming API to send the requests, and continue
processing other requests while a response inbound.

V2: Fixes several bugs related to when the connection between the client
and upstream server was disconnected, and added tests for them.


Joshua Watt (10):
  asyncrpc: Add Task Group
  asyncrpc: serv: Use Task Group
  asyncrpc: serv: Cancel all clients on server stop
  hashserv: tests: Improve test logging
  hashserv: client: Add asynchronous streaming API
  hashserv: server: Add queued streaming API
  hashserv: server: Use streaming and queue API for upstream unihash
    queries
  hashserv: server: Use streaming and queue API for upstream exist
    queries
  hashserv: tests: Add more upstream tests
  hashserv: tests: Add test for upstream pipelining

 bin/bitbake-hashclient       |   2 +-
 lib/bb/asyncrpc/__init__.py  |   1 +
 lib/bb/asyncrpc/serv.py      |  13 +-
 lib/bb/asyncrpc/taskgroup.py |  52 ++++++
 lib/hashserv/client.py       | 349 +++++++++++++++++++++++++++--------
 lib/hashserv/server.py       | 181 ++++++++++++++----
 lib/hashserv/tests.py        | 261 ++++++++++++++++++++++++--
 7 files changed, 723 insertions(+), 136 deletions(-)
 create mode 100644 lib/bb/asyncrpc/taskgroup.py

-- 
2.54.0


