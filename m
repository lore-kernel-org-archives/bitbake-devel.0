Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE1C61DCB
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:55 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4133.1787932786169334297
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RsuHlvGV;
 spf=pass (domain: gmail.com, ip: 209.85.210.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ee4399c3abso1234229a34.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932785; x=1788537585; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6jUTStZ8e1C2OBxSStAZBHwgK5fV6ISN2is5wZzl/g=;
        b=RsuHlvGVXBZrKmWKwiN5f5AomRDxm4hXnaCNIA4y1QIeWkwx1WfVYkV30l79lmOloH
         JFxSNtaRmjGMaIFgYgxFDA1E6wmrm8GNyTLa8nIjGFF4WAD2wRHtghTZj2LFjjDayPMm
         HjjhK9A8CVQcGE9IcenI6cdJCJqZ6Z68VEmpqZPc+2UVbFaC/53K6xfS5WorG4R1owBu
         f9tVDj/fjiyPOsNacEs0hND6OZ6dFNL+59XdQWvDL97bPn/jgeZ8ny/3nypRQK0JkjvE
         O+uPpf61F++WhdDcP3iNehM88Lve9wKHBE9DfDz2HPjcNSbEAjT4b3xFXJfME/JqXJ1J
         QETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932785; x=1788537585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6jUTStZ8e1C2OBxSStAZBHwgK5fV6ISN2is5wZzl/g=;
        b=i9gufWWLwtY9c7d5LOpD7On1/qmfjOWW4POS3/C3ZxQOYv4X/iDYaf/d10GR55/MqC
         sIcjNN4xO4m/72nhwaT5qDbuvYGy8NNcCwDlHc08u8ayHL39PxyfdIGv7OCknzeKYI+Z
         umHQMWxplTD8H/HeOOA5i3kS754HYbKLsHttbaHCNjRGo3E1uPh0e+JXpqOsDFqmd6t+
         rya8XYg70FyEmbp+QqmB9TyR2yNYEL1q7esKBJh+dATV2WDaJR2plUKrfxRZii2OysR2
         JkOUDrRnsByr3C/idhmkULe7UculcAB4cg+6CWk/Lk7fBeGzqEecyNJZLZfvJ1eCbGlY
         u1xg==
X-Gm-Message-State: AFuF++nhrsEn1Clv/jv/JikY++3Y5YOwdaL5f12AvkBzge4Gs6aw4Y0J
	gRSX1G2O7nYiMhYTx8XOJb0/9QPR8HIRH4HqAUnXx/qYo7JPWLftvgSVjYj4Jw==
X-Gm-Gg: AR+sD131VlG8jYt471SMSN4IVpEPSBDWmzg6eti3zRw0J4hWM8SLCePD9vvChYtzBXc
	peqAH/FFz4cGt4+zRgkylVWSG5b/QFdG5c4ZnS/nCLkvrxAvhxKG0nKJPPOSMpTfDsIz4OnKrRa
	BPP1gCQOPa/b/uTwQIryNgnQpu+mxIxLDhF5Ku3v7YOCWFBd0S25Evgf7GknBM6LVH+s25oGrQo
	yYsLwRSNFF9BvF2Rl50v6VEqBc1l27lbofG0YgafpIyrJSjbFC9edH1ukat87vSw8WJPhsJUN9Z
	/hXrZMiLCGF/Ednnx/9B7HIl6VQCpHJtDmJ1D4v9t1fET9zGoWajHEUhiXPIX8WOicF97jIzpju
	tD47vNec4x7vbH1l8bSV5fEHgujSGeEdTC+QuRRmXErAXdODuV6gUiXCXPAikDgYL/EcpR8ffC9
	Ii08WLFwiSOyYv1xIeXXTdVq0TvCQQn4QE11j/24Er7bQgPgsiSbLNi8dwk6jcI7/zNKCQ
X-Received: by 2002:a05:6830:4491:b0:7e6:cee5:1bbf with SMTP id 46e09a7af769-7f4f250f5e1mr9536617a34.12.1787932785036;
        Fri, 28 Aug 2026 08:59:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 00/11] hashserv: Pipeline Upstream Queries
Date: Fri, 28 Aug 2026 09:58:07 -0600
Message-ID: <20260828155942.1219468-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730183254.793698-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20106


Adds a true asynchronous streaming API to the hash equivalence clients,
then uses that streaming API to pipeline requests to an upstream server.
This means that when a server wants to defer a request to an upstream,
it no longer has to wait for a complete round-trip API call. Instead, it
can use the faster streaming API to send the requests, and continue
processing other requests while a response inbound.

V2: Fixes several bugs related to when the connection between the client
and upstream server was disconnected, and added tests for them.

V3: Fixes an unexpected disconnect when there was a unihash miss from
the upstream server while streaming

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

Michal Sieron (1):
  hashserv: server: Fix upstream get-unihash miss truncating stream

 bin/bitbake-hashclient       |   2 +-
 lib/bb/asyncrpc/__init__.py  |   1 +
 lib/bb/asyncrpc/serv.py      |  13 +-
 lib/bb/asyncrpc/taskgroup.py |  52 ++++++
 lib/hashserv/client.py       | 349 +++++++++++++++++++++++++++--------
 lib/hashserv/server.py       | 197 ++++++++++++++++----
 lib/hashserv/tests.py        | 298 ++++++++++++++++++++++++++++--
 7 files changed, 776 insertions(+), 136 deletions(-)
 create mode 100644 lib/bb/asyncrpc/taskgroup.py

-- 
2.55.0


