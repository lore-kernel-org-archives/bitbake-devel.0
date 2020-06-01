Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web12.48704.1591047987516519965
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: linux.intel.com, ip: 134.134.136.31, mailfrom: timothy.t.orling@linux.intel.com)
IronPort-SDR: qEeVpP72EyfIuymqktCQHKG8boWj9ax4HB6gDpteADYGUlY0IkheqRPijRM7iQNqQ1OKd3BBKm
 YKkWsESeXWPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 14:46:26 -0700
IronPort-SDR: WcdnlZxX4M8pt3a4h+mWECiKCTcrFE9c/gTVXsgJkJm7Ad1oYydkOz4s7DOPmZweQucwhe4MC5
 s5+cSqvo8qdw==
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208,217";a="470463958"
Received: from pingjuch-mobl.amr.corp.intel.com ([10.254.69.36])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 14:46:25 -0700
From: "Tim Orling" <timothy.t.orling@linux.intel.com>
Message-Id: <95C12BDD-75CB-4E6C-83E3-A2C24A6E5057@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Toaster] [bitbake-devel] [dunfell][1.46][PATCH] toaster-requirements.txt: require Django 2.2
Date: Mon, 1 Jun 2020 14:46:24 -0700
In-Reply-To: <a463f133-7853-f2e6-9124-a98be5322a1f@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
 toaster@lists.yoctoproject.org,
 david.reyna@windriver.com
To: akuster808 <akuster808@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20200527232512.27409-1-timothy.t.orling@linux.intel.com>
 <a463f133-7853-f2e6-9124-a98be5322a1f@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_9B9F986E-8E66-4CCE-82E0-3B309759EBF7"

--Apple-Mail=_9B9F986E-8E66-4CCE-82E0-3B309759EBF7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On May 28, 2020, at 12:03 PM, akuster808 <akuster808@gmail.com> wrote:
>=20
>=20
>=20
> On 5/27/20 4:25 PM, Tim Orling wrote:
>> In commit 9730f95686b2ac72cf1fa513c555f7c7787e2667
>> Django 2.2 was enabled.
>>=20
>> Django 1.11 was EOL on April 1, 2020
>>=20
>> Signed-off-by: Tim Orling <timothy.t.orling@linux.intel.com> <mailto:ti=
mothy.t.orling@linux.intel.com>
>> ---
>>  toaster-requirements.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/toaster-requirements.txt b/toaster-requirements.txt
>> index a682b085..735b6145 100644
>> --- a/toaster-requirements.txt
>> +++ b/toaster-requirements.txt
>> @@ -1,3 +1,3 @@
>> -Django>1.8,<1.12
>> +Django>2.2,<2.3
>=20
> Is this version supported on all hosts supported by Dunfell?
>=20

It would be since Django 1.11 went EOL a while ago and it is loaded via =
=E2=80=9Cpip3 install -r toaster-requirements.txt=E2=80=9D (not requiring =
Django 2.2 to be packaged on a given bistro).

Also, toaster is currently broken on Dunfell without this change:

Traceback (most recent call last):
  File "/home/usersetup/poky/bitbake/bin/../lib/toaster/manage.py", line 1=
4, in <module>
    execute_from_command_line(sys.argv)
  File "/usr/local/lib/python3.6/dist-packages/django/core/management/__in=
it__.py", line 364, in execute_from_command_line
    utility.execute()
  File "/usr/local/lib/python3.6/dist-packages/django/core/management/__in=
it__.py", line 356, in execute
    self.fetch_command(subcommand).run_from_argv(self.argv)
  File "/usr/local/lib/python3.6/dist-packages/django/core/management/base=
.py", line 283, in run_from_argv
    self.execute(*args, **cmd_options)
  File "/usr/local/lib/python3.6/dist-packages/django/core/management/base=
.py", line 327, in execute
    self.check()
  File "/usr/local/lib/python3.6/dist-packages/django/core/management/base=
.py", line 359, in check
    include_deployment_checks=3Dinclude_deployment_checks,
  File "/usr/local/lib/python3.6/dist-packages/django/core/management/base=
.py", line 346, in _run_checks
    return checks.run_checks(**kwargs)
  File "/usr/local/lib/python3.6/dist-packages/django/core/checks/registry=
.py", line 81, in run_checks
    new_errors =3D check(app_configs=3Dapp_configs)
  File "/usr/local/lib/python3.6/dist-packages/django/core/checks/urls.py"=
, line 16, in check_url_config
    return check_resolver(resolver)
  File "/usr/local/lib/python3.6/dist-packages/django/core/checks/urls.py"=
