Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF551C54F3B
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.7669.1650460941067716561
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XUZurLKd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id u3so2266026wrg.3
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rLpFsHpkQh9sdD3II14kz2ZGwVlMdiZBGb75Hr9cUGs=;
        b=XUZurLKd8IhI7KY+/eOk6XvW92rhvdHqBbBEgsMBeWbUjEmQUqeUErcc0r29JQMkui
         +aUtzBI57UkFxZ6xT9Qn1xql0jJux1mlgyJds1cJ2izpR3LXHtQszniMNBxDtjyb78sv
         BhsizCihPAgusa3u+6TQvP16QvGbeqXU5QkXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLpFsHpkQh9sdD3II14kz2ZGwVlMdiZBGb75Hr9cUGs=;
        b=DetPemxbbYFSW9yFMjtce06WCJa+UG2yXiPvXgrrAJ5FiCkgY1q2v0ys1iE6q6bN7O
         /bffH8S3jVeJYQlmkbDkYq6laOP1UyV6fwby6FP8z949Q+O14SPKVOMriUAtbAvUOSTe
         y2ZNGQd7oeyENTIfZMWjtzlYpiywTc0Rwgvtv74LAWPFC0yQ5Bq/1a9ORSuAQRwoPr6+
         dwHYcfEQBt/PWMa682ig79GEW8VW2TufDVkcrk/s81sJJQhyzGXuVPrSVl2waubzIO9v
         taJutUVXPFz5jplydmy/Wn/YDELSROe2+cDHHr3gGWz9Gclr6RN/F2XPNb+qv0u89okk
         93gA==
X-Gm-Message-State: AOAM533GwijaRDCNu4LB1zPktZeujVSsDebSdxTs9pjw3CuFI2/gkLj1
	cjEVkeIkB2m5Nk955gWdcRPvQ3f/QuIBtA==
X-Google-Smtp-Source: 
 ABdhPJwKW8gRppoVZi2K3fQMJEvx9wGLJ48lSG8vWbvQ4i7EMDbEWYyTURtJsQMi+mODpz7w/3U6kQ==
X-Received: by 2002:a05:6000:188b:b0:20a:a7f4:2f8 with SMTP id
 a11-20020a056000188b00b0020aa7f402f8mr5700891wri.424.1650460939011;
        Wed, 20 Apr 2022 06:22:19 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:18 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 08/11] ui/knotty: Drop pointless pass statement
Date: Wed, 20 Apr 2022 14:22:02 +0100
Message-Id: <20220420132205.2530591-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13650

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 3f410fd525..61cf0a37f4 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -877,7 +877,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     state_force_shutdown()
 
             main.shutdown = main.shutdown + 1
-            pass
         except Exception as e:
             import traceback
             sys.stderr.write(traceback.format_exc())
-- 
2.32.0


