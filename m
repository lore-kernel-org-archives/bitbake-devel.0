Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SL1cC-0000Lt-Pn
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Apr 2012 02:22:20 +0200
Received: by qcso7 with SMTP id o7so5636885qcs.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Apr 2012 17:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=yZNDL8phZ9o0qoaScARyDxWUfR3EnzM1PsVyAmp1kk4=;
	b=Kn/2VTB/LeXJF/1yWpEcjcNML2TCXAlZkVoHN0OY1Ce3KNtunJzAoYm8lBXzZbEKsE
	FX4F3gCamKZnvuTRnluCv0aLoBI+zyOske7NKM9KH5OsKAqMgZD10XYanaAGr5LYqKWu
	BF5epIywqWK+kfnYOfhsuh5ear0xL9cM4KXOnb+KWOK5bo85OC1UncpgD2rEdNmM+1q6
	9cRi7CJDVXb60aaQ7iPrscM/0E4tUQuHT3+lsYfvdBYSPNzb+ZaP2KemIN53PFx5Pxlp
	RAC1iBmDC8yMV3tZuMNlozs9Gcx+1OXwsGNmhwL4oSR7dJdv0Ah7oZGiqDH5mHb+byNr
	16MQ==
Received: by 10.224.211.5 with SMTP id gm5mr5673717qab.33.1334880771256; Thu,
	19 Apr 2012 17:12:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.79.79 with HTTP; Thu, 19 Apr 2012 17:12:31 -0700 (PDT)
In-Reply-To: <E7A9054A5ACABE48B0E540E46E862B0F0427CB82@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
	<671D7BD596E04EE1961D6EA1C734C816@gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427C5FA@NAEMMAIL01.na.leapfrog.com>
	<CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427CB32@NAEMMAIL01.na.leapfrog.com>
	<1334874480.3028.18.camel@ted>
	<E7A9054A5ACABE48B0E540E46E862B0F0427CB82@NAEMMAIL01.na.leapfrog.com>
From: Chris Larson <kergoth@gmail.com>
Date: Thu, 19 Apr 2012 17:12:31 -0700
Message-ID: <CABcZANnEFUW0AMdkusU8-RrrNKq2kQmCNyZM=k+9Y8wQbfiLBg@mail.gmail.com>
To: Daniel Lazzari <dlazzari@leapfrog.com>
Cc: "'bitbake-devel@lists.openembedded.org'
	\(bitbake-devel@lists.openembedded.org\)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: python function used in variable expansion called multiple times per recipe
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
X-List-Received-Date: Fri, 20 Apr 2012 00:22:20 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 4:13 PM, Daniel Lazzari <dlazzari@leapfrog.com> wro=
te:
>
>
>>On Thu, 2012-04-19 at 21:24 +0000, Daniel Lazzari wrote:
>>> >> I think immediate expansion is what I=E2=80=99ll need to use, thanks=
 for the tip.
>>> >> That at least brings the invocation down to once per run. Unfortunat=
ely,
>>the
>>> >> variable doesn=E2=80=99t seem to get filled in when I change to imme=
diate
>>> >expansion.
>>> >>
>>> >> def testFunc(bb, d):
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print( bb.da=
ta.getVar("PN", d, True) )
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "e1"
>>> >>
>>> >> EXTERNPV :=3D "${@testFunc(bb, d)}"
>>> >>
>>> >> Now only prints the package name once, but using =E2=80=93e, I don=
=E2=80=99t see the
>>> >> variable EXTERNPV at all.
>>> >
>>> >Don't know what to tell you. It does work, so it's something wrong on
>>> >your end. Either it's returning an empty string, which will result in
>>> >-e only showing the commented out definition, or it's raising an
>>> >exception, or something else in your setup. Aside: you don't need to
>>> >pass 'bb' in. That namespace is always accessible, even from def'd
>>> >python functions.
>>> >--
>>> >Christopher Larson
>>>
>>> Just thought I'd provide an update real quick on this. I discovered,
>>> to my dismay, that even doing an immediate expansion still ran the
>>> code before every task for that recipe. I switched to using an event
>>> handler, but the RecipeParsed event occurs before every task for that
>>> recipe. Eventually I discovered that the variable BB_WORKERCONTEXT is
>>> set for RecipeParsed events when they are occurring before a task, but
>>> not for the initial parse. Also, I discovered that setting a variable
>>> in the event handler would not necessarily keep it set through
>>> building the recipe. Thus I devised the below code to run the time
>>> intensive code during initial parse and cache the value in a file so
>>> it can be picked up again in later events. I'm leaving this here in
>>> case it helps someone else.
>>
>>Just as a note, we have the persist_data code in bitbake which was
>>written for this kind of reason in relation to SRCREV and AUTOINC which
>>uses a sqlite backend as the storage. There isn't anything wrong with
>>what you're doing, I just thought I'd mention it.
>>
>>Cheers,
>>
>>Richard
>
> That sounds like a better alternative, but I have no idea how to implemen=
t it. Is there documentation for it? I'm not even sure how to get at the pe=
rsist_data from the event handler. Is there a way to access it using d or s=
omething?

The bb.persist_data python module just provides a convenience
dictionary wrapper around an sqlite3 database.

persist =3D bb.persist_data.persist('some_identifier', d)
persist['foo'] =3D 'bar'
--=20
Christopher Larson


