Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C519E9A03B
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 11:13:54 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11364.1771499633489912444
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Feb 2026 03:13:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MP7pdAJR;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6f21c2d81so75923385a.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 03:13:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771499632; cv=none;
        d=google.com; s=arc-20240605;
        b=D8ob6Rc9BBLCTjweJ1pP7m1jG2OlDjvuhJp2mJ7XqR/JTYTOHrwV3LF9QwP7DEyUxX
         vyS1IdA6sA6tPfUNbQcYiv+N4CORo1FQ559Ir+oiJqzZ+7TFBIO4whX+OFdiQezmLAvA
         rJCwGBJs1LGCj5prSn1q0nZBYGN3vNmiWsai/xMB3Mrn0MFkjKBHHkJMaWSFPVnMFNJe
         Fgme3cE5/DDWhalU+zN7BjEXwH/wqKfiXb7kiCGg3uIobe5gMFvW9uquuwPxd7qrWCpR
         nDj5qHcT1mPHLdFdD3lZEImlAuVBa3t8Yw88pYYizHFgIwOuvtdjdm1hskv73a/boDOs
         Fymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AME47bsVi/m+/QQlB2Kf3qAHcEv5BZ7SpKTPsnot6NE=;
        fh=UJkoOGbn+U5q9XkTPsz9HbukLwUOOXfVEaqD2z76Yx4=;
        b=NwHhwwPyiqobb1comtQWmIFUYat9iNQVyTdA63ESo9haAMDsf5lNQTgdbMcMR9r5Y7
         vUKuuAwwN5VZjgojOxWdBwnhbUIqI/lOfCsBFOYr6Ls0D/E+azLDKdlIiiEMdajJnAxG
         3AK2uNprm7TSj2uHN3priOlGjbGyH4mSR8DAYYwRxZYkEPxrHPhDzW/qkVBCFe/ynLCF
         8mQgRtMrhQvvgC0LHfZG7SPdgS7BOd3pAkHkpykQjihJPUHKlPofX+GiIMT+OkoA8FtV
         7LixLjqx7Yrwisxb4d7ZFIO3PsGX/GdGPZJOWXDpJBQSgthcSfp3iFtyZnqGHHZgvLnF
         26KQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771499632; x=1772104432; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AME47bsVi/m+/QQlB2Kf3qAHcEv5BZ7SpKTPsnot6NE=;
        b=MP7pdAJRNeEZXz4tNVfzSlou76u/H6eZugPy4JCS8vbWd6luEpR4nhU7VboMG2Nct6
         t1Np2o5XUs1W7a4gkz32mEyT6O4eRk3vPn5oLSLKFWHQ24Uj+i8OYZq6QlrsyqE81AIS
         kdiCXVhm8AB49VrU8FpmYm01l4UL01lWCuleXU8adTHpZur3em+ZgxR/ArK5EaYh9CE9
         fD4ClDJP1fXDHbo3oHS9Xn+dS+ug5KKwJXYABdP5DSM3gvMBVwhmlq+7kRzJcchaiAUQ
         peeqWB5gGbEPl5sxFnWSrOV5o+rl08pZ+eiwVKq/NYJkUgAOs8k1T0+dQcZQg2YdMKRf
         RL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771499632; x=1772104432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AME47bsVi/m+/QQlB2Kf3qAHcEv5BZ7SpKTPsnot6NE=;
        b=knbd/nXTvx3Scd2K1zJLx06KZT/IdAUNL+3sKQdeNoSMzEc50XPPpxgsI+1ycaIx8t
         L5rdRt1fCVxo815j7+IiYfY0b0GkARfT9SxL4kQ0wx7hWBQBgRUYsXgKfgjGt/jqQstb
         UZxmHvhQA2oxUM4E1rs5My7qwdqiibJ9yl1ccny6A7cb87yRHzNUmRlog668pDxAh87R
         ihWVQYVxSbloYNPdIhgk0t/ZBkdzgAWdQED+VYSz4rIPNjK/Mv9fQ6KiPtmb2QaHX61E
         z26zvxNHq9YEvXWsVTu4dwA11XP0vzSAfdEqwJ0YneF5l6n2Ddl4WvO1V27rTa1ME9sN
         w0GQ==
