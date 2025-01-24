Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6CEC02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 23:37:42 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.879.1737761858805723738
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jan 2025 15:37:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gzZkOuyB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43690d4605dso17938415e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 15:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737761857; x=1738366657; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4p0BDw4CEn2RngaheBioh+dCQ0sBxNshAQxV+02XUk=;
        b=gzZkOuyB9kgIfudvz9RDJ1Xdgl79uMoAWZdcb7jQreVkHEmBcjrGtlseiHWbl2iBbl
         95Q1LamXYiv9fdkXvPXKu4NI5ihgO4eQWRBS9sLX27enD94im0TFXMJZFuC0TOMxDC/a
         EQVYRUeyZGpHCI+tWhL63tHgBqITdaW44wo5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737761857; x=1738366657;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4p0BDw4CEn2RngaheBioh+dCQ0sBxNshAQxV+02XUk=;
        b=eS/aN/PRkZMXrFK6eanyS0sh403rIstpJIiDYxL4hld/UFOgfCKke419B+xyU8tUUW
         KIvahTtogbhwQfWc4kxmGiFCFZ6Oc46i1nVVN5abfDJQ1SIQjor+V6qYyBjNXMNTop3w
         uVtwbPPoKKn7deNI6v/7Ya1Q3rogPlyM24RHsUBlb4YOBEVPqBw00WwnG5Huk0QFVeB5
         AGYPcGLo2/PvTXnFaHygpkgdKOf/oaUc2AZKIGq7cASPECqu3I+yuyRNqGhEMEgn3l8z
         2sxJO26rmcdxADTXiQs59yE6hb5TAp0Br4ATVYvjCWi/U1pa/nwWv7IHhXIiqbWkW1y+
         rVWg==
X-Forwarded-Encrypted: i=1; AJvYcCWBMa4TpE+KMI3Sm5k9jJHfrgF5GnFdF9QvWsgJ/2XJKsXWczsf7OlCTMzglhjE/1YKMlOHZfUeM8dz874X@lists.openembedded.org
X-Gm-Message-State: AOJu0YwZevwnGNGxF9EmBwoOlfn/SyuVIHiSJQI2Uhm0eMcpc/i21teQ
	/bjG18ocPvKjQEzWlBjrXgOtIorliZPmcV1fBweMM+W7GMw/9gpWA1Mh4dEzCNU=
X-Gm-Gg: ASbGnctJN/o0TUqaYpKN9TIqryE8Ubzn+6+sk0PlN9hvDGsxr7x3LU7lRgKBDZ9H0Og
	9JVzlwNbNE1yrFT1VWXELme0wkHKSO2aqjfinE5F3KNtE5D/HjcI5Y5zzpwerRC0cnnsgubIY4f
	g9VW+LUPqghpYUk48E+llAMJkBvZ8BvC06I4a6FAD+5DL8KA3+LckwLlbqlw7xyKrkQxTCmPfeB
	lnOlysWBic9aPSGktQit3AgWh3MGFdNd+2sm2mkvUBVSFi0vC+U4f3I34FpKQuWqrwB3eVDbjZ+
	roda3FqmIxtaK3if3vMF1nxevAjTl5ZQRMm/mI9Mcv+43V6N1iUsQyInZrIBFTD1lZw=
X-Google-Smtp-Source: AGHT+IFHPdlzNdYNHUbQ8k48N7up9ebau6vEW3hPPKXan8ZNnyFnB/chsHppDlGNU6CGU1y/UHa+/Q==
X-Received: by 2002:a05:600c:a03:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-438913ed350mr314284485e9.12.1737761856911;
        Fri, 24 Jan 2025 15:37:36 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e837:2c7b:abf:41e5? ([2001:8b0:aba:5f3c:e837:2c7b:abf:41e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa3efsm42325485e9.2.2025.01.24.15.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 15:37:35 -0800 (PST)
Message-ID: <1e7c915f718b636a7c010dea330e9c010a6f4303.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] server/process: remove need for
 ConnectionWriter to have self self-reference
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jan 2025 23:37:34 +0000
In-Reply-To: <20250121175634.3723325-2-chris.laplante@agilent.com>
References: <20250121175634.3723325-2-chris.laplante@agilent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 23:37:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17079

On Tue, 2025-01-21 at 12:56 -0500, Chris Laplante via lists.openembedded.or=
g wrote:
> From: Chris Laplante <chris.laplante@agilent.com>
>=20
> It's a minor thing, but the mystery was too enticing to pass up.
>=20
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>

This seems to swap one mystery for another and makes the code a bit
more complex.

I think I'd left the note with removing the requirement somehow in
future at the back of my mind...

Cheers,

Richard


