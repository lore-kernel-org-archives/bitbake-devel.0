Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50CC87FCB
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 09:12:53 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.69585.1754989967366294338
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Aug 2025 02:12:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C9pxegNH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so2549998f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754989965; x=1755594765; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+AaPC0km9jJAzd+gK1aZvy0UPILW4Mt0vGGQfRecIE=;
        b=C9pxegNHtjdovhw3zGP9cxC++QaDmoTm0jH8ZUXm9YXKp+nyOY24tOzaPTs4trlYzO
         e82yidzFunA5+FhXowjFJbEJocnG6AV3J3NvPUAo6G0MuKRs4satAKc7cKVsavIfnU1c
         EwObcHtbpIr/7Mg0Mkal3DHxRS6QC6WA7IIpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989965; x=1755594765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+AaPC0km9jJAzd+gK1aZvy0UPILW4Mt0vGGQfRecIE=;
        b=pDSovcZJVnGWlqJb4tBTzK5vuJkzl/I4IsabPBnU82M2VDGiBVA3Xz9vzfbWdGIh6/
         6HbOYtMHfMGWvVVNZzz93Jt1OpbXhhQA4UOrSpD30Le+IIb84mzcUkH981BmHWX8QuGb
         J99zQn2kkzw5nRXQPFJnn7JXXULpxkGJs+GgT9SYMPv5eMGi92vj63e818AlErfneLlk
         WMsO/MAHa3FaQWv3b2hOBqlqYHBYKHY2CGGWbTqYx3gk+9mUMyIYJL6bxVNcEuRu9d47
         AspwWuqijk4m/OK6cGdhQ2NYZB9vLfmfuxrKAReGmKa5y8B8mcvunI1BcUBqWZiSwC3O
         DzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtY2Ez/UGr1PkrF3hUWLRpXZuuNgqKUht+NCMT7a6Ixxn/QYTBzEv/kVE7YCSBuOUDib08XxomJNy+jUNs@lists.openembedded.org
X-Gm-Message-State: AOJu0YyleyIkFWt+PWjv6iTfQgMhhFx0qoUs/aRa//FFq/xn+qcZy6VT
	46eV4iPykPZb3KaFaQPupiwctKIBeDxfEGGEi+9qnXuC1t2nOOpniM5MNP7yvg+YA5bbJJqYx0R
	O460P
X-Gm-Gg: ASbGncuZcxPjNU2CI9bJZ563o6opNO8q4VO8tst2kfIacjjc3fcEv71X2rOPUeWjJUQ
	CcWJhYtSTQAuRzZ8QxAhqycTb8+ZOvBVY+p93x0bF/o6zolTK5GAS1Qa9CESkXdmFmvfkRb5B60
	ZOuxQkN4NgB2D5Uf0/gd81QmAwNszLaiJBOb508nv31Nh3CLStP1J4vAq1KW+A16lUHgICB4BAt
	OOi1Gzc8UYws021oJWiI20TirIC5Lvo7rJjk4PbYZ2nUkaeEaTEZ5l7s2O/ZYtZcMNrgZgX4bCw
	FksNbqlm31db+XIW28WgZ9F2GN4wCZ5sVLaMPnPDjaHCVqwldceNmlg60E6PzyNkN7At6Hsz0Q2
	RDjPDCgIep68jN22x2dMBXDHPdpXu2Lw81xmGvIICMVc8oAwidPXHY9k0YpHxsTpiG7/2f4VHYr
	VOknvnTHN0AD4=
X-Google-Smtp-Source: AGHT+IH8r25rTwKEXbYMWDY/gs6ZHmdsIZkWxUlTzp6EqjqO1E32dW7CYkb38Qa94b0TZFdlBkT3TQ==
X-Received: by 2002:a5d:5849:0:b0:3b8:f8e7:7fea with SMTP id ffacd0b85a97d-3b910fceceemr2101601f8f.7.1754989965207;
        Tue, 12 Aug 2025 02:12:45 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:89f2:883f:9153:ef6b? ([2001:8b0:aba:5f3c:89f2:883f:9153:ef6b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459de0d4cf1sm352299835e9.13.2025.08.12.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:12:44 -0700 (PDT)
Message-ID: <2f5167e9cbc03b7235db9268d4a3a9292c773f8a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 1/1] fetch2: try_mirror_url(): Skip
 invalid local url
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
Date: Tue, 12 Aug 2025 10:12:43 +0100
In-Reply-To: <fc732bac7b8fc7535e9cbacac05d8b6e118d8e73.1754985648.git.liezhi.yang@windriver.com>
References: <cover.1754985648.git.liezhi.yang@windriver.com>
	 <fc732bac7b8fc7535e9cbacac05d8b6e118d8e73.1754985648.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 09:12:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17868

On Tue, 2025-08-12 at 01:04 -0700, Robert Yang via
lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
>=20
> There can be multiple PREMIRRORs each PREMIRROR contains specifics source=
s for
> each layer, each recipe will try the PREMIRRORs one by one until succeed,=
 but
> the trying would be failed if the PREMIRROR doesn't contain the required
> sources, so return it immediately to make log.do_fetch clean, and tt also=
 can
> fix a warning when BB_GIT_SHALLOW and is enabled and failed to fetch the =
source
> from the PREMIRROR:
>=20
> WARNING: Fast shallow clone failed, try to skip fast mode now.
>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/__init__.py | 16 ++++++++++++++++
> =C2=A01 file changed, 16 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/fetch2/__init__.py
> b/bitbake/lib/bb/fetch2/__init__.py
> index 0ad987c596..6149b1726a 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1067,6 +1067,22 @@ def try_mirror_url(fetch, origud, ud, ld,
> check =3D False):
> =C2=A0=C2=A0=C2=A0=C2=A0 # Return of None or a value means we're finished
> =C2=A0=C2=A0=C2=A0=C2=A0 # False means try another url
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 # Skip fetching it when the local url's path doesn't =
exist
> +=C2=A0=C2=A0=C2=A0 if ud.parm.get('protocol', '') =3D=3D 'file':
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found =3D False
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_paths =3D [ud.path]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Git works with or without '=
.git' suffix
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.path.endswith('.git'):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check=
_paths.append(ud.path[:-4])
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check=
_paths.append('%s.git' % ud.path)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for check_path in check_paths=
:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os=
.path.exists(check_path):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 found =3D True
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not found:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n False
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if ud.lockfile and ud.lockfile !=3D origud.lockf=
ile:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lf =3D bb.utils.lockfile=
(ud.lockfile)

Absolutely not.

This is adding git specific code into the main fetcher functions and
the whole idea is this kind of thing is meant to be abstracted.

The fetcher logging is a mess and we should probably be improving that
up rather than trying to add special cases to the code.

Cheers,

Richard

