Return-Path: <sider123456789101112131415@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D6C3ABAC
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 13:18:05 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.75526.1746537479703665553
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 May 2025 06:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eeJGstnc;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: sider123456789101112131415@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54addb5a139so6432217e87.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 May 2025 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746537477; x=1747142277; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ltrMDSc28mDFrrmffJa7AQNqzGnjfu+GHjwQbrXLzdQ=;
        b=eeJGstnclNu+Lb9yb62nRvOovL/ADvV+seFWfbgtbRPme04Q+zY7sg4lymzUp5GHZx
         XD32QFmb5JCkeyNxorhx7KP0+3guFkk4L4V/IQaMcxB6vGu/29aIE2f9OAOFltWI+Jj8
         c1PGfB+n6y+nMhdX/PgwP47aKbClo8Eki9pnfhxgEwDtDznv/L/tcdzzpMyHeOxkZBQl
         CmNZjGhByM4jFdchP8wqXJvdr7IIric58/yDaOGf+ZlFcctwQmS0To1zw+4EE9n4SSPG
         Ryt37OUz+s3F6y8lsxeSaB6RYgqu9FgJzUJYVVVai6BfwugKNjU2vWYugT2RXbdgGU9E
         eZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537477; x=1747142277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltrMDSc28mDFrrmffJa7AQNqzGnjfu+GHjwQbrXLzdQ=;
        b=Ov0TPvW5z/+7i6n556a6mIn/12g7sYW2a+tAoacqMG7ANRfCMRLLnscfHRw90ffHSh
         UkHsbvkB73vtC5hX+kYvI+TA1MmCK7rGaLI4uIuErePF85OuaayHfSLeFChPFMNC4Ma0
         nKUFWAtXs3Nr2uSZe3uXlCSbV+bB9DcRQReHrvK++KSIKLE9O5+rvh8vakONS+GS+HP3
         iTqvHcIPITA3gudFSsFEXuBzay+XZnzMWcOYWuBrcXQNGZ5/SKb0QIhWZk24UxQowIgL
         u/5Fzh/HukhurIe0yzAcaR/WNFq61QLUgWDCSuvVIFCwD3Rb3gt+HgnFYsFIAtgcYzh0
         ZM6Q==
X-Gm-Message-State: AOJu0YwlCv0KfE1hii7xduzOYXt81DpF5MjcqRZsD8TlcqbY5/wRERft
	7jea71g/Zx1sGwttfQTWSxjvOeJwOQ+RR9ZlgF8g0KI7mL1NCFs5ZUZ6r+OBJAtJgiCZ
X-Gm-Gg: ASbGncuYMo/d79C5omSvU1+fN7sCh62mwf6VG6IfAH9tMuzZdIcS78Zzp65Q89YoKIC
	FejhGYBWKvV3w+H7GBktE4xi38UPInmGSIuTpkp3z1ZBC7JDiMqqgEJ4Pz3/+f+uufnYuBss5O8
	2G1eZRXU3K5S51IvcCqpI7qzjXFtXhAKBPloB6XomEvw1p4s7wsssG1LSHK8SLYfOzcLcnPiWjM
	afm1e2rMr/capnMemKESVlhvQf2QWlFdshC03ka8J4XMIGBCaWfdEWxhAQrhuqY+wi+eu6K96Ki
	TM0fRltkmYg8qjJeis2Lr4vzo7r8mwevQj1pmZm0ZLXzGF1Mdxw7iPqxthEEK6VV3cfG39hXDqU
	=
X-Google-Smtp-Source: AGHT+IG9vg3LbM2K2HLbP5L8vSMUbGO1J9Bcei4CIb3ExvXjCAbIf2jMpFDsRHzv9VuUdkCJ2LjsmQ==
X-Received: by 2002:a05:6512:12c3:b0:54e:859b:b9d3 with SMTP id 2adb3069b0e04-54f9efb75fbmr3189171e87.6.1746537477217;
        Tue, 06 May 2025 06:17:57 -0700 (PDT)
