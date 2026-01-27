Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA951D2D8F8
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:46:48 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7704.1769510801616607778
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:46:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RzzpDG1Z;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-894703956b8so84205876d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 02:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769510800; cv=none;
        d=google.com; s=arc-20240605;
        b=THRwZk0Zk7w2o6hBMs7i5dg5KqOG0BJJB5Ood5DQagH7pEpKTj/FTGp03C9FKkxRcK
         bZq+NcXeX7p+fxBADP9ZPVhHC6+ixS4UrDbndmOenn1Hn7rc9Qr1cuvYq6vevXztK06d
         bGInpQuh9oLCi/0RnZ4pPZPa+ZqttI1yhhfoRVqOelpLYdNFnV7D21069vWpXxUKMXsY
         RSaiaCAfg3n6I3Cx+02Ev9vaU8zKXtUBez3H0O/Xyn4n44gqwhHoC76/klY+Wax0gURP
         qewaGjBFQ1n/N6MKDjnnvmD3nPI/rhRsM8/h5tLM/o3nqok8d3gASG6GfwOg6TH3xknK
         akpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GDtJqARYL5tTnhAZzQ/M7tcj0QG/dlz2RJEyUE30480=;
        fh=LWh0xvcRMb5z8TjSMf8pq1E0+uyPVn1M0GxG3lNq6Rk=;
        b=dpdwsWUiK20N33Ws+GQgdpIPHp7RUHckF9w5sLkHEKcRFqsQWPO0wXsqgGmHrBg+1Y
         /m+crBv9Xs399OFXF3h4xg6eCqBUeJ8ZhyHKBLVBdeOHh+4b+5yjV48qRIP9i5xHk+Hv
         Ccz08G4J7UBirq6j/Ccf1K9zjJdRA2HLg51S/FBkb9URIBl/vkw9PriYWMcVmtrh4yV8
         zAIoqXuU/da5RF3ITYlGmRfrYNXSnE4Ws9Dn2ar/yGn1ljps4EqirJcu8GxyCpMGoSL9
         0arNZBaZ0r6mhGD0MimcScN2NgT9GuasOC9F2fMNi+C5aLBPGmOgFl178DYV5HpGKt/6
         Zmmw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769510800; x=1770115600; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GDtJqARYL5tTnhAZzQ/M7tcj0QG/dlz2RJEyUE30480=;
        b=RzzpDG1ZP7YP5PqlXzPddAc3fl+9en2Q8Ld8BA6VnYwOKb+6PD1Fmt1BDFabP5d2Uu
         3CW74Nn9HTL9tbquNZE0EkBgZPJksB4ifI3gWrU2rtijKo20BRn5beAPpDSkD3P1HbbF
         X6eEqUQ/vRQ/qHJGirCcPTjb0sAp1XXc1JrPM9b6IEvnhWknnqZcKP6Yx/yRfisHwJT6
         Z1c8K+GoemxYvSeS2IOd0YiKAACN5KXNHDkXyEeixmiFC2ZoFaL0SfFYgMaMmTLKhoqi
         uP5uQ4OZ6QC8SDnH08Yo2iqRCviYobP2UzMxYUXq4AMZpCzFp5bjt7dRTOGI8PFx4qvn
         Ozrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510800; x=1770115600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDtJqARYL5tTnhAZzQ/M7tcj0QG/dlz2RJEyUE30480=;
        b=sEqQXkDjfUtkHD77Ss8yTqwQqfJoDlJ+rRirrUyJzNPPVk8Smz6HqlryusjPmWaFSJ
         RHgI1AWRTbkCfFLEDh4B3BU4WfZ/LsYatWnzWlplI1orbRT/1tEi6KoNNbgx3aM7rI44
         H5mq6F+2W9CD3MF+DdYBd8XlcuQlR03rxrX3fI15D4Ainmk+E9xbEWI81W+TVriRQ4LD
         XzuQrlVeewcMTrfZGo+xI7/tHa8SRfDHrbi44iZeiM09fvIX1y5Sb6+Zi981pbAK8apn
         CChAbaODmxsA6ox50VxiOAfUipZ4Ynd3cHM8y6rn9AmJbEUz0h3SVZNqcjLoo19me5I8
         uptQ==
X-Forwarded-Encrypted: i=1; AJvYcCV228OMTxS1/UZu/qqZ7q6F+wkQ6Pt2T04MXYIaMXQdOtH8EjPJqZQV9yXbVfi19ch6jfT0QH4milZ+Pjng@lists.openembedded.org
X-Gm-Message-State: AOJu0YxTwzmMvHzoTz4EZ6D6GnS6sA91TtvA3J7szumRG90CB9ZU/zQ9
	7FU+091VLr/eigAVAujSizfTVUhmWVdFMc/4m25bx4hb3s8p610Ay2tci0EAmVBajVbqz6h/FW9
	yMZ2rUccck2peVCz3wEbQX1Ok3Os4g4M=
X-Gm-Gg: AZuq6aIJMyeXdiYo7NR1+kYIS7812Mvq/Sw18anjOvDh76k9wrByuBq/o6V3Aultjcd
	DzOUBBpw59x9b6gUkMmKHwpbPhlM+ezKi47rakEjCMLgCnPdcFrE1DyE17YQnKFJOIn6aY2ej5L
	YNKRH6cixGrMjqJb1km3njqhvXO+O0opGjPstwpHXooer+2AXSq9x8wuYt8y7Qb3j7ocNt5lcIJ
	5JscnKljdlK4oFK5aAJnZ7iysb2hnA4HxGUJN5MfInBCAqPVj2s8mXo4Tju77EIuyYC9pEXoMzT
	31+yifyaXmDBN3SmIeIBXntToHFnUk74PhCz9Ngf
X-Received: by 2002:ad4:5cad:0:b0:87d:622d:dd7b with SMTP id
 6a1803df08f44-894cc7cfd68mr16207596d6.1.1769510800625; Tue, 27 Jan 2026
 02:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-4-daiane.angolini@foundries.io> <DFZAUMTS82AH.ZQEHCQSFT7EU@bootlin.com>
In-Reply-To: <DFZAUMTS82AH.ZQEHCQSFT7EU@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 27 Jan 2026 11:46:29 +0100
X-Gm-Features: AZwV_QgfoL3oLNCWBPlsaVhO_gtzI-noCLrmkYF5KwLMxqXek0ElS53XGsJYSyo
Message-ID: <CANNYZj9qjZ-3YV21-i0dcMeQDTKjwOvPNzVjC9mUtPuVCbvMhg@mail.gmail.com>
Subject: Re: [docs][PATCH 4/5] doc: Add the term Variant
To: antonin.godard@bootlin.com
Cc: daiane.angolini@foundries.io, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:46:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18885

On Tue, 27 Jan 2026 at 11:29, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
> I think multiple variants could contains different set of layers too
> (bb-layers). So it's not limited to fragments?
> Also bb-env-passthrough-additions, etc.

TBH, I think we should drop 'variants' altogether, and just refer to
'bitbake configurations'. We can explain that a list of bitbake
configurations is formed by flattening the configurations template,
and when a user selects from that list, and further selects from
fragment choices, that selection (together with the layer spec)
becomes a *configuration instance*.

Alex

