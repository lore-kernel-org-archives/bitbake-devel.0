Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 6CEC37F6CF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2019 14:32:07 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id a15so18734022wrf.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2019 06:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=resent-from:resent-date:resent-message-id:resent-to:mime-version
	:date:references:in-reply-to:message-id:subject:from:to;
	bh=6wVUPwoDnyg7YhidKuPQoy+s6iY3Bglkvx4VVgWD8bg=;
	b=vHDMzb4CKqOh2uCbWlhioHeJTUCjpEq4PUiu/pc7YVHRnuDqyYxprud4f1qYrrpcYT
	Hai4whT4mMOuBnK+KaEOGyRB89gWdVhVMzMu8pIMW3k4jxvh+lSo1np4LAm872YzPK7A
	xfv9QvfEJNR3eTGnNfI/2VPpzRD5PoJp+7UbML0PRrcDFoxO5AjGI2UEwzrsSw3F1eX1
	7flXmMT52baEkBHtivLTcAvjrgQbyjjRPiKm631XZhZ1Jpd4OJKLEewCGSf3Vj00512b
	iztOLeZBLB1Km0Z9cISU/SH9qWMtNryxwz9TBFfkirH1/L+nQ8wYre1TY61hHtRQey7K
	kRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:resent-from:resent-date:resent-message-id
	:resent-to:mime-version:date:references:in-reply-to:message-id
	:subject:from:to;
	bh=6wVUPwoDnyg7YhidKuPQoy+s6iY3Bglkvx4VVgWD8bg=;
	b=icJjLm75aUeVS8yYqmopfROxft4jcmXl93Um/YQaXYHi5ZjRnMBonFA87YOilE55jk
	DUxfmftufdniErCGvsfVPWKZCX34xOAzCNXoRMHIMaJJ2obegxZz6bTP0fsvmYJfxcpo
	suzm5izmRA/0cpjddpqoQfb6Fd1P1vOiI7KtSsUEUKpra/BOPhsD+qarYkBllqOMOdLM
	hEfV5B06MmfGCvbkVKoZ46bKChXTGrMO+2iZgcPQsM3EboEqsVB7B+IvUrd9Wb9PsRPo
	jyIf65W1RZIr4rHx9qIW3ZjTpLKsLMan5VhrQr3h4MVl/rsTOKdHTQVTRQ1jrR/uTNFH
	Qu6Q==
X-Gm-Message-State: APjAAAVaYGooxjS+jBvtLBnMmsU0ZmE4jONhw43nxz8+8jjGMRpAPcWE
	R0RCvc17UKjiRqKwgEBqjOlD5qNS
X-Google-Smtp-Source: APXvYqwFm7fK17KfPNysMCTLT7Z4GxaAuoWFtlPvZLE01excMAONYYfXnIb4t9EU2yV5JWN6M7NEaQ==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr24564016wre.332.1573569127551;
	Tue, 12 Nov 2019 06:32:07 -0800 (PST)
Received: from localhost ([109.238.218.228])
	by smtp.gmail.com with ESMTPSA id x8sm2887096wmi.10.2019.11.12.06.32.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 12 Nov 2019 06:32:07 -0800 (PST)
Resent-From: Martin Jansa <Martin.Jansa@gmail.com>
Resent-Date: Tue, 12 Nov 2019 15:32:06 +0100
Resent-Message-ID: <20191112143206.luz5sv3g6sm6re7v@jama>
Resent-To: bitbake-devel@lists.openembedded.org
MIME-Version: 1.0
Date: Tue, 12 Nov 2019 15:14:01 +0100
References: <6f692d96-9b78-b317-d033-09d1f140da62@linux.intel.com>
	<CA+chaQcOse_xmbyi0q=WXB1JQxV6AgGJtvrFZ_Wtmi-N2z0g6A@mail.gmail.com>
	<956a3bfb-732c-bb87-0aa7-f9b2c5b4369d@linux.intel.com>
In-Reply-To: <956a3bfb-732c-bb87-0aa7-f9b2c5b4369d@linux.intel.com>
Message-ID: <CA+chaQd1CfJ35pDsvyA8aNL17HtpzXduSRgFzHOgEcjVcX+fEw@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
To: =?UTF-8?Q?Adrian_Ambro=C5=BCewicz?= <adrian.ambrozewicz@linux.intel.com>
X-TUID: h1W6YOjfR7mg
Subject: Re: Patch idea - fetcher for gerrit patches
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
X-List-Received-Date: Tue, 12 Nov 2019 14:32:08 -0000
Content-Type: multipart/alternative; boundary="000000000000360544059726dc0a"

