Return-Path: <just4tech83@gmail.com>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
	[209.85.218.47])
	by mail.openembedded.org (Postfix) with ESMTP id 145A26FFF2;
	Tue,  5 Jan 2016 13:07:35 +0000 (UTC)
Received: by mail-oi0-f47.google.com with SMTP id l9so245735511oia.2;
	Tue, 05 Jan 2016 05:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=YH49h5OKpaHBeOexI2no2gnvj+NDgg6gXtVUzevunqU=;
	b=m6NVrZkDDQle6c1Qp+VaLL+P0+G+Grc2+GU0v4Y6jq+TDFD18U96c6+wsG6l3gahK8
	hvCx/E4aKeDgfu9/6ttAjfgL2Vfoef9nnOZAtXtVyXxFbk38IX4mpx9EpWbhPKdZDsPx
	FWroZW6LgSX16LtrB8eyymS5vrXAFfTxg+0X41niIhtcYuwkNsKa1ldKddlhKRNCaXXr
	05Gbi4auE8CWAPGog+FkH8XBi67YHex3Uv+RkvIbXq5Z2+GdYp3xCdnzd4uob55gZcQE
	zJax6PnVBu+3/mRFu2fObEajVctPGzXqEX4J6mXPJYlSKhJRYbry3EWqE9qhmCMXz/GC
	+Ejg==
MIME-Version: 1.0
X-Received: by 10.202.48.6 with SMTP id w6mr59662149oiw.97.1451999256340; Tue,
	05 Jan 2016 05:07:36 -0800 (PST)
Received: by 10.202.71.10 with HTTP; Tue, 5 Jan 2016 05:07:36 -0800 (PST)
Received: by 10.202.71.10 with HTTP; Tue, 5 Jan 2016 05:07:36 -0800 (PST)
In-Reply-To: <CAD2C2VTmyKj=T_F-DHrxNzW4d4gEDJ3=EaZFtQnF4m0in6C2Yg@mail.gmail.com>
References: <CAD2C2VSOXLTPM-yu6JFajf0LMHoE1t3utWG0vLFUzERcZs+7HA@mail.gmail.com>
	<CAD2C2VTmyKj=T_F-DHrxNzW4d4gEDJ3=EaZFtQnF4m0in6C2Yg@mail.gmail.com>
Date: Tue, 5 Jan 2016 18:37:36 +0530
Message-ID: <CAD2C2VRO2QwXk6i-SXJU6Rk7EoBaHgdEyLdAKR__9+CG=i57_Q@mail.gmail.com>
From: Bryan <just4tech83@gmail.com>
To: openembedded-core@lists.openembedded.org, 
	openembedded-issues@lists.openembedded.org
Cc: linux-yocto@yoctoproject.org, poky@yoctoproject.org,
	bitbake-devel@lists.openembedded.org,
	openembedded-devel@lists.openembedded.org
Subject: Re: korean/chinese keyboard layout support on yocto
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
X-List-Received-Date: Tue, 05 Jan 2016 13:07:36 -0000
Content-Type: multipart/alternative; boundary=001a113cd986e36e6a052895eb36

--001a113cd986e36e6a052895eb36
Content-Type: text/plain; charset=UTF-8

On Dec 24, 2015 1:40 PM, "Bryan" <just4tech83@gmail.com> wrote:

>
> On Dec 18, 2015 1:03 PM, "Bryan" <just4tech83@gmail.com> wrote:
> >
> > Hi,
> >     I am working on yocto poky-dizzy 1.7.1 and have developed some
> application on top of customized os image. I have a reqirement to support
> korean/chinese keyboard layout for application.
> > I have added cross complied libraries for  ibus-hangul pckages. Can
> somebody suggest me how can i add support for keyboart layout and how to
> enable automatically.
> >
> > Is there any bitbake recipe available to support these keyboard layout.
> >
> >
> > regards
> > Bryan
>

--001a113cd986e36e6a052895eb36
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Dec 24, 2015 1:40 PM, &quot;Bryan&quot; &lt;<=
a href=3D"mailto:just4tech83@gmail.com">just4tech83@gmail.com</a>&gt; wrote=
:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr"><br=
>
On Dec 18, 2015 1:03 PM, &quot;Bryan&quot; &lt;<a href=3D"mailto:just4tech8=
3@gmail.com" target=3D"_blank">just4tech83@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi, <br>
&gt; =C2=A0=C2=A0=C2=A0 I am working on yocto poky-dizzy 1.7.1 and have dev=
eloped some application on top of customized os image. I have a reqirement =
to support korean/chinese keyboard layout for application. <br>
&gt; I have added cross complied libraries for=C2=A0 ibus-hangul pckages. C=
an somebody suggest me how can i add support for keyboart layout and how to=
 enable automatically.<br>
&gt;<br>
&gt; Is there any bitbake recipe available to support these keyboard layout=
.<br>
&gt;<br>
&gt;<br>
&gt; regards<br>
&gt; Bryan</p>
</blockquote></div>

--001a113cd986e36e6a052895eb36--
