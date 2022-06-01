Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45613C3F2D4
	for <webhook@archiver.kernel.org>; Wed,  1 Jun 2022 18:22:45 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web12.1527.1654107762284672385
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jun 2022 11:22:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SngCs0Rm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id
 c5-20020a1c3505000000b0038e37907b5bso3547616wma.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jun 2022 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZfnGwcIoyQxVXjefpVBBTRy7VwHZqlVhsQdXh+G9TI=;
        b=SngCs0Rmh9KZ+xkzFIO+ql+/3OoLlmEwpqF+CO69dL6edPft9JGkzefVt3z8QI9iga
         Zrcqn24P3LLelL64NqFmtEFV+i8ZwPLNbVahKhrfrCQbuUfLgFnPYFxEJYXGNSMAahXs
         pIjngP8aNxUlUe4EH6cn7cIaft8yRH1slR1hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZfnGwcIoyQxVXjefpVBBTRy7VwHZqlVhsQdXh+G9TI=;
        b=gamRB09iPizO5uHYGNrHL/A5wZESXuREhllNwZQgXJlkn0JYW6VsEGN39tjbcnIxE8
         JJdjtuetj4Ox8yljnrjGP7mdQI83hV0hzm4DTJl6YMUZYjkS0lDNuPwM3/P/0FTQdKTr
         M4Yynv22SRsrO9pCBfwTyrN5THsGtBSkpmzQbheJ9rWb4jcUrP+YfaPbsCYl22rVILdq
         K7NHc9fxc2WBJjZX6QKNm4SK7WKA0DiqolNK34dFriZj8Z5d4fxxmfWdkOtHQK0kC5YN
         twwI15/HAUAvahd4yXdT1Vu4ol2a9bDgqVjdX7+Jvdn1lkC0EmwRVqbyCRHTfBF50vRV
         grqg==
X-Gm-Message-State: AOAM5301fIhyiMjFCL8VUp5cPsJmukmFDboagjKtlWn2WL/+wQA0vzhg
	D9w3/CipGV1ULTHn/MjONgN24D/GTBoHYpWP
X-Google-Smtp-Source: 
 ABdhPJyfgz24sBiSYo65gJhaZAwXUguTPhfLSGXyrG+/bDCyz6fq+qjCvqbUwRwpRSPv+c1z5S2XfA==
X-Received: by 2002:a05:600c:4f90:b0:397:89b1:539b with SMTP id
 n16-20020a05600c4f9000b0039789b1539bmr26120026wmq.149.1654107760168;
        Wed, 01 Jun 2022 11:22:40 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:eab:cafb:b8d4:fe67])
        by smtp.gmail.com with ESMTPSA id
 l14-20020a05600c2cce00b0039751bb8c62sm6665150wmc.24.2022.06.01.11.22.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:22:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] runqueue: Fix unihash cache mismatch issues
Date: Wed,  1 Jun 2022 19:22:37 +0100
Message-Id: <20220601182239.103588-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Jun 2022 18:22:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13725

Very occasionally we see errors in eSDK testing on the autobuilder where the task
hashes in the eSDK don't match what was just built. I was able to inspect one of
these build directories and noticed that the bb_unihashes.dat file in the eSDK
was zero sized. Whilst inspecting the code to understand the cause, I noticed that
updated hashes are not saved out in subsequent updates of the values in the rehash
process.

Add a missing sync call to ensure this happens.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f34f1568e2..1e47fe70ef 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2299,6 +2299,9 @@ class RunQueueExecute:
                     self.rqdata.runtaskentries[hashtid].unihash = unihash
                     bb.parse.siggen.set_unihash(hashtid, unihash)
                     toprocess.add(hashtid)
+                if torehash:
+                    # Need to save after set_unihash above
+                    bb.parse.siggen.save_unitaskhashes()
 
         # Work out all tasks which depend upon these
         total = set()
-- 
2.34.1


