Return-Path: <alex.kanavin@gmail.com>
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com
	[209.85.217.68])
	by mail.openembedded.org (Postfix) with ESMTP id E21F77D40E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2019 15:06:14 +0000 (UTC)
Received: by mail-vs1-f68.google.com with SMTP id r3so36267177vsr.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2019 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=KUjY7KmxYLmNfJDCglR5S2SL1Dn7qLPRwVdG/obDQWM=;
	b=ViwXiaGTCnTB2urB3a3nOD3U8B1MOBMYmxfTTB0ODQgQ5KXdOc3hwwri5ehXh0WG83
	r5nZJ2tp7FEvEfTJ9gVa0LU3gi5UjWX7RcZZIn8TxvdpALDj5lfwIjHP9uwzsAABHyI2
	brfOqr6MlW0W87B01W67/eV0sShu71rGCcPBVIcv0YAG1ulv30y1UhpBssQ591OaS9OW
	6jB4veXCZ9+1VDepXEg8N+3MJOD46AeiGCpIfT4C9iyGz8CPvorxA4kU3CWbCHybAkw/
	2J8VeD7al1Jx0X6o3AlHllw7iWd7jYuJe3r7POtvyqPmhcwVK/Q9oN15l4ORSTmhTQ1X
	QfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=KUjY7KmxYLmNfJDCglR5S2SL1Dn7qLPRwVdG/obDQWM=;
	b=tOKP3xFIlwAcGfTjECiOCMjXBi+BGN7KwWzTmtdhdcw70C3QHDA3kmPah/6Aa5Bs3z
	pio1wvTANba7LuUAEvOZDmh27uONshfZNtCl5TkINxAm3CQtY4I0BFduodZnlaGqitAv
	Ntwn7PARkbc7sUTNd9ObiQ6SksaaitNwjsf9rw2GJm6zFMc7Hceb1toTAXGgm77HvJ94
	tO88HFoIEKYCWXAp9oCjTs2gJaTUUqXqTmIUZZODHHIUFvXfzs4Y8spodBfNPJBJoZkb
	IJoCeaCE/M1B01tUP8wRvHq9wnMVFQ8aTLhCR+KL1gna3QIHrYj+Ng1v056JqTsQIGXD
	sR7A==
X-Gm-Message-State: APjAAAVbFRNTQXuEgQOLeyuNjaiJhCW9Lin2SCYll8Rib2KZaVehG2eJ
	RzwQtVZi8Djx8swsK/fFnwgWkJ7yALcd6v6+2Lnp2wiQ
X-Google-Smtp-Source: APXvYqwpc87lWUarB6+0AwqAjM1eASeH++t8nPTgkS8VchRL3zNvq65ZWB8pFEVOz3pgZBdfVTCfQC0do2iokRIg+T4=
X-Received: by 2002:a67:fd13:: with SMTP id f19mr59742855vsr.25.1564153575819; 
	Fri, 26 Jul 2019 08:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <1564149248-7626-1-git-send-email-chris.laplante@agilent.com>
In-Reply-To: <1564149248-7626-1-git-send-email-chris.laplante@agilent.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 26 Jul 2019 18:06:02 +0300
Message-ID: <CANNYZj_ykVaOvq4EKtJ=7qpTNt5HcdpYqE+z4dRpqNQH-6ykYA@mail.gmail.com>
To: Chris Laplante <chris.laplante@agilent.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: add ability to skip recipes when get_srcrev fails via BB_FETCH_SKIP_ON_SRCREV_ERROR
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
X-List-Received-Date: Fri, 26 Jul 2019 15:06:16 -0000
Content-Type: multipart/alternative; boundary="00000000000042ced7058e96e2be"

--00000000000042ced7058e96e2be
Content-Type: text/plain; charset="UTF-8"

I think it's better to rearrange the layer itself, and split it into a
privileged and a non-privileged one.

This patch seems to enable skipping the recipe, regardless of what the
actual issue with fetching was (which may or may not be 'access denied').
Skipping on any error doesn't seem right to me as it may mask other types
of problems.

Alex

On Fri, 26 Jul 2019 at 16:55, Chris Laplante via bitbake-devel <
bitbake-devel@lists.openembedded.org> wrote:

