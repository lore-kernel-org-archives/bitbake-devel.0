Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B6C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 20:44:34 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.1929.1716929067084593646
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 May 2024 13:44:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hKmFMROh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4202ca70289so11139955e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 13:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716929065; x=1717533865; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+zhKfDtI6DAXg6cnmGPeU07vIux6vj01VoOFctCbl4=;
        b=hKmFMROhmi0cstgmBvgiSWL7Bilf0HTNdDwXArqYAeKl9pbvcYurCOoXNhlrHZn0ql
         QKwwoUq7bsmyCIkoIP9392YwYn5Thav8PtlU6CMU8B5vGKYFRS7IXvfRwOn3gmjLf67A
         j2hVsXmdXyJX5CIchb5h3XoG2spqJMBz2h0Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929065; x=1717533865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+zhKfDtI6DAXg6cnmGPeU07vIux6vj01VoOFctCbl4=;
        b=CFXncBatXY95RSZkHQTxw6u0afPArdiwigxoZHTCObMDUCq9mb+LcRTbEyRFGggzJn
         bxrS+m6mP1TLPUp2KwWXkkpLhYKArGjZgI6ftwEWv1R/soNKyYUJWShZMPySqguWJIrP
         yndaagtY47vLXuzR5Cu4kr3d81jvzLH/V0DJ4YRvg6Uso8uU6qDVDRFWXjBCWnjPb6LO
         XrdkWe+QfOozpJlDzDd3xQj+nGo4qvpYHTBkZNF3rIcYmC8AsnV6CmmH0mFwZk5O8+0t
         LLOKWSHfapMhWywEM3Bu61OoxgczpljOTcJZv5TfLcIMYctLAv8i5rmXrWuUhba/0Pa9
         soxA==
X-Gm-Message-State: AOJu0YxD+mfKClxCb8AyDuWD/EgiD4hyRnrkf5PIRRZVLT2sp3fquNZV
	s64WH7XJUmOiO912ALtXzBZJSfOo5a/UhngGW5Pi+9Jk/nFyN2YGbaRb96KZUVazloSCYHiQSE2
	g
X-Google-Smtp-Source: AGHT+IE2CN1CpZe+yqSVKQTtDfTjhV95/XaPJ+tTfYzh6+th26hAdDt2IieJOISpxxWYiuJzXMenCw==
X-Received: by 2002:a5d:59aa:0:b0:358:380:f44c with SMTP id ffacd0b85a97d-3580380f521mr7546136f8f.5.1716929065260;
        Tue, 28 May 2024 13:44:25 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b316:c62f:d434:bcd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f9649esm12635228f8f.29.2024.05.28.13.44.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:44:24 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] runqueue: Improve rehash get_unihash parallelism
Date: Tue, 28 May 2024 21:44:20 +0100
Message-Id: <20240528204420.2845521-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528204420.2845521-1-richard.purdie@linuxfoundation.org>
References: <20240528204420.2845521-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 20:44:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16275

Improve the rehash code to query unihashes in parallel since this is more
efficient on slower links.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 999868dd72..47f48304ea 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2578,13 +2578,21 @@ class RunQueueExecute:
         while next:
             current = next.copy()
             next = set()
+            ready = {}
             for tid in current:
                 if self.rqdata.runtaskentries[p].depends and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
+                # get_taskhash for a given tid *must* be called before get_unihash* below
+                ready[tid] = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
+
+            unihashes = bb.parse.siggen.get_unihashes(ready.keys())
+
+            for tid in ready:
                 orighash = self.rqdata.runtaskentries[tid].hash
-                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
+                newhash = ready[tid]
                 origuni = self.rqdata.runtaskentries[tid].unihash
-                newuni = bb.parse.siggen.get_unihash(tid)
+                newuni = unihashes[tid]
+
                 # FIXME, need to check it can come from sstate at all for determinism?
                 remapped = False
                 if newuni == origuni:

