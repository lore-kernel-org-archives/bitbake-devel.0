Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SHc0B-00052v-Nz
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Apr 2012 16:25:00 +0200
Received: by qcso7 with SMTP id o7so2986040qcs.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2012 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=8avcxMA21FTUCP2YTdnEa3M7PX/zncKT3bKCdECV/IQ=;
	b=gQr3mVolEPZ94Psbqh+9sPLgNrNBX6lrkR1Y/s2g0eHFp2Kn5FQXvI4gTq5EZh0t4P
	2z6s4DX8VZozH32NciQCxJ7dkq7KYUwXAryfAOCvmxoHQgqyvKSdd7x1wRmsBoTSwi7p
	//rVbBeTSrnv9nLQxgfyHOdRmJjIHYxVkP+G/3sialZLs0ea/oobpqU5EZ8+/BBHf41F
	0Zef8S+x9cvaP7GsdpB8KbQNaZWgEPQtqA7CyvmIvdOW53iAzp0UH1Et/Ewzgt48ksgT
	/YkXUUhllFnrIytfdt1XZNyligNWoW9YH48lP2NT8mBIPEbCuud2mDZP5lMlZQM/NmGd
	FplQ==
Received: by 10.224.111.5 with SMTP id q5mr14636801qap.41.1334067341732; Tue,
	10 Apr 2012 07:15:41 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.79.79 with HTTP; Tue, 10 Apr 2012 07:15:21 -0700 (PDT)
In-Reply-To: <4F843FC1.1080309@windriver.com>
References: <4F83EE3C.8040904@windriver.com>
	<CABcZANm628Wm0TYo45eSjLsVjzpseV=4__he=s=Lz_r1ekyJBw@mail.gmail.com>
	<4F843FC1.1080309@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 10 Apr 2012 07:15:21 -0700
X-Google-Sender-Auth: tmMu-5VhQoWvrUdK-SELsDcyLvQ
Message-ID: <CABcZAN=LTh8GDhz5Zs0SsOkrfmsGK+-6t4+DsC23_Z-qHMk7xw@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: questions about bitbake world
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
X-List-Received-Date: Tue, 10 Apr 2012 14:25:00 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 7:12 AM, Robert Yang <liezhi.yang@windriver.com> wr=
ote:
> On 04/10/2012 09:58 PM, Chris Larson wrote:
>>
>> On Tue, Apr 10, 2012 at 1:24 AM, Robert Yang<liezhi.yang@windriver.com>
>> =C2=A0wrote:
>>>
>>> In the following code:
>>>
>>> def buildWorldTargetList(self):
>>> ...
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for f in self.status.possible_world:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0terminal =3D True
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pn =3D self.status.pkg_fn[f]
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for p in pn_provides[pn]:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if p.startswith(=
'virtual/'):
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pa=
rselog.debug(2, "World build skipping %s due to %s
>>> provider starting with virtual/", f, p)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te=
rminal =3D False
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0br=
eak
>>> ...
>>>
>>> Does it mean that if a recipe contains:
>>>
>>> PROVIDES =3D "virtual/something"
>>>
>>> Then it would not be built until a pkg depends on it? Why we design it =
in
>>> this
>>> way, please?
>>
>>
>> The original intent with world was that when two recipes provided the
>> same thing, we'd still only want to build one of them, not both, as
>> building both can cause problems with stepping on one another in
>> sysroot, etc.
>
>
> Thanks for your reply, but it seems that it builts none currently.

Fair point, I think in certain cases we also only wanted to build
things if they got pulled in via a dependency. For example, iirc
native and cross both exclude themselves from world via a variable set
in the classes. I don't recall if such was the case here, however.
--=20
Christopher Larson


