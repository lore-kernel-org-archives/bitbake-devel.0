Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C2C5DF67
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 12:48:42 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18288.1786625321661372253
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 05:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZIfxToFf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so1920391f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786625320; x=1787230120; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uqompJTxlFaD8h+sxVr2B+BvQk2DgizptmZDTlPv1no=;
        b=ZIfxToFfzs5cVitu7vHaG1pc3OExqIi03MwCcmARvfpDfYNUYL/L05/Ptn4cwA02Jm
         Y7BrwxfvRE7vGh43sQX5eYGxI86YVTbZb9VJAKPfH7UfFJWzQE8tP7zduXZZeVFKMobu
         jYvOGs/lh5SHaj5+/xwbtragXkFAGm/mWc44s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625320; x=1787230120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uqompJTxlFaD8h+sxVr2B+BvQk2DgizptmZDTlPv1no=;
        b=B4CmnIkWZKCREp4OX1deKIY4bR7NFQ4UnSa+rdq7d2jeh2o1gP22QwoUF3SCqdtq44
         B/y0dgRnY1B3MLZIG/o+bMY6vKkEAFDCQ/g+qHXrnynKClSrWqIXNMIX7/Pm44snVVbF
         vMhSHdVp/+0kaboRo+VgVYshP5VAUmcSNyNFAVZux13nCcqIQNjFsvLi3NeyYb5Ki/xG
         bCWKle6Td+VnJpOR8sfZ+vdcfoW58AdGu9DPrXvV8Vq4Fyed83zk6b0WRq4nyCTXUDlY
         9BLFhbDGirIvMqVzrh3zgTCD6+TC3uYbEKvV0EcLXF7b/+carfPHD16lOD4Blk5scWYg
         YDuQ==
X-Gm-Message-State: AOJu0YzbgKl9ZWKFFO0ob7QD4igwbLL02YVsTvBiGK5DyqgSV4OwBTxk
	1P0StlSqipdYExdUVf+O2nNWvq41KwgmLc7zkpLnpOJAUw09EoOMwBHGf4V0SaR33t5n437abEv
	8ejfPF8w=
X-Gm-Gg: AR+sD10IttSCL0kZnZnFo5yAGWMLwoyfn1ZrLnwOvGrLUdRaf/Jf6139KAE5q5gNgsa
	V7tfisJzwTQNTLompd0i0Hu9VCjPgl4lqWAdFCsAqlVwQMl3BPKLXTVSnZI+MimUlE+jGDhEROz
	3Ao6zL2u51SW9wmFyktm+TVwu+qrINnLpGJZmchdtk4S9tBnaO8zTW55gIU6YfA2jzQAYxfmsog
	aXtlb8myX22jMOkUZYOXN5dAfphubFTFkLuS4npZGNA9/16UXHY6DXPJTNYLh4Csx9NhSIeaPCH
	sX7zu+T7CDz2MJ0YDIoMIIht9usU+wxNHGOC+m514U+e4hbMUu35hlDgCIw5xZAvWWPxQOLNDDU
	ttBAVtflNQlv6XDSCeKtJRpUnLZUjWZ4LRINFQ+Ki8x+y+IdesFr1Wf1HhgVl5id6N8nkd5daz/
	E9rRfzl+mHOK+nMuBqRNJ0ibcgoZR1WCpBA4V1XykZDZ3Hk+JkA5J20ckwhPWv/hcM+p7/GeIaN
	FNklU/M3W81cWEJNgLsPBGmHk+m
X-Received: by 2002:a05:6000:46c4:b0:481:5bce:4485 with SMTP id ffacd0b85a97d-4815bce4854mr3856365f8f.13.1786625319909;
        Thu, 13 Aug 2026 05:48:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e77b:339c:e0c2:6c8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6616sm6685768f8f.25.2026.08.13.05.48.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:48:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/6] utils: Allow lockfile/unlockfile to take empty names
Date: Thu, 13 Aug 2026 13:48:32 +0100
Message-ID: <20260813124834.1770307-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
References: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 12:48:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19926

I've been torn on whether to allow this for a long time. The context manager
does allow it and it does allow code simplification if it can just accept
no locks are present so on balance, it is probably slightly neater.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 8b8d381faa5..92b60b39d2c 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -529,6 +529,9 @@ def lockfile(name, shared=False, retry=True, block=False):
 
     Returns the locked file descriptor in case of success, ``None`` otherwise.
     """
+    if not name:
+        return None
+
     basename = os.path.basename(name)
     if len(basename) > 255:
         root, ext = os.path.splitext(basename)
@@ -594,6 +597,9 @@ def unlockfile(lf):
 
     No return value.
     """
+    if not lf:
+        return
+
     try:
         # If we had a shared lock, we need to promote to exclusive before
         # removing the lockfile. Attempt this, ignore failures.

