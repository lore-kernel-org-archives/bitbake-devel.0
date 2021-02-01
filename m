Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.32768.1612180416800477269
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:53:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=G2qXGmWK;
 spf=pass (domain: konsulko.com, ip: 209.85.128.54, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f54.google.com with SMTP id o10so11339853wmc.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 03:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OImZS+M/ndtnQgUN8xpSyxmnBUjUSQH/Vfm9IfGbVHs=;
        b=G2qXGmWK8KI0Is40Oj4Hv3sRIUAORIOXDPr2U3lIcsIznktQ15UCeE8moHR1EEqBPp
         lwR0FUisSNRs77FpODsn5AaCG4g+QBBW9VS7I5Xj7Ki2vBTx3kXpwzL4XGPVJOQS67+n
         QC1bv2VH93jFJqwanqDoFohf9s+nFI1f59dPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OImZS+M/ndtnQgUN8xpSyxmnBUjUSQH/Vfm9IfGbVHs=;
        b=pCGQtsB1I8fV09txzz+QQCxSKqHwREdnadSVBKC4fSz6tekuVgrI/JLqUUrwUvlksy
         ohbDueyC+TL71hRCGst/Py1+NqfGtRXSeyJF8ivYrVlHT5dBVjEcKAolGc0R/2uNxxdF
         Pyh37D+cNmgsLoBKW85WSubAWci96b2Xm1KcVhPyyBuZyT9kQxsDDOLibeapTODflIH6
         jKXdgT6MgmBUd+uc0wQyUTZ/mbZKNz3KLfrIFlt2/NEeDZVsKWDW200uu9MEoYqHpRVI
         felpJ/Jc0um/DL9YPFnqzABqg2WYghLwkn5FDjfWvj7qlkhYlDxavjg6CgB0s2mGRnfM
         s13g==
X-Gm-Message-State: AOAM530X9KAlKPu2jBMgxq/nOZYgsWI39mb8eDKajvtwOkFV+3VxFt/w
	QtPXoziodhGg4FTVVvhlTsqiXx9/4xQ33khH
X-Google-Smtp-Source: ABdhPJzUqU5ExY9mltiV/ABTLnPPJslvAdlcIbN/tFqkrzDji4HhylwuhZYkY+0sf1KlA3hGWDIwkw==
X-Received: by 2002:a05:600c:4114:: with SMTP id j20mr1426455wmi.15.1612180415236;
        Mon, 01 Feb 2021 03:53:35 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id u6sm28120514wro.75.2021.02.01.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:53:34 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 1/8] bitbake-hashclient: Remove obsolete call to client.connect
Date: Mon,  1 Feb 2021 11:53:24 +0000
Message-Id: <20210201115331.13510-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201115331.13510-1-pbarker@konsulko.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connect function was previously removed from the hashserv Client
class but the bitbake-hashclient app was not updated. The client is
connected during hashserv.create_client() anyway so not separate connect
call is needed.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 bin/bitbake-hashclient | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index 29ab65f17..a89290217 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -151,9 +151,6 @@ def main():
     func = getattr(args, 'func', None)
     if func:
         client = hashserv.create_client(args.address)
-        # Try to establish a connection to the server now to detect failures
-        # early
-        client.connect()
 
         return func(args, client)
 
-- 
2.26.2

