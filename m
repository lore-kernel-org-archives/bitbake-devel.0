Return-Path: <raj.khem@gmail.com>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
	[209.85.223.173])
	by mail.openembedded.org (Postfix) with ESMTP id 2CBB56EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2014 18:13:13 +0000 (UTC)
Received: by mail-ie0-f173.google.com with SMTP id lx4so2280763iec.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2014 10:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=R+vYquDCgRwro+W09Q2TmrZzfhdC8HvhyQtmIEABLas=;
	b=Jjw88qZBb5QMsI9/TOOzZrTEasaVS7CvvDbj7LVBUZ/8jNUewBS5hSvA20mgBxApUD
	6W6w7YMeqrWltSkxcHpyWmLhBH5zSyLeGZewN8XhP4fvdsjhYEVxfYZZ8E64MW5MUW7Y
	lAdIvYmsrPCyKx5LT0PD9hi4E03OEm8LULh4clQtNvIaV0mFWa4+OfjR4wLiq103AriZ
	NCSmYf3YAURk0m66iY1HjK0n/PCV8sfKkb+Ae1yrI/U0dAteBZMZpob3W4DYVvpPP3nP
	fKRLd/IfCDlQmzc9jgjWNJaaPJdEkzGg5wuOartLnsuJK9Yq+5+hayN2spT++XQA/3fe
	40jg==
X-Received: by 10.50.143.69 with SMTP id sc5mr6419408igb.2.1393092794950; Sat,
	22 Feb 2014 10:13:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.50.224.137 with HTTP; Sat, 22 Feb 2014 10:12:44 -0800 (PST)
In-Reply-To: <1393087949-6183-1-git-send-email-jacob.kroon@mikrodidakt.se>
References: <1393087949-6183-1-git-send-email-jacob.kroon@mikrodidakt.se>
From: Khem Raj <raj.khem@gmail.com>
Date: Sat, 22 Feb 2014 10:12:44 -0800
Message-ID: <CAMKF1soqCA_6zQXN2bo7HSqKAqAfYE-eGEncp__1todBqHBg0A@mail.gmail.com>
To: Jacob Kroon <jacob.kroon@mikrodidakt.se>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] ast: Fix support for anonymous methods in wildcard .bbappend files
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
X-List-Received-Date: Sat, 22 Feb 2014 18:13:14 -0000
Content-Type: text/plain; charset=UTF-8

On Sat, Feb 22, 2014 at 8:52 AM, Jacob Kroon <jacob.kroon@mikrodidakt.se> wrote:
> +    tr_tbl = string.maketrans('/.+-@%', '______')
> +

why is this moved out

