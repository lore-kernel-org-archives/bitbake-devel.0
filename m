Received: from mail-pb0-f49.google.com ([209.85.160.49])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <trungiee@gmail.com>) id 1TxmQk-00044n-8O
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 23:34:58 +0100
Received: by mail-pb0-f49.google.com with SMTP id un15so4225043pbc.22
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jan 2013 14:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:content-type:mime-version:subject:from:in-reply-to:date
	:content-transfer-encoding:message-id:references:to:x-mailer;
	bh=FiTHZUyUs9pgSKRgMjpgfih6Pbmo9uLYS5TyS4vT71U=;
	b=KeV6QAqrjQEGnOw6J6rIXlE60JK8UVjYYp8/+9FKc9SGnFbK2jO9Afro8uh78FuVby
	Xdawl4aO2Iuc719umhgU4f+C9fVG9YM5N6rA+KNadDVfOP+4WVtcvf2exkzw4/qFDAAm
	odfxVQry/v1Pa+yG119LGGKxHa7ovdRUdObUeQakLDchhanSxEcmvw8pWCyiVvDUbT8b
	ckR5aM2oCxOML+cFrD6wEAN6D5UVXIib6MaoyTZGgdLsmo3NMufUu3c0FERchHblPdJ4
	8mrch7n16LDMjcriW+8waS6lYckCon9p1erTaNcg7+A8RGHRiXAZvN3y9A2aFLPT4yD9
	M+9A==
X-Received: by 10.68.227.73 with SMTP id ry9mr61638738pbc.73.1358893166862;
	Tue, 22 Jan 2013 14:19:26 -0800 (PST)
Received: from [192.168.0.26] (CPE-60-225-117-182.hhui4.ken.bigpond.net.au.
	[60.225.117.182])
	by mx.google.com with ESMTPS id v2sm12135604paz.36.2013.01.22.14.19.23
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 22 Jan 2013 14:19:25 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
From: Trung Hoang <trungiee@gmail.com>
In-Reply-To: <50FEC2BE.3020902@windriver.com>
Date: Wed, 23 Jan 2013 09:21:08 +1100
Message-Id: <2ABB9CD2-9E60-4E5A-A9B0-1C96F25A424B@gmail.com>
References: <6811518C-5E13-40A7-8B8B-57C2810DEA8B@gmail.com>
	<CAHUNapSSaOqnkOZq3_BaMthqY6hG+JTxvi9XpgD_38yT6+wDhA@mail.gmail.com>
	<50FEC2BE.3020902@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
X-Mailer: Apple Mail (2.1499)
Subject: Re: Display mode
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 22 Jan 2013 22:34:58 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Ahh yes, Knotty2 rocks!=20

For those who don't get this by default, i did this..=20

`bitbake -u knotty2 gumstix-console-image'=20

I do notice that sometimes the "Running task 3160 of 3162 =85" does get =
buggy.. Instead of updating that line it makes a new line so i end up =
with=85=20

Running task 3160 of 3162..
Running task 3161 of 3162..
Running task 3162 of 3162=85
0: =85



On 23/01/2013, at 3:47 AM, Mark Hatle <mark.hatle@windriver.com> wrote:

> On 1/22/13 10:37 AM, Trevor Woerner wrote:
>> On Tue, Jan 22, 2013 at 1:20 AM, Trung Hoang <trungiee@gmail.com> =
wrote:
>>> The current git HEAD of bit bake nicely displays the x threads and =
what is happening on them instead of constantly scrolling in detail what =
is exactly happening.
>>=20
>> This feature is called "knotty".
>>=20
>>> Is this feature configurable? How do i enable it on older versions =
of bitbake? As the gumstix setup scripts check out a older version of =
bit bake and it displays reams and reams of info.
>>=20
>> Knotty was added this past... August (?) (or, perhaps it is more
>> correct to say "it was made the default" this past August?). So =
making
>> it work on older versions would require back-porting it to those
>> versions.
>=20
> "In general", newer versions of bitbake work with older systems.  =
There is one main condition where this can be problematic however.  =
There was a period of time where, in python functions, tabs were all =
converted to spaces.  So code is in bitbake to check for this condition.
>=20
> If you try to use a modern bitbake with an older system that still has =
tabs, you can get failures.
>=20
> Note, it does require testing to verify that the newer bitbake will =
work on an older configuration, but it has in my experience.
>=20
> --Mark
>=20
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



