Return-Path: <jpewhacker@gmail.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 0E2E26BF38
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Dec 2018 03:28:01 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id u3so2465508wrs.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Dec 2018 19:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=SAjt0vxMjdkmoK8IXs3b3GH9TfUriU0MdfdznStZhfE=;
	b=q3cskzv12sqzXC3UFUoEe8e8a0WWFcsl6lz1w04aQEWwcbrHHN3p5H+CQG0AjbBS29
	OCKNDgEV8y6B+kjIX8XOKRS+B0JwdIuezIN9koq5lKDvnT86ER2knDfKhSllueVqgyKb
	MuxjqLTki7CvU1xhceuPFBphEwy9wERbYnhIMtNL5NceSTkl0JWRNb0KpIsOmGW4d7Up
	OXgIDgZmTpCm5oyg34nX3hGNyvQTs4C9PuEec0VZFqz241lT91D+GSSCstlUJ5m4DWWo
	/FXc6p0Ppu5qRTbxVDvSwgXsua28fij14AQMSiSWsK8A+pd19tN1k2AtFz499nugLQI1
	jtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=SAjt0vxMjdkmoK8IXs3b3GH9TfUriU0MdfdznStZhfE=;
	b=hZjK1hK28nBi+/bjSX/eyQdGp5zw/Vxxf6Q+YvZehW8SyBGE9U1PO6a9GA1gXJtKUC
	LKrPlEM81Nwnfob8ionLby+V+MeUtzzKRXw/KFW+8QFCzQ8SQV/NM9QpPcyiS0GhJ9k8
	m69S6e9aRAZ0+V1EZ16sQJWKKIwH8hNzUXOzm+6ygkHdGh9U/gs2I07tX7mnRV5LcfkY
	7E4KtGZ52kZlprLM07JzlKo/L2++Jdpu5jPiEK1Cq08Bpa8xHmJmIpScaqPr7RyUUXXr
	UNPe2fuf+2Sa4OD0p3OryLEpWzBO5ZodlwC7XZteeVMaqU8BUIc7WlBxvEMZl18kejjH
	3rQg==
X-Gm-Message-State: AA+aEWYmSeJEJarL2WQgUAWF/0ZKk3NFqheFmT4unjyZ79vat+gh6PAK
	6jRi4y/IR8vyUK8BueqmBamhjyaFZA3gnfZwVLs=
X-Google-Smtp-Source: AFSGD/WoK4Fkpp0s4GXvE6wURT6tlamY/byBfODNcsBltE1xpNPi7XGqDCK8aSzRHENFmEPeg4c/RqHRDNI6tyKsCao=
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr383141wrx.248.1544153282504;
	Thu, 06 Dec 2018 19:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20181206185535.12523-1-JPEWhacker@gmail.com>
	<76873c27c0f7da4f8339b25f009150d7b38d1e72.camel@linuxfoundation.org>
In-Reply-To: <76873c27c0f7da4f8339b25f009150d7b38d1e72.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 6 Dec 2018 21:27:51 -0600
Message-ID: <CAJdd5GbfV4vm9eoCPYxme7s31vvoK-M_jbCPKfzkLWxNH=BT-w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Add a variable to pass flags to fakeroot (pseudo)
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
X-List-Received-Date: Fri, 07 Dec 2018 03:28:02 -0000
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 6, 2018 at 4:05 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2018-12-06 at 12:55 -0600, Joshua Watt wrote:
> > It is occasionally useful to pass additional flags to fakeroot
> > (pseudo)
> > either for debugging or for behavioral system changes. Add a variable
> > called "FAKEROOTARGS" that can be used for this purpose.
>
> Why wouldn't you just append to FAKEROOT/FAKEROOTCMD ?

You can't currently add arguments to FAKEROOTCMD because it is passed
as an array member to subprocess.Popen sort of like:

 subprocess.Popen([d.getVar('FAKEROOTCMD'), 'blah', 'blah', ...

In order to pass arguments, it would probably have to have split into
an array i.e. :

 subprocess.Popen(d.getVar('FAKEROOTCMD').split() + ['blah', 'blah', ...

I wasn't sure if that was desirable or if it would break anything, so
I went with the lower risk approach of adding a new variables. I can
certainly make a change to modify the usage of FAKEROOTCMD as
described above and simply append the flags to it if that is
preferred.

>
> Cheers,
>
> Richard
>

