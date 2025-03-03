Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4161AC282D2
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:06:35 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.52729.1741007194571769271
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:06:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IQgWomd9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so11736455e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 05:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741007192; x=1741611992; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JChjod1m1BykZONHw8XPSKX3td5N9nklz6VVO7fT14=;
        b=IQgWomd9njt3pnyU93gYHnJtudOC9hFGNYMb7fvdSZz3nM+BIeQTDmhZhu9hOtOW4l
         Bq6sJjUZ+8ynfPMGnlixI0G3vLGftizhJnPZfHznfJXLXoqP3sO1QPJDpBssLf1tTx7N
         8BPURPKBEqRyjIJxxjBVZXp4ERLmoQ+DTXgZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007192; x=1741611992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JChjod1m1BykZONHw8XPSKX3td5N9nklz6VVO7fT14=;
        b=Ymq/QV87xCkE8WQyK1b9VUE/U7mA9FL7J0SIqwCFhhHRzBBbHTmoV6F4609bl7aMzU
         stlGNVEqRMyYayRMb+pNkOMg3L4bDEBtQE+2pMNnP2LXnspN2LqV1aTDb4is2Me8wn2g
         2IvP6jzU8a0dd85wHrlON2ma/E14LVT43TviBlDV3SDnTzsml+KSKOTNm17NfBySb9wT
         QBu6SLq4MG4C5E8gH7wez9LkMJD2cFgw4+TQG21PkUw6k8dKmszCUh8F8w4EDa3XR54W
         eZEly8vXVwMV7zZJgtl7gwcl4Iz83m7M59lSRsa7RQymz77MlxOGcFEel26zFWe3hyEY
         Wukg==
X-Gm-Message-State: AOJu0YyO6GmhLETxtJTpFTJm/GM6Z5Ki43t66QLw5R8TBy0gCdlYdfrY
	b6Ee/2Uxwj3EK2probTByMQJ+9SR/NiOZ7goMT+c/PV5hjmvwxW5BcMww8ukT+qZLUKeyeJjZZ8
	M
X-Gm-Gg: ASbGncsgcvMk1Pn74hMAc7nLNBk2//D+MoUk9juDeh2c3L94a5HaY28bY9WAsd4ojBF
	0bhIJ/BuoN1xOqqSachFygGJBX5zKQ3jhZeyhVlL8RE06ObipjsfEfRiubIbVjAhpHgvfkG/aID
	UUV1I9T0qwAdkxeM7MWDXod4QTWAmsRlRGYz1enV9Q7/xv73wdJviykaENdPROxVxlL9u5ZD4fR
	z81J62hIp9Tsp4mEiuWGr6KSVgVd3UpVAcFakjQEaEA3wyV0sfoX8Xkj53fZ9Oq+MfVl4V7fMIl
	ia3jMoZcCGozDQC55qA+pLmDas3s19AoOxMDpREeK/d4Rh5OXRfKaypoCbW6Z1cCf2UOQniP
X-Google-Smtp-Source: AGHT+IGm6orQHS8S4PUeHgYGgKybPp4/UloNYDB7svaXBSz81+bJayGx2v9u0H+ZNDEDGD7pHftV6A==
X-Received: by 2002:a05:600c:3b8e:b0:43b:c228:1ec8 with SMTP id 5b1f17b1804b1-43bc2281fecmr23553175e9.1.1741007192621;
        Mon, 03 Mar 2025 05:06:32 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c70:3037:60d2:90d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27af83sm160667145e9.30.2025.03.03.05.06.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:06:31 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] utils: Add signal blocking for lock_timeout
Date: Mon,  3 Mar 2025 13:06:27 +0000
Message-ID: <20250303130628.1656131-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250303130628.1656131-1-richard.purdie@linuxfoundation.org>
References: <20250303130628.1656131-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:06:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17371

We never want to exit whilst holding these locks as it deadlocks all python
threads. Add signal blocking around the lock critical part so a signal
shouldn't cause such an exit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 992e200641..3a4b29181e 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1882,6 +1882,7 @@ def path_is_descendant(descendant, ancestor):
 @contextmanager
 def lock_timeout(lock):
     try:
+        s = signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_signals())
         held = lock.acquire(timeout=5*60)
         if not held:
             bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
@@ -1889,3 +1890,4 @@ def lock_timeout(lock):
         yield held
     finally:
         lock.release()
+        signal.pthread_sigmask(signal.SIG_SETMASK, s)

