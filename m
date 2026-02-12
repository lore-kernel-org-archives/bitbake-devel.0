Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0312EB490A
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 11:39:03 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43139.1770896335498102899
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Feb 2026 03:38:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nc/Ao2Ma;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5320536bfso271101985a.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 03:38:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770896334; cv=none;
        d=google.com; s=arc-20240605;
        b=hQNrZuJNsye71G+iW+0Y13gdECHXxjkleI6nBQFvHEEu1URnvdZN1ZzJb7TqbA580u
         CbTnrkynzqNomEmeWNBjBjgFcvltd5AC0CAw6T8xMkghwOjiv4cz86vaoHAWwSS/NqUw
         kuH06VOARi72VTkb8DiBYYX1DLnF4o5owZDqWu5d5teGBas/JCiRA1P026qvOEGGRw/5
         R37nFX144MybCNofusKPmG4/XE6FsgWYA6W1O34OYAWP949NP/XPVsMKbzIDWBE+FJ8Y
         SlIzyZglpEidIK8Mq7jFA1v2GGlrMbNz+Lzeczf3I7UN6XiwxweGFfPStItlaWysZzps
         B44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k+G+gpqKIcL1pi+DsQtUTc2U3QOgaB4OkPo0m083XuI=;
        fh=BSOvGxNa+5Q3LgHZ081m8RFSyxnI10rZpHTQSyThbqU=;
        b=YM++YoEzalMVrQ0IsDGolmCe6s/Y/y1k8d2v9u1kVftdXmU5T6Q+w98UgiJPLaEqMV
         u25osr3kurAjkMTYvSAbyW7flPgh79sr8cx+PNzmbMGPcpycOCgzoTx9BIQUmI0N/7Ru
         skMnFpZL327y+B5nIJva440rG7moCMkOzKFPX1w0C1YPVR5JRxJXAGQNtgs6WxSl33Gy
         yr/UAfMZmjbL8yL8UCmh6zd1bebPFyqwj3O1Jk3JT9LeX8rBARouJ+pLrL/+3FK4lPz/
         w8r6dYO78DvCbDPuvWWaJU4POdof7t8kN7ZLBSvRKPeso4JlAZGfcrYxdoVAb1jTgb0M
         yEyw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770896334; x=1771501134; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+G+gpqKIcL1pi+DsQtUTc2U3QOgaB4OkPo0m083XuI=;
        b=nc/Ao2MaN47bclSHnsRCzsCa5tRFmMk0GjmrJliIH9sYpUSLrDaQeKkFk4OkX+qc9D
         lZLqhHNIGUyqjwjKfc90VH54uf7CO2BLo0hf5u/3GFG+R8w95M3NHwY0GyuqhZTQsFN3
         ONoI5AjAaaarK5a65j2Bq6dk92pV9MlQfYtAoFp6aJCrLrNXcGyrr8BPouGAa1gpFFkU
         gTn/iVS+mbxsCNQZbLDGuhX4k1pYeTHsNQzGzCF9gA6xsoSMhWgupSq3+wMAtkmUFZCm
         +nbrXM82jnxRtk+svPFBtXcebaEKLwM4Nuem7EhQaWjrTBhOtLrw0DWbeftdDxA+0bpY
         CBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770896334; x=1771501134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+G+gpqKIcL1pi+DsQtUTc2U3QOgaB4OkPo0m083XuI=;
        b=oMD0iLp1lTESWZgKj5iShuMws1zMvn/M16nXvTgfxiY8GqdwAch3FuMR+uhA5GMU48
         Oaw0lP89ZVIJHgqo9uJsHEQ7naJX8ht/moV3KqbtyP33wUz6fTMkB+/hlDpmrtiNyHRu
         PIMSg7To6wXaERcMdHa4vUN4tap/j+0Tw45iLHgecnLY8xzJVIxPeZW/z4JS4sTbIwtc
         Gx/A91Gv/EJD4t7ejqi25t/n5628BlSf9jA0Sbw2OCrmIQGR5q+iffKeoNAjUKsJnhyi
         bXXA1F5MQREFqQpTrtaOmQGZHBFEan9QuNWay2Jlp1XEZqBu9dqcuNK/djVnQ3HM7wcn
         2bTg==
