Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C25D11705
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 16:10:55 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.873.1764691851994826463
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 08:10:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SYfRxV5a;
 spf=pass (domain: gmail.com, ip: 209.85.221.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55b302b8369so3649127e0c.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 08:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764691851; x=1765296651; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4r7JDdWDFuWsuFwmAoIcTAYcqybDsrM5KVEzfychlPg=;
        b=SYfRxV5aphVMnhWoLFFEPWTkpbMi2S8H9zujWHaQng2A9ouBi+x1jbGfC+XZXmK2sB
         s5FLBMj63QnF9yg5IEESRBMxLsXcLxJHIS43KHxRRCQuWiNoPLBi7+4GJ8+2EPuT/GQt
         lx07ncxSG3rDDPHT2bRWhzZgugSMIQJMxn/BFzJAy/fWghMEgp4xJ1O+Dsvs3xZqjcNt
         TDtZuyCm7znhOPjgpo0hICWm4zVOGsYY3qrvcVmigoziBExPd3y+dQwWmRsWPSn1sq56
         /u4yUccLokaBYwbgi4fQtMKCV2QI1VXuJA7CS1AxY9bQsL+H0Bz5VCWyg8SFZhgsqI5b
         Yd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691851; x=1765296651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r7JDdWDFuWsuFwmAoIcTAYcqybDsrM5KVEzfychlPg=;
        b=qXOy9Qf32I+cim4hWB9RUNERCaYIrvID+L96eZhwp7OcozBNBxFkz1AJqf6Uns2qXv
         Rm1m2pTfAJu2hUVle57ZhVKySesOoyR42nxKLdzYboHlouG5sbiwL7WJjGqDk4wYuX/r
         w1BzIkOBqzr6Jpxc3dTk7kP3iU/GYtleA35wwBm5DX4uWxq0Ayv1n/JfW/OL2gbk9srf
         MWElfLE9E+l3gz5zi8AWG1caK8Sh4cgKj7RevWaN3R6rojYQFMSW+kOufdoRJfVqO/bj
         a0Kcs8CsKvSnS8ujJK8vIe9MmRSLXqi/MJsEZiNXo6mDDVS0sQYCB9jNz/I+ryCsEjCw
         WhAg==
X-Gm-Message-State: AOJu0YxjCwXo4dI1ZTa8zFo/CNBLeff24whON4d4WDdXMDC/lnWxdaG7
	17Q5DMbW99B2T5ddYrKP20QcibDdI5vMiU4Ix5G3t9xjvtYbiQD4yYQfYOjrR026L1Z86h/JEtu
	1A4oREgpvCHOd/l4ujyzQtDTT4S0AFS481Q==
X-Gm-Gg: ASbGncsdyWZRulDaM6fokGpjWjCUAB191Nc+nTY1G0BascekK3tBG9JW8SxbHfgCFXP
	bFQrxxQWekVtprWO8UohLNk0KqLapdWGCAV6sn5al/Q6Xt2+BFeJ2UCtp+QPxAx1w27mU7d2h5w
	elqWMhh9mcHk0jxjItQSGypcyJFiJZjMPyNVVw9T2xL16yGWqGEUSZCVxO3xBNSRvZq7/IcVBi5
	Ny82dBblzLvpCC1CG5DAZuyDOaE3sqxfAwdksx8R5jzPbzTQgIrmZ6ByJCiH3YhDqkBM1ZVLJoZ
	VENK20KUIpLtfGkMzxUz9xPM13PRow==
X-Google-Smtp-Source: AGHT+IFM5FIKbMhtvJGpqbNr/6N4VHlvTc8+8TP5nKghOZPQjBBOk+p85Vu06wqsb7Tp4A8MscYkfqHV4b473Dth1+I=
X-Received: by 2002:a05:6122:459d:b0:55b:cba:f391 with SMTP id
 71dfb90a1353d-55cd777fde9mr11341079e0c.14.1764691850830; Tue, 02 Dec 2025
 08:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20251202160402.819060-1-corentin.guillevic@smile.fr>
In-Reply-To: <20251202160402.819060-1-corentin.guillevic@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 2 Dec 2025 17:10:39 +0100
X-Gm-Features: AWmQ_blxFfHjturj1bZS_Pfep06W0cXwbvWX4CoOgph9klaQ5II_H1oDgGf4Ybc
Message-ID: <CANNYZj_vE__-k+TprPNpW2UuphPscG-uLem05Z3_1bncT5xcGA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: add inline URI
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 16:10:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18509

On Tue, 2 Dec 2025 at 17:04, Corentin Guillevic via
lists.openembedded.org
<corentin.guillevic=smile.fr@lists.openembedded.org> wrote:
> +
> +        _handle_uri_shortcut(r_remote)
> +
>          remotes = r_remote['remotes']

Rather than have a function that does mutable 'magic' to r_remote so
that it can be used somewhere else, it's a lot better to:

remotes = get_remotes(r_remote)

and then you can append the shortcut (if present) in that helper function.

Alex

