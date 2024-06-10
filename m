Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DD2C27C5E
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 04:34:09 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web10.12352.1717994042866774506
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 09 Jun 2024 21:34:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lJ/i1zX9;
 spf=pass (domain: gmail.com, ip: 209.85.208.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebdfe261f9so12793061fa.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 09 Jun 2024 21:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717994041; x=1718598841; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uY10gAFvn5N6IU9kaMYm6ztM3xy8PMZYTP35XQYzQ9g=;
        b=lJ/i1zX9kGF7rGaMVfnw8967sPEJhuGenHIrNYcSt132klGG9yIh7eNvClRUgCt0cC
         Kl4/IvlWnqu+IUl+OHX9vTqy8hvEoKzN0qLUXzGYQJye2fEbcwJ8hpvW+wYddNxX1Z+u
         8/yC1oXHzNFj63kjMhr1NWhLRkAm/mP/fadeBjw9CkgEIxH+hXLYPEbzVCsKSPIWVSAC
         BHPa0XoaQyrCPDFLpugiEC02qv00iUyeva6omYPAq9FTwsy3ttY9SLJCzfUeR/JzkMqD
         Vyhep02i4aeGXG7o9y0wjbdxXm6HEtaBZA5j3T4zNBwCIyVd03kGtEX8ANyyaRQXx3bx
         pE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994041; x=1718598841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uY10gAFvn5N6IU9kaMYm6ztM3xy8PMZYTP35XQYzQ9g=;
        b=QXR9I/U9pevMlcLSbfo6BeBDvBCLgOhSqFEUy+90V+mo31TBfTrjhckH5oBhLh1FBM
         jwsQ2m9qJXHYnt9XfyAdYtLoZFmAQhi339P7tip2AhuMzz7T0Qla+aQ+/01jQ3JBvfkL
         sEzRUlg6OJqPpHxYiRof+pUxUQvuuo74+aKD2Qyv0zq3F3BaFZhOeTCemZFYbZD8UILb
         TOpvAkh4jzJ0UNopUncsBbje97zwCO/Kq4VUUiC6AZEdxifIRfIQqhWwiJD5Cjpqk01k
         fm3yAMwg/Ru2lMS/MNhxUynMGZM11Rm0NhTIa3HfHJZ7ddjx9r8EkCs1XjYr9yaiRMI9
         /zSg==
X-Gm-Message-State: AOJu0YyqXqFSG2gepPsFjzGIY9w5bMkT7JR5OZMSgQCh+juwzKpu1+tN
	uh5DvfaQKGGt7GctQKJcXNBkpg7qkXEllnUE81v/mAbXeCbY0/M3tC/bJOLKeC6AtZZvxmqguGO
	mcs+s6zWw5wk5bm0Rk/AnnNzMhBWNSw==
X-Google-Smtp-Source: AGHT+IGc+qD6KACs0zfoI3tWnyIBuHepqY2ONkxV9SjcjXKbDd3DvJk9q8P+88jSMDveEh4ILmqYR8YXF2mqHAozCJQ=
X-Received: by 2002:a2e:7c16:0:b0:2ea:e9f9:6acc with SMTP id
 38308e7fff4ca-2eae9f96bccmr49212161fa.35.1717994040579; Sun, 09 Jun 2024
 21:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240609220226.977-1-egyszeregy@freemail.hu> <17D789EEBA45C61A.15183@lists.openembedded.org>
In-Reply-To: <17D789EEBA45C61A.15183@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 10 Jun 2024 06:33:49 +0200
Message-ID: <CANNYZj-viDOqH+GUsehwYukr0SKJsu8qwKbGyvEgmXW-ob4drQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/wget: Add user_agent parameter
 so it can be used optionally
To: bitbake-devel@lists.openembedded.org, egyszeregy@freemail.hu
Cc: docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000083dbbd061a81a82e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 04:34:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16337

--00000000000083dbbd061a81a82e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On second thought, you did mention that FETCHCMD_whet can be used to set a
custom user agent in one of the tickets, so if this can be done per recipe
there is no need to add a new variable.

Ale

On Mon 10. Jun 2024 at 6.24, Alexander Kanavin via lists.openembedded.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:

> No. I really do not like the idea that we should pretend to be Firefox.
> And you didn=E2=80=99t answer Ross questions properly.
>
> Fix the servers please.
>
> Alex
>
>
>
> On Mon 10. Jun 2024 at 0.02, Livius via lists.openembedded.org
> <egyszeregy=3Dfreemail.hu@lists.openembedded.org> wrote:
>
>> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>>
>> Add "user_agent" optional parameter for wget fetcher to able
>> to use it if HTTP servers block requests with the default wget
>> user agent.
>>
>> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>> ---
>>  conf/bitbake.conf                             |  1 +
>>  .../bitbake-user-manual-fetching.rst          | 23 +++++++++++++------
>>  .../bitbake-user-manual-ref-variables.rst     |  5 ++++
>>  lib/bb/fetch2/wget.py                         | 11 +++++----
>>  4 files changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/conf/bitbake.conf b/conf/bitbake.conf
>> index f5a5a333a..045cc7dbd 100644
>> --- a/conf/bitbake.conf
>> +++ b/conf/bitbake.conf
>> @@ -44,3 +44,4 @@ TARGET_ARCH =3D "${BUILD_ARCH}"
>>  TMPDIR =3D "${TOPDIR}/tmp"
>>  WORKDIR =3D "${TMPDIR}/work/${PF}"
>>  GITPKGV =3D "${@bb.fetch2.get_srcrev(d, 'gitpkgv_revision')}"
>> +BB_USER_AGENT ??=3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0)
>> Gecko/20100101 Firefox/126.0"
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> index fb4f0a23d..4da558f0c 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> @@ -221,13 +221,21 @@ HTTP/FTP wget fetcher (``http://``, ``ftp://``,
>> ``https://``)
>>  This fetcher obtains files from web and FTP servers. Internally, the
>>  fetcher uses the wget utility.
>>
>> -The executable and parameters used are specified by the
>> -``FETCHCMD_wget`` variable, which defaults to sensible values. The
>> -fetcher supports a parameter "downloadfilename" that allows the name of
>> -the downloaded file to be specified. Specifying the name of the
>> -downloaded file is useful for avoiding collisions in
>> -:term:`DL_DIR` when dealing with multiple files that
>> -have the same name.
>> +The executable and parameters used are specified by the ``FETCHCMD_wget=
``
>> +variable, which defaults to sensible values. The fetcher supports
>> +parameters:
>> +
>> +-  *downloadfilename:* That allows the name of the downloaded file
>> +   to be specified.
>> +
>> +-  *user_agent:* Enable to use a default ``Mozilla/5.0`` user-agent
>> +   which is defined in :term:`BB_USER_AGENT`.
>> +
>> +Specifying the name of the downloaded file is useful for avoiding
>> +collisions in :term:`DL_DIR` when dealing with multiple files
>> +that have the same name. A few HTTP servers block requests with
>> +the default wget user-agent, in this case specifying a valid
>> +user-agent can solve this issue.
>>
>>  If a username and password are specified in the ``SRC_URI``, a Basic
>>  Authorization header will be added to each request, including across
>> redirects.
>> @@ -239,6 +247,7 @@ Some example URLs are as follows::
>>     SRC_URI =3D "http://oe.handhelds.org/not_there.aac"
>>     SRC_URI =3D "ftp://oe.handhelds.org/not_there_as_well.aac"
>>     SRC_URI =3D "ftp://you@oe.handhelds.org/home/you/secret.plan"
>> +   SRC_URI =3D "https://oe.handhelds.org/not_there.aac;user_agent=3D1"
>>
>>  .. note::
>>
>> diff --git
>> a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index 899e584f9..1132d44b9 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -699,6 +699,11 @@ overview of their function and contents.
>>        Within an executing task, this variable holds the hash of the tas=
k
>> as
>>        returned by the currently enabled signature generator.
>>
>> +   :term:`BB_USER_AGENT`
>> +      Specifies a user-agent string which BitBake uses if "user_agent"
>> +      parameter is enabled for HTTP/FTP wget fetcher. Default value can
>> +      be found in conf\bitbake.conf.
>> +
>>     :term:`BB_VERBOSE_LOGS`
>>        Controls how verbose BitBake is during builds. If set, shell
>> scripts
>>        echo commands and shell script output appears on standard out
>> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
>> index 2e9211763..098cac52b 100644
>> --- a/lib/bb/fetch2/wget.py
>> +++ b/lib/bb/fetch2/wget.py
>> @@ -52,11 +52,8 @@ class
>> WgetProgressHandler(bb.progress.LineFilterProgressHandler):
>>
>>  class Wget(FetchMethod):
>>      """Class to fetch urls via 'wget'"""
>> -
>> -    # CDNs like CloudFlare may do a 'browser integrity test' which can
>> fail
>> -    # with the standard wget/urllib User-Agent, so pretend to be a mode=
rn
>> -    # browser.
>> -    user_agent =3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0)
>> Gecko/20100101 Firefox/84.0"
>> +    def init(self, d):
>> +        self.user_agent =3D d.getVar("BB_USER_AGENT")
>>
>>      def check_certs(self, d):
>>          """
>> @@ -89,6 +86,10 @@ class Wget(FetchMethod):
>>
>>          self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wge=
t
>> -t 2 -T 30"
>>
>> +        is_user_agent_enabled =3D ud.parm.get("user_agent","0") =3D=3D =
"1"
>> +        if is_user_agent_enabled:
>> +            self.basecmd +=3D f" --user-agent=3D'{self.user_agent}'"
>> +
>>          if ud.type =3D=3D 'ftp' or ud.type =3D=3D 'ftps':
>>              self.basecmd +=3D " --passive-ftp"
>>
>> --
>> 2.45.2.windows.1
>>
>>
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16336):
> https://lists.openembedded.org/g/bitbake-devel/message/16336
> Mute This Topic: https://lists.openembedded.org/mt/106583049/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000083dbbd061a81a82e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">On second thought, you did mention that FETCHCMD_whet can=
 be used to set a custom user agent in one of the tickets, so if this can b=
e done per recipe there is no need to add a new variable.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Ale=C2=A0</div><div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon 10. Jun 2024 at 6.24=
, Alexander Kanavin via <a href=3D"http://lists.openembedded.org">lists.ope=
nembedded.org</a> &lt;alex.kanavin=3D<a href=3D"mailto:gmail.com@lists.open=
embedded.org">gmail.com@lists.openembedded.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(2=
04,204,204)"><div><div dir=3D"auto">No. I really do not like the idea that =
we should pretend to be Firefox. And you didn=E2=80=99t answer Ross questio=
ns properly.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Fix the ser=
vers please.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><=
/div><div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon 10.=
 Jun 2024 at 0.02, Livius via <a href=3D"http://lists.openembedded.org" tar=
get=3D"_blank">lists.openembedded.org</a> &lt;egyszeregy=3D<a href=3D"mailt=
o:freemail.hu@lists.openembedded.org" target=3D"_blank">freemail.hu@lists.o=
penembedded.org</a>&gt; wrote:<br></div></div></div></div><div><div><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex=
;border-left-color:rgb(204,204,204)">From: Benjamin Sz=C5=91ke &lt;<a href=
=3D"mailto:egyszeregy@freemail.hu" target=3D"_blank">egyszeregy@freemail.hu=
</a>&gt;<br>
<br>
Add &quot;user_agent&quot; optional parameter for wget fetcher to able<br>
to use it if HTTP servers block requests with the default wget<br>
user agent.<br>
<br>
Signed-off-by: Benjamin Sz=C5=91ke &lt;<a href=3D"mailto:egyszeregy@freemai=
l.hu" target=3D"_blank">egyszeregy@freemail.hu</a>&gt;<br>
---<br>
=C2=A0conf/bitbake.conf=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0.../bitbake-user-manual-fetching.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 23 +++++++++++++------<br>
=C2=A0.../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
5 ++++<br>
=C2=A0lib/bb/fetch2/wget.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++++----<br>
=C2=A04 files changed, 28 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/conf/bitbake.conf b/conf/bitbake.conf<br>
index f5a5a333a..045cc7dbd 100644<br>
--- a/conf/bitbake.conf<br>
+++ b/conf/bitbake.conf<br>
@@ -44,3 +44,4 @@ TARGET_ARCH =3D &quot;${BUILD_ARCH}&quot;<br>
=C2=A0TMPDIR =3D &quot;${TOPDIR}/tmp&quot;<br>
=C2=A0WORKDIR =3D &quot;${TMPDIR}/work/${PF}&quot;<br>
=C2=A0GITPKGV =3D &quot;${@bb.fetch2.get_srcrev(d, &#39;gitpkgv_revision&#3=
9;)}&quot;<br>
+BB_USER_AGENT ??=3D &quot;Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0=
) Gecko/20100101 Firefox/126.0&quot;<br>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-fetching.rst<br>
index fb4f0a23d..4da558f0c 100644<br>
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst<br>
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst<br>
@@ -221,13 +221,21 @@ HTTP/FTP wget fetcher (``http://``, ``ftp://``, ``htt=
ps://``)<br>
=C2=A0This fetcher obtains files from web and FTP servers. Internally, the<=
br>
=C2=A0fetcher uses the wget utility.<br>
<br>
-The executable and parameters used are specified by the<br>
-``FETCHCMD_wget`` variable, which defaults to sensible values. The<br>
-fetcher supports a parameter &quot;downloadfilename&quot; that allows the =
name of<br>
-the downloaded file to be specified. Specifying the name of the<br>
-downloaded file is useful for avoiding collisions in<br>
-:term:`DL_DIR` when dealing with multiple files that<br>
-have the same name.<br>
+The executable and parameters used are specified by the ``FETCHCMD_wget``<=
br>
+variable, which defaults to sensible values. The fetcher supports<br>
+parameters:<br>
+<br>
+-=C2=A0 *downloadfilename:* That allows the name of the downloaded file<br=
>
+=C2=A0 =C2=A0to be specified.<br>
+<br>
+-=C2=A0 *user_agent:* Enable to use a default ``Mozilla/5.0`` user-agent<b=
r>
+=C2=A0 =C2=A0which is defined in :term:`BB_USER_AGENT`.<br>
+<br>
+Specifying the name of the downloaded file is useful for avoiding<br>
+collisions in :term:`DL_DIR` when dealing with multiple files<br>
+that have the same name. A few HTTP servers block requests with<br>
+the default wget user-agent, in this case specifying a valid<br>
+user-agent can solve this issue.<br>
<br>
=C2=A0If a username and password are specified in the ``SRC_URI``, a Basic<=
br>
=C2=A0Authorization header will be added to each request, including across =
redirects.<br>
@@ -239,6 +247,7 @@ Some example URLs are as follows::<br>
=C2=A0 =C2=A0 SRC_URI =3D &quot;<a href=3D"http://oe.handhelds.org/not_ther=
e.aac" rel=3D"noreferrer" target=3D"_blank">http://oe.handhelds.org/not_the=
re.aac</a>&quot;<br>
=C2=A0 =C2=A0 SRC_URI =3D &quot;<a href=3D"ftp://oe.handhelds.org/not_there=
_as_well.aac" rel=3D"noreferrer" target=3D"_blank">ftp://oe.handhelds.org/n=
ot_there_as_well.aac</a>&quot;<br>
=C2=A0 =C2=A0 SRC_URI =3D &quot;<a href=3D"ftp://you@oe.handhelds.org/home/=
you/secret.plan" rel=3D"noreferrer" target=3D"_blank">ftp://you@oe.handheld=
s.org/home/you/secret.plan</a>&quot;<br>
+=C2=A0 =C2=A0SRC_URI =3D &quot;<a href=3D"https://oe.handhelds.org/not_the=
re.aac;user_agent=3D1" rel=3D"noreferrer" target=3D"_blank">https://oe.hand=
helds.org/not_there.aac;user_agent=3D1</a>&quot;<br>
<br>
=C2=A0.. note::<br>
<br>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
index 899e584f9..1132d44b9 100644<br>
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
@@ -699,6 +699,11 @@ overview of their function and contents.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Within an executing task, this variable holds th=
e hash of the task as<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0returned by the currently enabled signature gene=
rator.<br>
<br>
+=C2=A0 =C2=A0:term:`BB_USER_AGENT`<br>
+=C2=A0 =C2=A0 =C2=A0 Specifies a user-agent string which BitBake uses if &=
quot;user_agent&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 parameter is enabled for HTTP/FTP wget fetcher. Defau=
lt value can<br>
+=C2=A0 =C2=A0 =C2=A0 be found in conf\bitbake.conf.<br>
+<br>
=C2=A0 =C2=A0 :term:`BB_VERBOSE_LOGS`<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Controls how verbose BitBake is during builds. I=
f set, shell scripts<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0echo commands and shell script output appears on=
 standard out<br>
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py<br>
index 2e9211763..098cac52b 100644<br>
--- a/lib/bb/fetch2/wget.py<br>
+++ b/lib/bb/fetch2/wget.py<br>
@@ -52,11 +52,8 @@ class WgetProgressHandler(bb.progress.LineFilterProgress=
Handler):<br>
<br>
=C2=A0class Wget(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Class to fetch urls via &#39;wget&#39=
;&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 # CDNs like CloudFlare may do a &#39;browser integrity test&=
#39; which can fail<br>
-=C2=A0 =C2=A0 # with the standard wget/urllib User-Agent, so pretend to be=
 a modern<br>
-=C2=A0 =C2=A0 # browser.<br>
-=C2=A0 =C2=A0 user_agent =3D &quot;Mozilla/5.0 (X11; Ubuntu; Linux x86_64;=
 rv:84.0) Gecko/20100101 Firefox/84.0&quot;<br>
+=C2=A0 =C2=A0 def init(self, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.user_agent =3D d.getVar(&quot;BB_USER_AGE=
NT&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def check_certs(self, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -89,6 +86,10 @@ class Wget(FetchMethod):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.basecmd =3D d.getVar(&quot;FETCHCMD_=
wget&quot;) or &quot;/usr/bin/env wget -t 2 -T 30&quot;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_user_agent_enabled =3D ud.parm.get(&quot;us=
er_agent&quot;,&quot;0&quot;) =3D=3D &quot;1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if is_user_agent_enabled:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.basecmd +=3D f&quot; --user=
-agent=3D&#39;{self.user_agent}&#39;&quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.type =3D=3D &#39;ftp&#39; or ud.typ=
e =3D=3D &#39;ftps&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.basecmd +=3D &quot; --=
passive-ftp&quot;<br>
<br>
-- <br>
2.45.2.windows.1<br>
<br>
<br>
<br>
<br>
</blockquote></div></div></div><div><div><div class=3D"gmail_quote"></div><=
/div>
</div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16336): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16336" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16336</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/106583049/168=
6489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/106583049/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--00000000000083dbbd061a81a82e--

