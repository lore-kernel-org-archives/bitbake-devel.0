Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9000.1794994120096335261
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2026 01:28:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=SkN0N95I;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: stondo@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so7587345e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 01:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794994118; x=1795598918; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5cNUqk8Jzkf9NEZi3n/clV13n2d3tjknj5sy1s/sIN8=;
        b=SkN0N95I8cnDb0m29fnSm/LBuNX+/6S7Y9i4QyV7IXgE3z35RxGDd0gfNoLry21XTq
         +CL8Rh49z77geiMmGdPgA0SuF5ghgHaKuemvgX0lt9lCPddAITqPqw6jCumClyZcjXyR
         CgzBJ+k0GWlQBNqexBb5z8o58k9S5q4f7skCxaZWldGlJ2jLedjv6fBXijFcMzHmYjzX
         wDdeUnereY1UMLVEPQmQAjmOCGT7UWO5E5wSwwHSLQLofQxJAtZqukFm3G9DWqz5MP/d
         HuuY8b8EUBa6giuqQVCXN1W3EBf0gn+nm7KKo3ddAAPXncoe26XSYjwXr0ma1ejlwjRX
         uulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994118; x=1795598918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cNUqk8Jzkf9NEZi3n/clV13n2d3tjknj5sy1s/sIN8=;
        b=qFYMDJPV9b7IzgNR2qH8qhwNB2M3X9wr/BmWMZDACQnvGHi8ElMgESBnWzIsJwnoGS
         NvnSxlM2crP0Xf1TN3oeXmEH0SDtcIeOFdXbaTPLe17GtiYfXwfhouC/BKCJiilvbINC
         j9GGKQAm26e15Kuu7YtsjDacuDu1CqaDCVP0QrqWjAuPc8s4gBp0oyld8p4jvyl30vqN
         M5F+vUCY1hEJD4LUiHG3jPDi0kV2zIztaBgM0Yn8OBZOyfB39rhdw641Jrth1UsI0yOi
         SunhhOgF+JTxw2qqWOkKw5ukygCxIjSScz/nD/jd4cxwHucuM8+tl+iugTYDWHmsNfxe
         ygBw==
X-Gm-Message-State: APuU4Z8vT/UA+F5y4xf7ZFokaEsc/5fi5guiiabbSgaQZ3M/hBHDAU0s
	OZOYw9j3WhqzM+ZJGdj/d8GB+QYay6JT0khtMb+Vpi4KnRDNY/WKlQ3bbQ6HXg==
X-Gm-Gg: AYBFou2rACgFzzg3/RqlRxHEJ3X4A33NZ1qZ1xICtea7pB0xG/EB0/TPCRezrDeJ/HU
	SIJGNxxCU6+gkvKNzMT3aIcHZEz063QYNhRw/vM/zTAA0+3oRoLPaT/BUwXdhjQ1f1RP68P1XGc
	ACxt5+pTdewfoLlUOwthiTYsYxXJwMOvQq3fZ7WFMpT4SBltw4BVO8L2PW58iwjuscewC8olWWj
	lXXK9vaCG0yEobFRU5Vk6og8xPE0aQO0H3fr/GXnP6QsZnufMvW+mE0GDo+qRAJVAIkA4bzVwUu
	2p8j/vbpmEX2B0wMM0mLVspPw9uoCJDZxyAsXAMTPDcPDEZNsxuIbUF004GkIEGI9LphaurVR2x
	84+CzMbnPNQJHdCpf45EXz4uygGCU1D+r34aB0ScjAucytVP4ks0bw6capEMPfSL3UHqt4EPk4m
	AhDv9nXMe+pI3J3VxYN+1rN30cwQpK5IF5fEom3MEjqxeJOYooavXHGXvl/XKYiqwis9LeCiK1Z
	EsAnZu4S4rJzXvfZTuRcaDQg2ZtF78RpXPIik78qz3aYhfUih2SBGJhCSBi4sMrXHzM0AIw4GDJ
	zuog5Tcw614=
X-Received: by 2002:a05:600c:1d83:b0:4bb:679a:86ee with SMTP id 5b1f17b1804b1-4bb7da44c6amr35249095e9.29.1794994118171;
        Wed, 18 Nov 2026 01:28:38 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7defa59csm27007085e9.3.2026.11.18.01.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:28:33 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Stefano Tondo <stondo@gmail.com>
Subject: [PATCH 0/2] fetch: package identity of crate, gomod and npm URLs
Date: Wed, 18 Nov 2026 10:28:29 +0100
Message-ID: <20261118092831.201831-1-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 09:28:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20455
Content-Type: text/plain; charset="utf-8"

Hi,

This series adds the fetcher API from the RFC "spdx30: name, version
and purl for dependency downloads" [1]. Richard asked for a fetcher
API that returns structured data with the purl, so that OE-Core does
not read fetcher internals.

Patch 1 adds FetchMethod.package_identity(). It returns the name, the
version and the purl of the downloaded package, or None. It uses only
the URL and the datastore, so it works before the fetch and without
network access.

Patch 2 implements it for the crate, gomod, gomodgit and npm fetchers,
with unit tests.

The RFC also covered the downloads that gitsm and npmsw add by
themselves. That part is not in this series. Richard and Alexander
prefer to list those downloads in SRC_URI. I will send that change
for npm in a separate series.

An OE-Core series that uses the API follows on the OE-Core list.

[1] https://lore.kernel.org/openembedded-core/20261105122145.543282-1-stondo@gmail.com/

Stefano Tondo (2):
  fetch: Add package_identity() to the fetchers
  fetch: Return the package identity of crate, gomod and npm URLs

 lib/bb/fetch/__init__.py | 27 +++++++++++++++++
 lib/bb/fetch/crate.py    |  7 +++++
 lib/bb/fetch/gomod.py    | 16 ++++++++++
 lib/bb/fetch/npm.py      |  7 +++++
 lib/bb/tests/fetch.py    | 63 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+)

-- 
2.56.1

