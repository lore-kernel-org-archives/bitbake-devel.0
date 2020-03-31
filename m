Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web12.8703.1585661114755716522
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2020 06:25:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Nsxbuf4o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id a81so2609732wmf.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2020 06:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=1E9qpVMKWfdaHeMvX0TA6wfou5qRPEJQMtFB1KQrSiQ=;
        b=Nsxbuf4om5lQCX/AnS60A9oSZmTT+kwjxJGh2nXl0P9FZaMnVDhuBlJwaTJ8tjTibj
         RsnrE08tNqHI05IeHTXcHLxkDO9tuRke0UO5PzZk3zxjKwA6FQPTesNktizuHuLd+j2F
         BC915Md6mQr+uQmXRAChWU8XMiCI6KTmDMPVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1E9qpVMKWfdaHeMvX0TA6wfou5qRPEJQMtFB1KQrSiQ=;
        b=YpZEB/4v7wOXyFfPv1HG0W8kVrKRvJdA9HRd57F9Yo5UZnN37FluP/8qkcmXPbTJH5
         9z5tQRCY5cxMbvo3Rr+6l10+wJ1tCtW0G3bp+P0yWLG/ZKFZpg583aR/D3vrr+1lmOjw
         1FEisumQJw6JwwrW/CO73OGiCas8OEARwS+vXGVn5q4sPVssr5f5n8vj52sJdQ80xTQO
         RNcmoJ2btBUs05Pry16+0Mh4vslI+WjjJXLJsYCr+HKDU5+E/LZs5nJ522hHxXQbHaC3
         4eYKoy55f3bOU2+rTaSLg8Hk0qKhzZHUqyNV49ukOKbu88H+2h0xEylhkIc0Fxz6dVav
         5bEA==
X-Gm-Message-State: ANhLgQ3uCg8yNt/No7gsVIeAcJBGtf3vzkf5Nn1SBDJTvofkL/LMgytd
	YLaPs8VSkvkeNeMmbeexl15SmQ==
X-Google-Smtp-Source: ADFU+vvf5B9iIUJfmNM/VDSqrl59eU9KshggHC/c0jAVC9exgk3tmGBsZ93aprI/XRcOmyfzvYTGZw==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr3517634wmj.30.1585661113361;
        Tue, 31 Mar 2020 06:25:13 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id f25sm3893547wml.11.2020.03.31.06.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 06:25:12 -0700 (PDT)
Message-ID: <e0b081d78c3dea3f4cb6b0f549cd66afc49664f3.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Layerindex broken by recent change to bitbake tinfoil
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Konrad Scherer <Konrad.Scherer@windriver.com>, 
	bitbake-devel@lists.openembedded.org, Paul Eggleton <paul@softec.co.nz>
Date: Tue, 31 Mar 2020 14:25:11 +0100
In-Reply-To: <0675cf46-fd67-9b01-4c77-521099191339@windriver.com>
References: <0675cf46-fd67-9b01-4c77-521099191339@windriver.com>
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-03-31 at 08:27 -0400, Konrad Scherer wrote:
> Hello,
> 
> The following commit to bitbake breaks recipe parsing in the
> layerindex:
> 
> commit f2341dc46b6abfc08a4d01c7abdd3d4630577999
> Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> Date:   Mon Mar 23 12:30:04 2020 +0000
> 
>      tinfoil: Drop parse_recipe_file custom datastore support
> 
> The layerindex uses the tinfoil.parse_recipe_file call to build its
> database:
> 
> https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/tree/layerindex/update_layer.py#n105
> 
> now fails with the following error message:
> 
> parse_recipe_file() got an unexpected keyword argument 'config_data'
> 
> When I remove the config_data argument from the layerindex code the
> parsing continues, but I don't 
> know either code base well enough to determine if this is the correct
> solution. How best to resolve 
> this problem?

Adding Paul to this conversation.

From my reading of the code, config_data comes from config_data_copy
and is most unmodified. The only place it is modified is in
update_distro_conf_file() which does:

d = utils.parse_conf(path, d)

which amounts to calling bb.parse.handler() on it.

Looking at the code, I'm not sure its intentional that those changes
are preserved in config_data_copy.

Paul: Should those distro changes persist in config_data_copy? 

If not, the fix is easy and we just remove the parameter. If wanted,
that is harder.

Cheers,

Richard



