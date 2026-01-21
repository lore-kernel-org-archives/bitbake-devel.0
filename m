Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B6C44501
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 09:30:00 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8115.1768987793082790956
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 01:29:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aAg4dYIt;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-502acd495feso50986581cf.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 01:29:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768987792; cv=none;
        d=google.com; s=arc-20240605;
        b=Zvi7RCLVs4FwFQEnAm6DiGiw/RNvn58Il2IOLWRkfsjy+Zd4f/dZrgQoxWEpMn7MqY
         ediP1hAd/Hld9CRtit9R/OPPzUcryLJkHcakLDodb82pv2OAVjQC7Wk4mnG4XwdLKPm/
         uhhFcUqJstJ9TeL+JJW2Z/i97gjYwLfPVqXV8buLqEvl4mYRTNPymC7xXrb/rUk4EHhF
         gaOHYyiQjQEbIMjpaFJpf8KHhq/w6JMCvF8Tal9QZFE7P7r3GIW6vCP3ws1AM10BoEuh
         A6rsLT9bR5pGKw0h+QmNZKO7bBlb8TtG3gR7FuF1ZstAeCuRnGyNBWhfcQUZnIQKgjQx
         uZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fAOGZi8pRmb0LKIGySjoGB4f41gLdSuSjBgWaSjE0gA=;
        fh=EDWU2tBsLzGSMILdf24myye+6XvP5MXMb5z/2yUvO+c=;
        b=PrewYyXPmtMczD5fEvwID0UKkbZIGVC7flaX1nWVzgP65xHWzQEGPftzJAk0eb+sR4
         ur+bWGkJ6tntgrySYdkSEztAkHa9uSGcvdG6LTfCp8OYcMlxtH9n69S8hzVC+PoSV4s4
         oWy3lXWYM1iyfSetdQ6ls71dtF4kyte9BE3x5z1QxM81GJfRcyTkOA5pszmoufijV3Ao
         aCYsy42/QVadt4UaQGUvtInwC0M44gwPA8ywTiJr0uVi24H+KSQmMi8+Mu+lH0nlObdJ
         MF44o5XLtuE37NPD+PsV6dcdDsNSfNYU2N2v4+KBAnjLxmwkKJVNzE8a9M+GEITYoaJg
         ohfQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768987792; x=1769592592; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fAOGZi8pRmb0LKIGySjoGB4f41gLdSuSjBgWaSjE0gA=;
        b=aAg4dYItP8ecK/4msKineG3Le5OcgRNYlIFzRKrN9R09uxuNJlEx8GYLWVlbwlyz0x
         7pfQ+NFLZ3tuCxiTKLHpqK7lolc+mvPz9m0ckXntzMXfe72ZkttxuHusIJBXlSCqHx06
         Ho1zXxHBprndm8/YUdYBy7ZBitpoCG5E1/2YxOA+AWXcQKBl79t/JKX2esPZKYtkxLpL
         ZtVkCNsVnoib2PQLJa+Qtc6SaHSBRF1mdVcJhRD/Xscwy3pYgxL2+vx7eVErlmXIu8Ta
         h688QCYJhf7/5RtX27oEjdvgclQLLW8M1lX+DcAkvQLRiizRDbnkEiofpkFFDDY1+saY
         s/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768987792; x=1769592592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAOGZi8pRmb0LKIGySjoGB4f41gLdSuSjBgWaSjE0gA=;
        b=YmyzvyXfNW+tn8JEzacT278ofvpg2M7UFAuGRYCYDMiO8y56p/m6REN0B0tviUg/XQ
         bckRz4G3ZFwz1qkdZL69V9mN/hydrq00b3xgXtUhJiRXVN685CqWfOZMLaF7vk+VoUGY
         tegGkVmhO7Mr+4XvGRXsK8F9BuhP8kNGBTRzzC/G1jICuqaPmsCIO6bskTtzlV6JgXII
         PGVhGoa82/CSQwkt6nShXbqKxLoTqH3GWhn0Ktas7fh4Gh85dJZ8tyUoxqJFEUPyI82E
         OUulKOH0jNdyllVgOyG/2HkgSFBqxUVTLhGXfhC0FcFYIq+tP3YAOoL7oMbA5ZD6y4ob
         qoqQ==
X-Gm-Message-State: AOJu0Yw6kgSpNDtPVRdHrP1wA4sdGRMHJZx9Dus3wQTR8CnspwsiGKdX
	B9nDIAUZ5afRbY7+pIbQp99psMa/uMkxLl+fbUqDoqnhTspJRkrqhfEugeYiqvnuX/QlQlg3cn/
	kEbzBNc4cuuw/tiqTphhu6hau/HX0uPI=
X-Gm-Gg: AZuq6aIX9HGnMF5BFjcIWuIJ1xQ4b7eKcZ9xobcEW2vMmm85EufEIkG5i0KvXuQtGW5
	W+7OEyYmSAHJaLUIFyCvOGvmb8WO777vfPgXXpOkKde8OwR4RiUKEZek7BnaSjp+wDyGkRLxFQQ
	Jx6nqbGI/CU5ZVKxAOutX4GDmeyENBrkLrCV/qI0nPD9DRDHK8apJLGsBRABsb310b44TlYcMk1
	f98ba+4gsrz+UnaewISizBn1TJOMyH6KLJPwwlgJOAb0/7Vrb+hpmNWvenkKTjLbL7MUhIwiHEh
	sa08dBVgRFMKpOXHhST4RMhu4apyfg==
X-Received: by 2002:ac8:57c1:0:b0:4f1:e9da:e876 with SMTP id
 d75a77b69052e-502a1f84f0cmr238086671cf.62.1768987791950; Wed, 21 Jan 2026
 01:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20260121024723.2634264-1-rob.woolley@windriver.com> <20260121024723.2634264-4-rob.woolley@windriver.com>
In-Reply-To: <20260121024723.2634264-4-rob.woolley@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 21 Jan 2026 10:29:40 +0100
X-Gm-Features: AZwV_QgOczXfVka6oxpzEGDpRim9YMkPiexNthpZpnluUmt8rEk3j36xHXhtElM
Message-ID: <CANNYZj_kGD8X4RFuOymYnFNr_k2q+v-O9Njd3XkS+xD6B2sdmw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/5] bitbake-setup: Add wrapper script for
 bitbake_setup module
To: rob.woolley@windriver.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 09:30:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18831

On Wed, 21 Jan 2026 at 03:47, Rob Woolley via lists.openembedded.org
<rob.woolley=windriver.com@lists.openembedded.org> wrote:
>
> This wrapper script is used to support the workflow where
> bitbake-setup is invoked from the bitbake git repository.
>
> It uses the directory of the script to find the bitbake_setup
> module present in the same git repository.
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  bin/bitbake-setup | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100755 bin/bitbake-setup
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> new file mode 100755
> index 00000000..e1b1cdd1
> --- /dev/null
> +++ b/bin/bitbake-setup
> @@ -0,0 +1,11 @@
> +#!/usr/bin/env python3
> +import os
> +import sys
> +
> +ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
> +sys.path.insert(0, os.path.join(ROOT,'lib'))
> +
> +from bitbake_setup.__main__ import main
> +
> +if __name__ == "__main__":
> +    main()

I'm not sure I understand the rationale for this and the previous
patch. Why do we need to convert bitbake-setup into a module, and
replace the executable with a wrapper?

Alex