Received: from localhost.localdomain ([176.15.165.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94b15d2sm2068917e87.50.2025.05.06.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:17:55 -0700 (PDT)
From: KonstantinKondratenko <sider123456789101112131415@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: gavrilov.andrew1999@yandex.ru,
	tinyakovx@gmail.com,
	denisova.olga.k@yandex.ru,
	sider123456789101112131415@gmail.com
Subject: [PATCH] Speeding up Checking sstate mirror object availability : Add async filtering SSTATE_MIRRORS
Date: Tue,  6 May 2025 16:17:51 +0300
Message-Id: <20250506131751.93175-1-sider123456789101112131415@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 May 2025 13:18:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17595

As the number of addresses specified in the SSTATE_MIRRORS variable increases, the duration of the "Checking sstate mirror object availability" process also increases.
This is logical, as the number of addresses to probe grows. However, it was observed that the "Checking sstate mirror object availability" process time increases even when SSTATE_MIRRORS contains one valid address and multiple unreachable addresses.

A patch has been implemented that, during the parsing of the local.conf configuration file, immediately after reading the SSTATE_MIRRORS variable, attempts to asynchronously establish TCP connections for each address listed in SSTATE_MIRRORS. If a connection is successfully established, the address remains in SSTATE_MIRRORS; if the connection attempt fails, the address is removed from the variable. This ensures that any addresses unreachable at the TCP level are excluded from subsequent processing.
These modifications are activated only if the FILTER_SSTATE_MIRRORS variable is set to 1 in local.conf.

Signed-off-by: KonstantinKondratenko <sider123456789101112131415@gmail.com>
---
 lib/bb/cookerdata.py | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 1f447d30c2..8b642bdd90 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -305,6 +305,73 @@ class CookerDataBuilder(object):
 
         bb.codeparser.update_module_dependencies(self.data)
 
+        if self.data.getVar('FILTER_SSTATE_MIRRORS') == '1':
+            try:
+                import asyncio
+                from urllib.parse import urlparse
+
+                mirrors = self.data.getVar('SSTATE_MIRRORS') or None
+                if mirrors:
+                    parts = mirrors.split()
+                    mirrors_list = [' '.join(parts[i:i+2]) for i in range(0, len(parts), 2)]
+
+                def get_default_port(scheme):
+                    if scheme == 'http':
+                        return 80
+                    elif scheme == 'https':
+                        return 443
+                    elif scheme == 'ftp':
+                        return 21
+                    elif scheme == 'ftps':
+                        return 990
+                    else:
+                        return 8888  # Default value for unknown schemes
+
+                async def is_port_open(address, port, timeout=5):
+                    try:
+                        reader, writer = await asyncio.wait_for(asyncio.open_connection(address, port), timeout)
+                        writer.close()
+                        await writer.wait_closed()
+                        return True
+                    except (asyncio.TimeoutError, OSError):
+                        return False
+
+                def extract_address_and_port(url):
+                    parsed_url = urlparse(url)
+                    address = parsed_url.hostname
+                    port = parsed_url.port if parsed_url.port else get_default_port(parsed_url.scheme)
+                    return address, port
+
+
+                async def async_mirrors_filter(mirrors_list, data):
+                    tasks = []
+
+                    for item in mirrors_list:
+                        url = item.split()[1]
+                        address, port = extract_address_and_port(url)
+                        if address and port:
+                            tasks.append(is_port_open(address, port))
+
+                    results = await asyncio.gather(*tasks)
+
+                    if False in results:
+                        output_string = " ".join(
+                            mirror
+                            for mirror, result in zip(mirrors_list, results)
+                            if result
+                            )
+                        if not output_string:
+                            logger.warning("All SSTATE_MIRRORS are not available")
+                        else:
+                            logger.warning(f'Several SSTATE_MIRRORS are not available, using: {str(output_string)}!')
+                        data.setVar('SSTATE_MIRRORS', output_string)
+
+                if mirrors:
+                    asyncio.run(async_mirrors_filter(mirrors_list, self.data))
+
+            except Exception as e:
+                logger.error(f"Error checking SSTATE_MIRRORS availability: {e}")
+
         # Handle obsolete variable names
         d = self.data
         renamedvars = d.getVarFlags('BB_RENAMED_VARIABLES') or {}

