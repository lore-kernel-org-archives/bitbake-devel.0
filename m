Return-Path: <kergoth@gmail.com>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by mail.openembedded.org (Postfix) with ESMTP id 8A3407F7A1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 16:21:35 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id o9so4982372plk.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 08:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:message-id:in-reply-to:references:subject:mime-version; 
	bh=a7Dw0M4WiuGutEBpOo8Q72lsZtq3CRWAwlaLIKMdmCA=;
	b=fGN53HBZOncejwlqz8VYLxXFcRU/y68Pz+/I4WIxYeoAamOs+L3apTYd9g7KMvZ1dy
	ZsT/TtQ1kG16I1PzzOz0CZROQdmwKN91YlaDQvHbSw7/esQYYSxq3rok8kmNoukSR9Vt
	oZi8aw6dJhV5FP/y3KM1ewPWfE4qU3f0iXGhZ0TfhWHgchBw+LmmdYQiU3i3vVRVOr5h
	jKdx8p97+pPdz+/+3Tg82ktbgI6qJ861BGW1uPEv/j3eWV9cP5CpGqPX7Y3wqch0yA6K
	O7j/LFDqfSQVF7tazl36sgfreO9ZRbAbtqatq8wNP6dJs5KdfVLFizBUV1N3XIY0z6MB
	iEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
	:subject:mime-version;
	bh=a7Dw0M4WiuGutEBpOo8Q72lsZtq3CRWAwlaLIKMdmCA=;
	b=KkNi1aD7G4xQC0WRAhYBPmtPejNoTWXpO01ExdnlOYmXoiePxGoyvP2RvAP5I+9Qg/
	iW1tnrxrKu9bs2H0wyvCZ/+WbnXDjqHFxjaah2fSZT6gRLPwsCw0OMXkspsxNFEPD/tm
	tFsiZa6FBR+PzVE3+mtf9NFRN1M2FCnlhgDKac75l5Skv2EQ1DicUyPfE6I9uddDn+D+
	cQP4D7jlyB7lLAnTFnLcVQJ1jS6gAHZSbKus1KWwHABoAqL5n0LptLFJ/TY2mpy/FgF6
	iWxdjjqIO9Hw2m37I5ri89xMYCOaT2SYRyImpVk0wBSKBxMtnxPBcmCiNBXLb1aNbCW1
	oi7g==
X-Gm-Message-State: APjAAAW+kRplkdq3EnLoI+wi0uDGA0bHuHViOcamiGmLMgoODLWfd8vl
	D5SmvLtm/RiJ9xbVGR5OIods3Cxq6Ow=
X-Google-Smtp-Source: APXvYqwhLrbF2Bm6cfIJy3AgFhf6NsDM9ngKxC+/6u5WNHGAE4J3j2e2JdRO0H9hmlujazS+c9DixA==
X-Received: by 2002:a17:902:8d98:: with SMTP id
	v24mr15813847plo.265.1573834896126; 
	Fri, 15 Nov 2019 08:21:36 -0800 (PST)
Received: from [192.168.1.17] (ip70-180-21-74.ph.ph.cox.net. [70.180.21.74])
	by smtp.gmail.com with ESMTPSA id
	d7sm12602792pfc.180.2019.11.15.08.21.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 15 Nov 2019 08:21:34 -0800 (PST)
Date: Fri, 15 Nov 2019 09:21:26 -0700
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org, Paul Barker
 <paul@betafive.co.uk>
Message-ID: <22367b6d-6c98-41fe-b795-4618af17cd6c@Spark>
In-Reply-To: <5d3e68e3-5c06-43f5-8a28-b19834b7b7c5@www.fastmail.com>
References: <5d3e68e3-5c06-43f5-8a28-b19834b7b7c5@www.fastmail.com>
X-Readdle-Message-ID: 22367b6d-6c98-41fe-b795-4618af17cd6c@Spark
MIME-Version: 1.0
Subject: Re: Warnings when starting bitbake with Python 3.8.0
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
X-List-Received-Date: Fri, 15 Nov 2019 16:21:35 -0000
Content-Type: multipart/alternative; boundary="5dced08d_74b0dc51_e0e5"

--5dced08d_74b0dc51_e0e5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

That=E2=80=99s definitely a bug, incorrect usage of =60is=60.
On Nov 15, 2019, 6:06 AM -0700, Paul Barker <paul=40betafive.co.uk>, wrot=
e:
> I'm using Arch on one of my dev machines and recent upgrades have broug=
ht in Python 3.8.0.
>
> When running bitbake (latest master, 33197db8abf82be240d7c1c5c9d2484a08=
a90849) I'm seeing the following warnings. This only happens on the first=
 invocation as =5F=5Fpycache=5F=5F is used after this.
>
> /.../bitbake/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: =22is=22 wi=
th a literal. Did you mean =22=3D=3D=22=3F
> if command is 'mkview':
> /.../bitbake/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: =22is=22 wi=
th a literal. Did you mean =22=3D=3D=22=3F
> elif command is 'rmview':
> /.../bitbake/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: =22is=22 wi=
th a literal. Did you mean =22=3D=3D=22=3F
> elif command is 'setcs':
>
> I've never used the clearcase fetcher and have no way of testing this m=
yself so I don't want to dive into it. May be worth someone who is using =
this taking a look at it though.
>
> Thanks,
>
> --
> Paul Barker
> --
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> bitbake-devel mailing list
> bitbake-devel=40lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--5dced08d_74b0dc51_e0e5
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>That=E2=80=99s definitely a bug, incorrect usage of=
 =60is=60.</div>
</div>
<div name=3D=22messageReplySection=22>On Nov 15, 2019, 6:06 AM -0700, Pau=
l Barker &lt;paul=40betafive.co.uk&gt;, wrote:<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =231abc9c;=22>I'=
m using Arch on one of my dev machines and recent upgrades have brought i=
n Python 3.8.0.<br />
<br />
When running bitbake (latest master, 33197db8abf82be240d7c1c5c9d2484a08a9=
0849) I'm seeing the following warnings. This only happens on the first i=
nvocation as =5F=5Fpycache=5F=5F is used after this.<br />
<br />
/.../bitbake/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: =22is=22 with=
 a literal. Did you mean =22=3D=3D=22=3F<br />
if command is 'mkview':<br />
/.../bitbake/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: =22is=22 with=
 a literal. Did you mean =22=3D=3D=22=3F<br />
elif command is 'rmview':<br />
/.../bitbake/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: =22is=22 with=
 a literal. Did you mean =22=3D=3D=22=3F<br />
elif command is 'setcs':<br />
<br />
I've never used the clearcase fetcher and have no way of testing this mys=
elf so I don't want to dive into it. May be worth someone who is using th=
is taking a look at it though.<br />
<br />
Thanks,<br />
<br />
--<br />
Paul Barker<br />
--<br />
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br />
bitbake-devel mailing list<br />
bitbake-devel=40lists.openembedded.org<br />
http://lists.openembedded.org/mailman/listinfo/bitbake-devel<br /></block=
quote>
</div>
</body>
</html>

--5dced08d_74b0dc51_e0e5--
