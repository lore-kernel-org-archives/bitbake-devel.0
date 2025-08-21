Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79937CA0EF8
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 14:18:52 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
 by mx.groups.io with SMTP id smtpd.web11.10861.1755785930048012392
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Aug 2025 07:18:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eV+OTS54;
 spf=pass (domain: gmail.com, ip: 209.85.219.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e95026b33eeso1126902276.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785929; x=1756390729; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PxogCEI9LYls41QbmgB1tQkre3VejkTD4UQ099w9mwY=;
        b=eV+OTS54THJXPVpt14EpswMR8UKSCfT7OYmTRYTxrCqF/mArz9QCSSkYwsuCJsziVV
         8v4ZMQjOoYVkVbpwTC6ndukrQo68RNDQnGdhTs7wyALjFXjXR+PcrzRnftNRJJrSKxkp
         w6KyCTfWQI8l3z7e45Ts985h+JxznOwwux0HUoZAhfPbtEWgNzZTkWfBR9rqWptQ/bcU
         oXFoCelYGmuxxiKcA+zQ/f0iknB5Px6ULBSh8YByzcM9PKhazMlhmvBK4hTf6qHroHOr
         wPGXCm19zpe+XfYr/GhqpFwCy/vrSZY1f0Q0yTeivsLJ0g+REt4if5djKBFzrM6WCJO8
         m/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785929; x=1756390729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxogCEI9LYls41QbmgB1tQkre3VejkTD4UQ099w9mwY=;
        b=PvatbiC4BY0Pp1Pl1bq5y8DBXJtC9aY4WWpeSGa64Y00ccvsHquUEFGDEPRwY08QB1
         LYgVt4JORC/2JCqa3oogUA5WkUtnfAobGMaNY6gELqdcJe2blKiQauXJWYzscN1daEWj
         /KqWoG3hCyW8zEvlT+T9/v9HeBn8bRgiheLMpKVkN4Un40DX4WZdW7ji5YAOXyWTfzGc
         SyLf2+ie4Aom+Hin5NeT3C7JPBOBzj8ssBFKsB9wmyOiroJIxfRX1BE3/ij0dO63h55z
         edrcM5U7xuN8tsumSsl4NxY4qE0Aynjts7CrdfW6rYoQFhRuEKpLPyvyNqlVTfMvfo+5
         ochQ==
X-Gm-Message-State: AOJu0YzlMEFTDQqoGfxayIy0a/MWdxu910aBpilXj3LDPBMa6ECvPbZb
	M71S9lgqDLBWoTOFvIu6qthwdTlyrP62cNdPfZ0gkmRuSO9yKLh1vLygSygC88XopYhpxDSLL2j
	0Y0PhqyXKgAFVGU4noi5V33OSIeSmgMU=
X-Gm-Gg: ASbGncsqfYVQFCI7pAD7R4M88n5Zzu5NsjwkcLkXexqhwVhtZbZ7rSgDTC0MedZqb8O
	M7RCqMm9qzfzLpQA3OUa53EaseizHh7Q/F2Nt/VyxSmhclMZD/FbQEg2FrItSM5SI/jgaE33AwE
	KXG29db6iCqRof3jHlwCKYC/pGqMHsp9xydDXA1o1SVevgWtVLAmJXyUpzaZ+ANPw3xUdmw+JRQ
	KCIAbmqa+pF7/PGTDtQrQQ0+FM4ihTVmXslFaVBIn8+nPO9brNQ
X-Google-Smtp-Source: AGHT+IEnP4qBF4IWcJjuNKaC9TxIW9pdd9lNv42sfDvaLwi7SKcWqyssC7P4TFVZd8hqCKRzyy1PrFIAgx3umNYAjzM=
X-Received: by 2002:a25:abe5:0:b0:e94:fbb5:715 with SMTP id
 3f1490d57ef6-e950cc536d0mr2193394276.10.1755785929032; Thu, 21 Aug 2025
 07:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250821130715.1904574-1-alex.kanavin@gmail.com> <9cfa7c31-cbbc-43a3-a65b-fcb9984c6757@gmail.com>
In-Reply-To: <9cfa7c31-cbbc-43a3-a65b-fcb9984c6757@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 21 Aug 2025 16:18:36 +0200
X-Gm-Features: Ac12FXxhwTeMUVxlHaJAyiA6lV6xhkqnD0qppFFCUDpL_KWwgkpO1j5ULeYeoTo
Message-ID: <CANNYZj_WM_6L40=hF6VoQ52TJKS6fWwjayBCjGPuvmbz=T-i=A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial implementation
To: Gyorgy Sarvari <skandigraun@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 14:18:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17907

On Thu, 21 Aug 2025 at 16:08, Gyorgy Sarvari <skandigraun@gmail.com> wrote:

> > +    bb.process.run("git -C {} init -b main".format(confdir))
> > +    bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".format(confdir))
>
> Possible bug: This throws an error if git email and name are not
> configured ("Author identity unknown"). I tried "bitbake-setup init" in
> a docker image, where I use git with untouched config. But when I ran
> the same command right away once again, it succeeded, saying that it was
> already initialized

Yes. bitbake-setup assumes that 'git init' and 'git commit' work, as
it maintains a local history of configuration revisions with it. Can
you look into how this can be better handled?

Alex

