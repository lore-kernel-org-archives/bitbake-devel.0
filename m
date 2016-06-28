Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 5654A6FFAB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jun 2016 10:23:51 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id s63so12491493ioi.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jun 2016 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=dcB8sy9R/6a7ti8RG4H60OQtJmYRhObIXS6DGQpL/Go=;
	b=0AprIOYqH3FP5GFE5yVQC1D7vebbQOuyEoq39Bzdw2ZimoL9TBoeYkQ7slMT4AW78n
	kvqc4ShiGHH33qE+VTE9WETi2fPgAtFAo49suLYw2izFaSBPLPHlGQeDCx60vuKTMzdQ
	9vWGcPO5FSJbtDSJx6bNYsdv99Sbab9aTIr25ZqISAS/MeP4rq+/qo/Oud2MNBuLxsrg
	LQ6Cv1CGHHMkBf6SdkvIue8khTRuAET48IxZJ6hHwC/PxSP7YPTLgJXJjlZpMqWrmrS8
	rQVBnoSKorjAVNcnFUDUPTuUVoaTa5KMLxbhXurf5AY428he/P1AdKSzyjG7W6CwZl6H
	JA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=dcB8sy9R/6a7ti8RG4H60OQtJmYRhObIXS6DGQpL/Go=;
	b=V8W5t19A068k+baXDMTRozbCwXEuLj3pZaZ4WmtMUBdIHkjG0wv63F5Y+pi0mUaSgI
	yXwLCCLyi+Zb6hP+6OHNL1tc2P3AhwH26a/1EfDxI+1ZO5moS8K5XGo+YfEf6DMxCh5N
	jdc5rGIui/BaiqiNa9kB3PnSqM5263AV6Wi2tzYKInF5zzTOzmej0HMeE/Y1VFGumWRc
	DwhQNCmQolUbISZRdjYxW541XCpoXLuAeoBNO9/Mphcw6DLJ7H3XZNKkUzp2rFzsuI3z
	XNiM5qZPbOHNObZOl073i2zRRhYtRUxlAnRLXKRti8nvAVBh4LYO8oSs7KA8/lWJx67y
	U7jg==
X-Gm-Message-State: ALyK8tLhxinOHPQe1zX3XqmWYH81XQyPtJMssGvuvShmAM2JoTLszBMFUxZK1BRIbD2gHPjfEmm9T0KXulFWEnE1
X-Received: by 10.107.154.210 with SMTP id c201mr2522270ioe.99.1467109432305; 
	Tue, 28 Jun 2016 03:23:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.142.151 with HTTP; Tue, 28 Jun 2016 03:23:32 -0700 (PDT)
In-Reply-To: <5e1ed9818cf97c1de778cc25a640d8bc589f4d55.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
	<5e1ed9818cf97c1de778cc25a640d8bc589f4d55.1465786269.git.paul.eggleton@linux.intel.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 28 Jun 2016 11:23:32 +0100
Message-ID: <CAJTo0Lbfx7mDE1f0Oa3EtAp+-HdYGXJ8AY0T4adDiMKi=fLzzw@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 05/10] fetch2: implement progress support
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
X-List-Received-Date: Tue, 28 Jun 2016 10:23:53 -0000
Content-Type: multipart/alternative; boundary=001a1140fab68f3e1a05365408ff

--001a1140fab68f3e1a05365408ff
Content-Type: text/plain; charset=UTF-8

On 13 June 2016 at 03:52, Paul Eggleton <paul.eggleton@linux.intel.com>
wrote:

> +        runfetchcmd(command + ' --progress=dot --show-progress', d,
> quiet, log=progresshandler)
>

wget: unrecognized option '--show-progress'

Turns out wget on Ubuntu 14.04 (wget 1.15) doesn't support this option.

Ross

--001a1140fab68f3e1a05365408ff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 13 June 2016 at 03:52, Paul Eggleton <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggleton@linux.i=
ntel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex"><div id=3D":8yl" class=
=3D"">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(command + &#39; --progress=
=3Ddot --show-progress&#39;, d, quiet, log=3Dprogresshandler)<br></div></bl=
ockquote></div><br>wget: unrecognized option &#39;--show-progress&#39;</div=
><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Turns out =
wget on Ubuntu 14.04 (wget 1.15) doesn&#39;t support this option.</div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</div></div=
>

--001a1140fab68f3e1a05365408ff--
