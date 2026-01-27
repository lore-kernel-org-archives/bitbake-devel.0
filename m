Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00E9D2D8F2
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:35:18 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7549.1769510112814111320
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:35:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QgyklWRy;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c52c1d2a7bso722670285a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 02:35:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769510112; cv=none;
        d=google.com; s=arc-20240605;
        b=E+HctqUNdJmYz8SqQad4D/118dkvX27K1FUtLf8IYgk5HPo9NS3PBMEkt2EnWvIjYi
         ISIIBQVDNMfj5R8VsRhm0f/Na75HpGQTDBgo4Fil1XEkKYvQBV62FmgmtZbZpqpYG6VM
         UzvZ06YZMNzESqcWOgxxbUdRMbIp8f7PijMLaeYzyLP6b1YhYYikBdoKShTS0VwWfI2c
         N2SqVhTuA2Wsh+4LmPlMVBoZyHKTMwpf1oCjcOtdnEFreax3mN4cu4apgZ0C4cf1TiAR
         Znj8GUm9Of0LOrOsYCVvP47lI7BvKedBPOAojVlrgZlZ6sc2Uh0+qhhYc+wn8N83cMk6
         52GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3gzFffLDvIdr0NjekHc53yJhmvgBqh197is7zUtJo9s=;
        fh=KW0f7yRIx3yXFpTJLQhuYUN1/mEK/3oIWqWPK3KyzVA=;
        b=P2MFTfaiAcRXzyzk5ASkS97dWXVxjPHmcF1+PRVh/gvjmLAsJjZP3Q2e0zBhKWbo4P
         8gka5LaFBNmRiAsAssOsOI6p26CiRfSofwSg2yvOcWU8ahC+CEUpXip9tvuxKqoHRbjE
         o0wO/vFDsR2N0xLM3ySu8js17aKLZHn47nNSrxO+jVCbO9EqKsyyC+h1Es5agA6dozs7
         v2O2nAVFHSO/VIN0oMabAxJzgTqO6E6QPPPlFTsknamh/PopCvMPO0+3dMtIafWrAM8w
         2nlIsSAPyBK7QmYv+PkYJvZDJu2+dkh+4NRflxj7zUQjLinwCjiONNflEju5DRhnTOtC
         Pfpw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769510112; x=1770114912; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3gzFffLDvIdr0NjekHc53yJhmvgBqh197is7zUtJo9s=;
        b=QgyklWRy3egkJD0+qHsDfS2sx9myqhckULy2mfPtkmZXxLEtimUwP/mtoH/uv5AVlE
         Nc0p5tvWwkW+WLp7fVGBNPE5+oJYNhpsKcvI5KRkAggKl9bE/l72QZCi/zoKKRfuiCve
         V7YEgD3AAdCqIsZI26FYV5un91SaqqeNLxGNlfJGVNGxZOLY+pnNp5l3eP2O5i9uioQr
         OsDG6eYvTNHsoz+BqjCKQ53Rf7tG8BEcEXuzzckfjRMTHR0o4pKqn8I6HTn/WbkBySgB
         ivsN3JusNXaVPAJH6EV9BlTc6UIQ0VmAdXWcIjU9amjeLu9i+jvA3IDYuFysKNNApoUt
         sZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510112; x=1770114912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gzFffLDvIdr0NjekHc53yJhmvgBqh197is7zUtJo9s=;
        b=FwnpZhSgBbIqNEy0LKJlrQq8Ya0bPsqVGwXowNQdam2AD74ENGJu8zGuM06NsVOQ+T
         P881lW7hIAR16r9jCBzroa0nZfGUSikjhNVe4kD9s68l4Nrns9Fpzd9eRjSSi5yuCoJW
         heT0CPaH9t3VpzLVjcQ3YFYR2+tjpo6af8Gz5GvtvqB0AKNJuLPA2Ny7tr75aPmYXmUU
         RrJGsNr8y6E5j+yzX2a+dpQK9DIoxQ3CdHvLBB6+xwtTKnRmw45rO8VGtfDzLyxxd68q
         iMibCAv+p6KSf/OGa44DMWWCawuKeb+LW26EOAchssbOo3cq2pRzP7J9VxJUI//8b3To
         A3Uw==
X-Gm-Message-State: AOJu0YwEmwN/quoVudUT9O8NY1/zrsMjIRV2JeWifvIpATmmUGsNNvhX
	qnIC2d6BtWkjo6q4Z4UWa+5cCxjq5U3YNnSJun1V5TD22l2FNWQOGTBC7Hj0dIdOsYQVeaaN9wN
	DPY0bxUlGxaPLffeLz2JAkfJzVUjIHuI=
X-Gm-Gg: AZuq6aL9Biw4+zOF5lEcPpSs03x+LiHEn9vs0XLE3EaJ8U9nujEHfbf1YLD8rDt8gFj
	tFl843u6hZHfMyw/ou7gOzJh5OSEXGuZHO8m0M3ByXwZtL2l2FWq6dfokwnNVpNsf785cOqvdw7
	NB3noTcUAgc8audSKHQXT0Nq4+wtu4oXFINHan5Nq+k4Cmv68tPA1zcTWkbHrfpklOSE7yy6s7e
	xXgA8sAkobWHpUS3ccGGBWDyQoZkBOPmYVvPf3eklDj613blj0lxeDt58rnWUDlAAInoEAoaFss
	kafMOvePGxhOSf0Km8PbQrJ0S5zigQ==
X-Received: by 2002:a05:620a:4593:b0:891:7008:f2e0 with SMTP id
 af79cd13be357-8c70c17d025mr105188685a.8.1769510111650; Tue, 27 Jan 2026
 02:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
In-Reply-To: <20260126222743.411405-1-daiane.angolini@foundries.io>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 27 Jan 2026 11:35:00 +0100
X-Gm-Features: AZwV_Qjen7b5Z803R9gbwpnPTe01Fmuf2b2n8KG5yo6sDNspzyXJYMmy2gTkZc8
Message-ID: <CANNYZj9_AWqqHRWWiXg8R9y9Ash9pev2xKqUPAxzuy_1YdYoPg@mail.gmail.com>
Subject: Re: [docs][PATCH 1/5] doc: change some terminology around bitbake-setup
To: daiane.angolini@foundries.io
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:35:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18882

On Mon, 26 Jan 2026 at 23:28, Daiane Angolini via
lists.yoctoproject.org
<daiane.angolini=foundries.io@lists.yoctoproject.org> wrote:

> -   -  ``configurations``: Configurations can recursively contain as many nested
> -      configurations as needed. This will create more choices when running the
> +   -  ``configurations``: Configurations can recursively contain as many
> +      variants as needed. This will create more choices when running the
>        :ref:`ref-bbsetup-command-init` command.

This is describing the format of the json file, and it should be
conveying that 'configurations' are recursive: they can contain nested
'configurations' in their values.

Configuration variants come into play when the tool has processed the
template, and made a flat list that can be presented to users.

Alex

