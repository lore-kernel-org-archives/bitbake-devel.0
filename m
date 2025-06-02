Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAAEC54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 10:04:25 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.46178.1748858655043359297
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 03:04:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GGKYB152;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a375888197so2112850f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748858653; x=1749463453; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxapjawn/GNzgBVV4W0+w6K555SYasU4mm4YxIbxdzY=;
        b=GGKYB152dyXl74VveGeoHA/2Fgx4XN9R5e1i+z2GCmm3MLdLB/jQNMH1Bdk0EsrdYw
         aCnSCWC+Sbh7m+oWCuN55tHozGVE8OwlWEm0b4NQtQ+nvRbFBQbKEWuAs206mP038+0E
         EUa32rPOo7oBvA+Pk/U0u3HudJLUChxvSIMuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748858653; x=1749463453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxapjawn/GNzgBVV4W0+w6K555SYasU4mm4YxIbxdzY=;
        b=VBy/LbbRpgdOSKyMrSeZ5tCucW9HYQ6nspRC8O9kSHnNT2+hMUVTRl32zvQ+2etlxL
         +H7uZGg7tI/1gvfAkWSP+aZHMo15N0akBXcdHnFPaj35ocmWa67taSGJOyXTE+R1kX9X
         Q1I/6zkalhSDNG+A7XzhH5pk5vcG5Kzy0Iv+WurjD3JgH0P25FPQe10saHfH7nbZLeSl
         +vS/ks+typQfLmsdj7l2FxTJPsrWs5SQsUVB6aYvvGhoW9lcgK/tsdVxFyXn3W94RWoO
         fjD7InpssQvbH0HXlcOD2NY5U6t8sdmqz0AQH0dCeZvYHsxejFXYJznBfEwe2jNcMFfj
         w7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW+RFC1b7tDro2UpNo1oHcpKM5mIa2SaGYO5YxfrYfPU0cDq29i9jCYo6+Tb0S1CrBtJtNI8BLRPXGYGj+H@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz0lsQOIm/G9vE3ghWbtdMDUrOEJ6okKXWS8If/KZYQ3Z0e5oyl
	jq+tBdqlTyVGFXzyF6BbLyMiWF+hdulcdEpixhGDhfIQ8D+QV0fcZ/B39dYYRhuik6g=
X-Gm-Gg: ASbGnctZCKaL9SfV4sSM4l0g7v1CWRirazdg0KDPZ4NxLRlt7ua0xqTixqQ8Bt0BF+o
	GRm4vbwtmHGwA8ySx4O2naDqozDC2eegjdDfGX2ZsAsO/rfqwedRy+d7g2g8TSjJWCnelbx3K9V
	82y88oXA2RvDQ/GTcpdoqRfzsXBRgnjUWQGIXyAaLu4ZW4cLpm7npPW/GktVHFJiuf/SWK89oVi
	a71iUf2AnIZk5lHnd4JqyvJAzE0i/3asOsmLEUI6qeKf6/R6gYt/cB5vUJdPtEn/KT2kS6aASc/
	1IbzzJLzOHaEPk4pr2R4xVx59HncygHX4U6CAL5trvpUquk6ZB2ylv7jnxAr6XKVMm9NmOZracy
	V3R9eUjufZg83bfh7cwN3fsuJZiGT81G4ZunATlvv
X-Google-Smtp-Source: AGHT+IErhxrVMoc47YVTQETBYA58tnGJddMvfpqTgVfKj/pYJpPex4xEw5EqG60ZunDzPg4/sCBsjw==
X-Received: by 2002:a05:6000:420a:b0:3a4:e0e1:8d9d with SMTP id ffacd0b85a97d-3a4fe394737mr4915321f8f.32.1748858653214;
        Mon, 02 Jun 2025 03:04:13 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:907c:f576:5b06:73b7? ([2001:8b0:aba:5f3c:907c:f576:5b06:73b7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b89dsm14464794f8f.19.2025.06.02.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 03:04:12 -0700 (PDT)
Message-ID: <d9e0acdf135b044b80bca83f6359f5ddc67ee69f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] Update documentation and add extra
 check for az fetcher. AZ_SAS token should be prefixed with a question mark.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: quentin.schulz@cherry.de, robbinvandamme@gmail.com, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 02 Jun 2025 11:04:11 +0100
In-Reply-To: <23d79ce3-efe8-4976-a874-801fa9df8f0b@cherry.de>
References: <20250601201505.177262-1-robbin.vandamme@renson.be>
	 <23d79ce3-efe8-4976-a874-801fa9df8f0b@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 10:04:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17669

On Mon, 2025-06-02 at 11:49 +0200, Quentin Schulz via
lists.openembedded.org wrote:
> Hi Robbin,
>=20
> On 6/1/25 10:15 PM, robbin van damme via lists.openembedded.org
> wrote:
> > From: Robbin Van Damme <robbinvandamme@gmail.com>
> >=20
>=20
> We typically do not accept commits with empty logs, so please provide
> some backstory for this patch.
>=20
> > Signed-off-by: Robbin Van Damme <robbinvandamme@gmail.com>
> > ---
> > =C2=A0 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++-=
-
> > =C2=A0 lib/bb/fetch2/az.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
>=20
> I would highly recommend to split this into two commits, one for the=20
> documentation and one for the added FetchError, those are typically=20
> reviewed by different people.
>=20
> Also, patches to the doc (yes, even the BitBake docs) should be Cc'ed
> to=20
> the yocto-docs mailing list, c.f.=20
> https://git.openembedded.org/bitbake/tree/README#n32
>=20
> I see that Richard has already merged that patch, so just think about
> it for the next one(s) to come :)

It is in master-next, so not quite merged yet. I did tweak the commit
message to the correct form (subject prefixed with fetch/az, added bug
reference and reworded).

In this case I'm probably ok tweaking the docs at the same time as the
code since it is all clearly related and they're in the same repo.

Cheers,

Richard

