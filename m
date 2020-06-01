Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web12.48784.1591048173864732249
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:49:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: linux.intel.com, ip: 192.55.52.88, mailfrom: timothy.t.orling@linux.intel.com)
IronPort-SDR: oFqocwExlVtlLsJTxK8IZB2MqzSpP8Iwohk1hC+IkKf4BxDhBo20S9YKnrirbE52DT2jLTLmEy
 7LeFEBydnMAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 14:49:33 -0700
IronPort-SDR: mUc6Bj7RPWA/ayoskE7vaZ+uK5rtpuoQYOXUQfzve6PR/3mo8YzHGYR/ised9U6Tc4+X0VgJsA
 ZrRYO+R6neBQ==
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208,217";a="293338786"
Received: from pingjuch-mobl.amr.corp.intel.com ([10.254.69.36])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 14:49:13 -0700
From: "Tim Orling" <timothy.t.orling@linux.intel.com>
Message-Id: <52CC4F3C-A882-4B07-859D-DECEDC564D22@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Toaster] [bitbake-devel] [dunfell][1.46][PATCH] toaster-requirements.txt: require Django 2.2
Date: Mon, 1 Jun 2020 14:49:12 -0700
In-Reply-To: <95C12BDD-75CB-4E6C-83E3-A2C24A6E5057@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org,
 toaster@lists.yoctoproject.org,
 david.reyna@windriver.com
To: akuster808 <akuster808@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20200527232512.27409-1-timothy.t.orling@linux.intel.com>
 <a463f133-7853-f2e6-9124-a98be5322a1f@gmail.com>
 <95C12BDD-75CB-4E6C-83E3-A2C24A6E5057@linux.intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_BADEADCE-9F12-4D07-B429-91F0E6E1C28C"

--Apple-Mail=_BADEADCE-9F12-4D07-B429-91F0E6E1C28C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jun 1, 2020, at 2:46 PM, Tim Orling <timothy.t.orling@linux.intel.com=
> wrote:
>=20
>=20
>=20
>> On May 28, 2020, at 12:03 PM, akuster808 <akuster808@gmail.com <mailto:=
akuster808@gmail.com>> wrote:
>>=20
>>=20
>>=20
>> On 5/27/20 4:25 PM, Tim Orling wrote:
>>> In commit 9730f95686b2ac72cf1fa513c555f7c7787e2667
>>> Django 2.2 was enabled.
>>>=20
>>> Django 1.11 was EOL on April 1, 2020
>>>=20
>>> Signed-off-by: Tim Orling <timothy.t.orling@linux.intel.com> <mailto:t=
imothy.t.orling@linux.intel.com>
>>> ---
>>>  toaster-requirements.txt | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/toaster-requirements.txt b/toaster-requirements.txt
>>> index a682b085..735b6145 100644
>>> --- a/toaster-requirements.txt
>>> +++ b/toaster-requirements.txt
>>> @@ -1,3 +1,3 @@
>>> -Django>1.8,<1.12
>>> +Django>2.2,<2.3
>>=20
>> Is this version supported on all hosts supported by Dunfell?
>>=20
>=20
> It would be since Django 1.11 went EOL a while ago and it is loaded via =
=
=E2=80=9Cpip3 install -r toaster-requirements.txt=E2=80=9D (not requiring =
Django 2.2 to be packaged on a given bistro).
>=20

I should have said Django 1.11 began the EOL process a while ago. Mainstre=
am support ended December 2, 2017
So after that it was only security and bug fixes.
https://www.djangoproject.com/download/ <https://www.djangoproject.com/dow=
nload/>

> Also, toaster is currently broken on Dunfell without this change:
>=20
> Traceback (most recent call last):
>   File "/home/usersetup/poky/bitbake/bin/../lib/toaster/manage.py", line=
 14, in <module>
