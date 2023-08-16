Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28FEC04FE2
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 18:08:00 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.167691.1692209278374909445
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Aug 2023 11:07:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CY1KX7Ro;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fe8a1591c8so53018335e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Aug 2023 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692209276; x=1692814076;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lVMBto2urqVuXM43ibLyE7VUA79eALYjqak4f5StOgA=;
        b=CY1KX7Roe+1Em8MqW2l5slGaGLNzar1gog/CepJDzpenN3yD2qiVcOdTV4/ZI8wINd
         QZto8i6oSrw04LX1fm7IZ3oYXUZoVmqf5iVcPqCAwcYBrl09PusoETDf8gJt7ZnVNCEu
         uanqc+TUG3nUlO6JP7cwXLHgrCspVb1xRmgp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692209276; x=1692814076;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVMBto2urqVuXM43ibLyE7VUA79eALYjqak4f5StOgA=;
        b=AcjW/AAvSZxKjJhM5zhPm/ryTx4gUXNNu6sobh+U0KJHi0EbOAeSNUkBBqoZUlWwQV
         JHhBOGRjGL2tD6L/pw7Tc3svh934da56fVsvTdlV1AfyypqcNPdqz+2TijtG6D/WiYLx
         GikZHTvXnGqjepr6VDJ95xes4OoKFwkTV3AlPgRS/dsj5kG2CvxwFKhl1Q6mhwhEZnzO
         ufzqLqkq4sTBhedotQ2wKYufHYJMgBzRO1EgcyzyRqcya6Hwh0ZqEEgGpC34693Cehge
         n434MW9Cl1Zdf6Wz6wX0AeNq5ICLtXAPHBh5lMDQ2c/Bm8VdJ1dzF6heuJBa4dFbxVJ2
         iO0g==
X-Gm-Message-State: AOJu0YzSrhA+nrKMD9JtFbVc/fZ5aDi5K6er1xOPSXr1to2FLEA7ZVbl
	NyTWxJegKFK+0z1SAZHv58HKIQ==
X-Google-Smtp-Source: AGHT+IFAU2Q9wZJ2tvIJ7D7+rrdYcSrt6WMtV+tj2MtaebmUG/7vBSGI2osetOySYLrV7lZdcfGRMw==
X-Received: by 2002:a05:600c:231a:b0:3fb:b618:f7b3 with SMTP id 26-20020a05600c231a00b003fbb618f7b3mr2218054wmo.21.1692209276617;
        Wed, 16 Aug 2023 11:07:56 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b782:7711:f696:663e? ([2001:8b0:aba:5f3c:b782:7711:f696:663e])
        by smtp.gmail.com with ESMTPSA id n26-20020a7bcbda000000b003fc02218d6csm139120wmi.25.2023.08.16.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 11:07:56 -0700 (PDT)
Message-ID: <7da097e1dee5267af6672fcfbe94da8330cef7f0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add new srcrev fetcher API
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 16 Aug 2023 19:07:55 +0100
In-Reply-To: <2023081618054635e1a5b3@mail.local>
References: <20230811130453.29278-1-richard.purdie@linuxfoundation.org>
	 <2023081618054635e1a5b3@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Aug 2023 18:08:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14947

On Wed, 2023-08-16 at 20:05 +0200, Alexandre Belloni wrote:
> Hello,
>=20
> On 11/08/2023 14:04:53+0100, Richard Purdie wrote:
> > Add new functions to return some of the get_srcrev data in new and diff=
erent
> > ways. We need two different forms of the data, one is a string to injec=
t into
> > PKGV, the other is the full revisions as a string to include in hash co=
mputations
> > so that the hash changes when the input revisions change.
> >=20
> > This allows us to clean up and simplify the code in OE-Core and move th=
e
> > version information from PV to PKGV.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/fetch2/__init__.py | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 2428a26fa6..c42961cb04 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -753,7 +753,7 @@ def get_autorev(d):
> >      d.setVar("__BBAUTOREV_SEEN", True)
> >      return "AUTOINC"
> > =20
> > -def get_srcrev(d, method_name=3D'sortable_revision'):
> > +def _get_srcrev(d, method_name=3D'sortable_revision'):
> >      """
> >      Return the revision string, usually for use in the version string =
(PV) of the current package
> >      Most packages usually only have one SCM so we just pass on the cal=
l.
> > @@ -774,6 +774,7 @@ def get_srcrev(d, method_name=3D'sortable_revision'=
):
> >      d.setVar("__BBINSRCREV", True)
> > =20
> >      scms =3D []
> > +    revs =3D []
> >      fetcher =3D Fetch(d.getVar('SRC_URI').split(), d)
> >      urldata =3D fetcher.ud
> >      for u in urldata:
> > @@ -781,16 +782,19 @@ def get_srcrev(d, method_name=3D'sortable_revisio=
n'):
> >              scms.append(u)
> > =20
> >      if not scms:
> > -        raise FetchError("SRCREV was used yet no valid SCM was found i=
n SRC_URI")
> > +        d.delVar("__BBINSRCREV")
> > +        return "", revs
> > +
> > =20
> >      if len(scms) =3D=3D 1 and len(urldata[scms[0]].names) =3D=3D 1:
> >          autoinc, rev =3D getattr(urldata[scms[0]].method, method_name)=
(urldata[scms[0]], d, urldata[scms[0]].names[0])
> > +        revs.append(rev)
> >          if len(rev) > 10:
> >              rev =3D rev[:10]
> >          d.delVar("__BBINSRCREV")
> >          if autoinc:
> > -            return "AUTOINC+" + rev
> > -        return rev
> > +            return "AUTOINC+" + rev, revs
> > +        return rev, revs
> > =20
> >      #
> >      # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
> > @@ -806,6 +810,7 @@ def get_srcrev(d, method_name=3D'sortable_revision'=
):
> >          ud =3D urldata[scm]
> >          for name in ud.names:
> >              autoinc, rev =3D getattr(ud.method, method_name)(ud, d, na=
me)
> > +            revs.append(rev)
> >              seenautoinc =3D seenautoinc or autoinc
> >              if len(rev) > 10:
> >                  rev =3D rev[:10]
> > @@ -823,7 +828,21 @@ def get_srcrev(d, method_name=3D'sortable_revision=
'):
> >          format =3D "AUTOINC+" + format
> > =20
> >      d.delVar("__BBINSRCREV")
> > -    return format
> > +    return format, revs
> > +
> > +def get_hashvalue(d, method_name=3D'sortable_revision'):
> > +    pkgv, revs =3D _get_srcrev(d, method_name=3Dmethod_name)
> > +    return " ".join(revs)
> > +
>=20
> I guess you already know but this causes:
>=20
> ERROR: Failure expanding variable fetcher_hashes_dummyfunc[vardepvalue], =
expression was ${@bb.fetch.get_hashvalue(d)} which triggered exception Attr=
ibuteError: module 'bb.fetch2' has no attribute 'get_hashvalue'
> The variable dependency chain for the failure is: fetcher_hashes_dummyfun=
c[vardepvalue]

It needs the corresponding patch on the bitbake list and which is in
bitbake master-next.

Cheers,

Richard