X-Gm-Message-State: AOJu0YwDdFEujrCINuGWzKUBnIWwLAG18scyX5zLCzYLFheOJ4fDSix9
	m8n7Tj8YsLW0DefDeryHmsYDMWH6nJvc+8nBNfbPHJ94KibFBiIUqHbJclo1HymT2oXGmBbGL0F
	hPslQplqdyF+Pw5Ydk9vq+pnBmvk3Fb8=
X-Gm-Gg: AZuq6aLpnqsAd2Jn7zqu9NjkOASYhMntocOFJcj9nX2IfLccoFO9zkFHYoUhkXP5cit
	f91BsneCBkoHgHqm/Bin5VI2jHUxlYQnnrfBK2L/G7CsSbQ0/w3zoyfKvuAKs1kgjHhqKg6r6Pn
	PQMzdRyBFKv73nAgzVc6OhP449PUar4zSeQrG0scSWIJmzg+2/j465oS0wvfSsj22U6hWUIMLcK
	C/aN3j0XsMye1kgiE3ph+y53tp4BTMJaF9GorNtG3+xhX+wnLGo3OgmUgh5BiIuyuysD33LGMvz
	sai/+w0I3M0TXMh6sp2Y3tJS7BEgWOD+gdz8kjNeEQ==
X-Received: by 2002:a05:620a:45a3:b0:8c6:e2a5:9715 with SMTP id
 af79cd13be357-8cb740a5209mr567412785a.55.1771499632398; Thu, 19 Feb 2026
 03:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
 <20260218-improve-bbsetup-readability-v2-3-351584e5df9c@bootlin.com>
 <DGI6Z0US5NPC.6Y8DAVVEYWRG@bootlin.com> <CANNYZj9grDk3dYjGARxhyca6a++GtHYaSKB0ouxpaoX03NWt+Q@mail.gmail.com>
 <DGIV1GKTYP9C.1OMEZARTNTX1U@bootlin.com>
In-Reply-To: <DGIV1GKTYP9C.1OMEZARTNTX1U@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 19 Feb 2026 12:13:41 +0100
X-Gm-Features: AaiRm50OZ2T3AdyHA1rvHmjYkiY8CFE3HItXZC0tphkfQZFPem9z1nE3yBYUWUk
Message-ID: <CANNYZj8qG7NJHmMOLmUvPXM_=mHahRCtZ6uX1NWM7rdjxxON7A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 3/4] bitbake-setup: print colored diffs
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 11:13:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19067

On Thu, 19 Feb 2026 at 11:18, Antonin Godard <antonin.godard@bootlin.com> wrote:
> Not sure I follow.
>
> def color_enabled() -> bool:
>     return logger.handlers[0].formatter.color_enabled
>
> IMO this is better than the previous version which did:
>
> global BBSETUP_COLOR
> if args.color == 'always' or (args.color == 'auto' and sys.stdout.isatty() and os.environ.get('NO_COLOR', '') == ''):
>     BBSETUP_COLOR = True
>
> That logic is already present in the logger object, in msg.py, when creating the
> logger:
>
> if color == 'always' or (color == 'auto' and output.isatty() and os.environ.get('NO_COLOR', '') == ''):
>     format.enable_color()
>
> The proposal here was to get rid of BBSETUP_COLOR entirely and avoid
> duplication. Not sure how this is *way* over-engineered, I'd rather see it as a
> simplification

Apologies, I started writing emails before putting enough coffee in my
bloodstream and got everyone confused.

What I mean is that run_git_diff() ended up being too complex, because
it aims to cover all possible use cases of getting a diff. I know I
had asked for that :) but I wonder if instead of that whole new
function, we could simply add:

def get_color_param():
    return "--color={}".format("always" if color_enabled() else "never")

and then tweak all existing invocations of 'diff' and 'git diff', e.g.:

-        bb.process.run('diff -uNr {} {}'.format(file1, file2))
+        bb.process.run('diff {} -uNr {} {}'.format(get_color_param(),
file1, file2))

Would be a much simpler change, with the same end result.

Alex

