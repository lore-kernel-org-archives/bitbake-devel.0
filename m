Return-Path: <avery.brian@gmail.com>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
	[209.85.213.67])
	by mail.openembedded.org (Postfix) with ESMTP id D415C606D0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Nov 2016 21:08:54 +0000 (UTC)
Received: by mail-vk0-f67.google.com with SMTP id l126so7441438vkh.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Nov 2016 13:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=5NnFPAuAQsdQXKzVErzhlxe3vVontW4dB+ubrxuJB24=;
	b=CDAvromC4/Ucm6UroffIDK3EJIHjCFY2Lr7hN53PuFI0piVssLz5uSq+5g3UJNceA4
	LdsykDLTtc7icag7wRwruaF6lN5ozNW+TKeSuFDcuwP8uL7inp1k/7x97fM3fvoBUba2
	JLKlzodldnJkJMx6f7bHA5tDwBif4LkVKmr0UubZnh2eGxBZVarjmyAPoTuXdZVtv6DN
	wjlBErg9UFY6Xy9B64p/veN27GXK2it38VdXdwexQZe7x+pPjjEK3KwdPxlvhj47aDfa
	zoseD90Yw00QXLLu1+Dls1caw7SwaMbmk8Uw/Zv/sOILseovWQltXKoBmm3Nkboc7B/B
	Cuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=5NnFPAuAQsdQXKzVErzhlxe3vVontW4dB+ubrxuJB24=;
	b=YpTDI9O+/AJFaM8EleIixkKBqY6Ll0T62ZgJbLxG8oxsAO+y/NF/NBUBwGIm2weJ0D
	5XALA8N4JTnOcEw2TMVU0tXVfTYgcJIKLI+BxNNNFlVH9+uuwEfeX0oAQqI7XisYsIwD
	iaxue/EJDQ+gbdqpbErMYCk6q0Wai1eeVvHNJeUZbOYHq1sxc/qWsU8YOsKDlb3oGqUl
	Iz2E0CZjXwUdKMC8gg6G8g56/iH3d06DeYzghrQWhSG0Er21giX8W5BfvVqDJ4SjCC0b
	+uzqKR8vL+5KzC990AvShvFG0/VgGsExkGyUMstlSnPMBmOdN08JQTSO+UJP5Kfvnh1/
	bt9Q==
X-Gm-Message-State: ABUngvd7plZfiKWySkaeJX0S+IzIBNptDaGp4tGIqP3FT3NSHx9SxXtvT26WSGf/oimR2+2CPV2mM/wSO26SYw==
X-Received: by 10.31.232.199 with SMTP id f190mr11887355vkh.96.1479157735325; 
	Mon, 14 Nov 2016 13:08:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.67.72 with HTTP; Mon, 14 Nov 2016 13:08:54 -0800 (PST)
In-Reply-To: <7a43f58b-8ced-2032-1d1e-3dcebc4a4301@intel.com>
References: <1478262426-5350-1-git-send-email-michael.g.wood@intel.com>
	<7a43f58b-8ced-2032-1d1e-3dcebc4a4301@intel.com>
From: Brian Avery <avery.brian@gmail.com>
Date: Mon, 14 Nov 2016 13:08:54 -0800
Message-ID: <CAKV_0eiE523KQqnDo=gXLpkUf4i0GrVAM0_iDfYwFX2HTWijNg@mail.gmail.com>
To: Michael Wood <michael.g.wood@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH][master/morty/1.32] toaster: settings set ALLOWED_HOSTS to * in debug mode
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
X-List-Received-Date: Mon, 14 Nov 2016 21:08:55 -0000
Content-Type: multipart/alternative; boundary=94eb2c0948526185da0541493f91

--94eb2c0948526185da0541493f91
Content-Type: text/plain; charset=UTF-8

bump.
-brian
an intel employee

On Fri, Nov 4, 2016 at 5:30 AM, Michael Wood <michael.g.wood@intel.com>
wrote:

