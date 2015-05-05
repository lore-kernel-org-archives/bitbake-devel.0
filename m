Return-Path: <ross.burton@intel.com>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
	[209.85.216.172])
	by mail.openembedded.org (Postfix) with ESMTP id EC5336AC3E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 May 2015 10:42:07 +0000 (UTC)
Received: by qcyk17 with SMTP id k17so85464598qcy.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 May 2015 03:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=IXpKf4V4vpUt1hRrMgdsUH//4RC7zAdysKKLfH3kNHM=;
	b=TQLRQVfEV301nIBNTKCguIYlDjhzU3nYVtZla9JtZ5BAWUSb8iYiP/pbSymkFyhtLJ
	tno6Fi1y1f/AkwJueA/pPSRrPrurSfBVtN3m0/pDJ03JVB3dswcf5MC+YWp5wLlE6XRm
	+4B8S+5Q5O58cvvQsZYg4rYyTYJ+MpW0aDCzb4mNT6U1oNMQYake7qfsJCp1JYqQtQbQ
	ATi6osyKT39RHJ4Tsjh5moKOrgQ4HyOjIew0uKxYcs8rm1vN2m+lO/MC4rxxnJ19I377
	oeQFrOdILixqsKi2zLA4vC7jkHAUkuSZNg7IfuFg+vm+s8ijX5udPRpwu7fqdMoHRiYc
	x2Sg==
X-Gm-Message-State: ALoCoQkHgSqc2lAFZYuHNOuvvSga497tA1O9NuRRzixKBXzLtpl9u6tGCcRPDoglgCxo7kDf5iIf
X-Received: by 10.229.110.10 with SMTP id l10mr13352787qcp.5.1430822528852;
	Tue, 05 May 2015 03:42:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Tue, 5 May 2015 03:41:48 -0700 (PDT)
In-Reply-To: <ecc3772510e36b5f9a21cdb194fb5c78@riseup.net>
References: <ecc3772510e36b5f9a21cdb194fb5c78@riseup.net>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 5 May 2015 11:41:48 +0100
Message-ID: <CAJTo0LZf9g5V_jfOygHmRW4O6vDYXxphMvAmQjd5uVnRwaKfNQ@mail.gmail.com>
To: skaluzka <skaluzka@riseup.net>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: cannot install bitbake inside virtualenv
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
X-List-Received-Date: Tue, 05 May 2015 10:42:08 -0000
Content-Type: multipart/alternative; boundary=001a11344c8491b7dd051553547e

--001a11344c8491b7dd051553547e
Content-Type: text/plain; charset=UTF-8

On 1 May 2015 at 20:48, skaluzka <skaluzka@riseup.net> wrote:

> I am trying to install bitbake inside virtualenv, but I am not able
>

I'll stop you there - it's not recommended to "install" bitbake so the
setup.py is probably broken.  Don't use it, just use the source tree
directly.

Ross

--001a11344c8491b7dd051553547e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 1 May 2015 at 20:48, skaluzka <span dir=3D"ltr">&lt;<a href=3D"mailto:sk=
aluzka@riseup.net" target=3D"_blank">skaluzka@riseup.net</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div id=3D":943" class=3D"a3s" style=
=3D"overflow:hidden">I am trying to install bitbake inside virtualenv, but =
I am not able<br></div></blockquote></div><br>I&#39;ll stop you there - it&=
#39;s not recommended to &quot;install&quot; bitbake so the setup.py is pro=
bably broken.=C2=A0 Don&#39;t use it, just use the source tree directly.</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</di=
v></div>

--001a11344c8491b7dd051553547e--
