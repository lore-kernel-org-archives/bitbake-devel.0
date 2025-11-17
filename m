Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D7DCE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 12:14:33 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8010.1763381667029113244
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 04:14:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PdXOIi1l;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88057f5d041so42119446d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 04:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763381666; x=1763986466; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n/6IiHb/SRwidpZR5HcRMSiLLGbFqrPBbU7wABedDbc=;
        b=PdXOIi1luG7VjZMnz7KoyIFp4aInJDQMZ0MbbdBq2Tlj/8og2PtwnBPgsiizlC8PqI
         ythiil45riQGIbHm9u7Cd2FMkWR7qAV0eI46eyHrLIDdRY1edzOF8rHwl6zvMt5/4nrx
         i6BM6kYvnPVzZGHamKnqKG8FvX8eVRiU+xJf+tL9zdI70pUAm2HUkVYJn6rZyMtuu5Lm
         lSVrCiAXixYnq93/7Cxy9BLTf+rQVOvIMSv5KtfZ0emLCRp3ayFFbF3yeSOu6hX7WHye
         ra1706FmhhV+RhQ938vacHR4ok6g6LM8Ch+7Q3jn5mMm0O2o81EKwsHatqiwvguPdz/Q
         WdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763381666; x=1763986466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/6IiHb/SRwidpZR5HcRMSiLLGbFqrPBbU7wABedDbc=;
        b=HGTj9iWuZi7FkD1D3VxexsfxM/YVF9Q1OY2tIb+5L0bQTQciLgOjBMEhfjdXWzlRx4
         O7TIXn1Qp9yzKvz3XXTwIjZU69nXgU5Y3NZIaxxYAgCrG8hhniTwIgFI5HFloLgOs+7Q
         Zc8I5jWvieDj1ilohFKYGDo/CzfyWsEZzp72tuUl9tFYLNhVYaSDnFXWHqAMi8XArCF+
         WQHpuqBHN7w5gog21Q+p6jYTGdoF2riWOsXcnKAf2OK/yGPOC3/LAXfHNWXuYFKe3Mvq
         lvAvcnnrhF6cQljFgwDSiCT/20jLah1MQMqED+5t3KRWwRdiDJktg6lL63bcYrax8OT8
         EB4w==
X-Forwarded-Encrypted: i=1; AJvYcCUh0P4skdN+Sqw8SIazqKyboODJsFrIcn90bGF6g4v6jruTxowbV8us0pzWCNMuV9VD/0Oi9d3XwvqdvkGs@lists.openembedded.org
X-Gm-Message-State: AOJu0YyGw571T1LpN4PLgeWIJZG4erMkZALdhc/uEewFclw1lBYKHWsi
	iNqnr0QWQc7iV+OnXsJt7xenZVX/y+HiX2YxCsEAXwMHZBeKvBgDBIk0bUQWoOFLteAuBE2Z/Hx
	df4mfcV+kwHU0/8aS7HKqLZHrqWiBurw=
X-Gm-Gg: ASbGncscbClfMWe6x5to6McCF6z9LgnvTF0CjfSXjId6jfot/kAY2mj1Qy45OJKYyog
	fMsyZKdDXv1iKngGBvtprxWIgfb+NNcw24g2xMTWjR7XGHNeTVXCiS9+15spvPsX2ykENIxS10E
	V9xJepXy3x9LNo+xrlasWgj/uPYZneSncHQ3dXWP97adtYqoS02JD1ZvABFM4d4Wbp+A5njG0M0
	aQKCtUBda0d1xLULlNdibaBdRaSCydw8x0quDI/aWH01ImHDlSZijVkG3pv3MzuMMX3z8/2SuWh
	PVjdechCOsqiyXrO2u+SnJjvYcApQQ==
X-Google-Smtp-Source: AGHT+IGt/tUWUovEH/gsnh8LwnCnfHyVCSOiGyWXmcmU6rnM0baXtV5Ng5++gVQ2oqWNdUjroxfzflAugosiv2Sg3ic=
X-Received: by 2002:a05:6214:19e2:b0:880:48c6:ad02 with SMTP id
 6a1803df08f44-88292699637mr200213856d6.52.1763381665955; Mon, 17 Nov 2025
 04:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com>
 <20251114-bitbake-setup-conf-updates-v1-2-990583d8251b@bootlin.com> <DEAYICIFFDWO.3R8QEGO7FSMBV@bootlin.com>
In-Reply-To: <DEAYICIFFDWO.3R8QEGO7FSMBV@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 13:14:14 +0100
X-Gm-Features: AWmQ_bncGK6BDdfP_C1-Xp8ceUWRc77mwUUzWgwBUx9_Un_TgbCFSNl-HcKxKwE
Message-ID: <CANNYZj9f+WDUSppAkUPHh3EsnUGVYJLV2S5AAMwAtE9PfQqLLQ@mail.gmail.com>
Subject: Re: [docs] [PATCH 2/2] bitbake-selftest: setup: add test for --update-bb-conf=no
To: mathieu.dubois-briand@bootlin.com
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:14:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18425

On Mon, 17 Nov 2025 at 13:08, Mathieu Dubois-Briand via
lists.yoctoproject.org
<mathieu.dubois-briand=bootlin.com@lists.yoctoproject.org> wrote:
> hashlib.file_digest was added in python 3.11, so this is failing on some
> supported distros:
>
> Traceback (most recent call last):
>   File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake/lib/bb/tests/setup.py", line 393, in test_setup
>     sums_before = _conf_chksum(f"{setuppath}/build/conf")
>   File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake/lib/bb/tests/setup.py", line 373, in _conf_chksum
>     sum = os.path.basename(f) + '_' + hashlib.file_digest(fd, "sha256").hexdigest()
> AttributeError: module 'hashlib' has no attribute 'file_digest'
>
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2707
>
> Can you find some alternative?

I think it should be a simple change to read the file content, and
feed that into hashlib.

Alex

