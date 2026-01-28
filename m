Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384DCD2FEDA
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:57:53 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13759.1769608671294041696
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 05:57:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bVceYw2X;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8947ddce09fso63123616d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 05:57:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769608670; cv=none;
        d=google.com; s=arc-20240605;
        b=Rr1oJEquh9okegOTaKxaZj7H2pe8aD6K5s1+U2Hl205+teT9zfsRaR2jLKizjDy+1O
         sDK5kFkIb+rDEpB9gCXzZwjBmgdTzbXN1+4dbXkcD1xh1vdH08pynQUxjgP8Q0ab26XR
         TQ/s6ztSE/aP7L5OCXSA5ja5BadLj0aJmwy4AZDRl0vCRu2c2jfpzjUsvfLtbids3YYL
         2cHv90k3C7FuhT1tVi+CUJ8FRIdaPEasFsHW4XZKkNIS1npPT5xdL5DwwIltUiO30G3k
         sQfOc6vOjJU/FAbDGQPUWh9CZNRtAUgDjZ6F3LElZHHAM1n+aVNUzdpgCwXrojX2p+Xc
         0GwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a+UeJHSz/2iZTmnItKb280zu3yC4iM5tT8jpjhKLVjo=;
        fh=YeVbJkliH5eDBh1Er8S35T+UocMXyM0bEWhqLK1eJ4o=;
        b=ghJVslRAzSlvVr1KlxFXKjak88ssnn+xK5GDQxEhw+iPHQd23M0PG5GG2w28GMqdnE
         VclPa2f8t0x5g9iR9vUycVXsNE3CmObdj5HA6I+x71am/o5+XGzAyPU2B8BTBOLpdlPO
         wkS1Ro2AQWWVRA+uTkczXViYq0ftlLRLGGdo6RWzlQ9FO1gBTFaweAp9y6aBVK2+LAd7
         GESMCbBHQFfqQ1dDG0/TjsnzH0Pw95uMLkgYg5CkHY4lkH32f98ZTovdQF+ihRmetpBQ
         bJwI+EsaOBw7WVyKCGwZK7HeZRgoKfnqntNHmiDxY4PYaiTMT0Lrz8D0RF/EDIEnmgfD
         K3uA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769608670; x=1770213470; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a+UeJHSz/2iZTmnItKb280zu3yC4iM5tT8jpjhKLVjo=;
        b=bVceYw2XQaOJ8EmbuRmu2iWBsqiB9pQa6OK7lFYmxo2zPn+qOZoN9psPvZxmal6MPP
         9nYnlW02nb4NYTN4zmPaJDj+3icQbGGlZcho4tG3KjFPDzrbDGmJf+uAM+TS+R//V793
         NTWIqPteC0qwz46v60Dx6BHqiKX9i/+qj9u7fL4UCNmqTneS0Q0hQmKu3UYA3q3QBo24
         dMRolU8LCCzBrPZLdS8mieKTiWMw5aeVuAy7/kuauP4cockbyFpw0NQvcFTVclbdT8Jw
         WnoQbPi/9o5H2RC9xqTv7FRYSY/gYKZMUkC+aYD8MusdAdP+yOBvrMOYaY8eE2aEUMxt
         PWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769608670; x=1770213470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+UeJHSz/2iZTmnItKb280zu3yC4iM5tT8jpjhKLVjo=;
        b=eolU20Pm59B+hhqLdGZw/WV64E3S3VQzyDoKufEiV+aBSNUWfA7nSJiZ1fNP7DhzRv
         FYywLWAkV9BOX4RsPDK7AZAmCPRG13GZ4+KIDCB/wmZFjlwCLiMO0s9E+IDBkEI/2xGI
         eFamdOWdnYRLwYeyUH63Ggti67IYg9J00OP7Q56zQRMostXL+TJamS0N+HNPP7xc4CVO
         PG1Ccj7Yzt4kmAsCejCvepAMANBLmpURmH/Nw72EWHqIkNwJnZJVxokkvELe24x+AlNZ
         CvhMAjde2UIote27+EZTvI8mheycqCvB+NjJePyxQPS8rOL+qdqh54wkL0VZn5gneODs
         mqYA==
X-Gm-Message-State: AOJu0YzbeeCD5192M62kG8HjhGaxFE4lyONK5gN/c2XjGJVpw/Z4/otH
	fWfOwlwivNLGMvQgBrj/CW1DRHwZItubNoTpSqi/AhVaUkPbC79iO7hyU5PJwFD2gf+3vC5C2iT
	fjCXrgbf5eSiR/oqn/IdJlLkyxKJgiqFdjw==
X-Gm-Gg: AZuq6aIDVwsMpVnuors5xrx8ZNfHkCXH8srzLVaSLr1k54divLKUwmOzIaY+MFOkP5b
	BGsL92BvXf+8Sns0fXAuJBxjQu71mFYmm+wQMG2H4oTdyuT66aVIlaUJhYbVEGvF10+R1TUtEjS
	UqhsSNa/A9kTcLeav3bZlHSuxoHcuvE24IOq3H4GVmZqdI7Jrh5n8XMBtsG6qSFfdEmr8HP3CDa
	Yvlbx+CdTgqG2DbUOiXrsxI0cUZdI9EDyCOAc+IFOHcWAJIPkPQqyVu0X25eaQxBtE53LJxX0e9
	qN5AuCY3hyYIlAaC7MkWxvgkWIl6NDrLuOB2s+o5
X-Received: by 2002:ad4:5de1:0:b0:880:2a49:7047 with SMTP id
 6a1803df08f44-894cc8c9644mr76315956d6.35.1769608670079; Wed, 28 Jan 2026
 05:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
 <20260127160508.3392732-8-rob.woolley@windriver.com> <CANNYZj9+7rLoDbtyujAu1S=WQE6Hd2eBRAo6Evy8osHvF7ww+w@mail.gmail.com>
 <DM8PR11MB56552B52B2ABE9C43DC32AA2E191A@DM8PR11MB5655.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB56552B52B2ABE9C43DC32AA2E191A@DM8PR11MB5655.namprd11.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Jan 2026 14:57:38 +0100
X-Gm-Features: AZwV_QhbZeQutNXQcc5XuMPM_IAZOYYyzUIoRsDROY4htJEy7i8txbdlWZt4f9Q
Message-ID: <CANNYZj-57StPZ8ehtdjWe=FrG8FkbjK1MeBHk1x_HkeoPzOgWw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 07/10] bitbake-setup: Remove unused
 stdout variable
To: "Woolley, Rob" <Rob.Woolley@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 13:57:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18915

On Wed, 28 Jan 2026 at 14:21, Woolley, Rob <Rob.Woolley@windriver.com> wrote:
> That's cool.  We can drop the patch.
>
> I checked upstream and don't see the line you mentioned on the master branch:         https://github.com/openembedded/bitbake/blob/master/bin%2Fbitbake-setup#L583
>
> Should I be looking at a development repo or -next branch?  I want to make sure to rebase any future patches against that.

Ah, I was looking at my own outdated code. The patch is okay.

Alex

