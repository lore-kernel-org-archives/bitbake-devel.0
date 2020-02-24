Return-Path: <paul.barker@konsulko.com>
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
	[209.85.210.68])
	by mail.openembedded.org (Postfix) with ESMTP id 1D95B606F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 23:15:04 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id i6so10349264otr.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 15:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eSuqqGuL8+ZmVtg5vwcOjp6qe60uYyLwaG0FV//AWQ4=;
	b=iLeeCAGe/CJDdkCnLAygE7O1k0cm6RQnyAzmJTGQyLUYjCVowyNR3fcsvEr3RBG8pI
	FGsFYrsUelylp230qgPsTKqj5ecKeSZ1K/NX8PjtoZWSwMTdFNiANnxJFfjdvwCYN9Rg
	l/lxIomt/KC+GnCU7UaIgJ6x5anasH+iClUxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eSuqqGuL8+ZmVtg5vwcOjp6qe60uYyLwaG0FV//AWQ4=;
	b=NY6y61maFf/PFLF1kMulk9r/rIPmP5IFTJmdbz9m8+fP2301LYcO4A6XavuWhQ0I9z
	jTucUrEjh+fc2mooaYb/XMiYmW3Gue15cihnCUns3uTWqo7Ofa0ISZBlN1ryRzEtSzNs
	qGKJ6y5w+nwLE1ggPVObox608zwZRc3H5g0NMpF1gXSZ/qk/o8g8IhQuhwVIjwTFjNv/
	mslTNtO5X3LmaZIVMZXZFJgv6UG3jUY7IXvJHTuYoTiIPCjNQVN56ya46b/FpUk/SG4a
	bUQ0tKA465XpDpcUlrJN6DpCOZjbZ2JZZEynQiZ4H8+UMI9LYbJ6ADX4h663t5Mrx4L0
	l9fA==
X-Gm-Message-State: APjAAAW5eRs/6wSshKuUCdgBhoJZfuWTc6TMssJVj+wOHXGw+3noxtuM
	YTtkF6ejakSLeWH6SMEl6ABfeD8x50OSt4pg5LMdtg==
X-Google-Smtp-Source: APXvYqwjS/YmyqWdnJeIw9FiA3ex5NjO3aGFq9dlNNmdwq7OMG1PPua+06bGB8QXmJsEQydfHDi7MNyeJCfmM1mAnqU=
X-Received: by 2002:a05:6830:194:: with SMTP id
	q20mr43445293ota.92.1582586106045; 
	Mon, 24 Feb 2020 15:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20200224201629.13774-1-pbarker@konsulko.com>
	<ab447cea74fea333860e75d1b2619a7215855e67.camel@linuxfoundation.org>
	<CAM9ZRVv3opmXyKAFPFaaUV7D33uNmxWmn47bQR_Ek_Z0eXqKxw@mail.gmail.com>
	<d79eb8997dcf6635856e574d407c9c805e14326c.camel@linuxfoundation.org>
	<CAM9ZRVtRhBeAdYSeODrxkPOpen3y-7NsJ-jvM5JN+mTO1A+ymA@mail.gmail.com>
	<CABcZANms9EhTWSe=5WfnONjFjx2bTtVgYqx8YTc-MjJDYz7Q9Q@mail.gmail.com>
In-Reply-To: <CABcZANms9EhTWSe=5WfnONjFjx2bTtVgYqx8YTc-MjJDYz7Q9Q@mail.gmail.com>
From: Paul Barker <pbarker@konsulko.com>
Date: Mon, 24 Feb 2020 23:14:55 +0000
Message-ID: <CAM9ZRVs9ymWjxon2VcHQZQiE+wEkYA+jvX0TYzOR=626Q98RyA@mail.gmail.com>
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
X-List-Received-Date: Mon, 24 Feb 2020 23:15:05 -0000
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2020 at 23:06, Christopher Larson <kergoth@gmail.com> wrote:
>
> I don't think this is right. This unpacks the shallow tarball into ud.clonedir. The fetcher is specifically done the way it is to avoid ud.clonedir ever being shallow so as to avoid having to maintain that state and convert it when necessary.

Any suggestions on where we can unpack the shallow tarball then? We
need it to be unpacked somewhere so that we can examine the
.gitmodules file.

