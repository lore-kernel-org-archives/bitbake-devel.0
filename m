Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D40C00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 13:36:25 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by mx.groups.io with SMTP id smtpd.web09.5881.1660138582234325023
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 06:36:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=g538DH1+;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.25,
 mailfrom: pavel@zhukoff.net)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 618BE320010B
	for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 09:36:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute2.internal (MEProxy); Wed, 10 Aug 2022 09:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to; s=fm1; t=1660138580; x=1660224980; bh=pRxGeClo4+
	3q+C4x27bSP3KhWeKljRKJYReF/DvVLMA=; b=g538DH1+Yx7z9ulpGhc4RmFOFI
	acSemQZBtIEH0auvGKszmtoGxEYm78j2NDDtJryeUD8bT8jWGV9kqGZg6h8bEMn7
	9PSzv5/3sCLKmQVN94nY3p4IEMwHFzfh+hbtXA0k5ncuVixN0Kw49ztqY2MVaElv
	2VOW1ZTbbeO4xul0DhqOKMBPpIyU9PbiLcBVdH/4bN/2tGv+RUZzVaW+970cg8L1
	DITF5GJdc4wgajIqkcMLkx1A/6+zeN2XxG5Zv36/fXjOBmXqI+vGqbiBDalv6jlT
	3eyOn1bN3qzR9MK0t1B3FGOKcv4yTIBxKi6Ekdy8EhifG4ghceUe5SsQQkFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1660138580; x=1660224980; bh=pRxGeClo4+3q+C4x27bSP3KhWeKl
	jRKJYReF/DvVLMA=; b=pyWz9PjMiA2PAGI2NdCkM0uCwm7O0Ic1FUNIu8NunGMv
	3aijrZu0RSqwAlAecU7zejbH1hcLh0gfyyP5VAMcfJiYgEkPMq8jHJWQS7NNEDO9
	TjKcj7yENz/Y1ZGllpZ53O8Q7ycFMY+An3jYaryz/H0azI/EKIUhu68euK+BZroA
	dnsj7zil9Tfo5/4LkVWaC0lyrBD2C2AlQagEPfccs1b+jTLhLv6klUnfBviqGeLc
	7C/PFE0tk0ZEoNXxVfJGxUu+bjzTO0sMua1k6srRs3w1JRXqn15i4GypS0g3foZ/
	Pxy1R7QgA2nASVKpB4bvlC7P5eEmzF5PKrIBrHxmeg==
X-ME-Sender: <xms:VLTzYmOIJrbw-a4qTdBht5tIy55wYzmXcl8kIKBisuFs51kCBX-Kag>
    <xme:VLTzYk8gKwozVnM-WpUtAaQgSJtclu5tCXYxh3vZsMyot74pjTATCSUxI4TC2jXOC
    eF3OCjyJfOdAvcYSqc>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsegrtd
    erreerredtnecuhfhrohhmpedfrfgrvhgvlhcukghhuhhkohhvfdcuoehprghvvghlseii
    hhhukhhofhhfrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevhefhteekvdefvdeive
    ettdehkeffjeeujeeihfduheegffejledvgeehvdenucffohhmrghinhepohhpvghnvghm
    sggvugguvggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphgrvhgvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:VLTzYtQTmFXvhfqcgIdPW_l_2vLqaJTQQkR9X9Uz4Zd4RIqM8ZjUmw>
    <xmx:VLTzYmtV5HeXZpReWQG7Kds-tH5Odb6rNITp89dFaBLUrwSfQ7erzg>
    <xmx:VLTzYudE3vWXeFyLGLuacH7N6MIbjqSGW8PlGzoanY1RXcgQAZqnBw>
    <xmx:VLTzYop8TCkp9duBUSqyEeAWqhw3Gs9DsyNO-3h8Bhtr-fYD0RGt6A>
Feedback-ID: ib94946c9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9ED29B6007B; Wed, 10 Aug 2022 09:36:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-811-gb808317eab-fm-20220801.001-gb808317e
Mime-Version: 1.0
Message-Id: <d1c63bf2-5260-4559-91c1-32439f8767b9@www.fastmail.com>
In-Reply-To: <20220810084401.3885-1-tomasz.dziendzielski@gmail.com>
References: <20220810084401.3885-1-tomasz.dziendzielski@gmail.com>
Date: Wed, 10 Aug 2022 09:36:00 -0400
From: "Pavel Zhukov" <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Switch branch to correct hash
 in case
 of two premirrors
