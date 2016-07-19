Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com
	[209.85.214.54])
	by mail.openembedded.org (Postfix) with ESMTP id C188460589
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 16:45:23 +0000 (UTC)
Received: by mail-it0-f54.google.com with SMTP id j124so25564025ith.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=9/Xpj9h1YnfYC+nNWCiOMHjma0ksRrBmCLzCIny4ZrA=;
	b=VtPkmeItSFAlCQOpQdvwC4Ig4ii4kwWvoQiWSmiWpCb2ld1DKqeFfW6v9xJiZoT9aS
	5fLsL5Qjg3UZB5vY7grNDan6dg1g8fWShm4kClXTBBnE4S7CZyL5XROh6yT8Jx0sa2bA
	Q3zQCQ2lbcg+z4XyIK1hRAwld+DZ0uHUOiqDb9VG9BiR1PaszcczZZmuVa021draGDhk
	epYD3xdiIF70upF9I2sevEMxwiHFDIpAjCVPioP6HNK+IRcCj/8PPex3MqIziECWLWCB
	QYcaCozI/t4v/gHqS2dXKjLgPUrHsRpjqp+LCjCD6Z9b2otcEtqaPj9Bj6j+N3fPmUD+
	oFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=9/Xpj9h1YnfYC+nNWCiOMHjma0ksRrBmCLzCIny4ZrA=;
	b=kkvdEb80ifXOr/RtO4fA6iGtjM812fVE0Wh883tY32/LczfwV+noMZyLnMlM9mhirF
	loUXeoAsHrsBei4XIyY0MPg/+vQYkCDpnVcZrbyOeGb6rdVOKsQcUyYqCTdzKMI4kOwY
	kSfr6uCdcfb9dfsnQ2O4gMZwmca4c8S1WTc1CsPbWhRrCxsxWjG/cXfJHA8VfFh++Hjw
	KZ4eIayKmXGRVcDLBNZ/k8i1odg3o8+NF+7MvkYdCFmzg1/M7nUUN2LjQdwGAFwp3HOE
	k5Kf5ikv/sTlV9xNgknLDfNWhOZ5yuf3JFl/tVo1h1YIbp1gZe5QjtQge7clJETuCb0K
	2T6g==
X-Gm-Message-State: ALyK8tLyQI7BAOWX1nzZVWoVKecCuVamaoHhnZlQbbxPwyjKLnDaNxSbr8K/324RmOoeSbhDQTJSdh7WhqTlacsV
X-Received: by 10.36.19.75 with SMTP id 72mr4873028itz.83.1468946724200; Tue,
	19 Jul 2016 09:45:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.18.17 with HTTP; Tue, 19 Jul 2016 09:45:04 -0700 (PDT)
In-Reply-To: <578DF132.7020101@mlbassoc.com>
References: <578DC9D2.1060607@mlbassoc.com>
	<9795063.LvlJDZtIeJ@peggleto-mobl.ger.corp.intel.com>
	<578DF132.7020101@mlbassoc.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 19 Jul 2016 17:45:04 +0100
Message-ID: <CAJTo0LaXhGF3eFt=tfRBHfU56kf_nheBrV8Sshsxrpq+fGn7cA@mail.gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: New progress meters
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
X-List-Received-Date: Tue, 19 Jul 2016 16:45:24 -0000
Content-Type: multipart/alternative; boundary=001a1145180ab0c0120537ffcf52

--001a1145180ab0c0120537ffcf52
Content-Type: text/plain; charset=UTF-8

On 19 July 2016 at 10:21, Gary Thomas <gary@mlbassoc.com> wrote:

> Thanks.  I was mostly asking to see what the expected "user experience"
> should be since the webkitgtk (which takes FOREVER to build) seemed a
> bit misleading/optimistic.  For the most part, I do like the additional
> information.
>

The situation here is that cmake counts the steps and announces its
progress through them as the progress.  Of course the last step is to link
about 8GB of binaries...

A progress bar is better than no progress bar, so I still call this an
improvement :)

Ross

--001a1145180ab0c0120537ffcf52
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 19 July 2016 at 10:21, Gary Thomas <span dir=3D"ltr">&lt;<a href=3D"mail=
to:gary@mlbassoc.com" target=3D"_blank">gary@mlbassoc.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div id=3D":33j" class=3D"a3s aXjCH =
m1560276aed1bf905">Thanks.=C2=A0 I was mostly asking to see what the expect=
ed &quot;user experience&quot;<br>
should be since the webkitgtk (which takes FOREVER to build) seemed a<br>
bit misleading/optimistic.=C2=A0 For the most part, I do like the additiona=
l<br>
information.</div></blockquote></div><br>The situation here is that cmake c=
ounts the steps and announces its progress through them as the progress.=C2=
=A0 Of course the last step is to link about 8GB of binaries...=C2=A0</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">A progress =
bar is better than no progress bar, so I still call this an improvement :)<=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</=
div></div>

--001a1145180ab0c0120537ffcf52--
