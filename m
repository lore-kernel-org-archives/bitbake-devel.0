Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEEBC021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 15:48:33 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.52922.1740066507058640574
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 07:48:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bfGcwSi3;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd43aa1558so8721826d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 07:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066506; x=1740671306; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aFAnqWgm32VL5BnSPXH10bfXn4lD157tQIgn4wblvRE=;
        b=bfGcwSi31k4mf1rrwsynui0ikGfpa9ki0gt0M/AYD7AqrKx2eMjCyP1hhnKv7OoyF0
         syBePoE7KjAtDvr/LPTzSi89MRUnaQv96BvjlrFoEXQDxSag4GhCDySGLH+VZWcWb4KS
         yUR9ixPzxxGZMRWV04V7niiBNvklstONQUHv7QjN6pmH/khaTqvoaySFm8QsdkyWXZOF
         vgftTKkllW6zmeHYRs9JL0SuySrGBnAKvIjZ6jFC4zD9gKNVIxMqhnQA0o6ZWLoKq1/K
         8SuUK8ED+XnoBO5QnxhiAJwhe2zMukYcrNONH8mfZ/GjY10wnYGwHwLOUpYk5A/vCMOe
         0q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066506; x=1740671306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFAnqWgm32VL5BnSPXH10bfXn4lD157tQIgn4wblvRE=;
        b=VT/qhpbI8arDkQPbJ6kmo8PunEGOfkPvSlmx2swO7K2j7JY9EyERr34+sf58sW7xzV
         kUEt5ltRygVGnWnfDgmrTKbMgTYhF75ghSwowN55AS3RkHHtkjSQRcFe+IAubOFxfZJ/
         Gc3EwzXyF8siu2N6jAfVh8VbsQuFqw4Neb2MbAu4HyebOQa8ramI+kaRiGc5cGs7c2f4
         4Q5IdaaxO2qodZqL0CpbFux+kagrLF2/uKEYUpx4c/ikiLc4wl9AF9xcIF+PonqOrQGC
         xODTC1aeuY0X4tBxvjSaRVC+Qqf5w0DifTfB4oA850vKTNE1kr1FmqdZwdIGOqBZYZXh
         w4lA==
X-Gm-Message-State: AOJu0YxYEzoKZ/q+yL6gurCJkz4IAre2Dbm19KSh+eM9pEL3Q+PfFe0q
	b2651cnhsVypqURhjPS212ryCuSFLpsnbUYxjfhc+ropEZl6V99XEyLeyVEfCyHLkBGWgI1huXK
	1fcavQF1wIYGVcXD3DMYzsypdb3I=
X-Gm-Gg: ASbGncuhXbz2aJpDfj2tkkU4hwKXyfZn/zKx2ijoQpVYlTCiCYHcJynoevaAs8VXVki
	VwWqh54CbFU0CuERTTAPQuoUleQv88bYXgUSBS2EoEndhZU4cf0rTOTKmn+nUD+vgy8pfgqBJvW
	CBEV4c2D6YsYjTXFQ+0mTv7gEHI8sqW7w=
X-Google-Smtp-Source: AGHT+IGpwC65kKAhziVeE0BunNUWYQXORl/5bMTbixIJ5gAAyi8hSAJc/PBK31jlCHDlKlCG70xSggOaGVFphS/Pe2I=
X-Received: by 2002:a05:6214:f6d:b0:6e6:5bd5:f3bb with SMTP id
 6a1803df08f44-6e6a4b44397mr39675116d6.7.1740066506077; Thu, 20 Feb 2025
 07:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20250220143030.12982-1-eric.meyers@arthrex.com> <20250220143030.12982-2-eric.meyers@arthrex.com>
In-Reply-To: <20250220143030.12982-2-eric.meyers@arthrex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 20 Feb 2025 16:48:13 +0100
X-Gm-Features: AWEUYZnVXVY0itrnU4ZjMsfa0ry8qbYNCvbunbHNCXOakk-co5VS7uZa-FQjDV4
Message-ID: <CANNYZj_d1vuPc9M6+6WBnrQ-RRDRArngsDxSi_8ghjeK=pDO4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Eric Meyers <eric.meyers15310@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Chuck Wolber <chuckwolber@gmail.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 15:48:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17258

I'm broadly ok with this (except the question below), but it needs to
be lgtm'd by real npm fetcher users.

Does npmrc contain secrets? Would copying it to some tmpdir put the
secrets at risk?

Alex

On Thu, 20 Feb 2025 at 15:30, Eric Meyers <eric.meyers15310@gmail.com> wrote:
>
> Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
> Cc: Geoff Parker <geoffrey.parker@arthrex.com>
> Cc: Alex Kanavin <alex.kanavin@gmail.com>
> Cc: Chuck Wolber <chuckwolber@gmail.com>
> Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
> ---
>  lib/bb/fetch2/npm.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index c09f05044..23fb5029d 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -107,6 +107,21 @@ class NpmEnvironment(object):
>          """Run npm command in a controlled environment"""
>          with tempfile.TemporaryDirectory() as tmpdir:
>              d = bb.data.createCopy(self.d)
> +
> +            # If an .npmrc file exists in the HOME directory, then use it in the NPM environment
> +            # (along with the user provided configs). Otherwise, leave it blank.
> +            home_npmrc_file = os.path.join(os.environ.get("HOME"), ".npmrc")
> +            tmp_npmrc_file = os.path.join(tmpdir, ".npmrc")
> +            if os.path.exists(home_npmrc_file):
> +                bb.utils.copyfile(home_npmrc_file, tmp_npmrc_file)
> +                # Still need to append the contents of the user config created in __init__
> +                with open(tmp_npmrc_file, 'a') as t:
> +                    with open(self.user_config.name, 'r') as u:
> +                        t.write(u.read())
> +                        t.flush()
> +
> +                self.user_config.name = tmp_npmrc_file
> +
>              d.setVar("PATH", d.getVar("PATH"))  # PATH might contain $HOME - evaluate it before patching
>              d.setVar("HOME", tmpdir)
>

