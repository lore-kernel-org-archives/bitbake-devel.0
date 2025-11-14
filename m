Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83288CE8D72
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:21:46 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5055.1763144505063599507
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 10:21:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aJlnr5X2;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8823d5127daso27271226d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 10:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763144504; x=1763749304; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCogTe/i5HmGjd5KmHfMcthwjVV+YKNq0XJlqdEiiF0=;
        b=aJlnr5X2Xx7VhCBgeEQk22ZYc+qdgXe7hLSBxfWWpuzK3r77ChN07UYSqNSbxLXozF
         edi3Y2D5dtuBtw56X+RmqhBxSM7qegG6z67hS6aBVhTgHkuAwJNcHQObkqhQ+3Y1zJDu
         f38q1RvtiDwiJ/At/uf/qPQUo6XYrtkKVcjMErjsusV8+q7i68bGP9vQd5TkNtiJZvx5
         O8oOS3AeTZoMlZEX5J3ajQVOpiOEWcIsPyiAHMDytpchm286+eqzVN6ogvAL2HQ1SZfi
         j8HCPPdhcxBjK2Kq5DDEC0VIHM9GE15mynXmDhi/CclOYs6mj18HGKnnmEDkgPyGbsC6
         SKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144504; x=1763749304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCogTe/i5HmGjd5KmHfMcthwjVV+YKNq0XJlqdEiiF0=;
        b=noCO7hshHagCiakI7NT7pGOLNQJeyIpbHCLayZAvrAgQ5MlLpXN9C056O986Rh3WoD
         tve/QfENgqr24Gpri4WnKYl+kI3G9oGLDpoSRdnfX1SOORkvlHGbntwI/cqawxO602LM
         92qGoSVxEzO+y4uHac/wMn/o59GbPrn3y/qyPEqs5KaAOBox4O+Dh2jCcnH3kjGyG9fU
         Xt69a2EXCR8XQ5wanNAryEvIh1QX6Oqj1CLasK9OcPdsU9qGvdeA8iPjoSarXu9Fh5fp
         8Y6G24AZoRNcNGEkQIjNPxudrsCB2hZcHdmt8kL3zFAvw09Csvg5PupP0frrO6IXcKs1
         nk+w==
X-Gm-Message-State: AOJu0YzLrf4mwENKWdLhgcqDvoiU7jBu6LJ3bdCxq5Xn/OR24fg5IxYC
	il0cbYI8VXfBrOHa6oI9tzs0uISrlon/7mWyySss1U3Ri+i171HdUeiN9h5ADE6jeTJFtNNLn4m
	+3FOjcAdEYHXY/ki5oPQeZjrb+CE12tA=
X-Gm-Gg: ASbGncsYQy3d39KJP2XVmy8ey3vSncvnv+6kPC9HAp8PbGf5uETQRsaMNNBxvHMeBjZ
	BOnH7t9tXU/enlUlPnuN3A9J679BnQqQR+bXHWDXR++JHgP+2jftLf5Yo5wd0/fagluvxz8Sz9R
	k8n6Ap2FZ2ZFkjhLXjl/4gCR+uOMZam+UsaA+z9I/HPobI8Dvgf3kF+O7/wwj5g1U/U9TU1NKNS
	T4j7nCUxHsOc6Cg2HMyZ7zcthiwLe5lgA9+fWBOpnWpyj3faBy7Tbq5vb8RS9r6gIna3HF56gIJ
	BRUf
X-Google-Smtp-Source: AGHT+IHEttPu6zMbYXs0A/5m+yZkl3rxqdLb9h5q+QdlAfDgNNuj4+NQ0STGgLtDq4KDLZTNnomz/eFLV3roH+3Pas0=
X-Received: by 2002:a05:6214:19e6:b0:880:4736:a20e with SMTP id
 6a1803df08f44-88292594fdamr60821346d6.2.1763144503908; Fri, 14 Nov 2025
 10:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com> <20251114-bitbake-setup-abort-v1-1-d2f9967df3b1@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-abort-v1-1-d2f9967df3b1@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 19:21:33 +0100
X-Gm-Features: AWmQ_bnhUVJ3dFmiifA93FfzX3k0iwfSkOYWfO2O_6SXCiXdxbMYaBUwJU8hZSc
Message-ID: <CANNYZj8wihnjM0YQwLGz-s9N2jvYwuGsUO0et9=V_sJj15as3Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: fix top_dir creation
 in create_siteconf
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 18:21:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18408

On Fri, 14 Nov 2025 at 12:07, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
> -        os.makedirs(os.path.dirname(top_dir), exist_ok=True)
> +        os.makedirs(top_dir, exist_ok=True)

Wait. What and where creates the top directory then, if writing the
site.conf still succeeds without this change?

Alex