--000000000000360544059726dc0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

it looks the same as any other recipe fetching from normal git repository
(not managed by gerrit), e.g.:

SRC_URI =3D "git://gerrit/projectA;name=3DA \
    git://gerrit/projectB;name=3DB \
"
SRCREV_FORMAT =3D "A_B"
SRCREV_A =3D "refs/changes/61/252561/44"
SRCREV_B =3D "refs/changes/62/252562/1"

In regular case SRCREV_A and SRCREV_B will be set to some git SHA, but to
build from some open reviews we just set the refs/changes/*/*/* in the
SRCREV variables (without changing SRC_URI except adding ;nobranch=3D1 whic=
h
is added through another variable - our exact case is a bit more
complicated, see:
https://github.com/webosose/meta-webosose/blob/master/meta-webos/conf/distr=
o/include/webos-repositories.inc
 )
recipes then use e.g. WEBOSOSE_GIT_REPO_COMPLETE variable (there are more
variables like this in internal builds for different gerrit servers and
projects there), so the CI can just set WEBOS_GIT_BRANCH =3D ";nobranch=3D"=
.

In regular builds this triggers QA error to prevent anyone merging change
like this by accident, because all our regular builds fetch from annotated
tags (the SRCREV is set to matching SHA and bbclass checks that the SHA is
matching with the corresponding submissions/N where N is part of the
component version), that's implemented as do_fetch[prefuncs] here:
https://github.com/webosose/meta-webosose/blob/master/meta-webos/classes/we=
bos_enhanced_submissions.bbclass

Most our recipes use just one repository, so 99,9% cases is even simpler
than this.

Regards,

On Tue, Nov 12, 2019 at 3:01 PM Adrian Ambro=C5=BCewicz <
adrian.ambrozewicz@linux.intel.com> wrote:

>
>
> W dniu 11/8/2019 o 15:58, Martin Jansa pisze:
> > Do we actually need separate fetcher for gerrit?
> >
> > We're using gerrit for everything @LGE and to fetch from open reviews
> > instead of merged commits I'm just setting the gerrit reference in
> > SRCREV (e.g. refs/changes/61/252561/44) and normal git fetcher does the
> > right think and fetches it correctly.
> >
> > Advantage of using the same fetcher is to easily switch between tag/git
> > ref/gerrit ref just by small SRC_URI modification instead of replacing
> > whole repository (starting from fetcher change from git:// to gerrit://=
).
> >
> That is very good suggestion and should work in simplest cases. How does
> SRC_URI and SRCREV look in your case?
>
> I see some limitations of that solution, but correct me if I'm wrong as
> my experience with bitbake is quite limited.. how about multiple
> patchse? How SRC_URI and SRCREV would look like then?
>
> > Adding optional parameter for git:// fetcher to make it easier to
> > specify which review to pull seems easier to use and less error prone
> > (as you probably never want to use e.g. review from glib gerrit project
> > in dbus recipe, so always including the project name and showing error
> > when the referenced review in change parameter doesn't point to the
> > right project is IMHO better then fetching something completely
> different).
> >
> > For topic parameter I don't understand how would you fetch the reviews
> > if there are more then one with the same topic? Would you fetch multipl=
e
> > repositories in some automatically generated destdir directories? Or
> > fetch just the patches and apply them on top of some other SRC_URI entr=
y?
> The latter. Our use case is contribution to many existing subrepos. We
> have a bunch of reviews to manage which combined on top of existing
> recipe builds our features. Gerrit fetcher in our case is aimed to
> address applying many patches of ongoing reviews until they are integrate=
d.
> >
> > Regards,
> >
> > On Fri, Nov 8, 2019 at 3:08 PM Adrian Ambro=C5=BCewicz
> > <adrian.ambrozewicz@linux.intel.com
> > <mailto:adrian.ambrozewicz@linux.intel.com>> wrote:
> >
> >     Hello,
> >
> >     As it is my first message here allow me to introduce myself. I'm
> Adrian
> >     Ambro=C5=BCewicz and I work at Intel Technology Poland. I love flex=
ibility
> >     and features of Bitbake and I would like to propose new feature whi=
ch
> >     will solve our problem.
> >
> >     I would like to propose extension to already supported fetcher
> >     library -
> >     gerrit. Idea is to be able to apply gerrit patches by simply
> >     specifying:
> >     "SRC_URI +=3D gerrit://[gerrit_server];change=3D[change_id]". Fetch=
er
> would
> >     then take care of downloading most recent patchset from given revie=
w.
> >     Further extensiosn of that fetcher could include ability to specify=
:
> >     - revision (get given revision instead of top)
> >     - topic (get all patches from given topic)
> >     - project (to be used in conjunction with 'topic' parameter)
> >     etc...
> >
> >     I've prepared minimal PoC implementation without any error handling=
.
> It
> >     works just fine and is basing on wget command. Gerrit REST API is
> used
> >     to obtain base64-encoded patch which is then decoded to file with
> name
> >     [change_id].patch . I'm very interested in polishing that and
> >     upstreaming it for everyone to use.
> >
> >     The question I have for you is the following: does this fetcher hav=
e
> a
> >     chance to be accepted upstream?
> >
> >     Regards,
> >     Adrian
> >     --
> >     _______________________________________________
> >     bitbake-devel mailing list
> >     bitbake-devel@lists.openembedded.org
> >     <mailto:bitbake-devel@lists.openembedded.org>
> >     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> >
>

