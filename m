Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA00C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 17:58:44 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web10.22287.1737482316364760226
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 09:58:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cdbuI9TY;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46e28597955so23288991cf.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737482315; x=1738087115; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ag/ew3xTPvMiQM2KNgTvTUCXnVw/069p/LS5BD4FZYE=;
        b=cdbuI9TYBjRIE9I/4O3zLHSFLrJZSqTkkHn5947n7ExFoQn2CPcWg9si5uWR2ejlhg
         noNH/HaHsoogY3zTagyKx8XvvuTla8ilDvTKdAYifyVlt24UgZrfsemhTwvbTn3ZWUSy
         zv5Yd3xBI62xfnpIKqtJIq9fJwYPWST5HHApxPdbcx/Z5umiR0olpXv72kWjWiJ8t/8r
         BIZu7Kh0Eq3fhx9J9/KDDWLbxdIEltY1OORmZrdcBwtJhomo/d3R+tkvTSkTWWbtnYti
         mPN14i7d5qK0xWHkx5G8+w/VHLzAOyua8zA8xUZZYPinG0BAiEgyJ4PP2B88TPGfjVgK
         kp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482315; x=1738087115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ag/ew3xTPvMiQM2KNgTvTUCXnVw/069p/LS5BD4FZYE=;
        b=J6ZPJ+wJTzXn0YJl77AwENZIdawReYzhSR3GMkUHb27p/rsG1U4Aze0nfk0CGBJF6d
         Ii81Pon/lneBlUFCyIfYd4teT2usZuZCKxLXjXt4J7TMvsRkyYep/H2HMsVnb9yPtXxK
         3lRk3qSJbZWx6wiqaA0hscYy/mrffogEVN8NAH24tspoD51Oh5uwEpDiRlqMnqNV0bN0
         Tu7WIw+iG85P3lSSN6T5rhwO+Oo5WcxH0bhKeVtU2MjOG93AuWS5y8M5tUsUt0Lgti6J
         jLx+NNj+cM6GIvwM3RJvb/Yfks+3XumcolswnkhtoeEfZiijXykmIkxJ+6JhidPxoeGL
         jdAA==
X-Gm-Message-State: AOJu0Yw18M2BFXfK1un334TlULp8AVF6Q/RT3IZ9pD5oAAu8BJTbhEi5
	GMkJzps7kHu59FKzsJtwTUhPcLdsfuWuAVana3SswStGYlK3vXPkuLfU5ADRCYibWD6iQOq2a+6
	5zTGic4cACoanP+G2B6iXxbOO7ds=
X-Gm-Gg: ASbGncvoC8owU2jA2YsXK5+R+CT6P/yiaaeqZPZGQAJlvW2r3hv8h7VBCGXZLTqOc79
	TCvsqEITiAgfRZfMSbZ2C6zMQ0bbTBvRL1k7LeCiI4fB75ML/Fqnup0/vxlwWcqHmE0F3hHNSO9
	Oe91+LUFHI2Q==
X-Google-Smtp-Source: AGHT+IGMU0Yzeukx++wWW0peGlqSiqYt8fLxCt4ODSeNISUFHyjPJhTsWAGCXCh/J/bAt655nUDTJxaaM6PeK1V447o=
X-Received: by 2002:ad4:5c6d:0:b0:6e1:6aa2:2156 with SMTP id
 6a1803df08f44-6e1b224c283mr232002736d6.30.1737482315240; Tue, 21 Jan 2025
 09:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20241014125406.2322310-1-alex.kanavin@gmail.com>
 <D92E13F2-8973-407A-801E-D743AE755FD9@arm.com> <181CC55DF6F8EBED.28835@lists.openembedded.org>
In-Reply-To: <181CC55DF6F8EBED.28835@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 21 Jan 2025 18:58:24 +0100
X-Gm-Features: AbW1kvYfc1ImA4oJm0MqUnI5onp_obcSZDEdti334225yhxT9IK-4KzfTj0yoNQ
Message-ID: <CANNYZj-3mGjhmasOC4ukmA_+POBi_uSfu49hHF=AXHRx_Gn_Zg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget.py: use default wget
 user-agent in upstream version checks
To: Ross Burton <ross.burton@arm.com>, Tim Orling <ticotimo@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 17:58:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17046

On Tue, 21 Jan 2025 at 18:29, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
wrote:
>
> This has been discussed before. Taking things from mercurial with wget is=
 explicitly disallowed and there=E2=80=99s an official location for those t=
arballs. I=E2=80=99ll find that thread when I get to a real computer.

Found it:
https://lists.openembedded.org/g/bitbake-devel/message/16359

Alex