>     execute_from_command_line(sys.argv)
>   File "/usr/local/lib/python3.6/dist-packages/django/core/management/__=
init__.py", line 364, in execute_from_command_line
>     utility.execute()
>   File "/usr/local/lib/python3.6/dist-packages/django/core/management/__=
init__.py", line 356, in execute
>     self.fetch_command(subcommand).run_from_argv(self.argv)
>   File "/usr/local/lib/python3.6/dist-packages/django/core/management/ba=
se.py", line 283, in run_from_argv
>     self.execute(*args, **cmd_options)
>   File "/usr/local/lib/python3.6/dist-packages/django/core/management/ba=
se.py", line 327, in execute
>     self.check()
>   File "/usr/local/lib/python3.6/dist-packages/django/core/management/ba=
se.py", line 359, in check
>     include_deployment_checks=3Dinclude_deployment_checks,
>   File "/usr/local/lib/python3.6/dist-packages/django/core/management/ba=
se.py", line 346, in _run_checks
>     return checks.run_checks(**kwargs)
>   File "/usr/local/lib/python3.6/dist-packages/django/core/checks/regist=
ry.py", line 81, in run_checks
>     new_errors =3D check(app_configs=3Dapp_configs)
>   File "/usr/local/lib/python3.6/dist-packages/django/core/checks/urls.p=
y", line 16, in check_url_config
>     return check_resolver(resolver)
>   File "/usr/local/lib/python3.6/dist-packages/django/core/checks/urls.p=
y", line 26, in check_resolver
>     return check_method()
>   File "/usr/local/lib/python3.6/dist-packages/django/urls/resolvers.py"=
, line 256, in check
>     for pattern in self.url_patterns:
>   File "/usr/local/lib/python3.6/dist-packages/django/utils/functional.p=
y", line 35, in __get__
>     res =3D instance.__dict__[self.name] =3D self.func(instance)
>   File "/usr/local/lib/python3.6/dist-packages/django/urls/resolvers.py"=
, line 407, in url_patterns
>     patterns =3D getattr(self.urlconf_module, "urlpatterns", self.urlcon=
f_module)
>   File "/usr/local/lib/python3.6/dist-packages/django/utils/functional.p=
y", line 35, in __get__
>     res =3D instance.__dict__[self.name] =3D self.func(instance)
>   File "/usr/local/lib/python3.6/dist-packages/django/urls/resolvers.py"=
, line 400, in urlconf_module
>     return import_module(self.urlconf_name)
>   File "/usr/lib/python3.6/importlib/__init__.py", line 126, in import_m=
odule
>     return _bootstrap._gcd_import(name[level:], package, level)
>   File "<frozen importlib._bootstrap>", line 994, in _gcd_import
>   File "<frozen importlib._bootstrap>", line 971, in _find_and_load
>   File "<frozen importlib._bootstrap>", line 955, in _find_and_load_unlo=
cked
>   File "<frozen importlib._bootstrap>", line 665, in _load_unlocked
>   File "<frozen importlib._bootstrap_external>", line 678, in exec_modul=
e
>   File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_r=
emoved
>   File "/home/usersetup/poky/bitbake/lib/toaster/toastermain/urls.py", l=
ine 72, in <module>
>     if p.pattern.regex.pattern =3D=3D '^' + modulename + '/':
> AttributeError: 'RegexURLResolver' object has no attribute =E2=80=98patt=
ern'
>=20
>> - armin
>>>  beautifulsoup4>=3D4.4.0
>>>  pytz
>>>=20
>>>=20
>>=20
>>=20


--Apple-Mail=_BADEADCE-9F12-4D07-B429-91F0E6E1C28C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;" class=3D""><div class=3D""><br class=
=
=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div class=
=3D"">On Jun 1, 2020, at 2:46 PM, Tim Orling &lt;<a href=3D"mailto:timothy=
.t.orling@linux.intel.com" class=3D"">timothy.t.orling@linux.intel.com</a>&=
gt; wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><di=
v style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 14=
px; font-style: normal; font-variant-caps: normal; font-weight: normal; let=
ter-spacing: normal; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px=
; text-decoration: none;" class=3D""><br class=3D"Apple-interchange-newline=
"><br class=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On Ma=
y 28, 2020, at 12:03 PM, akuster808 &lt;<a href=3D"mailto:akuster808@gmail.=
com" class=3D"">akuster808@gmail.com</a>&gt; wrote:</div><br class=3D"Apple=
-interchange-newline"><div class=3D""><div class=3D""><br class=3D""><br cl=
ass=3D""><div class=3D"moz-cite-prefix">On 5/27/20 4:25 PM, Tim Orling wrot=
e:<br class=3D""></div><blockquote type=3D"cite" cite=3D"mid:20200527232512=
.27409-1-timothy.t.orling@linux.intel.com" class=3D""><pre class=3D"moz-quo=
te-pre" wrap=3D"">In commit 9730f95686b2ac72cf1fa513c555f7c7787e2667
Django 2.2 was enabled.

Django 1.11 was EOL on April 1, 2020

Signed-off-by: Tim Orling <a class=3D"moz-txt-link-rfc2396E" href=3D"mailt=
o:timothy.t.orling@linux.intel.com">&lt;timothy.t.orling@linux.intel.com&gt=
;</a>
---
 toaster-requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index a682b085..735b6145 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,3 +1,3 @@
