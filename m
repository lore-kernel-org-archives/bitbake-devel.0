Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E40C47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 07:50:45 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
 by mx.groups.io with SMTP id smtpd.web10.9431.1706687436812074063
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 23:50:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zhukoff.net header.s=fm3 header.b=q90aumaW;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=O48cYp2r;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.20, mailfrom: pavel@zhukoff.net)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 995F43200906;
	Wed, 31 Jan 2024 02:50:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 31 Jan 2024 02:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706687435; x=1706773835; bh=UBakMUmyeB
	Hdwj/o2miOCDIGWl6dHYmwtQNRo3KxfP4=; b=q90aumaW5WBKOSX14FiHtZ+RiY
	SxhA7DgKx5C2X2aWcwHxhZpV0hxBZu+VfwLGazV9dn6AV/Ghd5wylAAK3m2zNhDe
	869f5+WR7ZUGuClrCm+HgJINC3DFXQNzO8sESdfn6uaGvm2gA8bgCN8iPZczrB1w
	aAVYe0BRZZgpym9WoUMpJRCe+DCmmQJUH8u/O1c1bGO2eku3oLS1Nk62y7YEp2PL
	61GWSy/pdDtQqqDU3S+IzC2E750Jfn9XhgiCcHKQdDEj/Yo0F2gqOZUCaRPRuiRv
	s9Q/AbJ6ZEDQvA1ZStB3Lr+vz8TTYaF7NDR95E4B/D+xwE5lk66jqqg3HSMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706687435; x=1706773835; bh=UBakMUmyeBHdwj/o2miOCDIGWl6d
	HYmwtQNRo3KxfP4=; b=O48cYp2rwDkIYvER00OpOv2QTfQaLIdv6qj3BVTafUjH
	bZZxKOUSmFadMe6iDhiD7/7P8/P0+lwzIP3dKuyPJVdB5RZKL8fGQab+P6kPcPQ4
	ntSiDw72GGHOXndtyan4S/OPWFVYXjTKCGqhlW4jF8zTAUGK46PhGQWCgrBSyIaX
	a4SFn45ierGJKXg3m4io8e3GXCT5ItdEiGsXt3ghdrTW1sdsxNrCYeLb71EPUWgM
	s0HI09HbuLYUa0950tRNpe0946IjXfiQiNGL1NcvLzyh2Shz7KkOoiBbJ7C+oLgk
	S8umTfWw2KlDCu0GvBaRsyTbs44Kt5iWy/hR9DPdCA==
X-ME-Sender: <xms:yvu5ZfloeKWHVtmrDNlGPi_RqN6nB7AiX9T2QlWIvU0inXrp0f8NRg>
    <xme:yvu5ZS2EFp58tGqLzgDpCBJnS9oR5jbsbTsVFVJUPKKWT2F7N9tOxHGHm1AI1kLEv
    tlH_3MuFAX69qFLL8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesrg
    dtreerreertdenucfhrhhomhepfdfrrghvvghlucgkhhhukhhovhdfuceophgrvhgvlhes
    iihhuhhkohhffhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehhfetkedvfedvie
    evtedtheekffejueejiefhudehgeffjeelvdeghedvnecuffhomhgrihhnpehophgvnhgv
    mhgsvgguuggvugdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:yvu5ZVoNM2E8UPicGHpMImlivoSYFlfeYxGSwKXmE6t8fEkt88HqZg>
    <xmx:yvu5ZXn3luC_4pDr531M8_x6Kpx6q3NyxROPyadukBlVdP9QRrKmnA>
    <xmx:yvu5Zd3YbZAC1xwGTmiwDbthgj83FwmUEwDxME_BzYHps_UFAgZf8w>
    <xmx:y_u5Za-7LjnRPBSTWW0eOtgXT-QOarYTdBhi5hNpHIhI_JmA_t1nMg>
