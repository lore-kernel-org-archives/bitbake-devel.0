Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web12.6799.1612524378211366344
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 03:26:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mXIXCz3j;
 spf=pass (domain: konsulko.com, ip: 209.85.221.54, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f54.google.com with SMTP id l12so7320970wry.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 03:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OImZS+M/ndtnQgUN8xpSyxmnBUjUSQH/Vfm9IfGbVHs=;
        b=mXIXCz3j02ypwJrPKQ7aZWq/kQjhAPGstriyvgWH54n63m27R7BHVcDZLlOnKCZoSs
         9NXRYoTTHH/Voil2HsunAwvHVdR016wciWBtyF8+rnnM6/ca8IY2f/7x1RLMYpdX+jr8
         LEeJBmEaEHt09m7mApvt+Uf49fxoLcV2TdBCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OImZS+M/ndtnQgUN8xpSyxmnBUjUSQH/Vfm9IfGbVHs=;
        b=bPz6emfxTNN8YEVvB3nu+ECPYrusVCk4lVtoyKsgcEiYxK0Bfn8Re0Sg0MiEB5dDb4
         0nbTGG8YDUiDxEDqRsUU2CLbYBp5szCznOklUjc5xmgrYOqXlGbVuKdvvHHKPdK0gDxk
         AqsKbmzSqnc1FC0gFsuHaFwKWEaVMPctm+CJDXKYncZtlgi/9gRxJRhRf7qLD1p0/oil
         yhsJK2fSRyb28F9hcOGS9vs25J7v4mW3hE/OPQa2e1ibrezy5i9wNNj/4tSQ1elca/aD
         iSWpNN86LS039rqEwDr+oYMreD+gDr3TyhKmkfk3K/WZKm4FkbBGUXvTxM6uh6aTP/F7
         XsMg==
X-Gm-Message-State: AOAM531cx2GSLfyVbowXciObGy2tS0+uUq6Itx5M4Qvh4RESNLyPswQe
	baDbxfDFpFe1ApHvv0rOpCb/CXLH90TbvabV
X-Google-Smtp-Source: ABdhPJyojJEfirC+B/rhjE7Y34mCOJhoyrAd4jGYDRoht8y0d3JxhQZlh2GwDwamVRpNcNp4CorZ/Q==
X-Received: by 2002:a5d:4292:: with SMTP id k18mr4564162wrq.218.1612524376430;
        Fri, 05 Feb 2021 03:26:16 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y18sm11881716wrt.19.2021.02.05.03.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:26:15 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 1/8] bitbake-hashclient: Remove obsolete call to client.connect
Date: Fri,  5 Feb 2021 11:26:04 +0000
Message-Id: <20210205112611.17167-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205112611.17167-1-pbarker@konsulko.com>
References: <20210205112611.17167-1-pbarker@konsulko.com>
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

