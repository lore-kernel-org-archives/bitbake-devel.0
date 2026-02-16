Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9495AE8382E
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 19:56:54 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2687.1771271805134050244
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 11:56:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nVUuKc8u;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506984b6d83so32398011cf.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 11:56:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771271804; cv=none;
        d=google.com; s=arc-20240605;
        b=h1DbJjQhmQGinBlUkgzjcwT7jyfncJ8jNjotwTcplfBKV66Bmg0ssxwi1BCwwE8WHh
         C9L0XkzlCUaSZPPnaIPqJDYgpaSEn+QDfMHH/+mNe71sESZ8rrvIpmPMIubQl1EpWE0s
         CaouT9vzg8BQAS0QFsO8kbqwtC0jvMdna4QLa/eXRL1HJAaUVium5F6a0CB17+M9uWKA
         j8ljo7Yn7m2USOqxYiAjyKkTGincs7vrZYcHyJtFDKu3frOFGZ1LP/SIC604Zih1GSzB
         vCbVL9XYn6UVTTzNUN38TAqftKZf+KY16rKNs59/sNCBmFc0FaRAqbrhHuqGUCcYPSep
         ETIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CTyo1dv08Dyqg9tRpyW6eool4Z/sPdQYczmPCUiM2Js=;
        fh=UY90k4PlQOzv0SHkLPYnGUROqDnYu+dGNcFSIvIhMlk=;
        b=d/18fG81gTcIu2ok9TB94W7z9dZoZG7V6HZ7ahV8pdmQhXgHLGUvm9wlURPcgk7ptb
         +y0YtEk3WgnYI+KSjFHIz2wepUC9O6C6JBijBIqR4qhl5lce2Z5FaBnx6pvPBgvqzESa
         SAFQDcF9VPMySsDf45k341yaSZ+uj0DdcnZqAvC5zDXmccKI2urkyNvE3U5sB93bq4fX
         NM6PdjjL9uJSHHSi/iNj7WLRc+Kheyhjp5D8ijI1c0varCsBVEJjoNL/skvpJPpt6Idq
         RpHTv4l058oMSM4AOFYnYF7SXzikXMUnMfcNMZdmcEvjRCK69AdGHUyJt7V3qW4oQA9y
         KNMw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771271804; x=1771876604; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CTyo1dv08Dyqg9tRpyW6eool4Z/sPdQYczmPCUiM2Js=;
        b=nVUuKc8upDFDvnh8oBxOhHW8WnFU6b0xLKbP2qeeNXc3Eun8az4S2ZSCc5JQP9V1ba
         JiGBQul3Gljv/KVravXHUQ/iEkYIysG/49xdiurUC7g/86BtivjshCaDj65VhEX72eYp
         0Tyjk0n865SM56rIxxoKIApburmW5oohikmnsXEMte5EoNBFls6OUecw4Y0lw7I1sKpF
         /UeQwOdLnXwXRo1GCJQCqfx/MgLDyihXHSuKfZUKKRUFSxvz9JIXeHsVa27JR0hymft9
         CH1cevBegM6F0G8mN4YEnzBgxHDpNc4sg0wtU20l/8I3BxIJtPepWllj3gzOvvWSBP7O
         iK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771271804; x=1771876604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTyo1dv08Dyqg9tRpyW6eool4Z/sPdQYczmPCUiM2Js=;
        b=ZvleNN8FQrHUXNWJ7AebnMym02svMBsyW8QizyFwZe9C+gsRtX4U6RuHqx1amExw/J
         H1KNeSzzK03cZu4jIzTzyvcuc1TSV4QGLwKUdmCAVWhjD0WpyuQWZLjGEPt48Tsy1Lmp
         exSNVpe2cwYXsEXON/vPZsuJZT4APnY7idBdkETbrYpLAgc1OiWBuUTmGve7X+SKwCGX
         mgIh/BEHHHm14cQ/MBXWsOpmywKVO2pPm7FHHnru+MxbOtfJdPwPFSRWzNg/guWLIw31
         l1s07LQLyxAhFZxZcKAgg3coE6gst15Y4z7n6eNZlUkK2KXz4I241KMQgRxbJnXbxqPN
         d3jQ==
X-Gm-Message-State: AOJu0YxqwQ4BZ8AvV8vJol20flfBOUzwolGXerHCDUk5TjLOubI1l6HH
	C28nTJPlvdKCUp24sq/RdnLB0XQQ3aGL+/eek5d4Z8AH2vCOO5EuBZUkF9PN678FK5OdvQ14JHn
	1iyMSQg2fKcm6/QhYYmq4e91uoaQlwj391A==
X-Gm-Gg: AZuq6aLCzDY4uUdi5zgqmkzLG4SUpoetbfkvaIY3Tc5UMWtEeRmE6+chyzKaLFmNOPV
	Hng5l2TfzRY6Cc8awt1QsjQyfTzHPVPcFOfK7CN19UJHPwi5VUGwRjgqyx+ATwmUXCNnGBdfjIA
	XRmozb/CortyNdcMA4wH856ONljmR6s5nUJ+JBkpf4m8RJdugcbjewdyajczj5RFWpU2aFddtgO
	dhM3XRpvOZ6Upe82rbvTYwMHPkOorTvl7G8JpCKao91V21i2snhM2C7SKOJWbM247AVn9+LPcBG
	9q39Q4jczENYlAA1a+Ppuw9FfpW+Iid8l3ai6xP5NA==
X-Received: by 2002:a05:622a:609:b0:504:3c8f:f9bf with SMTP id
 d75a77b69052e-506a839103bmr142127231cf.74.1771271804100; Mon, 16 Feb 2026
 11:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
 <20260213-improve-bbsetup-readability-v1-3-41cec3b06992@bootlin.com>
In-Reply-To: <20260213-improve-bbsetup-readability-v1-3-41cec3b06992@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 16 Feb 2026 20:56:32 +0100
X-Gm-Features: AaiRm52-ZE1gBVZsTGSIB79YGEFHHSta7YC5Ju2NNEyq-nNDgpuv7-Euk8f5c4s
Message-ID: <CANNYZj9CV1hvFR2dvw56QktVStoYm+QjRgTLm+kC8TNA3+mdvA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/4] bitbake-setup: print plain messages
 in quiet mode
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 19:56:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19043

On Fri, 13 Feb 2026 at 14:50, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
> At the moment, plain messages are not printed when --quiet is passed on
> the command line. This makes no sense since bitbake-setup prints most of
> the essential information with the logging.PLAIN level. Raise the quiet
> logger level to logging.INFO + 1, which corresponds to the PLAIN level
> in the BBLogFormatter class.

Can you provide an example of e.g. 'init' before and after the change
please? The idea is that quiet mode is indeed quiet, e.g.
bitbake-setup really says nothing unless there's an error or warning
that the user should know about.

Alex

