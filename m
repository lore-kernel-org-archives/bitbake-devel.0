Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com
	[209.85.214.41])
	by mail.openembedded.org (Postfix) with ESMTP id 0B3DD77212
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 16:43:07 +0000 (UTC)
Received: by mail-it0-f41.google.com with SMTP id x130so17269497ite.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Aug 2016 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=UOc1lHCQvrxlHoMKP67+H+oUJoYxEH5BlXeTP58grrg=;
	b=V2leYSHLUoyUCO5N4E1qAu50fRFHfUB+8Gb/SIpKMdyQ6YTz3EAkWTvpCZGkQ4TzmV
	QYEtEuX2u5ZMSeuLSbgnaAbmwG0NP7t5yawgQEJHsDG8xjng7W+W6X8mKNY1q+8rF0Pq
	Y9GMdlWE/kRQs3NB+HxdBcge+2mby9uZm9UHFJl1M0nO6irxeVS+5I7d/XKlL8YoUmGZ
	lUF4QCrAq88ThfHPG5B19+nvl7ZtYWtSdHCHxfsnobqie3lsV328FHFv3u05I3dxn8oP
	ho0IYhwX46L7ucsblGDZh6G2E5opiiY7fFhMPbSTDVGZSdVfLZV1WAmut4EoiETXBShl
	1P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=UOc1lHCQvrxlHoMKP67+H+oUJoYxEH5BlXeTP58grrg=;
	b=Wo2fqx5bh9m67AwwxfEr6Xitma0DHcDL/4J4lu/nBTeV5MMemKtP/bKAgnfksxmEZ8
	BtKlrhNlkfPDpOid9gvYsjjhuZSb9s9X/IvU5hzDE1rf7xNC2ajkhfqQbNquQWhdJ3vV
	XLVYM/qhGLPbBSdwyra3vQcTLfaI17ub6YvRv/QQ8T3PSXDE+rUhgdXPtQSebwbUs7R8
	zCsVdPDirwPD9c47HPkXjp/m96mdWMAXfSaXOLd+B6IuWYwoBKEV1bDzkfAYM74QMluw
	X6wzsX8JYMLbah8JKS/0sZ7HJZi6oT4ft74XtixSP0q2EdAMrCujoeoeHY3/3cJEBZKs
	m3oQ==
X-Gm-Message-State: AEkooutpiPNdm8FelPiW78pZlXD5K090y1Ehp4RM8/GCWxtEs0zpdAGKM8Iaw3gcIRtX0Dr6XR+YFeFGFH7g9htx
X-Received: by 10.36.87.140 with SMTP id u134mr26643023ita.38.1470760976078;
	Tue, 09 Aug 2016 09:42:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.18.17 with HTTP; Tue, 9 Aug 2016 09:42:35 -0700 (PDT)
In-Reply-To: <CAJTo0LaGv91=ubi32qcQGx_CYp9gfLTTaQWU2Bpakmjfwnc6DQ@mail.gmail.com>
References: <dec52a2f-ef2f-f9c1-9ca2-e8b99cea7694@126.com>
	<CAJTo0LZNQNqiTLWHcegQUXfDAMp+4eahe1jmpJgsWWDhjxfPjw@mail.gmail.com>
	<b560cd81-616c-54a4-c69c-30d0fa6b03d8@126.com>
	<CAJTo0LaGv91=ubi32qcQGx_CYp9gfLTTaQWU2Bpakmjfwnc6DQ@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 9 Aug 2016 17:42:35 +0100
Message-ID: <CAJTo0LZN5Y99qUGt0mqybk78VWeo1mUL6WD8AfKbknx66KgxQg@mail.gmail.com>
To: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: howto rerun a task whenever it's content chang
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
X-List-Received-Date: Tue, 09 Aug 2016 16:43:08 -0000
Content-Type: multipart/alternative; boundary=001a1135018c8772d70539a6393d

--001a1135018c8772d70539a6393d
Content-Type: text/plain; charset=UTF-8

On 9 August 2016 at 17:40, Burton, Ross <ross.burton@intel.com> wrote:

> Ah, you're using bare bitbake.  You'll want to set BB_SIGNATURE_HANDLER in
> your bitbake.conf if you want magic autodetection, set it to "BasicHash"
> should do what you want.
>

Actually I've just been told "basichash". :)

Ross

--001a1135018c8772d70539a6393d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 9 August 2016 at 17:40, Burton, Ross <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:ross.burton@intel.com" target=3D"_blank">ross.burton@intel.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_extra"=
>Ah, you&#39;re using bare bitbake.=C2=A0 You&#39;ll want to set BB_SIGNATU=
RE_HANDLER in your bitbake.conf if you want magic autodetection, set it to =
&quot;BasicHash&quot; should do what you want.</div></blockquote><div><br><=
/div><div>Actually I&#39;ve just been told &quot;basichash&quot;. :)</div><=
div><br></div><div>Ross=C2=A0</div></div><br></div></div>

--001a1135018c8772d70539a6393d--
