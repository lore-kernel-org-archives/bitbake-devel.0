Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QWVym-000532-GJ
	for bitbake-devel@lists.openembedded.org;
	Tue, 14 Jun 2011 17:56:36 +0200
Received: by vws2 with SMTP id 2so5113498vws.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2011 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:sender:in-reply-to:references:from
	:date:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=h1WmEkomzg9XMEw6RWr5QAk6ZoZldHFWEnbeOf6yml8=;
	b=pNqhgKdGkSN9HmlR7sHyYvxvYoULXGmCvIJYvDFkpH7r3gMpZvNlJDAcX4Ywhm0Ebv
	63nvMROF3lncgioHIpmT7EVx5RUzZ7edP0go29vaaHJuuGGFnO2Kzr7wpGG1NWwqP4Wn
	UpGT42ZsJ62hlVAJWOnWrY+XFldDsBlXMBVss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	b=TJc1rCf5DgcTfJZRm4ResnbaZ2C7zwOh1xqAMPHaKAmOHSV/AzhI0+jMo80WavUQkU
	NIhY+X3x+qAczvInLjA/ZICwAS/m3MwZ93sMIOXHsU5bzgRMnAPTgigiDEufLy9oXL1p
	V9rK7Yp/U2bIG9JaDkyvBKRjn5dU0UHDaYkfE=
Received: by 10.52.111.71 with SMTP id ig7mr18046vdb.209.1308065995085; Tue,
	14 Jun 2011 08:39:55 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.181.2 with HTTP; Tue, 14 Jun 2011 08:39:35 -0700 (PDT)
In-Reply-To: <BANLkTik1j9_BR7qPF1hH-X6t=GXE3v4pmw@mail.gmail.com>
References: <20110610230326.GA20047@sakrah.homelinux.org>
	<BANLkTik1j9_BR7qPF1hH-X6t=GXE3v4pmw@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 14 Jun 2011 08:39:35 -0700
X-Google-Sender-Auth: ryfg_qnuMFz-YrMr6DYi71dtk7A
Message-ID: <BANLkTi=YyOez5MjdYSWPYfNFcPsxaTG+gw@mail.gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake quitting without parsing or doing anything
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
X-List-Received-Date: Tue, 14 Jun 2011 15:56:36 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2011 at 4:51 PM, Khem Raj <raj.khem@gmail.com> wrote:
> On Fri, Jun 10, 2011 at 4:03 PM, Khem Raj <raj.khem@gmail.com> wrote:
>> Hi
>>
>> I started to experience this error on my machine when I updated bitbake
>> in my setup today. bitbake console-image simply quits without doing anyt=
hing
>> and it dies pretty early. Same setup worked fine last week I did not cha=
nge
>> anything
>>
>> I could trace it go until
>>
>> bb.event.fire(bb.event.ConfigParsed(), data) line 693 in lib/bb/cooker.p=
y
>> and silently quit after that
>>
>> Bisecting resulting in this commit being bad for me.
>>
>> Let me know if I more information is needed
>>
>>
>> d21d5954d0c08b1c80b72c5f37becc2e58ec916a is the first bad commit
>> commit d21d5954d0c08b1c80b72c5f37becc2e58ec916a
>> Author: Richard Purdie <richard.purdie@linuxfoundation.org>
>> Date: =C2=A0 Wed Jun 8 13:08:52 2011 +0100
>>
>> =C2=A0 =C2=A0bitbake/server: Move server specific code into the server b=
ackend and create a server API
>>
>> =C2=A0 =C2=A0Move the server implementation specific code into the serve=
r backend where
>> =C2=A0 =C2=A0it belongs and replace this with a set of object method cal=
ls which
>> =C2=A0 =C2=A0establish the server, detach it and then connect to it usin=
g appropriate
>> =C2=A0 =C2=A0IPC.
>>
>> =C2=A0 =C2=A0Signed-off-by: Richard Purdie <richard.purdie@linuxfoundati=
on.org>
>>
>
> strangely recloning it works fine again. Dont know why

I just ran into this one. bitbake exists silently, no useful output,
-DDD doesn't result in anything useful.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


