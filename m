Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C2AE77183
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 22:31:22 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.69085.1734388276116730131
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Dec 2024 14:31:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BBZ7sIPe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso4019225f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Dec 2024 14:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734388274; x=1734993074; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3pZ0QdvZG5f4feKfxdnAUS/WcLrsHdLQGzUVZprds0=;
        b=BBZ7sIPe1foPYoSTaKRB0ebwX6AB4SJ7dXZ3aUz4sdPzGvDwxd3l12LOK/sSPJC4xb
         Mt/OPZgSor7sWRXlIDks3KWLruuiFd8+Pj4KP9vUCNJHWvNzuzvCaz6yhY/D7ijpx3iF
         u9Fl5puikcEJ8m6OB9xtgUF0uqbm7WpElVj0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734388274; x=1734993074;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G3pZ0QdvZG5f4feKfxdnAUS/WcLrsHdLQGzUVZprds0=;
        b=DsjiR7hM/VXGiAFobkYctmMkkfIFHVIfe1OWtvX+bYfw7K1SQ8hmWiirfAgm/g6ZZF
         RlLNwBHVs4C/p1sxUnt+Jv11X3RGjokYA1JhZlE2e7tvsvgnWo8tOMQGnBWoX9JjouNx
         RNJriAiYlU9yiiyatHbcJGSSSF1HeagV9aB13mkbm5imWdNXJ3n2Hdicw+rFSBO6rRCp
         7V8sgCFvUnA6//EBp99skTuy2vouTvdgGIo1dHEj5ld3cfSKIHheQC3TA4Hk6ZSye3VJ
         e+PpHOwbp9cE7njU0mQQxwoVXwEMHHnq1AkDYiIBDqRVy+Hl7TC1Worjkvguiy1PRtwo
         zHsw==
X-Forwarded-Encrypted: i=1; AJvYcCUvwTDl3PE+0t2y0T/qouQgeEt4w2zUyTCba6Au7N6IeIahsZViLm3ZKoswCmgCMjYXZ8lGvc6Y6QtrDjnn@lists.openembedded.org
X-Gm-Message-State: AOJu0YxclJch/5AIHPwKrmE1uuW5klvI4uIRNcqXLEiFhHtMcc470yEF
	so+suoZqe8qr9Pxw2oCpsuVwyGrVwu7ZU6EJ0O3CkanGbfTM7aGGQK2V4zbQg7c=
X-Gm-Gg: ASbGncvqNnOWqLyHKO0GA7qLeq0jKXAsQjHkGmNcJ4YlW0NGvb7aUdPHgTwmwddKBjV
	2I9EU79tt3VQhTAnUtld5fbUqmF9msrG/Qp6OLBOId7hi9G6Eyhe/bfcKyLbKJA20akpLMwwPFa
	kr8wYC+DXi+iaPYSKV8pSrQwW92VBBBeb8c10ropPV3Ta0tw37N22vU3oNIHg91orRIWmo2+Bib
	wesyl8JNdDODW98lMtskya1LCjyNEl9BOvfr5S72zsCMYqV177Ebi5sv55iEwsh1NXeMHUWnltT
	uLInUQGPC4Y4i/TzQovFriyA8jIyWVebImsrytj1hWuVXQ==
X-Google-Smtp-Source: AGHT+IFi9DQw8RjOqaYhqwjhPmPqXGRiGF5ZywiWNox2hiDUGlyhSOxp9xitHhKdTH/E5hmVVSNBpA==
X-Received: by 2002:a05:6000:1f82:b0:386:256c:8e59 with SMTP id ffacd0b85a97d-38880ac601dmr11201783f8f.3.1734388274505;
        Mon, 16 Dec 2024 14:31:14 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1fc0:ef8f:2636:e0cd? ([2001:8b0:aba:5f3c:1fc0:ef8f:2636:e0cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b14f241sm612905e9.1.2024.12.16.14.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 14:31:12 -0800 (PST)
Message-ID: <df46a810902511e9427023e23663c74f5094f16a.camel@linuxfoundation.org>
Subject: Re: Potential compromise on adding type hints?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 16 Dec 2024 22:31:10 +0000
In-Reply-To: <DM8PR12MB5430AA0A8523E4086243CEB28B3B2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
	<DM8PR12MB5430AA0A8523E4086243CEB28B3B2@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Dec 2024 22:31:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16914

Hi Chris,

On Mon, 2024-12-16 at 18:28 +0000, chris.laplante@agilent.com wrote:
> I know you=E2=80=99ve expressed you don=E2=80=99t want to add type hints =
to BitBake,
> and although I strongly disagree, I respect your decision. However, I
> have a potential compromise I wanted to run by you. Instead of adding
> inline type hints, what if I created stub files (.pyi) and added them
> alongside the code in a separate directory?
> =C2=A0
> It could look something like:
> =C2=A0
> :~/repos/poky/bitbake$ tree -L 1 stubs/bb lib/bb
> stubs/bb
> =E2=94=9C=E2=94=80=E2=94=80 acl.pyi
> =E2=94=9C=E2=94=80=E2=94=80 build.pyi
> =E2=94=9C=E2=94=80=E2=94=80 cache.pyi
> =E2=94=9C=E2=94=80=E2=94=80 event.pyi
> =E2=94=9C=E2=94=80=E2=94=80 fetch2.pyi
> =E2=94=9C=E2=94=80=E2=94=80 __init__.pyi
> =E2=94=94=E2=94=80=E2=94=80 msg.pyi
> lib/bb
> =E2=94=9C=E2=94=80=E2=94=80 acl.py
> =E2=94=9C=E2=94=80=E2=94=80 asyncrpc
> =E2=94=9C=E2=94=80=E2=94=80 build.py
> =E2=94=9C=E2=94=80=E2=94=80 cache_extra.py
> =E2=94=9C=E2=94=80=E2=94=80 cache.py
> =E2=94=9C=E2=94=80=E2=94=80 checksum.py
> =E2=94=9C=E2=94=80=E2=94=80 codeparser.py
> =C2=A0
> =C2=A0
> (I don=E2=80=99t think it actually matters where the stub/ directory goes=
,
> relative to lib/. We should be able to configure mypy to make it
> work:
> https://mypy.readthedocs.io/en/stable/config_file.html#confval-mypy_p
> ath)
> =C2=A0
> What do you think?

I suspect the practicalities of this will become problematic. It will
start out well, then something will get added and not covered and
someone will ask the original author why they didn't update the stubs.
Authors will be pressured to update both files and I'll be asked to
defend why they're separate and not maintained together.

Can you see a way to maintain the stub files that is going to avoid
those kind of scenarios?

I did look again at the typing and I'm afraid I really really hate the
syntax :(.

Cheers,

Richard