X-Forwarded-Encrypted: i=1; AJvYcCXDjV18MSEyCmbF7z/3rZDyE0Ix3diVEBocfD270I71jzj1OcqJUD0sXllQVhGOC+bW+eqNjrvA50Cir9C3@lists.openembedded.org
X-Gm-Message-State: AOJu0YzKGDaZEw27E9pCMj0yoiH9FTAnJdbcUxSDNjqnSbRAuRMBQmIx
	jDYPs5wfGWUaE6mzh2pUnaOQDBj/GMNTckJD/9IYUsJpoVp/DUlep7AaJrbUwKgeZa3sYMsLfH1
	R25BzDKQPVJL3tALeSs/Ymv6ftKE8E+0=
X-Gm-Gg: AZuq6aILf5QbedKnGrakmgMgpxx80SU1hnaAMJlhB3Ze1Zg8Rm7xiusy0GuzvMhZ4cA
	R5EgnBASRNd/HCjA/fIyx3dhZkT7ANef9YFp2lzcyek1WU4O7MKYetEsBVfA9giSTQiqOHTuOen
	bnhaAlnlmx9KtRS2JfSjVD9qShOQPAozFOUJxLcH3I17+vfn+yr2Vu96J90P7SXhl/KDVXp5uhe
	YrjsUTmo4Mp3YroLUH1fDxNEzUR1wGLhnuMheRc5Dy/BaZX84kWYy6dl+ixz63/ToKJ2y+Y8j5k
	OjwNLWiHf0qElmayIQH3SAnjFX5RqnahT5wNwaxreg==
X-Received: by 2002:a05:620a:2996:b0:8ca:4288:b163 with SMTP id
 af79cd13be357-8cb3504589bmr176770785a.17.1770896334423; Thu, 12 Feb 2026
 03:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
 <20260121024723.2634264-5-rob.woolley@windriver.com> <CANNYZj_DjeLtLYLFNdwc=_RjagYAkdPuZznP5+QRLpc8bdE3hQ@mail.gmail.com>
 <4e1605c1-7f20-45d1-8291-399001921ad8@cherry.de> <CAGAhMBwAGcAqT+m0+XOC=KCEgxXAj=86Lqt35wD4f5JmozXJMQ@mail.gmail.com>
In-Reply-To: <CAGAhMBwAGcAqT+m0+XOC=KCEgxXAj=86Lqt35wD4f5JmozXJMQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 12 Feb 2026 12:38:43 +0100
X-Gm-Features: AZwV_QgGJoMX6XQUWguVKzYdmsRbcC4_jrsO9qcSMOEU0GN5qYqWPStCw7VXWXs
Message-ID: <CANNYZj-cqAEQ77PHOUd48RcNq3LYJiw_tPTxnABLe2+y+XXh=w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 4/5] Add Python packaging files
To: Rob Woolley <rob.woolleywr@gmail.com>
Cc: quentin.schulz@cherry.de, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 11:39:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19017

On Wed, 11 Feb 2026 at 15:41, Rob Woolley <rob.woolleywr@gmail.com> wrote:

> Are we okay with pinning the temporary staging directory inside the git r=
epository?  If so, do you have a preference as to what that directory is ca=
lled and where it is located?

I am okay and I have no particular preference. As long as it's in .gitignor=
e.

> The setuptools_scm uses git tags rather than branches.  We may want to co=
nsider updating our tagging strategy if we want to use it to automatically =
describe the commit for packages built on master.  One option we have is to=
 set tag_regex in pyproject.toml to a custom pattern.  Thus we could create=
 tags like bitbake-v2.16.0 or bitbake-setup-v2.16.0 to provide a reference =
point for results like bitbake-setup-2.16.1.dev0+gd2e159d85.d20260211 or so=
mething simpler like bitbake-setup-2.16.2.dev1 (see https://setuptools-scm.=
readthedocs.io/en/latest/extending/#version-number-construction)

The tags available in master branch can be see with 'git tag --merged
master'. It seems that the two most suitable sets are at the end:

2024-04-scarthgap
2024-10-styhead
2025-04-walnascar
2025-04.1-walnascar
2025-10-whinlatter
...
yocto-5.0
yocto-5.1
yocto-5.2
yocto-5.2.1
yocto-5.3

So we could simply use one of these versions (they match exact release
points), and then add a .relN+hash if that can be done automatically.
And then there's no need to introduce new tag schemes or extra work
for RP. I like the one with the year and release name a bit more,
because it's more informative to the users.

Alex

