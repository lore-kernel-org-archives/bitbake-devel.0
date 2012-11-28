Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TdqD4-0006rO-4D
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Nov 2012 23:34:43 +0100
Received: by mail-lb0-f175.google.com with SMTP id gg13so7780583lbb.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Nov 2012 14:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=yk8MMMdvUUmsxVfdrsusB8aZNkCx+NaNHwTUMQSjgZQ=;
	b=zWjgm4BYAtItK/5beNPOLFj0NZ+9K1Zt/qBRDXJd3BpRjUAbVbXd+zAxZe04fe7GgK
	trzddPC8x7s+bI/CJykAizXX5NDt/sYrWMF5LRoazgaHjJcVUdupOPnfSSoMUWYauVXg
	U1rPu7ddA90+axCCmcPgw6QhpHVoUgPNZhNvnryisS6WW8VgaPBpTHEa9m8g+6Tya0dR
	k74gIgFJjmRKvxT+Y43/I/wU5gX9wKvJiDYo73mhMQOUCsiYOmpjhMjQN+uUAGwjcTxI
	Npvuat3/udJCiePp5jEv/GRyaT76vSTt2CRQ7RP5mlMeakBmxDve/30CDPihjgKB9rdy
	PoeA==
Received: by 10.152.113.225 with SMTP id jb1mr19424282lab.23.1354141211250;
	Wed, 28 Nov 2012 14:20:11 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Wed, 28 Nov 2012 14:19:49 -0800 (PST)
In-Reply-To: <CABcZANkV1td28s-vZCXfukMHvYUAkoUH=3jScF3ZVkaBTyp9Qw@mail.gmail.com>
References: <1354134376.15992.5.camel@ted>
	<CABcZANkV1td28s-vZCXfukMHvYUAkoUH=3jScF3ZVkaBTyp9Qw@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 28 Nov 2012 15:19:49 -0700
X-Google-Sender-Auth: oU0cfKi_wLeu7s2GWjSst501Ras
Message-ID: <CABcZANkDfxxQCupuJLEjJJfXM44MczWcSpvZCqQKmOsDbCPF5A@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, "Eggleton,
	Paul" <paul.eggleton@intel.com>
Subject: Re: [PATCH] build.py: Preserve sigdata files in the stamps directory
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
X-List-Received-Date: Wed, 28 Nov 2012 22:34:44 -0000
Content-Type: multipart/alternative; boundary=f46d0408d91bdf500604cf959120

--f46d0408d91bdf500604cf959120
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 28, 2012 at 3:19 PM, Chris Larson <clarson@kergoth.com> wrote:

> On Wed, Nov 28, 2012 at 1:26 PM, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> -        bb.utils.remove(mask)
>> -
>> +        # Preserve sigdata files in the stamps directory
>> +        for name in glob.glob(mask):
>> +            if name.find("sigdata") != -1:
>>
>
> if 'sigdata' not in name:


Erm, s/not in/in/. You get the idea. Use of 'find' only really makes sense
if you need the locations within the string.
-- 
Christopher Larson

--f46d0408d91bdf500604cf959120
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, Nov 2=
8, 2012 at 3:19 PM, Chris Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:cl=
arson@kergoth.com" target=3D"_blank">clarson@kergoth.com</a>&gt;</span> wro=
te:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Wed, Nov 28, 2012 at 1:=
26 PM, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdi=
e@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org=
</a>&gt;</span> wrote:<br>

<div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.r=
emove(mask)<br>
-<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Preserve sigdata files in the stamps directo=
ry<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for name in glob.glob(mask):<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if name.find(&quot;sigdata&quot;=
) !=3D -1:</div></blockquote></div><br></div>if &#39;sigdata&#39; not in na=
me:</blockquote></div><br>Erm, s/not in/in/. You get the idea. Use of &#39;=
find&#39; only really makes sense if you need the locations within the stri=
ng.<br>

-- <br>Christopher Larson<br>
</div>

--f46d0408d91bdf500604cf959120--