> Sometimes it is desirable to just skip a recipe if the upstream(s) can't be
> accessed by the user, rather than fail the whole build outright.
>
> For example, in a corporate environment, sometimes certain git repositories
> are access controlled. If privileged and non-privileged users share
> the same Yocto layers, it would be nice for the non-privileged users to
> be able to build the recipes they need, without tripping over parse
> failures on the non-accessible recipes.
>
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  lib/bb/fetch2/__init__.py | 99
> +++++++++++++++++++++++++----------------------
>  1 file changed, 52 insertions(+), 47 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index f6b5529..a165a77 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -741,55 +741,60 @@ def get_srcrev(d, method_name='sortable_revision'):
>      that fetcher provides a method with the given name and the same
> signature as sortable_revision.
>      """
>
> -    scms = []
> -    fetcher = Fetch(d.getVar('SRC_URI').split(), d)
> -    urldata = fetcher.ud
> -    for u in urldata:
> -        if urldata[u].method.supports_srcrev():
> -            scms.append(u)
> -
> -    if len(scms) == 0:
> -        raise FetchError("SRCREV was used yet no valid SCM was found in
> SRC_URI")
> -
> -    if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
> -        autoinc, rev = getattr(urldata[scms[0]].method,
> method_name)(urldata[scms[0]], d, urldata[scms[0]].names[0])
> -        if len(rev) > 10:
> -            rev = rev[:10]
> -        if autoinc:
> -            return "AUTOINC+" + rev
> -        return rev
> -
> -    #
> -    # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
> -    #
> -    format = d.getVar('SRCREV_FORMAT')
> -    if not format:
> -        raise FetchError("The SRCREV_FORMAT variable must be set when
> multiple SCMs are used.\n"\
> -                         "The SCMs are:\n%s" % '\n'.join(scms))
> -
> -    name_to_rev = {}
> -    seenautoinc = False
> -    for scm in scms:
> -        ud = urldata[scm]
> -        for name in ud.names:
> -            autoinc, rev = getattr(ud.method, method_name)(ud, d, name)
> -            seenautoinc = seenautoinc or autoinc
> +    try:
> +        scms = []
> +        fetcher = Fetch(d.getVar('SRC_URI').split(), d)
> +        urldata = fetcher.ud
> +        for u in urldata:
> +            if urldata[u].method.supports_srcrev():
> +                scms.append(u)
> +
> +        if len(scms) == 0:
> +            raise FetchError("SRCREV was used yet no valid SCM was found
> in SRC_URI")
> +
> +        if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
> +            autoinc, rev = getattr(urldata[scms[0]].method,
> method_name)(urldata[scms[0]], d, urldata[scms[0]].names[0])
>              if len(rev) > 10:
>                  rev = rev[:10]
> -            name_to_rev[name] = rev
> -    # Replace names by revisions in the SRCREV_FORMAT string. The
> approach used
> -    # here can handle names being prefixes of other names and names
> appearing
> -    # as substrings in revisions (in which case the name should not be
> -    # expanded). The '|' regular expression operator tries matches from
> left to
> -    # right, so we need to sort the names with the longest ones first.
> -    names_descending_len = sorted(name_to_rev, key=len, reverse=True)
> -    name_to_rev_re = "|".join(re.escape(name) for name in
> names_descending_len)
> -    format = re.sub(name_to_rev_re, lambda match:
> name_to_rev[match.group(0)], format)
> -
> -    if seenautoinc:
> -        format = "AUTOINC+" + format
> -
> -    return format
> +            if autoinc:
> +                return "AUTOINC+" + rev
> +            return rev
> +
> +        #
> +        # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
> +        #
> +        format = d.getVar('SRCREV_FORMAT')
> +        if not format:
> +            raise FetchError("The SRCREV_FORMAT variable must be set when
> multiple SCMs are used.\n"\
> +                             "The SCMs are:\n%s" % '\n'.join(scms))
> +
> +        name_to_rev = {}
> +        seenautoinc = False
> +        for scm in scms:
> +            ud = urldata[scm]
> +            for name in ud.names:
> +                autoinc, rev = getattr(ud.method, method_name)(ud, d,
> name)
> +                seenautoinc = seenautoinc or autoinc
> +                if len(rev) > 10:
> +                    rev = rev[:10]
> +                name_to_rev[name] = rev
> +        # Replace names by revisions in the SRCREV_FORMAT string. The
> approach used
> +        # here can handle names being prefixes of other names and names
> appearing
> +        # as substrings in revisions (in which case the name should not be
> +        # expanded). The '|' regular expression operator tries matches
> from left to
> +        # right, so we need to sort the names with the longest ones first.
> +        names_descending_len = sorted(name_to_rev, key=len, reverse=True)
> +        name_to_rev_re = "|".join(re.escape(name) for name in
> names_descending_len)
> +        format = re.sub(name_to_rev_re, lambda match:
> name_to_rev[match.group(0)], format)
> +
> +        if seenautoinc:
> +            format = "AUTOINC+" + format
> +
> +        return format
> +    except FetchError as e:
> +        if d.getVar('BB_WORKERCONTEXT') != '1' and
> bb.utils.to_boolean(d.getVar("BB_FETCH_SKIP_ON_SRCREV_ERROR")):
> +            raise bb.parse.SkipRecipe(e)
> +        raise
>
>  def localpath(url, d):
>      fetcher = bb.fetch2.Fetch([url], d)
> --
> 2.7.4
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--00000000000042ced7058e96e2be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think it&#39;s better to rearrange the layer itself, and=
 split it into a privileged and a non-privileged one.=C2=A0<div><br></div><=
div>This patch seems to enable skipping the recipe, regardless of what the =
actual issue with fetching was (which may or may not be &#39;access denied&=
#39;). Skipping on any error doesn&#39;t seem right to me as it may mask ot=
her types of problems.<br><div><br></div><div>Alex</div></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 26 Ju=
l 2019 at 16:55, Chris Laplante via bitbake-devel &lt;<a href=3D"mailto:bit=
bake-devel@lists.openembedded.org">bitbake-devel@lists.openembedded.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-col=
or:rgb(204,204,204);padding-left:1ex">Sometimes it is desirable to just ski=
p a recipe if the upstream(s) can&#39;t be<br>
accessed by the user, rather than fail the whole build outright.<br>
<br>
For example, in a corporate environment, sometimes certain git repositories=
<br>
are access controlled. If privileged and non-privileged users share<br>
the same Yocto layers, it would be nice for the non-privileged users to<br>
be able to build the recipes they need, without tripping over parse<br>
failures on the non-accessible recipes.<br>
<br>
Signed-off-by: Chris Laplante &lt;<a href=3D"mailto:chris.laplante@agilent.=
com" target=3D"_blank">chris.laplante@agilent.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/__init__.py | 99 +++++++++++++++++++++++++-------------=
---------<br>
=C2=A01 file changed, 52 insertions(+), 47 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index f6b5529..a165a77 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -741,55 +741,60 @@ def get_srcrev(d, method_name=3D&#39;sortable_revisio=
n&#39;):<br>
=C2=A0 =C2=A0 =C2=A0that fetcher provides a method with the given name and =
the same signature as sortable_revision.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 scms =3D []<br>
-=C2=A0 =C2=A0 fetcher =3D Fetch(d.getVar(&#39;SRC_URI&#39;).split(), d)<br=
>
-=C2=A0 =C2=A0 urldata =3D fetcher.ud<br>
-=C2=A0 =C2=A0 for u in urldata:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if urldata[u].method.supports_srcrev():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scms.append(u)<br>
-<br>
-=C2=A0 =C2=A0 if len(scms) =3D=3D 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;SRCREV was used yet no =
valid SCM was found in SRC_URI&quot;)<br>
-<br>
-=C2=A0 =C2=A0 if len(scms) =3D=3D 1 and len(urldata[scms[0]].names) =3D=3D=
 1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 autoinc, rev =3D getattr(urldata[scms[0]].meth=
od, method_name)(urldata[scms[0]], d, urldata[scms[0]].names[0])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(rev) &gt; 10:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rev =3D rev[:10]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if autoinc:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;AUTOINC+&quot; + re=
v<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rev<br>
-<br>
-=C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT<=
br>
-=C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 format =3D d.getVar(&#39;SRCREV_FORMAT&#39;)<br>
-=C2=A0 =C2=A0 if not format:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;The SRCREV_FORMAT varia=
ble must be set when multiple SCMs are used.\n&quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;The SCMs are:\n%s&quot; % &#39;\n&#39;.join(scms))<b=
r>
-<br>
-=C2=A0 =C2=A0 name_to_rev =3D {}<br>
-=C2=A0 =C2=A0 seenautoinc =3D False<br>
-=C2=A0 =C2=A0 for scm in scms:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D urldata[scm]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in ud.names:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoinc, rev =3D getattr(ud.meth=
od, method_name)(ud, d, name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seenautoinc =3D seenautoinc or a=
utoinc<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scms =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D Fetch(d.getVar(&#39;SRC_URI&#39;).=
split(), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 urldata =3D fetcher.ud<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for u in urldata:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if urldata[u].method.supports_sr=
crev():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scms.append(u)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(scms) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;SRCREV wa=
s used yet no valid SCM was found in SRC_URI&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(scms) =3D=3D 1 and len(urldata[scms[0]]=
.names) =3D=3D 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoinc, rev =3D getattr(urldata=
[scms[0]].method, method_name)(urldata[scms[0]], d, urldata[scms[0]].names[=
0])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if len(rev) &gt; 10:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rev =3D rev[:=
10]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name_to_rev[name] =3D rev<br>
-=C2=A0 =C2=A0 # Replace names by revisions in the SRCREV_FORMAT string. Th=
e approach used<br>
-=C2=A0 =C2=A0 # here can handle names being prefixes of other names and na=
mes appearing<br>
-=C2=A0 =C2=A0 # as substrings in revisions (in which case the name should =
not be<br>
-=C2=A0 =C2=A0 # expanded). The &#39;|&#39; regular expression operator tri=
es matches from left to<br>
-=C2=A0 =C2=A0 # right, so we need to sort the names with the longest ones =
first.<br>
-=C2=A0 =C2=A0 names_descending_len =3D sorted(name_to_rev, key=3Dlen, reve=
rse=3DTrue)<br>
-=C2=A0 =C2=A0 name_to_rev_re =3D &quot;|&quot;.join(re.escape(name) for na=
me in names_descending_len)<br>
-=C2=A0 =C2=A0 format =3D re.sub(name_to_rev_re, lambda match: name_to_rev[=
match.group(0)], format)<br>
-<br>
-=C2=A0 =C2=A0 if seenautoinc:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 format =3D &quot;AUTOINC+&quot; + format<br>
-<br>
-=C2=A0 =C2=A0 return format<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if autoinc:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;AUTOI=
NC+&quot; + rev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rev<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Mutiple SCMs are in SRC_URI so we resort to =
SRCREV_FORMAT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 format =3D d.getVar(&#39;SRCREV_FORMAT&#39;)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not format:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;The SRCRE=
V_FORMAT variable must be set when multiple SCMs are used.\n&quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The SCMs are:\n%s&quot; % &#39;\n&#39;=
.join(scms))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name_to_rev =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 seenautoinc =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for scm in scms:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D urldata[scm]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in ud.names:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoinc, rev =3D g=
etattr(ud.method, method_name)(ud, d, name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seenautoinc =3D se=
enautoinc or autoinc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(rev) &gt; 1=
0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rev =
=3D rev[:10]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name_to_rev[name] =
=3D rev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Replace names by revisions in the SRCREV_FOR=
MAT string. The approach used<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # here can handle names being prefixes of othe=
r names and names appearing<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # as substrings in revisions (in which case th=
e name should not be<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # expanded). The &#39;|&#39; regular expressio=
n operator tries matches from left to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # right, so we need to sort the names with the=
 longest ones first.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 names_descending_len =3D sorted(name_to_rev, k=
ey=3Dlen, reverse=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name_to_rev_re =3D &quot;|&quot;.join(re.escap=
e(name) for name in names_descending_len)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 format =3D re.sub(name_to_rev_re, lambda match=
: name_to_rev[match.group(0)], format)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if seenautoinc:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format =3D &quot;AUTOINC+&quot; =
+ format<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return format<br>
+=C2=A0 =C2=A0 except FetchError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.getVar(&#39;BB_WORKERCONTEXT&#39;) !=3D &=
#39;1&#39; and bb.utils.to_boolean(d.getVar(&quot;BB_FETCH_SKIP_ON_SRCREV_E=
RROR&quot;)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise bb.parse.SkipRecipe(e)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise<br>
<br>
=C2=A0def localpath(url, d):<br>
=C2=A0 =C2=A0 =C2=A0fetcher =3D bb.fetch2.Fetch([url], d)<br>
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
</blockquote></div>

--00000000000042ced7058e96e2be--
