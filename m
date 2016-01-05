Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
	[209.85.223.180])
	by mail.openembedded.org (Postfix) with ESMTP id 319A26FFF7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Jan 2016 15:21:31 +0000 (UTC)
Received: by mail-io0-f180.google.com with SMTP id 1so142822616ion.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 Jan 2016 07:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=1du+CIbfjmAvK1JypUoZ2z43ufqX8sNvjQ9+p0C3T4k=;
	b=aNdLDLLxZLpp6puN7zR6ysL8JX2y3Cw3uYQnrrqsJZJDx4nUPv4oL+/2aknzZK4TBX
	4OLRzxY+UWOrVi6F4+ugKZ0PDqCJ8w0Y5Z0PkIZtG0IaHLHhOpnYoW4NvKNMc8OFgbOn
	zykLS4JqnHWb0f/EDL6h/ViGPGvH9gmc3vkECS2R5RKrL7E5r4bu9n8B0d5D7vQVYQN9
	ljF9wAEI55MEpAWCjhSxKoAkO+QekDxFmnrpbk4NMR9bq0a2PW5rhYsgZpHFG1Gbrt3W
	c0dUa/7qWq5UVvuI7xCSLuvYh6DriGax1ctYsPpC2Rde4eoWW55qle6ikuZeJGeYuxxG
	5w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=1du+CIbfjmAvK1JypUoZ2z43ufqX8sNvjQ9+p0C3T4k=;
	b=XIHYBdXW+6n8S4Ti2Xbtb18TwHYjlnSos2qxG0Iw7KQGRj8WfhnVW82rOiqho1uLye
	V72ifLZ1YBoZlC6wKISdUSnFVE+XGTv1rydoITsnO612lDkhziWVckkKo/L96QjlQ/+n
	I9lq2ta80ewDvH8997AD42O8lxJklKp9yX5r0KWnU7Wkz0QqoSKXP6vU7dlTeL5CGakl
	6dAHz9bez17yhBaaEUPlsBFvUkOis+w8kPSn9gJk6f07ubg2uuKr34fdhTWjLymHaqKn
	c/j7l4/rkliNv75PERB7S0uDkxjimmy62AQ7q1inzqjw42iFFj72HKTtP+vFYvypTGdV
	csIQ==
X-Gm-Message-State: ALoCoQkRI6HRnNdfpm4NFaSgNl+82uZfaEc3/ql3ozDH6dyyacmTORncvuDZiio4atBq66kKTwnhJunU95lkPlJW7aQc4zDMy5mNij7x6oIdeqriMP39IMk=
X-Received: by 10.107.164.161 with SMTP id d33mr77818342ioj.148.1452007292482; 
	Tue, 05 Jan 2016 07:21:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.162.70 with HTTP; Tue, 5 Jan 2016 07:21:13 -0800 (PST)
In-Reply-To: <1451983692-14842-2-git-send-email-ed.bartosh@linux.intel.com>
References: <1451983692-14842-1-git-send-email-ed.bartosh@linux.intel.com>
	<1451983692-14842-2-git-send-email-ed.bartosh@linux.intel.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 5 Jan 2016 15:21:13 +0000
Message-ID: <CAJTo0LaxgVGcwkTL-3mzHeCtU+s42oMVwtm7Sbcb1YqErx2p=w@mail.gmail.com>
To: Ed Bartosh <ed.bartosh@linux.intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] bitbake: xmplrpc: split connect method
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
X-List-Received-Date: Tue, 05 Jan 2016 15:21:32 -0000
Content-Type: multipart/alternative; boundary=001a1141c976e14c83052897cac4

--001a1141c976e14c83052897cac4
Content-Type: text/plain; charset=UTF-8

On 5 January 2016 at 08:48, Ed Bartosh <ed.bartosh@linux.intel.com> wrote:

> Moved functionality of setting up event queue in from 'connect'
> method to 'setupEventQueue' in BitBakeXMLRPCServerConnection class.
>

Bitbake fails for me now:

Traceback (most recent call last):
 File "/home/ross/Yocto/poky/bitbake/bin/bitbake", line 45, in <module>
   cookerdata.CookerConfiguration()))
 File "/home/ross/Yocto/poky/bitbake/lib/bb/main.py", line 414, in
bitbake_main
   server_connection.setupEventQueue()
AttributeError: BitBakeProcessServerConnection instance has no attribute
'setupEventQueue'

Ross

--001a1141c976e14c83052897cac4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 5 January 2016 at 08:48, Ed Bartosh <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:ed.bartosh@linux.intel.com" target=3D"_blank">ed.bartosh@linux.intel.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex"><div id=3D":1fy" class=3D"" sty=
le=3D"overflow:hidden">Moved functionality of setting up event queue in fro=
m &#39;connect&#39;<br>
method to &#39;setupEventQueue&#39; in BitBakeXMLRPCServerConnection class.=
<br></div></blockquote></div><br>Bitbake fails for me now:</div><br>Traceba=
ck (most recent call last):<br>=C2=A0File &quot;/home/ross/Yocto/poky/bitba=
ke/bin/bitbake&quot;, line 45, in &lt;module&gt;<br>=C2=A0 =C2=A0cookerdata=
.CookerConfiguration()))<br>=C2=A0File &quot;/home/ross/Yocto/poky/bitbake/=
lib/bb/main.py&quot;, line 414, in bitbake_main<br>=C2=A0 =C2=A0server_conn=
ection.setupEventQueue()<br>AttributeError: BitBakeProcessServerConnection =
instance has no attribute &#39;setupEventQueue&#39;<div><br></div><div>Ross=
</div></div>

--001a1141c976e14c83052897cac4--
