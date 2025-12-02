Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CC0D11712
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 16:38:50 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.260.1764693529961065444
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 08:38:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PdZ5W1FH;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4edb6e678ddso71336631cf.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 08:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764693529; x=1765298329; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4li+jWj8FtQsudtvrj/6JUhWv1XNHuCsb11yJlCRWQ=;
        b=PdZ5W1FH8sfUK1KdpaBypTRc2Ib2ebo8lV2P2gqGVm4YJB/iQz4n9k8U3ePLHtAxhf
         +rfc6yaRAykJ6dF2k4fYWhgj0dc9UVbCbO2fc3ErMFVxAhLRST1qW3j0+z3ZkqROQ4m2
         tyN0uPaD00Gs4AAK2we3JqK5ZWgpcL8ozOEeeJrSoDmXItbLWCy1OEFyFPjZU18z4qcs
         QrtIz0YMiPiMK5YI39CCRRFrEhaC48ddYuoEE7iO/R76Pz1WnNSp9FbRdmsMmKO1CudX
         A5mhhEVu0b8LBHWyg2Q9e+j1FFJJyCNU+9fbciGFc7RN/2aayThHGABNSjb6H5SZNWti
         BkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764693529; x=1765298329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4li+jWj8FtQsudtvrj/6JUhWv1XNHuCsb11yJlCRWQ=;
        b=fW9aOeC2r/g6Nzny54XuI70J4NWGwx3eA68d9GrD9LzvO0hvZwGu5JUG79M1xymosT
         jwU8zpdGxJIcAkPNcfKWzmMBcBTK2ZeDJnoOcJO+E0f7A732QS/As3lDT9oJ7ogE4LnH
         D1/8LqWAZzaFKw1jozX3NojIenid3RCzGlZfswK9SatEWJy5gj6NQqhuwjwYzIHHtCsf
         whl3bVgiJCqyVx/BM+GdS/sA4HW+Q3USnK+g4hMPgwtaXeJti4zdaBTcF4Z09WEYMAsy
         vUEQcxGt9J6qabw1XK1rKVu8uXIZLBodcs2ncfD/m+yLGwoaQKuyhvNyIXB+D0KzuI4h
         QDKA==
X-Forwarded-Encrypted: i=1; AJvYcCXoqAfqfeTO6srCrGrPCcfGjbqLIRzfdeR2zSIMawt2qcd9qJY6FUFD6RXQ2xWP3fQgrEYTCquEweYEVKUM@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz0pF8TcAi/X6joLNyLga9YApvXd7RW7wIkZSqL1pKZmec3RQRX
	GycyAoFIRq7DK0P7FHkIw+VG0dbPURjl1YA4DhbuVjWerNcpwVwGqzGAmITLQChPyEvlWDCSmYw
	OBFnqUpdNb7vdGbl9DOVVIi8FTbOgfCM=
X-Gm-Gg: ASbGncuqH0vVObT8pUjXX7C493f8BQiKfvaeKiJt9JuC8cCtSzkU9gpcKtIfdRM8AxN
	5Uk3WKprBU57p8nDfh8lNCn8dNrBS8VLjLPNKRBM0/rQf4I6uscIHT6wRXpSfS5IXvFe+cC+Zgp
	SRMGePgr75fo96LqjIRuAO5YPYXu7tW07VvWDrqi3IziXBbY7KLPYOcEwO6Q+v5pa7lyHGWoaGR
	iVdZwKeDX2hY6h+CGaIb6s3qB/ohvobtJsZxeexpAqZuqhISv2UKM7133RBUN73XWVONZ8caRnu
	q5J+qL+BfLEwbwRGUCwFX51XtGXndQ==
X-Google-Smtp-Source: AGHT+IFojCgiTl/ATmddPw1MOYd9lxrkLQ2pLQ6Ay1DtnicUpcQH5dkAXPrhK3fV4G9ocKmBVWVc2pHYnhM4SpBRcqI=
X-Received: by 2002:ac8:5f88:0:b0:4ee:3c15:f3e8 with SMTP id
 d75a77b69052e-4ee58af8ba1mr592883661cf.76.1764693528914; Tue, 02 Dec 2025
 08:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20251202160402.819060-1-corentin.guillevic@smile.fr> <DENVH6TU57FQ.QPAN5BAMB9P1@bootlin.com>
In-Reply-To: <DENVH6TU57FQ.QPAN5BAMB9P1@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 2 Dec 2025 17:38:38 +0100
X-Gm-Features: AWmQ_blnoptbIPEv5O3hykQ0AIX7CfL2Lvau1ajBvccYtkaxmTHM56GDeNjYVFE
Message-ID: <CANNYZj-ZUksi9WEw4h4-uG-ZOKsA+9RqihxcbsZOT8X_L1WTvw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: add inline URI
To: antonin.godard@bootlin.com
Cc: corentin.guillevic@smile.fr, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 16:38:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18512

On Tue, 2 Dec 2025 at 17:30, Antonin Godard via lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:

> If this is accepted, please also document this new syntax in
> doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst.

I'd say standard configurations in default-registry/ should be updated too.

Alex

