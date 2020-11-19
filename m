Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web10.13106.1605808987935762468
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Nov 2020 10:03:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=jrPr5g2r;
 spf=pass (domain: linaro.org, ip: 209.85.219.182, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-yb1-f182.google.com with SMTP id w5so6015596ybj.11
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2020 10:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDeom3S33/p9yDilM0ulpECtaQ16OvC0Rh1A078O9i8=;
        b=jrPr5g2rP/x409vrVFqQB4VkKpcYYUo9BWT3YHiKInIW++YZbC02FEeGkG7veHRMPW
         nBR/dFffqpCA3PrEAYSh8s4R3gyMoXMqKRx4zGe01DBgYyXkDE3JjN3oLpIZRA4wu4v6
         HBYufq+q5+Ja207923LTDtYDcjTkkcmBl+CJeoRC6i5187v1GC33qPLoVUsE1SxqgTpE
         MzmBqFznVNGOC2jlawgrrtY5TF8Y6B7Dqo63qapx9oFCZFqnOvxv0qzpy+QoNHcj+lEn
         KkkbsEAfx8aIN8tyT+2tXrlvdH4cvWZLUxd/Rf9HFnB4aUXXM5oH9A81TMPcTkMVQu1P
         CnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDeom3S33/p9yDilM0ulpECtaQ16OvC0Rh1A078O9i8=;
        b=Uz8tpY03ZlSr/ueBBncE0ZZtZ5TSLans6t5jeFTR9/vTVA7yPhBja6rouJtxodcP5C
         0s9vN0pgSkE1lJEpAv4ipYew5T9V09dxoLWgXIvqNbjSNmYZrvmzkZJawqhOgNqAW9Cg
         VNi3dhyXVUOhZd+9I4S/5JD6CA7cI8bq3NDSx6x4rrOtOvggq7EUGTloYUaxhONPUAds
         FPYMGqzRkQFNTAW09J2ODC25HI/RvfUBHVfPe4/qTQ/hkzpVTVNuzgu/LqhJ3FI1RojJ
         8mb5/OMgVOVusUSpCUaW1aqIwEyjQHDhXXK/vprf13MbUAP3vQG7hiOSPCIj5vwFflAN
         W1fg==
X-Gm-Message-State: AOAM5338xCEcoowlIvZhQXoZ7mzQsQ+WUBaBay366V5P4Tv8OhrcXB8l
	wqK9n685DxKx/YyxbE0v3wQZKcotr3A0XZ7MPPfpOg==
X-Google-Smtp-Source: ABdhPJz0164kl290h3inHktq1aytaafwEF9iwNp4c7agirWL/rpIyh567JfNXkvHnIe9iRCq3zZWZyUHVHnJxXNA0tg=
X-Received: by 2002:a25:ab2c:: with SMTP id u41mr17819408ybi.133.1605808987125;
 Thu, 19 Nov 2020 10:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20201117212251.33622-1-mert.kirpici@siemens.com>
In-Reply-To: <20201117212251.33622-1-mert.kirpici@siemens.com>
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
Date: Thu, 19 Nov 2020 19:02:56 +0100
Message-ID: <CAP71Wjxc9UN3Q0LSsvVwQTt=fWLen6QysRizAssBH7ft_TsUNg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc/conf.py: add missing import sys
To: Mert Kirpici <smertk@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Mert Kirpici <mert.kirpici@siemens.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2020 at 10:23 PM Mert Kirpici <smertk@gmail.com> wrote:
>
> From: Mert Kirpici <mert.kirpici@siemens.com>
>
> Due to the calls to sys.stderr.write() and sys.exit() in exception
> handling in case of sphinx_rtd_theme not being installed, the
> following exception is raised by Python due to the fact that sys
> module not being imported.
>
> ---
>
> During handling of the above exception, another exception occurred:
>
> Traceback (most recent call last):
>   File "/usr/lib/python3/dist-packages/sphinx/config.py", line 368, in eval_config_file
>     execfile_(filename, namespace)
>   File "/usr/lib/python3/dist-packages/sphinx/util/pycompat.py", line 150, in execfile_
>     exec_(code, _globals)
>   File "/work/doc/conf.py", line 80, in <module>
>     sys.stderr.write("The Sphinx sphinx_rtd_theme HTML theme was not found.\
> NameError: name 'sys' is not defined
>
> ---
>
> Signed-off-by: Mert Kirpici <mert.kirpici@siemens.com>

Nice catch, I could reproduce the issue, and this is a right fix!

Reviewed-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>

> ---
>  doc/conf.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/doc/conf.py b/doc/conf.py
> index 354dff36..fc2ee081 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -14,6 +14,7 @@
>  # import sys
>  # sys.path.insert(0, os.path.abspath('.'))
>
> +import sys
>  import datetime
>
>  current_version = "dev"
> --
> 2.29.2
>
>
> 
>