, line 26, in check_resolver
    return check_method()
  File "/usr/local/lib/python3.6/dist-packages/django/urls/resolvers.py", =
line 256, in check
    for pattern in self.url_patterns:
  File "/usr/local/lib/python3.6/dist-packages/django/utils/functional.py"=
, line 35, in __get__
    res =3D instance.__dict__[self.name] =3D self.func(instance)
  File "/usr/local/lib/python3.6/dist-packages/django/urls/resolvers.py", =
line 407, in url_patterns
    patterns =3D getattr(self.urlconf_module, "urlpatterns", self.urlconf_=
module)
  File "/usr/local/lib/python3.6/dist-packages/django/utils/functional.py"=
, line 35, in __get__
    res =3D instance.__dict__[self.name] =3D self.func(instance)
  File "/usr/local/lib/python3.6/dist-packages/django/urls/resolvers.py", =
line 400, in urlconf_module
    return import_module(self.urlconf_name)
  File "/usr/lib/python3.6/importlib/__init__.py", line 126, in import_mod=
ule
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 994, in _gcd_import
  File "<frozen importlib._bootstrap>", line 971, in _find_and_load
  File "<frozen importlib._bootstrap>", line 955, in _find_and_load_unlock=
ed
  File "<frozen importlib._bootstrap>", line 665, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 678, in exec_module
  File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_rem=
oved
  File "/home/usersetup/poky/bitbake/lib/toaster/toastermain/urls.py", lin=
e 72, in <module>
    if p.pattern.regex.pattern =3D=3D '^' + modulename + '/':
AttributeError: 'RegexURLResolver' object has no attribute =E2=80=98patter=
n'

> - armin
>>  beautifulsoup4>=3D4.4.0
>>  pytz
>>=20
>>=20
>=20
>=20


--Apple-Mail=_9B9F986E-8E66-4CCE-82E0-3B309759EBF7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;" class=3D""><br class=3D""><div><br c=
lass=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On May 28, 2=
020, at 12:03 PM, akuster808 &lt;<a href=3D"mailto:akuster808@gmail.com" cl=
ass=3D"">akuster808@gmail.com</a>&gt; wrote:</div><br class=3D"Apple-interc=
hange-newline"><div class=3D"">
  
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8" class=3D"">
  
  <div class=3D"">
    <br class=3D"">
    <br class=3D"">
    <div class=3D"moz-cite-prefix">On 5/27/20 4:25 PM, Tim Orling wrote:<b=
r class=3D"">
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20200527232512.27409-1-timothy.t=
.orling@linux.intel.com" class=3D"">
      <pre class=3D"moz-quote-pre" wrap=3D"">In commit 9730f95686b2ac72cf1=
fa513c555f7c7787e2667
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
+Django&gt;2.2,&lt;2.3</pre>
    </blockquote>
    <br class=3D"">
    Is this version supported on all hosts supported by Dunfell?<br class=
=3D"">
    <br class=3D""></div></div></blockquote><div><br class=3D""></div>It w=
ould be since Django 1.11 went EOL a while ago and it is loaded via =E2=80=
=9Cpip3 install -r toaster-requirements.txt=E2=80=9D (not requiring Django=
 2.2 to be packaged on a given bistro).</div><div><br class=3D""></div><div=
>Also, toaster is currently broken on Dunfell without this change:</div><di=
v><br class=3D""></div><div><div>Traceback (most recent call last):</div><d=
iv>&nbsp; File "/home/usersetup/poky/bitbake/bin/../lib/toaster/manage.py",=
 line 14, in &lt;module&gt;</div><div>&nbsp; &nbsp; execute_from_command_li=
