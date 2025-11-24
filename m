Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C0CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 17:24:19 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22310.1764005050941371695
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Nov 2025 09:24:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kvEKFTnQ;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso29887705e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 09:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764005049; x=1764609849; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1w4Edq4dQOsXAUQy6Awzvx150CoxD4fFYbvbZfQETw=;
        b=kvEKFTnQZ4rTCGFLgn1VwzbQkX3C4cbOz5XNsf16qcooHBzs7ozahnQe1KJTgeCaxK
         1GCgtFTyUfyyrjX5UObS2+ZP4xH12E1gg7OZB6hDB+97VDuSKyTN2jJy+QN9wx7VMc7d
         QC4fsgxNAmCkbQEjRBXUJNNiZ4L16eu9htX8Z1QiCdUlPvl2ZgMGXMXkjh4az/Sqr2ZN
         fblqCX8c9pGCvNZVQJOoSYH1hUZ7pXrlCXzrGyO8pEsqXaomI6v3YrEHfY3DNPvQM9WS
         u54buc1N1U6TAlMAeTUU65VkHL6E7wkKEnWiE8BkewDxtKLyZmK5Xi8eaaFcpYvMt5Yf
         /ATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764005049; x=1764609849;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z1w4Edq4dQOsXAUQy6Awzvx150CoxD4fFYbvbZfQETw=;
        b=LpdUzXgaYIFOlvn/CwbneV/Z9KJoIrvCuj/WOL8jjP5hbmYdrpTBzOhihRgt/gU4GH
         lMzAq6rIGBaOiIOpa0nPfHXfC3rcMFV9wYcX/OKWVzkb+1exPM8vGy0ShZrBThmh2EUV
         OPc4KKXod1RaGdw7U5guiFsmBggxoRmJBRJuIr42158DA/OMsoN+SlrPW8LYAJY74z4Q
         T2Xda8rLu5q/Eka29PFkEMXaupuMF1jf0W2vvRVSubZMx/bFr3XGyslG9P7vrhWmBeFM
         B3UxUfUoxvRwkIcqn2QI+fxENkb+KTcxgYMllulUW799JLYBm7/KVAVhREgD/l2lAt34
         +JQQ==
X-Gm-Message-State: AOJu0YxgElMp7MXZ993VXmyfY7j9xEpt5gRvgPOEFr3MrLfE32DgOtqT
	mKe8+1nHvh0vL0gi8btGINa1RvF6Rs3ylcBuzNddg24qLBVRPlc9lBPQ
X-Gm-Gg: ASbGncuDKYwshiaDCQ1gaqPioZbMsEpLiNd5WN83PlOt4fwNIASffXRQ0V/PrUuCrA/
	ZM3akRK7TqmEl+5TEc0Rvu8LUc5ClXgRLLaH5e8eeCubkLq9XmBU4hau5uy7Dum+IqvitctNrm5
	OtamsAiXzyfm5rWP1VUgHHTrGC+Ja6HAmWYgCNo5XKilHFFVE86br9L+GvgXijkmYmzdaLN4SNr
	joq20U/cTNo0U358AR+nbjl6/9IK+JuzFvX9hhZ00S+Qv1fMW/z1zablAtpBZfwoGprs9NiH1Mn
	DNub1j4rgoWKq4HMaQ/lSAZ/h5Z2okMX3psmt2dVUCsn6RLXuJfCowLjnHefZzj5dk/GqOwI0s0
	zse8zrW9yPbqryIxv5X+mgnU0m9m6d/j0fgMpzUMGDpBqUfrZhvOb5Flxayz2cnftXwNuyTHMbA
	Q47HMyaiTZAq+K
X-Google-Smtp-Source: AGHT+IGUs/f3tHVysB1ZlKntMi7sxySBVZQRtXWjJhMqnNWGPV/qgKkNy1XRXLpitVWnH7qtYFQzVQ==
X-Received: by 2002:a05:600c:1994:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-477c01740e1mr121978775e9.11.1764005048828;
        Mon, 24 Nov 2025 09:24:08 -0800 (PST)
Received: from osama ([156.223.112.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3af0ecsm208610655e9.9.2025.11.24.09.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 09:24:08 -0800 (PST)
Date: Mon, 24 Nov 2025 19:24:04 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: yocto@lists.yoctoproject.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [RFC] Proposal: New tool to display recipe dependency trees
Message-ID: <aSSUtHYFQlychNQk@osama>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 17:24:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18480

Hi All,

I would like to propose adding a new command-line tool (or BitBake subcommand) that generates
dependency trees, including:

DEPENDS (build-time)
RDEPENDS (runtime)
Optional graph output (text, JSON)

Motivation

Currently, BitBake provides:

bitbake -g produces task-depends.dot (task-level, not recipe-level, must use graphviz)
oe-pkgdata-util runtime dependency only
bitbake -e <recipe> view variables, but manually
Errors from the dependency resolver (if a recipe is missing)

But there is no built-in CLI tool to display a recipe dependency tree, e.g.:

bitbake-deptree dnf

dnf
 ├── libdnf
 │    ├── libsolv
 │    └── json-c
 └── sqlite3


Such a tool would help:

layer developers understanding complex deps
learning how Yocto resolves recipe names, PROVIDES, virtual/ mappings
documenting or visualizing architecture

I started experimenting with a prototype using Tinfoil to walk DEPENDS and collect data through BitBake’s recipecache, and it seems feasible.

Questions for the community

Before developing this further, I would like guidance on the following:

Is this functionality valuable upstream? Would BitBake benefit from such a tool?

Where should it live?
Options I see:

new BitBake subcommand (e.g. bitbake-deptree)
extension to oe-pkgdata-util
standalone Python tool under scripts/
part of devtool?

Preferred output format(s)?
Plain ASCII tree (default)
JSON


Should the tool:

cover only DEPENDS (build-time)?
include RDEPENDS with pkgdata?
resolve virtual/ providers?

Any prior work I may have missed?

If the idea is acceptable, I will prepare a proper implementation and send a patchset to the appropriate mailing list.
Thank you for your feedback!

Best regards,
Osama

