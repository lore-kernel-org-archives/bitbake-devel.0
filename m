Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id C51C878BB1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 06:48:25 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id s14-v6so807583wmc.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 23:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iKnIBl8Vc9vwdYeHbZvMkvsY6BkdqxQKzZ+ZF8I3xe4=;
	b=Ens4QrxugRdiItNONK03AoTvQJxGLSb1jSVF6E/mVylbZlPOemy5QMhX5ewbF8x/kB
	dcyDKVdPciY7IF/wDpdLATmDdTjNfQNlg9S7Qua1S4ifCYmi+93158Wm3pxWx8IeyK6v
	BRzYxyECNJbTFRpfFYDyCuNC0StDNr5mAFUvVrQT0MMiZue8QjqoV5hvVQPsyKkVyJhr
	2KXaK1MZRzme/Wh6KDMLH1SmMgDxzZusHr44ZS6xL9Elj8zaPux+hUr2iPlmIRnbAzMw
	Y+drhpEm6by9IarZg0apnPI03wfQvckoMJ66McAKB64M/bnRzFMM+FNYVvd3XKAjIT4X
	yBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iKnIBl8Vc9vwdYeHbZvMkvsY6BkdqxQKzZ+ZF8I3xe4=;
	b=Wt7hijZQBjKhyAVZbUyB8VQGFmvYszTq/LxB1ut0/kfxAJVDs5QdnJpArvIwipTNBn
	BQomGhpOXMhpQVeZ75uBcNJw+ctIN4kNHKOtyj8onbzyCDeKpUiCEcY+fpz7WbGSpx0E
	gzfKK4nXlrodKsJrHnw5TDDrF8bYsoGI1++HAZ0i+9cJreECQYPSPDLW+FeBVadOAEqJ
	PQQ85/JpMCnrvmqUH7d9TBkysdTu5xRIFE4Xu4baFCkOkgNwiPy0/CoBGCVWRXkXyrPZ
	HBISqXyKApOXTxZGtng89gMKwKOFa/BdP8zoi8FOCJCHpYJ6S0kYRWqrjX2TJQzfc46+
	UDuQ==
X-Gm-Message-State: AOUpUlF2mvpDW8l3GUXScQToeSFfI46+b/Tk1vRA9lzxz544qJK+nB0Q
	5KbksiNfu9qvMxoTHHXQWvapvxyfPTYAAqLFcKg=
X-Google-Smtp-Source: AAOMgpczhf/aT2aPh+twY/zDPUUROZ0pAsCUGt/GWCoekHzdkkngqP/JgbnFxmEOt6xvtM1N30fkOt/vk2uzJtx8xkU=
X-Received: by 2002:a1c:8c08:: with SMTP id o8-v6mr657814wmd.60.1532587706549; 
	Wed, 25 Jul 2018 23:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <1532564810-2025-1-git-send-email-changhyeok.bae@gmail.com>
	<CABcZANmPoDTRWoKCm8w1KL9uw0iNaMCfrM5C8rY_cSCyRDGZMw@mail.gmail.com>
In-Reply-To: <CABcZANmPoDTRWoKCm8w1KL9uw0iNaMCfrM5C8rY_cSCyRDGZMw@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 26 Jul 2018 08:48:16 +0200
Message-ID: <CA+chaQeSvbBwRUF1qjx2oHi7_h8deiXyanmU9RzhxBF8Ezq0Yg@mail.gmail.com>
To: Chris Larson <kergoth@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Changhyeok Bae <changhyeok.bae@gmail.com>
Subject: Re: [PATCH v2][1.32] fetch2: fix import error for Python 3.6.5
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 26 Jul 2018 06:48:26 -0000
Content-Type: multipart/alternative; boundary="000000000000d6087d0571e161ce"

--000000000000d6087d0571e161ce
Content-Type: text/plain; charset="UTF-8"

Chris: you're right, but it was already merged in this form to master,
1.38, 1.36, 1.34 branches, so it would be better to keep the same for 1.32.

On Thu, Jul 26, 2018 at 4:30 AM Christopher Larson <kergoth@gmail.com>
wrote:

> subprocess searches PATH by default, /usr/bin/env is redundant anywhere
> but in a #! line of an executable script, as far as I know.
>
> On Wed, Jul 25, 2018 at 5:27 PM Changhyeok Bae <changhyeok.bae@gmail.com>
> wrote:
>
>> From: Tzu Hsiang Lin <t9360341@ntut.org.tw>
>>
>> When running bitbake command with Python 3.6.5 always result in
>> import error causing by the change of distutils module.
>> This patch replaces the method to search executable in PATH by
>> "/usr/bin/env <command>".
>>
>> Signed-off-by: Tzu Hsiang Lin <t9360341@ntut.org.tw>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> Signed-off-by: Changhyeok Bae <changhyeok.bae@gmail.com>
>> ---
>>  lib/bb/fetch2/clearcase.py | 3 +--
>>  lib/bb/fetch2/npm.py       | 1 -
>>  2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
>> index 70e280a..41cd46f 100644
>> --- a/lib/bb/fetch2/clearcase.py
>> +++ b/lib/bb/fetch2/clearcase.py
>> @@ -70,7 +70,6 @@ from   bb.fetch2 import FetchMethod
>>  from   bb.fetch2 import FetchError
>>  from   bb.fetch2 import runfetchcmd
>>  from   bb.fetch2 import logger
>> -from   distutils import spawn
>>
>>  class ClearCase(FetchMethod):
>>      """Class to fetch urls via 'clearcase'"""
>> @@ -108,7 +107,7 @@ class ClearCase(FetchMethod):
>>          else:
>>              ud.module = ""
>>
>> -        ud.basecmd = d.getVar("FETCHCMD_ccrc", True) or
>> spawn.find_executable("cleartool") or spawn.find_executable("rcleartool")
>> +        ud.basecmd = d.getVar("FETCHCMD_ccrc", True) or "/usr/bin/env
>> cleartool || rcleartool"
>>
>>          if data.getVar("SRCREV", d, True) == "INVALID":
>>            raise FetchError("Set a valid SRCREV for the clearcase fetcher
>> in your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your
>> choice.")
>> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
>> index 699ae72..7ccaba9 100644
>> --- a/lib/bb/fetch2/npm.py
>> +++ b/lib/bb/fetch2/npm.py
>> @@ -33,7 +33,6 @@ from   bb.fetch2 import runfetchcmd
>>  from   bb.fetch2 import logger
>>  from   bb.fetch2 import UnpackError
>>  from   bb.fetch2 import ParameterError
>> -from   distutils import spawn
>>
>>  def subprocess_setup():
>>      # Python installs a SIGPIPE handler by default. This is usually not
>> what
>> --
>> 2.7.4
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>
>
> --
> Christopher Larson
> kergoth at gmail dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Senior Software Engineer, Mentor Graphics
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--000000000000d6087d0571e161ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Chris: you&#39;re right, but it was already merged in this=
 form to master, 1.38, 1.36, 1.34 branches, so it would be better to keep t=
he same for 1.32.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On T=
hu, Jul 26, 2018 at 4:30 AM Christopher Larson &lt;<a href=3D"mailto:kergot=
h@gmail.com">kergoth@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div dir=3D"ltr">subprocess searches PATH by default, /usr/bin/e=
nv is redundant anywhere but in a #! line of an executable script, as far a=
s I know.<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, =
Jul 25, 2018 at 5:27 PM Changhyeok Bae &lt;<a href=3D"mailto:changhyeok.bae=
@gmail.com" target=3D"_blank">changhyeok.bae@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">From: Tzu Hsiang Lin &lt;<a href=3D"mail=
to:t9360341@ntut.org.tw" target=3D"_blank">t9360341@ntut.org.tw</a>&gt;<br>
<br>
When running bitbake command with Python 3.6.5 always result in<br>
import error causing by the change of distutils module.<br>
This patch replaces the method to search executable in PATH by<br>
&quot;/usr/bin/env &lt;command&gt;&quot;.<br>
<br>
Signed-off-by: Tzu Hsiang Lin &lt;<a href=3D"mailto:t9360341@ntut.org.tw" t=
arget=3D"_blank">t9360341@ntut.org.tw</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
Signed-off-by: Changhyeok Bae &lt;<a href=3D"mailto:changhyeok.bae@gmail.co=
m" target=3D"_blank">changhyeok.bae@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/clearcase.py | 3 +--<br>
=C2=A0lib/bb/fetch2/npm.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A02 files changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py<br>
index 70e280a..41cd46f 100644<br>
--- a/lib/bb/fetch2/clearcase.py<br>
+++ b/lib/bb/fetch2/clearcase.py<br>
@@ -70,7 +70,6 @@ from=C2=A0 =C2=A0bb.fetch2 import FetchMethod<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import FetchError<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import logger<br>
-from=C2=A0 =C2=A0distutils import spawn<br>
<br>
=C2=A0class ClearCase(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Class to fetch urls via &#39;clearcas=
e&#39;&quot;&quot;&quot;<br>
@@ -108,7 +107,7 @@ class ClearCase(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.module =3D &quot;&quot;<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D d.getVar(&quot;FETCHCMD_ccrc&qu=
ot;, True) or spawn.find_executable(&quot;cleartool&quot;) or spawn.find_ex=
ecutable(&quot;rcleartool&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D d.getVar(&quot;FETCHCMD_ccrc&qu=
ot;, True) or &quot;/usr/bin/env cleartool || rcleartool&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if data.getVar(&quot;SRCREV&quot;, d, Tru=
e) =3D=3D &quot;INVALID&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise FetchError(&quot;Set a valid=
 SRCREV for the clearcase fetcher in your recipe, e.g. SRCREV =3D \&quot;/m=
ain/LATEST\&quot; or any other label of your choice.&quot;)<br>
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
index 699ae72..7ccaba9 100644<br>
--- a/lib/bb/fetch2/npm.py<br>
+++ b/lib/bb/fetch2/npm.py<br>
@@ -33,7 +33,6 @@ from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import logger<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import UnpackError<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import ParameterError<br>
-from=C2=A0 =C2=A0distutils import spawn<br>
<br>
=C2=A0def subprocess_setup():<br>
=C2=A0 =C2=A0 =C2=A0# Python installs a SIGPIPE handler by default. This is=
 usually not what<br>
-- <br>
2.7.4<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"m=
_6441764931516959306gmail_signature" data-smartmail=3D"gmail_signature"><di=
v dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail =
dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software E=
ngineer, Mentor Graphics</div></div></div></div>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--000000000000d6087d0571e161ce--
