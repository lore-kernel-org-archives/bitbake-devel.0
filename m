Return-Path: <danismostlikely@gmail.com>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
	[209.85.220.196])
	by mail.openembedded.org (Postfix) with ESMTP id 500A865C9C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 15:14:36 +0000 (UTC)
Received: by qkan20 with SMTP id n20so286606qka.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=VWkhGHqtbas4NSfHq5nwHlGgrB8MIanO2ighuiTDvNQ=;
	b=wkfTcskxmf/Xfj3ibVB2sLj0sDvOeU4GK94ai5Obw482cgYCV7rJo1nt0qt2RrFtz5
	IBeeaxMqdv9Smhg2+MK63+RUi9nTQY+ZPYUPSzWAXxF6gKwvPAJPEZ0wJ+RwZEVQLLXL
	sKN6IJ5Sk2Ms3Qt0hNJHHDjbOC/tkIaGrE1fnc9h/bcFkH+oZJFeplqzLmo0JECnORtW
	TN9sA3JxxQZ0s0ly7izY/UgVYOmVG+ZDufpy2UnKNul/EIYTBTdq0tqloeCbQU+CpoYt
	7m6+i4l99OnkqWHIisG85ax4Bpxoz5V0RcQWqWbLhRV5kyqwVeiiGcJ+3gZ914IkFTVV
	ibzg==
MIME-Version: 1.0
X-Received: by 10.140.146.79 with SMTP id 76mr13173478qhs.27.1431962077629;
	Mon, 18 May 2015 08:14:37 -0700 (PDT)
Received: by 10.96.203.231 with HTTP; Mon, 18 May 2015 08:14:37 -0700 (PDT)
Received: by 10.96.203.231 with HTTP; Mon, 18 May 2015 08:14:37 -0700 (PDT)
In-Reply-To: <5559A238.4090003@windriver.com>
References: <1431401118-17064-1-git-send-email-danismostlikely@gmail.com>
	<5559A238.4090003@windriver.com>
Date: Mon, 18 May 2015 09:14:37 -0600
Message-ID: <CACS+7ZSMT2SqazbKWg4KYpsNhM6SUCwefTwj3FzQSCHwRTJjag@mail.gmail.com>
From: Dan McGregor <danismostlikely@gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v4] fetch/hg: support submodules
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
X-List-Received-Date: Mon, 18 May 2015 15:14:39 -0000
Content-Type: multipart/alternative; boundary=001a11353cbef817f005165ca6d4

--001a11353cbef817f005165ca6d4
Content-Type: text/plain; charset=UTF-8

Thanks for the heads up, I'll poke at it this evening.
On 18 May 2015 1:26 am, "Robert Yang" <liezhi.yang@windriver.com> wrote:

