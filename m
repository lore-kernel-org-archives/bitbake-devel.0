Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69A5C83F26
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 14:49:22 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web10.9389.1753800553350338150
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 07:49:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kfmzj7vo;
 spf=pass (domain: gmail.com, ip: 209.85.166.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86a052d7897so183560539f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753800552; x=1754405352; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TvCjr3nN//mRYSt4H7IPv6qXbpbDuLnPmF/OOZi9KA=;
        b=kfmzj7vonVihLYgK54CPvk7TlDx/WpfPIvYJks2NLaenuf+xapeXjQL24q9SWjXFMu
         RMV1P+K9cY6jWszcWYMFqUBEGBahAMEvpEXiX5QVFzPXUYWNlmK/ibPPQyf+0If7M0mw
         6qa357oBmQIvA2UQxGsIB5CJsjt1HTQPO+2oQrnxu8efLLhH6GFUtCdrGpmE8PNJmsQp
         FR1FkohlWFz2NVTPO5n5NkR+J0kawGQuNY9u/ADmSyLDNxakm5DT8Rm/y2e8YCB/SaBG
         9XPoP/fz+SNT4nKH5kIEBdRFF81zZixJH7j6gJL7t8AB4legh3284bazBPKtoH8ng0gg
         94fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753800552; x=1754405352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TvCjr3nN//mRYSt4H7IPv6qXbpbDuLnPmF/OOZi9KA=;
        b=czHb8nAXV34Ql774ga4/TX9oCOj563sbbm+o5K7MPl5nOjiKX52ogZFTzkejMCNCxS
         o98AIYdi8+o+Hwca8TeAgEnS93ELIiMtAzisEUJOiJpcdfDUedZGUy3hj+Oz5yHmNkZ7
         uiZR3rabUUazV/Qbc+H0Qt/RKvhSvNGDKQ23t2RlOuI6l6eEC8DQE7vkWmz9XKxHBr5C
         O2KrPGHscac1l/8bxVIBKquoEZtXnZFPImzqPaGt9CN4zcJpp9bbIWeGSW9iSscjGq52
         XT64futI32nJaqekgckF6p1iadzHRkfWaMS7G0Z7ZxKE8M1seFqf7GnWLR4qKwqmpEUG
         jyqA==
X-Gm-Message-State: AOJu0YwTyu/+y7T+rLsDJQaboWGtAvGMugq4VLQs1q7XsFmNIUsX9KHO
	vv1wN8T8I2k1JPOQ1X+IZyCdhf7+Edr/50g7fGKI38pboZkRkO7SVVunNCTOHw==
X-Gm-Gg: ASbGncuvjRsp2wIYVSLZs8xugE5+aoNqVdqeV8A9XjgMNWKhmQWMeS4tIqgfGzT+Mfj
	9WRhuaY7RTbU6nyBVkvU1v+TFuxZkveZwYefi6FGqprYjF8Hc4KrMQQjL2+kB89p5C55DVkGAR4
	LYtz9iv210E95YqwAeAmCb5dGzY6WfQ5L+B+n9N+IM6UHqrmAyyfNIvZakK2c8ywbM9F3N3OxPg
	0bGv3yoppcsDAGlm8K+R287RQwa9cSKzJY3TDLGI9C1l5eOcuzIT8zIK7lKvWisv1NIdSFQ9IMn
	iztI0dxcTmvVg+qWAXrf/4LNSGjlf89FkCDaFylP4Nnk2YHEapCIG/VN+doapuKkc9fcMRZWgoW
	1cDbByYc5BJoypvn+rt1u
X-Google-Smtp-Source: AGHT+IFj14ExLTBa1GtuAQsWJkQYOtAc2AgluuA2yYy8oSsNLk+lky3df6C9Dkw7EtBXCQbsDev/Iw==
X-Received: by 2002:a05:6602:341b:b0:87c:4496:329d with SMTP id ca18e2360f4ac-8800f104e04mr2735532739f.5.1753800551718;
        Tue, 29 Jul 2025 07:49:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::bc4c])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c91cb412sm2545328173.3.2025.07.29.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:49:11 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for dangling appends
Date: Tue, 29 Jul 2025 08:47:54 -0600
Message-ID: <20250729144906.1665908-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 14:49:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17819

Implements a new layer-specific variable called
BB_DANGLINGAPPENDS_IGNORE. This variable is similar to the removed
BB_DANGLINGAPPENDS_WARNONLY, except that it is scoped to a specific
layer, and it also causes appends to be completely ignored instead of
warning about them.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
BACKGROUND AND RATIONAL:

I was fully on board with removing BB_DANGLINGAPPENDS_WARNONLY, since it
was pretty bad that it operated on all layers if any layer set the
variable. However, I did mention at the time that it was going to cause
us some trouble, but not wanting to hold up a good change, I indicated
that I would attempt a fix for it later. Later is now :)

After much poking around in our setup and deliberation, the conclusion
that I came to is that we do actually need _something_ along the lines
of being able to ignore dangling appends, at least in a few specific
layers.

Our setup is that we have a "disto" layer that we need to maintain
against several version of Yocto at once. In this disto layer, we make
policy choices that sometimes are tied to a specific version of a recipe
found in a specific version of Yocto using a bbappend; and often that
version is only in one or two Yocto versions, which means that the
bbappend will be dangling in the others.

dynamic-layers doesn't work here because we are keying off the Yocto
version, not the existence of some layer (unless there is something I'm
unaware of).

BBMASK is also a less than satisfactory solution (IMHO). Part of the
reason we have structured our distro layer in the way we have is to
reduce the cognitive overhead required to maintain our dozens of
products that more or less need to behave similarly. Keeping all the
distro stuff together makes the quite easy to reason about, but having
then again to track (probably quite complicated, and possibly
per-product) BBMASKs erodes that maintainability.

We did go through and eliminate as many dangling appends with other
methods as possible, but at the end of the day, we ended up with some
for which we didn't really see a viable (and maintainable) solution.

I'm open to suggestions if this change is entirely reprehensible, but
our primary goal is to keep the maintenance of our cross-yocto distro
layer simple.

I also decided to simplify this to just ignore dangling BBAPPENDS, since
I suspect anyone setting this is simply going to ignore the warnings
anyway, but that can be changed if there's a strong option to do it
differently.

 bitbake/lib/bb/cooker.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1810bcc604..349e27d538 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -953,7 +953,11 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
             appends_without_recipes[mc] = []
             for _, appendfn in self.collections[mc].bbappends:
                 if not appendfn in applied_appends:
-                    appends_without_recipes[mc].append(appendfn)
+                    layername = self.collections[mc].calc_bbfile_priority(appendfn)[2]
+                    ignore = self.databuilder.mcdata[mc].getVar("BB_DANGLINGAPPENDS_IGNORE_%s" % layername,
+                        False) or "no"
+                    if ignore.lower() not in ("1", "yes", "true"):
+                        appends_without_recipes[mc].append(appendfn)
 
         msgs = []
         for mc in sorted(appends_without_recipes.keys()):
-- 
2.49.0


