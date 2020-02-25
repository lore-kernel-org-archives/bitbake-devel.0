Return-Path: <paul.barker@konsulko.com>
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by mail.openembedded.org (Postfix) with ESMTP id 5BE6B608BD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2020 10:34:00 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id g64so11581178otb.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2020 02:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1+TtYSJyc2Emy+UeMVUYUlq6cGUiQTbNT4vqqYB6YsQ=;
	b=UsyAppLAKPt3eDIE2EsCL0FiYHVf7ObiMTVM7Aa3EkxzsvG8bX/6yLlQQhvZeAEtv/
	junqLI7q23RUxZBfaWxekBbKacxhmUYAS5wpd3gQg4NRqRWWJ/QGHGOKAGXN85VaKBLt
	nF33Euch52JSlWmdEZ5DVgW8qJ8xKnFZQm96I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1+TtYSJyc2Emy+UeMVUYUlq6cGUiQTbNT4vqqYB6YsQ=;
	b=NSXKc8oIl0XXd5Z+iMhr6R0+LztpY/iqW4oSCs9W4hFdkMqR8526UVVuPHQbaCWGLp
	BsZ5W6X8uCVqr9jgeRXuFWxNUtLMn2WAELAZq3bCvba/z4U5Lu1Oq/v+CcTWb8xMf903
	8BaOO+pkwtPSjHhXURnhY2yEu1DU1C9QHQhnw88gjA3ZxWhnGjZAjl3u3wQQ2SShiH39
	fYFr6wlJt9B8i8iIgOs8SEePoaTlYrsggQra1FQTLHwr0tBHq223ZMmDR7LWgeBdsg/m
	0bcLtv0LwQymZEHD2FI/keyOBf5mp39h2jHAGqccYxe+DwU257UqoEwW22wnHhvpZOGh
	/7+w==
X-Gm-Message-State: APjAAAWM/hTHPIKB1kcGs0EnO5OFmkACDd8yXBb+RaKnv7r66iAsO1gF
	9YoxI566/GioDXjJZ6DEdvOoCkZ/CrSFiOm3UNnIpQ==
X-Google-Smtp-Source: APXvYqzUP1B6p9BWECy3L8a3sW/JqCj3Oi3EoTM3MhtH+EetLVeh5NXv8UmNC/2BIiC3Xp4rNAzfgaGBVi38d7RMA40=
X-Received: by 2002:a05:6830:194:: with SMTP id
	q20mr45345653ota.92.1582626841202; 
	Tue, 25 Feb 2020 02:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20200224201629.13774-1-pbarker@konsulko.com>
	<ab447cea74fea333860e75d1b2619a7215855e67.camel@linuxfoundation.org>
	<CAM9ZRVv3opmXyKAFPFaaUV7D33uNmxWmn47bQR_Ek_Z0eXqKxw@mail.gmail.com>
	<d79eb8997dcf6635856e574d407c9c805e14326c.camel@linuxfoundation.org>
	<CAM9ZRVtRhBeAdYSeODrxkPOpen3y-7NsJ-jvM5JN+mTO1A+ymA@mail.gmail.com>
	<CABcZANms9EhTWSe=5WfnONjFjx2bTtVgYqx8YTc-MjJDYz7Q9Q@mail.gmail.com>
	<CAM9ZRVs9ymWjxon2VcHQZQiE+wEkYA+jvX0TYzOR=626Q98RyA@mail.gmail.com>
In-Reply-To: <CAM9ZRVs9ymWjxon2VcHQZQiE+wEkYA+jvX0TYzOR=626Q98RyA@mail.gmail.com>
From: Paul Barker <pbarker@konsulko.com>
Date: Tue, 25 Feb 2020 10:33:49 +0000
Message-ID: <CAM9ZRVta1x+3SntEe8ex2LuOMQ45=+tzku68Ac5n_RS40jbPVg@mail.gmail.com>
To: Christopher Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/gitsm: Unpack shallow mirror tarballs
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
X-List-Received-Date: Tue, 25 Feb 2020 10:34:00 -0000
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2020 at 23:14, Paul Barker <pbarker@konsulko.com> wrote:
>
> On Mon, 24 Feb 2020 at 23:06, Christopher Larson <kergoth@gmail.com> wrote:
> >
> > I don't think this is right. This unpacks the shallow tarball into ud.clonedir. The fetcher is specifically done the way it is to avoid ud.clonedir ever being shallow so as to avoid having to maintain that state and convert it when necessary.
>
> Any suggestions on where we can unpack the shallow tarball then? We
> need it to be unpacked somewhere so that we can examine the
> .gitmodules file.

So my downloads directory blew up and I saw lots of fetch errors for
git SRC_URIs on builds overnight after testing this patch.

We could extract to a temporary directory as needed when downloading a
gitsm shallow mirror tarball and then throw this away once we've
checked .gitmodules. That would mean repeating the tarball extraction
if the download method is executed again but that should be fairly
rare. How does that sound?

The alternative would be to create a new 'gitsmshallow' directory
under DL_DIR for unpacking gitsm shallow mirror tarballs only. The
names of directories under 'gitsmshallow' would need to include the
commit hash given in the shallow tarball filename so that we don't
have clashes when DL_DIR is shared between builds which use different
SRCREVs of the same gitsm SRC_URI.

I also have a test case ready to go which I'll include in v2 of this
patch once we've decided where to extract the tarballs.

Thanks,
Paul