>
> Hello,
>
> This patches breaks the BB_GENERATE_MIRROR_TARBALLS, it doesn't generate
> or untar the local tarball any more, the local tarball's mirror doesn't
> work any more.
>
> // Robert
>
> On 05/12/2015 11:25 AM, Dan McGregor wrote:
>
>> From: Daniel McGregor <daniel.mcgregor@vecima.com>
>>
>> Use hg clone and hg pull to copy the source into the build
>> directory rather than taring up the cloned repository and
>> untarring in the destination.
>>
>> This allows submodules to be cloned. While here, make the default
>> behaviour keep the hg scm data to match the behaviour of the git
>> fetcher.
>>
>> Signed-off-by: Daniel McGregor <daniel.mcgregor@vecima.com>
>> ---
>>   lib/bb/fetch2/hg.py | 55
>> +++++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 36 insertions(+), 19 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
>> index 81592f6..6547cca 100644
>> --- a/lib/bb/fetch2/hg.py
>> +++ b/lib/bb/fetch2/hg.py
>> @@ -64,7 +64,9 @@ class Hg(FetchMethod):
>>           elif not ud.revision:
>>               ud.revision = self.latest_revision(ud, d)
>>
>> -        ud.localfile = data.expand('%s_%s_%s_%s.tar.gz' %
>> (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'),
>> ud.revision), d)
>> +        ud.localfile = ud.moddir
>> +
>> +        ud.basecmd = data.getVar("FETCHCMD_hg", d, True) or
>> "/usr/bin/env hg"
>>
>>       def need_update(self, ud, d):
>>           revTag = ud.parm.get('rev', 'tip')
>> @@ -80,8 +82,6 @@ class Hg(FetchMethod):
>>           command is "fetch", "update", "info"
>>           """
>>
>> -        basecmd = data.expand('${FETCHCMD_hg}', d)
>> -
>>           proto = ud.parm.get('protocol', 'http')
>>
>>           host = ud.host
>> @@ -98,7 +98,7 @@ class Hg(FetchMethod):
>>                   hgroot = ud.user + "@" + host + ud.path
>>
>>           if command == "info":
>> -            return "%s identify -i %s://%s/%s" % (basecmd, proto,
>> hgroot, ud.module)
>> +            return "%s identify -i %s://%s/%s" % (ud.basecmd, proto,
>> hgroot, ud.module)
>>
>>           options = [];
>>
>> @@ -111,22 +111,22 @@ class Hg(FetchMethod):
>>
>>           if command == "fetch":
>>               if ud.user and ud.pswd:
>> -                cmd = "%s --config auth.default.prefix=* --config
>> auth.default.username=%s --config auth.default.password=%s --config
>> \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (basecmd, ud.user,
>> ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
>> +                cmd = "%s --config auth.default.prefix=* --config
>> auth.default.username=%s --config auth.default.password=%s --config
>> \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (ud.basecmd, ud.user,
>> ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
>>               else:
>> -                cmd = "%s clone %s %s://%s/%s %s" % (basecmd, "
>> ".join(options), proto, hgroot, ud.module, ud.module)
>> +                cmd = "%s clone %s %s://%s/%s %s" % (ud.basecmd, "
>> ".join(options), proto, hgroot, ud.module, ud.module)
>>           elif command == "pull":
>>               # do not pass options list; limiting pull to rev causes the
>> local
>>               # repo not to contain it and immediately following "update"
>> command
>>               # will crash
>>               if ud.user and ud.pswd:
>> -                cmd = "%s --config auth.default.prefix=* --config
>> auth.default.username=%s --config auth.default.password=%s --config
>> \"auth.default.schemes=%s\" pull" % (basecmd, ud.user, ud.pswd, proto)
>> +                cmd = "%s --config auth.default.prefix=* --config
>> auth.default.username=%s --config auth.default.password=%s --config
>> \"auth.default.schemes=%s\" pull" % (ud.basecmd, ud.user, ud.pswd, proto)
>>               else:
>> -                cmd = "%s pull" % (basecmd)
>> +                cmd = "%s pull" % (ud.basecmd)
>>           elif command == "update":
>>               if ud.user and ud.pswd:
>> -                cmd = "%s --config auth.default.prefix=* --config
>> auth.default.username=%s --config auth.default.password=%s --config
>> \"auth.default.schemes=%s\" update -C %s" % (basecmd, ud.user, ud.pswd,
>> proto, " ".join(options))
>> +                cmd = "%s --config auth.default.prefix=* --config
>> auth.default.username=%s --config auth.default.password=%s --config
>> \"auth.default.schemes=%s\" update -C %s" % (ud.basecmd, ud.user, ud.pswd,
>> proto, " ".join(options))
>>               else:
>> -                cmd = "%s update -C %s" % (basecmd, " ".join(options))
>> +                cmd = "%s update -C %s" % (ud.basecmd, " ".join(options))
>>           else:
>>               raise FetchError("Invalid hg command %s" % command, ud.url)
>>
>> @@ -163,15 +163,6 @@ class Hg(FetchMethod):
>>           logger.debug(1, "Running %s", updatecmd)
>>           runfetchcmd(updatecmd, d)
>>
>> -        scmdata = ud.parm.get("scmdata", "")
>> -        if scmdata == "keep":
>> -            tar_flags = ""
>> -        else:
>> -            tar_flags = "--exclude '.hg' --exclude '.hgrags'"
>> -
>> -        os.chdir(ud.pkgdir)
>> -        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath,
>> ud.module), d, cleanup = [ud.localpath])
>> -
>>       def supports_srcrev(self):
>>           return True
>>
>> @@ -191,3 +182,29 @@ class Hg(FetchMethod):
>>           Return a unique key for the url
>>           """
>>           return "hg:" + ud.moddir
>> +
>> +    def localpath(self, ud, d):
>> +        return ud.moddir
>> +
>> +    def unpack(self, ud, destdir, d):
>> +        """
>> +        Make a local clone or export for the url
>> +        """
>> +
>> +        revflag = "-r %s" % ud.revision
>> +        subdir = ud.parm.get("destsuffix", ud.module)
>> +        codir = "%s/%s" % (destdir, subdir)
>> +
>> +        scmdata = ud.parm.get("scmdata", "")
>> +        if scmdata != "nokeep":
>> +            if not os.access(os.path.join(codir, '.hg'), os.R_OK):
>> +                logger.debug(2, "Unpack: creating new hg repository in
>> '" + codir + "'")
>> +                runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
>> +            logger.debug(2, "Unpack: updating source in '" + codir + "'")
>> +            os.chdir(codir)
>> +            runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d)
>> +            runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d)
>> +        else:
>> +            logger.debug(2, "Unpack: extracting source to '" + codir +
>> "'")
>> +            os.chdir(ud.moddir)
>> +            runfetchcmd("%s archive -t files %s %s" % (ud.basecmd,
>> revflag, codir), d)
>>
>>

