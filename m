Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B443FCEBF95
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 10:53:53 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.66416.1727434428799348864
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Sep 2024 03:53:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R8e25A1X;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53653ff0251so2474804e87.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Sep 2024 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727434427; x=1728039227; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gMtEpzVr2v+JsYI6C2gonitYr2ABw1hiReEIqvTsUw=;
        b=R8e25A1X1qmlKrlJXknfowLCKvqQWdSksIIFcOZGKMkLDZLBkzumtMRez3AK8n1ljc
         rzSE9EJ0D2OvydmTrTKiKvQW8+SZF40zbVBhQ/7vq0bfSi7VmwcAFSgvlMyPb2GyiBIh
         NpAiHoVh01iy3H+RzAQdkc//4oY0fiGHFHfRAgXLatlfxFhIfDhz+2I6G/wGdbppw9Mc
         cDiUvVbMdroshbTxy4VT7VTJAi98DQwshtBuzfi8WXWKXlJxRzwidat0Ii2ssotAtiVG
         /P8k9wKxGdeJzuVGRjNfQ/dCsdzNoDaIk0E8RZT+ZzookGTRE6GG3OAHY9Be7QcxeB9Y
         Dbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727434427; x=1728039227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gMtEpzVr2v+JsYI6C2gonitYr2ABw1hiReEIqvTsUw=;
        b=hP6SEEkItLcjvtHE582w98xU9cg1JC6fKyfMu/QYK/j/lwquwh1U6wJ9dF58GokjAC
         Jt+ELSBpLyiQN7PvwjJdlSZQu5gt56lLmcKqGf87xLLWXUR9Xqc147QmCZ1c6xK69mEE
         94VMUQv+xN1sB/paSgt/HxjjpwkRCNCmJQ35NTx1O42UWac2hY+ZNUC4Vz88E4QgbSf5
         6v6zOlgkn3vesakZq+NBeTCqTeQ1c4oHv3OrC5/7Fm3CCXqvyoZ58ma65qCrQsbpuT3j
         gXfPM0rQ8K4PGbI7sIKjIdDt3FyJR+2Eog2sLCv0mo5BrgEG8o7KmT0LzSQ/AmpzkAEY
         iIkw==
X-Gm-Message-State: AOJu0YxfgIexaI/KmdXC3LECQICCEymMQQxe30OigHyqlmvyQerzvM0T
	SuFrPTm3B2CNDhyQAHFHicQn8DVHVa+nTDu+m/gyeji1MGPT4f4NzlwfAw/aOBBH8vv9y1WHCsi
	eW959eV7geOrbqFG+0khlIfAPPs8=
X-Google-Smtp-Source: AGHT+IFw+nQZDUePKjTjaI1FeWx2sdH1NfzXwg03eXaBqFKelcbCbEUx5xDYkmNTl/Wt+g+UBEiCG4v/JdKYUCulMHo=
X-Received: by 2002:a05:6512:3ca4:b0:536:7a24:8e89 with SMTP id
 2adb3069b0e04-5389fc6b191mr1683037e87.49.1727434426276; Fri, 27 Sep 2024
 03:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj_3XLABQZLYvRuQu+PnQ52gDRS8pXgQDS-SBfp8g9o=sA@mail.gmail.com>
 <29158.1727362658714839430@lists.openembedded.org> <CANNYZj9y7cMMEd__1s5POt64HMhY_xxKrBt38T=uLT2aPRKD4w@mail.gmail.com>
 <CAAc_J+-b1SPPcy9kZisFWCacmORXbZcKu-7Ab-ZKDywWqy03gg@mail.gmail.com>
In-Reply-To: <CAAc_J+-b1SPPcy9kZisFWCacmORXbZcKu-7Ab-ZKDywWqy03gg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 27 Sep 2024 12:53:34 +0200
Message-ID: <CANNYZj_YxgeQ6e=YALKLbXRezhHASEF47ZQ=PHwG1oYxbxBeQw@mail.gmail.com>
Subject: Re: [bitbake-devel] URL encoding/decoding bug with files like
 "serialgetty@.service" or "sshd@.service" with archiver.bbclass #poky
 #bitbake #kirkstone
To: Brennan Coslett <brennan.coslett@bluerivertech.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Sep 2024 10:53:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16609

Can you turn these into patches, and send them as RFC?

Alex

