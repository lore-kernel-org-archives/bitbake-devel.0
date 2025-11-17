Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884EACE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 19:19:35 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17986.1763407170873793611
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 11:19:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=m7IU451T;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee2014c228so10718981cf.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 11:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763407170; x=1764011970; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxfcqy4cRKjldyKGgw+A9iQ91k7SAFWcYeQAuDEqfpw=;
        b=m7IU451TqH1UGvqVjRKJG4C23tTTBCuy4kpZD6fhDtCs2mkEJbJ2G3cwBejjXseaNG
         OjW/Wb1Qp36yV1inXoXiAJb4NIF44jFd/UfP0ZT8+t4gdm0VHOW9MDnY4zQs3dQP8Dfi
         WdPUxLvWk1vH6OkGYpDmCE189cpwmwg2Qh1Aqn7+2xw0nbV5crKuhUN/PyG+62on3iwn
         Z5yl54oa/PAy4Scnp7T/d6wBuyKNoydyztpA7IKS5R+Qp5LTepMFjXuTKw7pDTkt+sRu
         aWmYBxqIiFWX/lZz9yWGlv9amQDAQ2Oeb/oiW5v2lDVvHdxHtDmyhG0A+qc8h07xB4O4
         ygMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763407170; x=1764011970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxfcqy4cRKjldyKGgw+A9iQ91k7SAFWcYeQAuDEqfpw=;
        b=WXlTa1+C6T2u/YysjxeTo0IhljwtnDY1gb7PMyCpkkr5swQE1aJDWd4xfqhlrZ7LQc
         r1MUErUrgQDE+8uVSSpXCje/RppPVbdhTEUh2VLifxQ+JgGhnA07KckjaUfErkbv4kUk
         1m90c2/jbjfA0h2mGUAk2IhLQkJxQO6cKM1X0XlpR+eprzHtsrtQ3L1QrwepIv3wjU5V
         yZuZhVjq005uSNyW83EFBvraxQJ1fxLc/xGt5aS60cIXIc+odISF+CxCa7r+zoJ+uwwX
         YID/jJFEmZZ9ogv8z7OybQ7cfBoubkHakA0dxYfbhXrFZOurFdgPYPPz9JI23Nx7VdjG
         zK/w==
X-Forwarded-Encrypted: i=1; AJvYcCWinfuVx0l+r7U4SHEew4IpmpPnojCOXeQQE2jqctBs84vcJ8gfaFcwoVk0JT7NtKAsM+CcFetCr94+ARrf@lists.openembedded.org
X-Gm-Message-State: AOJu0YxzIcuUgE0dLUqc0P0sN5pIpCGulTbrv/YoLaxJhCOXUEvNtXjG
	8WSpDrX/rhyP4zRiBfKKuU1YddyEvOIdZ9tTIjv9JdNGPP+OlxA/ieAIO6m9sWBWkSAxmWthCth
	VzVyczhJ6V+yAAEXDtWYMiAVT68rkUTs=
X-Gm-Gg: ASbGncvEmuBv0aB9FCohjFr0RGuybsWxt7z1n9httdzIRFcY4NWccN44Q8737+hC4wt
	hSzlEcPfjmk0V35vho6AJRLArNXIv33gqxLjQT/J63gORb0Nu/9L20EiytBEmvQZ9ZavGR9AxT1
	UgLAL6h5yUU/3zO5z2WqAHtUpWS44KwWvoamhXfslmV5ZbwaYXYtA+/zbL3ZBZI2ccXS1M8JGtU
	SnYJpLdJiiIq2TtyXD2cHONBqAjxck0UNgaQcBNGLY4lWNYMnnyKCFMEzK58JEus/RGDXnCQ/E1
	PEen
X-Google-Smtp-Source: AGHT+IHE0n8e5EYHW5YtMBTJpXbJ+2SlSevKk32abFIff206dPKGJYE/egXh0r7DATuJVRO98RpCwCoyKMEdm6atZk8=
X-Received: by 2002:a05:622a:1988:b0:4ee:146f:2503 with SMTP id
 d75a77b69052e-4ee146f27edmr97882851cf.3.1763407169892; Mon, 17 Nov 2025
 11:19:29 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
 <1878E0BD2F283F54.1265056@lists.openembedded.org>
In-Reply-To: <1878E0BD2F283F54.1265056@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 20:19:18 +0100
X-Gm-Features: AWmQ_bkRKhBJd7kpDUE_gkC1ee6qpa2B9lFWRPM_blaeCq_JW5gKIfupq0r6vPU
Message-ID: <CANNYZj8L6hZuwxhQSeYt25pSk+bQj2PfXLjM6RuMwbRLkziEOA@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup steps for release
To: alex.kanavin@gmail.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Paul Barker <paul@pbarker.dev>, 
	Ross Burton <ross.burton@arm.com>, reatmon <reatmon@ti.com>, 
	Robert Yang <liezhi.yang@windriver.com>, "antonin.godard" <antonin.godard@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 19:19:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18435

On Mon, 17 Nov 2025 at 20:05, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> So where do we go from here? How can we prevent poky being mentioned
> three times? Should the tool try a short directory name first, and if
> that already exists, try a longer one, and if that's taken, add even
> more pieces, and, as a last resort, a magic number? Honestly, I don't
> have clarity in my head now. Asking the audience!

Another possibility is a new setting, similar to Ryan's patch (which
added a command line option), that sets the format string, or a
'style' (short, medium, full). Defaulting to short (e.g.
'poky-master') but geeks like myself would switch it to full. And if
the directory exists, the tool could try longer and longer styles
until there's something not taken yet.

Alex

