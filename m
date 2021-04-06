Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 by mx.groups.io with SMTP id smtpd.web09.1175.1617724646159645180
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Apr 2021 08:57:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: kernel.crashing.org, ip: 76.164.61.194, mailfrom: mark.hatle@kernel.crashing.org)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 136FufNj009261
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 6 Apr 2021 10:56:42 -0500
Subject: Re: [bitbake-devel] still confused about valid wildcarding for bbappend files
To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
        BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <e66c2878-5f82-394b-e6a-ccd45dc44c73@crashcourse.ca>
From: "Mark Hatle" <mark.hatle@kernel.crashing.org>
Message-ID: <4d45946c-442a-53eb-53e9-b480a2b83112@kernel.crashing.org>
Date: Tue, 6 Apr 2021 10:56:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <e66c2878-5f82-394b-e6a-ccd45dc44c73@crashcourse.ca>
X-MIME-Autoconverted: from 8bit to quoted-printable by kernel.crashing.org id 136FufNj009261
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 4/4/21 2:51 PM, Robert P. J. Day wrote:
>=20
> from current bitbake manual:
>=20
> https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-m=
anual-intro.html?highlight=3Dwildcard#append-files
>=20
> "The use of the =E2=80=9D % =E2=80=9D character is limited in that it on=
ly works
> directly in front of the .bbappend portion of the append file=E2=80=99s =
name.
> You cannot use the wildcard character in any other location of the
> name."

The filename is broken up into: name_version.bbappend  I believe the inten=
tion
is that only "version" can contain wild cards.

>   that *appears* to suggest that you can have one (and exactly one)
> "%" before the ".bbappend" suffix. so how does that explanation cover
> examples in some of the OE layers like:
>=20
>   meta-security/recipes-kernel/linux/linux-%_5.%.bbappend
>   meta-anaconda/recipes-gnome/gtk+/gtk+3_%.%.%.bbappend

"%" is a wildcard for the _version_ only.

It is my understanding it can be used in any part of the version string, b=
ut can
NOT be used in the name.  The above example shows it being used in the lin=
ux-
recipe name.  So perhaps that has changed.

The later example (gtk+3) it's being used in the versioning, but looks
unnecessary as it's just patching all of the version elements anyway.

The general case is:

recipe_1.0.3.bb

recipe_%.bbappend - match all versions

recipe_1.%.bbappend - match all 1.x versions

recipe_1.0.%.bbappend - match all 1.0.x versions

Any other usage might work, but I doubt has been seriously tested.  (And t=
he key
isn't that the '%' be right before the bbappend!  It just happens to be th=
ere.)

--Mark

> rday
>=20
>=20
>=20
>=20
>=20
