Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC835CD98C7
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 10:08:23 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16762.1781086094994106352
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 03:08:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=jPg5P3+i;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so70075565e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781086093; x=1781690893; darn=lists.openembedded.org;
        h=in-reply-to:references:from:subject:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WUUXnXoVwER610lf7p4ZMCb43FIfromimGDMbNp4gI=;
        b=jPg5P3+iO/DHus8hfeuXa+tj424c1phxDKQ6YOJIGpB1etYqsrjSEahVa7o24tTRKi
         0ADeFgbGQKtZ4Nvu2gbwGw5mQU34iwEdXBU36x5hW8vyIEVClH8V5O7ge3Xa1vni7LxO
         v/72FlCHfT88uFQvS9R2bbpoy/hOsdJ/YuB4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781086093; x=1781690893;
        h=in-reply-to:references:from:subject:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WUUXnXoVwER610lf7p4ZMCb43FIfromimGDMbNp4gI=;
        b=H016OuaKfngardBv+Bk9xvBNvfuu59Ose/EPw3njSBNfhTHtBumrQyPZPNMxKpvw3S
         UjzTfPylgcaW+8uRp+PwLBeH/dS/GBGraXlkpJ0nrZtH8bNRWSw3BloXabhf1VSb5/e+
         GVnHtdU4tuh1z4iidIrAMFNOAAp6TcDy7Haa9U3ZBwTMTEiH02C+ZpqXCkVDCfjmld/K
         j7yT0q/+lBwVPF4A1ozTFhgaptOWXewOfAfqLsuCtrnKcq/wCEIC+hT5KOE8PHFNOqKm
         AlvAZlP7Hy99iEboGDjuR+iGjoi4sfbfZMENAATP8yY/fz22Xch8sSHxSJ+2WYDMZDIT
         WAwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8eNG0kY+UYIijvvSFBomf6XSwKtR6fBN7lfK64Tt+oQtsI/G1QvUsie07KgwpfiTBJ/4XYgtg2ISkdS9cA@lists.openembedded.org
X-Gm-Message-State: AOJu0YxWSKH5/qTfu7f5YCw4iKBt3DzVPBv0ZcSsM7Wskpu+t3p+ZGvL
	Dt6MLj6uKCtR01zE9MhKc/gMmIeiDwvwZdeKgrOW5/VB2JMj9cKEocS8kMUXymTdG+c=
X-Gm-Gg: Acq92OFHjTva2kwO7jNJirDht5jkxfuOnnERVjzOD14uEgNwNZUXrnOknbsrKeYG4XF
	LoNxqzz2dVq8BD9VbAuyWtSbXN9aVDi/a6C5QiM7kT+7nUKBpmUZTeeqUEsA+o/2d/s/2g93LC8
	YGkXrCTUfO/uWS01Nl6ckXQ23Vdul2rOsmgmII59ejyCz9n6xjPKAQF6LHztySD2MYL+RjCnVZ8
	LDwpGTfrUHoWoBQTCDYYDiPCdrIIoKQxeFH/Nkx6A/8RCadBrspbhZWo/nBmzgDwDcGAEF8zHWi
	cG1/C5Dsx5Ztt6Vt1iO5op+IolSn74yn1kCGoQPB1h1OxvGr05cp5QwNbkjMdpYgN5o9s1mg3pM
	3PpbFAadsNtCc68KQ766qZf+X8EkfCiBGwb3aUdnJFkKbo31Tc97mIgZrGz3L9DSq9CTDwPA2Yf
	2+4oE/wN08iPKAYzyeG7PyRAQZOqLGQdOu9AxA3SQ8W1l/um8F/DwbH7sN4cCj9MPMv9jTAJz0t
	w1vfd9wALJSiM6CYnjrTfuoyOs=
X-Received: by 2002:a05:600c:45ce:b0:490:b35c:88ea with SMTP id 5b1f17b1804b1-490c25e74b7mr355694085e9.15.1781086091546;
        Wed, 10 Jun 2026 03:08:11 -0700 (PDT)
Received: from localhost (2a01cb001331aa00bb749f54eeb85d7b.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:bb74:9f54:eeb8:5d7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm526604025e9.10.2026.06.10.03.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 03:08:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 12:08:10 +0200
Message-Id: <DJ5ABQHS3CCX.1HSTYR4LCU4YH@smile.fr>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
To: "Antonin Godard" <antonin.godard@bootlin.com>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] doc/bitbake-user-manual-ref-variables: document
 BB_CONSOLE_LOG's persistence
From: "Yoann Congal" <yoann.congal@smile.fr>
X-Mailer: aerc 0.20.0
References: <20260610-bb-console-log-persistent-v1-1-5430d24061c3@bootlin.com>
In-Reply-To: <20260610-bb-console-log-persistent-v1-1-5430d24061c3@bootlin.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 10:08:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19641

On Wed Jun 10, 2026 at 10:28 AM CEST, Antonin Godard wrote:
> Changes to this variable only take effect after a server restart.
> Document this behavior.
>
> [YOCTO #15641]
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---

Looks good to me, thanks!

>  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 10 +++++=
+++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 9824b58ef27..f3e1a3a38c9 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -135,6 +135,16 @@ overview of their function and contents.
>        Specifies the path to a log file into which BitBake's user interfa=
ce
>        writes output during the build.
> =20
> +      This variable's value remains persistent during the entire executi=
on of
> +      the BitBake server. Changes to this variable will only take effect
> +      after a server restart, which can be accomplished with the ``bitba=
ke
> +      --kill-server`` command.
> +
> +      .. note::
> +
> +         For more details on how to make the BitBake server persistent, =
see the
> +         :term:`BB_SERVER_TIMEOUT` variable.
> +
>     :term:`BB_CURRENTTASK`
>        Contains the name of the currently running task. The name does not
>        include the ``do_`` prefix.
>
> ---
> base-commit: c687d42b81b17e7a2399099cab0f1a6aafcf6520
> change-id: 20260610-bb-console-log-persistent-c91ce341f898


--=20
Yoann Congal
Smile ECS