--001a11353cbef817f005165ca6d4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thanks for the heads up, I&#39;ll poke at it this evening.</=
p>
<div class=3D"gmail_quote">On 18 May 2015 1:26 am, &quot;Robert Yang&quot; =
&lt;<a href=3D"mailto:liezhi.yang@windriver.com">liezhi.yang@windriver.com<=
/a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
Hello,<br>
<br>
This patches breaks the BB_GENERATE_MIRROR_TARBALLS, it doesn&#39;t generat=
e<br>
or untar the local tarball any more, the local tarball&#39;s mirror doesn&#=
39;t<br>
work any more.<br>
<br>
// Robert<br>
<br>
On 05/12/2015 11:25 AM, Dan McGregor wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Daniel McGregor &lt;<a href=3D"mailto:daniel.mcgregor@vecima.com" tar=
get=3D"_blank">daniel.mcgregor@vecima.com</a>&gt;<br>
<br>
Use hg clone and hg pull to copy the source into the build<br>
directory rather than taring up the cloned repository and<br>
untarring in the destination.<br>
<br>
This allows submodules to be cloned. While here, make the default<br>
behaviour keep the hg scm data to match the behaviour of the git<br>
fetcher.<br>
<br>
Signed-off-by: Daniel McGregor &lt;<a href=3D"mailto:daniel.mcgregor@vecima=
.com" target=3D"_blank">daniel.mcgregor@vecima.com</a>&gt;<br>
---<br>
=C2=A0 lib/bb/fetch2/hg.py | 55 +++++++++++++++++++++++++++++++++++--------=
----------<br>
=C2=A0 1 file changed, 36 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py<br>
index 81592f6..6547cca 100644<br>
--- a/lib/bb/fetch2/hg.py<br>
+++ b/lib/bb/fetch2/hg.py<br>
@@ -64,7 +64,9 @@ class Hg(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif not ud.revision:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.revision =3D self.lates=
t_revision(ud, d)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.localfile =3D data.expand(&#39;%s_%s_%s_%s.=
tar.gz&#39; % (ud.module.replace(&#39;/&#39;, &#39;.&#39;), ud.host, ud.pat=
h.replace(&#39;/&#39;, &#39;.&#39;), ud.revision), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.localfile =3D ud.moddir<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D data.getVar(&quot;FETCHCMD_hg&q=
uot;, d, True) or &quot;/usr/bin/env hg&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 def need_update(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revTag =3D ud.parm.get(&#39;rev&#39;, &#=
39;tip&#39;)<br>
@@ -80,8 +82,6 @@ class Hg(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command is &quot;fetch&quot;, &quot;upda=
te&quot;, &quot;info&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 basecmd =3D data.expand(&#39;${FETCHCMD_hg}&#3=
9;, d)<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 proto =3D ud.parm.get(&#39;protocol&#39;=
, &#39;http&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D ud.host<br>
@@ -98,7 +98,7 @@ class Hg(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hgroot =3D u=
d.user + &quot;@&quot; + host + ud.path<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if command =3D=3D &quot;info&quot;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;%s identify -i %s:/=
/%s/%s&quot; % (basecmd, proto, hgroot, ud.module)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;%s identify -i %s:/=
/%s/%s&quot; % (ud.basecmd, proto, hgroot, ud.module)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options =3D [];<br>
<br>
@@ -111,22 +111,22 @@ class Hg(FetchMethod):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if command =3D=3D &quot;fetch&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.user and ud.pswd:<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s -=
-config auth.default.prefix=3D* --config auth.default.username=3D%s --confi=
g auth.default.password=3D%s --config \&quot;auth.default.schemes=3D%s\&quo=
t; clone %s %s://%s/%s %s&quot; % (basecmd, ud.user, ud.pswd, proto, &quot;=
 &quot;.join(options), proto, hgroot, ud.module, ud.module)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s -=
-config auth.default.prefix=3D* --config auth.default.username=3D%s --confi=
g auth.default.password=3D%s --config \&quot;auth.default.schemes=3D%s\&quo=
t; clone %s %s://%s/%s %s&quot; % (ud.basecmd, ud.user, ud.pswd, proto, &qu=
ot; &quot;.join(options), proto, hgroot, ud.module, ud.module)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s c=
lone %s %s://%s/%s %s&quot; % (basecmd, &quot; &quot;.join(options), proto,=
 hgroot, ud.module, ud.module)=C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s c=
lone %s %s://%s/%s %s&quot; % (ud.basecmd, &quot; &quot;.join(options), pro=
to, hgroot, ud.module, ud.module)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif command =3D=3D &quot;pull&quot;:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # do not pass options list=
; limiting pull to rev causes the local<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # repo not to contain it a=
nd immediately following &quot;update&quot; command<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # will crash<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.user and ud.pswd:<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s -=
-config auth.default.prefix=3D* --config auth.default.username=3D%s --confi=
g auth.default.password=3D%s --config \&quot;auth.default.schemes=3D%s\&quo=
t; pull&quot; % (basecmd, ud.user, ud.pswd, proto)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s -=
-config auth.default.prefix=3D* --config auth.default.username=3D%s --confi=
g auth.default.password=3D%s --config \&quot;auth.default.schemes=3D%s\&quo=
t; pull&quot; % (ud.basecmd, ud.user, ud.pswd, proto)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s p=
ull&quot; % (basecmd)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s p=
ull&quot; % (ud.basecmd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif command =3D=3D &quot;update&quot;:<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.user and ud.pswd:<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s -=
-config auth.default.prefix=3D* --config auth.default.username=3D%s --confi=
g auth.default.password=3D%s --config \&quot;auth.default.schemes=3D%s\&quo=
t; update -C %s&quot; % (basecmd, ud.user, ud.pswd, proto, &quot; &quot;.jo=
in(options))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s -=
-config auth.default.prefix=3D* --config auth.default.username=3D%s --confi=
g auth.default.password=3D%s --config \&quot;auth.default.schemes=3D%s\&quo=
t; update -C %s&quot; % (ud.basecmd, ud.user, ud.pswd, proto, &quot; &quot;=
.join(options))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s u=
pdate -C %s&quot; % (basecmd, &quot; &quot;.join(options))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s u=
pdate -C %s&quot; % (ud.basecmd, &quot; &quot;.join(options))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;Inv=
alid hg command %s&quot; % command, ud.url)<br>
<br>
@@ -163,15 +163,6 @@ class Hg(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(1, &quot;Running %s&quot;, =
updatecmd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(updatecmd, d)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 scmdata =3D ud.parm.get(&quot;scmdata&quot;, &=
quot;&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if scmdata =3D=3D &quot;keep&quot;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tar_flags =3D &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tar_flags =3D &quot;--exclude &#=
39;.hg&#39; --exclude &#39;.hgrags&#39;&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(ud.pkgdir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;tar %s -czf %s %s&quot; % (t=
ar_flags, ud.localpath, ud.module), d, cleanup =3D [ud.localpath])<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 def supports_srcrev(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
<br>
@@ -191,3 +182,29 @@ class Hg(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Return a unique key for the url<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;hg:&quot; + ud.moddir<br>
+<br>
+=C2=A0 =C2=A0 def localpath(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.moddir<br>
+<br>
+=C2=A0 =C2=A0 def unpack(self, ud, destdir, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Make a local clone or export for the url<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 revflag =3D &quot;-r %s&quot; % ud.revision<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 subdir =3D ud.parm.get(&quot;destsuffix&quot;,=
 ud.module)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 codir =3D &quot;%s/%s&quot; % (destdir, subdir=
)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scmdata =3D ud.parm.get(&quot;scmdata&quot;, &=
quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if scmdata !=3D &quot;nokeep&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.access(os.path.join(co=
dir, &#39;.hg&#39;), os.R_OK):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(2, &q=
uot;Unpack: creating new hg repository in &#39;&quot; + codir + &quot;&#39;=
&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;=
%s init %s&quot; % (ud.basecmd, codir), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(2, &quot;Unpack: up=
dating source in &#39;&quot; + codir + &quot;&#39;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(codir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%s pull %s&quo=
t; % (ud.basecmd, ud.moddir), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%s up -C %s&qu=
ot; % (ud.basecmd, revflag), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(2, &quot;Unpack: ex=
tracting source to &#39;&quot; + codir + &quot;&#39;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(ud.moddir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%s archive -t =
files %s %s&quot; % (ud.basecmd, revflag, codir), d)<br>
<br>
</blockquote>
</blockquote></div>

--001a11353cbef817f005165ca6d4--