--000000000000360544059726dc0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>=C2=A0</div><div>it looks the same as a=
ny other recipe fetching from normal git repository (not managed by gerrit)=
, e.g.:</div><div><br></div>SRC_URI =3D &quot;git://gerrit/projectA;name=3D=
A \<div>=C2=A0 =C2=A0 git://gerrit/projectB;name=3DB \</div><div>&quot;</di=
v><div>SRCREV_FORMAT =3D &quot;A_B&quot;</div><div>SRCREV_A =3D &quot;refs/=
changes/61/252561/44&quot;</div><div>SRCREV_B =3D &quot;refs/changes/62/252=
562/1&quot;<br></div><div><br></div><div>In regular case SRCREV_A and SRCRE=
V_B will be set to some git SHA, but to build from some open reviews we jus=
t set the refs/changes/*/*/* in the SRCREV variables (without changing SRC_=
URI except adding ;nobranch=3D1 which is added through another variable - o=
ur exact case is a bit more complicated, see:</div><div><a href=3D"https://=
github.com/webosose/meta-webosose/blob/master/meta-webos/conf/distro/includ=
e/webos-repositories.inc">https://github.com/webosose/meta-webosose/blob/ma=
ster/meta-webos/conf/distro/include/webos-repositories.inc</a>=C2=A0)<br></=
div><div>recipes then use e.g.=C2=A0WEBOSOSE_GIT_REPO_COMPLETE variable (th=
ere are more variables like this in internal builds=C2=A0for different gerr=
it servers and projects there), so the CI can just set=C2=A0WEBOS_GIT_BRANC=
H =3D &quot;;nobranch=3D&quot;.</div><div><br></div><div></div><div>In regu=
lar builds this triggers QA error to prevent anyone merging change like thi=
s by accident, because all our regular builds fetch from annotated tags (th=
e SRCREV is set to matching SHA and bbclass checks that the SHA is matching=
 with the corresponding submissions/N where N is part of the component vers=
ion), that&#39;s implemented as=C2=A0do_fetch[prefuncs] here:<br></div><div=
><a href=3D"https://github.com/webosose/meta-webosose/blob/master/meta-webo=
s/classes/webos_enhanced_submissions.bbclass">https://github.com/webosose/m=
eta-webosose/blob/master/meta-webos/classes/webos_enhanced_submissions.bbcl=
ass</a><br></div><div><br></div><div>Most our recipes use just one reposito=
ry, so 99,9% cases is even simpler than this.<br></div><div><br></div><div>=
Regards,</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Nov 12, 2019 at 3:01 PM Adrian Ambro=C5=BCewicz &lt=
;<a href=3D"mailto:adrian.ambrozewicz@linux.intel.com">adrian.ambrozewicz@l=
inux.intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><br>
<br>
W dniu 11/8/2019 o=C2=A015:58, Martin Jansa pisze:<br>
&gt; Do we actually need separate fetcher for gerrit?<br>
&gt; <br>
&gt; We&#39;re using gerrit for everything=C2=A0@LGE and to fetch from open=
 reviews <br>
&gt; instead of merged commits I&#39;m just setting the gerrit reference in=
 <br>
&gt; SRCREV (e.g.=C2=A0refs/changes/61/252561/44) and normal git fetcher do=
es the <br>
&gt; right think and fetches it correctly.<br>
&gt; <br>
&gt; Advantage of using the same fetcher is to easily switch between tag/gi=
t <br>
&gt; ref/gerrit ref just by small SRC_URI modification instead of replacing=
 <br>
