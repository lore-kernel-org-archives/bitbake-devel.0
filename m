Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F1D6EC08
	for <webhook@archiver.kernel.org>; Fri, 29 Nov 2024 13:13:14 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web11.115612.1732885990868321050
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Nov 2024 05:13:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mbAZTSTG;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d88d3d1eb6so235126d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 05:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732885990; x=1733490790; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lOgIs4wwxqVsnp6EGfCnGSLCheLpLHpT68Mm2b8qsHw=;
        b=mbAZTSTGris5iw7PtLD3YkRjflEQN5QZdigBDgT9ZwetkmwneokZ1xfuAVtet9t6E1
         KliCtur/yJ40P5x+tepMpfmdZtuyr4GP5+I4IMuD9DW9DYf/D3oRNuWK83cmrxLw/2ko
         oZ5CbqGXYvZheNf3G76xdJxgmhfm7ERycTBVu+NikSce0b5OfBfrKtrPzVerckBfcgN3
         5TTc3hIxAtuQYA5qc6R6N+esBCYOvjfmx/deJsc4lqON0KMXY1u9vAr5JBjGB0r+Geky
         BDf2CFxkQ88XaOzW+oHroudYye38lL+ZIu0h5j8ncXPprg5crWsbqz3WWH8PaIkNF7fa
         qAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885990; x=1733490790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOgIs4wwxqVsnp6EGfCnGSLCheLpLHpT68Mm2b8qsHw=;
        b=poONOunAdIxIviIjQ5c9lsY/G4ltZXPj4dq7PI3YCWvglMx3DkgdlySjPQc6UL8P9i
         UQBfWDezbqhwGqY8MwKnQuJGK+G5R0aIbYSjm9hRekeKRej9gerPKWxXCqQsWxIV5Swo
         c+6SFegK5cyQ0j4kTIoe/lY5wUv3aETDcfvh97VbWAjw9GBXAdpxCAoFtwDM2NPBMIYP
         sewWE3LN2fBUNAz3Ojac125DJfuBSVnaSTyLXaRPDv5wEPHmLpUt2CmCqxx7IHAN3kgI
         JTts/HOl04WnGsZvFK0/K8hE5KJ6IlgnmwgzqzhlYK9W0Qd6aKRHfnaf2AjiJTdMznu0
         FbRA==
X-Gm-Message-State: AOJu0Yyqji+uz0Zo5WIKcaDhyfPna1pQT6m9l06qwpDwcDliG3AbpAe4
	KLRFHYpV4b/1HYybVoMeE5wRGAVy5Cd8bTGTJirQQ4WqxN7IzljF2uUTu+jH/kQE/e5tGWypZy9
	S6NVHHftatD4G0NBhnG+l0keCp0Y=
X-Gm-Gg: ASbGnctRpCvF9tlHRRD4J1Xfmw3pClbppnZvZdk9GxJ/JgUCZRejPmPPT7I4N1qVbv9
	uMSpPy49sIX45pplDHBhbBhkN88Qgqo5GtcXwHap+4Gh+4sTMRqTZHsV0695yHeGwIA==
X-Google-Smtp-Source: AGHT+IHwwKYIooSX61lHgWn9brtC7i+wLWkqSibDm/Rq+rJyNp7qmld5r97zUmwDOOrYKbzIq88QV8xvFEixEVZs1as=
X-Received: by 2002:a05:6214:2428:b0:6d4:cec:2ffd with SMTP id
 6a1803df08f44-6d8729ce698mr128600086d6.15.1732885989687; Fri, 29 Nov 2024
 05:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20241129125524.131362-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20241129125524.131362-1-richard.purdie@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 29 Nov 2024 14:12:58 +0100
Message-ID: <CANNYZj_sJuUFJc9V37yhvjeFukqQ-A7GRC5SUwc+WMM24bvSeA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Fix performance of multiconfigs
 with large overlap
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 13:13:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16849

I noticed that particularly 'bitbake core-image-ptest-all' tends to
sit for significant amount of time without spawning tasks. I
cherry-picked this patch and it doesn't seem to be helping :(

Alex

On Fri, 29 Nov 2024 at 13:55, Richard Purdie via
lists.openembedded.org
<richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:
>
> There have been complaints about the performance of large multiconfig builds
> for a while. The key missing data point was that the builds needed to have large
> overlaps in sstate objects. This can be simulated by building the same things with
> just different TMPDIRs. In runqueue/bitbake terms this equates to large numbers of
> deferred tasks.
>
> The issue is that the expensive checks in the setscene loop were hit every time
> through runqueue's execute function before the check on deferred tasks. This leads
> to task execution starvation as that only happens once per iteration.
>
> Move the skip check earlier in the function which speeds things up enormously
> and should improve performance of such builds for users.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 61608ac603..2179ee1302 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -2210,6 +2210,9 @@ class RunQueueExecute:
>              # Find the next setscene to run
>              for nexttask in self.sorted_setscene_tids:
>                  if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values() and nexttask not in self.sq_harddep_deferred:
> +                    if nexttask in self.sq_deferred and self.sq_deferred[nexttask] not in self.runq_complete:
> +                        # Skip deferred tasks quickly before the 'expensive' tests below - this is key to performant multiconfig builds
> +                        continue
>                      if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and \
>                              nexttask not in self.sq_needed_harddeps and \
>                              self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and \
> @@ -2239,8 +2242,7 @@ class RunQueueExecute:
>                          if t in self.runq_running and t not in self.runq_complete:
>                              continue
>                      if nexttask in self.sq_deferred:
> -                        if self.sq_deferred[nexttask] not in self.runq_complete:
> -                            continue
> +                        # Deferred tasks that were still deferred were skipped above so we now need to process
>                          logger.debug("Task %s no longer deferred" % nexttask)
>                          del self.sq_deferred[nexttask]
>                          valid = self.rq.validate_hashes(set([nexttask]), self.cooker.data, 0, False, summary=False)
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16848): https://lists.openembedded.org/g/bitbake-devel/message/16848
> Mute This Topic: https://lists.openembedded.org/mt/109833404/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

