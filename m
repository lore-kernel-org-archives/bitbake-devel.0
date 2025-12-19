Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A11E6689D
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 22:36:33 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28136.1766183785697914568
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 14:36:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xh14ZKI9;
 spf=pass (domain: gmail.com, ip: 209.85.161.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-657464a9010so846782eaf.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 14:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766183785; x=1766788585; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cllxCRhNlTERMwmcZVJWurgxKQjyVuOZxtraI9BVY+M=;
        b=Xh14ZKI9jb+wQMEv/9oghJYwIRPUHxFZfRMiYIfmLrM6nedanUbsh84ZrKecbI3gZa
         t8vHritirff4/Ox9H9jOyt67GcsmZRan0HudwiUKAsrR0JzfDZMD/ky8PQgePs2ekhWb
         Dwm9ydGJRI76egroX0/9+mKSW2a6qSxfVpsE7gCbM5quVlV8AQ0+qz2qmMd32qBG9XNk
         xj+iVWgVKjQS5wGM9qTGNhF0EUQ/069/B7x9hW8pTTzc78ZYenj2x+9iSsb0jW0X5BDm
         mpeca1dn6OM4DW5OSY3NWnYlzzwOJHUuE1/S7sxYoqEJk+OD3IC8CBDcmPGramkI9XFn
         XZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766183785; x=1766788585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cllxCRhNlTERMwmcZVJWurgxKQjyVuOZxtraI9BVY+M=;
        b=w8xarqvp2uuK8GdxtVCI2IFk7UqdvrYAsH780gRgMhlmgno/Q7vj1zvZOq0BOQMdze
         60wHn9eJ7w3bVvdlQ5iRXOtUKfQKXxLgKOSCcoNZ3G3j1OP5gWlVQ82WOODMFCRT9huI
         hbNrEVJD4v0BoUR1n5lT+pL8d6YF2YPVoUixN8M44FXIbdIDM0JxvW+Mjw/3Mijdj9Xc
         +APxueOCYn2ZxV9UBuqd92ZE5JmhbQOweJFvfDNPfvhWbSiQgBkwmEvvgpDLHLyLyN2d
         trpokzN2k2ELXBSZGY74BRuKE95/Q20dr/aQgX/Ah5iFlahQOsRit7UGa72NpUz06WBq
         EhAw==
X-Gm-Message-State: AOJu0YwfFuDUOR6VN+574THXIMSMwxk4NPLM5lLdtYl/6m99cqBpIvkj
	dP5OFjYNXn5fcCcy7KyfLvvNwHZPAw1fUbJgk6qBUY8MV7/RJ3aqSuvhay3dcA==
X-Gm-Gg: AY/fxX7XkYu85hTjxe0hbqL2qmqxX46NWHp79d62IpSvmKxTqV2+YVDefPB+RX7bg6G
	bF7IXTaiN6SwRuyRni38pJMvddzWd/89GdMm0v2nBVjJ5N2pzSAU3K7LxOCRHA1AG+urUFPxRJU
	7z5Zika1pVVUyLQAdGS5Mpar+YgGOvwZxHGMYnLLK8DTdl9XZWgfMqPJkpjfe5uj+5CbBIchHaF
	9CFKfiWW1lAjBYQeZIGKOgcx76N5k/xxgol2V7vnM45B78cYF5XZg/X+bJFvu1l1wFHRPfxUvsJ
	F0/tbT5es/XjBta1ZiAshOb+Lrq71O21Ey2rK2Pg4SvRieYWm7IVzutCqwxtmVI5QgRSxhVfgRc
	tbunbl+kdmPgSVsj/ePoz9qRI6coysQZalLzFQNEUVAEyzEeUyRQ8zxqsGizM7P6L9KtXzraDY6
	bsubMBrBMT
X-Google-Smtp-Source: AGHT+IGRUUj+jjN5S3dvFo+zNNdl86Us1qxHJ6xXMRoZ94MNi7w+YHLjfGzy9JcHDl9d5svKlA3wEg==
X-Received: by 2002:a05:6820:4703:b0:659:9a49:909c with SMTP id 006d021491bc7-65d0e9713a4mr1351974eaf.27.1766183784777;
        Fri, 19 Dec 2025 14:36:24 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::74c5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f3f9d15sm2399392eaf.4.2025.12.19.14.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 14:36:24 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] cookerdata: Include "originating" recipe name when parsing
Date: Fri, 19 Dec 2025 15:36:20 -0700
Message-ID: <20251219223620.2222861-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251030141904.69494-1-JPEWhacker@gmail.com>
References: <20251030141904.69494-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 22:36:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18628

When a bbappend file is parsed, the FILE variable is set to the name of
the actual file being parsed (e.g. the name of the bbappend). Since
PN/PV etc. are derived from FILE, this means that they can be
misleading in the event that bbappend is using wildcards (e.g. PV might
have the value of "%" instead of the actual version number).

In order to allow bbappends to derived the actual information of the
recipe, capture the name of the original recipe being parsed as
ORIG_FILE when parsing a new recipe.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/cookerdata.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 22ac95eac..fe41bb3bf 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -512,6 +512,8 @@ class CookerDataBuilder(object):
         bb_data.setVar("__BBMULTICONFIG", mc)
         bb_data.setVar("FILE_LAYERNAME", layername)
 
+        bb_data.setVar("ORIG_FILE", bbfile)
+
         bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
         bb.parse.cached_mtime_noerror(bbfile_loc)
 
-- 
2.52.0


