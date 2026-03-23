Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF62DF483E5
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 18:53:47 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2449.1774292022692881572
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Mar 2026 11:53:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GzfhMB1P;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89cab686a9bso3996906d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 11:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774292022; cv=none;
        d=google.com; s=arc-20240605;
        b=X7qVUPU18zyXyyn24AxUr7MiN3oheVFUnL+QflancRsPlHFJhNEQQPxDM+st5NLW1w
         XMlrE6NDOTWQ/FzWHDosUmUC2kcasY9uDhygq2857pqMvX8/4oln5SOSMWa/yKcqYDRs
         +ZUtbT7JJtieYeIHR3AB5QhpFlW4ChGOlJMusdgKDzD/9wQ7oxUOJtcZhzoja76DxFsy
         S8Mk5iDeB8hg7gu8JTol3NoC7JEwfMLYaWFkPrrD4H4Tebh73QrAQuLMpFnG8uEqz2qU
         dRSqhmgJ6zAeFMAVOCwkkvnsqkK4XSzNwiZHJz8XeO9QyboLp8O56znCDY36CInFaFv/
         MP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X/9P+OpmNpikeBVFNeM5yg26XegKcuL4F8PctfixOK4=;
        fh=z79r7devTYIWKIIJnNEQrp8fu91t3iK8WPc0gYxDyHM=;
        b=EJIL/+eEwZXmMexArjcEufHkSPoa/mgSk/EU4bKZqad0W75J2S4bJg6QAslwm16ftF
         PcsDh+fdKNW/4YxZ0ueW1zgks2TvQytAIEUfYt+pklzXvdQ9sSnZM/hqO+jrvZ36eTTR
         NOAhlFbYUcXLh0S9sh+5ULqflNgxQUtfTHUXoGl3iPjLTCbjednvu9qmLHA5ExuTE+oI
         l054GqyGXvtu6cRmgXCw8Ef+TC7MuV6eU6EsAsq0HMLvH/zrOkdihzi2aF/mtyL7+b75
         ghlSww+ZF3nx6Dfotu71JBLEuwEoZ84xaKXWEMgj191qvvQesjQyM6fyKrAkSgY8vbNK
         DXqg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774292022; x=1774896822; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/9P+OpmNpikeBVFNeM5yg26XegKcuL4F8PctfixOK4=;
        b=GzfhMB1PE3LhHPW+Z9I+6qBX2FNIFdCL494FwrrGr3uzKNUJAuzFRTJhqL0M0Oc5Tg
         PQ3CBmRMLc4l3lwW8dTPU8ofg8LpAr3zIayOLflqycxBWZzx97wGkFevdmCSFb0RyvYG
         f9+T6FJpYVqCfdSL44gHTl+9yUr7sxBo00NVqzimk7RKm8YZZkVed6ullcdqDarClr8v
         6NIsrHww7b1nGR7v52uBqs7YIBG/kCW6AfRR61r5xWM/O1osoxpBBTi+panFTlR3qs13
         gdCusQAHfmIMTjHbvbREQVnkoVN5Pvp3OauKglVaogI41+3h9R9LMaXmGGa/FfmV/Shh
         W8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774292022; x=1774896822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/9P+OpmNpikeBVFNeM5yg26XegKcuL4F8PctfixOK4=;
        b=afu7eVlP0bax+OU+IhS3wbFs30OJR2eSpdXzq9E6J04dU7ekXuM9/DxCYcNaUQFtM4
         6VDd58wu9Y+Evo0QBhqEpqG6Mik7fHHcsbGZSS2AcOot5+9YtqsT2PnG9cA53EBtQz/i
         ihgYTrPCaoktvlRey6zcbGp0sqvwC6SDcBCZN0AP4Hj9uKZIL2lS8UdE1gFC+7qBQGTr
         kSZEOYLu4lu9aG/EPADbZmYHuxAJauQOIoYOymd85tTTueIYqQwARiWlYkYoFxr3fpoR
         PWzDn7i177+Ub0x+k/+3ThUmNVevAa4m1nuFwjiwK2bRS14LuJhfAKBtBSmQcwzvz9dC
         kiRA==
X-Gm-Message-State: AOJu0YzfDDMFwVDRBPPhratevsTEX0rhJ6YJAfJaSESArU9h8UeNkxBt
	EdYw7iR2laYXIDAy4xXApktBnEB9E7CtxAXLNvEAKhY7+0cDoZjgFqyY8k6Pll6ofncc/5CpU3g
	hMYEnsbDXsYEvySb0SFQbsAYAEpXnpaw0aA==
X-Gm-Gg: ATEYQzyf9KiXppVYvduopEubp93+mDCYiLKDiO7ieNH/HfeY7o7NK22zu4yaVDS/0Jh
	gOKCMA/ErBW0OR/K/2wBIGIPtwknWe7oUPExFzeUYpGm2jIPOP9D5QySQMH+ekYvnbbdq0Jt7hL
	iGnvWSnIp8PqQXRgASTyj2qDh/DLuLJaVa4ERWyQeV+pwzH6n+f5bOrpU++JZtWb/2N3FdNy24L
	Dmc2j9ovRzfkNlGjnbl69NOxFKF3effRoHw7Ws7IgywzmE9ECNBIkNnNy+lmrZqqhe356G8/ZXM
	7KrFaeA97l1LXOH0G3ZSlBQ0a7uoEI3Df7dj1aTMFg==
X-Received: by 2002:a05:6214:3305:b0:89a:1944:a696 with SMTP id
 6a1803df08f44-89c85a1670bmr191345486d6.19.1774292021473; Mon, 23 Mar 2026
 11:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260322193440.870120-1-adrian.freihofer@siemens.com> <20260322193440.870120-7-adrian.freihofer@siemens.com>
In-Reply-To: <20260322193440.870120-7-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 23 Mar 2026 19:53:27 +0100
X-Gm-Features: AQROBzDUGgv3uxNdOqgjhOzBT1OvzWvk99k_jmVrRlax81jkTZnA2aWAdejmDjw
Message-ID: <CANNYZj95Rw9ExQGN2kgQtZof_fm3FeQY1L=c5gAG0G34m8+s-A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 6/9] bitbake-setup: generate config files
 for VSCode
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 18:53:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19212

On Sun, 22 Mar 2026 at 20:35, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:

>      parser_update = subparsers.add_parser('update', help='Update a setup to be in sync with configuration')
>      add_setup_dir_arg(parser_update)
>      parser_update.add_argument('--update-bb-conf', choices=['prompt', 'yes', 'no'], default='prompt', help='Update bitbake configuration files (bblayers.conf, local.conf) (default: prompt)')
> +    parser_update.add_argument('--init-vscode', action=argparse.BooleanOptionalAction, default=bool(shutil.which('code')),
> +                        help='Generate VSCode workspace configuration (default: %(default)s)')

'update' operation shouldn't need this option, it should simply check
if a workspace already exists, and update it if necessary (or simply
brute force update).

Alex