-Django&gt;1.8,&lt;1.12
+Django&gt;2.2,&lt;2.3</pre></blockquote><br class=3D"">Is this version su=
pported on all hosts supported by Dunfell?<br class=3D""><br class=3D""></d=
iv></div></blockquote><div class=3D""><br class=3D""></div>It would be sinc=
e Django 1.11 went EOL a while ago and it is loaded via =E2=80=9Cpip3 insta=
ll -r toaster-requirements.txt=E2=80=9D (not requiring Django 2.2 to be pac=
kaged on a given bistro).</div><div style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 14px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br =
class=3D""></div></div></blockquote><div><br class=3D""></div>I should have=
 said Django 1.11 began the EOL process a while ago. Mainstream support end=
ed&nbsp;<span style=3D"color: rgb(12, 60, 38); font-family: Palatino, &quot=
;Palatino Linotype&quot;, &quot;Book Antiqua&quot;, &quot;Hoefler Text&quot=
;, Georgia, &quot;Lucida Bright&quot;, Cambria, Times, &quot;Times New Roma=
n&quot;, serif; font-size: 18px; font-variant-ligatures: normal; orphans: 2=
; text-align: center; widows: 2; background-color: rgb(255, 186, 186);" cla=
ss=3D"">December 2, 2017</span><div class=3D"">So after that it was only se=
curity and bug fixes.</div><div class=3D""><a href=3D"https://www.djangopro=
ject.com/download/" class=3D"">https://www.djangoproject.com/download/</a><=
/div><div class=3D""><br class=3D""></div><blockquote type=3D"cite" class=
=3D""><div class=3D""><div style=3D"caret-color: rgb(0, 0, 0); font-family=
: Helvetica; font-size: 14px; font-style: normal; font-variant-caps: normal=
; font-weight: normal; letter-spacing: normal; text-align: start; text-inde=
nt: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -web=
kit-text-stroke-width: 0px; text-decoration: none;" class=3D"">Also, toaste=
r is currently broken on Dunfell without this change:</div><div style=3D"ca=
ret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 14px; font-styl=
e: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; white-sp=
ace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decora=
tion: none;" class=3D""><br class=3D""></div><div style=3D"caret-color: rgb=
(0, 0, 0); font-family: Helvetica; font-size: 14px; font-style: normal; fon=
t-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-a=
lign: start; text-indent: 0px; text-transform: none; white-space: normal; w=
ord-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" c=
lass=3D""><div class=3D"">Traceback (most recent call last):</div><div clas=
s=3D"">&nbsp; File "/home/usersetup/poky/bitbake/bin/../lib/toaster/manage.=
py", line 14, in &lt;module&gt;</div><div class=3D"">&nbsp; &nbsp; execute_=
from_command_line(sys.argv)</div><div class=3D"">&nbsp; File "/usr/local/li=
b/python3.6/dist-packages/django/core/management/__init__.py", line 364, in=
 execute_from_command_line</div><div class=3D"">&nbsp; &nbsp; utility.execu=
te()</div><div class=3D"">&nbsp; File "/usr/local/lib/python3.6/dist-packag=
es/django/core/management/__init__.py", line 356, in execute</div><div clas=
s=3D"">&nbsp; &nbsp; self.fetch_command(subcommand).run_from_argv(self.argv=
)</div><div class=3D"">&nbsp; File "/usr/local/lib/python3.6/dist-packages/=
django/core/management/base.py", line 283, in run_from_argv</div><div class=
=
=3D"">&nbsp; &nbsp; self.execute(*args, **cmd_options)</div><div class=3D"=
">&nbsp; File "/usr/local/lib/python3.6/dist-packages/django/core/managemen=
t/base.py", line 327, in execute</div><div class=3D"">&nbsp; &nbsp; self.ch=
eck()</div><div class=3D"">&nbsp; File "/usr/local/lib/python3.6/dist-packa=
ges/django/core/management/base.py", line 359, in check</div><div class=3D"=
">&nbsp; &nbsp; include_deployment_checks=3Dinclude_deployment_checks,</div=
><div class=3D"">&nbsp; File "/usr/local/lib/python3.6/dist-packages/django=
/core/management/base.py", line 346, in _run_checks</div><div class=3D"">&n=
bsp; &nbsp; return checks.run_checks(**kwargs)</div><div class=3D"">&nbsp; =
File "/usr/local/lib/python3.6/dist-packages/django/core/checks/registry.py=
", line 81, in run_checks</div><div class=3D"">&nbsp; &nbsp; new_errors =3D=
 check(app_configs=3Dapp_configs)</div><div class=3D"">&nbsp; File "/usr/lo=
