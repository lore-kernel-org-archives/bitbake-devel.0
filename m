Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C82C61DB9
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 13:10:45 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21525.1787663443967052462
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 06:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=2kcCeX1W;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4998590d392so20263165e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1787663442; x=1788268242; darn=lists.openembedded.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YrPGWiNMaIPnwUhxNZ2nMH7jlrH6bqNYgGBa135H7ts=;
        b=2kcCeX1W99VA5US+92zD/T2+gYaJ6oRR/bW8aEHP11CQS1uJw/8Qq05uQnok3hDDLl
         79N2psrMtKdRLa5/OqHcdTALHQEEoVMTadwejmJw8ommlVOxxk58fWLD5yG+689V8oZu
         8aQ2REYO5Ga3AXBh2TldVshMk43xeqb8u9+mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663442; x=1788268242;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrPGWiNMaIPnwUhxNZ2nMH7jlrH6bqNYgGBa135H7ts=;
        b=cUuRlgzQ6rGjFAmM/oKXAx7qEWGoTUaWvQHSZbkCOU5y5A7xj2Y/DIaLbbt+BGKHyU
         XJhFRunW+l/zZG4zClj1bbEJ2NjkQgr80HUEwBZ0TaU6oT7nZQEDw+lGHJ1u34Hi7fOt
         GnEQqr2ZjvPaIpjShX+1t/IDjUN7P7XCtxXmPDH+SVW327rMiamKlVN4CVnUriMmC+on
         a/0GmgVYAEDiZUxVj4fGQzKGp6fMqeX46tRGBVUwHFfUtiPZ8qOlpev433eGZ8Mb/Eyq
         RLJ+6hcYl/J0pU8HxLVfEfMSejnnWY7G29fNa5zLq30dkM6NuUMWug6RhMM0rGeGFnxU
         dk9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpmHvUp9VeY2UBsBg0U22oqbxg0FMuMH0pCdq0WIIb8vtvPQg/Am19B+2vHnn3TAme4xhGiln5KofXSB82L@lists.openembedded.org
X-Gm-Message-State: AFuF++l2pSm4BrldLmbt2nPRIZL05kDYe1d9VQaW2gXvb1dOl9T9H6dc
	6dzMnnLtQn3SbAUlOQifEPBQLRkVnVX/8ntSzhOHbkjAvuwrLYJxk7O/k2vobH97vJU=
X-Gm-Gg: AR+sD13zC4aaEn9NkkREIkPMwe9xQTbOduDaCVAp2xtjNxuPQM5DGFQKje8a3SWvADd
	BZqlkq9O9BrP1+pdF7hi4YYffQxh7wnBlXD7r3g2yJPl0/jE5WA5JYJNxlJa8grjO0rnm6Kan7I
	GIsZlF1e//aYg4vQBRAYiMof/6G/NEKqe2tr7omfMPJpPr3fDHnZFzIoSoTlUIIYK4b6k++T16H
	9hHxLQOrTSsFpagDq0hs9zmf2jWFJcOMvMVEtbGgzVn5XTN+UU396o6psFiVQ+inU7El09XhRRs
	l5NpNIanpGng13v50DHAsGeRB2sOpdCE4OjdAtxpm3uIQcYyRrnbNg9Rnb4komcp4AgAYsvKZIa
	kodGvgZtZblRxU5rNL1dusp0Y0pA1Hfi8XMFVy8qOi+X+xWKJgr1eE1VzhQBiN7tMvnuk/MAXkJ
	IaNVTaXOTCVzyWFq5tslNB6ilc1jxkdHW39JW2e5oWCfjTqThEGPPPcsHIluSHSaA6mqADmdZy9
	63z7R9CX1u55J7ja72LALSH1RMrGrNMIkbaEyjQRNM1ktg7
X-Received: by 2002:a05:600c:3485:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-499b8343de0mr451022805e9.9.1787663442010;
        Tue, 25 Aug 2026 06:10:42 -0700 (PDT)
Received: from localhost (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d5d64ffdsm22753755e9.2.2026.08.25.06.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:10:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 15:10:41 +0200
Message-Id: <DKY1SVKSA25G.1G4STPIKU99KZ@smile.fr>
Subject: Re: [bitbake-devel] [2.18][PATCH 0/2] fetch/{npm,npmsw}: fix
 security issue and re-enable fetchers
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas Perrot"
 <thomas.perrot@bootlin.com>, "Mathieu Dubois-Briand"
 <mathieu.dubois-briand@bootlin.com>, "Richard Purdie"
 <richard.purdie@linuxfoundation.org>
To: <antonin.godard@bootlin.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.0
References: <20260825-enable-npmsw-fetcher-wrynose-v1-0-425c8cc1e111@bootlin.com>
In-Reply-To: <20260825-enable-npmsw-fetcher-wrynose-v1-0-425c8cc1e111@bootlin.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 13:10:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20036

Hello,

On Tue Aug 25, 2026 at 3:02 PM CEST, Antonin Godard via lists.openembedded.=
org wrote:
> This is a proposal to backport patches re-enabling the npm and npmsw
> fetcher on 2.18 (Wrynose). The two patches from this series are simple
> cherry-picks, and had no conflicts applying.
>
> Applying these two patches locally is also fine to me, but as this seems
> to be working as-is I figured this might be helpful to others - up to the
> maintainer(s) to decide.

I understand this is tempting but that'd be a feature addition from
wrynose point of view and so, unacceptable per stable policy.

Without exception to the rules, we'll have to live with wrynose not
having a NPM fetcher.

Regards,
--=20
Yoann Congal
Smile ECS