On Thu, 26 Sept 2024 at 17:31, Brennan Coslett
<brennan.coslett@bluerivertech.com> wrote:
>
> Okay I added an additional test case to URLHandle which then tests encodi=
ng and decoding the original patch I sent worked for decoding
> but in the encoding test it converted "@" to "%40" which I dont think we =
need for local files. The test-case looks like:
>
> diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
> index 4e26e38811..dff7780e33 100644
> --- a/bitbake/lib/bb/tests/fetch.py
> +++ b/bitbake/lib/bb/tests/fetch.py
> @@ -1390,6 +1390,7 @@ class URLHandle(unittest.TestCase):
>         "file://somelocation;someparam=3D1": ('file', '', 'somelocation',=
 '', '', {'someparam': '1'}),
>         "https://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234"=
 : ('https', 'somesite.com', '/somerepo.git', '', '', {'user': 'anyUser:idt=
oken=3D1234'}),
>         r'git://s.o-me_ONE:!#$%^&*()-_=3D{}[]\|:?,.<>~`@git.openembedded.=
org/bitbake;branch=3Dmain;protocol=3Dhttps': ('git', 'git.openembedded.org'=
, '/bitbake', 's.o-me_ONE', r'!#$%^&*()-_=3D{}[]\|:?,.<>~`', {'branch': 'ma=
in', 'prot
> ocol' : 'https'}),
> +       "file://serialgetty@.service" : ('file', '', 'serialgetty@.servic=
e', '', '', {}),
>      }
>      # we require a pathname to encodeurl but users can still pass such u=
rls to
>      # decodeurl and we need to handle them
>
> So adding the encodeurl change I needed:
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
> index ddee4400bb..4ea561e1f8 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -369,6 +369,11 @@ def decodeurl(url):
>          path =3D location[locidx:]
>      elif type.lower() =3D=3D 'file':
>          host =3D ""
> +        # parsing out a user doesn't make sense for
> +        # local files?
> +        if user:
> +            location =3D "%s@%s" % (user, location)
> +            user =3D None
>          path =3D location
>      else:
>          host =3D location
> @@ -414,7 +419,12 @@ def encodeurl(decoded):
>          # Standardise path to ensure comparisons work
>          while '//' in path:
>              path =3D path.replace("//", "/")
> -        url.append("%s" % urllib.parse.quote(path))
> +        urllib_parsed =3D urllib.parse.urlparse(path).path
> +        if type =3D=3D "file":
> +            # Local systemd template file paths don't need the
> +            # escaped character.
> +            urllib_parsed =3D urllib_parsed.replace('%40', '@')
> +        url.append(urllib_parsed)
>      if p:
>          for parm in p:
>              url.append(";%s=3D%s" % (parm, p[parm]))
> - Brennan
>
> On Thu, Sep 26, 2024 at 10:03=E2=80=AFAM Alexander Kanavin <alex.kanavin@=
gmail.com> wrote:
>>
>> On Thu, 26 Sept 2024 at 16:57, Brennan Coslett via
>> lists.openembedded.org
>> <brennan.coslett=3Dbluerivertech.com@lists.openembedded.org> wrote:
>> >
>> > I think the bug is in `bb.fetch.decodeurl`, I just noticed it because =
of the archiver.
>> > @Alex if that means it should still move over to the oe-core list, let=
 me know and I can do that.
>>
>> Right, let's stay here.
>>
>> > Steps to replicate:
>> > 1. Checkout poky master (just replicated with 8634e46b4040b6008410b6d7=
7fecb5cbaec7e90e)
>> > 2. source oe-init-build-env
>> > 3. append the following to the auto-generated local.conf:
>> >     + require conf/distro/include/init-manager-systemd.inc
>> >     + INHERIT +=3D "archiver"
>> >     + ARCHIVER_MODE[src] =3D "original"
>> > 4. Run "bitbake systemd-serialgetty", the source dir will be created b=
ut it wont contain anything:
>> >     brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$ ls tmp/=
deploy/sources/x86_64-poky-linux/systemd-serialgetty-1.0-r0/
>> >     brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$
>> >
>> > I think something in the regex inside the `decodeurl` function in `bit=
bake/lib/bb/fetch2/__init__.py` needs to change to stop it from
>> > parsing out `<name>@`  in `<name>@.service` into the `user` field or m=
aybe it needs additional logic inside that function when its a
>> > local file to put the parsed out `user` group back into the `location`=
 group? This appears to fix it but i'm not sure if this is actually valid,
>> > if it is I can submit it as an actual patch. I think there should prob=
ably be a corresponding addition of a fetch test around these types of
>> > files?
>>
>> Let's do test driven development here :) There are tests for fetchers
>> in bitbake/lib/bb/tests/fetch.py - if you can check and add a test
>> that exposes this issue (e.g. fails without the fix and passes with
>> it), then we can discuss what the best fix would be. Run them with
>> bitbake-selftest.
>>
>> Alex