cal/lib/python3.6/dist-packages/django/core/checks/urls.py", line 16, in ch=
eck_url_config</div><div class=3D"">&nbsp; &nbsp; return check_resolver(res=
olver)</div><div class=3D"">&nbsp; File "/usr/local/lib/python3.6/dist-pack=
ages/django/core/checks/urls.py", line 26, in check_resolver</div><div clas=
s=3D"">&nbsp; &nbsp; return check_method()</div><div class=3D"">&nbsp; File=
 "/usr/local/lib/python3.6/dist-packages/django/urls/resolvers.py", line 25=
6, in check</div><div class=3D"">&nbsp; &nbsp; for pattern in self.url_patt=
erns:</div><div class=3D"">&nbsp; File "/usr/local/lib/python3.6/dist-packa=
ges/django/utils/functional.py", line 35, in __get__</div><div class=3D"">&=
nbsp; &nbsp; res =3D instance.__dict__[self.name] =3D self.func(instance)</=
div><div class=3D"">&nbsp; File "/usr/local/lib/python3.6/dist-packages/dja=
ngo/urls/resolvers.py", line 407, in url_patterns</div><div class=3D"">&nbs=
p; &nbsp; patterns =3D getattr(self.urlconf_module, "urlpatterns", self.url=
conf_module)</div><div class=3D"">&nbsp; File "/usr/local/lib/python3.6/dis=
t-packages/django/utils/functional.py", line 35, in __get__</div><div class=
=
=3D"">&nbsp; &nbsp; res =3D instance.__dict__[self.name] =3D self.func(ins=
tance)</div><div class=3D"">&nbsp; File "/usr/local/lib/python3.6/dist-pack=
ages/django/urls/resolvers.py", line 400, in urlconf_module</div><div class=
=
=3D"">&nbsp; &nbsp; return import_module(self.urlconf_name)</div><div clas=
s=3D"">&nbsp; File "/usr/lib/python3.6/importlib/__init__.py", line 126, in=
 import_module</div><div class=3D"">&nbsp; &nbsp; return _bootstrap._gcd_im=
port(name[level:], package, level)</div><div class=3D"">&nbsp; File "&lt;fr=
ozen importlib._bootstrap&gt;", line 994, in _gcd_import</div><div class=3D=
"">&nbsp; File "&lt;frozen importlib._bootstrap&gt;", line 971, in _find_an=
d_load</div><div class=3D"">&nbsp; File "&lt;frozen importlib._bootstrap&gt=
;", line 955, in _find_and_load_unlocked</div><div class=3D"">&nbsp; File "=
&lt;frozen importlib._bootstrap&gt;", line 665, in _load_unlocked</div><div=
 class=3D"">&nbsp; File "&lt;frozen importlib._bootstrap_external&gt;", lin=
e 678, in exec_module</div><div class=3D"">&nbsp; File "&lt;frozen importli=
b._bootstrap&gt;", line 219, in _call_with_frames_removed</div><div class=
=3D"">&nbsp; File "/home/usersetup/poky/bitbake/lib/toaster/toastermain/ur=
ls.py", line 72, in &lt;module&gt;</div><div class=3D"">&nbsp; &nbsp; if p.=
pattern.regex.pattern =3D=3D '^' + modulename + '/':</div><div class=3D"">A=
ttributeError: 'RegexURLResolver' object has no attribute =E2=80=98pattern'=
</div><div class=3D""><br class=3D""></div><blockquote type=3D"cite" class=
=3D""><div class=3D""><div class=3D"">- armin<br class=3D""><blockquote ty=
pe=3D"cite" cite=3D"mid:20200527232512.27409-1-timothy.t.orling@linux.intel=
.com" class=3D""><pre class=3D"moz-quote-pre" wrap=3D""> beautifulsoup4&gt;=
=
=3D4.4.0
 pytz
</pre><br class=3D""><fieldset class=3D"mimeAttachmentHeader"></fieldset><=
pre class=3D"moz-quote-pre" wrap=3D""></pre></blockquote><br class=3D""></d=
iv></div></blockquote></div></div></blockquote></div><br class=3D""></div><=
/body></html>

--Apple-Mail=_BADEADCE-9F12-4D07-B429-91F0E6E1C28C--
