Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.37052.1623078219615421790
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Jun 2021 08:03:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=evx0sBjS;
 spf=pass (domain: konsulko.com, ip: 209.85.221.47, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f47.google.com with SMTP id r9so1300261wrz.10
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Jun 2021 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ds9v/e1exBc3UoKz6VapmgKaMC5+YRbXd+m9M1a2K5E=;
        b=evx0sBjSMKfXvFhqGFKLZrgZqkx6EgNF47Upjq0LsWevOlBKl/ObmRW/Y1PqI1a2tc
         M1xDkOrT20ki/Jro/w4s7PD32Y0BgYeRI1b07Nxs2glvNfFKV2JU0qjLm6snMTZwlQVA
         m7pzoDNB1O/P8JFW8j5r0V5i9T2jZMXhxVcQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ds9v/e1exBc3UoKz6VapmgKaMC5+YRbXd+m9M1a2K5E=;
        b=EyjBQjxFVS9im4N1fLM9zp5CIJK8tTmxOrP/W3p66YScN0Rc18PBmaPS1nJgrA2lMd
         XGvT4AExZ6mcmj/U1PnBPxBt7/UIlKMedw3+fd0x8YnnXY3SMyPgaDDaw5oCJR6aBnEp
         glpLtmdsQxjRDUxTlDZ0mUK1EEc7VYHnUAr1S8OsP/ydAsEg+f+MLNXYd7vF3s7BhL42
         uiF0Sp5H01+CsHf/VQ0Wg73+k0z8N+9i5Di80St//nCCzeGef+1YUrftIOWAlcWF209b
         +x/wqLkIFB6fTES1XmwUR3CPTuumQ3616bQ7vEpiTsZ4egZBlNtHJRjplJAKiZzsuW39
         k4WQ==
X-Gm-Message-State: AOAM5327mP9j/hDDjAB6KLedWM0e6cLHL4ahCNGyH1gE1Ktil/i5euIM
	Jkb3nP5k5P3eOENhDXe0+Bx9wuGPhVgeUg==
X-Google-Smtp-Source: ABdhPJzRGWk4e9nLTue5zUOyMHKRpkMo0W0eSXJ7qYRvxFWHK3OeyhHj1NeUZYwyEF+7FK1Wx4/GNg==
X-Received: by 2002:adf:a441:: with SMTP id e1mr17522606wra.227.1623078217715;
        Mon, 07 Jun 2021 08:03:37 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id l2sm15995488wrp.21.2021.06.07.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:03:37 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 0/4] Re-implement prserv on top of asyncrpc
Date: Mon,  7 Jun 2021 16:03:31 +0100
Message-Id: <20210607150335.32326-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes replace the old XML-based RPC system in prserv with the
new asyncrpc implementation originally used by hashserv.

Changes from v1:
  * Drop obsolete getPR function in PRServer, this was replaced by
    handle_get_pr()

  * Add timeouts to catch bitbake hangs seen on the autobuilder. This should
    turn these hangs into errors which can be more reasonably investigated.

  * Add a minor error message fix I spotted.

Paul Barker (4):
  asyncrpc: Fix bad message error in client
  asyncrpc: Set timeout when waiting for reply from server
  prserv: Add 15s timeout to auto shutdown
  prserv: Replace XML RPC with modern asyncrpc implementation

 lib/bb/asyncrpc/client.py |  11 +-
 lib/prserv/serv.py        | 267 ++++++++++++++++++++------------------
 2 files changed, 147 insertions(+), 131 deletions(-)

-- 
2.26.2

