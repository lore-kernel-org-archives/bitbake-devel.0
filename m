Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4785.1795121340838308790
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Nov 2026 12:49:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=u+mvqT3u;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: stondo@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-498f5fa5103so85632f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2026 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795121339; x=1795726139; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijw2flT7UO3h78B4/qb4oRoezXXLJbqeqx18Hi0sApg=;
        b=u+mvqT3uvfo7PSUUX43xLeJveTLHtgHJoOl/+qJyLNayzD/OFDpBgpcM9KUuQfCqU6
         gA44gCQgIIuLSlt+aqSPWqc6bwEf3WsKfnY2hufKyo+uoyKH3wfIhFHAM0DVNsA3G8Aj
         pFJWHGrq5AsyyKSAmw2iDwrEcJB3u4y8ZxCXe4hBt+DpHBy9IgiLIvodOHjTyVUntNHb
         OGAJfL7Wt+NuORohKuHShqX8V7FLVIwNJWIhMNwKipL60EWNiW3kD8SwaNGtbu+EUsOv
         h8xZzqqi2NEGsfkhxQ7xXZ9Ycdh09+CZfyXhMqu4EDhWj4Z1NQnWFEQ5+LMhmm/y656b
         Iilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795121339; x=1795726139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijw2flT7UO3h78B4/qb4oRoezXXLJbqeqx18Hi0sApg=;
        b=Q2AkEsljHT81Mmk8F8ZcUf/6riEtwjTNmkqH3zWWqkSYmvhbjs1fFRgJVjLPe3wqsm
         p9jIGhhptSl4yfRoozY4kUdlnErMMoeP+PGqPcEsdi/SJTtXJOtI8qIbHiiFKjxu6Uux
         ee2qq/6C9uNFCvLYNqu/1SEE4neN8/Dg7IpfQcT6Zpt4F3tzeZgkaOEl6yWMA97NXUzV
         qrpVYg3IHcr/WVvB6egwI2dt+n11DSmoPEGdPtXBSqCFNVHSWreKtFoPyFureOLFBQMh
         OQKjQeL++d6rg5uFJmlftDMM7LsiR5uRxFhJq+8RCEWwG4BspIHlQSRR9CRIxWYhZIBE
         Iiew==
X-Gm-Message-State: APuU4Z8iHFj5tGvImYz7/eO4ep+Diiyfpha217dvDJ2P8WOQ5otoYTFY
	8/z0USSeGVVSiTJugtoa7/LErQfJbdkowKAX6Tc4XOhD+wIGSnQEDzmqG214KqlZ
X-Gm-Gg: AZFdTZdnHqsYZTEctV2uG6iQrodsQMjJXCVy5aHTMPHP2vaUNlaUnTRLls7PrH5vGeO
	NixVU6qZzfsRCCQbmD8yFanJSS0/k5vKfN4hWUfMJnQ9tVOD40r0BSamx/VX53fzeG4tbADASBM
	iNl0xrChW4+wdh9EW3Lq5Hb5F1TjvRi/Ml/d8/+2RzI9rN8wHBadOn1lf3ZHA1HCHRJcdyMIMsk
	E5GMWHz1OB6xTHykyrUs9XWySzgfEvdv5+lelsCpm6yTI03DxIUC0v3MWvyFhsPWMm36dcSZQDW
	5UMbBhEMTZrAoTAVpjT1RQYGs+exXwY5iy8IMByEbG/6EiWdy5Q16rVhAOxDzrkCx8IHIX+Blb7
	kHStBVsudGXGq+aXJoIS4eOXeF7oOlWlA1PuuOREpG26BMhe4CdlqeRe4xqR2q7S5XcFtJdsYx9
	4iPXO3yChNosSaHWndp74f0bohNBevLHuMsYJphfpZOWAzw/HWFAGCRNUHOgAjaF0VXZP3HRPOq
	sFeu2/s+ea5BVCpXr/QaB0GYt5nstnZ23TQNUU1Xmn3/8nL7fDaQ7wxDZBXo086An6DcVqbBOxL
	RghPRizccIc=
X-Received: by 2002:a5d:5888:0:b0:492:5ef7:5d98 with SMTP id ffacd0b85a97d-4abb6651686mr1045445f8f.38.1795121338819;
        Thu, 19 Nov 2026 12:48:58 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm1749597f8f.2.2026.11.19.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:48:58 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Paul Barker <paul@pbarker.dev>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Peter Marko <peter.marko@siemens.com>,
	stefano.tondo.ext@siemens.com
Subject: [PATCH v2 0/2] fetch: package identity of crate, gomod and npm URLs
Date: Thu, 19 Nov 2026 21:48:54 +0100
Message-ID: <20261119204856.2930668-1-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2026 20:49:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20462
Content-Type: text/plain; charset="utf-8"

Hi,

This series adds the fetcher API from the RFC "spdx30: name, version
and purl for dependency downloads" [1]. Richard asked for a fetcher
API that returns structured data with the purl, so that OE-Core does
not read fetcher internals.

Patch 1 adds FetchMethod.package_identity(). It returns a
PackageIdentity dataclass with the name, the version and the purl of
the downloaded package, or None. It uses only the URL and the
datastore, so it works before the fetch and without network access.

Patch 2 implements it for the crate, gomod, gomodgit and npm fetchers,
with unit tests.

The RFC also covered the downloads that gitsm and npmsw add by
themselves. That part is not in this series. Richard and Alexander
prefer to list those downloads in SRC_URI. I will send that change
for npm in a separate series.

Changes in v2:

- package_identity() returns a PackageIdentity dataclass instead of a
  dict, as Paul proposed [2]. The dataclass is frozen.
- Rebased on master.

Tests: bitbake-selftest bb.tests.fetch.PackageIdentityTest passes.
bb.tests.fetch without the network tests gives the same results as on
master.

v3 of the OE-Core series that uses the API follows on the OE-Core
list.

[1] https://lore.kernel.org/openembedded-core/20261105122145.543282-1-stondo@gmail.com/
[2] https://lore.kernel.org/bitbake-devel/DMZ3ERL47CEB.3KE9TOG6YIZPD@pbarker.dev/

Stefano Tondo (2):
  fetch: Add package_identity() to the fetchers
  fetch: Return the package identity of crate, gomod and npm URLs

 lib/bb/fetch/__init__.py | 38 ++++++++++++++++++++++++
 lib/bb/fetch/crate.py    |  7 +++++
 lib/bb/fetch/gomod.py    | 16 ++++++++++
 lib/bb/fetch/npm.py      |  7 +++++
 lib/bb/tests/fetch.py    | 64 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+)

-- 
2.56.1

