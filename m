Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B36D743FE
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 17:48:49 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.4750.1732211327711974683
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Nov 2024 09:48:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fh9xnEO2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-432d866f70fso10400465e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Nov 2024 09:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732211326; x=1732816126; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wO/6RxAJkxnmxCAWinxTJ7gSk2zxwBX82C72j3AB7EE=;
        b=fh9xnEO21TRaCm0Hh3E3KF9s14mTELeLvoArNPR6ojo8E9fplum7hJeN7Qgxe2jCkY
         SkRMdQaIvv8Nulj7OOAD/0R1VvTkyGLDQtl372VcQfjQVz8pmSqpbA4IMJ1NTCwBO9Fd
         F82ZbBRueFIYm0I0BdriQp1LCRh5WbNCGO8PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732211326; x=1732816126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wO/6RxAJkxnmxCAWinxTJ7gSk2zxwBX82C72j3AB7EE=;
        b=b6ls7W0fQgaEHICWMoovrkZiIXAsNVaQdiC3yFM9M5F0y3YkFMcNtBIexoE5ldlH8N
         sGfCRdIxDBvvJsc5dqiSwM0HQ5IKgDRWg+2Y9K7wQz0VfQNlzqMgEHFS+0k81qz4VUOe
         fVAIElWn5KfPH3/J/hpknWjsyQ9vi/Kv6M5ANeYDoHEQ8Fib9g0ZMIP7OCL3FhdiAzHh
         zQMgPA1bFwQDMp2Xlj5QGfyA9L0fjDnH+Keln47dw+U3P/Xz/LOoAbaMkMZlzEZR14aB
         7cVaeV3uco78fghfxTXZ84BtR+JLpZhn1Cf76Je1eAvF4I4+chj3ovLh9bIDUy5xgvme
         hHwg==
X-Forwarded-Encrypted: i=1; AJvYcCXzrYBBgg0RX0/OjZuQ9uNSCVREVCKsJ4OpIzk1AyuIJodaM/Mp3iB50dzvwVoRKHjJi5l2lzu9FtOcbs1l@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz+alEiszKyBXpqFl/NEmBCA7yx6vIZ2ezAxOT8hsND3REN8/it
	mUR+6DOWr5dECMycmlfZRoH6NgONnGPYvESjHnZfM1oMmfG47DZisZePUspC+TM=
X-Gm-Gg: ASbGncsN7KnZ1Qg0NJHfVj9MPZCPX+wBdhB3eIE/v/wbza3313i4fQBxiullYQnTlEC
	goi5wF3TAFJDnjmU0BSeuRuQN1onJnt9HM/m7OKrA0AwRZePBcpp4FVFbv2cSsEo8rQMH0wZ0HD
	XTRk+Z4Nwt1txIohfvyOUE84XCGM8Wa5y1NvTSLDCxwX/ZyH5+aNfGU9ihjNmD32wzMMbNVK5Fz
	A1PVHInAYHvkHzFFBrMxyMSx5i8IIMT/HHgOjwxLgOnkoqzRXniqsvfZU2Q1Qjax56hYrdXuVyy
	kTj5PInnFjkn9UF9lOM0jjKy4SHF2QW9kl2AWiA=
X-Google-Smtp-Source: AGHT+IHJVQzp57x0UT0VTtCvzPUmHSWRtRtQYHV7jAti1K04ivGfU0WQSn5S3LOqXOztmpJCLFfk1Q==
X-Received: by 2002:a05:600c:8709:b0:431:1d97:2b0a with SMTP id 5b1f17b1804b1-433489d325emr75969615e9.15.1732211326135;
        Thu, 21 Nov 2024 09:48:46 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:a4ee:c091:1f03:6404? ([2001:8b0:aba:5f3c:a4ee:c091:1f03:6404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc415asm138849f8f.75.2024.11.21.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 09:48:45 -0800 (PST)
Message-ID: <d63db1ebb79dacf3b5ff5303eba5be0587df7925.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
 persist_data to a standard cache file
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "steve@sakoman.com" <steve@sakoman.com>
Date: Thu, 21 Nov 2024 17:48:44 +0000
In-Reply-To: <DM8PR12MB5430E29DAE622F328269C0E48B222@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
		 <20241008123627.252307-3-richard.purdie@linuxfoundation.org>
		 <DM8PR12MB5430F82E66A733A5687F5FB78B212@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <e7fcf2110ae769882a989d104e92bb7291245a6a.camel@linuxfoundation.org>
	 <DM8PR12MB5430E29DAE622F328269C0E48B222@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Nov 2024 17:48:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16824

On Thu, 2024-11-21 at 17:30 +0000, chris.laplante@agilent.com wrote:
> Hi Richard,
>=20
> > > I was wondering if you or Steve would be interested in a patch
> > > for
> > > this to apply to Scarthgap. If so, I'd be happy to send one in.
> >=20
> > I think scarthgap and older users would probably appreciate having
> > this fixed so
> > I'd be willing to take a patch.
>=20
> OK, will do!=20
>=20
> Question about sending the patches though: I don't think there are
> stable release branches for BitBake, so do I just send the patches to
> oe-core with the 'bitbake/' path and 'bitbake: ' commit message
> prefixes?=C2=A0 (With the [scarthgap] subject prefix, of course)
>=20
> And if so, do you want me to update the stable release section in the
> manual to mention this?
> https://docs.yoctoproject.org/contributor-guide/submit-changes.html#submi=
tting-changes-to-stable-release-branches

kirkstone is based on the 2.0 bitbake branch, scarthgap on 2.8 and
styhead on 2.10 so those are LTS branches and are where we'd need
patches. Prefix would be [2.0] with a note on why it wasn't needed for
master in the commit message.

Cheers,

Richard