Content-Type: multipart/alternative;
 boundary=b1ead0dea55149fb9a0b9629e0096caa
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 13:36:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13879

--b1ead0dea55149fb9a0b9629e0096caa
Content-Type: text/plain

Some basic test would be useful here. 
There're few tests to cover premirror functionality in the testsuite so adding new one should be relatively easy. 

-- Pavel

On Wed, Aug 10, 2022, at 04:44, Tomasz Dziendzielski wrote:
> If we use two premirrors and tarball from the first one contains older
> commit then after fetching from tmpdir master ref still points to older
> commit, so _contains_ref can't find the proper revision on a branch.
> 
> Switch master ref to correct hash so _contains ref can find it. It needs
> to be done in for loop because we don't know which branch is used for
> specific repo in case of multiple repositories.
> 
> We need to use two try blocks because both commands might fail and it's
> not the reason to break the execution. There are two specific cases I
> want to cover. First is when we have multiple git:// entries in SRC_URI
> and one uses "master" and second "main". In this code we don't know
> which branch is assigned for which repository so we want to add both
> branches - so first we need to remove both branches and one might not
> exist. We could check if the branch exists and create it only then but
> this would break the second case. Now the second case is when for the
> first premirror we remove the branch but we can't create it later
> because the hash does not exist on the branch since tarball doesn't
> contain the newer commits - then for the second premirror the removal of
> the branch would fail.
> 
> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> Signed-off-by: Mateusz Marciniec <mateuszmar2@gmail.com>
> Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
> ---
> lib/bb/fetch2/git.py | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 4534bd758..ea47df3cf 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -362,6 +362,16 @@ class Git(FetchMethod):
>                  runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
>                  fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
>                  runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
> +                # Switch branch ref to a correct hash
> +                for name in ud.names:
> +                    try:
> +                        runfetchcmd("LANG=C %s branch -d %s" % (ud.basecmd, ud.parm.get('branch', ud.branches[name])), d, workdir=ud.clonedir)
> +                    except:
> +                        pass
> +                    try:
> +                        runfetchcmd("LANG=C %s branch %s %s" % (ud.basecmd, ud.parm.get('branch', ud.branches[name]), ud.revisions[name]), d, workdir=ud.clonedir)
> +                    except:
> +                        pass
>          repourl = self._get_repo_url(ud)
>  
>          # If the repo still doesn't exist, fallback to cloning it
> -- 
> 2.36.1
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13878): https://lists.openembedded.org/g/bitbake-devel/message/13878
> Mute This Topic: https://lists.openembedded.org/mt/92932619/6390638
> Group Owner: bitbake-devel+owner@lists.openembedded.org <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [pavel@zhukoff.net]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

--b1ead0dea55149fb9a0b9629e0096caa
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><title></title><style type=3D"text/css">p.Mso=
Normal,p.MsoNoSpacing{margin:0}</style></head><body><div>Some basic test=
 would be useful here.&nbsp;<br></div><div>There're few tests to cover p=
remirror functionality in the testsuite so adding new one should be rela=
tively easy.&nbsp;<br></div><div><br></div><div>-- Pavel</div><div><br><=
/div><div>On Wed, Aug 10, 2022, at 04:44, Tomasz Dziendzielski wrote:<br=
></div><blockquote type=3D"cite" id=3D"qt" style=3D""><div>If we use two=
 premirrors and tarball from the first one contains older<br></div><div>=
commit then after fetching from tmpdir master ref still points to older<=
br></div><div>commit, so _contains_ref can't find the proper revision on=
 a branch.<br></div><div><br></div><div>Switch master ref to correct has=
h so _contains ref can find it. It needs<br></div><div>to be done in for=
 loop because we don't know which branch is used for<br></div><div>speci=
fic repo in case of multiple repositories.<br></div><div><br></div><div>=
We need to use two try blocks because both commands might fail and it's<=
br></div><div>not the reason to break the execution. There are two speci=
fic cases I<br></div><div>want to cover. First is when we have multiple =
git:// entries in SRC_URI<br></div><div>and one uses "master" and second=
 "main". In this code we don't know<br></div><div>which branch is assign=