> On 04/11/16 12:27, Michael Wood wrote:
>
>> From: brian avery <brian.avery@intel.com>
>>
>> As of Django 1.8.16, Django is rejecting any HTTP_HOST header that is
>> not on the ALLOWED_HOST list.  We often need to reference the
>> toaster server via a fqdn, if we start it via webport=0.0.0.0:8000 for
>> instance, and are hitting the server from a laptop. This change does
>> reduce  the protection from a DNS rebinding attack, however, if you are
>> running the toaster server outside a protected network, you should be
>> using the production instance.
>>
>> [YOCTO #10578]
>>
>> Signed-off-by: brian avery <brian.avery@intel.com>
>> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
>> ---
>>   lib/toaster/toastermain/settings.py | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/toaster/toastermain/settings.py
>> b/lib/toaster/toastermain/settings.py
>> index 3dfa2b2..aec9dbb 100644
>> --- a/lib/toaster/toastermain/settings.py
>> +++ b/lib/toaster/toastermain/settings.py
>> @@ -60,9 +60,19 @@ DATABASES = {
>>   if 'sqlite' in DATABASES['default']['ENGINE']:
>>       DATABASES['default']['OPTIONS'] = { 'timeout': 20 }
>>   -# Hosts/domain names that are valid for this site; required if DEBUG
>> is False
>> -# See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
>> -ALLOWED_HOSTS = []
>> +# Update as of django 1.8.16 release, the '*' is needed to allow us to
>> connect while running
>> +# on hosts without explicitly setting the fqdn for the toaster server.
>> +# See https://docs.djangoproject.com/en/dev/ref/settings/ for info on
>> ALLOWED_HOSTS
>> +# Previously this setting was not enforced if DEBUG was set but it is
>> now.
>> +# The previous behavior was such that ALLOWED_HOSTS defaulted to
>> ['localhost','127.0.0.1','::1']
>> +# and if you bound to 0.0.0.0:<port #> then accessing toaster as
>> localhost or fqdn would both work.
>> +# To have that same behavior, with a fqdn explicitly enabled you would
>> set
>> +# ALLOWED_HOSTS= ['localhost','127.0.0.1','::1','myserver.mycompany.com']
>> for
>> +# Django >= 1.8.16. By default, we are not enforcing this restriction in
>> +# DEBUG mode.
>> +if DEBUG is True:
>> +    # this will allow connection via localhost,hostname, or fqdn
>> +    ALLOWED_HOSTS = ['*']
>>     # Local time zone for this installation. Choices can be found here:
>>   # http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
>>
>
> Should also say that this is needed for backport because the requirements
> for django was effectively also added as a backported to the version we are
> currently using i.e Django>1.8,<1.9
>
> More info in Brian's cover letter on the toaster mailing list.
>
> https://lists.yoctoproject.org/pipermail/toaster/2016-November/005300.html
>
> Michael
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--94eb2c0948526185da0541493f91
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">bump.<div>-brian</div><div>an intel employee</div></div><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Nov 4, 2016=
 at 5:30 AM, Michael Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:michael.g=
.wood@intel.com" target=3D"_blank">michael.g.wood@intel.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=
=3D"h5">On 04/11/16 12:27, Michael Wood wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: brian avery &lt;<a href=3D"mailto:brian.avery@intel.com" target=3D"_b=
lank">brian.avery@intel.com</a>&gt;<br>
<br>
As of Django 1.8.16, Django is rejecting any HTTP_HOST header that is<br>
not on the ALLOWED_HOST list.=C2=A0 We often need to reference the<br>
toaster server via a fqdn, if we start it via webport=3D<a href=3D"http://0=
.0.0.0:8000" rel=3D"noreferrer" target=3D"_blank">0.0.0.0:8000</a> for<br>
instance, and are hitting the server from a laptop. This change does<br>
reduce=C2=A0 the protection from a DNS rebinding attack, however, if you ar=
e<br>
running the toaster server outside a protected network, you should be<br>
using the production instance.<br>
<br>
[YOCTO #10578]<br>
<br>
Signed-off-by: brian avery &lt;<a href=3D"mailto:brian.avery@intel.com" tar=
get=3D"_blank">brian.avery@intel.com</a>&gt;<br>
Signed-off-by: Michael Wood &lt;<a href=3D"mailto:michael.g.wood@intel.com"=
 target=3D"_blank">michael.g.wood@intel.com</a>&gt;<br>
---<br>
=C2=A0 lib/toaster/toastermain/settin<wbr>gs.py | 16 +++++++++++++---<br>
=C2=A0 1 file changed, 13 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/toaster/toastermain/sett<wbr>ings.py b/lib/toaster/toaster=
main/sett<wbr>ings.py<br>
index 3dfa2b2..aec9dbb 100644<br>
--- a/lib/toaster/toastermain/sett<wbr>ings.py<br>
+++ b/lib/toaster/toastermain/sett<wbr>ings.py<br>
@@ -60,9 +60,19 @@ DATABASES =3D {<br>
=C2=A0 if &#39;sqlite&#39; in DATABASES[&#39;default&#39;][&#39;ENGINE&#39;=
]<wbr>:<br>
=C2=A0 =C2=A0 =C2=A0 DATABASES[&#39;default&#39;][&#39;OPTIONS&#39;<wbr>] =
=3D { &#39;timeout&#39;: 20 }<br>
=C2=A0 -# Hosts/domain names that are valid for this site; required if DEBU=
G is False<br>
-# See <a href=3D"https://docs.djangoproject.com/en/1.5/ref/settings/#allow=
ed-hosts" rel=3D"noreferrer" target=3D"_blank">https://docs.djangoproject.c=
om<wbr>/en/1.5/ref/settings/#allowed-<wbr>hosts</a><br>
-ALLOWED_HOSTS =3D []<br>
+# Update as of django 1.8.16 release, the &#39;*&#39; is needed to allow u=
s to connect while running<br>
+# on hosts without explicitly setting the fqdn for the toaster server.<br>
+# See <a href=3D"https://docs.djangoproject.com/en/dev/ref/settings/" rel=
=3D"noreferrer" target=3D"_blank">https://docs.djangoproject.com<wbr>/en/de=
v/ref/settings/</a> for info on ALLOWED_HOSTS<br>
+# Previously this setting was not enforced if DEBUG was set but it is now.=
<br>
+# The previous behavior was such that ALLOWED_HOSTS defaulted to [&#39;loc=
alhost&#39;,&#39;127.0.0.1&#39;,&#39;::1&#39;<wbr>]<br>
+# and if you bound to <a href=3D"http://0.0.0.0" rel=3D"noreferrer" target=
=3D"_blank">0.0.0.0</a>:&lt;port #&gt; then accessing toaster as localhost =
or fqdn would both work.<br>
+# To have that same behavior, with a fqdn explicitly enabled you would set=
<br>
+# ALLOWED_HOSTS=3D [&#39;localhost&#39;,&#39;127.0.0.1&#39;,&#39;::1&#39;<=
wbr>,&#39;<a href=3D"http://myserver.mycompany.com" rel=3D"noreferrer" targ=
et=3D"_blank">myserver.mycompany.com</a>&#39;] for<br>
+# Django &gt;=3D 1.8.16. By default, we are not enforcing this restriction=
 in<br>
+# DEBUG mode.<br>
+if DEBUG is True:<br>
+=C2=A0 =C2=A0 # this will allow connection via localhost,hostname, or fqdn=
<br>
+=C2=A0 =C2=A0 ALLOWED_HOSTS =3D [&#39;*&#39;]<br>
=C2=A0 =C2=A0 # Local time zone for this installation. Choices can be found=
 here:<br>
=C2=A0 # <a href=3D"http://en.wikipedia.org/wiki/List_of_tz_zones_by_name" =
rel=3D"noreferrer" target=3D"_blank">http://en.wikipedia.org/wiki/L<wbr>ist=
_of_tz_zones_by_name</a><br>
</blockquote>
<br></div></div>
Should also say that this is needed for backport because the requirements f=
or django was effectively also added as a backported to the version we are =
currently using i.e Django&gt;1.8,&lt;1.9<br>
<br>
More info in Brian&#39;s cover letter on the toaster mailing list.<br>
<br>
<a href=3D"https://lists.yoctoproject.org/pipermail/toaster/2016-November/0=
05300.html" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject=
.org<wbr>/pipermail/toaster/2016-Novemb<wbr>er/005300.html</a><span class=
=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Michael</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
-- <br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedd<wbr>ed.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
</div></div></blockquote></div><br></div>

--94eb2c0948526185da0541493f91--
