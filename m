Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.18492.1595172340925753233
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 19 Jul 2020 08:25:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h+D5Xbma;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id 88so5200573wrh.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 19 Jul 2020 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=uID4lJ8ZWGGLra97SUH9AYo01LQm7otuX4b37FkL2+g=;
        b=h+D5XbmaChkfnhdkdr3Fv/Kp8Sbox/VvBScO5uC0Tli48B1Re4i/dBs0Rr2LnSeV3B
         LVJQmsQ7IHqqz6gbUSegXvqvqyOzmpasSNGXfO0MYin3QByeaqM6lQ/yQumSEAxndbbC
         NXNcL8K0b2qlqXsfUqaeZnLK8dIPMuwJ8ISBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uID4lJ8ZWGGLra97SUH9AYo01LQm7otuX4b37FkL2+g=;
        b=PF5eAcbHveJ4XPwFaCgzDx1/E+M2MZhB5PGKSH0TQsb/lUT3CYPWXHDHMORu0zlh/2
         O+RG6XbEyMb5G7wt6a8ILXtc2tkjkdJP33AcOwTYAiRXxBUqKXYRBnWocR7PM/l2izRi
         0NyUb8tgReHZq22tMJ3Rvyy/UA0nWuWTLLM7WfH0O4ElO6fSVQ3/utOTRS48VKZ7QLec
         4aHqAI/DEAAOf1ILP6EV6qf1579wWenXWS9KFvkbdliruYweaxP19Qpdz51dyiJ5S5zc
         cbLW9xoxynBgMbGYuQK6WLEfrD0L+njIRBNge71lNAaHsER1aB9T+mmK6gRv87NKeQ2T
         u64w==
X-Gm-Message-State: AOAM532iOdurPs+C8xWKUYffKPUX9swSGGiuB30JH2iIE9Ic/S158Ojp
	hDQaHdGguuXLxMWmg0IcaUqIvg==
X-Google-Smtp-Source: ABdhPJw3h4KMuOVfo5Y/RT2HRLuJYkEbQwE0Vc3rBJWrAJKuODXzTAY5pAsC8ZwJCaKgjdk8Ss+aNw==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr17980858wrt.309.1595172339177;
        Sun, 19 Jul 2020 08:25:39 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 5.f.a.a.6.6.c.6.8.7.0.3.0.b.c.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (5.f.a.a.6.6.c.6.8.7.0.3.0.b.c.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:1cb0:3078:6c66:aaf5])
        by smtp.gmail.com with ESMTPSA id f12sm26854789wrj.48.2020.07.19.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 08:25:38 -0700 (PDT)
Message-ID: <436e18f3d9dd0fd0ae23547f4172f907fed50dc9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] ipk ar/tar unpack
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Chris Minnoy <chris.minnoy_ext@softathome.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 19 Jul 2020 16:25:35 +0100
In-Reply-To: <a3910c7d-89b4-6203-7ff8-339205e249e4@softathome.com>
References: <a3910c7d-89b4-6203-7ff8-339205e249e4@softathome.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 2020-07-15 at 15:20 +0200, Chris Minnoy wrote:
> From: Chris Minnoy <chris.minnoy_ext@softathome.com>
> Date: Wed, 15 Jul 2020 15:02:35 +0200
> Subject: [PATCH] ipk packages can be formed with ar or tar. ar/tar
> can't 
> read
>   each other archives. This fixes the unpack to call the correct 
> archiver based
>   on the format.
> 
> ---
>   bitbake/lib/bb/fetch2/__init__.py | 40
> ++++++++++++++++++++++++++++---
>   1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py 
> b/bitbake/lib/bb/fetch2/__init__.py
> index 2ada43befc..e79149a208 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1467,7 +1467,41 @@ class FetchMethod(object):
>                       iterate_file = unpack_file
>                   else:
>                       cmd = 'rpm2cpio.sh %s | cpio -id' % (file)
> -            elif file.endswith('.deb') or file.endswith('.ipk'):
> +            elif file.endswith('.ipk'):
> +                output = subprocess.check_output(['file', file], 
> preexec_fn=subprocess_setup)
> +                if output:

Thanks for the patch. Unfortunately it came through line wrapped. The
short/long commit message also doesn't match our patch format
guidelines.

https://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines

Could you fix those issues and resubmit please?

Cheers,

Richard

