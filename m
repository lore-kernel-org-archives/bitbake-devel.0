Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD6DD59D65
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 15:20:16 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14939.1765552811307706119
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 07:20:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gon+v+HT;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88859a63001so8292126d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 07:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765552810; x=1766157610; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h5/O1E5j5fIeLCGDIydTse7/bxmFX8E8WwLRxOl6jb8=;
        b=gon+v+HTKS7ZJm5JXWu11fwOJ/vDDw9KhrGlpYJMTiDltxDy82UrhOaV4D05tD37w4
         y3yv/4EHpBcUjV3dJ/h+MGa+u0csdJI0MWL268qct8C2TJRTqXK+fOxKcntTmjKeywHJ
         psxVI6pY3INTHEf6XK93+EVyMc3fTcy9QE9jrL16MFF0sIbFaRxSvx+kjhfI1y54r3g/
         0HpkM9xmyOR4cfZr1tDPzQAW/SecWqiz023FQbYgceJgEksygmfmy+DjYWfOlQmaAPZq
         qJk8DYsOW6+dxqxq2ksfWeuQCmDwcBVPzvjcpRigIO+TpA07OzY57sU79IMOaYYl3Z6g
         XSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552810; x=1766157610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5/O1E5j5fIeLCGDIydTse7/bxmFX8E8WwLRxOl6jb8=;
        b=GzKQooes8JXBRomPjpslbwZTz/j5ks4mm2OZuI4t/HlO/sWX6YkAmWxjv9BVZ1Lfe8
         9wOhQYmUOPRigUeo1rKDFiiiz6Dd1yP6teW/uVQ85kAV268J3FhsevlMW8ncpQojMm4q
         NwN8KyeRijL2NyB1JGD6ZchkGgxQOO4K6c3suOtCJYJxYaA49byht39aNO31KYqlirYl
         g28zXVMz/APiw8iK/+jcfquJYGq1eNCv8IdZJxW/oMiKsa9GlUno/C4iMs5Dibb/Ru4N
         K8YnadkxCdbRkj/shSLA7L1fK4OeWYNENymWLx3wgB16CGsW6tSHQFov26sJATYTVlh8
         zcoQ==
X-Gm-Message-State: AOJu0YydlDZ60HlCCZWcmt/xRX6Kc+OP1ZhwzMF8fi3fcIGzEVAOwhds
	ZewG1uf8dajkidzBVTkOYTdHZiNC23m3FRlnVdZGUhKLk6myLkoLpAN409GALcAjx+M37LosuA+
	HwUH0O8ImSMx7SjUbATCU+pdnDHQ4QvQ=
X-Gm-Gg: AY/fxX460rhkoOXdViuWKrYeIwh8IS70DYiTRW/O1SkLUefjxw7Ub7qFydCoawFQN3+
	7pCNKtjSiZKF4hClGCgdvEQUq9ARoE+XX/DXfgYSKH2X9Xl+xHYRsEVlWZ7E4zP1/h+7gq2jpxO
	oX0AP+L3lWpHpwR0vK679fIdLlcUkGjHDS+hJLWHt/022OCAachO0vfvsPt6EiWcwdW0RRAvaFv
	jvvWwXpAXO2ESKTpato6Dla6N6s8EpCOqK6un1dmXmLC755/YYmQ3t3RRN5lHzldKLCNw==
X-Google-Smtp-Source: AGHT+IE+M4gd8T+Yc0punTGCWsvxyV5UohAXsmyf/cN6t70mBdGfshZu8RnCeXLONlqDvcpp0O5N7Dd+SBIEWd3r+48=
X-Received: by 2002:a05:6214:4109:b0:880:4e10:462b with SMTP id
 6a1803df08f44-8887e4097dcmr34447276d6.10.1765552810023; Fri, 12 Dec 2025
 07:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
 <20251211142532.983960-4-alex.kanavin@gmail.com> <9df2121472cb0296ca4c1ded0edeb1059e55a130.camel@pbarker.dev>
In-Reply-To: <9df2121472cb0296ca4c1ded0edeb1059e55a130.camel@pbarker.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 12 Dec 2025 16:19:56 +0100
X-Gm-Features: AQt7F2rO2BgANmK5NV-7OYC-kfRoIDvOe5e7iFNZA2YgQtaclmIex5OmWgUhXQc
Message-ID: <CANNYZj-4ob3HPkxj9w=_m+2LP_RBOe5R2ne=FUeckf+6kvogwA@mail.gmail.com>
Subject: Re: [PATCH 4/4] bitbake-setup: implement symlinking local sources
 into builds
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 15:20:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18577

On Fri, 12 Dec 2025 at 12:27, Paul Barker <paul@pbarker.dev> wrote:

> Applying overrides shouldn't result in both 'git-remote' and 'local'
> keys being present for the same source, but a badly written .conf.json
> file could contain both. We should probably error out if both keys are
> provided.

Yes, I'll add a check for this.

> We call os.path.expanduser() in obtain_overrides, so I don't think we
> need to call it again here.

This is for the situation where there are no overrides, and the base
configuration itself contains a local source with ~ in it - e.g.
something that is intended for private use on a specific machine.

> And, I'd prefer the variable name r_local to match r_remote.

That will be corrected as well.

Alex

