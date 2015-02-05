Return-Path: <ross.burton@intel.com>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
	[209.85.216.44])
	by mail.openembedded.org (Postfix) with ESMTP id D369460017
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Feb 2015 12:44:21 +0000 (UTC)
Received: by mail-qa0-f44.google.com with SMTP id w8so5585942qac.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Feb 2015 04:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=8d7MfRsEygRcdtU72tYuqBy8Me6PthA4a0JS8cYntEM=;
	b=lvQ6rOPcJdHT56jsANBzOh0IZptQ1ZEvY+wjmtzBzetSiUR7SF4In1tIry3j6DfgQp
	U/qESP8MfdWwefJoL7tj4pjd5KSbXdZI4s8Z5VmNWR52KJ7o/u8XcrfK4V+bIly2scO8
	aQnzyTpYZ7Nb9Te42AXD3HGUFHuaooxRQvGe4fxJcFUHsFLb72mmGxESRUk5lpUwMcJg
	OystgqoBi5tbkrsQ+JuSj60f2WO2y9vwKqA9b8PjYryp0kOqaFD2INjKMTmqHYJ6v9K0
	GxWocemBzkt6hpLuQ9J/vdMlvwLOccT5aJc6TE8eds6sNPPwc86FFF3PtCcrUCQ7y7N6
	fflw==
X-Gm-Message-State: ALoCoQnX2zhK3yJB8Ap0fmLqueofT9yRjtPnBNkPsXBSHWRQoq+xHUPdmkG1TCHOTLzQwzjUroCO
X-Received: by 10.140.39.179 with SMTP id v48mr7272512qgv.77.1423140262937;
	Thu, 05 Feb 2015 04:44:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.166 with HTTP; Thu, 5 Feb 2015 04:44:02 -0800 (PST)
In-Reply-To: <CAGpdKUKoy9MG_N6zLu54Lnh8TUmvogAQHvWPPrT_FAi6mO4sBg@mail.gmail.com>
References: <CAGpdKUKoy9MG_N6zLu54Lnh8TUmvogAQHvWPPrT_FAi6mO4sBg@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 5 Feb 2015 12:44:02 +0000
Message-ID: <CAJTo0LYdomcg-7pbYsZ_AWAvD2gQ2ti5EvDQdoXpPir0=FgTxw@mail.gmail.com>
To: Roman Savchenko <gmstima@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Specify files to package for subpackages
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
X-List-Received-Date: Thu, 05 Feb 2015 12:44:30 -0000
Content-Type: multipart/alternative; boundary=001a11c131f6d6adb5050e56a9a1

--001a11c131f6d6adb5050e56a9a1
Content-Type: text/plain; charset=UTF-8

On 5 February 2015 at 12:29, Roman Savchenko <gmstima@gmail.com> wrote:

> How can i specify files to package for subpackages in general way,
> something like:
> FILES_${PN}-*
>

Like that.  For example,  FILES_${PN}-dev.

Ross

--001a11c131f6d6adb5050e56a9a1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 5 February 2015 at 12:29, Roman Savchenko <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gmstima@gmail.com" target=3D"_blank">gmstima@gmail.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div>How can i specify files=
 to package for subpackages in general way, something like:<br>FILES_${PN}-=
*</div></blockquote><div><br></div><div>Like that.=C2=A0 For example, =C2=
=A0FILES_${PN}-dev.</div><div><br></div><div>Ross</div></div></div></div>

--001a11c131f6d6adb5050e56a9a1--
