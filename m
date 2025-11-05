Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5BECCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 14:46:57 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11296.1762354016454908899
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 06:46:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=ORa6ddnX;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.47, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso1267012a91.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1762354016; x=1762958816; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9yO81M5eJaSsNa4tXpscSOpU3GQgN58Bh9vwOf8Qhs=;
        b=ORa6ddnXB6hpJ2HGFnM9wlohgEOsSKbrvqIfwnQktcPS9FqTt4jODOV8Vb/lU+Sf9s
         iJItO9L28FYfn1uA312d9x8gQtT8jRfiYUDwxiogEg//Z547dyjF+0NqcdFGubVULxwr
         ye0n5wv7prrP7aazJAJTTUBzFy6vnQVLUmXAxeLjdtFzJx+Vm/gQZgNZi4P5ETjt12QX
         lsWlb8qr9OSSElQ9bU/kGqw6MoqXzIn19uPOHO4Afd6MNlBUBeu523gaMDPhbRmlkVI6
         rxlCsMvsFw3hbkNz958BCV+B2uE2/Rfhqp1C8jUAqSyQiN359BRtDETB/W/dhJCujAVX
         nkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354016; x=1762958816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9yO81M5eJaSsNa4tXpscSOpU3GQgN58Bh9vwOf8Qhs=;
        b=lk6O6AgX98citACPe0oKbq/vs+c/oJS1d8GgNp0eZuBAGLvuthUDMYoztwa4Z/IeeU
         oyu36xw3DNVOf9kPyV73jZK9qjhBLjrzukyo1z4GoULpaoQnFgiRUw8nSKW+FFhsi9Xa
         zrpM5G3vVshemntNLNLcuF/mi8X/AO7MsCMTTsbsxcHnMRCET23iP/mIgD/uXutFnq2/
         XImTKCpcf+d4zbylkcQ64tMu/b1LoI2apRuvyUDoWsO2klV0n3Y1GSDYbvHG3Mv6TRar
         HxkMlaFbj0yBShhPdw4Dhztkh7j/neGaBZ2YcXw/az08Go4eBWMhLE3ToufdD3Zq+7e/
         oDhw==
X-Gm-Message-State: AOJu0Yz3Pp6AHOAlRpGj5qadyyKwdvJs3CXCzpIlRWlHPQJWHBzfL1NX
	/As7/fLqpAPVGI8/E7iBJ2La+IkTDqCt/L07uQWtuwCP6hYBYbvd5QQLyq8sk3g2ZMq3YLeJGKI
	AveMYwF0=
X-Gm-Gg: ASbGncvuko/fl9ZKHOi1wA/dPDNmkHj1FIP1nHYNs3TuKwD1n7E9sdJUqTlrH0wRSVA
	tSAuapze6jGI2AZXYVKihiWdxojCVCW+9g03umGBouND7+56AQn7gdIxwXPH95aIEF20T7hQwov
	0BwYAc/gOfQTBydpW9cp4x2OLJ2XD8C3ol6nS87FSvyrDJaTrq8HCm+zkyOxC5wByqtzMLXtVlX
	ZQlMKpsjYnWQaKXTiLkAsjg8PHn5GNI/vtz5hMkhhVpzZgzvrX+S/P+hvVPK9Q+d/Ct/3aTjc+4
	5uIkDgvWaUNiFgGiSN+SakQbLQ+XfMmPoH/vk31AlK/4jmWh8Lu3YcMhUhche6cS55xttCc0fUe
	K97qZ0MTmzR9oHgqpUK7oqGCASTONzohyJxxxKCuocaELDaA29jOJdQSLriwKWVKrk78=
X-Google-Smtp-Source: AGHT+IF8sHy17ZifvSFw7gGtzgGZI4/1k/0iXuDrgIUY3GDIgmudMqXgSHkf3OzKtMI/Fw/ElNJJ4g==
X-Received: by 2002:a17:90b:2f0b:b0:340:be4d:8980 with SMTP id 98e67ed59e1d1-341a6c2d896mr4126591a91.14.1762354015676;
        Wed, 05 Nov 2025 06:46:55 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:56d2:561d:76c2:db7d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3921584sm6589449b3a.25.2025.11.05.06.46.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:46:55 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/2] bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()
Date: Wed,  5 Nov 2025 06:46:48 -0800
Message-ID: <6311eb37781ed5c1f016161d35bc7fc8d6563f52.1762353905.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762353905.git.steve@sakoman.com>
References: <cover.1762353905.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 14:46:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18264

From: Bin Lan <bin.lan.cn@windriver.com>

There is the following warning when executing to bitbake linux-yocto:
  bitbake/lib/bb/fetch2/__init__.py:464: DeprecationWarning: 'count' is passed as positional argument

This is because the 4th parameter of re.sub(pattern, repl, string, count=0, flags=0)
is a keyword parameter. We use keyword arguments for parameters that are not positional.

Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1a6ff25d4..7b75d5d83 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -460,7 +460,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                 for k in replacements:
                     uri_replace_decoded[loc] = uri_replace_decoded[loc].replace(k, replacements[k])
                 #bb.note("%s %s %s" % (regexp, uri_replace_decoded[loc], uri_decoded[loc]))
-                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc], 1)
+                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc], count=1)
             if loc == 2:
                 # Handle path manipulations
                 basename = None
-- 
2.43.0


