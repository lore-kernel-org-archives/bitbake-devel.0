Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF861C87FCB
	for <webhook@archiver.kernel.org>; Fri,  1 Aug 2025 14:40:05 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.89616.1754059192355231201
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Aug 2025 07:39:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PjRN7dg5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-454f428038eso15563115e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 Aug 2025 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754059190; x=1754663990; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPbk0iig+cz7yxvcDbIZpHHZ/++GiYOQ67LRujGtnEI=;
        b=PjRN7dg5vBkrnjKiO+B9sdy5vgIBv0qqF9o1MVSDCtVoq53jTEKUcJnCSUd6oi+H7t
         SjOZ0i4BXJtpZRhvgvXrnr2QW/JR+XicSCUOZlo5Qt7+z+KB5yOe+0WCn0/Yu2RxdesF
         qN/dbI6ehpy/PVNLWyz08y0EVdW1YEpy2Onds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754059190; x=1754663990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPbk0iig+cz7yxvcDbIZpHHZ/++GiYOQ67LRujGtnEI=;
        b=uJkJD1IIhGZck+Ua+QsjcB4ek4pxvftZBFDRQRN8VsbCTSTr8w25Fxk1I5tkiNdCTV
         cxcX7Nauh63gPJ7ebpKI6IVZMwcVUgQlLgSKF1vjrCCjJOfWcNrvBNXTFjHex77TyIri
         cHovprnCcd/3mBWsLlrsd20GgNkuf2dAflrs2keCcW5zlR67pkbynKlxeDHISbR0WzaU
         dOnOMwH/UTaf/UAreh9mztQo4++qIGs+GTeFSqfFVaQTpWYDKSIkhTwv1RIHvSNNrTL+
         TmmVj5259e/9MPV4VhONlP5xLgCTASwktm6gZVa+9lTxeJ5JBe3+aL/hxzqF5vTXnc26
         u16A==
X-Gm-Message-State: AOJu0Yy8yvTgTvCMItlIKwCo2wcpNG1/1dC6vw8exa9ByGav6vWPnRKm
	+I3VSdlVb2qJPs8xXl2BpI0q5+8htifw+bhkZAsCHw8Bl3BZ1kZPW0pglGAcn/QLg4lgh0Rd0dK
	yKIQS
X-Gm-Gg: ASbGncurqztnnk8oAMgwanztK9T2eX11khrttx0YV0F+VjyR4SbS4Uf+3ronjd6NfhL
	flVgdz+kHku+FHBxR7aDLSRrPRGtTpqWxhQ9AV04exGTSTcn59gxXDqJFVHbnla93A9MdLCQgSP
	fR7sznY939HpjSLUfijhtGzaLPXjDLpM4MfxEoz8LK7T9T3cW7GaBiQ4WanURws+hNHxzcIN8Jr
	HQBfSHakjA/nIMahWUp5zg7vagkQPmYUiOyG/XQXsM/NLt4vVQsY+TCD2Oeoupie9zkVzCli09Q
	aNc+uVArfhYRQGUl9mzviCI0JwyVxSYomyUMLLXklYDHy1/Ga/OJHUFMuyE9/s9/MLn4ZRrKxCW
	zrFfXfaCD0i89np1gA6mrgphQxCtHsZTS4EI3DiUVR5PncF3DP7M=
X-Google-Smtp-Source: AGHT+IHGdkPlQikzSwvcaB6/vtX14e7tfhrXOmMaRHML8HQg4sRhNkFDn9txbYvQJbpys4dk+zL9bA==
X-Received: by 2002:a05:600c:4fcb:b0:458:a6e8:621e with SMTP id 5b1f17b1804b1-458aa451b2amr23182525e9.20.1754059190221;
        Fri, 01 Aug 2025 07:39:50 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3aef:c1be:3992:4dc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b0a55c92sm7936555e9.4.2025.08.01.07.39.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:39:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Ignore KeyErrors duing shutdown
Date: Fri,  1 Aug 2025 15:39:48 +0100
Message-ID: <20250801143948.932436-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Aug 2025 14:40:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17834

When parsing failures occur, trap KeyError to avoid these kinds
of tracebacks (from a parsing error in meta-ti).

bb.parse.ParseError: ParseError at /srv/pokybuild/yocto-worker/check-layer-nightly/build/meta-ti/meta-ti-bsp/recipes-kernel/linux/linux-ti-mainline_git.bb:6: Could not inherit file classes/${KERNEL_BASE_CLASS}.bbclass

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/command.py", line 123, in runAsyncCommand
    self.cooker.updateCache()
  File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cooker.py", line 1639, in updateCache
    if not self.parser.parse_next():
  File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cooker.py", line 2314, in parse_next
    self.shutdown(clean=False, eventmsg=str(exc))
  File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cooker.py", line 2209, in shutdown
    read_results()
  File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cooker.py", line 2195, in read_results
    self.result_queue.get(timeout=0.25)
  File "/usr/lib/python3.10/multiprocessing/queues.py", line 122, in get
    return _ForkingPickler.loads(res)
  File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cache.py", line 338, in __setstate__
    setattr(self, key, self._restore(state[key], pid))
  File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cache.py", line 318, in _restore
    ret[dep] = map[mapnum]
KeyError: 156

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2eb64ef2372..9f88ae7a7d5 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2195,6 +2195,11 @@ class CookerParser(object):
                    self.result_queue.get(timeout=0.25)
                 except queue.Empty:
                     break
+                except KeyError:
+                    # The restore state from SiggenRecipeInfo in cache.py can
+                    # fail here if this is an unclean shutdown since the state may be been
+                    # reset. Ignore key errors for that reason, we don't care.
+                    pass
 
         def sync_caches():
             for c in self.bb_caches.values():

