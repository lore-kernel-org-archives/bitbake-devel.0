Received: from mail-qa0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SMrAw-0007oG-HZ
	for bitbake-devel@lists.openembedded.org;
	Wed, 25 Apr 2012 03:37:46 +0200
Received: by qabg1 with SMTP id g1so3181951qab.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Apr 2012 18:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=OWd0+DrGUEzb3aZr6c8EQgPnpPa6DxcBx+rAwD/GTFQ=;
	b=0Xp7tSLmzvpyMT/M2PGUpPF/sB6kg0Q2oFwTS92guGPVfot5ggtuF/A3dNW6Rv0f+x
	swXwJYGDQFHmRuQ7bvynZWfKDgxpfhHvwA6Q3iawiRp3xHvq0LvVjIkxPPehG0xk56fs
	YApkQLc81xKiIeygGFZQdGvegPtChrcgoDq7WRUT9Ok+cSttNkJ+ytE3jWdnoHjGZxjP
	yrhu4tvelpXQARM25ITQmTgMVOQx6Xi1gmthyf8ArBdFqWiPYBS4pUbIkg8BZzcdhm8d
	oFd2DF1bWb62uHNUqIBoXO8+FwfJ9UnTyoTPfO4jyZxEZc1da7f6N9USm/N2cODH65Fh
	M1ww==
Received: by 10.229.154.78 with SMTP id n14mr111502qcw.119.1335317290851; Tue,
	24 Apr 2012 18:28:10 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.79.79 with HTTP; Tue, 24 Apr 2012 18:27:50 -0700 (PDT)
In-Reply-To: <CABcZANkt3RPjL+JQSA5i2UbundQzn=n7xMKG+pwj4rRuyUJ-oA@mail.gmail.com>
References: <cover.1335254750.git.dongxiao.xu@intel.com>
	<2bbdbdf903d6c80f54058bcb5edd8a1e6aa89d15.1335254750.git.dongxiao.xu@intel.com>
	<CABcZANkt3RPjL+JQSA5i2UbundQzn=n7xMKG+pwj4rRuyUJ-oA@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 24 Apr 2012 18:27:50 -0700
X-Google-Sender-Auth: 70izDJnj88C7WHQfW5eCOGZyXxA
Message-ID: <CABcZAN=sX1jfNNC5PMXEQVWmMgJm_eOO7QwL_L3cVJirDyPcpw@mail.gmail.com>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/3] event.py: Add SanityCheck and SanityCheckPassed events
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
X-List-Received-Date: Wed, 25 Apr 2012 01:37:46 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2012 at 6:26 PM, Chris Larson <clarson@kergoth.com> wrote:
> On Tue, Apr 24, 2012 at 1:16 AM, Dongxiao Xu <dongxiao.xu@intel.com> wrot=
e:
>> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
>> ---
>> =C2=A0lib/bb/event.py | =C2=A0 10 ++++++++++
>> =C2=A01 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/lib/bb/event.py b/lib/bb/event.py
>> index bbece58..f3fb521 100644
>> --- a/lib/bb/event.py
>> +++ b/lib/bb/event.py
>> @@ -517,3 +517,13 @@ class PackageInfo(Event):
>> =C2=A0 =C2=A0 def __init__(self, pkginfolist):
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Event.__init__(self)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._pkginfolist =3D pkginfolist
>> +
>> +class SanityCheck(Event):
>> + =C2=A0 =C2=A0"""
>> + =C2=A0 =C2=A0Event to issue sanity check
>> + =C2=A0 =C2=A0"""
>> +
>> +class SanityCheckPassed(Event):
>> + =C2=A0 =C2=A0"""
>> + =C2=A0 =C2=A0Event to indicate sanity check is passed
>> + =C2=A0 =C2=A0"""
>
> Sanity checking is not part of bitbake, nor does it belong there. I'd
> say to find another way to do this.

Erm, ignore this, I was obviously mistaken. I had no idea any of this
code existed. It does seem pretty questionable, still. 'sanity check'
is extremely vague, and unclear about what it does, and further, the
terminology overlaps with the various checks in the metadata. At a
minimum I'd think we should improve this naming.
--=20
Christopher Larson


