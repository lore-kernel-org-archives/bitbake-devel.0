Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A5CAC5B0
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 10:09:35 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.5225.1759399773651791819
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 03:09:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ocx6a9qO;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so8658175e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399772; x=1760004572; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEG2LiB+W82jgjqncB4nLpIn8hSl+MlvmbhEnGyNSds=;
        b=Ocx6a9qOY0RN/3wsGmngaURNQ/QVnbKwkbJBLPD2oHVac3ZWFR4rctUXFvvO6UH2Bq
         7tmtKP3mBXcEpzzALhnqU+uvmFSzwUSv1JGb1bbCg2aP4HArqhpP8kE46bpMdptAkHr3
         xvcGwkAxMShbTDKyBhXOF/uugiAIMwf9AnuNYs2EFJDYCEVTbK3v9aQuhF0+VRFW60XI
         u/rTAKekc6m2KkiT3R05ErMMseRoTxDvOPx2ijzX4OW4bYSX70T6sKn9fIqRKloSHRaF
         m3gGcSIta6gW7/Ke1zpPOMXWCqKiXVZE5nrO/qJzny9ychfhD/aJ3uFSFLJMi5QzYVU9
         cDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399772; x=1760004572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEG2LiB+W82jgjqncB4nLpIn8hSl+MlvmbhEnGyNSds=;
        b=GwXye+vRt+p2NjIJGTLj2SZJ0e8FqkK05EhrZYxHkCD6THvPZYgia4sOmsWnu5Bv4n
         nCmM4YV9N3kQg4fLgymkZjp5plMpwh3svG+z86p6OZN7/f35oSnl0uYwFgwCz7AShzNs
         ZpqudAtwK0mRPp99Dpa8HoKBqb2RF6ehmNfm6O5qXslyTZtBvZA7J3LmrPG9+mAhn77K
         mvgayj6JosXLo6/wh7E3cLVwopZzNFXIONxthjdUuH/3J2tmu7l8JBbjDR0bBPED7cUL
         fMszYkhqlI+ZCjwVyltOKY97u+x95txMzEU1I4u5gzi93itquC09WhEjDEFBkOZLVNjb
         sxwg==
X-Gm-Message-State: AOJu0YwEhfzbM45KzQqwPutoYNrcO5PWcE0tx6b3D+2KL1y33kwmq+jJ
	IPqNVm9OWMOReboX9wph8NIZ6f7j5VlJRLr11oEmcp8OyetAyH9kkwv+3gG4gQ==
X-Gm-Gg: ASbGnctc/j3ap1hEiFelr2F4qJJGjqt+CzBChM6NVkOq7OJ2M12JgwYzUlmixI5dPux
	INzFKQW+ebJI85e5w1jd75ovJdJM7YLjpKNMtGCV1Z2sBBBeycfWQO/8rtTL5M5Oyg0rXqko65R
	FZaVSC6HLYhraYdWNZuVb0dqhkyn6+BIi4Wcq/FsvpMcbPc8YhtDpdsjDoiGQldcoIo1KK7BC7j
	nVjuBkNOPGzq0pZl6Z8b8HnaGKvPM7KsbmDEkSGET9gKCI52oKstQ1aMZ1Lqc/02ar99tsAvvj1
	TT9sFXr1utHLD+RjzsDD+4cKAUbtknv0BflY1L7DT88LnuZCZdX52MCzv6MEAfErrNu74WG481P
	FoWp1zR5cKct36mrELcjC9U/hSR+7oO33jnUtYTZC6BZuGrD2aV0ILNnWVfQAeUNPsLsfnUXUp9
	asnHS8R4niI4M3InkMfC6MKftcgWMoW8SyhfO7Aaz62rxTUZELAOh7YxXJnWyzv8x7XVdF+sqeN
	Rnj3BhjAA==
X-Google-Smtp-Source: AGHT+IGI3Exh1JOvwThxg4AqlN0e6xMZYgca5CpJcJi8xCm4kUlQgCUIQML1w2MmZkI+UoiM/t7S5w==
X-Received: by 2002:a05:6000:2dc3:b0:401:70eb:eec7 with SMTP id ffacd0b85a97d-42557808ad0mr4707205f8f.43.1759399771681;
        Thu, 02 Oct 2025 03:09:31 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm2953894f8f.12.2025.10.02.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:09:31 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 1/7] bitbake-setup: suggest "." instead of "source"
Date: Thu,  2 Oct 2025 12:09:23 +0200
Message-Id: <20251002100929.1054540-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 10:09:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18115

From: Yoann Congal <yoann.congal@smile.fr>

"." is in POSIX standard[0], whereas "source" is only supported in more
feature-full shells (bash, zsh, ...)

[0]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#dot

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 1fbb65494..51d9503c4 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -219,7 +219,7 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
         f.write(readme)
     print("Usage instructions and additional information are in\n     {}\n".format(readme_file))
     print("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
-    print("To run builds, source the environment using\n    source {}".format(init_script))
+    print("To run builds, source the environment using\n    . {}".format(init_script))
 
 def get_registry_config(registry_path, id):
     for root, dirs, files in os.walk(registry_path):
-- 
2.39.5


