Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26467C44511
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 15:44:13 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16056.1784216648935060594
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jul 2026 08:44:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DyxBOEug;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47362928f65so6140116f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Jul 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784216647; x=1784821447; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hwX2fMUOGls2C7OtRj3RV4HhREgdgXRcfI05PrmLLok=;
        b=DyxBOEugHHh4DMf/shrcN06I7SA4T7I6r85zNq4qjfza/cOxXRSpOwXZSv0/9nT5oA
         mEAixiWYT3sWMtiBl4Ny0jpYhxYbzXODcKmEgW1fiuGLTOydSazbD0vq9NsA2ktrh1xP
         EcuystjQT3ARl9wPeLnqkEQ1JGY6KSgm+ecIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784216647; x=1784821447;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hwX2fMUOGls2C7OtRj3RV4HhREgdgXRcfI05PrmLLok=;
        b=QIck6SgrBpTCsDlm9mowDrBqVdFQIne/TRvL/5gWGDHkROxcew/SS04aNu3KzGmTmD
         JbjnooHi+bCHJzxUS0mK3S2DXqLto0gnGPOPf6O2OTNuXSK0qahF0k7oE5NCKedQyGew
         GPEgwU2TNbP5rBGFkY6N2rL7TrJeSofe9DSs79HdEDQOhTrlsiUtacmw0eu4matAObb9
         EYo+zFI61KA1HTmxKd0vP8t0a+eR7z2XFgauzR27D9C0dBrkSHqN8M6QJm0P+d8slq+9
         VJyPePdFs49KG3qkLKjP6k+mwxEoGK5O3pRi40Twdq6SB+Y9iIEiYYM/xhTaBHaglvzK
         qVMg==
X-Forwarded-Encrypted: i=1; AHgh+RoPEuwMIm9slCjWhgklYCEa/DcgZuYujHjE2fRknYqwcs83Kkfm68nfamSBGsNNKwYGcPqzStLSbbRkiVcH@lists.openembedded.org
X-Gm-Message-State: AOJu0YxhBrTpAQcVofZVpfc8llH79frDbIPin+CCdJIa95NN3BE4/OXd
	1Df9UrB3HDhPTpp/TnJwIBaADnbNQrxwZMItmR27uNlngpVXtkg7TQSzwBgP3kJFPPg=
X-Gm-Gg: AfdE7ckRtSJG4fEh3uYxD886P5T1maFsjGVDlWDEtSzU2PtGEhev4FzgIO9XoWf47je
	gfeu6VGm7iSq7kLtblbhVgH0PDUW3ry9ChsgW/BXr9eF4VMy+gdb7j0ncZZHbZeQzY8XiWMx6kc
	ri8LNj6jzFOblFpNnVqyJwX8Hxi8yXkAfZad7BhgllFqO6EAV4UR3djMx/SDkHrUmU2xHITJQ/f
	AJGfLDfD7LmXHj7wl7qpA2Cn5NgR0+5MHwruA1r1S3+gFKwa3T7n+fBkjorsaqHEUHdP1xKLkvy
	sCZPiBdyQktnQ0wtIPAOkE3iM+aPqyAZor0UwJFzq2b1r3afemIGVfuNsRG/R4Vp21mNnHMPTPH
	i83CV4uoE06o7I5iG3NoyvXSquwgHN2/5dDpCWxddOlEjTqI2xtJOPm/PYKULg2XYnu9RRfs5Yz
	gfmM4l6QJBYTQP9HCe84avnFokO1+eWqUVK0Isn4ZCVPR0tSzHOZZwehGv4uojEDUXJKU=
X-Received: by 2002:a05:6000:2509:b0:47d:eee2:e19f with SMTP id ffacd0b85a97d-47f488920a7mr13314281f8f.33.1784216646976;
        Thu, 16 Jul 2026 08:44:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a03c:6417:d88d:c21a? ([2001:8b0:aba:5f3c:a03c:6417:d88d:c21a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c30a9sm24249829f8f.31.2026.07.16.08.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:44:05 -0700 (PDT)
Message-ID: <a4ad8dcdef504155bebebe81125b68bb66692c2e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH RFC 0/2] bitbake: Add basic landlock
 support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: david.nystrom@est.tech, bitbake-devel@lists.openembedded.org
Date: Thu, 16 Jul 2026 16:44:05 +0100
In-Reply-To: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Jul 2026 15:44:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19839

Hi David,

On Fri, 2026-06-12 at 13:38 +0200, David Nystr=C3=B6m via lists.openembedde=
d.org wrote:
> When current implementation runs in an unprivileged docker container,
> basic networking will be allowed by default in all steps, ignoring the
> network varflags intention.
> Introduce support for landlock blocking of bind and connect, providing
> basic support for blocking TCP.
> UDP is corrently beeing worked on upstream, but not yet supported.
>=20
> Landlock requires PR_SET_NO_NEW_PRIVS to prevent escape,=20
> which is also attempted, this prevents privilege escalation from child.
> devshell and related are already tagged with network varflag and
> can sudo at will.
>=20
> syscall ABI is asm-generic, 5.13+ for all archs except alpha.
> On alpha, we leak 2 fd:s in the childs context before graceful exit,
> which is cleaned up at child termination.
> Don't have an alpha target, so this is not tested, evaluated via=20
> static analysis only.
>=20
> Landlock also provides a future possibility for filesystem
> limitations with the purpose of catching bugs, and preventing
> persistance of supply chain releated payloads. writes to f.ex.=20
> .bashrc and friends.
>=20
> Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
> ---
> David Nystr=C3=B6m (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 utils: Add landlock_restrict_network funct=
ion
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitbake-worker: Call landlock_restrict_net=
work for tasks without network
>=20
> =C2=A0bin/bitbake-worker |=C2=A0 2 ++
> =C2=A0lib/bb/utils.py=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++++++++
> =C2=A02 files changed, 28 insertions(+)

I think this has generally has positive comments, we just need to take
Paul's review comments into account about the magic numbers. Would you
be able to send a version with those tweaks?

Thanks,

Richard

