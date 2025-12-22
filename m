Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43B0E67482
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:36:51 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78433.1766403406689106130
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 03:36:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QoumEgrn;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-888310b91c5so41000616d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 03:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766403406; x=1767008206; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDoz9zQC+P4cKxpC9385Nh9UkOkMqmJiB0X8wZucklk=;
        b=QoumEgrnbuDjNcgAZdmVkJc1ruCuX7Zg+lBzAE2/gP0G8XI5anJPHwgLwKsxd+Lhvp
         oFb77balMxoym2EJX9Zu1j3cdAbw9LVIuCx91yJQMo980Hu1bm616Kz7vdwmJ0GNBkPn
         EMKzvmZX2FBuLITwmqjAtLBctqXBAaAuFz7/1MBvSmA7LV6RmDUH9R6OIonDhrf9rLgp
         g2N4HA2t+I4vhbubcUpKZKhLR68iYmHn6qNBgjC8SxjIEA89IEFw5nIRXlMXh6PGQcFA
         r4e3LczMC1WfDQZvWQYa6em9ucw22eGmwrvMeTj30SlMVt1GTiZsrWxLxNGcfr620qbl
         6dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766403406; x=1767008206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDoz9zQC+P4cKxpC9385Nh9UkOkMqmJiB0X8wZucklk=;
        b=nWpKJL9N5WVFFpfJei/D9995xAeOGm8K9wozjM86Ls2iTRIKsapoHCxXxYxqbhY7Jt
         JyExIcdVv2rFCP2md87YPCzDyDHXNGaO5kw9Rlq3U5PG9rgYGczFwN4RK2QX8Pkoveit
         wSwWbQEPcGVd50nsDMLcLnkF0ndh01HT/xxhHF6JgyjYp+ydmQS50c3dMjeofyypgJFa
         7/BrqbhqdvBg7mXtNKax+Qmx5cdH85z8EcGi/pj4sVAsycLHk2WKFKRpRHEb/aG7Pkiq
         KRXj2pIJXjwEpjq0xri8I9phnqjOXh7B/2L3NDn7luobEnpWcvcXy6fFysTLYaj5mG4H
         85ng==
X-Gm-Message-State: AOJu0Yw78/rvS4HExYQD+48LbYIVtDA9QHFlCw3CFpTwuMo3taouHFBx
	cxWy1RyxEHAn9MMI4t1xVEfT8Y8K4iIUkS4QZl3n80Un816Qc9OELaPkmM5ENZ8amfZGoJHVQey
	U/2YRw3gHyMAJcurSgsUWoOy47KqycAM=
X-Gm-Gg: AY/fxX4AMJfRhAd9NcAQ4kEKVaJuX3VypnQvSprYRuha4iTZEWy52uz0Yh97gC8frdB
	m01OKKXWmt40G8IvyUyuTznXq3u0yJYmr0QuoEG8HLHoMwnUn63JnZ1EAnALDQfI8KrVNiVEeXd
	spZvBgAM/le+bL5MDGgLmEQ7BUURF4QYy40bvOMLO9U7x1oO6l8xKJyTsuK0TzfO5od2bjqKP1a
	4NqbEAhXRoJOyGIMNnI2ub2UurjN7QeTDsc7fHgz0/df3ZJjENdye/qVWhiYeZMeyPI6w==
X-Google-Smtp-Source: AGHT+IF6b++UzVI1hiEzvT7yo8ZQL4/rH8eFqajInTfJu/7Sx8+gKcR/zLwkX3PyjWELSWEFrNlV55Wh19qLBXiSs9w=
X-Received: by 2002:a05:6214:1c88:b0:888:81bc:93b1 with SMTP id
 6a1803df08f44-88c50adfe75mr229735576d6.12.1766403405627; Mon, 22 Dec 2025
 03:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20251221004750.35128-1-anibal@limonsoftware.com>
In-Reply-To: <20251221004750.35128-1-anibal@limonsoftware.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 22 Dec 2025 12:36:34 +0100
X-Gm-Features: AQt7F2qiud2loBHPvQof5dWhQM4H51tafhsqUsX0DCRUF6oks-L0W8hnuUg9Y60
Message-ID: <CANNYZj9iWkw6xJ1EpA8mRGV8=6kBJ1vYtLXcfsjy2xBVaYGj_Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH][RFC] bitbake-setup: local sources add oe.path.expendvars
To: anibal@limonsoftware.com
Cc: bitbake-devel@lists.openembedded.org, antonin.godard@bootlin.com, 
	richard.purdie@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 11:36:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18637

On Sun, 21 Dec 2025 at 01:48, Anibal Limon via lists.openembedded.org
<anibal=limonsoftware.com@lists.openembedded.org> wrote:
> -            _symlink_local(os.path.expanduser(r_local["path"]), os.path.join(layerdir,repodir))
> +            _symlink_local(os.path.expandvars(os.path.expanduser(r_local["path"])), os.path.join(layerdir,repodir))

What happens if the variable isn't set? This may introduce a usability
problem when users forget to set the needed variable, or are oblivious
to needing to set it, and get cryptic path-related fails.

I'd rather use a -L command line switch to override the default value,
and, if needed, place the environment variable into that:

bitbake-setup init -L openembedded-core $SOME_CUSTOM_PATH/openembedded-core

Alex

