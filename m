Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A774C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 12:01:54 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.10019.1742299314024101508
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 05:01:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ApMQtDQb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4865215f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742299312; x=1742904112; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erfBFKXZxD1FwHeaZarwx428UX5UNosNvA9PHe6A3ho=;
        b=ApMQtDQbj3dyFXPp35cCbuAIJAm87gtepcHi+Oa30H4ycoRXwhOS/Ur56DlWYGiX+2
         rpNxulfSMWkmW0oWQTEFKJs+VBO4bbLzomL5nx8TvcK0RNo73HHoYTbAF+6BpjbW4K+Q
         JSwcMBcqSLlRdbFsXTXBfDuDAnqVxgAWbO2I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299312; x=1742904112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erfBFKXZxD1FwHeaZarwx428UX5UNosNvA9PHe6A3ho=;
        b=R1nlGZ98fkPsV1NRw+mBuSiVdEXmPCwG+b3GTIrPOXxKNQnzKQl5WBXGsvTWI/JxTM
         PxstGpbFNRZbhcGeAg7YhFmM79jbxEvCCJxusrBudmS6/kp7MXEtz0ft+SxmsMAPZFx4
         k6M4g7trpnq/mpgWC0S9OU6qpzn7N9Q/sy2IeYjA5t4FU7sGF8HPnv4jeu4pG/buzxE+
         o9kJOEIFdqyboainmVECyyloGhjHawugeaUZ9Rj+i/E1WmJP1IWNQm7hxXg9FkVUzwVN
         aCYBsRp4eEWl8e4jXO9ko3wMzKqmgYjY9I1HVyuLToHRLhHmsP+powKntUdhS5tITAe9
         pLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVknMolX2kmbNEHPxMTuFkVGgUicA97BtQF2gQEVIlebzWJJL78z4bTjw1j36aU0Y/lxf6fsQ7EGUH0SBOu@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxj2ISqs/kAiJMb1ed3EUrCDhHuMfTf2dDpbftDKC/7ePWHzgRm
	49s/qhxOcxtfTeeFq+W7Ek06unm1KIyKu6B30TYckftHFrjKKOoSHciH8+Q22vrB+JED53TxA38
	T
X-Gm-Gg: ASbGncvQixVVxPZYNvd+kdYgMuRa413Q3lp0pRq6HVS2+yv0KKOP7cWcv3wMOxAZ6aQ
	rJz9WrLpNk/hBCCjezk9NZLkiHyhgqmxNyMdsnToQCuZ0r3Jpu8OFv85FGoT1am59DNQa0YNlLz
	Gqr1GsZ4pVeTW5HKoYkQArn7MK5+i9ojHKwLapMoTWRsowfTF4OGpqBM4Ok6IDfCII5WktegQ1x
	Yak7EajKtK51r2OwA/UTqv99t6IpGipAhU64cZlb/nypLRCA16o8rLKBnqM/++lfz5BL0xNebRN
	wcaPn4VrbR2QWoClp/aGZu9o2SAbQUtIvsdatwmop4plNEN8dUS+FnPOnFdYj3geIgGP0S/Nae7
	PPFX+0B1Jlyy4Gv1yDi1vKQ1bqitn6T6CiXpQcLzEri07
X-Google-Smtp-Source: AGHT+IFmTUi9gfZZSIP/NJiyXkk+6w00bxA1Uv9ql0ILvxwAEA65S4S6fnAKTJk2TIDQzED40tcd+w==
X-Received: by 2002:adf:a35e:0:b0:38d:d0ea:b04c with SMTP id ffacd0b85a97d-3971ee43fa0mr16882529f8f.38.1742299310739;
        Tue, 18 Mar 2025 05:01:50 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:791f:f4e7:28a8:7096? ([2001:8b0:aba:5f3c:791f:f4e7:28a8:7096])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df34eesm18183906f8f.18.2025.03.18.05.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:01:50 -0700 (PDT)
Message-ID: <4ee434130c0e49628fa176daa033cdf0a2988cf0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/get: Rework tag parameter handling
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Marko, Peter" <Peter.Marko@siemens.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 18 Mar 2025 12:01:49 +0000
In-Reply-To: <AS1PR10MB5697EA94CD905C93AF76CD38FDDE2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20250318110743.3936601-1-richard.purdie@linuxfoundation.org>
	 <AS1PR10MB5697EA94CD905C93AF76CD38FDDE2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 12:01:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17454

On Tue, 2025-03-18 at 11:52 +0000, Marko, Peter wrote:
> Hello Richard,
>=20
> I think this will break git shallow tarballs.
> Those (at least in scarthgap) don't contain tags so the check will fail d=
uring unpack.

In that case we may need to add something to ensure that any tags for
the commits in the shallow clone are present.

The other possibility would be to skip the test for shallow clones but
I'd prefer not to do that.

Cheers,

Richard

