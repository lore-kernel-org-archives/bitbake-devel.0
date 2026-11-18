Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13487.1795011382925862046
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2026 06:16:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DpbpCKRb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so637900f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 06:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795011381; x=1795616181; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+jk6mY0j2BlVEWAqVqTFWaCxuexyPeszzaZALiqqPEE=;
        b=DpbpCKRbC8rKLLpvfI1xdiNDwyXxM/GHOQD4+ke7/3pdUTRFBR9eCVn3OAJMGgGwPt
         eeXPFJgmDU5aD2KzGlu2MXZ5+jRriDvbEagZKXJj6NX0le1PR1p4/MjceEaBDXtoCLB0
         DtpMxncCZD5Ys+sceSbDGw1+cJso+UHaGVyPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011381; x=1795616181;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jk6mY0j2BlVEWAqVqTFWaCxuexyPeszzaZALiqqPEE=;
        b=pvOfz3WAqd14zdhOYeKihfTQrqoTAjz4KCRc7/4CBKQe7ZrSZN0WFyLDPeqGUbl914
         k4rpbZG9KsPUsCkfw38Gg4tsdntpgVvGptvTGCPmqF3akjzMnhz6HyA97S/U2CHWyaFq
         5id6iK1pk86msZLEXsFn4zOJsU4F4UGyrdxoBH7HmP5oXdgQBQ+L5X6u+lxXxbqTFp4Q
         ds5nSm7oT/s+GbgDZ45GwD8xwyj4RAT5imfS9e4wEs/w+l/W8zAQKn28wNUShBMIW1+o
         fvtUYJwBW+bCb8IGY+Tg2szFRs6Ur4wjY79bDNXX7jYXZE0BKuFJ+ZtCWmtjJC7Cc5aa
         Z2Xg==
X-Forwarded-Encrypted: i=1; AL+hErHhTMxVa9Mx1B7CHQyeGP9+cIzQhiKSOutvoih21SDgGLJalLPU0jeOU+1TOXakeHLzXJ6zCZR6pO+9DD/O@lists.openembedded.org
X-Gm-Message-State: APuU4Z9HXz9xS/qn2iLx4utXC0ERYrSU1JwaNMV+szY5neKT5grMDkMR
	R4BciV9u6aFk2KhnMLHOUFPr8iJyr2Wy2Noadh1ADgiXM30E8IbGrtZR9A3fiTZg5Q8=
X-Gm-Gg: AZFdTZcuk9XFpKBWqIIGdUqxylouoFflzunWT2n/jqMCCcub7soW9H4ZhuB/ltSdebs
	6/pRcrWUyE2pjHr/hX2JH01+EpYIHVzcVcDlTVaVcft4oyizABno4ZMe4e/kerDkNgN3/WdsIt9
	KiTh8pCl1ntR9SFDvfd2ZDVIqSLitDMa5eTmsr28YImdbAL+09YZsS2LvOfs616IDOGcluEDX3C
	FyHEjjKDdAffyM302wcIyS9wQUG66ophnhsKve9WcS3/KbKqu1AYZRpOBzn/+e4KC9IuKQcFfoI
	d0ZBzeeuC+oy/IAp6x2thzKRjYDFxfAhtXw8Uzn/KlhJTEeethuTSLTwqyewkrKpSg3Bhmo2qpe
	o+XLWkvf5QPEllWPZ/22XgvhCgQm0vbnOyZ6rXjcXSJ0lUdI/nHgniV0WWyttcgzqvKYqSliNmv
	YxWzwLnFGW7pzOVXgFu1uphWccUHO8Qt8zYKSSP2phr+6rTgV9lCmlCNPc1dELIhdsjJxMRXXVb
	f13iyZfakN/0CG6bMaUM+khRI7Emkz80gKbbgCni+GOul7A2Ln+UhLN1W/KpKQm6zzqQ/2j2MVZ
	2/aw/QS+Q6/fIM5KMtyN4JDHEUSu7XGe/XcPRmQaJJba2XlGVDpvMO8aY6IKEScNziBKXps4pLh
	6hpEWOkxwUv+gVnfqWA==
X-Received: by 2002:a05:6000:2dc7:b0:4a7:518f:bea6 with SMTP id ffacd0b85a97d-4a7518fbfe3mr4007742f8f.28.1795011381017;
        Wed, 18 Nov 2026 06:16:21 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:4f58:eb00:4738:8a1f? ([2001:8b0:aba:5f3c:4f58:eb00:4738:8a1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654b807fesm4621452f8f.10.2026.11.18.06.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:16:20 -0800 (PST)
Message-ID: <3d549dd354a8bcc4fe00135a1ef610b9d1012124.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] utils: fix 'polution' misspelling
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: me@waymondrang.com, bitbake-devel@lists.openembedded.org
Date: Wed, 18 Nov 2026 14:16:19 +0000
In-Reply-To: <20261118063049.619717-1-me@waymondrang.com>
References: <20261118063049.619717-1-me@waymondrang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 14:16:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20458

On Tue, 2026-11-17 at 22:30 -0800, Raymond Wang via bitbake-devel wrote:
> * lib/bb/utils.py (mkdirhier): Fix 'polution' misspelling with
> 'pollution'
> ---
> =C2=A0lib/bb/utils.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 0e2677f8e..fdc243737 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -954,7 +954,7 @@ def mkdirhier(directory):
> =C2=A0=C2=A0=C2=A0=C2=A0 No return value.
> =C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0=C2=A0 if '${' in str(directory):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.fatal("Directory name {} c=
ontains unexpanded bitbake variable. This may cause build failures and WORK=
DIR polution.".format(directory))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.fatal("Directory name {} c=
ontains unexpanded bitbake variable. This may cause build failures and WORK=
DIR pollution.".format(directory))
> =C2=A0=C2=A0=C2=A0=C2=A0 try:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.makedirs(directory)
> =C2=A0=C2=A0=C2=A0=C2=A0 except OSError as e:

Thanks, I merged this since it is simple. In future patches should have
a Signed-off-by line though please!

Cheers,

Richard