Feedback-ID: ib94946c9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 937BEB6008D; Wed, 31 Jan 2024 02:50:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
MIME-Version: 1.0
Message-Id: <bce7631f-04c8-40f0-848d-5a4a4e2fd454@app.fastmail.com>
In-Reply-To: <0b842389-284d-0709-1dd8-ad63e2f8921f@windriver.com>
References: <20240127121536.2849664-2-pavel@zhukoff.net>
 <0b842389-284d-0709-1dd8-ad63e2f8921f@windriver.com>
Date: Wed, 31 Jan 2024 08:50:14 +0100
From: "Pavel Zhukov" <pavel@zhukoff.net>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2/git.py: Fetch mirror into HEAD
Content-Type: multipart/alternative;
 boundary=91c02e43e1c646fb848363c6b148c342
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 07:50:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15814

--91c02e43e1c646fb848363c6b148c342
Content-Type: text/plain

BB_FETCH_PREMIRRORONLY  is not hard requirement here. 
any usage of PREMIRRORS causes failure on second fetch but it's hidden by fetching from upstream iif available n most cases.

-- 
Pavel

On Wed, Jan 31, 2024, at 04:49, Chen Qi via lists.openembedded.org wrote:
> On 1/27/24 20:15, Pavel Zhukov wrote:
> > Fix the issue with using of (pre)mirror in case if clonedir exists but
> > outdated.
> 
> If I understand it right, the error only appears when 
> BB_FETCH_PREMIRRORONLY is set, right?
> 
> If so, could you please update the commit message to include this 
> information?
> 
> Regards,
> 
> Qi
> 
> > Previous version of the code fetched new mirror content into FETCH_HEAD
> > instead of branch which caused refetch from the upstream. Add new remote
> > add fetch from it instead so the ref can be found by "_contains_ref"
> >
> > Fixes [Yocto #15369]
> >
> > Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
> > ---
> >   bitbake/lib/bb/fetch2/git.py | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> > index 0deeb5cee1..b4497911f1 100644
> > --- a/bitbake/lib/bb/fetch2/git.py
> > +++ b/bitbake/lib/bb/fetch2/git.py
> > @@ -375,7 +375,11 @@ class Git(FetchMethod):
> >               else:
> >                   tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
> >                   runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
> > -                fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
> > +                output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
> > +                if 'mirror' in output:
> > +                    runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdir=ud.clonedir)
> > +                runfetchcmd("%s remote add --mirror=fetch mirror %s" % (ud.basecmd, tmpdir), d, workdir=ud.clonedir)
> > +                fetch_cmd = "LANG=C %s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
> >                   runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
> >           repourl = self._get_repo_url(ud)
> >   
> >
> > 
> >
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15813): https://lists.openembedded.org/g/bitbake-devel/message/15813
> Mute This Topic: https://lists.openembedded.org/mt/103994536/6390638
> Group Owner: bitbake-devel+owner@lists.openembedded.org <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [pavel@zhukoff.net]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

--91c02e43e1c646fb848363c6b148c342
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><title></title><style type=3D"text/css">p.Mso=
Normal,p.MsoNoSpacing{margin:0}</style></head><body><div>BB_FETCH_PREMIR=
RORONLY&nbsp; is not hard requirement here.&nbsp;<br></div><div>any usag=
e of PREMIRRORS causes failure on second fetch but it's hidden by fetchi=
ng from upstream iif available n most cases.<br></div><div><br></div><di=
v>--&nbsp;<br></div><div>Pavel</div><div><br></div><div>On Wed, Jan 31, =
2024, at 04:49, Chen Qi via lists.openembedded.org wrote:<br></div><bloc=
kquote type=3D"cite" id=3D"qt" style=3D""><div>On 1/27/24 20:15, Pavel Z=
hukov wrote:<br></div><div>&gt; Fix the issue with using of (pre)mirror =
in case if clonedir exists but<br></div><div>&gt; outdated.<br></div><di=
v><br></div><div>If I understand it right, the error only appears when&n=
bsp;<br></div><div>BB_FETCH_PREMIRRORONLY is set, right?<br></div><div><=
br></div><div>If so, could you please update the commit message to inclu=
de this&nbsp;<br></div><div>information?<br></div><div><br></div><div>Re=
gards,<br></div><div><br></div><div>Qi<br></div><div><br></div><div>&gt;=
 Previous version of the code fetched new mirror content into FETCH_HEAD=
