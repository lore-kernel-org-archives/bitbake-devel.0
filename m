Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web12.13454.1585148608859341256
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2020 08:03:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=vMg7GkFW;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id u10so3532808wro.7;
        Wed, 25 Mar 2020 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9mkONgx0iEq+emT5HbRwUPL57TNuW3VZ+uZB1c/HbjM=;
        b=vMg7GkFWPDv0CbFL+6WrcyfpcoVEAA3Bn5tlt29JNg1qwo6qYfOaZ3pIzCEIysu5e5
         4HA4tO515xc4SCP6FLfa9nb2Ed6lLJw0CtmMC7E/zZrn3d1+CDDBSqQRBflnqToicWZB
         +5dceUFMLRH67S/mMiPczZuXu1ST9CQeHDFHPS2SMsc4bdp0P5yWf5s+BbspgYCL3/eu
         l2e5Grgx4jTdWzpWlXZUT+iDjA9NwPHQxX2sLUSdmf63ml6q0G16RN+OdHF7t4cvjocS
         egAewjOd5Ps70TR2/n5effAe4j7kxhgnmURtMaOAuGcEymoTAMfyIOmoedAcYK+YZLu2
         bM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9mkONgx0iEq+emT5HbRwUPL57TNuW3VZ+uZB1c/HbjM=;
        b=UPrfFV0CQ8hd4T7yF1mMZhR5dwrmUfCgqbm7uBItQxEDhoeArVzG1XlPYpJEkLe1wj
         07I1jgDje/JLVwGCc0lvgGCJuwFPKinUF+BLmQ2122SE1VBdVp6SbimwFcnjzGD6CNqW
         kZnrjsKkNTY/WQsnmbPbhWfdB+GPZ/5WFecaKaxFpQUWiqAGkSHWhClPBNZQx/K0UrH7
         bgcMrDT8b0gRcriZ3ocADcf11/sDMIp5RTgAg1xGHDGdFNXk9az/a7eNucC/musvABkk
         ndbqP9zcrhJE3FJ1dEV+x//wK0alYsweuQjX7s5EUnLbNk8tKq89HPv7b0Mi7A2dHrbV
         5yxw==
X-Gm-Message-State: ANhLgQ2i0JVoCZ3nxx8rTAHWUNTXnFNXmUwy28e5XlF6XFvyWMf7C2mk
	3Ndvmv2eY56NbCqIza96ftU=
X-Google-Smtp-Source: ADFU+vtOZUfJtDvC6ZtR/jBPXl6x+g+vbjM4PnCSo56lnO3ZDAoK6KgFlicA9Rvrz5RJLkKmNt4RNg==
X-Received: by 2002:adf:e48c:: with SMTP id i12mr3873199wrm.173.1585148607333;
        Wed, 25 Mar 2020 08:03:27 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id u16sm34699383wro.23.2020.03.25.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:03:25 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Wed, 25 Mar 2020 16:03:25 +0100
To: Michael Halstead <mhalstead@linuxfoundation.org>
Cc: akuster808 <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org,
	openembedded-core <openembedded-core@lists.openembedded.org>,
	openembedded-architecture@lists.openembedded.org,
	openembeded-devel <Openembedded-devel@lists.openembedded.org>
Subject: Re: [oe] [bitbake-devel] Mailing list platform change March 20th
Message-ID: <20200325150325.yq5jtofhnxaui6he@jama>
References: <CADfgfobNNXr9HSOiwyamzbZ4q1uc8wgD5PzobDF56cDyYui-HQ@mail.gmail.com>
 <CADfgfoYCjVip=oc_U0TdFzOVst5U-KU+R31JhdckRv77APzQ-g@mail.gmail.com>
 <CADfgfob4=Zeh=jn9b9uMqq6Wnt83oGmJ-8yf1wSXYEFTppv2Bg@mail.gmail.com>
 <24a37655-8c0b-ca10-543e-90a32bc6bdb9@gmail.com>
 <CADfgfoZRZCM_Dvot5_z4YnG+OOyMg6xvDE13XQOK50wpucZWFA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADfgfoZRZCM_Dvot5_z4YnG+OOyMg6xvDE13XQOK50wpucZWFA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Groupsio-MsgNum: 11215
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qaryvwey46kdcbfu"
Content-Disposition: inline

--qaryvwey46kdcbfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 05:44:36PM -0700, Michael Halstead wrote:
> The migration to Groups.io is nearly complete. All functionality is ready
> to use and you can send e-mail now. Archives are in place except for the
> most recent from the Openembedded-commits list. Those are continuing to
> import.
>=20
> There is no need to update your address book as the list addresses have n=
ot
> changed.
>=20
> If you encounter any issues please visit
> https://www.openembedded.org/wiki/GroupsMigration for the latest
> information. If your concern isn't addressed e-mail me directly.

Hi,

thanks Michael!

Can you please check if git hooks sending e-mail notifications still
work or need some change (possibly related to this)?

There were new commits recently in couple repositories, but last e-mail
=66rom git hook I see from Mar 19th.

Cheers,

--qaryvwey46kdcbfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCXntyvAAKCRA3VSO3ZXaA
HEkqAKCW3OJ3y78pYM5VoXeQABS+7OfjkACfchnLCBZkk0N1lXaSELcmdIGyYgw=
=ZMvD
-----END PGP SIGNATURE-----

--qaryvwey46kdcbfu--
