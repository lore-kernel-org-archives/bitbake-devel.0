Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1CACCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 15:41:29 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.253.1762962089642745756
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 07:41:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GEC1Wg+p;
 spf=pass (domain: gmail.com, ip: 209.85.166.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4336f492d75so5690785ab.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962089; x=1763566889; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeBbHpiG2LCvKyoEQ8dLRgR7NIYZBzngHNpoDLuWqE0=;
        b=GEC1Wg+pvhT0UNxB0iAkyT3TEM53ZuDhD6AiFyOpfGPxW8r0uAd+0gJLHpHoGwX+md
         FUkipUIgBAWhIQrrNUt/lQZIeqT4ysSgA3aoOvQ7/P4O2lOmOzVt1ACGeaOi2CGfOzpK
         ASVCnR8tnQgqg41Nus5rIYPMahug1G/qUjKlKwRJgii71Ov6OGEXKUEaw8ERHgd/v5sw
         aXkg5TvRcb6W0o95cZekNkFH3olPRPNYRe2bATp7cpO6E0DXSYDUIN/JRwlxU0RrMbhX
         CO0qK6S/+OyfPd9sVtWIxYThBXXWPfacmbOjuyv7UAYhdJ0rir9Aje3TNurq2rrsYZyA
         Xgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962089; x=1763566889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eeBbHpiG2LCvKyoEQ8dLRgR7NIYZBzngHNpoDLuWqE0=;
        b=m+GStns6c0y7cjmTTE+dKsC0Xpfhd5KQF+J1RBW8VInk9GTaOQBbPH5KgApjDPy2sk
         SXDr8SYr6H5YXHKMBBr6q9ghDnlxIsfHZu93rdyAc2vfk0LnkxmEoReNrNxglebSmuGH
         tSqiUQykM7UlE+at8FVNHRv9cFUYhqmesN7pVN00sCQU1Zog76gTCds5SSrCHzhsbGH/
         cKnqwLV/RKOoJVI+mF3oihnofKnS3EGksHuLRCWzrivZrOqul7pP7F15cVqJno8ls2JY
         wSiOgYPGg0hd38DpNBs+6EU43fmc21rjp/WwPQp11Nz1u2i1p++P89WA+hFqh2l4vDI7
         beVA==
X-Gm-Message-State: AOJu0YxqbrWV1zhGA9ZJ6onvFpboW0YVwgvM7mtwiTTEkkUb1FI9OWD1
	mqwx5rny8eIJW21XyBdfiWJFZat36ZUV+vza178Z/u72wXi80F/eBwmvnUkitw==
X-Gm-Gg: ASbGncsL6yX04COHY10xzB5QJfjODhs9sRm5q0y7eFqJZ78omvG4gQGEIfzlefkEbj3
	N1di5YKByVCfFcbWnL9TxaJPxVIC4jZ9lIbb9KHgU25glUXFR4zzjBImSYMVvOD8lEtYmgahqMy
	lcE9OVjeFvGuaWD8mWP/S/2qIUHl56Ov2bLN0hnXMzqa1CcMN/7gleWVVPlL+IXTonFi0pm3QVx
	TNcNVvCVet4JXOPR9Ow9Fr8/5b7RMHcDthA8mFcCpvM6iNckhxrRfQ7CcSifcM3kDyMiIWSZNDS
	81UrRdyu40Rnou4SO+o4aNYW26V7EAk6Uce0eOtUESoVhPnV7AxDqhQa/H2QQh7iDs5RUqUkH/T
	uP119N3M3qNoX5P1dnOpqvazUachCRGQxKCjL10q/ZL5mi6j/rmDXsdDcbF6EFm06iBfqPuX9fg
	==
X-Google-Smtp-Source: AGHT+IEl+aeiKFz03Eig8fjUUHd9zYWDcRVWxn6+ncdRICFgN1RDjebW3qG7v2Bq2HNEJIV2u7MHvg==
X-Received: by 2002:a05:6e02:1806:b0:433:305c:179d with SMTP id e9e14a558f8ab-43473daeac0mr41522815ab.28.1762962088726;
        Wed, 12 Nov 2025 07:41:28 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::51c7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7aaf77e24sm1154289173.16.2025.11.12.07.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:41:28 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/2] bitbake-setup: Tell the user what to do if they don't like the top dir
Date: Wed, 12 Nov 2025 08:41:21 -0700
Message-ID: <20251112154121.3750738-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112154121.3750738-1-JPEWhacker@gmail.com>
References: <20251112154121.3750738-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 15:41:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18356

If the top level directory look new (e.g. doesn't contain a site.conf
file), then instruct the user on how to choose a different directory if
they desire. This should help clarify what bitbake-setup is about to do
and how to change it if desired.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 590828c9b..c3a29aacc 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -678,7 +678,16 @@ def create_siteconf(top_dir, non_interactive, settings):
     if os.path.exists(siteconfpath):
         print('A site.conf file already exists. Please remove it if you would like to replace it with a default one')
     else:
-        print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
+        print(f'{top_dir} looks like a new top directory. If you would like to use a different directory, answer "n" below and either:')
+        print('\t1) Pass one or more options to bitbake-setup change the top level directory:')
+        print('\t\tbitbake-setup --setting default top-dir-prefix <PATH> ...')
+        print('\t\tbitbake-setup --setting default top-dir-name <NAME> ...')
+        print('\t2) Change the default bitbake-setup configuration with:')
+        print('\t\tbitbake-setup settings set default top-level-prefix <PATH>')
+        print('\t\tbitbake-setup settings set default top-level-name <NAME>')
+        print()
+
+        print('A common site.conf file will be created, please check it is correct before running builds\n    {}\n'.format(siteconfpath))
         prompt_continue(non_interactive)
 
         os.makedirs(os.path.dirname(top_dir), exist_ok=True)
-- 
2.51.1