ne(sys.argv)</div><div>&nbsp; File "/usr/local/lib/python3.6/dist-packages/=
django/core/management/__init__.py", line 364, in execute_from_command_line=
</div><div>&nbsp; &nbsp; utility.execute()</div><div>&nbsp; File "/usr/loca=
l/lib/python3.6/dist-packages/django/core/management/__init__.py", line 356=
, in execute</div><div>&nbsp; &nbsp; self.fetch_command(subcommand).run_fro=
m_argv(self.argv)</div><div>&nbsp; File "/usr/local/lib/python3.6/dist-pack=
ages/django/core/management/base.py", line 283, in run_from_argv</div><div>=
&nbsp; &nbsp; self.execute(*args, **cmd_options)</div><div>&nbsp; File "/us=
r/local/lib/python3.6/dist-packages/django/core/management/base.py", line 3=
27, in execute</div><div>&nbsp; &nbsp; self.check()</div><div>&nbsp; File "=
/usr/local/lib/python3.6/dist-packages/django/core/management/base.py", lin=
e 359, in check</div><div>&nbsp; &nbsp; include_deployment_checks=3Dinclude=
_deployment_checks,</div><div>&nbsp; File "/usr/local/lib/python3.6/dist-pa=
ckages/django/core/management/base.py", line 346, in _run_checks</div><div>=
&nbsp; &nbsp; return checks.run_checks(**kwargs)</div><div>&nbsp; File "/us=
r/local/lib/python3.6/dist-packages/django/core/checks/registry.py", line 8=
1, in run_checks</div><div>&nbsp; &nbsp; new_errors =3D check(app_configs=
=3Dapp_configs)</div><div>&nbsp; File "/usr/local/lib/python3.6/dist-packa=
ges/django/core/checks/urls.py", line 16, in check_url_config</div><div>&nb=
sp; &nbsp; return check_resolver(resolver)</div><div>&nbsp; File "/usr/loca=
l/lib/python3.6/dist-packages/django/core/checks/urls.py", line 26, in chec=
k_resolver</div><div>&nbsp; &nbsp; return check_method()</div><div>&nbsp; F=
ile "/usr/local/lib/python3.6/dist-packages/django/urls/resolvers.py", line=
 256, in check</div><div>&nbsp; &nbsp; for pattern in self.url_patterns:</d=
iv><div>&nbsp; File "/usr/local/lib/python3.6/dist-packages/django/utils/fu=
nctional.py", line 35, in __get__</div><div>&nbsp; &nbsp; res =3D instance.=
__dict__[self.name] =3D self.func(instance)</div><div>&nbsp; File "/usr/loc=
al/lib/python3.6/dist-packages/django/urls/resolvers.py", line 407, in url_=
patterns</div><div>&nbsp; &nbsp; patterns =3D getattr(self.urlconf_module, =
"urlpatterns", self.urlconf_module)</div><div>&nbsp; File "/usr/local/lib/p=
ython3.6/dist-packages/django/utils/functional.py", line 35, in __get__</di=
v><div>&nbsp; &nbsp; res =3D instance.__dict__[self.name] =3D self.func(ins=
tance)</div><div>&nbsp; File "/usr/local/lib/python3.6/dist-packages/django=
/urls/resolvers.py", line 400, in urlconf_module</div><div>&nbsp; &nbsp; re=
turn import_module(self.urlconf_name)</div><div>&nbsp; File "/usr/lib/pytho=
n3.6/importlib/__init__.py", line 126, in import_module</div><div>&nbsp; &n=
bsp; return _bootstrap._gcd_import(name[level:], package, level)</div><div>=
&nbsp; File "&lt;frozen importlib._bootstrap&gt;", line 994, in _gcd_import=
</div><div>&nbsp; File "&lt;frozen importlib._bootstrap&gt;", line 971, in =
_find_and_load</div><div>&nbsp; File "&lt;frozen importlib._bootstrap&gt;",=
 line 955, in _find_and_load_unlocked</div><div>&nbsp; File "&lt;frozen imp=
ortlib._bootstrap&gt;", line 665, in _load_unlocked</div><div>&nbsp; File "=
&lt;frozen importlib._bootstrap_external&gt;", line 678, in exec_module</di=
v><div>&nbsp; File "&lt;frozen importlib._bootstrap&gt;", line 219, in _cal=
l_with_frames_removed</div><div>&nbsp; File "/home/usersetup/poky/bitbake/l=
ib/toaster/toastermain/urls.py", line 72, in &lt;module&gt;</div><div>&nbsp=
; &nbsp; if p.pattern.regex.pattern =3D=3D '^' + modulename + '/':</div><di=
v>AttributeError: 'RegexURLResolver' object has no attribute =E2=80=98patte=
rn'</div><div><br class=3D""></div><blockquote type=3D"cite" class=3D""><di=
v class=3D""><div class=3D"">
    - armin<br class=3D"">
    <blockquote type=3D"cite" cite=3D"mid:20200527232512.27409-1-timothy.t=
.orling@linux.intel.com" class=3D"">
      <pre class=3D"moz-quote-pre" wrap=3D""> beautifulsoup4&gt;=3D4.4.0
 pytz
</pre>
      <br class=3D"">
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <pre class=3D"moz-quote-pre" wrap=3D""></pre>
    </blockquote>
    <br class=3D"">
  </div>

<br class=3D""></div></blockquote></div><br class=3D""></body></html>

--Apple-Mail=_9B9F986E-8E66-4CCE-82E0-3B309759EBF7--
