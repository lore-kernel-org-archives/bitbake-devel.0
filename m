Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D860DD61006
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 11:22:36 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12826.1769685746846893198
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jan 2026 03:22:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HEaw7E4S;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-894703956b8so14335676d6.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 03:22:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769685746; cv=none;
        d=google.com; s=arc-20240605;
        b=Pw1McfXctPBnuL8JUk5eJsKGHrFaZVsc0rbFJDcZfuENH9c0NNEYl0/UwF0DBiOp7m
         +2ZVgFqZLSZ+waadVEomrGL5+JT6C8PYBAqP2waUWTwQBlHAaj9mdsRnavDEzjTagYrk
         U+AL/pZWrLzefGBPxN6z91o5XHecHaRrRlZK8W0k5MstuPp3lysGWlmOTFjBnYzdaGAF
         BJmYRIiW+LVplKJ8d3OJ6R3Qaut7VdTZSy/FplPT/pJJsrS/q4h19WzDFefmxMWZfeLW
         p/bdfbHlLyvEB1PxOJGYC8XzXe/U8Xo7YdcUmBfU1jmTaMRMUur/BAwCV0b+7CpHkY61
         SKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=17CaVxFNtJT7xnsMxHDkWGxSoZB8OwvBOZQwXd/c9n4=;
        fh=XcbtxtzHcvk4seWeZA/utLHYT3PsE8vPt0Jlttp5o9I=;
        b=Az1kOY6gnX190EtyWBpsHw/i7EgVDQeT2KB8ZdSDuczAcNLqy6ly4LEyVCmMCxqRe2
         VBRNmrpa7018MX0F2JDXpdj6eL1MXsj05b62FE7yEEwMCrc0m+3qnoqe2TztzPi9fKjH
         6JXzr/dwnxAApq5OZx+ydeQ4nYJ2BLMwROqU68dZJOqAIU24xQIvQzCfJMUZoYiNx36Q
         eWZoUeGOQKnEq3JTE4e3w6kEaMqM/cVGNkJdUAlikgYTd5LlAfE3B3idEnofKgmCfoJT
         p+i1vOHhtg3q68HhpleeNSGZcCZloD4MZwH97McvuaXFEa6jDEzsc7XDBM/VI/Ap0nRy
         4ddA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769685746; x=1770290546; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=17CaVxFNtJT7xnsMxHDkWGxSoZB8OwvBOZQwXd/c9n4=;
        b=HEaw7E4SomzkLTv1arZNOSgvUn7QFSv3aTWq/A0dzGneoUIcMwOE1NgXP75eWGioIv
         5QNfGStfNKW2GL2IVvBGvLTNo8hQibO6DT+y2yWlEN2WEHHIilY/RDj/5hROWyqCQK/5
         wutsP+m6s/J1a7gledB/0rEseaxRriaxxHJHbs9fK4CXdvsZivReD+hW6I5qOWOMlYC+
         6cBdafQqBOtbUsOgQaZnwubZ5EncuYsvek1d/PofK6k01wLd/NutgMNaQWAC4nelDEca
         E4UujTI7AjcRQ5K42N5r1M+tQSK6FFu+RsRoF5z35jmwo1B1d8G8Ya0dM7hIFw+AkZQz
         pC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769685746; x=1770290546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17CaVxFNtJT7xnsMxHDkWGxSoZB8OwvBOZQwXd/c9n4=;
        b=cHguVJ7fYSmha3Q0GSjg5auAIXdGJhSUByDCA6LrgS3vziXi0EwQ2oWyw4q9XkrXWp
         9ONb/So4pH64wiObyv+z2Oj8A8SuttEi/fTzGSuANJQaKy0EkfFhfA3o9ZKuEImwf3Aw
         Hd5AEppLOF+CtCLr0ojZ+MB9iL2WTKcuQjQJxhw5jfVqH1ncy+2iJ95Qoxh1+B1dtIjh
         ngQpAxEPkdxHTjJlLfXEr1yJY6Wdu9sqRX9q8M7wPqE88C4inD72fEZJujZPbQ7nclFI
         zoi4oiZlTcBVFkRRgbsQKNzNIQ/ga/RP9s/HlrqzeRfluMqNSJJ+LUVUfZzlDzcWiH1m
         3iUw==
X-Gm-Message-State: AOJu0YxuBFtONzhHlC6xhjmu3r5hroCmR0Gz0cO2jGWhozLcd/NUt8s3
	Y27+pVymQzFs+qWTqPmEnRmTgv8vj1iO3M0LEFNLsuIINvzhzPp+HqOSgzjRqntHOIsM4VgXoH0
	Km0/xGGlJ4LfuwzdQBkZTkntqOv4Chbo=
X-Gm-Gg: AZuq6aLaKZm8wfArz5r0W33jWZf8wM7RWEr/BQQoMa7ocKPl92UgGQeSNTPOzV1T13e
	VdHhnowa0259rlVaFtaMHYqXXIY7DIvIGFiolf8aC8DrhEDuRloWPglJMXAvHHZQFuovG44HtjC
	Iaj5iD5HM4Q/OLsn0UaCzQmswlTIaR4iJgAClWG+vQfiLygbSTXxnqyaW3PAUPbyAm+oARbHdXm
	gcrQMBlr6wokRFN9euQFp8u41qU+b1QVZlgwiMYGPL7vo2KVHqpHZ8WjjW9OQRWSt3EH2UBTU/W
	0QB0xeoCnImWVgo+aVdSOsQIr+/udA==
X-Received: by 2002:a05:6214:e8e:b0:890:811c:16d9 with SMTP id
 6a1803df08f44-894cc90974fmr132337336d6.35.1769685745732; Thu, 29 Jan 2026
 03:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20260128193156.2019850-1-anibal@limonsoftware.com>
In-Reply-To: <20260128193156.2019850-1-anibal@limonsoftware.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 29 Jan 2026 12:22:14 +0100
X-Gm-Features: AZwV_Qi089SSGAqQE74A19OzqD2_pXvOVnakHZuSe9V2kEBIIEspvFxhWt5_E3A
Message-ID: <CANNYZj-=7L33g4f2=gDPA9t7qKmo2KD7UH+Ky7eRpH3sgaEPMQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCHv2] bitbake-setup: _has_local_modifications
 fix user case when add/remove/add layer
To: anibal@limonsoftware.com
Cc: bitbake-devel@lists.openembedded.org, alex@linutronix.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 11:22:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18930

On Wed, 28 Jan 2026 at 20:32, Anibal Limon via lists.openembedded.org
<anibal=limonsoftware.com@lists.openembedded.org> wrote:
> +        if not r_name in fixed_revisions['sources']:
> +            logger.warning("""Source {} in {} doesn't have an entry in sources-fixed-revisions.json,
> + Source {} was previously remove from configuration.""".format(r_name, r_path, r_name))
> +            return True

I think what this needs to say is "Source {} is added with path {}.
This path already exists, but it has no entry in a fixed revisions
record. To ensure possible local modifications are not lost, it will
be preserved in a backup directory."

Othewise lgtm.

Alex

