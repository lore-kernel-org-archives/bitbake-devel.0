Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B887BC636FB
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:08 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.8076.1650463901359078510
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 07:11:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DNwJybKS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id
 n126-20020a1c2784000000b0038e8af3e788so1317507wmn.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=RM99cag41E0uHqore7HdxdvCswyjyzktyl+vDPBnWiw=;
        b=DNwJybKSV43bb706+bjmEdUh2hjIba4Hoj9kqeHPPhvRE0WY2II7DU/4/Kx1cGyq9d
         60CV0XPGAoxBq2SkujK+OOOzuyU8hkVLoaHNzyV5SDOPjg/yy/wpPFON2Vx/wHJr9R13
         Nn+Mb+DxQqemMcJDnpZkwOMxR4ayUrTKZyYaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RM99cag41E0uHqore7HdxdvCswyjyzktyl+vDPBnWiw=;
        b=7f30eNa3xIaqCP2jsLRYCXKLWNCWxJjbEmdh6+Ludorsqsb2G3f1fregSj1xAMcrFn
         Z+eEb8YoQNE+zjLyfZ6oHmpUKN/MKRTl5hqjR64gGNhaQqSBf2lsAczcGkEA6ZM45/P8
         qBmg+0bZBLk/dQQsk/nAnAvGh5xyeijIDgJpxBXr8Iya3Eg9G0ryACC8Z+czCBAR74KA
         hAz22yfUYyl4qD9PJrvCsdPqdWwnStiCd7fMGhKL6AaTztx66wqTqi6DBPoQhfDmME3f
         xushsq027+GymlwbLyr+zdLhC+OINrgUWhoHi9TXVJDMXOrAWlDM4iwpWbSMZvOC7iDG
         VUKg==
X-Gm-Message-State: AOAM533V8Jkb/mvnxnLcWKGjOzg/IgIvLUjBjGVLRI1SjZlH4bMNrWY6
	iiO9yI4Oa2ZjStiiiuGc8UePRQ==
X-Google-Smtp-Source: 
 ABdhPJyW8a7ecT5AXwPA4h6QzavAezrXHVpmm9YKOXuyS/rAexirMDvKh4DldpuEz+pppj7pA4oFrQ==
X-Received: by 2002:a7b:ce11:0:b0:38e:c257:4c76 with SMTP id
 m17-20020a7bce11000000b0038ec2574c76mr3865455wmc.151.1650463899622;
        Wed, 20 Apr 2022 07:11:39 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9745:8b8f:81da:af07?
 ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 r3-20020a5d6c63000000b0020a94e82a3dsm8017625wrz.64.2022.04.20.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:11:39 -0700 (PDT)
Message-ID: 
 <9b14b32e88ecbe01e179e817d76d9de0e21018fc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/ssh.py: Fix url code for +
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Wed, 20 Apr 2022 15:11:35 +0100
In-Reply-To: <20220419174243.44519-1-liezhi.yang@windriver.com>
References: <20220419174243.44519-1-liezhi.yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13654

On Tue, 2022-04-19 at 10:42 -0700, Robert Yang wrote:
> Fixed when fetch from PREMIRRORS via ssh:
> $ bitbake bonnie++ libsigc++-2.0 -cfetch
> 
> scp: /paht/to/downloads/libsigc%2B%2B-2.10.7.tar.xz: No such file or directory
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  lib/bb/fetch2/ssh.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
> index 484453088f..2836d7c884 100644
> --- a/lib/bb/fetch2/ssh.py
> +++ b/lib/bb/fetch2/ssh.py
> @@ -70,6 +70,7 @@ class SSH(FetchMethod):
>                  "git:// prefix with protocol=ssh", urldata.url)
>          m = __pattern__.match(urldata.url)
>          path = m.group('path')
> +        path = path.replace("%3A", ":").replace("%2B", "+")
>          host = m.group('host')
>          urldata.localpath = os.path.join(d.getVar('DL_DIR'),
>                  os.path.basename(os.path.normpath(path)))
> @@ -99,7 +100,7 @@ class SSH(FetchMethod):
>  
>          if path[0] != '~':
>              path = '/%s' % path
> -        path = path.replace("%3A", ":")
> +        path = path.replace("%3A", ":").replace("%2B", "+")
>  
>          fr += ':%s' % path
>  
> @@ -139,7 +140,7 @@ class SSH(FetchMethod):
>  
>          if path[0] != '~':
>              path = '/%s' % path
> -        path = path.replace("%3A", ":")
> +        path = path.replace("%3A", ":").replace("%2B", "+")
>  
>          cmd = 'ssh -o BatchMode=true %s %s [ -f %s ]' % (
>              portarg,

Do we need to be doing some kind of url decode on this?

Cheers,

Richard


