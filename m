Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F244C021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 04:49:16 +0000 (UTC)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web10.4033.1740631746927022675
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 20:49:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HLf1JoKG;
 spf=pass (domain: gmail.com, ip: 209.85.166.172, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d19e40a891so1893285ab.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 20:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740631746; x=1741236546; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4MsxHegKw3Gk36UKNhzXWM5LT3r03Kf9y2IPZMQUBPs=;
        b=HLf1JoKG3SF1W1f4yFbDPA1VBYpppwqRvs7TngWnVy1Fq3dX823V0owTGUvZYvhT7l
         jHYvya9HuHWzADWEBKaCEp1NHaI0T0hW9Gb7ih37uj6S61989SUMdQyI2emph8Vqew59
         nrIYGavd5w1tNvjgjp6km8rXG14kfqA0RMpNw5GqfXFk4EtT5LvtnI4+lv6mvstYfQE4
         48ES6wf8nBM+9MUoPWoEwNJp0VMOVcDmGE7EZlDoq7RYCHYwRO1XGq32qKu7+niaoLKD
         o+VeNO04f6JiFD4z8FDYs2TWpeLb2n3esasF3Jv6tc9B48iWu6QIpBgRQxoig5ZRtBTj
         6kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631746; x=1741236546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MsxHegKw3Gk36UKNhzXWM5LT3r03Kf9y2IPZMQUBPs=;
        b=v1orVTblMTFPLjDQ+8N1u8e+AVL4/vB63t7jI1R+SMNcE0yuUw31lROVUkiTC9gn08
         9DsMcTLsLNPb4iDq8XA55QE4VaO6rXAia9YzwX1ZOww6ukyspEUxelXjiK260+jOStF3
         AuWclDroVgfrKhPxC1zsjf8P3hAhoCXoxq5jyurWvJM22bo+ox15InFbEKHnzoxBVFSZ
         FeBMGE20ww2pD1L3K7sL6DD/m2+oFT/nowRqcV6cYbe2r1WMMhLB62XsVQSY8uM+kiVI
         Hn6jS3cl3Fnn+8xZDozfxS+e2zzqtIZlvZk+DmCE0IGPILA9cau+8CLyh383zpK32kFI
         2s+w==
X-Gm-Message-State: AOJu0YxBxqmO+VhsAHFc7BwdgiXtiuGPM0QAn86RvQtiihQwFPx7ZCf9
	HYVCDyEsClXGRoBcDBJmgYsU3NdTtDhsrZTv5u8PnJWwH3HbFojiYPj7ObkaQ3iH5wED5SLyoBm
	JxNOP1k/jwh25AYzXS8iYTZiQi3o=
X-Gm-Gg: ASbGncvrlVfDwGH1835JyafP1yRdT5ejYLP7dnJZXEa2sFXqWBcTQyYWImDSInCoH+q
	qKCTm3BuX/6NyAf9wadH9YlHWpzC7k7HrlZREUDVO+lZhsMX/8/on5PUFOmtZimEV+z8MwZwCZx
	1ONtNN+XTDZ3gESBSj1n8rEoPdQgfeEIvC09G21eDl
X-Google-Smtp-Source: AGHT+IHSMDjk6LWDVtIsN6+RfPR/+twpRUYu1EXQh6Zr4hsFVlS6zzCoEqzqlxzqBq38Piz+H4j7ijPZe9oSvVpkY3k=
X-Received: by 2002:a05:6e02:13ad:b0:3d3:deee:de2f with SMTP id
 e9e14a558f8ab-3d3deeee2cdmr9979095ab.7.1740631745998; Wed, 26 Feb 2025
 20:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20250226124720.6462-1-eric.meyers@arthrex.com>
 <20250226124720.6462-2-eric.meyers@arthrex.com> <CAB=6tBS6MwA_rwuttiwcfmr+QfWuvtt7FGihTVAFO0qQ2vMmZA@mail.gmail.com>
In-Reply-To: <CAB=6tBS6MwA_rwuttiwcfmr+QfWuvtt7FGihTVAFO0qQ2vMmZA@mail.gmail.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Wed, 26 Feb 2025 20:48:48 -0800
X-Gm-Features: AQ5f1JocR4cV0GD0PNmv66ETf7YR3VTE8Ada4GYtU5nD2tKdAgogpiDwJXEaGEc
Message-ID: <CAB=6tBQr2=oEhk3VB0r9qe0s5tYPyyhDPkGYMOYut6n=ExE7vQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Eric Meyers <eric.meyers15310@gmail.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Alexander Kanavin <alex.kanavin@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e7b988062f1868a4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 04:49:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17336

--000000000000e7b988062f1868a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 11:14=E2=80=AFAM Chuck Wolber <chuckwolber@gmail.co=
m> wrote:

>
> On Wed, Feb 26, 2025 at 4:47=E2=80=AFAM Eric Meyers <eric.meyers15310@gma=
il.com>
> wrote:
>
>> Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
>> Cc: Geoff Parker <geoffrey.parker@arthrex.com>
>> Cc: Alexander Kanavin <alex.kanavin@gmail.com>
>> Cc: Chuck Wolber <chuckwolber@gmail.com>
>> ---
>>  lib/bb/fetch2/npm.py | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
>> index c09f05044..7486049b8 100644
>> --- a/lib/bb/fetch2/npm.py
>> +++ b/lib/bb/fetch2/npm.py
>> @@ -107,6 +107,22 @@ class NpmEnvironment(object):
>>          """Run npm command in a controlled environment"""
>>          with tempfile.TemporaryDirectory() as tmpdir:
>>              d =3D bb.data.createCopy(self.d)
>> +
>> +            # If the user opts to use their own NPMRC file, then use it
>> within the NPM environment
>> +            # (along with the user provided configs). Otherwise, leave
>> it blank.
>> +            if d.getVar("BB_USE_HOME_NPMRC_FILE") =3D=3D "1":
>> +                home_npmrc_file =3D os.path.join(os.environ.get("HOME")=
,
>> ".npmrc")
>> +                tmp_npmrc_file =3D os.path.join(tmpdir, ".npmrc")
>> +                bb.warn("BB_USE_HOME_NPMRC_FILE flag is set - NPM
>> fetcher will now use the .npmrc file in the HOME directory.")
>> +                if os.path.exists(home_npmrc_file):
>> +                    bb.utils.copyfile(home_npmrc_file, tmp_npmrc_file)
>> +                    # Still need to append the contents of the user
>> config created in __init__
>> +                    with open(tmp_npmrc_file, 'a') as t:
>> +                        with open(self.user_config.name, 'r') as u:
>> +                            t.write(u.read())
>> +                            t.flush()
>> +                    self.user_config.name =3D tmp_npmrc_file
>> +
>>              d.setVar("PATH", d.getVar("PATH"))  # PATH might contain
>> $HOME - evaluate it before patching
>>              d.setVar("HOME", tmpdir)
>>
>>
>
> Thank you for the patch! I see a few nits.
>
> Recommendations further down in this message somewhat obviate this first
> one, but I am including it anyway for completeness. I think you should
> combine the two if statements. There does not seem to be any point in
> printing the bb.warn if there is no ${HOME}/.nmprc file.
>
> I like the use of the BB_USE_ prefix, because it vests the policy decisio=
n
> to
> allow outside influence with bitbake, where it belongs. However I recomme=
nd
> shortening it a bit to BB_USE_HOME_NPMRC. The addition of _FILE seems a
> little
> redundant, and it narrows the future options a bit more than necessary.
>
> And, given that you are adding a new variable, I think you should include=
 a
> patch to add that variable to the bitbake manual.
>
> Rather than clutter things up in the run() method, you can simplify your
> change greatly by creating a separate instance method (e.g.
> __home_npmrc(..))
> in the NpmEnvironment class which only returns a file path, or None. It i=
s
> in
> that method that you would check for the ${HOME}/.npmrc file, the
> BB_HOME_NPMRC
> flag, and do the bb.warn. Then you would return the string that is the fi=
le
> path to the user's .npmrc. No need for any file copy, or renaming.
>
> Then in NpmEnvironment __init__ you would do something like this:
>
> self.user_config =3D self.home_npmrc(self, d)
> if self.user_config is None:
>     self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", bufferin=
g=3D1)
> for key, value in configs:
>     self.user_config.write("%s=3D%s\n" % (key, value))
>


Apologies for not proof-reading my code. That example code is obviously not
what you would want to do. Hopefully the actual meaning bled through
somehow.

I meant something closer to this:

self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", buffering=3D1)
hn =3D self.home_npmrc(self, d)
if hn is not None:
   with open(hn, 'r') as hnf:
      self.user_config.write(hnf.read())
for key, value in configs:
   self.user_config.write("%s=3D%s\n" % (key, value))


..Ch:W..


--=20



*  Opinions expressed are my own. | --------------------------------|------
"Perfection must be reached by degrees              she requires the slow
hand of time."                                 |       -Voltaire*

--000000000000e7b988062f1868a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2025 at=
 11:14=E2=80=AFAM Chuck Wolber &lt;<a href=3D"mailto:chuckwolber@gmail.com"=
>chuckwolber@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-=
family:monospace"><br></div></div>On Wed, Feb 26, 2025 at 4:47=E2=80=AFAM E=
ric Meyers &lt;<a href=3D"mailto:eric.meyers15310@gmail.com" target=3D"_bla=
nk">eric.meyers15310@gmail.com</a>&gt; wrote:<div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Eric Meyers &=
lt;<a href=3D"mailto:eric.meyers@arthrex.com" target=3D"_blank">eric.meyers=
@arthrex.com</a>&gt;<br>
Cc: Geoff Parker &lt;<a href=3D"mailto:geoffrey.parker@arthrex.com" target=
=3D"_blank">geoffrey.parker@arthrex.com</a>&gt;<br>
Cc: Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=
=3D"_blank">alex.kanavin@gmail.com</a>&gt;<br>
Cc: Chuck Wolber &lt;<a href=3D"mailto:chuckwolber@gmail.com" target=3D"_bl=
ank">chuckwolber@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/npm.py | 16 ++++++++++++++++<br>
=C2=A01 file changed, 16 insertions(+)<br>
<br>
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
index c09f05044..7486049b8 100644<br>
--- a/lib/bb/fetch2/npm.py<br>
+++ b/lib/bb/fetch2/npm.py<br>
@@ -107,6 +107,22 @@ class NpmEnvironment(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run npm command in a co=
ntrolled environment&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with tempfile.TemporaryDirectory() as tmp=
dir:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =3D bb.data.createCopy(se=
lf.d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # If the user opts to use their =
own NPMRC file, then use it within the NPM environment<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # (along with the user provided =
configs). Otherwise, leave it blank.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.getVar(&quot;BB_USE_HOME_NP=
MRC_FILE&quot;) =3D=3D &quot;1&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 home_npmrc_file =
=3D os.path.join(os.environ.get(&quot;HOME&quot;), &quot;.npmrc&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp_npmrc_file =3D=
 os.path.join(tmpdir, &quot;.npmrc&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;BB_U=
SE_HOME_NPMRC_FILE flag is set - NPM fetcher will now use the .npmrc file i=
n the HOME directory.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(=
home_npmrc_file):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.u=
tils.copyfile(home_npmrc_file, tmp_npmrc_file)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # St=
ill need to append the contents of the user config created in __init__<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with=
 open(tmp_npmrc_file, &#39;a&#39;) as t:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 with open(<a href=3D"http://self.user_config.name" rel=3D"norefe=
rrer" target=3D"_blank">self.user_config.name</a>, &#39;r&#39;) as u:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 t.write(u.read())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 t.flush()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a h=
ref=3D"http://self.user_config.name" rel=3D"noreferrer" target=3D"_blank">s=
elf.user_config.name</a> =3D tmp_npmrc_file<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d.setVar(&quot;PATH&quot;, =
d.getVar(&quot;PATH&quot;))=C2=A0 # PATH might contain $HOME - evaluate it =
before patching<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d.setVar(&quot;HOME&quot;, =
tmpdir)<br>
<br></blockquote></div><div><br><br><div style=3D"font-family:monospace">Th=
ank you for the patch! I see a few nits.<br><br>Recommendations further dow=
n in this message somewhat obviate this first</div><div style=3D"font-famil=
y:monospace">one, but I am including it anyway for completeness. I think yo=
u should</div><div style=3D"font-family:monospace">combine the two if state=
ments. There does not seem to be any point in</div><div style=3D"font-famil=
y:monospace">printing the bb.warn if there is no ${HOME}/.nmprc file.</div>=
<br></div><div><div style=3D"font-family:monospace">I like the use of the B=
B_USE_ prefix, because it vests the policy decision to</div><div style=3D"f=
ont-family:monospace">allow outside influence with bitbake, where it belong=
s. However I recommend</div><div style=3D"font-family:monospace">shortening=
 it a bit to BB_USE_HOME_NPMRC. The addition of _FILE seems a little<br>red=
undant, and it narrows the future options a bit more than necessary.<br><br=
></div><div style=3D"font-family:monospace">And, given that you are adding =
a new variable, I think you should include a</div><div style=3D"font-family=
:monospace">patch to add that variable to the bitbake manual.</div><div sty=
le=3D"font-family:monospace"><br></div><div style=3D"font-family:monospace"=
>Rather than clutter things up in the run() method, you can simplify your</=
div><div style=3D"font-family:monospace">change greatly by creating a separ=
ate instance method (e.g. __home_npmrc(..))</div><div style=3D"font-family:=
monospace">in the NpmEnvironment class which only returns a file path, or N=
one. It is in</div><div style=3D"font-family:monospace">that method that yo=
u would check for the ${HOME}/.npmrc file, the BB_HOME_NPMRC</div><div styl=
e=3D"font-family:monospace">flag, and do the bb.warn. Then you would return=
 the string that is the file</div><div style=3D"font-family:monospace">path=
 to the user&#39;s .npmrc. No need for any file copy, or renaming.</div><di=
v style=3D"font-family:monospace"><br></div><div style=3D"font-family:monos=
pace">Then in NpmEnvironment __init__ you would do something like this:</di=
v><div style=3D"font-family:monospace"><br>self.user_config =3D self.home_n=
pmrc(self, d)<br>if self.user_config is None:<br>=C2=A0=C2=A0=C2=A0 self.us=
er_config =3D tempfile.NamedTemporaryFile(mode=3D&quot;w&quot;, buffering=
=3D1)<br></div><div style=3D"font-family:monospace">for key, value in confi=
gs:<br>=C2=A0=C2=A0=C2=A0 self.user_config.write(&quot;%s=3D%s\n&quot; % (k=
ey, value))</div></div></div></blockquote><div><br></div><div><div style=3D=
"font-family:monospace" class=3D"gmail_default"><br></div><div style=3D"fon=
t-family:monospace" class=3D"gmail_default">Apologies for not proof-reading=
 my code. That example code is obviously not</div><div style=3D"font-family=
:monospace" class=3D"gmail_default">what you would want to do. Hopefully th=
e actual meaning bled through somehow.</div><div style=3D"font-family:monos=
pace" class=3D"gmail_default"><br></div><div style=3D"font-family:monospace=
" class=3D"gmail_default">I meant something closer to this:<br><br></div><d=
iv style=3D"font-family:monospace" class=3D"gmail_default">self.user_config=
 =3D tempfile.NamedTemporaryFile(mode=3D&quot;w&quot;, buffering=3D1)</div>=
<div style=3D"font-family:monospace" class=3D"gmail_default">hn =3D self.ho=
me_npmrc(self, d)</div><div style=3D"font-family:monospace" class=3D"gmail_=
default">if hn is not None:</div><div style=3D"font-family:monospace" class=
=3D"gmail_default">=C2=A0=C2=A0 with open(hn, &#39;r&#39;) as hnf:</div><di=
v style=3D"font-family:monospace" class=3D"gmail_default">=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 self.user_config.write(hnf.read())</div><div style=3D"font-=
family:monospace" class=3D"gmail_default">for key, value in configs:</div><=
div style=3D"font-family:monospace" class=3D"gmail_default">=C2=A0=C2=A0 se=
lf.user_config.write(&quot;%s=3D%s\n&quot; % (key, value))</div></div><div>=
<br></div><div><br><div style=3D"font-family:monospace" class=3D"gmail_defa=
ult">..Ch:W..</div><br></div><div><br></div></div><span class=3D"gmail_sign=
ature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div=
 dir=3D"ltr"><div><b><span style=3D"font-family:monospace">=C2=A0 Opinions =
expressed are my own. |<br>=C2=A0--------------------------------|------ &q=
uot;Perfection must be reached by degrees<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 she requires the slow hand=
 of time.&quot;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 -Voltaire</span></b></div></div></div></div>

--000000000000e7b988062f1868a4--

