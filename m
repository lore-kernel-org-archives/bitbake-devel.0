Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B38D711DE
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 18:39:56 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.22375.1732127990300620267
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Nov 2024 10:39:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h3SKB3yY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314f38d274so48815e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 10:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732127989; x=1732732789; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/kKdVV787+Jd4GPoLO/Of7EtHMtc+LpyO5udDz6Qwo=;
        b=h3SKB3yY83Fpr9wdGuVg8EB04t32PZQwaxYbu/HyVt79QfyLg0UW+rJEJl3Fx4RylQ
         SCznWyEtnalJ56k7PLihduHYw5lPG9DMLdkNhLb961F3rxz/1/hQTk5PaC10QCSwuDqM
         GFuWe2bet+8Ag5F3dEqYXQsl2ZbTj2ju0MZqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732127989; x=1732732789;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/kKdVV787+Jd4GPoLO/Of7EtHMtc+LpyO5udDz6Qwo=;
        b=SnnQTSNM9iGwjimhOACm+6OP8Qqxyscb328EaOYqqi2sE4lj+IpnPcW06j28eZam3V
         CeWD3+cbeJWRVXcnqSFedwy7K0JFsQeDOtBY8gFZNE4aeEsOBX2GDriB+e1EA/HLdWWz
         Qfcq+0HADTOTVsi2hkcBFTLnawURsDNvc6odasbpWnqiDW7e6D4MY58kCVK/5/7DQuAd
         qatIl8GiG0FczcTUxKjzMaqnhqYDmr1i2SNT+ApeUaTIUL/KyUk1rydrnmEBZ67UtJ/P
         1qQLI5rqcGoeDbJjwikDNTqlnIuJaxxYlNy/xY2WAu8vCeCd7tor3Ae01sIQJA0HOuiD
         69Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVIsYWSsCqX5/gU0Jg2FDIYqSHDPUevUpX5JRklDmbiJzwyFjOQjZaQz/l1hCDbC3THppZ14NCYEcfUCyEG@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx2kfIPIoAd41TDOjLz/AfUnLYWZKNPb0wB87+CILL8M+9R00Pm
	DD9omaR062rKWKXVzwS+eiaoAFzuyl3BgpBa5QFPb3PyJZUN/U6XiRFLNQecLuk=
X-Google-Smtp-Source: AGHT+IG7akocawb+pg71oc/6SpoojWTuoS/ww5kgyF42TuwaeZ0sM4PIY3Q4jT2yPos1+QNcgOo4OA==
X-Received: by 2002:a05:600c:4f46:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-4334f01d75bmr38325585e9.29.1732127988705;
        Wed, 20 Nov 2024 10:39:48 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:5abf:50dd:d6fd:8415? ([2001:8b0:aba:5f3c:5abf:50dd:d6fd:8415])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ad45sm28919455e9.39.2024.11.20.10.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 10:39:48 -0800 (PST)
Message-ID: <e7fcf2110ae769882a989d104e92bb7291245a6a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
 persist_data to a standard cache file
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "steve@sakoman.com" <steve@sakoman.com>
Date: Wed, 20 Nov 2024 18:39:47 +0000
In-Reply-To: <DM8PR12MB5430F82E66A733A5687F5FB78B212@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
	 <20241008123627.252307-3-richard.purdie@linuxfoundation.org>
	 <DM8PR12MB5430F82E66A733A5687F5FB78B212@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 18:39:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16819

On Wed, 2024-11-20 at 04:09 +0000, chris.laplante@agilent.com wrote:
> Hi Richard, Steve,
>=20
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org=C2=A0<bitbake-
> > devel@lists.openembedded.org> On Behalf Of Richard Purdie via
> > lists.openembedded.org
> > Sent: Tuesday, October 8, 2024 8:36 AM
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
> > persist_data to a standard cache file
> >=20
> >=20
> > The sqlite connection handling is causing problems with python
> > 3.13. The
> > connection can be closed at gc time which causing warnings and
> > those can
> > appear at 'random' points and break output, causing weird failures
> > in different
> > tinfoil tools and other tests.
> >=20
> > Using sqlite as an IPC was never a great idea so drop that usage
> > entirely and
> > just use the standard cache mechanism we already have for other
> > situations.
>=20
> I revisited these warnings on Scarthgap (which doesn't yet have the
> persist_data changes), and was able to resolve them. Ultimately, it
> seemed the context managers were just not set up correctly for
> managing the Connection.
>=20
> The __exit__ method of Connection only deals with transactions, and
> doesn't close any connection to the database:
> https://docs.python.org/3/library/sqlite3.html#how-to-use-the-connection-=
context-manager
> . But we were never using a context manager anyway when dealing with
> persist_data.
>=20
> I was able to get rid of the warnings by adding this 'close' method
> to SQLTable:
>=20
> =C2=A0=C2=A0=C2=A0 def close(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.connection.close()
>=20
> And then changing usages of persist_data in fetch2 from something
> like this:
>=20
> revs =3D bb.persist_data.persist('BB_URI_HEADREVS', d)
>=20
> to this:
>=20
> with contextlib.closing(bb.persist_data.persist('BB_URI_HEADREVS',
> d)) as revs:
>=20
>=20
> I was wondering if you or Steve would be interested in a patch for
> this to apply to Scarthgap. If so, I'd be happy to send one in.=20

I think scarthgap and older users would probably appreciate having this
fixed so I'd be willing to take a patch.

Cheers,

Richard



