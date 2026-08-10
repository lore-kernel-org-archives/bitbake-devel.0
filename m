Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A15C5AC82
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 11:12:45 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27295.1786360354967307903
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Aug 2026 04:12:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=csnnzi1r;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso12781695e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Aug 2026 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786360353; x=1786965153; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oMU1gugGvOYBSRPFi70naI8sRXeTQCvb04NMTn6Ds20=;
        b=csnnzi1rtG+GhPIapz/NQolSfSBtLp1x6En+3Raqmg7BEArg0i3bX47jJnbDZX6U48
         KUZCHTwnqmQqoWGPktzF1H0s05wLCOQCUyQEIL8KUZyIWqN9+fBXmhLOSR1PcwlyOfuT
         +Zyf0v8f5fHHBmpNg79fXoYyu6J4zpP4jxd+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786360353; x=1786965153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oMU1gugGvOYBSRPFi70naI8sRXeTQCvb04NMTn6Ds20=;
        b=ZtCprNIzPbXDdglAhXAsfMALtGt1Rcc5B7Jhr8FJbaavkjlDWOo1EVh3K6Nv0uIl63
         NUe83JyrGfZy4X5odHrGwSdxcSDQt85TobfgN1oPc+N3LjTBm/cxlWxmC5eXblhnkHyl
         g4RhOQ42/VbtWXTKlhVuQp6Q9GZnQsAxQF0aMur05a+6yiJW9TrN09koB5+ky2iZpwOq
         n6HppW7n9527lhPbiInqpUa+AtF4MQXiM2G7m7aFOlzwo8xpwPKtI5nZyBEkrYCUefcS
         q71RQFILjq2FM/M5RW0vkTe6bYOPDzL0Kxx6XGNatxjeEwlBvvRGme3ShqduYFNZq15K
         aBgw==
X-Gm-Message-State: AOJu0Yzh3ckDUMrPUTIv6lvYVIt/eZJCOTA1qX1N3WVUPKkyM6nJSCge
	qDTOovqAkzf2cyGCzxuemJe8HjGE2ptBEhboEJ4vZDulQPFsXLJ+fZaHNT4fwAyB6nUcVYMYB33
	tZbXFz3w=
X-Gm-Gg: AR+sD1097wlAxb+aSErNl3WsxVIr1r5/9+P9Mapp0tzSX45Tm++/L80jw3NozoHwBia
	HBYJXs0akQF6RKPB/d8c5g03/h6uVNprrIHb0WwINPM9Xokwhuqgk6n3gKpas4Dw3mGslhqVjwN
	033mYyd2lDacNgscS1OgHXO6LH8uaVwzxHEHzdp8Or9+PB0vWrzsR7y09VwRAf+NYj1QZPnc7VB
	BZJUCq5xzCz65G729TyGSiL7zKDHlXsik5F+r5BRCe7lcUOkYNtAi0Fq8iyI4IgMgRAoyiYR8cB
	dDJopOZq36HDR4BgYzY1RK0HiIbXfmfuDKZlV9ZmY94MKIEPL/xCjlfrKnaBocGOqIVpttQoVV7
	rETVH5H9klH+S1xeepDcgOwOWe7I4MTjc9gCC5lQQh8a3tPfaHXVsUCiocoi6nJqYtCbGSrn+yL
	AFlUrLcByK7RORGt36Qw3+CuId67edU/qAH67uJmlIJ64aD3q+3KJ4s2P1U/f7uPboFQfHkeqmA
	5HHlc7YyGY+Od8yFQ==
X-Received: by 2002:a05:600c:8b4b:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-4995e0254cemr285139635e9.0.1786360353019;
        Mon, 10 Aug 2026 04:12:33 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:96ae:4423:ae88:ca02])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421fee8sm361632475e9.7.2026.08.10.04.12.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 04:12:32 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/wget: Handle long filenames correctly
Date: Mon, 10 Aug 2026 12:12:31 +0100
Message-ID: <20260810111231.2610507-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Aug 2026 11:12:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19909

Long filenames, which may happen through sstate, were being handled incorrectly
as they could exceed max path lengths when '.tmp' was added.

Handle those cases by using slightly shorter filenames if that happens for the
intermediate tmp file.

[YOCTO #16293]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 141c2d062d0..1e5d20132c3 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -106,7 +106,10 @@ class Wget(FetchMethod):
         fetchcmd = self.basecmd.copy()
 
         dldir = os.path.realpath(d.getVar("DL_DIR"))
-        localpath = os.path.join(dldir, ud.localfile) + ".tmp"
+        # Where we ultimately want the file
+        finalpath = os.path.join(dldir, ud.localfile)
+        # A temp location while processing, keeping in mind max path lengths
+        localpath = finalpath[:250] + ".tmp"
         bb.utils.mkdirhier(os.path.dirname(localpath))
         fetchcmd.append("--output-document=%s" % localpath)
 
@@ -146,7 +149,7 @@ class Wget(FetchMethod):
 
         # Remove the ".tmp" and move the file into position atomically
         # Our lock prevents multiple writers but mirroring code may grab incomplete files
-        os.rename(localpath, localpath[:-4])
+        os.rename(localpath, finalpath)
 
         return True
 

