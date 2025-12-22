Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CE2E6748D
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:25:41 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78382.1766402735896054831
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 03:25:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JTQ/spH7;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88888c41a13so42140066d6.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 03:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402735; x=1767007535; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zyMT7eEMvIGbvIIruz6wJYyrZW1QRnWkaXtajnrSEBc=;
        b=JTQ/spH7ZejMzWSgvz/C/ZOTv/6Vxtil+8ADf5xk/CGJc7HtjuFgzXbe1ckvPBWLvn
         JeKRl/af2MzJwVefM5WRuoT6i+IDDk7ucLTAXoVS2bmPu4qnHjqESWFwoeybb60mxxyR
         WjTFBIF+UaJXU9HtfF0C6Aj7eKqo2Yc4h8EcA5ztqZuxM8QxZXXLmLvk6Rt+ArkRJbpg
         Ki1IJ8w+klMDH5vI+0DFyJXOzAor8eR8caJO3S+Xn7XjgOUBlMfA2hUP1uw4Et6a4kJQ
         e3QBrGY53rlLiEyyj8Z917NFy4dICyWnwwh2R+qWeeGHZ+INsdTIn6F213UlMaw0skWL
         GR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402735; x=1767007535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyMT7eEMvIGbvIIruz6wJYyrZW1QRnWkaXtajnrSEBc=;
        b=l4UR7LspxsWY/lC1PYiPXyeQ28reZP2oZ8Ao9XekjF5l8Gr64+fOU4pS35yQKj8+VN
         U8/GaYNLxMNE8NhNzra6z+DQCEktYTviyJ7SeupJJy3+44/2IP2s+dZUdpDGocyUtTeh
         RcRvnTMMZie/IIRbAOuOeaDPA25RAgsPZdh0rY9NEt7h72dao9rjklX2k78uSEHeTMMU
         deQ/TIsdHNyIzcmVfs38+lSBMOiz5VC5YfbuNF0eiSOvb0Ga0zfnwxfDc1XvSynXQbai
         cZmbPO+5O3535aIMqNk58V7Vtgl13yGmLCe0PC5EPR3X9XnzijlI6+APRO2T9L38Riyq
         u24g==
X-Gm-Message-State: AOJu0YxtjR2YG3VLjQ9YMVoam6NHYypCZSicfzkvIg8YnT8Jsi4gyijn
	c5PKi5giFbeKE7esK0i9ltdY5ZjQ+14AirwLK/2AX9IOaDLyMlsECTZJua9NPRpCqRPeyOJINpE
	pA7tyJQdBXn8MDaGYyAefcAH2NQTTFloO3A==
X-Gm-Gg: AY/fxX5JzSvHxgWtEM9DcJR7T8E3Em279d3g60YweCzJTOgCuiG4Eol8rs26+nXjxqw
	XwQ295ndvV/DLbEABUomnVGUvxrk3/iS1S8qvrpdfLQKDxJKVJuvWPTYkItGvnRkRyFQxQY7lxq
	SlmBU3Uj8xTb+skh7x7KR+2s/6qB+hnHr9MEOroTHwLUq3u5EX6DBBH9A612CjXLaQs+7gbwQbI
	ERaW3UooCx5iAAiq2B8dlXx7t4n+8FvLaWjAoFeFIpKd0YeQLHsTxTgEKSBWDfISJ1KjZEEY3wg
	dsDTNBtzVc6gnCu3fg4V1Y53U1vTwA==
X-Google-Smtp-Source: AGHT+IHVUj26rSzk7Qa5zqK9uyiqP7o9pNunvD8B1sQ5kxaeu1G3KF8wyQDkSsBdsPT/QDVQ/SaN9nXbPPlefFEJWZw=
X-Received: by 2002:a05:6214:da6:b0:880:4736:a20e with SMTP id
 6a1803df08f44-88d81278ecbmr198608006d6.2.1766402734837; Mon, 22 Dec 2025
 03:25:34 -0800 (PST)
MIME-Version: 1.0
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
 <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
 <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com> <1883858B93EFC423.1614991@lists.openembedded.org>
In-Reply-To: <1883858B93EFC423.1614991@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 22 Dec 2025 12:25:22 +0100
X-Gm-Features: AQt7F2oVKYt7_KhEx1zble7TX66PuXgMeC3Bz5kexh_qi7os2san9gseIbgP1yw
Message-ID: <CANNYZj_VHtxtAmG1Mb5bCiNgonGkcWZwDKDEwFUX0bwiJixrhA@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup update problem
To: bitbake-devel@lists.openembedded.org
Cc: uvv.mail@gmail.com, Yoann Congal <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 11:25:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18636

On Mon, 22 Dec 2025 at 12:18, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> Sadly yes, this is how bitbake's git fetcher performs unpack(). It's a
> forced overwrite, with no consideration for whether there have been
> local changes. We do need a guard in bb-setup for this, I guess the
> good one would check the revision that was previously unpacked (it's
> written into config/sources-fixed-revisions.json), and if the revision
> in the actual layer doesn't match then it would ask the user in the
> same way that it asks about making build/conf/ changes.

If the revision does match, it should also check if there are
additional local branches. If either is true then ask to choose one
of:
1. Stop the update right now.
2. Move the existing layer directory to a backup location.

Alex

