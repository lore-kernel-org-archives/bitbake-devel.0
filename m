Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED62C433F5
	for <webhook@archiver.kernel.org>; Fri, 15 Oct 2021 11:57:53 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web09.8316.1634299072180316571
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Oct 2021 04:57:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WabGPxGk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id
 b189-20020a1c1bc6000000b0030da052dd4fso2198829wmb.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Oct 2021 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPUqqCexqcyDu/BdveINaIkOu3PPiXN0nXNADgCeLs0=;
        b=WabGPxGk66sZXJT8fogOg94Td+VpkEdJu05wcAqWrhiJFlsP/rYKWBNUj/xQegNafw
         2+eRc2mr+F1W6NztfVqczuhRN0p8kD/7vXDkfaLk/Q7Wj02F7cnecIh9/3XWNOWJfLmT
         DFWtu4z5SzKSsNRa3rRGaXkzrcL1syqIyCGR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPUqqCexqcyDu/BdveINaIkOu3PPiXN0nXNADgCeLs0=;
        b=51xVxLgvOfnPVXM7u94Iout08FrVTRbH7NMvwNcb5/Z6xjUzHLVoVHwdtOF0yJB6V9
         8ZI9i7f6L1U/RKzKfijq6czIV/COz3U/SDbfmjF1oblWMKT+ktywkwoXWc3eLgdDlvWZ
         7yolZFg2E2BrXhJ/KT7MB/mi//QNiu9QPa1KtXI/uZ+aOqrklQ16ZEILUQLvZ8PcNey/
         XfsRMIj6H0AFeu15RbmwCu9fIXpB+hIHrsRN51CwncmiguEspYJqIIt38WNyZgcuHWo7
         Q623yFfoyJl1ztVtDDxa9K/lk5xHERUxRG/kxb1uMQSTLE6olcHBuniafM5hQV+lno7g
         Ogbg==
X-Gm-Message-State: AOAM530FC8IaGN0tMV533pm7BB6L/YQTVJQSNLY0ZHUj264Ah1+x50H7
	N82YETimj40edtumVPQ0J9itNjr+5zNs9A==
X-Google-Smtp-Source: 
 ABdhPJzVdth6U8r3Ae3tOV9/stEcf1pi8d0T+GdpLQTxda1KKbr6dQF9UpXUBJQZaS9ZoBHunUy27A==
X-Received: by 2002:a1c:a5d6:: with SMTP id
 o205mr25297738wme.90.1634299070585;
        Fri, 15 Oct 2021 04:57:50 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3c2a:82f4:3a7b:54b1])
        by smtp.gmail.com with ESMTPSA id
 n11sm4440270wrw.43.2021.10.15.04.57.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 04:57:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-worker: Add debug when unpickle fails
Date: Fri, 15 Oct 2021 12:57:49 +0100
Message-Id: <20211015115749.2951684-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Oct 2021 11:57:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12783

We occasionally see bitbake-worker failing and from the logs, an unpickle error
occurs. Add more debug so we can further debug this next time it fails.

[YOCTO #14595]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index c8eb65567f..bf96207edc 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -418,7 +418,11 @@ class BitbakeWorker(object):
         if self.queue.startswith(b"<" + item + b">"):
             index = self.queue.find(b"</" + item + b">")
             while index != -1:
-                func(self.queue[(len(item) + 2):index])
+                try:
+                    func(self.queue[(len(item) + 2):index])
+                except pickle.UnpicklingError:
+                    workerlog_write("Unable to unpickle data: %s\n" % ":".join("{:02x}".format(c) for c in self.queue))
+                    raise
                 self.queue = self.queue[(index + len(item) + 3):]
                 index = self.queue.find(b"</" + item + b">")
 
-- 
2.32.0


