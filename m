Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F39C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 19:44:29 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42504.1782503063513174497
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2026 12:44:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=W3C+02tl;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9157ec935c5so201377285a.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 12:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782503062; cv=none;
        d=google.com; s=arc-20260327;
        b=eskGQA8JPGv6dH1sTXedeb0o+rS4DOrxv6RjLbjVBELuXgq3vhfd/MmbLsjeCGTqtX
         Rdx4Yu1MkS/iivN+3eB7HyzzGZFI4Ham+a6p/nF6CPXcYcREA9er5vbBDhzzmW5TkxYI
         Gn36jaiiW8SzpqD//smIEYvtYm38SPG/gJoD2kdASx9FmIcCFcwy3f5jlfK0qyIdpUGY
         bp30j4qKLG3PGQTWIO0kIO/mS3BD1FNzlnVNTiWa2iXj7Ci/rxTfVLqo8HmaMe5rIPeO
         XqyHimHAme8cmmpF8w8zS9gl+qi4KWMsd/P5M8XFnzAC/gJtgA3tGzAGy/hWtASWASfl
         pPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ywVU+4j6hYN2EPv7SvGuxQ5tx6PJ/mLOd6PObNbCZMc=;
        fh=1sPeGJstHoXKVbb5/jKcge0GMtYJBQA5lpzd8iKNszQ=;
        b=fDwWXWsNl2EUeECEikH1OKPNnXLdJQzmELmK0cTahN9Mw/UMuBMQCGLS2cgjNcYV1I
         dfdyK/zGoISrP/xmdpkykQRTGXJE00MnUxKNAcJZ5MWN7S3mHur4WSXRJ5dAHKNVhw8f
         O4zdsFyztR5Zcd4hKTZi8jgDItMfb86MUJS6YTbXLRicYw1xiFiL2plxaeZ4S5tnd5XM
         OQibHysfhVMm1o6+QPI1e1MzRuQkzYpoOkKA21JKUOleCy3aC2+EUnSrZ9pPv3GLCWAq
         JcBz197nTRtdOsN940royZWg8dnlaVtmJPfX8tBncbbH0fU2tZ4gRxycGdxOSCop7r1H
         beUQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782503062; x=1783107862; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ywVU+4j6hYN2EPv7SvGuxQ5tx6PJ/mLOd6PObNbCZMc=;
        b=W3C+02tlApKxTNA+xHp4t/PmBzYtF/0nM2BGyqa+27J94evXduOZ7KmkuE782Pj4XC
         b1qX3/A0ZZdVO2I7JsrI9YRvNZ22Zl6FqdsBrL/pGugzLXUAHTBuH1BFDKlMkgLKZte7
         2teL3z6gm5+NAozGYLA1wh3hV2h7cRPShqf5Oko48uh58hO2tuy9d9QxtoVM4SSkz9tL
         4KMsFb89mf5u+rTUPSLbgDacvVKQWYh6vkdkjbq2J00uA/TTgepwrvfY5/sAub3FVxuZ
         f90sNhoPluEUArQlCcz+WJsir+0OTjqgNZCFK7ucL3w6jUt/LgFFo4VAst23aNFNkQ4T
         reaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782503062; x=1783107862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywVU+4j6hYN2EPv7SvGuxQ5tx6PJ/mLOd6PObNbCZMc=;
        b=Gp8ZAiK5um8w48OzqFNz6YT+RvfIu4t+kj7HR6ermyXAM+OyKKnUJHR4hIgnhsKkGB
         uT+AFQUpkk8YyT+aS4p2bRwZSDSCRFKzHZUYqAEb5+Qd46wxx9vk4rgNa5ejtCd6QrrA
         8MTYb56nSig55ahn4eUb35ANsghgU+36tpVRsNMYd8U1lymv69yLW6uZPHtpqtKLb7ip
         pvqZz35wtHZy584OPqea5V3V9K7NR0AovPHPmbkxF5G0sbVFdDX/uSBAY5oAXmcj8lvu
         ukZV0BGcCQ7xPdWxZ5mAPuqmQTfhNBki5gUecqmB4hGo6XVyLU0dATWV10Xf6hbdUApU
         cFeQ==
X-Gm-Message-State: AOJu0YwqoCVnBjrSmkdDf+4dnmzxfhyaK18WqPDBImnVt/+WfuOy7Sg0
	qpOuiBvIgTVPMSiU3auHnkpjWnfW/RXTcCguSKDfRJ8KlQ4/uR8/IN9q4UCZEt44AGxkNlwalcU
	R2NrVw5uDFX4gH0U2zqfBzonceYhnUuM=
X-Gm-Gg: AfdE7ckoowOuakR9hPeZCuKvr9mkxcjqH4Fsm/F1Jv27v3m4r4jsHgJ2g4xBs3v1lnA
	oY58KWb9d3F6pvcGeUFkya9jxED3rnPwCduv44wo08E5bZJXd5n8ikBqnBg6EijxpeEHMoFjcFU
	xlKsxLfQoEE90BNwu24CCTGBKtExoeibbfenE32ai7tn8vhtDe6ZWOTxlLTcWKeFtQgm9cD0pmS
	JAIN/deTK8kUXbCIGOgU+9s9RWUZ9e4GlWYIo8qFqTr8AAeqA5vjK6HkUMPr1TEU0K6uwvTng==
X-Received: by 2002:a05:620a:7119:b0:92b:6805:9189 with SMTP id
 af79cd13be357-92b68059702mr216142385a.65.1782503062487; Fri, 26 Jun 2026
 12:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech> <20260626192330.50237-1-jaipaul.cheernam@est.tech>
In-Reply-To: <20260626192330.50237-1-jaipaul.cheernam@est.tech>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 26 Jun 2026 21:44:11 +0200
X-Gm-Features: AVVi8CeiYmehJOSUHi7FnysOvaALjhVQcaL7C17bqYC0hyiBSd2_TPvjoIQI71o
Message-ID: <CANNYZj9LDDS525+=3Hp-5SZ7LWwBK6PqcR=jQVaWSzWcE81Q0A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-setup: use bb.fetch for
 buildtools installer download
To: jaipaul.cheernam@est.tech
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 19:44:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19796

On Fri, 26 Jun 2026 at 21:23, Jaipaul Cheernam via
lists.openembedded.org
<jaipaul.cheernam=est.tech@lists.openembedded.org> wrote:
> +        # Per-configuration takes precedence over top-level
> +        buildtools_config = upstream_config.get('bitbake-config', {}).get('install-buildtools', {})
> +        if not buildtools_config:
> +            buildtools_config = upstream_config.get('data', {}).get(
> +                'bitbake-setup', {}).get('install-buildtools', {})

This wasn't quite the idea. I wanted to make per-configuration the
only place to specify custom buildtools, so no top level support at
all.

> +    # Unpack into a working directory (avoid touching DL_DIR directly)
> +    import tempfile
> +    unpack_base = os.path.join(args.setup_dir, 'buildtools-downloads')
> +    os.makedirs(unpack_base, exist_ok=True)
> +    unpackdir = tempfile.mkdtemp(dir=unpack_base)
> +    fetcher.unpack(unpackdir)

This should be using the same location as default buildtools, e.g.
fecher.unpack(buildtools_download_dir). So it's consistent, if someone
is expecting to find the buildtools archive there.

Alex

