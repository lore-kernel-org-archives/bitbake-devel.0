Return-Path: <joel.esponde@gmail.com>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
	[209.85.213.170])
	by mail.openembedded.org (Postfix) with ESMTP id 954AF607A5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Nov 2015 23:21:24 +0000 (UTC)
Received: by igbdj2 with SMTP id dj2so23746307igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Nov 2015 15:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc:content-type;
	bh=1ue7lbjS4jRSdg8QG46scsfnQbYmxrvJZGQh9moPRWM=;
	b=Oje50OIqffz8e8MCbMSIL5hGcIHBx46Fh+B3iyOKHeBhAfoUeBBZwjD7/o2YDdmfex
	WNvymcTTC2LJmyu+HSmqPqew/NscjVrMFDEaEKRQyEr+UCh4kDIJu28Jfkfpt+qkPmKp
	PkVPuApgvOy7N4cpFaIZJv1ctFiQk+Ir3vTXBC2GF+viRYZty82yWjL3IDb3R/chK75t
	GCsSYLNtzIow2pV6HwzVdg4BFcR/tjd0xOIIq1wbMgQMdoxGTyDsIr6ii9PFWusQ+xUD
	MYU/6CjCenHHdU8VLhrUBhU3w7pngrot/pNYXTyFbZka3uPnx/tjYZFHpdK+y6sa3i9j
	BiIQ==
MIME-Version: 1.0
X-Received: by 10.50.43.197 with SMTP id y5mr5608918igl.45.1446592884372; Tue,
	03 Nov 2015 15:21:24 -0800 (PST)
Sender: joel.esponde@gmail.com
Received: by 10.107.201.88 with HTTP; Tue, 3 Nov 2015 15:21:23 -0800 (PST)
Received: by 10.107.201.88 with HTTP; Tue, 3 Nov 2015 15:21:23 -0800 (PST)
In-Reply-To: <56393A0F.5040407@linux.intel.com>
References: <1446588511-16158-1-git-send-email-joel.esponde@gmail.com>
	<56393A0F.5040407@linux.intel.com>
Date: Wed, 4 Nov 2015 00:21:23 +0100
X-Google-Sender-Auth: k1Bsux9W4xMNOJx6qK9sizDPbk4
Message-ID: <CAFTpMo4XbAXtuVAAhjVBceGORXDEw+3Cm9TUdsYEU2Ps9c9q_Q@mail.gmail.com>
From: =?UTF-8?Q?Jo=C3=ABl_Esponde?= <joel@esponde.net>
To: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Bitbake hob's image detail page should be able to display big logs with display resolution like 1600x900. Freescale yocto project is producing big logs for example.
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
X-List-Received-Date: Tue, 03 Nov 2015 23:21:25 -0000
Content-Type: multipart/alternative; boundary=089e0118260801fc360523ab2760

--089e0118260801fc360523ab2760
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le 3 nov. 2015 23:47, "Leonardo Sandoval" <
leonardo.sandoval.gonzalez@linux.intel.com> a =C3=A9crit :
>
>
>
> On 11/03/2015 04:08 PM, Jo=C3=ABl Esponde wrote:
>>
>> Moved log boxes into ScrolledWindows to keep them with a small size
while being able to display big logs.
>> Changed buttons alignment from y centered to top for them to be visible
directly on first show.
>
>
> you may need to truncate your one-line patch description (summary) in
order to be accepted. You can include this info on the detailed description
area.
>
>

OK thanks.
I will try to provide a v2 patch email tomorrow.

>>
>> Signed-off-by: Jo=C3=ABl Esponde <joel.esponde@gmail.com>
>> ---

--089e0118260801fc360523ab2760
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
Le=C2=A03 nov. 2015 23:47, &quot;Leonardo Sandoval&quot; &lt;<a href=3D"mai=
lto:leonardo.sandoval.gonzalez@linux.intel.com">leonardo.sandoval.gonzalez@=
linux.intel.com</a>&gt; a =C3=A9crit=C2=A0:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 11/03/2015 04:08 PM, Jo=C3=ABl Esponde wrote:<br>
&gt;&gt;<br>
&gt;&gt; Moved log boxes into ScrolledWindows to keep them with a small siz=
e while being able to display big logs.<br>
&gt;&gt; Changed buttons alignment from y centered to top for them to be vi=
sible directly on first show.<br>
&gt;<br>
&gt;<br>
&gt; you may need to truncate your one-line patch description (summary) in =
order to be accepted. You can include this info on the detailed description=
 area.<br>
&gt;<br>
&gt;</p>
<p dir=3D"ltr">OK thanks.<br>
I will try to provide a v2 patch email tomorrow.</p>
<p dir=3D"ltr">&gt;&gt;<br>
&gt;&gt; Signed-off-by: Jo=C3=ABl Esponde &lt;<a href=3D"mailto:joel.espond=
e@gmail.com">joel.esponde@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
</p>

--089e0118260801fc360523ab2760--
