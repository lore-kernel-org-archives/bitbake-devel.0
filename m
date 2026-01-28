Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337AAD25B4C
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 12:15:02 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11861.1769602497223326585
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 04:14:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FUb9QNec;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c532d8be8cso616905585a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 04:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769602496; cv=none;
        d=google.com; s=arc-20240605;
        b=ifkH1pOb+kTLBGLjiap78rDbMukqUA+ooShamCboyCH4Lt0Daq9asJ8z5MgAmO26dI
         u9jlAHSiNnnKmbs6SLPKRljbH8kDTfu4a+oX9VTTdurAOLkZbKzRukISI6GiMC6Zssb5
         +20Gn7/HOHZzpZ8OwiWKcL9HUER9rq5X91Kunszx9RgPdkl/fgsYfQqMeh1g7zwQPVlR
         hQvB2pUJBkwsRxQ4RwpKr13TOQXzwcgXfD4JA0vUYSj7USHKXpZZ54ixqGiX8gQEPwAo
         3/Kcz/5wUEdL0WOPP9PZMpTfTxdrFwv/Jvl1xoKPgUAPHkAqvwFksdTZ6qwGTt0pkKl7
         udVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mnLseGUE5HH7AE+ozy4iT4qV0avr8JCjRUSqx1Z8/jY=;
        fh=OW3Dv9aSaONdxqFEg+gHG7ItOEhRMtXzTVqh/JdGy3c=;
        b=UjAdumRABPJx7zEBw9D3abYkC1i5mpIR0+PLvowm/4tI+usn2ZHOZ3MujbQqVA1k2Y
         kJpPGdXM4KWgSYYNlYVDJtt1Jqm/yu5FEh3WASooPo7pbz4i7+fL00nASXsT2Ty9JZr8
         x9EGze+VS3PQi+/MTRBMjtWlYQSY43ClJczzoVLP3ZRqkhyDnughE/E3vhmDCazE23E8
         hZT4kRW8Lpc1QpOc56INZvtTgCp6ErLfJGhRyEXHtNPt52Woo0JxI5uxySTBawITz27S
         L5HJ8MwH2Ds/DHmBrG60Brxe6SNS+AJcBn2bmpieJLiioxT5r83KmMvNG3NKfv+Dd3ei
         jIrA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769602496; x=1770207296; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mnLseGUE5HH7AE+ozy4iT4qV0avr8JCjRUSqx1Z8/jY=;
        b=FUb9QNec4q7AueLR9Sc4GAcWOvez7qLEhGBfsdg4WG94KXdqA3afr8gGh6Cx3/6aWL
         utypolfPqKJ8ZJ47e0Gvnk2FUOgh/9j1aWJxWJPG30TvExpiM2K3eR+KwxpQUPKIEAff
         pss2/mGAdB1KIQy0F9Aj950Ad1NV0UF/Zz8AVc/fkFf0Vsie7qb6r9N6mKXM0UY8CYBe
         +as6JjP4Sy53AWL2kJ1wzAnBiVSR9wL15um7EFO8v9OoBqyOvhF0MiZ4W6c2eY+FfRZu
         bNvIxWNOI+zyvCLwlaoRHK8XtaRCXJWihFc9RmArCxqVYOBmA5EXRVZ6S1B/jMSvli/3
         Ql4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769602496; x=1770207296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnLseGUE5HH7AE+ozy4iT4qV0avr8JCjRUSqx1Z8/jY=;
        b=ZxtAYxN4BxpZNd+uaIeMFSuoYX4CDV4c2kMTLkRvdz6gsLJpmA2+fpS2dhuCLNdxEh
         JZAG7RebJMhFJD2x3mE4HWd6X5jGAbmMC53XYhtP3lrp0j/7M7RB+Ec+fVQMm3uxgy1S
         /ZG2EDjuAvGvuqQszT3Dov6hAMzG9PNTH/jaHdoQXegHL8qSi/vPnfwRDp+Q9kz6Ur2u
         Bzsof9Av9CdVdga6vgBDtfWVDA9N1XSBbPz8k1GhtkSTAuXSkKBm2sd1E9SzmFDQqbIC
         vfBj+XyQn9nFRVcrycjiwy5gfPa0WxHxWE8A+6eCD0QF3uvs4u/aDHp3hkingLwsMC5S
         aLng==
X-Gm-Message-State: AOJu0YxeYnblm1HZNAtG5p4gB7VxQ3L/onMTZC7TY35q2Jr8JPserc5R
	RXZa4kwjylo9af55vJEHDYLFCh29MOqhXVb5jGa8KDeSru6aDnhkEGr8tbs9MRAeu9HyMVK/4iI
	tqH4z36VvCPFbITxbU0kPQsSiGicnDa9twwZh
X-Gm-Gg: AZuq6aKwRnVVxeuxNZRyuk73Z+NcuypvcaX6k+6hIsThTK7NNGrtb8/6QF2a6l1IpRR
	OWaYvDwBjoeWi2tUBO4jOCsw3CCMU1/nQPnK45oOL/Ok/cVyXGTCnf2tBsSz0RXLhVflAk8qxPy
	VmxhqlKj0iKhOk6JeH2WsKfs2dDQqxmdG6buH04arvhimryZfyo9ZQU25OSQFqKt6cWWKVvOB6c
	i5IVtd2myun/LKNH3MX4+IIgcijT0xReCvA45sjrx7TEbYAPHqKReRP2GYg4QWnEQEBhWAHgnvH
	iGZQCrTPJIbdWkUsKFGpg2/rdlbkVw==
X-Received: by 2002:a05:620a:1724:b0:8c3:5a72:b11 with SMTP id
 af79cd13be357-8c70b92f7c0mr648709685a.90.1769602496112; Wed, 28 Jan 2026
 04:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20260127160508.3392732-1-rob.woolley@windriver.com> <20260127160508.3392732-8-rob.woolley@windriver.com>
In-Reply-To: <20260127160508.3392732-8-rob.woolley@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Jan 2026 13:14:45 +0100
X-Gm-Features: AZwV_QgJZp49ZnYyOYahyLzv2gdiEPsmXMSCHv9wt6mlTLYZPYLgvBUeHZdm6Uc
Message-ID: <CANNYZj9+7rLoDbtyujAu1S=WQE6Hd2eBRAo6Evy8osHvF7ww+w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 07/10] bitbake-setup: Remove unused
 stdout variable
To: rob.woolley@windriver.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 12:15:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18910

On Tue, 27 Jan 2026 at 17:05, Rob Woolley via lists.openembedded.org
<rob.woolley=windriver.com@lists.openembedded.org> wrote:
>
> The ruff lint tool reported that stdout was never used:
>
>     F841 Local variable `stdout` is assigned to but never used
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  bin/bitbake-setup | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 59412588..e3e577e9 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -583,7 +583,7 @@ def init_config(top_dir, settings, args):
>      create_siteconf(top_dir, args.non_interactive, settings)
>
>      d = init_bb_cache(top_dir, settings, args)
> -    stdout = sys.stdout
> +
>      def handle_task_progress(event, d):
>          rate = event.rate if event.rate else ''
>          progress = event.progress if event.progress > 0 else 0

The next line is
        print("{}% {}                ".format(progress, rate),
file=stdout, end='\r')

So stdout is used. We can't simply supply sys.stdout, as do_fetch does
tricks with it to redirect the logs into a file (otherwise they would
clutter the console).

Alex

