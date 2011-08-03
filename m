Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QoQGh-0006Rq-I0
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 03:29:08 +0200
Received: by vxh2 with SMTP id 2so321391vxh.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Aug 2011 18:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=dsd/jztcJXmpnWWB1blnVysN+enu5cvRHy7OqnqGVeM=;
	b=iiVVdPWvY0UYQaSj5ovAwa59rcnLMT+aytbsg9A1kG6PKh3d9EKqSvVms2JXav7Rc8
	zO9As8ylQsxfdaMnLq5UYCMRJBo8cMi2EpBA2WEZ5cnZu5yqly+FkH8jhNV+Cw1ShZ5J
	/RbqOh0x+OPmNVZtGKmfpT29P7DWSV2uQ+we4=
Received: by 10.52.75.170 with SMTP id d10mr6405621vdw.160.1312334685271; Tue,
	02 Aug 2011 18:24:45 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.112.194 with HTTP; Tue, 2 Aug 2011 18:24:25 -0700 (PDT)
In-Reply-To: <359B10B9B28B294BAA6405D9320312E0111E93405D@naemmail08.na.leapfrog.com>
References: <359B10B9B28B294BAA6405D9320312E0111E93405D@naemmail08.na.leapfrog.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 2 Aug 2011 18:24:25 -0700
X-Google-Sender-Auth: 65pOPqTCde9rnq7zN1p90tp5H5s
Message-ID: <CABcZANmNObv54E4yW52t1wYt6pyranwAS5Hth8S1cF61ZM5N=g@mail.gmail.com>
To: Daniel Lazzari <dlazzari@leapfrog.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Bug with clearing SRCREV cache
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
X-List-Received-Date: Wed, 03 Aug 2011 01:29:08 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 2, 2011 at 12:06 PM, Daniel Lazzari <dlazzari@leapfrog.com> wro=
te:
> I=E2=80=99m not exactly sure if this is an oe-core or a bitbake bug, so I=
=E2=80=99m trying
> here first. I noticed the other day that one of our recipes that pulls
> source from svn and uses SRCREV =3D =E2=80=9CAUTOINC=E2=80=9D wasn=E2=80=
=99t pulling the latest
> revision even after a cleanall. After a lot of digging, I discovered that
> fetcher_init() was clearing the srcrev cache in =E2=80=9Ctmp-angstrom_201=
0_x =E2=80=9C
> rather than =E2=80=9Ctmp-angstrom_2010_x-uclibc=E2=80=9D. It appears that=
 the following line
> in persist_data.py is the culprit:
>
>
>
> =C2=A0=C2=A0=C2=A0 cachedir =3D (bb.data.getVar("PERSISTENT_DIR", d, True=
) or
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.data.getVar("CACHE", d, True))
>
>
>
> PERSISTENT_DIR doesn=E2=80=99t evaluate to the correct value. Changing it=
 to just
> pull from CACHE seems to fix it, but I=E2=80=99m not sure how important
> PERSISTENT_DIR is or even what it does.

What do you mean by "the correct value" here? PERSISTENT_DIR is
exactly what it sounds like, the location where persist_data stores
its database(s), that's it.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


