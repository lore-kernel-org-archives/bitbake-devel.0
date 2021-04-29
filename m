Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.7475.1619705488066410243
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Apr 2021 07:11:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QVv4SGZa;
 spf=pass (domain: konsulko.com, ip: 209.85.221.54, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f54.google.com with SMTP id e5so38454568wrg.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Apr 2021 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHK4IXl65qYVk1cxZsuK5HW+6utc/vQlcmot+xoFJZY=;
        b=QVv4SGZagW9JEKqKQL2A2SS/rTGSILQnblUAO10JVZM2eGEhtk4WXY4tlL41ylPjpS
         WBZ21ynRjKyhGiT8OV+kEQdKywnKhqzcN5oK76amblph1RGrIsZV4aHVkHoout8lJthN
         2mn4k6mS5vTA7SgOrKiFuj1nmJqA19OM/tsnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHK4IXl65qYVk1cxZsuK5HW+6utc/vQlcmot+xoFJZY=;
        b=rvUkgcZxIcFi8mEwurvnQYt3pACRyqbmMMYxCKoRcqHSWn/300lwySkGadfosflteo
         RtpSbOODBh/irZ4ghFU9G0Ntird0UkCbm5E+oayrrSbXTF4vaLqLR6XcAcC8GSD0G0zh
         W540eMz7gSpW8Gt4S0t8RyAfMa6OSttxTURUfRK4DpTLJ9Acsf3euPAXQQkqhgIpqi18
         FrdN3fQszNoG7X/pou8vuQ7bfOjwF9aWnezA7NzK43vzenl/PzKPrIIO34ObtzRPhuJ8
         6/sQFTsDp1BtmGPx/XmaNQayFsEEuLCduVqqFQ/eELHUyRqoGUUcE91mkui69VAYcrcy
         YzaA==
X-Gm-Message-State: AOAM530z+HOGBCKo/xjz1a3Q0HU2v4LhL0FJD0iQ+6WhigZosquMr0aV
	TdwMqkCpEitLWov/r8j+zbm+utGKsTbWoA==
X-Google-Smtp-Source: ABdhPJw4HpgpCQSQEbKIVwxf9tILRvoow/msJRpXONqRVIuJ6tHR4pI0l7tsGuKr/0N6AU9Z5V5UPA==
X-Received: by 2002:adf:f74d:: with SMTP id z13mr3299008wrp.147.1619705486212;
        Thu, 29 Apr 2021 07:11:26 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y16sm5282636wrp.78.2021.04.29.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 07:11:25 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 0/4] Modernise prserv startup & request handling
Date: Thu, 29 Apr 2021 15:11:09 +0100
Message-Id: <20210429141113.27974-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches continue the preparation of the prserv code for the update to a
json-based asyncrpc system.

When the prservice process is auto-started by bitbake we can make use of the
Python multiprocessing module to simplify startup and shutdown. When running
as a daemon via `bitbake-prserv` we still need to do the double-fork dance
but this is extracted from the PRServer class into a new `run_as_daemon`
function to simplify further changes. Since prservice requests are already
handled in a dedicated process we don't need to also have a separate handling
thread.

These changes are basically equivalent to those submitted in the previous RFC
series but with an additional patch to add a timeout when automatically
shutting down the prservice process. Hopefully this will prevent bitbake from
hanging during testing.

I've ran these changes through both `bitbake-selftest` and `oe-selftest -a`
and all looks good on my end. A couple of failures were seen in oe-selftest
but these are related to my host system configuration (socat not installed,
firewall blocking ports, etc) so I'm fairly confident they aren't caused by
this patch series.

Paul Barker (4):
  prserv: Use multiprocessing to auto start prserver
  prserv: Extract daemonization from PRServer class
  prserv: Handle requests in main thread
  prserv: Add 15s timeout to auto shutdown

 lib/prserv/serv.py | 338 +++++++++++++++------------------------------
 1 file changed, 113 insertions(+), 225 deletions(-)

-- 
2.26.2

