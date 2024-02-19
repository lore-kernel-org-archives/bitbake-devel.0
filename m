Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C144FC48BF8
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 13:43:41 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.41534.1708350216093083352
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Feb 2024 05:43:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EGgCE2Gk;
 spf=pass (domain: gmail.com, ip: 209.85.210.173, mailfrom: rybczynska@gmail.com)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e32a92e0fdso313312b3a.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 05:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708350215; x=1708955015; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=crwhSeal2LZks12/y9c82r/cdfuhVyxb7rxm4ormLQk=;
        b=EGgCE2Gkd7eafMisoavTj0qOcaL2mnYdfHeZHFqloxnkrcH55t69KY/WmEFbl+Vlm7
         p+8phlW0AZGImKXWby+Aok/52XbRX57kw16jhHc6wHJIhyRP+OH5HhTmD8ogB5PCK4wY
         758gpL01xtej91JtOWCvpadUh7B1A/BZy8QbwEsMEBvhI+TQWMucSMBoCrHu4NfmVfSb
         /clTQhu1cU/t74IysQWH1EHU/4bCV1cTPBYUSft/l6rnWiYXDj+bt6GYe7/DsUzodGFr
         00llCKHsl7aR11VmMUoPrkp3MlA2o/vr6phmmZ/+0zjADBk+XkVOcS0rbnQ+MHvAFbyw
         4kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708350215; x=1708955015;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crwhSeal2LZks12/y9c82r/cdfuhVyxb7rxm4ormLQk=;
        b=Ie9mnRnRe8A9T1Xmqod33ec7IM8esCdkPiy/FyOlwnQUIEW3j4T9ISh8bstgfFUhMZ
         IF8yVXJkv2GrGxb3rDXT+H6k+8JIPwPd5rwhy7j++4Hovty0NYOVU2efwWjgUR2qT7CD
         rr9dBZlBIPUmEBFOkAZxlOWb40Y+Tl7UDI634cdqMJ7gqfIVNKFjeFWsSZlWJtTL/DO+
         E+aIsgTpZFeQV+cYtafp9Pu3T+7CkqL1Z87mUDsoXUA6XkbRGHo01ddaL6kSj2NkuQuL
         9qnL8sP3a28Dz5yY2fS9PLOEZ+/57PdbIHdf5RgpgwMExbZxmAX2Xs74qjTgITRnmSic
         sPCg==
X-Forwarded-Encrypted: i=1; AJvYcCXZqyNghDgj4/gsQOUyDRB9XcY8hlKAVvQmrUiXyniH5YiI6IslL+2B71HlWoCS5FRIfguBgK0ChLJGjv8C6fnhFcOtiVYWPtS0BHonizwfxWpC8ao=
X-Gm-Message-State: AOJu0YzUILu5bvB+XwRlarJ34vSpO3TYmWaoVb7AzyG8HDBovQTTWJUD
	duVALQIbNkefcWvsWrCuMewCYFvvR2VC0wRuf5CDAAydWcoo1eMPAiE+cGCjFGqsHNRiddP91sN
	HzKMg8+uIIhaQ4jV/606FgH05OiI=
X-Google-Smtp-Source: AGHT+IESShPUxIRQURrNPgn7VWIkmxb/BC5FbdyqHY2s0ua1C5j9QKau7MWqbmSMNTw03kpS9VxE4V6H6ac+8KTzu7M=
X-Received: by 2002:a17:902:e84e:b0:1db:de64:97ac with SMTP id
 t14-20020a170902e84e00b001dbde6497acmr3805520plg.15.1708350215169; Mon, 19
 Feb 2024 05:43:35 -0800 (PST)
MIME-Version: 1.0
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Mon, 19 Feb 2024 14:43:23 +0100
Message-ID: <CAApg2=R-9zcMJOSDQXyZpGPG6KfACeFh4=_xn0tn0gqza6APyg@mail.gmail.com>
Subject: YOCTO PROJECT SECURITY ADVISORY 2024-01-19
To: yocto-security@lists.yoctoproject.org, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 13:43:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15941

YOCTO PROJECT SECURITY ADVISORY 2024-01-19

References: CVE-2024-25626 (HIGH severity, CVSS 8.8)

A remote execution vulnerability has been discovered in the Toaster
web application
included into bitbake, which is in turn a component of the Yocto
Project. An attacker
could craft an HTTP request that causes a run of attacker-controlled
command in the shell
running in with Toaster permissions. This issue does not require authorization.

Toaster is a web interface of Bitbake. It is disabled by default,
users need to launch
it explicitly. It should not be accessible from public or untrusted networks.

Users not using Toaster are not affected by this vulnerability.

Command line builds are not affected.

Solution: Update to Yocto Project 5.0, 3.1.31, 4.0.16, 4.3.2, or to
the current git versions.

Workarounds:
 - Make sure Toaster is listening on local interfaces only.
 - Run Toaster as a separate user with minimal permissions.

Thanks: The Yocto Project would like to to thank Michael Blunt for a
responsable disclosure.

References:
https://git.openembedded.org/bitbake/commit/?id=fe0881615896de844141393b21a121f7c3fa9d16
https://git.openembedded.org/bitbake/commit/?id=94e88efa9dbefd37f1d48459ade19797b6034b84
https://github.com/yoctoproject/poky/security/advisories/GHSA-75xw-78mm-72r4

Timeline:
19-November-2023 Information received by the Yocto Project Security team
21-November-2023 Issue confirmed by the Yocto Project
23-November-2023 Issue repriduced by the Yocto Project
20-December-2023 Fix pushed to the bitbake git repository
04-January-2024 A regression fix pushed to the bitbake git repository
16-February-2024 CVE entry has been assigned
19-February-2024 The issue has been made public and advisory published