ed for which repository so we want to add both<br></div><div>branches - =
so first we need to remove both branches and one might not<br></div><div=
>exist. We could check if the branch exists and create it only then but<=
br></div><div>this would break the second case. Now the second case is w=
hen for the<br></div><div>first premirror we remove the branch but we ca=
n't create it later<br></div><div>because the hash does not exist on the=
 branch since tarball doesn't<br></div><div>contain the newer commits - =
then for the second premirror the removal of<br></div><div>the branch wo=
uld fail.<br></div><div><br></div><div>Signed-off-by: Tomasz Dziendziels=
ki &lt;<a href=3D"mailto:tomasz.dziendzielski@gmail.com">tomasz.dziendzi=
elski@gmail.com</a>&gt;<br></div><div>Signed-off-by: Mateusz Marciniec &=
lt;<a href=3D"mailto:mateuszmar2@gmail.com">mateuszmar2@gmail.com</a>&gt=
;<br></div><div>Signed-off-by: Jan Brzezanski &lt;<a href=3D"mailto:jan.=
brzezanski@gmail.com">jan.brzezanski@gmail.com</a>&gt;<br></div><div>---=
<br></div><div>lib/bb/fetch2/git.py | 10 ++++++++++<br></div><div>1 file=
 changed, 10 insertions(+)<br></div><div><br></div><div>diff --git a/lib=
/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br></div><div>index 4534bd758..=
ea47df3cf 100644<br></div><div>--- a/lib/bb/fetch2/git.py<br></div><div>=
+++ b/lib/bb/fetch2/git.py<br></div><div>@@ -362,6 +362,16 @@ class Git(=
FetchMethod):<br></div><div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runfetchcmd("tar -x=
zf %s" % ud.fullmirror, d, workdir=3Dtmpdir)<br></div><div>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s " % (ud.ba=
secmd, shlex.quote(tmpdir))<br></div><div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runfe=
tchcmd(fetch_cmd, d, workdir=3Dud.clonedir)<br></div><div>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; # Switch branch ref to a correct hash<br></div><div>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; for name in ud.names:<br></div><div>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; try:<br></div><div>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; runfetchcmd("LANG=3DC %s branch -d %s" % (u=
d.basecmd, ud.parm.get('branch', ud.branches[name])), d, workdir=3Dud.cl=
onedir)<br></div><div>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; except=
:<br></div><div>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; pass<br></div><div>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; try:<br></div><div>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; runfetchcmd("LANG=3DC %s branch %s %s" % (ud.basecmd, =
ud.parm.get('branch', ud.branches[name]), ud.revisions[name]), d, workdi=
r=3Dud.clonedir)<br></div><div>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; except:<br></div><div>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; pass<br></div><div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; repourl =3D self._get_repo_url(ud)<br></div><div>&nbsp;=
<br></div><div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # If the=
 repo still doesn't exist, fallback to cloning it<br></div><div>--&nbsp;=
<br></div><div>2.36.1<br></div><div><br></div><div><br></div><div><br></=
div><div>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br></div><div>Lin=
ks: You receive all messages sent to this group.<br></div><div>View/Repl=
y Online (#13878):&nbsp;<a href=3D"https://lists.openembedded.org/g/bitb=
ake-devel/message/13878">https://lists.openembedded.org/g/bitbake-devel/=
message/13878</a><br></div><div>Mute This Topic:&nbsp;<a href=3D"https:/=
/lists.openembedded.org/mt/92932619/6390638">https://lists.openembedded.=
org/mt/92932619/6390638</a><br></div><div>Group Owner:&nbsp;<a href=3D"m=
ailto:bitbake-devel%2Bowner@lists.openembedded.org">bitbake-devel+owner@=
lists.openembedded.org</a><br></div><div>Unsubscribe:&nbsp;<a href=3D"ht=
tps://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openem=
bedded.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto:pavel@zhukoff.ne=
t">pavel@zhukoff.net</a>]<br></div><div>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-<br></div><div><br></div><div><br></div></blockquote><div><=
br></div></body></html>
--b1ead0dea55149fb9a0b9629e0096caa--

