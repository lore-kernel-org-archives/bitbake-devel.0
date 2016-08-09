Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 32C0B7721C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 16:41:13 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id m101so16796727ioi.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Aug 2016 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=GtDC3sd0eC+RlJCVmOMtPsdai6u1CANXQYvQOlkTMnc=;
	b=pp41vT+eQgfA4+ZmsWW5ocnkJWkdtqw1Cdj6l+D++0lfmrTra2Jr/ioPyQG6CsOvu0
	FaFNd1zNLacarV+5GutUzmnKQAAcf13yp7IUcXcD6fGvUJzqwnotS78AXAmlPBErMVwy
	EsmUwoBk5SkclHV+PJt6QhVuSim9yF2JSNUw/HrDZ3Y4g190ua3n/ZqVPfKcZ9bOUgyp
	n+BAyvFHywGBQuVqERZFqDLnKhekzhH6xPAxjXWxc9LJIdQs3QrjpNmWbIGAhAtYsz39
	6bBhY84tjM9Ckj9j73DpsgpneUzh6iJvLo+aI4+S1kwO2Qvkigt/1KL3rSnfIqkEvTT4
	4VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=GtDC3sd0eC+RlJCVmOMtPsdai6u1CANXQYvQOlkTMnc=;
	b=KSCdja2Z9MaJkTg3YhSIic8gOPLKjruED9gveIBYXlYh+GQAlu1jtQC7C0wKzON7OK
	rILXvTE8Mzpc1tAAbqP176I/T4m6mTtYxfdtGPqZ9o6SfeQDlI7h9t3DsIqgARLI2KVw
	ckBhU0kuOZ9pifT9B9Un50TGxhvTEPBxyV8Z1lnDq5h1XayHMbbciFdJIQ1OUXNThWL3
	kQdsGFy+rQDBYCx8yipAaCjkVCfBvVsw1QraOjJNN2WAzNAcUeMMHkgc3KmTl6Ug7fkn
	hc3+mK22jItJD5szf7N+hEzfa1nleoouGuA444FLQkXjiNtkQpoTA3SVOWPalsBYx3Hp
	MOOw==
X-Gm-Message-State: AEkoousJrTolhN/MsIuOHohgoCZF/5VYHo7pQeP8v4gE27CB1q/yr9dLE32rXbnIoYUt0kjaQ3aIIFMq8cIZ/UDK
X-Received: by 10.107.138.212 with SMTP id c81mr97496185ioj.148.1470760874359; 
	Tue, 09 Aug 2016 09:41:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.18.17 with HTTP; Tue, 9 Aug 2016 09:40:54 -0700 (PDT)
In-Reply-To: <b560cd81-616c-54a4-c69c-30d0fa6b03d8@126.com>
References: <dec52a2f-ef2f-f9c1-9ca2-e8b99cea7694@126.com>
	<CAJTo0LZNQNqiTLWHcegQUXfDAMp+4eahe1jmpJgsWWDhjxfPjw@mail.gmail.com>
	<b560cd81-616c-54a4-c69c-30d0fa6b03d8@126.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 9 Aug 2016 17:40:54 +0100
Message-ID: <CAJTo0LaGv91=ubi32qcQGx_CYp9gfLTTaQWU2Bpakmjfwnc6DQ@mail.gmail.com>
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
X-List-Received-Date: Tue, 09 Aug 2016 16:41:14 -0000
Content-Type: multipart/alternative; boundary=001a113ed93277577d0539a63370

--001a113ed93277577d0539a63370
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9 August 2016 at 15:19, =E5=BC=A0=E5=BF=A0=E5=B1=B1 <zzs213@126.com> wro=
te:

> the attach is my test project, just according the bitbake manual's
> printhello example.
>
> my bitbake was cloned from 'git://git.openembedded.org/bitbake'
> and using revision id was: 309f5907a3661821e041ed14645b5d165007b058
>
> Run 'bitbake printhello' firstime the output is:
>

Ah, you're using bare bitbake.  You'll want to set BB_SIGNATURE_HANDLER in
your bitbake.conf if you want magic autodetection, set it to "BasicHash"
should do what you want.

Ross

--001a113ed93277577d0539a63370
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 9 August 2016 at 15:19, =E5=BC=A0=E5=BF=A0=E5=B1=B1 <span dir=3D"ltr">&l=
t;<a href=3D"mailto:zzs213@126.com" target=3D"_blank">zzs213@126.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1p2" class=3D=
"a3s aXjCH m1566fad65c4350d2">the attach is my test project, just according=
 the bitbake manual&#39;s printhello example.<br>
<br>
my bitbake was cloned from &#39;git://<a href=3D"http://git.openembedded.or=
g/bitbake" rel=3D"noreferrer" target=3D"_blank">git.openembedded.org/bi<wbr=
>tbake</a>&#39;<br>
and using revision id was: 309f5907a3661821e041ed14645b5d<wbr>165007b058<br=
>
<br>
Run &#39;bitbake printhello&#39; firstime the output is:</div></blockquote>=
</div><br>Ah, you&#39;re using bare bitbake.=C2=A0 You&#39;ll want to set B=
B_SIGNATURE_HANDLER in your bitbake.conf if you want magic autodetection, s=
et it to &quot;BasicHash&quot; should do what you want.</div><div class=3D"=
gmail_extra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a113ed93277577d0539a63370--