<br></div><div>&gt; instead of branch which caused refetch from the upst=
ream. Add new remote<br></div><div>&gt; add fetch from it instead so the=
 ref can be found by "_contains_ref"<br></div><div>&gt;<br></div><div>&g=
t; Fixes [Yocto #15369]<br></div><div>&gt;<br></div><div>&gt; Signed-off=
-by: Pavel Zhukov &lt;<a href=3D"mailto:pavel@zhukoff.net">pavel@zhukoff=
.net</a>&gt;<br></div><div>&gt; ---<br></div><div>&gt;&nbsp;&nbsp; bitba=
ke/lib/bb/fetch2/git.py | 6 +++++-<br></div><div>&gt;&nbsp;&nbsp; 1 file=
 changed, 5 insertions(+), 1 deletion(-)<br></div><div>&gt;<br></div><di=
v>&gt; diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2=
/git.py<br></div><div>&gt; index 0deeb5cee1..b4497911f1 100644<br></div>=
<div>&gt; --- a/bitbake/lib/bb/fetch2/git.py<br></div><div>&gt; +++ b/bi=
tbake/lib/bb/fetch2/git.py<br></div><div>&gt; @@ -375,7 +375,11 @@ class=
 Git(FetchMethod):<br></div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else:<br></div><div>&g=
t;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmpdir =3D tempfile.mkdtemp(dir=3D=
d.getVar('DL_DIR'))<br></div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3Dtmpdir)<br></=
div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetch_cmd =3D "LANG=3DC %s fetch -f --=
progress %s " % (ud.basecmd, shlex.quote(tmpdir))<br></div><div>&gt; +&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; output =3D runfetchcmd("%s remote" % ud.basecmd, d, qui=
et=3DTrue, workdir=3Dud.clonedir)<br></div><div>&gt; +&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if 'mirror' in output:<br></div><div>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdi=
r=3Dud.clonedir)<br></div><div>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runfetchcmd("%s =
remote add --mirror=3Dfetch mirror %s" % (ud.basecmd, tmpdir), d, workdi=
r=3Dud.clonedir)<br></div><div>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetch_cmd =3D "L=
ANG=3DC %s fetch -f --update-head-ok&nbsp; --progress mirror " % (ud.bas=
ecmd)<br></div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runfetchcmd=
(fetch_cmd, d, workdir=3Dud.clonedir)<br></div><div>&gt;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; repourl =3D self._get_repo_=
url(ud)<br></div><div>&gt;&nbsp;&nbsp;&nbsp;<br></div><div>&gt;<br></div=
><div>&gt;&nbsp;<br></div><div>&gt;<br></div><div><br></div><div><br></d=
iv><div><br></div><div>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>=
</div><div>Links: You receive all messages sent to this group.<br></div>=
<div>View/Reply Online (#15813):&nbsp;<a href=3D"https://lists.openembed=
ded.org/g/bitbake-devel/message/15813">https://lists.openembedded.org/g/=
bitbake-devel/message/15813</a><br></div><div>Mute This Topic:&nbsp;<a h=
ref=3D"https://lists.openembedded.org/mt/103994536/6390638">https://list=
s.openembedded.org/mt/103994536/6390638</a><br></div><div>Group Owner:&n=
bsp;<a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org">bitb=
ake-devel+owner@lists.openembedded.org</a><br></div><div>Unsubscribe:&nb=
sp;<a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsub">http=
s://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto:=
pavel@zhukoff.net">pavel@zhukoff.net</a>]<br></div><div>-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br></div><div><br></div><div><br></div></b=
lockquote><div><br></div></body></html>
--91c02e43e1c646fb848363c6b148c342--

