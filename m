Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QogA3-0005Vi-9p
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 20:27:19 +0200
Received: by vxj14 with SMTP id 14so314484vxj.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Aug 2011 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=6jB8UIpQfWFh1jKb1M6K2sek4g1B4GMb1jHBvSW810M=;
	b=u8pQtzYytFj9lGxElyHZx5VfS1QN0VUVuM1MpxFzkQjld+Qr0MYTkj2Mm2rFeKELHb
	b7FCIRpE7sNpyUGp9ngOuJ6MqgJsTWV/iviPCbztK4WUa7ewmhPfVRH7nBPq7/bgGsW2
	TAVw78fv9bjHNcusolPpJpe99h/miiMlCfe/k=
Received: by 10.52.24.16 with SMTP id q16mr344612vdf.227.1312395776117; Wed,
	03 Aug 2011 11:22:56 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.112.194 with HTTP; Wed, 3 Aug 2011 11:22:36 -0700 (PDT)
In-Reply-To: <359B10B9B28B294BAA6405D9320312E0111E934062@naemmail08.na.leapfrog.com>
References: <359B10B9B28B294BAA6405D9320312E0111E93405D@naemmail08.na.leapfrog.com>
	<CABcZANmNObv54E4yW52t1wYt6pyranwAS5Hth8S1cF61ZM5N=g@mail.gmail.com>
	<359B10B9B28B294BAA6405D9320312E0111E934062@naemmail08.na.leapfrog.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 3 Aug 2011 11:22:36 -0700
X-Google-Sender-Auth: wToGlKjT6ejVnW-VHuRHE6gHsaM
Message-ID: <CABcZAN=g64xzJXijTwoJN-a6LQODb1itMBcDgtwnZR7kjwdRsg@mail.gmail.com>
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
X-List-Received-Date: Wed, 03 Aug 2011 18:27:19 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 3, 2011 at 11:21 AM, Daniel Lazzari <dlazzari@leapfrog.com> wro=
te:
>>-----Original Message-----
>>From: kergoth@gmail.com [mailto:kergoth@gmail.com] On Behalf Of Chris
>>Larson
>>Sent: Tuesday, August 02, 2011 6:24 PM
>>To: Daniel Lazzari
>>Cc: bitbake-devel@lists.openembedded.org
>>Subject: Re: [bitbake-devel] Bug with clearing SRCREV cache
>>
>>On Tue, Aug 2, 2011 at 12:06 PM, Daniel Lazzari <dlazzari@leapfrog.com>
>>wrote:
>>> I=E2=80=99m not exactly sure if this is an oe-core or a bitbake bug, so=
 I=E2=80=99m
>>trying
>>> here first. I noticed the other day that one of our recipes that pulls
>>> source from svn and uses SRCREV =3D =E2=80=9CAUTOINC=E2=80=9D wasn=E2=
=80=99t pulling the latest
>>> revision even after a cleanall. After a lot of digging, I discovered
>>that
>>> fetcher_init() was clearing the srcrev cache in =E2=80=9Ctmp-angstrom_2=
010_x =E2=80=9C
>>> rather than =E2=80=9Ctmp-angstrom_2010_x-uclibc=E2=80=9D. It appears th=
at the
>>following line
>>> in persist_data.py is the culprit:
>>>
>>>
>>>
>>> =C2=A0=C2=A0=C2=A0 cachedir =3D (bb.data.getVar("PERSISTENT_DIR", d, Tr=
ue) or
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.data.getVar("CACHE", d, True))
>>>
>>>
>>>
>>> PERSISTENT_DIR doesn=E2=80=99t evaluate to the correct value. Changing =
it to
>>just
>>> pull from CACHE seems to fix it, but I=E2=80=99m not sure how important
>>> PERSISTENT_DIR is or even what it does.
>>
>>What do you mean by "the correct value" here? PERSISTENT_DIR is
>>exactly what it sounds like, the location where persist_data stores
>>its database(s), that's it.
>>--
>>Christopher Larson
>>clarson at kergoth dot com
>>Founder - BitBake, OpenEmbedded, OpenZaurus
>>Maintainer - Tslib
>>Senior Software Engineer, Mentor Graphics
>
> Well, I may just be confused as to what the correct value of PERSISTENT_D=
IR should be, but I would expect it to be the same value as CACHE "tmp-angs=
trom_2010_x-uclibc" and not "tmp-angstrom_2010_x". If I do a "bitbake -e li=
nux-libc-headers | grep PERSISTENT_DIR" I get the value I expect, so maybe =
PERSISTENT_DIR is changing after fetcher_init() (where the cache is cleared=
) but before the first do_fetch() task (where the cache is checked for the =
SRCREV).

As khem pointed out, this is due to the use of _append with TMPDIR.
Early uses of the variable by bitbake do not have the appended bits
applied, later uses do.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


