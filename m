Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACD7CCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 14:47:07 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11297.1762354018017285235
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 06:46:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=kDB2OD2L;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.181, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7810289cd4bso7564135b3a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1762354017; x=1762958817; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRT4w+GwVR94b+LP7okZ7Sv4eCio5Ny0v9sj8TS207A=;
        b=kDB2OD2LFB2YyMJp459A+PodNeR0h0zO8VVkRdKvpr9CAg3wWhuPNq5MxwBiFqlJNx
         qizl7VBbUNj/WeTBfLrthAnWMjymdSAUllz5FITLFMacWATplzwJpZkgEwfEAc13G+JU
         0MbRSmNKVsY7FoiYnTaEVAsZjut1/1U4n1k5Q5UxtA2anCz1UdYlAWhNzwlqOQUzddTR
         BTTlRu7qVCYmJj+avhNaIYpARcvvSovjWfZI98sgDnTpnijI7a9Zwvy6A5sB8SFQKBO4
         g5c+GzAadzIC+IFe3SFDQo+aZyQmZK+i7/CaAjbX3P1Lcq+779IDt6MqX60NUaFZlqMA
         dn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354017; x=1762958817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRT4w+GwVR94b+LP7okZ7Sv4eCio5Ny0v9sj8TS207A=;
        b=jQOyGkYEjgqvmRYzT6G2sFmpmbVG9ni53X4rvxIiItB+9RMqIGLKQikdXZ3xSP/U7t
         HhWQREtTyROid1CpYJZPnCGSU812Tzz4K75MqSWQSrNEE15ZR3KJOK+6KCvR///RQANC
         9S3IhTkLcQtR8HC2wExewjxjPuEio+o3XS/I7+N72Kb4uwNfx6Y9S3aReaQMxGOisycq
         k3wG3iLs8blBkqUvzpvoQ3LrNfuAcCmYlOoWP3HaZxIL5CdqdIPo8ahLDn1AokO81h4X
         PvRBDPann0T4d3wwqxZz7Y7/RjEdAOC9w/Cm9voMGQwemWTB+uW8i4KghbI3IRMK+nrG
         vPrw==
X-Gm-Message-State: AOJu0Yw6U4iZqQn+iLQ2xYCqDjbtU89ld8Gb3mlTiRSkY42+lO3AhyCY
	AyoOWrs6BR9KSeV8csUnFxq35ocvI8oyY8mXX+jE/jUiIDBMMGTdGm3EufTmkb4vT+r4r/vHpha
	u8SCYzsY=
X-Gm-Gg: ASbGncu0a4IyjNA6fTxSdVGDRxUOEwo2YCZlvofYnNg9rsnfir00hjkzMUWuTyBheb6
	RtkF1Nnw/KHfXIr2ntK4MgHZEoPokM4IOaPF66d99xW588MBaqagbrpwDI3H31lE2/pD2y6MOta
	cDaomkAsIT7l2mNRH1WnAqXsCSN3YI0ACiirvShvdveMEy8BFTpCc+LMuucyvZqEOA2XgiEws2D
	Xl3dIeNRyH0Png53Sa7ogf7hyyaqpGIdKlYRTBWJm8RDv4xPvhNvTTd3HXFwcA4ThCIPdnYMKeb
	bryWpffV2bdUz7g92miMCxk0JaUdISkaGMwjZP8ReVz8Utm9gZ2Q2SF/PP/YKd7U+VFEZgjQfLc
	pQYnVmvIKQhlv2hI33p4W/YMS46Z3wpfjkvkmeFDdNpAPUOSHCQ5E9geLE/Bp17sPSs8=
X-Google-Smtp-Source: AGHT+IHbMgFS9DsjOiKX/p3hp/1EsCBwQAQvURBeVKWAvsC/Uzcbc7+zgGSgaedZ6dJE3NG0WtqGnw==
X-Received: by 2002:a05:6a20:3d20:b0:344:f9e5:e9a9 with SMTP id adf61e73a8af0-34f83d11dcamr3394168637.18.1762354017266;
        Wed, 05 Nov 2025 06:46:57 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:56d2:561d:76c2:db7d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3921584sm6589449b3a.25.2025.11.05.06.46.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:46:56 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/2] fetch2/wget: Keep query parameters in URL during checkstatus
Date: Wed,  5 Nov 2025 06:46:49 -0800
Message-ID: <b994c77b6f9ca95af1967f3d55cd7eaa4eaae060.1762353905.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762353905.git.steve@sakoman.com>
References: <cover.1762353905.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 14:47:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18265

From: Philippe-Alexandre Mathieu <pamathieu@poum.ca>

When recreating the uri in wget's checkstatus method, we only use the
scheme, host and path. This completely strips the query parameters from
the final URI and potentially breaks the checking functionality for
URLs that require query parameters (such as the AZ fetcher with SAS
token).

This bug was resolved on master in
`096301250455e2a83bdd818a56317c62436c9981`.
This patch is adapted to the scarthgap branch.

CC: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Philippe-Alexandre Mathieu <pamathieu@poum.ca>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/wget.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 5bb3b2f36..2345ba6b4 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -344,8 +344,11 @@ class Wget(FetchMethod):
             opener = urllib.request.build_opener(*handlers)
 
             try:
-                uri_base = ud.url.split(";")[0]
-                uri = "{}://{}{}".format(urllib.parse.urlparse(uri_base).scheme, ud.host, ud.path)
+                parts = urllib.parse.urlparse(ud.url.split(";")[0])
+                if parts.query:
+                    uri = "{}://{}{}?{}".format(parts.scheme, parts.netloc, parts.path, parts.query)
+                else:
+                    uri = "{}://{}{}".format(parts.scheme, parts.netloc, parts.path)
                 r = urllib.request.Request(uri)
                 r.get_method = lambda: "HEAD"
                 # Some servers (FusionForge, as used on Alioth) require that the
-- 
2.43.0