&gt; whole repository (starting from fetcher change from git:// to gerrit:/=
/).<br>
&gt;<br>
That is very good suggestion and should work in simplest cases. How does <b=
r>
SRC_URI and SRCREV look in your case?<br>
<br>
I see some limitations of that solution, but correct me if I&#39;m wrong as=
 <br>
my experience with bitbake is quite limited.. how about multiple <br>
patchse? How SRC_URI and SRCREV would look like then?<br>
<br>
&gt; Adding optional parameter for git:// fetcher to make it easier to <br>
&gt; specify which review to pull seems easier to use and less error prone =
<br>
&gt; (as you probably never want to use e.g. review from glib gerrit projec=
t <br>
&gt; in dbus recipe, so always including the project name and showing error=
 <br>
&gt; when the referenced review in change parameter doesn&#39;t point to th=
e <br>
&gt; right project is IMHO better then fetching something completely differ=
ent).<br>
&gt; <br>
&gt; For topic parameter I don&#39;t understand how would you fetch the rev=
iews <br>
&gt; if there are more then one with the same topic? Would you fetch multip=
le <br>
&gt; repositories in some automatically generated destdir directories? Or <=
br>
&gt; fetch just the patches and apply them on top of some other SRC_URI ent=
ry?<br>
The latter. Our use case is contribution to many existing subrepos. We <br>
have a bunch of reviews to manage which combined on top of existing <br>
recipe builds our features. Gerrit fetcher in our case is aimed to <br>
address applying many patches of ongoing reviews until they are integrated.=
<br>
&gt; <br>
&gt; Regards,<br>
&gt; <br>
&gt; On Fri, Nov 8, 2019 at 3:08 PM Adrian Ambro=C5=BCewicz <br>
&gt; &lt;<a href=3D"mailto:adrian.ambrozewicz@linux.intel.com" target=3D"_b=
lank">adrian.ambrozewicz@linux.intel.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:adrian.ambrozewicz@linux.intel.com" targe=
t=3D"_blank">adrian.ambrozewicz@linux.intel.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hello,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0As it is my first message here allow me to introduc=
e myself. I&#39;m Adrian<br>
&gt;=C2=A0 =C2=A0 =C2=A0Ambro=C5=BCewicz and I work at Intel Technology Pol=
and. I love flexibility<br>
&gt;=C2=A0 =C2=A0 =C2=A0and features of Bitbake and I would like to propose=
 new feature which<br>
&gt;=C2=A0 =C2=A0 =C2=A0will solve our problem.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I would like to propose extension to already suppor=
ted fetcher<br>
&gt;=C2=A0 =C2=A0 =C2=A0library -<br>
&gt;=C2=A0 =C2=A0 =C2=A0gerrit. Idea is to be able to apply gerrit patches =
by simply<br>
&gt;=C2=A0 =C2=A0 =C2=A0specifying:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;SRC_URI +=3D gerrit://[gerrit_server];change=
=3D[change_id]&quot;. Fetcher would<br>
&gt;=C2=A0 =C2=A0 =C2=A0then take care of downloading most recent patchset =
from given review.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Further extensiosn of that fetcher could include ab=
ility to specify:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- revision (get given revision instead of top)<br>
&gt;=C2=A0 =C2=A0 =C2=A0- topic (get all patches from given topic)<br>
&gt;=C2=A0 =C2=A0 =C2=A0- project (to be used in conjunction with &#39;topi=
c&#39; parameter)<br>
&gt;=C2=A0 =C2=A0 =C2=A0etc...<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;ve prepared minimal PoC implementation withou=
t any error handling. It<br>
&gt;=C2=A0 =C2=A0 =C2=A0works just fine and is basing on wget command. Gerr=
it REST API is used<br>
&gt;=C2=A0 =C2=A0 =C2=A0to obtain base64-encoded patch which is then decode=
d to file with name<br>
&gt;=C2=A0 =C2=A0 =C2=A0[change_id].patch . I&#39;m very interested in poli=
shing that and<br>
&gt;=C2=A0 =C2=A0 =C2=A0upstreaming it for everyone to use.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The question I have for you is the following: does =
this fetcher have a<br>
&gt;=C2=A0 =C2=A0 =C2=A0chance to be accepted upstream?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Adrian<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0_______________________________________________<br>
&gt;=C2=A0 =C2=A0 =C2=A0bitbake-devel mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:bitbake-devel@lists.openembedded.=
org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:bitbake-devel@lists.op=
enembedded.org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a>&=
gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel" rel=3D"noreferrer" target=3D"_blank">http://lists.ope=
nembedded.org/mailman/listinfo/bitbake-devel</a><br>
&gt; <br>
</blockquote></div>

--000000000000360544059726dc0a--
