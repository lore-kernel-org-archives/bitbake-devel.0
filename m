Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E934E7716D
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 15:28:44 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.13856.1733412515607557453
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 07:28:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bKkzIbi8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so805468f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 07:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733412514; x=1734017314; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tC2iyTdheR/QF1qHssYeW+S8Ov4ond5LGOLM5FMzx7w=;
        b=bKkzIbi85PjshEoBMPbHOQKeeE/1GCDSZFBWyJA05RaBuH5IHVD8flgOKJ83s35Tco
         JiXXnIfciWufqFR6oply5RQ3APRIxbR3Wc0je1ZfgBPFLMDBGmvEKPGjRwCbrZRyADjL
         BdlDFSb1yjq++9O3rlaGz9N22D1MjC7LYmnBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733412514; x=1734017314;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tC2iyTdheR/QF1qHssYeW+S8Ov4ond5LGOLM5FMzx7w=;
        b=Bc45Sx/3kawi/booKrFXyggUVBmQ7HF1EE9OjtigZ3q0hAA4YqK+Qx/czovcwgE3Gw
         +e7lOZEhB02c1sbA0dC7Pn6wcYFdINU7D2VcHuNt7THzyoxbn4d0dgEZZ1+xPr7dFIzT
         22LGAFu6LhwS1Yl1CpB31JqwayVIURy5FBqXkAjdYAIS5t1N6Wx9BGEIW36OvGyFQDBc
         ad1pWobqSYU5R6788oTuiw8P40F0Mfrj/3uZXmeLCw0yA3CnvL+CZ7LSPf/yCbrBGFt7
         YEYS5xzgAiOKBRgh5ThfYQYcxK+8HegCWpkWq0snYJbmmDIMU4w4kbxyFbaBmykdQXI6
         DQSQ==
X-Gm-Message-State: AOJu0YwDN4zF9aYJfZs/lZi3P7Z3Wb8r52JWb0XlOUlQLo3s0FR50YdO
	VUfZFxcmcrhF+0ToSxGL+5H4e1MmBgoHrjnRQvMm8FSIeaNhTifggKn76fHEJ6o=
X-Gm-Gg: ASbGncsHsqgnGR2Q8u2+TmuZd/0+oLOdD61RNJ67NwGjUTDbkpwrZs2eC/ssKsr/CPE
	wMp33Rx+J8BCL5AqQQHjrDNCGvYu4Ne390f78tE3JwvuyJbz4sXH62pxdzA5/Te+jpv+y33gB7O
	Rx7sieSWU1ucfM8vvTpdqo71r6WoNy6LmZM4mKR4p0PGkYlOaWauzU9m815GwJUd4m/D3XJZ2nw
	v8LPRk+/fM/sLyTLTlStCFW6WYrjZMJ5y2rsvI039uzaDy3wr/n33jrSDg7pLbJ3ftFajEL37Nl
	iXrQK3T/ve7/2LjuF2clK3SuxpoI+X9vlYTc5QI=
X-Google-Smtp-Source: AGHT+IEx/D41/qK24tqygrmO9klbeMb0+BT9viwHFCpr94uR42oHCFgvEa+QjeMsETL6E+QHHzqz9g==
X-Received: by 2002:a5d:6483:0:b0:385:df2c:91b5 with SMTP id ffacd0b85a97d-385fd378ddamr8719731f8f.0.1733412513920;
        Thu, 05 Dec 2024 07:28:33 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7d2d:8585:e7e1:10f7? ([2001:8b0:aba:5f3c:7d2d:8585:e7e1:10f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf40a0sm2187831f8f.13.2024.12.05.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:28:32 -0800 (PST)
Message-ID: <70cd6dd736551401d88185c060ee45fcc3d02819.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 3/4] parse: add support for
 'addfragments' directive
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 05 Dec 2024 15:28:31 +0000
In-Reply-To: <CANNYZj8hDKYRQ3cCLQGb0ddch3Q4stYyx=o15uF9ohSs8Bh1DA@mail.gmail.com>
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
	 <20241118162610.1423384-3-alex.kanavin@gmail.com>
	 <215a45a05eb2be50b71ad3c044334635239ff0e4.camel@linuxfoundation.org>
	 <CANNYZj8hDKYRQ3cCLQGb0ddch3Q4stYyx=o15uF9ohSs8Bh1DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 15:28:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16878

On Thu, 2024-12-05 at 16:12 +0100, Alexander Kanavin wrote:
> On Thu, 28 Nov 2024 at 13:54, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > Whilst checking if the file exists and only including if present sounds
> > like the right thing to do, it needs to be a bit more complex. The
> > issue is that bitbake needs to track both the files it accesses but
> > also the files it looked for but didn't find. If those files are then
> > created, we need to reparse.
> >=20
> > There are two ways to handle this, one is to trust that the
> > bb.parse.ConfHandler code does already know how to do this and just
> > call unconditionally until it matches a file. The apis might not let
> > you easily know if it found a file.
> >=20
> > The other way is to call bb.parse.mark_dependency() and just mark the
> > accessed files that way.
>=20
> After reading through usage of mark_dependency() in existing code, I
> need a bit more clarification there, because I'm not 100% sure you are
> correct, or alternatively I don't have complete understanding of how
> things work :)
>=20
> The original 'include some/file' directive iterates over BBPATH, and
> appends some/file to each of those, regardless of whether they exist,
> and marks them as dependency in case they appear later. This is fine.
>=20
> The fragments code takes a fragment name (which has a layer id as
> prefix), unambiguously converts that to a full file path that is
> checked for existence and hands it over to ConfHandler.include()
> (which calls mark_dependency() internally). If such conversion to full
> path fails, it calls bb.error, which immediately fails the whole
> thing. Would we want to still call mark_dependency() on a full path
> that does not exist in a case of such failure, and why? If the error
> is addressed and file is created, then bitbake will parse it anyway,
> no?

You're right, the loop in the fragment code is a little subtle. The
code in question:

+        def find_fragment(layers, layerid, full_fragment_name):
+           for layerpath in layers.split():
+               candidate_fragment_path =3D os.path.join(layerpath, full_fr=
agment_name)
+               if os.path.exists(candidate_fragment_path) and bb.utils.get=
_file_layer(candidate_fragment_path, data) =3D=3D layerid:
+                   return candidate_fragment_path
+           return None

looks like it loops checking for file existence but it is guarded by
the layername matching check too. It shouldn't be possible for two
layers to have the same layer name. I'm not sure how rigorous our
checks are for that.

For some reason I was thinking that fragments with and without a layer
prefix were possible but that isn't the case.

The patch is therefore probably ok but I am a bit worried about this
potentially breaking in the future if someone else (or I!) miss the
subtly in the code.

Cheers,

Richard






