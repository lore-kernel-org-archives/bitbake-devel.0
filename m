Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A2CCD6E6B
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 13:35:04 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11721.1780580094125051543
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 06:34:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y+mcSMs5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac357c55so8822635e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780580092; x=1781184892; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yffhqDEzIKFflDNbr/nW0Kv6kK20OLhLHTJ0Cg0Gzts=;
        b=Y+mcSMs5he6Njkyv3MBfrnXMTC9fH9+dgw/hRWrPp5TgZbjkX9XmP35Kh/1gRLIRPh
         0vrxo4fdu0lv/RcSmqgnK83KsUoi6PP2yJ9FscEDtu3swNUlnBwJipNhaL9CY6KIJ5Wi
         iEk6XSX4JtzAwCt2VEUvxiP1F0RQA/yav6t2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580092; x=1781184892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yffhqDEzIKFflDNbr/nW0Kv6kK20OLhLHTJ0Cg0Gzts=;
        b=muifzun02j0OYs5J//Ys0FwAKPta411gdUULvRwofymqww3mUXMRg9XLB7tMsdRrd+
         YOSdc+jFbpc3AiKWAxDwp5XoaHSdJE9Cd+P8kEwrYR/z35kX/v1QyRb7NCZXKUspl9Gh
         IgrZlIRhL9aXULe0JlkUq+Ux1Ef+bRSM9ERC5tJCeyiCqXSq2EdQUZgcgkNm9ktgQJ6Y
         5Wn/kFlNR8sGq65U3ieG/VW7YgK8O9t9CmR9yMTqzttxYUvKsEnESOBWzsUbI4p2lR/V
         Kz/w+hWCGhltF4p5zDhl6u7oXQRGysagG6cImrkT59sbFcgMeOvk48NaBwHOWpvwhbO5
         KMOA==
X-Gm-Message-State: AOJu0Yy9L5wjhyg7kHOT3BRI3nLWDy+mOmPRuqBCPGBmdeIVGqoEb8+9
	4qPSbLHYPjtESSA9X5tQvFRR4VWVKRxg3cInr/MCgteHSHyHkXIJNP4Q/nxlFwe0tG0LXVxDLFG
	wb68V
X-Gm-Gg: Acq92OGQBoww80DIqlGRuL6Ht27hvK2yXquD8e8mP/6ax46OtUz2KuJ604RPhVkuIhk
	r6vM5LPAlFFuAwUqJ44P+tWIC3etAD1jkvmxZ+U3Ann5mZKCz0MFz8i7lafCxmuD8XIyJPE+20X
	aYeHdWCe0MXb5wJLQpA0ZD20OFF/HbrgW/zNtfJo2jBavt3SdfoNxWf9ObP9hCfuvhT6MOqKaF6
	6ha58j9jpUqGkAWqTutZT4Gbh9h/hNOFwPbEDm1Fnt9hc9hmbVlYdBzHE3OCyoTxsfJoqnbEI3u
	3Cpm9nAdxjhM5HYZA9HNSTPRGUYh4Spjoq3kgO88NWU/MQ2lKTCv/vo/sc2TSF0TsCUI4F8Wbzr
	faqodx0vF+wXqEFxkYObfgwIX3UKHBuYKpsFjkz4uL6IEqEhgNeRNpk2GiNVRpz0T+95pmsBZR7
	owj4xee6tJAb/XHqn9SKnMH7CpGLVujHOQE+LUFthQX050ZRPiMy54d9M4A325onI=
X-Received: by 2002:a05:600c:3508:b0:490:5cd8:d21c with SMTP id 5b1f17b1804b1-490b5eb3310mr127259955e9.14.1780580092366;
        Thu, 04 Jun 2026 06:34:52 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:eed3:d0ae:8f44:9e49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm71326935e9.12.2026.06.04.06.34.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:34:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/5] fetch: Improve tar pipeline unpack commands
Date: Thu,  4 Jun 2026 14:34:46 +0100
Message-ID: <20260604133446.2528212-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604133446.2528212-1-richard.purdie@linuxfoundation.org>
References: <20260604133446.2528212-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 13:35:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19609

When originally implemented, tar didn't support many of the compression options so
it was easier for the code to use pipelines. tar does support these now, so we
can switch to using them.

zstd isn't converted since the --zstd option isn't present in tar v1.30 present
on RHEL 8 derived distros.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 58359896602..088136bb627 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1584,17 +1584,17 @@ class FetchMethod(object):
             elif file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
                 cmd = tar_cmd + ['-z', '-f', file]
             elif file.endswith('.tbz') or file.endswith('.tbz2') or file.endswith('.tar.bz2'):
-                cmd = 'bzip2 -dc %s | %s -f -' % (file, shlex.join(tar_cmd))
+                cmd = tar_cmd + ['-j', '-f', file]
             elif file.endswith('.gz') or file.endswith('.Z') or file.endswith('.z'):
                 cmd = 'gzip -dc %s > %s' % (file, efile)
             elif file.endswith('.bz2'):
                 cmd = 'bzip2 -dc %s > %s' % (file, efile)
             elif file.endswith('.txz') or file.endswith('.tar.xz'):
-                cmd = 'xz -dc %s | %s -f -' % (file, shlex.join(tar_cmd))
+                cmd = tar_cmd + ['-J', '-f', file]
             elif file.endswith('.xz'):
                 cmd = 'xz -dc %s > %s' % (file, efile)
             elif file.endswith('.tar.lz'):
-                cmd = 'lzip -dc %s | %s -f -' % (file, shlex.join(tar_cmd))
+                cmd = tar_cmd + ['--lzip', '-f', file]
             elif file.endswith('.lz'):
                 cmd = 'lzip -dc %s > %s' % (file, efile)
             elif file.endswith('.tar.7z'):

